import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import * as path from 'path';
import { PrismaService } from '../prisma/prisma.service';
import { PayOSService } from './payos.service';
import { MailService } from '../mail/mail.service';
import { PaymentStatus, VipPackageType } from '@prisma/client';
import * as QRCode from 'qrcode';
import * as XLSX from 'xlsx';
import PDFDocument from 'pdfkit';
import { UpdatePaymentDto } from './dto/update-payment.dto';

const FONT_BASE = path.join(process.cwd(), 'node_modules', 'dejavu-fonts-ttf', 'ttf');
const FONT_SERIF = path.join(FONT_BASE, 'DejaVuSerif.ttf');
const FONT_SERIF_BOLD = path.join(FONT_BASE, 'DejaVuSerif-Bold.ttf');

@Injectable()
export class PaymentService {
  private readonly logger = new Logger(PaymentService.name);

  // Giá các gói VIP (VND)
  private readonly VIP_PRICES: Record<VipPackageType, number> = {
    one_day: 10000,
    one_week: 50000,
    one_month: 200000,
    one_year: 500000,
    lifetime: 1000,
  };

  // Mô tả ngắn gọn gửi sang PayOS (tối đa 25 ký tự)
  private readonly VIP_DESCRIPTIONS: Record<VipPackageType, string> = {
    one_day: 'VIP-1D',
    one_week: 'VIP-1W',
    one_month: 'VIP-1M',
    one_year: 'VIP-1Y',
    lifetime: 'VIP-LIFE',
  };

  constructor(
    private readonly prisma: PrismaService,
    private readonly payOSService: PayOSService,
    private readonly mailService: MailService,
  ) {}

