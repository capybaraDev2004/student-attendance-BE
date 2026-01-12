# 🥇 Hướng dẫn setup Brevo (Sendinblue) Email API

## ✅ Đã hoàn thành

- ✅ Cài đặt `axios` package
- ✅ Cập nhật `MailService` để dùng Brevo API
- ✅ Giữ nguyên các method `sendEmailVerification` và `sendPasswordReset`
- ✅ Retry logic (3 lần thử)
- ✅ Background job (không block response)

## 📋 Environment Variables cần set trên Render

Vào **Render Dashboard → Service → Environment** và thêm:

```env
BREVO_API_KEY=xkeysib-1234567890abcdef
MAIL_FROM=nguyentientoan28022004@gmail.com
MAIL_FROM_NAME=CapyChina
```

### Giải thích:

- **BREVO_API_KEY**: API key từ Brevo dashboard (bắt đầu bằng `xkeysib-`)
- **MAIL_FROM**: Email gửi đi (có thể dùng Gmail, Brevo sẽ cho phép)
- **MAIL_FROM_NAME**: Tên hiển thị khi gửi email

## 🔑 Cách lấy BREVO_API_KEY

1. Đăng ký tài khoản tại: https://www.brevo.com/
2. Login vào dashboard
3. Vào: **SMTP & API → API Keys**
4. Click **Create a new API key**
5. Name: `NestJS Render`
6. Copy key (chỉ hiện 1 lần!)

## ⚠️ Fix lỗi "sender not allowed" (nếu gặp)

Nếu Brevo báo lỗi sender:

1. Vào: **Settings → Senders → Add a sender**
2. Add email bạn dùng trong `MAIL_FROM`
3. Verify email

## 🚀 Ưu điểm

- ✅ Không timeout (HTTP API thay vì SMTP)
- ✅ Hoạt động tốt trên Render, Vercel, Railway...
- ✅ Free 300 email / ngày
- ✅ Nhanh và ổn định
- ✅ Không cần cấu hình SMTP phức tạp

## 📝 Lưu ý

- Code đã tự động retry 3 lần nếu gửi thất bại
- Email được gửi trong background (không block response)
- Logs sẽ hiển thị khi gửi thành công/thất bại
