import {
  IsEmail,
  IsEnum,
  IsOptional,
  IsString,
} from 'class-validator';

import { Region } from './create-user.dto';

export class UpdateProfileDto {
  @IsOptional()
  @IsString({ message: 'Tên người dùng phải là chuỗi' })
  username?: string;

  @IsOptional()
  @IsEmail({}, { message: 'Email không hợp lệ' })
  email?: string;

  @IsOptional()
  @IsString({ message: 'Địa chỉ phải là chuỗi' })
  address?: string;

  @IsOptional()
  @IsString({ message: 'Tỉnh/Thành phải là chuỗi' })
  province?: string;

  @IsOptional()
  @IsEnum(Region, { message: 'Miền không hợp lệ' })
  region?: Region;
}

