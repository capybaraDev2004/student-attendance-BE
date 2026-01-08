import {
  IsBoolean,
  IsDateString,
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';

// Enum role để validate dữ liệu đầu vào giống schema
export enum UserRole {
  ADMIN = 'admin',
  CUSTOMER = 'customer',
}

export enum AccountStatus {
  NORMAL = 'normal',
  VIP = 'vip',
}

export enum AccountType {
  LOCAL = 'local',
  GOOGLE = 'google',
}

export enum Region {
  BAC = 'bac',
  TRUNG = 'trung',
  NAM = 'nam',
}

export class CreateUserDto {
  @IsNotEmpty({ message: 'Tên người dùng không được để trống' })
  @IsString({ message: 'Tên người dùng phải là chuỗi' })
  username!: string;

  @IsNotEmpty({ message: 'Email không được để trống' })
  @IsEmail({}, { message: 'Email không hợp lệ' })
  email!: string;

  @IsNotEmpty({ message: 'Mật khẩu không được để trống' })
  @MinLength(6, { message: 'Mật khẩu phải tối thiểu 6 ký tự' })
  password!: string;

  @IsOptional()
  @IsEnum(UserRole, { message: 'Role không hợp lệ' })
  role?: UserRole;

  @IsOptional()
  @IsBoolean({ message: 'email_confirmed phải là true/false' })
  email_confirmed?: boolean;

  @IsOptional()
  @IsString({ message: 'verification_code phải là chuỗi' })
  verification_code?: string;

  @IsOptional()
  @IsDateString({}, { message: 'verification_code_expires_at phải là định dạng ISO' })
  verification_code_expires_at?: string;

  @IsOptional()
  @IsEnum(AccountStatus, { message: 'account_status không hợp lệ' })
  account_status?: AccountStatus;

  @IsOptional()
  @IsEnum(AccountType, { message: 'account_type không hợp lệ' })
  account_type?: AccountType;

  @IsOptional()
  @IsBoolean({ message: 'must_set_password phải là true/false' })
  must_set_password?: boolean;

  @IsOptional()
  @IsString({ message: 'image_url phải là chuỗi' })
  image_url?: string;

  @IsOptional()
  @IsString({ message: 'address phải là chuỗi' })
  address?: string;

  @IsOptional()
  @IsString({ message: 'province phải là chuỗi' })
  province?: string;

  @IsOptional()
  @IsEnum(Region, { message: 'region không hợp lệ' })
  region?: Region;

  @IsOptional()
  xp?: number;

  @IsOptional()
  streak_days?: number;
}
