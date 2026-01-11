# 🚀 Setup Resend - Giải pháp Fix Lỗi Mail trên Render

## ✅ Tại sao dùng Resend?

- ✅ **Không bị block bởi firewall** - Dùng REST API, không cần SMTP
- ✅ **Free tier tốt** - 3,000 emails/month
- ✅ **Setup đơn giản** - Chỉ cần API key
- ✅ **Reliable** - Uptime 99.9%
- ✅ **Dashboard tốt** - Xem logs, analytics

## 📋 Các bước setup:

### Bước 1: Tạo tài khoản Resend

1. Vào https://resend.com
2. Click **"Get Started"** hoặc **"Sign Up"**
3. Có thể đăng ký bằng:
   - Email
   - Google account (khuyến nghị)
4. Verify email nếu cần

### Bước 2: Tạo API Key

1. Sau khi đăng nhập, vào **Dashboard**
2. Click **"API Keys"** ở sidebar (hoặc vào https://resend.com/api-keys)
3. Click **"Create API Key"**
4. Đặt tên: `CapyChina Backend`
5. Chọn permissions: **"Sending access"**
6. Click **"Add"**
7. **Copy API Key ngay** (chỉ hiện 1 lần, format: `re_xxxxxxxxxxxxxxxxxx`)

### Bước 3: Cấu hình trên Render

1. Vào **Render Dashboard** → **Web Service** → **Environment**
2. Thêm/sửa các biến sau:

```
MAIL_PROVIDER=resend
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxx  (API key vừa copy)
RESEND_FROM_EMAIL=onboarding@resend.dev  (hoặc email đã verify)
MAIL_FROM_NAME=CapyChina
```

**Lưu ý:**
- `RESEND_FROM_EMAIL`: 
  - Có thể dùng `onboarding@resend.dev` để test (free, không cần verify)
  - Hoặc verify domain của bạn để dùng custom email (ví dụ: `noreply@yourdomain.com`)

3. **Save** changes
4. **Redeploy** service

### Bước 4: Verify Domain (Tùy chọn - để dùng custom email)

Nếu muốn dùng email từ domain của bạn (ví dụ: `noreply@capychina.app`):

1. Vào Resend Dashboard → **Domains**
2. Click **"Add Domain"**
3. Nhập domain (ví dụ: `capychina.app`)
4. Thêm DNS records vào domain registrar:
   - TXT record (SPF)
   - CNAME records (DKIM)
   - TXT record (DMARC)
5. Đợi verify (thường vài phút)
6. Sau khi verified, cập nhật `RESEND_FROM_EMAIL` với email từ domain này

## 🎯 Environment Variables Summary:

### Bắt buộc (Resend):
```
MAIL_PROVIDER=resend
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxx
RESEND_FROM_EMAIL=onboarding@resend.dev
MAIL_FROM_NAME=CapyChina
```

### Không cần nữa (Gmail):
```
# Có thể xóa hoặc giữ lại nếu muốn switch về Gmail sau
# MAIL_USER=...
# MAIL_PASS=...
# MAIL_USE_SSL=...
```

## ✅ Test sau khi deploy:

1. **Kiểm tra logs:**
   ```
   ✅ MailService initialized with Resend (API-based)
   ✅ Email đã được gửi thành công qua Resend đến ... (ID: ...)
   ```

2. **Test đăng ký:**
   - Đăng ký tài khoản mới
   - Response nhanh, không bị stuck
   - Kiểm tra email inbox

3. **Kiểm tra Resend Dashboard:**
   - Vào https://resend.com/emails
   - Xem email logs, status (delivered, bounced, etc.)

## 🔄 Switch về Gmail (nếu cần):

Nếu muốn dùng Gmail lại (không khuyến nghị vì có thể bị block):

1. Cập nhật env:
   ```
   MAIL_PROVIDER=gmail
   MAIL_USER=your-email@gmail.com
   MAIL_PASS=your-app-password
   ```

2. Redeploy

## 🎉 Kết quả:

- ✅ Email gửi thành công 100%
- ✅ Không còn connection timeout
- ✅ Response nhanh, không block user
- ✅ Free tier đủ cho hầu hết use cases

## 📚 Tài liệu tham khảo:

- Resend Docs: https://resend.com/docs
- API Reference: https://resend.com/docs/api-reference
- Domain Setup: https://resend.com/docs/dashboard/domains/introduction
