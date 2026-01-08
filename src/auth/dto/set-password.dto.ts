import { IsNotEmpty, MinLength } from 'class-validator';

export class SetPasswordDto {
  @IsNotEmpty({ message: 'Mật khẩu không được để trống' })
  @MinLength(6, { message: 'Mật khẩu tối thiểu 6 ký tự' })
  password!: string;

  @IsNotEmpty({ message: 'Xác nhận mật khẩu không được để trống' })
  @MinLength(6, { message: 'Mật khẩu tối thiểu 6 ký tự' })
  confirmPassword!: string;
}