  async createPayment(userId: number, vipPackageType: VipPackageType) {
    const amount = this.VIP_PRICES[vipPackageType];
    if (!amount) {
      throw new Error(`Invalid VIP package type: ${vipPackageType}`);
    }

    const description = this.VIP_DESCRIPTIONS[vipPackageType] || 'VIP';

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
        description,
      },
    });

    // Tạo payment link với PayOS
    const payOS = this.payOSService.getPayOS();
    const frontendUrl = process.env.FRONTEND_URL || 'http://localhost:3000';

    const paymentLink = await payOS.paymentRequests.create({
      orderCode: Number(orderCode),
      amount,
      description,
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

      // Gửi email cảm ơn khi thanh toán VIP thành công (chạy trong background)
      this.mailService.sendVipThankYouEmailAsync(
        payment.user.email,
        payment.user.username,
        payment.vip_package_type,
        expiresAt,
        payment.amount,
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

  async cancelPayment(paymentId: number) {
    const payment = await this.prisma.payments.findUnique({
      where: { payment_id: paymentId },
    });

    if (!payment) {
      throw new NotFoundException('Payment không tồn tại');
    }

    if (payment.status === 'paid') {
      this.logger.warn(`Không thể hủy payment ${payment.payment_id} vì đã thanh toán`);
      return { success: false, message: 'Payment đã được thanh toán, không thể hủy' };
    }

    if (payment.status === 'cancelled' || payment.status === 'cancel') {
      this.logger.log(`Payment ${payment.payment_id} đã ở trạng thái cancelled`);
      return { success: true, message: 'Payment đã được hủy trước đó' };
    }

    await this.prisma.payments.update({
      where: { payment_id: paymentId },
      data: {
        status: 'cancelled',
        updated_at: new Date(),
      },
    });

    this.logger.log(`Payment ${paymentId} được hủy thủ công từ API`);
    return { success: true, message: 'Payment đã được hủy thành công' };
  }

  /** Chuyển payment sang dạng JSON-safe (BigInt order_code -> string) */
  private serializePaymentForJson<T extends { order_code: bigint }>(p: T): Omit<T, 'order_code'> & { order_code: string } {
    return { ...p, order_code: String(p.order_code) } as Omit<T, 'order_code'> & { order_code: string };
  }

  /** Danh sách giao dịch cho admin (có thông tin user) */
  async findAllForAdmin() {
    const list = await this.prisma.payments.findMany({
      include: {
        user: {
          select: {
            user_id: true,
            username: true,
            email: true,
          },
        },
      },
      orderBy: { created_at: 'desc' },
    });
    return list.map((p) => this.serializePaymentForJson(p));
  }

  /** Danh sách giao dịch đã lọc theo status, year, month (cho báo cáo) */
  async getFilteredForAdmin(filters: { status?: string; year?: number; month?: number }) {
    const where: Record<string, unknown> = {};
    if (filters.status && filters.status !== 'all') {
      where.status =
        filters.status === 'cancelled' ? { in: ['cancelled', 'cancel'] } : filters.status;
    }
    if (filters.year != null && filters.month != null) {
      where.created_at = {
        gte: new Date(filters.year, filters.month - 1, 1),
        lt: new Date(filters.year, filters.month, 1),
      };
    } else if (filters.year != null) {
      where.created_at = {
        gte: new Date(filters.year, 0, 1),
        lt: new Date(filters.year + 1, 0, 1),
      };
    }
    const list = await this.prisma.payments.findMany({
      where: Object.keys(where).length ? where : undefined,
      include: {
        user: {
          select: {
            user_id: true,
            username: true,
            email: true,
          },
        },
      },
      orderBy: { created_at: 'desc' },
    });
    let result = list.map((p) => this.serializePaymentForJson(p));
    if (filters.month != null && filters.year == null) {
      result = result.filter((p) => new Date(p.created_at).getMonth() + 1 === filters.month);
    }
    return result;
  }

  /** Cập nhật giao dịch (admin) */
  async updatePaymentAdmin(paymentId: number, dto: UpdatePaymentDto) {
    const payment = await this.prisma.payments.findUnique({
      where: { payment_id: paymentId },
    });
    if (!payment) {
      throw new NotFoundException('Giao dịch không tồn tại');
    }
    const updated = await this.prisma.payments.update({
      where: { payment_id: paymentId },
      data: {
        ...(dto.status != null && { status: dto.status }),
        ...(dto.description != null && { description: dto.description }),
        updated_at: new Date(),
      },
      include: {
        user: {
          select: {
            user_id: true,
            username: true,
            email: true,
          },
        },
      },
    });
    return this.serializePaymentForJson(updated);
  }

  /** Xuất báo cáo PDF (buffer) — theo dữ liệu đã lọc nếu có filter */
  async exportPdf(filters?: { status?: string; year?: number; month?: number }): Promise<Buffer> {
    const hasFilter =
      filters &&
      (filters.status != null || filters.year != null || filters.month != null);
    const rows = hasFilter
      ? await this.getFilteredForAdmin(filters!)
      : await this.findAllForAdmin();
    const doc = new PDFDocument({ margin: 40, size: 'A4' });
    const chunks: Buffer[] = [];
    doc.on('data', (chunk: Buffer) => chunks.push(chunk));
    const bufferPromise = new Promise<Buffer>((resolve, reject) => {
      doc.on('end', () => resolve(Buffer.concat(chunks)));
      doc.on('error', reject);
    });

    // Font hỗ trợ tiếng Việt (Unicode)
    doc.registerFont('DejaVuSerif', FONT_SERIF);
    doc.registerFont('DejaVuSerifBold', FONT_SERIF_BOLD);
    const statusLabelForFilter: Record<string, string> = {
      pending: 'Chờ xử lý',
      paid: 'Đã thanh toán',
      cancelled: 'Đã hủy',
      cancel: 'Đã hủy',
      expired: 'Hết hạn',
    };
    const filterParts: string[] = [];
    if (filters?.status) filterParts.push(`Trạng thái: ${statusLabelForFilter[filters.status] ?? filters.status}`);
    if (filters?.year) filterParts.push(`Năm: ${filters.year}`);
    if (filters?.month) filterParts.push(`Tháng: ${filters.month}`);
    const filterLabel = filterParts.length > 0 ? filterParts.join(' | ') : 'Toàn bộ dữ liệu';

    doc.font('DejaVuSerif');
    doc.fontSize(18).text('BÁO CÁO GIAO DỊCH THANH TOÁN', { align: 'center' });
    doc.moveDown(0.5);
    doc.fontSize(10).text(`Ngày xuất: ${new Date().toLocaleString('vi-VN')}`, { align: 'center' });
    doc.moveDown(0.3);
    doc.fontSize(9).text(`Xuất theo bộ lọc: ${filterLabel}`, { align: 'center' });
    doc.moveDown(1);

    const headers = ['STT', 'Mã GD', 'Mã đơn', 'Người dùng', 'Email', 'Gói VIP', 'Số tiền (VNĐ)', 'Trạng thái', 'Ngày tạo'];
    const colWidths = [28, 38, 58, 70, 95, 52, 58, 42, 55];
    const startY = doc.y;
    let y = startY;
    const rowHeight = 28;
    const tableTop = y;

    const tableWidth = colWidths.reduce((a, b) => a + b, 0) + 4 * (headers.length - 1);
    const tableLeft = 40;
    const cellVerticalOffset = (rowHeight - 10) / 2;

    // Viền trên bảng + hàng tiêu đề (không dùng rect, vẽ từng cạnh)
    doc.moveTo(tableLeft, tableTop).lineTo(tableLeft + tableWidth, tableTop).stroke();
    doc.fontSize(9).font('DejaVuSerifBold');
    let x = tableLeft;
    headers.forEach((h, i) => {
      doc.text(h, x, y + cellVerticalOffset, { width: colWidths[i], align: i === 3 || i === 4 ? 'left' : 'center' });
      x += colWidths[i] + 4;
    });
    y += rowHeight;
    doc.moveTo(tableLeft, y).lineTo(tableLeft + tableWidth, y).stroke();
    doc.font('DejaVuSerif');

    const statusLabel: Record<string, string> = {
      pending: 'Chờ xử lý',
      paid: 'Đã thanh toán',
      cancelled: 'Đã hủy',
      cancel: 'Đã hủy',
      expired: 'Hết hạn',
    };
    const totalsByStatusPdf: Record<string, { count: number; amount: number }> = {
      pending: { count: 0, amount: 0 },
      paid: { count: 0, amount: 0 },
      cancelled: { count: 0, amount: 0 },
      expired: { count: 0, amount: 0 },
    };
    rows.forEach((p) => {
      const key = p.status === 'cancel' ? 'cancelled' : p.status;
      if (totalsByStatusPdf[key]) {
        totalsByStatusPdf[key].count += 1;
        totalsByStatusPdf[key].amount += p.amount;
      }
    });
    const vipLabel: Record<string, string> = {
      one_day: '1 Ngày',
      one_week: '1 Tuần',
      one_month: '1 Tháng',
      one_year: '1 Năm',
      lifetime: 'Vĩnh viễn',
    };

    rows.forEach((p, idx) => {
      if (y > 700) {
        doc.addPage();
        y = 40;
        doc.moveTo(tableLeft, y).lineTo(tableLeft + tableWidth, y).stroke();
        doc.font('DejaVuSerifBold').fontSize(9);
        x = tableLeft;
        headers.forEach((h, i) => {
          doc.text(h, x, y + cellVerticalOffset, { width: colWidths[i], align: i === 3 || i === 4 ? 'left' : 'center' });
          x += colWidths[i] + 4;
        });
        y += rowHeight;
        doc.moveTo(tableLeft, y).lineTo(tableLeft + tableWidth, y).stroke();
        doc.font('DejaVuSerif');
      }
      const user = p.user as { username?: string; email?: string };
      const cells = [
        String(idx + 1),
        String(p.payment_id),
        String(p.order_code),
        (user?.username ?? '—').slice(0, 12),
        (user?.email ?? '—').slice(0, 18),
        vipLabel[p.vip_package_type] ?? p.vip_package_type,
        p.amount.toLocaleString('vi-VN'),
        statusLabel[p.status] ?? p.status,
        new Date(p.created_at).toLocaleString('vi-VN', { dateStyle: 'short', timeStyle: 'short' }),
      ];
      x = tableLeft;
      doc.fontSize(8);
      cells.forEach((cell, i) => {
        doc.text(cell, x, y + cellVerticalOffset, { width: colWidths[i], align: i === 3 || i === 4 ? 'left' : 'center' });
        x += colWidths[i] + 4;
      });
      y += rowHeight;
      doc.moveTo(tableLeft, y).lineTo(tableLeft + tableWidth, y).stroke();
    });

    // Viền dọc: trái, giữa các cột, phải (lưới rõ ràng)
    for (let i = 0; i <= headers.length; i++) {
      const colX = tableLeft + colWidths.slice(0, i).reduce((a, b) => a + b, 0) + 4 * i;
      doc.moveTo(colX, tableTop).lineTo(colX, y).stroke();
    }
    doc.moveDown(0.5);
    doc.font('DejaVuSerif').fontSize(10);
    doc.text(`Tổng số giao dịch: ${rows.length}`, tableLeft, doc.y);
    doc.moveDown(0.5);
    doc.font('DejaVuSerifBold').fontSize(10).text('Tổng theo trạng thái:', tableLeft, doc.y);
    doc.font('DejaVuSerif').fontSize(9);
    const summaryOrder = [
      { key: 'pending', label: 'Chờ xử lý' },
      { key: 'paid', label: 'Đã thanh toán' },
      { key: 'cancelled', label: 'Đã hủy' },
      { key: 'expired', label: 'Hết hạn' },
    ];
    summaryOrder.forEach(({ key, label }) => {
      const t = totalsByStatusPdf[key];
      if (t) {
        doc.moveDown(0.2);
        doc.text(
          `  ${label}: ${t.count} giao dịch — ${t.amount.toLocaleString('vi-VN')} VNĐ`,
          tableLeft,
          doc.y,
        );
      }
    });
    doc.moveDown(0.5);
    doc.fontSize(9).text(
      `Báo cáo được xuất lúc ${new Date().toLocaleString('vi-VN')} — CapyChina Admin`,
      { align: 'center' },
    );

    doc.end();
    return bufferPromise;
  }

  /** Xuất báo cáo Excel (buffer) — theo dữ liệu đã lọc nếu có filter */
  async exportExcel(filters?: { status?: string; year?: number; month?: number }): Promise<Buffer> {
    const hasFilter =
      filters &&
      (filters.status != null || filters.year != null || filters.month != null);
    const rows = hasFilter
      ? await this.getFilteredForAdmin(filters!)
      : await this.findAllForAdmin();
    const statusLabel: Record<string, string> = {
      pending: 'Chờ xử lý',
      paid: 'Đã thanh toán',
      cancelled: 'Đã hủy',
      cancel: 'Đã hủy',
      expired: 'Hết hạn',
    };
    const vipLabel: Record<string, string> = {
      one_day: '1 Ngày',
      one_week: '1 Tuần',
      one_month: '1 Tháng',
      one_year: '1 Năm',
      lifetime: 'Vĩnh viễn',
    };

    const totalsByStatus: Record<string, { count: number; amount: number }> = {
      pending: { count: 0, amount: 0 },
      paid: { count: 0, amount: 0 },
      cancelled: { count: 0, amount: 0 },
      expired: { count: 0, amount: 0 },
    };
    rows.forEach((p) => {
      const key = p.status === 'cancel' ? 'cancelled' : p.status;
      if (totalsByStatus[key]) {
        totalsByStatus[key].count += 1;
        totalsByStatus[key].amount += p.amount;
      }
    });

    const filterPartsExcel: string[] = [];
    if (filters?.status) filterPartsExcel.push(`Trạng thái: ${statusLabel[filters.status] ?? filters.status}`);
    if (filters?.year) filterPartsExcel.push(`Năm: ${filters.year}`);
    if (filters?.month) filterPartsExcel.push(`Tháng: ${filters.month}`);
    const filterLabelExcel = filterPartsExcel.length > 0 ? filterPartsExcel.join(' | ') : 'Toàn bộ dữ liệu';

    const summaryOrder = [
      { key: 'pending', label: 'Chờ xử lý' },
      { key: 'paid', label: 'Đã thanh toán' },
      { key: 'cancelled', label: 'Đã hủy' },
      { key: 'expired', label: 'Hết hạn' },
    ];
    const summaryRows = [
      [],
      ['TỔNG THEO TRẠNG THÁI'],
      ['Trạng thái', 'Số giao dịch', 'Tổng tiền (VNĐ)'],
      ...summaryOrder.map(({ key, label }) => {
        const t = totalsByStatus[key];
        return [label, t?.count ?? 0, t?.amount ?? 0];
      }),
    ];

    const data = [
      ['BÁO CÁO GIAO DỊCH THANH TOÁN'],
      [`Ngày xuất: ${new Date().toLocaleString('vi-VN')}`],
      [`Xuất theo bộ lọc: ${filterLabelExcel}`],
      [],
      ['STT', 'Mã giao dịch', 'Mã đơn hàng', 'Người dùng', 'Email', 'Gói VIP', 'Số tiền (VNĐ)', 'Trạng thái', 'Ngày tạo', 'Ngày thanh toán'],
      ...rows.map((p, idx) => {
        const user = p.user as { username?: string; email?: string };
        return [
          idx + 1,
          p.payment_id,
          String(p.order_code),
          user?.username ?? '—',
          user?.email ?? '—',
          vipLabel[p.vip_package_type] ?? p.vip_package_type,
          p.amount,
          statusLabel[p.status] ?? p.status,
          new Date(p.created_at).toLocaleString('vi-VN'),
          p.paid_at ? new Date(p.paid_at).toLocaleString('vi-VN') : '—',
        ];
      }),
      ...summaryRows,
    ];

    const ws = XLSX.utils.aoa_to_sheet(data);
    const colWidths = [{ wch: 5 }, { wch: 12 }, { wch: 14 }, { wch: 18 }, { wch: 24 }, { wch: 12 }, { wch: 14 }, { wch: 14 }, { wch: 18 }, { wch: 18 }];
    ws['!cols'] = colWidths;
    ws['!merges'] = [
      { s: { r: 0, c: 0 }, e: { r: 0, c: 9 } },
      { s: { r: 1, c: 0 }, e: { r: 1, c: 9 } },
      { s: { r: 2, c: 0 }, e: { r: 2, c: 9 } },
    ];
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'Giao dịch');
    return Buffer.from(XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' }));
  }
}
