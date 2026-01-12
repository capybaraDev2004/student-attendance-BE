import { PartialType } from '@nestjs/mapped-types';
import { IsDateString, IsEnum, IsOptional } from 'class-validator';
import { VipPackageType } from '@prisma/client';

import { CreateUserDto, UserRole } from './create-user.dto';

export class UpdateUserDto extends PartialType(CreateUserDto) {
  @IsOptional()
  @IsEnum(UserRole, { message: 'Role không hợp lệ' })
  role?: UserRole;

  @IsOptional()
  @IsEnum(VipPackageType, { message: 'VipPackageType không hợp lệ' })
  vip_package_type?: VipPackageType;

  @IsOptional()
  @IsDateString({}, { message: 'vip_expires_at phải là định dạng ISO' })
  vip_expires_at?: string | null;
}
