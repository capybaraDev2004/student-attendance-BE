# 🔧 Fix Lỗi Mail Timeout trên Render

## 🚨 Lỗi hiện tại:

```
[Nest] ERROR [MailService] Gửi email xác thực thất bại đến ...@gmail.com: Error: Connection timeout
```

## ✅ Giải pháp đã áp dụng:

### 1. Cập nhật MailService với timeout configuration

Code đã được cập nhật trong `src/mail/mail.service.ts` với:
- ✅ Tăng timeout settings (60 giây cho connection và socket)
- ✅ Sử dụng explicit SMTP configuration (host, port) thay vì chỉ `service: 'gmail'`
- ✅ Cải thiện error logging để debug dễ hơn

### 2. Cấu hình Gmail App Password

**QUAN TRỌNG:** Gmail không cho phép dùng mật khẩu thường từ ứng dụng. Bạn **PHẢI** dùng **App Password**.

#### Các bước tạo Gmail App Password:

1. **Bật 2-Step Verification:**
   - Vào https://myaccount.google.com/security
   - Bật "2-Step Verification" nếu chưa bật

2. **Tạo App Password:**
   - Vào https://myaccount.google.com/apppasswords
   - Hoặc vào Security → 2-Step Verification → App passwords
   - Chọn "Mail" và "Other (Custom name)"
   - Nhập tên: "CapyChina Backend"
   - Click "Generate"
   - Copy mật khẩu 16 ký tự (dạng: `xxxx xxxx xxxx xxxx`)

3. **Cập nhật Environment Variable trên Render:**
   - Vào Render Dashboard → Web Service → Environment
   - Tìm biến `MAIL_PASS`
   - Thay thế bằng App Password vừa tạo (bỏ khoảng trắng: `xxxxxxxxxxxxxxxx`)
   - Save và redeploy

### 3. Kiểm tra Environment Variables

Đảm bảo các biến sau được cấu hình đúng trên Render:

```
MAIL_USER=nguyentientoan28022004@gmail.com
MAIL_PASS=<App Password 16 ký tự, không có khoảng trắng>
MAIL_FROM_NAME=CapyChina
```

⚠️ **Lưu ý:**
- `MAIL_PASS` phải là App Password, KHÔNG phải mật khẩu Gmail thường
- App Password không có khoảng trắng (nếu copy có khoảng, phải bỏ đi)
- App Password có 16 ký tự

### 4. Cấu hình Firewall/Network (nếu vẫn timeout)

Nếu vẫn gặp timeout sau khi dùng App Password:

1. **Kiểm tra port:**
   - Code đang dùng port 587 (TLS)
   - Có thể thử port 465 (SSL) nếu 587 bị block

2. **Kiểm tra network từ Render:**
   - Render có thể block outbound connections
   - Kiểm tra Render logs xem có network errors không

3. **Alternative: Dùng dịch vụ email khác:**
   - SendGrid (free tier: 100 emails/day)
   - Mailgun (free tier: 5,000 emails/month)
   - Amazon SES (pay as you go)
   - Resend (free tier: 3,000 emails/month)

## 📋 Checklist:

- [ ] Đã bật 2-Step Verification trên Gmail
- [ ] Đã tạo App Password mới
- [ ] Đã cập nhật `MAIL_PASS` trên Render với App Password (không có khoảng trắng)
- [ ] Đã save và redeploy service
- [ ] Đã kiểm tra logs - không còn lỗi timeout
- [ ] Đã test gửi email thành công

## 🔍 Debug:

Nếu vẫn còn lỗi sau khi làm theo các bước trên:

1. **Kiểm tra logs trên Render:**
   - Xem error message chi tiết
   - Kiểm tra xem có kết nối được đến smtp.gmail.com không

2. **Test connection:**
   ```bash
   # Trong Render Shell
   telnet smtp.gmail.com 587
   # Hoặc
   nc -zv smtp.gmail.com 587
   ```

3. **Kiểm tra App Password:**
   - Đảm bảo copy đúng (16 ký tự, không có khoảng)
   - Nếu sai, tạo App Password mới

4. **Xem code đã deploy:**
   - Đảm bảo code mới đã được deploy (có timeout settings)

## 🎯 Code Changes:

File `src/mail/mail.service.ts` đã được cập nhật với:
- Explicit SMTP host/port configuration
- Timeout settings: 60s connection, 30s greeting, 60s socket
- Improved error logging với stack trace
- Success logging để track email được gửi thành công
