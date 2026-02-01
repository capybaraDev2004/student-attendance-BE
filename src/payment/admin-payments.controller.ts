import {
  Controller,
  Get,
  Patch,
  Param,
  ParseIntPipe,
  Query,
  UseGuards,
  Res,
  BadRequestException,
} from '@nestjs/common';
import type { Response } from 'express';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { PaymentService } from './payment.service';
import { UpdatePaymentDto } from './dto/update-payment.dto';
import { Body } from '@nestjs/common';

@Controller('admin/payments')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('admin')
export class AdminPaymentsController {
  constructor(private readonly paymentService: PaymentService) {}

  @Get()
  findAll() {
    return this.paymentService.findAllForAdmin();
  }

  @Get('export')
  async exportReport(
    @Query('format') format: string,
    @Res({ passthrough: false }) res: Response,
    @Query('status') status?: string,
    @Query('year') year?: string,
    @Query('month') month?: string,
  ) {
    const f = (format || '').toLowerCase();
    const filters: { status?: string; year?: number; month?: number } = {};
    if (status && status !== 'all') filters.status = status;
    const yearNum = year ? parseInt(year, 10) : undefined;
    if (yearNum && !Number.isNaN(yearNum)) filters.year = yearNum;
    const monthNum = month ? parseInt(month, 10) : undefined;
    if (monthNum && monthNum >= 1 && monthNum <= 12) filters.month = monthNum;

    if (f === 'pdf') {
      const buffer = await this.paymentService.exportPdf(filters);
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader(
        'Content-Disposition',
        `attachment; filename="Bao-cao-giao-dich-${new Date().toISOString().slice(0, 10)}.pdf"`,
      );
      res.send(buffer);
      return;
    }
    if (f === 'excel' || f === 'xlsx') {
      const buffer = await this.paymentService.exportExcel(filters);
      res.setHeader(
        'Content-Type',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      );
      res.setHeader(
        'Content-Disposition',
        `attachment; filename="Bao-cao-giao-dich-${new Date().toISOString().slice(0, 10)}.xlsx"`,
      );
      res.send(buffer);
      return;
    }
    throw new BadRequestException(
      'Tham số format phải là pdf hoặc excel (xlsx)',
    );
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: UpdatePaymentDto,
  ) {
    return this.paymentService.updatePaymentAdmin(id, dto);
  }
}
