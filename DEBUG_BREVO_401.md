# 🔧 Debug lỗi Brevo API (401, 403)

## ❌ Lỗi thường gặp

### 1. Lỗi 401 Unauthorized
```
Request failed with status code 401 (Unauthorized)
```

### 2. Lỗi 403 Forbidden
```
HTTP 403 Forbidden: Unable to send email. Your SMTP account is not yet activated.
```

## 🔍 Nguyên nhân

### Lỗi 401:
1. **API Key không đúng hoặc chưa được set**
2. **API Key có quotes hoặc whitespace thừa**
3. **API Key không có quyền gửi email**
4. **API Key đã bị revoke hoặc expired**

### Lỗi 403:
1. **Tài khoản Brevo chưa được kích hoạt**
2. **Email chưa được verify**
3. **Sender email chưa được verify**
4. **Account đang trong trạng thái pending**

## ✅ Cách fix

### 1. Kiểm tra BREVO_API_KEY trên Render

Vào **Render Dashboard → Service → Environment** và kiểm tra:

```env
BREVO_API_KEY=xkeysib-1234567890abcdef
```

**Lưu ý:**
- ✅ Không có quotes: `xkeysib-...`
- ❌ Không đúng: `"xkeysib-..."` hoặc `'xkeysib-...'`
- ✅ Không có space ở đầu/cuối
- ✅ Phải bắt đầu bằng `xkeysib-`

### 2. Lấy API Key mới từ Brevo

1. Login vào Brevo: https://www.brevo.com/
2. Vào: **SMTP & API → API Keys**
3. Xóa API key cũ (nếu có)
4. Click **Create a new API key**
5. Name: `NestJS Render`
6. **Permissions**: Chọn **Send emails** (quan trọng!)
7. Copy key mới
8. Paste vào Render environment variables

### 3. Kiểm tra logs sau khi deploy

Sau khi deploy, kiểm tra logs để xem:

```
📧 Brevo API Key: ***xxxx (length: XX)
```

- Length phải > 20 (thường là 40-50 ký tự)
- Phải bắt đầu bằng `xkeysib-`

### 4. Kiểm tra sender email

Nếu vẫn lỗi 401, có thể do sender email chưa được verify:

1. Vào Brevo: **Settings → Senders → Add a sender**
2. Add email bạn dùng trong `MAIL_FROM`
3. Verify email (check inbox và click link)

## 🔴 Fix lỗi 403 (Account not activated)

### Cách 1: Verify Email trong Brevo Dashboard

1. Login vào Brevo: https://www.brevo.com/
2. Check email inbox để verify tài khoản
3. Click link verify trong email từ Brevo
4. Đăng nhập lại vào Brevo dashboard

### Cách 2: Verify Sender Email

1. Vào Brevo: **Settings → Senders**
2. Click **Add a sender**
3. Nhập email bạn dùng trong `MAIL_FROM` (ví dụ: `nguyentientoan28022004@gmail.com`)
4. Click **Save**
5. Check email inbox và click link verify
6. Đợi vài phút để Brevo activate

### Cách 3: Activate Account trong Dashboard

1. Vào Brevo Dashboard
2. Check xem có notification nào về "Account activation" không
3. Click vào và follow instructions
4. Có thể cần verify phone number hoặc identity

### Cách 4: Liên hệ Support

Nếu vẫn không được:

1. Email: contact@brevo.com
2. Subject: "Request account activation"
3. Nội dung: "Hi, I need to activate my Brevo account to send transactional emails via API. My email: [your-email]"

### Cách 5: Dùng Transactional API thay vì SMTP API

Nếu SMTP API không hoạt động, có thể thử Transactional API (code đã hỗ trợ, chỉ cần đổi endpoint)

## 🧪 Test API Key

Bạn có thể test API key bằng curl:

```bash
curl -X POST 'https://api.brevo.com/v3/smtp/email' \
  -H 'api-key: YOUR_API_KEY_HERE' \
  -H 'Content-Type: application/json' \
  -d '{
    "sender": {
      "email": "your-email@gmail.com",
      "name": "Test"
    },
    "to": [{"email": "test@example.com"}],
    "subject": "Test",
    "htmlContent": "<h1>Test</h1>"
  }'
```

Nếu trả về 401 → API key sai
Nếu trả về 200 → API key đúng

## 📝 Code đã được cải thiện

- ✅ Tự động strip quotes từ BREVO_API_KEY
- ✅ Validate API key format
- ✅ Log chi tiết khi lỗi 401
- ✅ Hiển thị error message từ Brevo API
