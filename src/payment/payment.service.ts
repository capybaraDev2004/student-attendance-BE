import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { PayOSService } from './payos.service';
import { VipPackageType } from '@prisma/client';
import * as QRCode from 'qrcode';

@Injectable()
export class PaymentService {
  private readonly logger = new Logger(PaymentService.name);

  // Giá các gói VIP (VND)
  private readonly VIP_PRICES: Record<VipPackageType, number> = {
    one_day: 1000,
    one_week: 1000,
    one_month: 1000,
    one_year: 1000,
    lifetime: 1000,
  };

  constructor(
    private readonly prisma: PrismaService,
    private readonly payOSService: PayOSService,
  ) {}

  async createPayment(userId: number, vipPackageType: VipPackageType) {
    const amount = this.VIP_PRICES[vipPackageType];
    if (!amount) {
      throw new Error(`Invalid VIP package type: ${vipPackageType}`);
    }

    // Tạo order code unique (timestamp + random)
    const orderCode = Date.now() + Math.floor(Math.random() * 1000);

    // Tạo payment record trong DB
    const payment = await this.prisma.payments.create({
      data: {
        user_id: userId,
        order_code: orderCode,
        amount,
        vip_package_type: vipPackageType,
        status: 'pending',
        description: `Thanh toán gói VIP ${vipPackageType}`,
      },
    });

    // Tạo payment link với PayOS
    const payOS = this.payOSService.getPayOS();
    const frontendUrl = process.env.FRONTEND_URL || 'http://localhost:3000';

    const paymentLink = await payOS.paymentRequests.create({
      orderCode: Number(orderCode),
      amount,
      description: `Thanh toán gói VIP ${vipPackageType}`,
      returnUrl: `${frontendUrl}/payment/success`,
      cancelUrl: `${frontendUrl}/payment/cancel`,
    });

    // Log để debug
    this.logger.log(`PayOS response - checkoutUrl: ${paymentLink.checkoutUrl ? 'OK' : 'NULL'}`);
    this.logger.log(`PayOS response - qrCode type: ${typeof paymentLink.qrCode}`);
    this.logger.log(`PayOS response - qrCode length: ${paymentLink.qrCode ? paymentLink.qrCode.length : 'NULL'}`);
    this.logger.log(`PayOS response - qrCode preview: ${paymentLink.qrCode ? paymentLink.qrCode.substring(0, 100) + '...' : 'NULL'}`);

    // PayOS có thể trả về:
    // 1. BASE64 PNG image (bắt đầu bằng iVBORw0KGgo...)
    // 2. VietQR data string (bắt đầu bằng 000201...)
    let qrCodeBase64: string;
    
    if (paymentLink.qrCode) {
      // Kiểm tra xem có phải BASE64 PNG không
      if (paymentLink.qrCode.startsWith('iVBORw0KGgo') || paymentLink.qrCode.startsWith('/9j/')) {
        // Đã là BASE64 image
        qrCodeBase64 = paymentLink.qrCode;
        this.logger.log('PayOS returned BASE64 PNG image');
      } else {
        // Là VietQR data string, cần generate QR code image
        this.logger.log('PayOS returned VietQR data string, generating QR code image...');
        try {
          // Generate QR code từ VietQR string thành BASE64 PNG
          qrCodeBase64 = await QRCode.toDataURL(paymentLink.qrCode, {
            type: 'image/png',
            width: 300,
            margin: 2,
          });
          // Remove data:image/png;base64, prefix
          qrCodeBase64 = qrCodeBase64.replace('data:image/png;base64,', '');
          this.logger.log('Successfully generated QR code image from VietQR string');
        } catch (error) {
          this.logger.error('Failed to generate QR code from VietQR string:', error);
          throw new Error('Không thể tạo QR code từ dữ liệu PayOS');
        }
      }
    } else {
      throw new Error('PayOS không trả về QR code');
    }

    // Cập nhật payment với checkout_url và qr_code
    const updatedPayment = await this.prisma.payments.update({
      where: { payment_id: payment.payment_id },
      data: {
        checkout_url: paymentLink.checkoutUrl,
        qr_code: qrCodeBase64, // BASE64 PNG (không có prefix)
      },
    });

    this.logger.log(`Created payment ${payment.payment_id} for user ${userId}, orderCode: ${orderCode}`);

    return {
      paymentId: updatedPayment.payment_id,
      orderCode: updatedPayment.order_code.toString(),
      amount: updatedPayment.amount,
      vipPackageType: updatedPayment.vip_package_type,
      checkoutUrl: updatedPayment.checkout_url,
      qrCode: updatedPayment.qr_code, // BASE64 PNG từ PayOS (không có prefix)
    };
  }

