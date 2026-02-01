import { Module } from '@nestjs/common';
import { PaymentController } from './payment.controller';
import { PaymentService } from './payment.service';
import { PayOSService } from './payos.service';
import { PrismaModule } from '../prisma/prisma.module';
import { MailModule } from '../mail/mail.module';
import { AuthModule } from '../auth/auth.module';
import { AdminPaymentsController } from './admin-payments.controller';

@Module({
  imports: [PrismaModule, MailModule, AuthModule],
  controllers: [PaymentController, AdminPaymentsController],
  providers: [PaymentService, PayOSService],
  exports: [PaymentService],
})
export class PaymentModule {}
