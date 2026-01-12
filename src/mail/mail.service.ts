import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios';

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);
  private readonly fromAddress: string;
  private readonly fromName: string;
  private readonly brevoApiKey: string;

  constructor(private readonly configService: ConfigService) {
    this.fromName = this.configService.get<string>('MAIL_FROM_NAME') ?? 'CapyChina';
    this.fromAddress = this.configService.get<string>('MAIL_FROM') ?? 'no-reply@capychina.app';
    
    // Lấy BREVO_API_KEY và strip quotes nếu có
    let brevoApiKey = this.configService.get<string>('BREVO_API_KEY') ?? '';
    if (brevoApiKey) {
      if ((brevoApiKey.startsWith('"') && brevoApiKey.endsWith('"')) || (brevoApiKey.startsWith("'") && brevoApiKey.endsWith("'"))) {
        brevoApiKey = brevoApiKey.slice(1, -1);
      }
      // Trim whitespace
      brevoApiKey = brevoApiKey.trim();
    }
    this.brevoApiKey = brevoApiKey;

    this.logger.log(`📧 MailService initializing with Brevo Email API`);

    if (!this.brevoApiKey) {
      this.logger.error('❌ BREVO_API_KEY chưa được cấu hình - email sẽ KHÔNG được gửi!');
      this.logger.error('❌ Vui lòng set BREVO_API_KEY trong environment variables');
    } else {
      // Validate API key format (should start with xkeysib-)
      if (!this.brevoApiKey.startsWith('xkeysib-')) {
        this.logger.warn(`⚠️  BREVO_API_KEY có vẻ không đúng format (nên bắt đầu bằng 'xkeysib-')`);
      }
      this.logger.log(`📧 Brevo API Key: ***${this.brevoApiKey.slice(-4)} (length: ${this.brevoApiKey.length})`);
      this.logger.log(`📧 From: ${this.fromAddress}`);
      this.logger.log(`📧 From Name: ${this.fromName}`);
    }

    this.logger.log(`✅ MailService initialized with Brevo Email API`);
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

    // Gửi email bằng Brevo API
    await this.sendWithBrevo(to, 'CapyChina - Xác thực tài khoản', html);
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

    // Gửi email bằng Brevo API
    await this.sendWithBrevo(to, 'CapyChina - Đặt lại mật khẩu', html);
  }

  private async sendWithBrevo(to: string, subject: string, html: string): Promise<void> {
    // Kiểm tra API key trước khi gửi
    if (!this.brevoApiKey) {
      this.logger.error('❌ BREVO_API_KEY chưa được cấu hình - không thể gửi email');
      return;
    }

    // Retry logic: thử gửi tối đa 3 lần
    let lastError: Error | null = null;
    const maxAttempts = 3;
    
    for (let attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        const res = await axios.post(
          'https://api.brevo.com/v3/smtp/email',
          {
            sender: {
              email: this.fromAddress,
              name: this.fromName,
            },
            to: [{ email: to }],
            subject,
            htmlContent: html,
          },
          {
            headers: {
              'api-key': this.brevoApiKey,
              'Content-Type': 'application/json',
            },
            timeout: 10000,
          },
        );

        this.logger.log(`✅ Email đã được gửi thành công qua Brevo đến ${to} (attempt ${attempt}/${maxAttempts})`);
        return; // Thành công, thoát
      } catch (error: any) {
        lastError = error instanceof Error ? error : new Error(String(error));
        
        // Extract error message chi tiết từ Brevo response
        let errorMessage = error.message;
        let errorDetails = '';
        
        if (error.response) {
          const status = error.response.status;
          const statusText = error.response.statusText;
          const data = error.response.data;
          
          errorMessage = `HTTP ${status} ${statusText}`;
          
          if (data) {
            if (typeof data === 'string') {
              errorDetails = data;
            } else if (data.message) {
              errorDetails = data.message;
            } else if (data.error) {
              errorDetails = typeof data.error === 'string' ? data.error : JSON.stringify(data.error);
            } else {
              errorDetails = JSON.stringify(data);
            }
          }
          
          // Log chi tiết cho 401 (Unauthorized)
          if (status === 401) {
            this.logger.error(`❌ Brevo API 401 Unauthorized - Kiểm tra lại BREVO_API_KEY`);
            this.logger.error(`   - API Key length: ${this.brevoApiKey.length}`);
            this.logger.error(`   - API Key starts with 'xkeysib-': ${this.brevoApiKey.startsWith('xkeysib-')}`);
            this.logger.error(`   - Response: ${errorDetails || 'No details'}`);
          }
          
          // Log chi tiết cho 403 (Forbidden - Account not activated)
          if (status === 403) {
            this.logger.error(`❌ Brevo API 403 Forbidden - Tài khoản Brevo chưa được kích hoạt!`);
            this.logger.error(`   - Vào Brevo Dashboard để verify email và activate account`);
            this.logger.error(`   - Hoặc liên hệ: contact@brevo.com`);
            this.logger.error(`   - Response: ${errorDetails || 'No details'}`);
          }
        }
        
        const fullErrorMessage = errorDetails ? `${errorMessage}: ${errorDetails}` : errorMessage;
        
        if (attempt < maxAttempts) {
          // Exponential backoff: 2s, 4s
          const delayMs = Math.min(2000 * Math.pow(2, attempt - 1), 4000);
          this.logger.warn(
            `⚠️  Gửi email qua Brevo thất bại (attempt ${attempt}/${maxAttempts}) đến ${to}: ${fullErrorMessage}. Đang thử lại sau ${delayMs}ms...`,
          );
          await new Promise((resolve) => setTimeout(resolve, delayMs));
        } else {
          // Lần thử cuối cùng thất bại
          this.logger.error(
            `❌ Gửi email qua Brevo thất bại đến ${to} sau ${maxAttempts} lần thử: ${fullErrorMessage}`,
          );
          if (lastError.stack) {
            this.logger.error(`Stack trace: ${lastError.stack}`);
          }
        }
      }
    }
    // Không throw error để không làm gián đoạn flow (code đã được save trong DB)
  }
}
