# 🔍 Debug Mail Service - Hướng dẫn kiểm tra

## ✅ Code đã được cập nhật với logging chi tiết

Code đã được cập nhật để log chi tiết hơn, giúp debug dễ dàng.

## 🔍 Cách kiểm tra:

### 1. Kiểm tra logs khi app start:

Khi app khởi động, bạn sẽ thấy logs như:

**Nếu dùng Resend:**
```
📧 MailService initializing with provider: resend
📧 Resend API Key: ***xxxx (4 ký tự cuối)
📧 Resend From Email: onboarding@resend.dev
✅ MailService initialized with Resend (API-based)
✅ From address: onboarding@resend.dev
```

**Nếu có lỗi:**
```
❌ RESEND_API_KEY chưa được cấu hình - email sẽ KHÔNG được gửi!
❌ Vui lòng set RESEND_API_KEY trong environment variables
```

### 2. Kiểm tra logs khi gửi email:

**Khi gửi email:**
```
📧 Attempting to send email via Resend: from=CapyChina <onboarding@resend.dev>, to=user@example.com
✅ Email đã được gửi thành công qua Resend đến user@example.com (ID: ...)
```

**Nếu có lỗi:**
```
❌ Resend client chưa được cấu hình - email sẽ KHÔNG được gửi
❌ Vui lòng kiểm tra RESEND_API_KEY trong environment variables
```

Hoặc:
```
❌ Gửi email qua Resend thất bại đến user@example.com: ...
Stack trace: ...
```

## 📋 Checklist để fix:

### Trên Local (Development):

1. **Kiểm tra file `.env`:**
   ```env
   MAIL_PROVIDER=resend
   RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxx
   RESEND_FROM_EMAIL=onboarding@resend.dev
   MAIL_FROM_NAME=CapyChina
   ```

2. **Đảm bảo không có duplicate:**
   - Xóa các dòng duplicate trong .env
   - Chỉ giữ 1 bộ config

3. **Restart app:**
   - Dừng app (Ctrl+C)
   - Start lại: `npm run dev`
   - Xem logs khi start

4. **Test gửi email:**
   - Đăng ký tài khoản mới
   - Xem logs để kiểm tra

### Trên Render (Production):

1. **Vào Render Dashboard → Environment Variables**

2. **Kiểm tra các biến:**
   ```
   MAIL_PROVIDER=resend
   RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxx
   RESEND_FROM_EMAIL=onboarding@resend.dev
   MAIL_FROM_NAME=CapyChina
   ```

3. **Xóa các biến cũ (Gmail) nếu không dùng:**
   - MAIL_USER
   - MAIL_PASS
   - MAIL_USE_SSL

4. **Save và Redeploy**

5. **Xem logs trên Render:**
   - Vào Logs tab
   - Tìm logs "MailService initializing"
   - Kiểm tra xem có lỗi không

## 🐛 Các lỗi thường gặp:

### 1. "RESEND_API_KEY chưa được cấu hình"

**Nguyên nhân:** Biến environment chưa được set

**Fix:**
- Kiểm tra .env (local) hoặc Environment Variables (Render)
- Đảm bảo tên biến đúng: `RESEND_API_KEY` (không có khoảng trắng)
- Restart/redeploy

### 2. "Resend client chưa được cấu hình"

**Nguyên nhân:** Resend client không được khởi tạo (thường do API key không hợp lệ hoặc không được set)

**Fix:**
- Kiểm tra API key có đúng format không: `re_xxxxxxxxxxxxxxxxxx`
- Kiểm tra API key có còn valid không (vào Resend dashboard)
- Tạo API key mới nếu cần

### 3. "Resend API error: ..."

**Nguyên nhân:** Lỗi từ Resend API (API key không hợp lệ, rate limit, etc.)

**Fix:**
- Kiểm tra API key
- Kiểm tra Resend dashboard xem có error không
- Kiểm tra quota (free tier: 3,000 emails/month)

### 4. Email không đến inbox

**Nguyên nhân:** 
- Email bị spam
- From address chưa verify (nếu dùng custom domain)
- Resend quota hết

**Fix:**
- Kiểm tra spam folder
- Dùng `onboarding@resend.dev` để test (không cần verify)
- Kiểm tra Resend dashboard → Emails để xem status

## ✅ Test đơn giản:

1. **Start app và xem logs:**
   ```bash
   npm run dev
   ```
   
2. **Tìm dòng:**
   ```
   ✅ MailService initialized with Resend (API-based)
   ```

3. **Nếu thấy dòng này → OK, tiếp tục test**
4. **Nếu thấy error → Fix theo checklist trên**

## 📞 Nếu vẫn không được:

1. Copy toàn bộ logs liên quan đến MailService
2. Kiểm tra Resend dashboard → API Keys → Xem API key có active không
3. Test API key bằng cách gửi email thủ công qua Resend dashboard
4. Kiểm tra file .env có format đúng không (không có quotes thừa, không có spaces)
