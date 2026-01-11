import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcryptjs';
import { randomBytes } from 'crypto';

import { UsersService } from '../users/users.service';
import { AccountType } from '../users/dto/create-user.dto';
import { MailService } from '../mail/mail.service';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
import { VerifyEmailDto } from './dto/verify-email.dto';
import { ResendVerificationDto } from './dto/resend-verification.dto';
import { GoogleAuthDto } from './dto/google-auth.dto';
import { SetPasswordDto } from './dto/set-password.dto';
import { ForgotPasswordDto } from './dto/forgot-password.dto';
import { ResetPasswordDto } from './dto/reset-password.dto';

type TokenPayload = {
  sub: number;
  email: string;
  role: string;
};

type AuthTokens = {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
};

@Injectable()
export class AuthService {
  private readonly verificationTtlMs = 5 * 60 * 1000;
  private readonly resetTtlMs = 5 * 60 * 1000;

  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
    private readonly mailService: MailService,
  ) {}

  // Đăng ký tài khoản mới và gửi mã xác thực
  async register(payload: RegisterDto) {
    const newUser = await this.usersService.create({
      ...payload,
      account_type: AccountType.LOCAL,
      email_confirmed: false,
      must_set_password: false,
    });

    const dispatch = await this.dispatchVerification(newUser.user_id, newUser.email);

    return {
      message:
        'Đăng ký thành công. Vui lòng kiểm tra email để nhập mã xác thực trước khi đăng nhập.',
      email: newUser.email,
      expiresIn: dispatch.expiresIn,
    };
  }

  // Đăng nhập bằng email và mật khẩu
  async login(payload: LoginDto) {
    const user = await this.usersService.findByEmail(payload.email);
    if (!user) {
      throw new UnauthorizedException('Email hoặc mật khẩu không đúng');
    }

    const passwordValid = await bcrypt.compare(
      payload.password,
      user.password_hash,
    );
    if (!passwordValid) {
      throw new UnauthorizedException('Email hoặc mật khẩu không đúng');
    }

    if (!user.email_confirmed) {
      const dispatch = await this.ensureActiveVerification(user);
      throw new ForbiddenException({
        code: 'EMAIL_NOT_VERIFIED',
        message: 'Tài khoản chưa được xác thực. Vui lòng nhập mã đã gửi đến email.',
        email: user.email,
        expiresIn: dispatch.expiresIn,
      });
    }

    const tokens = await this.buildTokens({
      sub: user.user_id,
      email: user.email,
      role: user.role,
    });

    return {
      user: this.mapUser(user),
      tokens,
    };
  }

  // Tạo lại access token từ refresh token
  async refreshToken(refreshToken: string) {
    try {
      const decoded = await this.jwtService.verifyAsync<TokenPayload>(
        refreshToken,
        {
          secret: this.configService.getOrThrow<string>('JWT_REFRESH_SECRET'),
        },
      );

      // Đảm bảo user vẫn tồn tại trong hệ thống
      const user = await this.usersService.findById(decoded.sub);
      const tokens = await this.buildTokens({
        sub: user.user_id,
        email: user.email,
        role: user.role,
      });
      return { user, tokens };
    } catch (error) {
      throw new UnauthorizedException('Refresh token không hợp lệ');
    }
  }

  async verifyEmail(dto: VerifyEmailDto) {
    const user = await this.usersService.findByEmail(dto.email);
    if (!user) {
      throw new NotFoundException('Không tìm thấy tài khoản');
    }

    if (user.email_confirmed) {
      return { message: 'Email đã được xác thực trước đó' };
    }

    if (!user.verification_code || !user.verification_code_expires_at) {
      throw new BadRequestException('Mã xác thực không tồn tại. Vui lòng yêu cầu mã mới.');
    }

    if (user.verification_code !== dto.code) {
      throw new BadRequestException('Mã xác thực không chính xác');
    }

    if (user.verification_code_expires_at < new Date()) {
      throw new BadRequestException('Mã xác thực đã hết hạn. Vui lòng yêu cầu mã mới.');
    }

    await this.usersService.confirmEmail(user.user_id);

    return { message: 'Xác thực email thành công' };
  }

  async resendVerification(dto: ResendVerificationDto) {
    const user = await this.usersService.findByEmail(dto.email);
    if (!user) {
      throw new NotFoundException('Không tìm thấy tài khoản');
    }

    if (user.email_confirmed) {
      return { message: 'Email đã được xác thực' };
    }

    const dispatch = await this.dispatchVerification(user.user_id, user.email);
    return {
      message: 'Đã gửi lại mã xác thực. Vui lòng kiểm tra hòm thư.',
      expiresIn: dispatch.expiresIn,
    };
  }

  async forgotPassword(dto: ForgotPasswordDto) {
    const user = await this.usersService.findByEmail(dto.email);
    if (!user) {
      return {
        message:
          'Nếu email tồn tại trong hệ thống, CapyChina đã gửi mã OTP đặt lại mật khẩu.',
      };
    }

    const dispatch = await this.dispatchResetCode(user.user_id, user.email);
    return {
      message: 'Đã gửi mã OTP đặt lại mật khẩu. Vui lòng kiểm tra email.',
      expiresIn: dispatch.expiresIn,
    };
  }

  async resetPassword(dto: ResetPasswordDto) {
    const user = await this.usersService.findByEmail(dto.email);
    if (!user) {
      throw new NotFoundException('Không tìm thấy tài khoản');
    }

    if (dto.password !== dto.confirmPassword) {
      throw new BadRequestException('Mật khẩu xác nhận không khớp');
    }

    if (!user.reset_code || !user.reset_code_expires_at) {
      throw new BadRequestException('Mã OTP không tồn tại. Vui lòng gửi lại yêu cầu.');
    }

    if (user.reset_code !== dto.code) {
      throw new BadRequestException('Mã OTP không chính xác');
    }

    if (user.reset_code_expires_at < new Date()) {
      throw new BadRequestException('Mã OTP đã hết hạn. Vui lòng gửi lại yêu cầu.');
    }

    const updated = await this.usersService.updatePassword(user.user_id, dto.password, {
      mustSetPassword: false,
    });
    await this.usersService.clearResetCode(user.user_id);

    const tokens = await this.buildTokens({
      sub: updated.user_id,
      email: updated.email,
      role: updated.role,
    });

    return {
      message: 'Đặt lại mật khẩu thành công',
      user: this.mapUser(updated),
      tokens,
    };
  }

  async handleGoogleAuth(dto: GoogleAuthDto) {
    const normalizedEmail = dto.email.toLowerCase();
    let user = await this.usersService.findByEmail(normalizedEmail);

    if (!user) {
      await this.usersService.create({
        username: dto.name ?? normalizedEmail.split('@')[0],
        email: normalizedEmail,
        password: this.generateTemporaryPassword(),
        account_type: AccountType.GOOGLE,
        email_confirmed: true,
        must_set_password: true,
      });
      user = await this.usersService.findByEmail(normalizedEmail);
    } else {
      if (!user.email_confirmed) {
        await this.usersService.confirmEmail(user.user_id);
      }

      user = await this.usersService.findByEmail(normalizedEmail);
    }

    if (!user) {
      throw new NotFoundException(
        'Không thể khởi tạo tài khoản Google. Vui lòng thử lại.',
      );
    }

    const tokens = await this.buildTokens({
      sub: user.user_id,
      email: user.email,
      role: user.role,
    });

    return {
      user: this.mapUser(user),
      tokens,
    };
  }

  async setPassword(userId: number, dto: SetPasswordDto) {
    if (dto.password !== dto.confirmPassword) {
      throw new BadRequestException('Mật khẩu xác nhận không khớp');
    }

    const user = await this.usersService.updatePassword(userId, dto.password, {
      mustSetPassword: false,
    });

    return {
      message: 'Cập nhật mật khẩu thành công',
      user,
    };
  }

  private async buildTokens(payload: TokenPayload): Promise<AuthTokens> {
    const accessExpiresSetting =
      this.configService.get<string>('JWT_ACCESS_EXPIRES_IN') ?? '900s';
    const refreshExpiresSetting =
      this.configService.get<string>('JWT_REFRESH_EXPIRES_IN') ?? '7d';

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(payload, {
        expiresIn: this.parseExpiresIn(accessExpiresSetting),
      }),
      this.jwtService.signAsync(payload, {
        secret: this.configService.getOrThrow<string>('JWT_REFRESH_SECRET'),
        expiresIn: this.parseExpiresIn(refreshExpiresSetting),
      }),
    ]);

    return {
      accessToken,
      refreshToken,
      expiresIn: this.parseExpiresIn(accessExpiresSetting),
    };
  }

  private parseExpiresIn(value?: string): number {
    // Hỗ trợ các format phổ biến: 15m, 1h, 7d
    if (!value) {
      return 900;
    }

    const match = value.match(/^(\d+)([smhd])$/);
    if (!match) {
      return 900; // default 15m
    }

    const amount = parseInt(match[1], 10);
    const unit = match[2];

    switch (unit) {
      case 's':
        return amount;
      case 'm':
        return amount * 60;
      case 'h':
        return amount * 3600;
      case 'd':
        return amount * 86400;
      default:
        return 900;
    }
  }

  private async dispatchVerification(userId: number, email: string) {
    const code = this.generateVerificationCode();
    const expiresAt = new Date(Date.now() + this.verificationTtlMs);
    await this.usersService.saveVerificationCode(userId, code, expiresAt);
    
    // Gửi email trong background để không block response
    this.mailService.sendEmailVerificationAsync(email, code, expiresAt);

    return {
      expiresIn: Math.floor(this.verificationTtlMs / 1000),
    };
  }

  private async dispatchResetCode(userId: number, email: string) {
    const code = this.generateVerificationCode();
    const expiresAt = new Date(Date.now() + this.resetTtlMs);
    await this.usersService.saveResetCode(userId, code, expiresAt);
    
    // Gửi email trong background để không block response
    this.mailService.sendPasswordResetAsync(email, code, expiresAt);
    
    return {
      expiresIn: Math.floor(this.resetTtlMs / 1000),
    };
  }

  private async ensureActiveVerification(user: any) {
    if (
      !user.verification_code ||
      !user.verification_code_expires_at ||
      user.verification_code_expires_at < new Date()
    ) {
      return this.dispatchVerification(user.user_id, user.email);
    }

    const remaining =
      (user.verification_code_expires_at.getTime() - Date.now()) / 1000;
    return { expiresIn: Math.max(0, Math.floor(remaining)) };
  }

  private generateVerificationCode(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  private generateTemporaryPassword() {
    return randomBytes(8).toString('hex');
  }

  private mapUser(user: any) {
    return {
      user_id: user.user_id,
      username: user.username,
      email: user.email,
      role: user.role,
      created_at: user.created_at,
      email_confirmed: user.email_confirmed,
      account_status: user.account_status,
      account_type: user.account_type,
      must_set_password: user.must_set_password,
      image_url: user.image_url,
      address: user.address,
      province: user.province,
      region: user.region,
      xp: user.xp ?? 0,
      streak_days: user.streak_days ?? 0,
    };
  }
}