  async handleWebhook(data: any) {
    const payOS = this.payOSService.getPayOS();
    
    // Verify webhook data - PayOS webhooks.verify() sẽ throw error nếu invalid
    try {
      await payOS.webhooks.verify(data);
    } catch (error) {
      this.logger.error('Invalid webhook data', error);
      return { success: false, message: 'Invalid webhook data' };
    }

    // PayOS webhook data structure: { code, desc, success, data: { orderCode, status, amount, ... } }
    const orderCode = data.data?.orderCode;
    const status = data.data?.status || data.data?.code; // PayOS có thể dùng 'code' hoặc 'status'
    const amount = data.data?.amount;

    if (!orderCode) {
      this.logger.error('Webhook missing orderCode', data);
      return { success: false, message: 'Missing orderCode' };
    }

    this.logger.log(`Received webhook for orderCode: ${orderCode}, status: ${status}, amount: ${amount}`);

    // Tìm payment theo order_code (KHÔNG CẦN BIẾT USER LÀ AI)
    const payment = await this.prisma.payments.findUnique({
      where: { order_code: BigInt(orderCode) },
      include: { user: true },
    });

    if (!payment) {
      this.logger.error(`Payment not found for orderCode: ${orderCode}`);
      return { success: false, message: 'Payment not found' };
    }

    this.logger.log(
      `Found payment ${payment.payment_id} for user ${payment.user_id}, current status: ${payment.status}`,
    );

    // Xử lý trạng thái PAID
    if (status === 'PAID' || status === '00' || data.code === '00') {
      // ✅ IDEMPOTENT CHECK - Nếu đã paid thì không xử lý lại (chống webhook trùng)
      if (payment.status === 'paid') {
        this.logger.log(`Payment ${payment.payment_id} already processed (idempotent)`);
        return { success: true, message: 'Already processed' };
      }

      // Kiểm tra amount có khớp không (chống fake)
      if (amount && amount !== payment.amount) {
        this.logger.warn(
          `Amount mismatch for payment ${payment.payment_id}: expected ${payment.amount}, got ${amount}`,
        );
        // Vẫn xử lý nhưng log warning
      }

      // Cập nhật payment status sang 'paid'
      await this.prisma.payments.update({
        where: { payment_id: payment.payment_id },
        data: {
          status: 'paid',
          paid_at: new Date(),
          updated_at: new Date(), // Đảm bảo updated_at được cập nhật
        },
      });

      this.logger.log(`Payment ${payment.payment_id} status updated to 'paid'`);

      // Tính ngày hết hạn VIP theo gói đã mua
      const expiresAt = this.calculateVipExpiresAt(
        payment.vip_package_type,
        payment.user.vip_expires_at,
      );

      // Cập nhật trạng thái VIP cho user
      await this.prisma.users.update({
        where: { user_id: payment.user_id },
        data: {
          vip_package_type: payment.vip_package_type,
          vip_expires_at: expiresAt,
          account_status: 'vip', // Cập nhật trạng thái sang VIP
        },
      });

      this.logger.log(
        `✅ Payment ${payment.payment_id} confirmed. User ${payment.user_id} upgraded to VIP ${payment.vip_package_type}, expires at: ${expiresAt}`,
      );

      return { success: true, message: 'Payment processed successfully' };
    }

    // Xử lý trạng thái CANCELLED
    if (status === 'CANCELLED' || status === 'CANCEL' || status === 'cancel') {
      // ✅ IDEMPOTENT CHECK
      if (payment.status === 'cancelled' || payment.status === 'cancel') {
        this.logger.log(`Payment ${payment.payment_id} already cancelled`);
        return { success: true, message: 'Already cancelled' };
      }

      await this.prisma.payments.update({
        where: { payment_id: payment.payment_id },
        data: {
          status: 'cancelled',
          updated_at: new Date(),
        },
      });

      this.logger.log(`Payment ${payment.payment_id} cancelled`);
      return { success: true, message: 'Payment cancelled' };
    }

    // Trạng thái khác (pending, expired, ...)
    this.logger.warn(`Unhandled payment status: ${status} for orderCode: ${orderCode}`);
    return { success: false, message: `Unhandled status: ${status}` };
  }

  /**
   * Tính ngày hết hạn VIP theo gói đã mua
   * - Nếu user đã có VIP và chưa hết hạn: cộng thêm vào ngày hết hạn hiện tại
   * - Nếu user chưa có VIP hoặc đã hết hạn: tính từ thời điểm hiện tại
   */
  private calculateVipExpiresAt(
    packageType: VipPackageType,
    currentExpiresAt: Date | null,
  ): Date | null {
    const now = new Date();
    let expiresAt: Date;

    // Nếu đã có VIP và chưa hết hạn, cộng thêm vào ngày hết hạn
    // Nếu không có hoặc đã hết hạn, tính từ bây giờ
    const baseDate = currentExpiresAt && currentExpiresAt > now ? currentExpiresAt : now;

    switch (packageType) {
      case 'lifetime':
        // Set 100 năm sau (coi như vĩnh viễn)
        expiresAt = new Date(baseDate);
        expiresAt.setFullYear(expiresAt.getFullYear() + 100);
        this.logger.log(`VIP package: lifetime, baseDate: ${baseDate.toISOString()}, expires at: ${expiresAt.toISOString()}`);
        break;
      case 'one_day':
        expiresAt = new Date(baseDate);
        expiresAt.setDate(expiresAt.getDate() + 1);
        this.logger.log(`VIP package: one_day, baseDate: ${baseDate.toISOString()}, expires at: ${expiresAt.toISOString()}`);
        break;
      case 'one_week':
        expiresAt = new Date(baseDate);
        expiresAt.setDate(expiresAt.getDate() + 7);
        this.logger.log(`VIP package: one_week, baseDate: ${baseDate.toISOString()}, expires at: ${expiresAt.toISOString()}`);
        break;
      case 'one_month':
        expiresAt = new Date(baseDate);
        expiresAt.setMonth(expiresAt.getMonth() + 1);
        this.logger.log(`VIP package: one_month, baseDate: ${baseDate.toISOString()}, expires at: ${expiresAt.toISOString()}`);
        break;
      case 'one_year':
        expiresAt = new Date(baseDate);
        expiresAt.setFullYear(expiresAt.getFullYear() + 1);
        this.logger.log(`VIP package: one_year, baseDate: ${baseDate.toISOString()}, expires at: ${expiresAt.toISOString()}`);
        break;
      default:
        this.logger.error(`Invalid VIP package type: ${packageType}`);
        return null;
    }

    return expiresAt;
  }

  async getPaymentByOrderCode(orderCode: bigint) {
    return this.prisma.payments.findUnique({
      where: { order_code: orderCode },
      include: { user: true },
    });
  }
}
