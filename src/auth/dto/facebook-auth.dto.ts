import { IsEmail, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class FacebookAuthDto {
  @IsOptional()
  @IsEmail({}, { message: 'Email không hợp lệ' })
  email?: string;

  @IsOptional()
  @IsString()
  name?: string;

  @IsNotEmpty()
  @IsString()
  providerId!: string;
}

