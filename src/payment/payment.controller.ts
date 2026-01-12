import {
  Controller,
  Post,
  Body,
  UseGuards,
  Get,
  Param,
  UnauthorizedException,
} from '@nestjs/common';
import { PaymentService } from './payment.service';
import { CreatePaymentDto } from './dto/create-payment.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';

@Controller('payment')
export class PaymentController {
  constructor(private readonly paymentService: PaymentService) {}

  @Post('create')
  @UseGuards(JwtAuthGuard)
  async createPayment(@CurrentUser() user: any, @Body() dto: CreatePaymentDto) {
    const userId = user?.user_id;
    if (!userId) {
      throw new UnauthorizedException('Không xác định được người dùng');
    }
    return this.paymentService.createPayment(userId, dto.vipPackageType);
  }

  @Post('webhook/payos')
  async webhook(@Body() body: any) {
    return this.paymentService.handleWebhook(body);
  }

  @Get('status/:orderCode')
  @UseGuards(JwtAuthGuard)
  async getPaymentStatus(
    @CurrentUser() user: any,
    @Param('orderCode') orderCode: string,
  ) {
    const userId = user?.user_id;
    if (!userId) {
      throw new UnauthorizedException('Không xác định được người dùng');
    }
    
    const payment = await this.paymentService.getPaymentByOrderCode(
      BigInt(orderCode),
    );
    if (!payment) {
      return { status: 'not_found' };
    }
    
    // Kiểm tra payment thuộc về user hiện tại
    if (payment.user_id !== userId) {
      throw new UnauthorizedException('Không có quyền truy cập payment này');
    }
    
    return {
      status: payment.status,
      vipPackageType: payment.vip_package_type,
      amount: payment.amount,
    };
  }
}
