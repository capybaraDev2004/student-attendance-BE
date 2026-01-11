# 🔧 Fix Hoàn Chỉnh Lỗi Mail - Background Job + Connection Timeout

## 🚨 Vấn đề đã fix:

1. ✅ **Frontend bị stuck** - Email đang chạy blocking, giờ đã chuyển sang background job
2. ✅ **Connection timeout** - Cải thiện SMTP config với retry logic và timeout tối ưu

## ✅ Thay đổi đã thực hiện:

### 1. Background Job cho Email

**File: `src/auth/auth.service.ts`**
- `dispatchVerification()` và `dispatchResetCode()` giờ gọi `sendEmailVerificationAsync()` và `sendPasswordResetAsync()`
- Không còn `await` email, response trả về ngay lập tức
- Email được gửi trong background, không block user

**File: `src/mail/mail.service.ts`**
- Thêm methods `sendEmailVerificationAsync()` và `sendPasswordResetAsync()` 
- Chạy email trong background với `.catch()` để handle errors
- User không phải chờ email gửi xong

### 2. Cải thiện SMTP Configuration

**Timeout Settings:**
- `connectionTimeout: 30000` (30s) - Giảm từ 60s để fail nhanh hơn
- `greetingTimeout: 15000` (15s)
- `socketTimeout: 30000` (30s)

**Retry Logic:**
- Tự động retry 2 lần nếu gửi thất bại
- Đợi 2 giây giữa các lần thử
- Log chi tiết từng attempt

**Port Configuration:**
- Mặc định: Port 587 (TLS)
- Có thể dùng Port 465 (SSL) bằng cách set `MAIL_USE_SSL=true`

### 3. Connection Verification

- Tự động verify SMTP connection khi khởi tạo
- Log warning nếu verification fail (nhưng không block app)
- Sẽ retry khi gửi email thực tế

## 🔧 Cấu hình Environment Variables trên Render:

### Bắt buộc:

```
MAIL_USER=nguyentientoan28022004@gmail.com
MAIL_PASS=<Gmail App Password - 16 ký tự, không có khoảng trắng>
MAIL_FROM_NAME=CapyChina
```

### Tùy chọn:

```
MAIL_USE_SSL=true  # Nếu muốn dùng port 465 (SSL) thay vì 587 (TLS)
```

## 📋 Các bước để fix lỗi mail hoàn toàn:

### Bước 1: Tạo Gmail App Password

**QUAN TRỌNG:** Gmail không cho phép dùng mật khẩu thường. Phải dùng App Password.

1. Vào https://myaccount.google.com/security
2. Bật **2-Step Verification** (nếu chưa bật)
3. Vào https://myaccount.google.com/apppasswords
4. Chọn:
   - App: "Mail"
   - Device: "Other (Custom name)"
   - Tên: "CapyChina Backend"
5. Click "Generate"
6. Copy mật khẩu 16 ký tự (dạng: `xxxx xxxx xxxx xxxx`)
7. **Bỏ tất cả khoảng trắng** → `xxxxxxxxxxxxxxxx`

### Bước 2: Cập nhật trên Render

1. Vào Render Dashboard → Web Service → Environment
2. Cập nhật `MAIL_PASS` với App Password (không có khoảng trắng)
3. (Tùy chọn) Thêm `MAIL_USE_SSL=true` nếu port 587 bị block
4. Save và redeploy

### Bước 3: Kiểm tra Logs

Sau khi deploy, kiểm tra logs:

**Nếu thành công:**
```
✅ SMTP connection verified successfully
✅ Email xác thực đã được gửi thành công đến ...
```

**Nếu vẫn lỗi:**
```
❌ Gửi email xác thực thất bại đến ... sau 2 lần thử: Connection timeout
```

### Bước 4: Troubleshooting

#### Nếu vẫn timeout với port 587:

1. **Thử port 465 (SSL):**
   - Thêm `MAIL_USE_SSL=true` vào Environment Variables
   - Redeploy

2. **Kiểm tra network từ Render:**
   - Render có thể block outbound connections
   - Kiểm tra logs xem có network errors không

3. **Kiểm tra App Password:**
   - Đảm bảo copy đúng (16 ký tự, không có khoảng)
   - Nếu sai, tạo App Password mới

#### Nếu vẫn không được:

**Alternative: Dùng dịch vụ email khác**

1. **SendGrid** (Free: 100 emails/day)
   - Dễ setup, API đơn giản
   - Cần update code để dùng SendGrid API

2. **Resend** (Free: 3,000 emails/month)
   - Modern API, dễ dùng
   - Cần update code

3. **Mailgun** (Free: 5,000 emails/month)
   - SMTP hoặc API
   - Có thể dùng SMTP với config tương tự

## 🎯 Code Flow Mới:

### Trước (Blocking):
```
User Register → Save Code → Wait Email → Response (chậm, có thể timeout)
```

### Sau (Non-blocking):
```
User Register → Save Code → Response (ngay lập tức)
                    ↓
            Background: Send Email (không block)
```

## ✅ Checklist:

- [ ] Đã bật 2-Step Verification trên Gmail
- [ ] Đã tạo Gmail App Password
- [ ] Đã cập nhật `MAIL_PASS` trên Render (không có khoảng trắng)
- [ ] Đã save và redeploy service
- [ ] Đã test đăng ký - response nhanh, không bị stuck
- [ ] Đã kiểm tra logs - email gửi thành công
- [ ] Đã test nhận email xác thực

## 🔍 Debug Commands:

Nếu cần debug trên Render Shell:

```bash
# Test SMTP connection
telnet smtp.gmail.com 587
# Hoặc
nc -zv smtp.gmail.com 587

# Test với port 465
telnet smtp.gmail.com 465
```

## 📝 Notes:

- Email giờ chạy background, user không phải chờ
- Nếu email fail, code vẫn được save trong DB (user có thể resend)
- Retry tự động 2 lần trước khi fail
- Logs chi tiết để debug dễ dàng
