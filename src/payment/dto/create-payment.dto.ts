import { IsEnum, IsNotEmpty } from 'class-validator';
import { VipPackageType } from '@prisma/client';

export class CreatePaymentDto {
  @IsNotEmpty()
  @IsEnum(VipPackageType)
  vipPackageType: VipPackageType;
}
