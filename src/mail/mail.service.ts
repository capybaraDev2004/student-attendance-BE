import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);
  private readonly fromAddress: string;
  private readonly fromName: string;
  private transporter: nodemailer.Transporter;
  private readonly smtpConfig: {
    host: string;
    port: number;
    secure: boolean;
    auth?: { user: string; pass: string };
    connectionTimeout: number;
    greetingTimeout: number;
    socketTimeout: number;
    tls: { rejectUnauthorized: boolean; minVersion: string };
    requireTLS: boolean;
    pool: boolean;
    maxConnections: number;
    maxMessages: number;
    debug: boolean;
    logger: boolean;
  };

  constructor(private readonly configService: ConfigService) {
    this.fromName = this.configService.get<string>('MAIL_FROM_NAME') ?? 'CapyChina';

    this.logger.log(`📧 MailService initializing with Gmail SMTP`);

    // Sử dụng các biến SMTP_* từ .env
    const smtpHost = this.configService.get<string>('SMTP_HOST') || 'smtp.gmail.com';
    const smtpPort = parseInt(this.configService.get<string>('SMTP_PORT') || '587', 10);
    const smtpUser = this.configService.get<string>('SMTP_USER');
    let smtpPass = this.configService.get<string>('SMTP_PASS');
    const useSSL = this.configService.get<string>('MAIL_USE_SSL') === 'true';
    
    // Strip quotes nếu có (một số env var có thể có quotes)
    if (smtpPass) {
      if ((smtpPass.startsWith('"') && smtpPass.endsWith('"')) || (smtpPass.startsWith("'") && smtpPass.endsWith("'"))) {
        smtpPass = smtpPass.slice(1, -1);
      }
    }

    if (!smtpUser || !smtpPass) {
      this.logger.error('❌ SMTP_USER hoặc SMTP_PASS chưa được cấu hình - email sẽ KHÔNG được gửi!');
      this.logger.error('❌ Vui lòng set SMTP_USER và SMTP_PASS trong environment variables');
    } else {
      this.logger.log(`📧 SMTP Host: ${smtpHost}`);
      this.logger.log(`📧 SMTP Port: ${smtpPort}`);
      this.logger.log(`📧 SMTP User: ${smtpUser}`);
      this.logger.log(`📧 SMTP Pass: ***${smtpPass.slice(-4)}`);
    }

    this.fromAddress = smtpUser ?? 'no-reply@capychina.app';

    // Xác định secure dựa trên port (465 = SSL, 587 = STARTTLS) hoặc MAIL_USE_SSL
    const secure = useSSL || smtpPort === 465;
    
    // Lưu config để có thể recreate transporter khi retry
    this.smtpConfig = {
      host: smtpHost,
      port: smtpPort,
      secure: secure,
      auth: smtpUser && smtpPass ? { user: smtpUser, pass: smtpPass } : undefined,
      connectionTimeout: 60000, // 60 seconds
      greetingTimeout: 30000, // 30 seconds
      socketTimeout: 60000, // 60 seconds
      tls: {
        rejectUnauthorized: true,
        minVersion: 'TLSv1.2',
      },
      requireTLS: !secure,
      pool: false, // Tắt pool để tránh connection timeout issues trên Render
      maxConnections: 1,
      maxMessages: 1,
      debug: process.env.NODE_ENV === 'development',
      logger: process.env.NODE_ENV === 'development',
    };
    
    this.transporter = nodemailer.createTransport(this.smtpConfig);

    this.logger.log(`✅ MailService initialized with Gmail SMTP`);
    this.logger.log(`   - Host: ${smtpHost}`);
    this.logger.log(`   - Port: ${smtpPort} (${secure ? 'SSL' : 'STARTTLS'})`);
    this.logger.log(`   - From: ${this.fromAddress}`);
    
    // Chỉ verify connection trong development (tránh timeout trên production)
    const isDevelopment = process.env.NODE_ENV === 'development';
    if (smtpUser && smtpPass && isDevelopment) {
      this.verifyConnectionWithTimeout().catch((error) => {
        this.logger.warn(
          `⚠️  SMTP connection verification failed (will retry on send): ${error instanceof Error ? error.message : String(error)}`,
        );
      });
    } else if (smtpUser && smtpPass && !isDevelopment) {
      this.logger.log(`📧 SMTP connection will be verified on first email send (skipping startup verification in production)`);
    }
  }

  // Verify SMTP connection với timeout
  private async verifyConnectionWithTimeout(): Promise<void> {
    try {
      // Verify với timeout 15 giây (tăng từ 10s để tránh timeout trên mạng chậm)
      const verifyPromise = this.transporter.verify();
      const timeoutPromise = new Promise<never>((_, reject) => {
        setTimeout(() => reject(new Error('Verification timeout after 15s')), 15000);
      });
      
      await Promise.race([verifyPromise, timeoutPromise]);
      this.logger.log('✅ SMTP connection verified successfully');
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : String(error);
      // Chỉ log warning, không throw - connection sẽ được test khi gửi email
      if (errorMessage.includes('timeout')) {
        this.logger.warn(`⚠️  SMTP verification timeout (this is OK, connection will be tested when sending email)`);
      } else {
        this.logger.warn(`⚠️  SMTP verification failed: ${errorMessage}`);
        this.logger.warn(`⚠️  Connection will be tested when sending email.`);
      }
    }
  }

  // Gửi email trong background (không block)
  sendEmailVerificationAsync(
    to: string,
    code: string,
    expiresAt: Date,
  ): void {
    // Chạy trong background, không await
    this.sendEmailVerification(to, code, expiresAt).catch((error) => {
      this.logger.error(
        `Background email send failed for ${to}: ${error instanceof Error ? error.message : String(error)}`,
      );
    });
  }

  async sendEmailVerification(
    to: string,
    code: string,
    expiresAt: Date,
  ): Promise<void> {
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

    // Gửi email bằng Gmail SMTP
    await this.sendWithGmail(to, 'CapyChina - Xác thực tài khoản', html);
  }

  private async sendWithGmail(to: string, subject: string, html: string): Promise<void> {
    // Retry logic: thử gửi tối đa 3 lần với exponential backoff
    let lastError: Error | null = null;
    const maxAttempts = 3;
    
    for (let attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        // Recreate transporter nếu retry (để tránh dùng connection cũ bị timeout)
        if (attempt > 1) {
          this.logger.log(`🔄 Recreating SMTP connection for attempt ${attempt}...`);
          try {
            this.transporter.close();
          } catch (e) {
            // Ignore errors khi close
          }
          // Tạo transporter mới
          this.transporter = nodemailer.createTransport(this.smtpConfig);
        }
        
        await this.transporter.sendMail({
          to,
          from: `"${this.fromName}" <${this.fromAddress}>`,
          subject,
          html,
        });
        this.logger.log(`✅ Email đã được gửi thành công qua Gmail đến ${to} (attempt ${attempt}/${maxAttempts})`);
        return; // Thành công, thoát
      } catch (error) {
        lastError = error instanceof Error ? error : new Error(String(error));
        const errorMessage = lastError.message;
        const errorCode = (lastError as any).code;
        
        // Kiểm tra nếu là timeout error
        const isTimeout = errorMessage.includes('timeout') || errorMessage.includes('ETIMEDOUT') || errorCode === 'ETIMEDOUT';
        
        if (attempt < maxAttempts) {
          // Exponential backoff: 3s, 6s (tăng delay cho timeout errors)
          const baseDelay = isTimeout ? 3000 : 2000;
          const delayMs = Math.min(baseDelay * Math.pow(2, attempt - 1), 6000);
          this.logger.warn(
            `⚠️  Gửi email qua Gmail thất bại (attempt ${attempt}/${maxAttempts}) đến ${to}: ${errorMessage}${errorCode ? ` [${errorCode}]` : ''}. Đang thử lại sau ${delayMs}ms...`,
          );
          await new Promise((resolve) => setTimeout(resolve, delayMs));
        } else {
          // Lần thử cuối cùng thất bại
          this.logger.error(
            `❌ Gửi email qua Gmail thất bại đến ${to} sau ${maxAttempts} lần thử: ${errorMessage}${errorCode ? ` [${errorCode}]` : ''}`,
          );
          if (isTimeout) {
            this.logger.error(`❌ Connection timeout - Có thể Render block SMTP hoặc mạng quá chậm. Xem xét dùng dịch vụ email API-based (Resend/SendGrid).`);
          }
          if (lastError.stack) {
            this.logger.error(`Stack trace: ${lastError.stack}`);
          }
        }
      }
    }
    // Không throw error để không làm gián đoạn flow (code đã được save trong DB)
  }

  // Gửi email reset password trong background (không block)
  sendPasswordResetAsync(
    to: string,
    code: string,
    expiresAt: Date,
  ): void {
    // Chạy trong background, không await
    this.sendPasswordReset(to, code, expiresAt).catch((error) => {
      this.logger.error(
        `Background password reset email send failed for ${to}: ${error instanceof Error ? error.message : String(error)}`,
      );
    });
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

    // Gửi email bằng Gmail SMTP
    await this.sendWithGmail(to, 'CapyChina - Đặt lại mật khẩu', html);
  }

}

