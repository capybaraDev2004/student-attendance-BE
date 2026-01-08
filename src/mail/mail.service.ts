import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);
  private readonly fromAddress: string;
  private readonly fromName: string;
  private readonly transporter: nodemailer.Transporter;

  constructor(private readonly configService: ConfigService) {
    const user = this.configService.get<string>('MAIL_USER');
    const pass = this.configService.get<string>('MAIL_PASS');

    if (!user || !pass) {
      this.logger.warn(
        'MAIL_USER hoặc MAIL_PASS chưa được cấu hình - email sẽ không được gửi',
      );
    }

    this.fromAddress = user ?? 'no-reply@capychina.app';
    this.fromName = this.configService.get<string>('MAIL_FROM_NAME') ?? 'CapyChina';

    this.transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: user && pass ? { user, pass } : undefined,
    });
  }

  async sendEmailVerification(
    to: string,
    code: string,
    expiresAt: Date,
  ): Promise<void> {
    if (!this.transporter) {
      this.logger.warn('Không thể gửi email vì transporter chưa cấu hình hợp lệ');
      return;
    }

    const formattedExpires = expiresAt.toLocaleTimeString('vi-VN', {
      hour: '2-digit',
      minute: '2-digit',
    });

    const html = `
      <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background:#f4f6fb;padding:24px 0;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;">
        <tr>
          <td align="center">
            <table role="presentation" width="560" style="background:#ffffff;border-radius:20px;box-shadow:0 15px 35px rgba(15,118,110,.12);overflow:hidden;">
              <tr>
                <td style="background:linear-gradient(120deg,#0f766e,#14b8a6);padding:32px;color:#fff;text-align:center;">
                  <div style="font-size:32px;font-weight:700;margin-bottom:8px;">CapyChina</div>
                  <div style="font-size:16px;opacity:.9;">Kích hoạt tài khoản học tiếng Trung</div>
                </td>
              </tr>
              <tr>
                <td style="padding:36px 40px;color:#111827;">
                  <h2 style="margin:0;font-size:20px;color:#0f172a;">Chào mừng bạn!</h2>
                  <p style="margin:12px 0 24px;font-size:15px;line-height:1.7;">
                    Cảm ơn bạn đã đăng ký CapyChina. Vui lòng nhập mã xác thực bên dưới để kích hoạt tài khoản.
                  </p>
                  <div style="background:#f0fdfa;border-radius:16px;padding:24px;text-align:center;">
                    <div style="color:#0f766e;font-size:14px;text-transform:uppercase;letter-spacing:.4em;">Mã xác thực</div>
                    <div style="font-size:36px;font-weight:700;letter-spacing:.35em;margin-top:12px;color:#0f172a;">${code}</div>
                    <div style="margin-top:12px;font-size:13px;color:#0f766e;">Hết hạn lúc ${formattedExpires} (sau 5 phút)</div>
                  </div>
                  <p style="margin:24px 0;font-size:14px;color:#475467;line-height:1.7;">
                    Nếu bạn không yêu cầu đăng ký, có thể bỏ qua email này. Vui lòng không chia sẻ mã với bất kỳ ai để đảm bảo an toàn tài khoản.
                  </p>
                  <p style="margin:0;font-size:14px;color:#0f172a;">
                    Thân mến,<br/>
                    <strong>Đội ngũ CapyChina</strong>
                  </p>
                </td>
              </tr>
            </table>
            <p style="color:#94a3b8;font-size:12px;margin-top:24px;">© ${new Date().getFullYear()} CapyChina. All rights reserved.</p>
          </td>
        </tr>
      </table>
    `;

    try {
      await this.transporter.sendMail({
        to,
        from: `"${this.fromName}" <${this.fromAddress}>`,
        subject: 'CapyChina - Xác thực tài khoản',
        html,
      });
    } catch (error) {
      this.logger.error(
        `Gửi email xác thực thất bại đến ${to}: ${String(error)}`,
      );
    }
  }

  async sendPasswordReset(
    to: string,
    code: string,
    expiresAt: Date,
  ): Promise<void> {
    const formatted = expiresAt.toLocaleString('vi-VN', {
      hour: '2-digit',
      minute: '2-digit',
      day: '2-digit',
      month: '2-digit',
    });

    const html = `
      <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background:#eef2ff;padding:24px 0;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;">
        <tr>
          <td align="center">
            <table role="presentation" width="560" style="background:#ffffff;border-radius:20px;box-shadow:0 15px 45px rgba(79,70,229,.18);overflow:hidden;">
              <tr>
                <td style="background:linear-gradient(120deg,#4338ca,#6366f1);padding:32px;color:#fff;text-align:center;">
                  <div style="font-size:28px;font-weight:700;margin-bottom:6px;">CapyChina</div>
                  <div style="font-size:15px;opacity:.85;">Yêu cầu đặt lại mật khẩu</div>
                </td>
              </tr>
              <tr>
                <td style="padding:36px 40px;color:#111827;">
                  <p style="margin:0 0 18px;font-size:15px;line-height:1.6;">
                    Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Nhập mã OTP bên dưới và tạo mật khẩu mới để tiếp tục.
                  </p>
                  <div style="background:#eef2ff;border-radius:16px;padding:24px;text-align:center;margin-bottom:24px;">
                    <div style="color:#4338ca;font-size:13px;text-transform:uppercase;letter-spacing:.4em;">OTP đặt lại mật khẩu</div>
                    <div style="font-size:36px;font-weight:700;letter-spacing:.35em;margin-top:12px;color:#111827;">${code}</div>
                    <div style="margin-top:10px;font-size:13px;color:#4338ca;">Hết hạn lúc ${formatted}</div>
                  </div>
                  <p style="margin:0 0 18px;font-size:14px;color:#475467;">
                    Nếu bạn không yêu cầu thao tác này, hãy bỏ qua email hoặc liên hệ với chúng tôi để được hỗ trợ.
                  </p>
                  <p style="margin:0;font-size:14px;color:#111827;">Trân trọng,<br/><strong>CapyChina Team</strong></p>
                </td>
              </tr>
            </table>
            <p style="color:#94a3b8;font-size:12px;margin-top:24px;">© ${new Date().getFullYear()} CapyChina</p>
          </td>
        </tr>
      </table>
    `;

    try {
      await this.transporter.sendMail({
        to,
        from: `"${this.fromName}" <${this.fromAddress}>`,
        subject: 'CapyChina - Đặt lại mật khẩu',
        html,
      });
    } catch (error) {
      this.logger.error(`Gửi email đặt lại mật khẩu thất bại: ${String(error)}`);
    }
  }
}

