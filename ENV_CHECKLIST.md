# ✅ Checklist Environment Variables cho Production (Render)

## 🔴 BẮT BUỘC phải sửa:

### 1. DATABASE_URL
**Hiện tại (SAI):**
```
DATABASE_URL=postgresql://postgres.nccehlxhghzfowssxluf:bich10091998@aws-1-ap-south-1.pooler.supabase.com:6543/postgres
```

**Phải sửa thành:**
```
DATABASE_URL=postgresql://postgres.nccehlxhghzfowssxluf:bich10091998@aws-1-ap-south-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```
⚠️ **Thiếu `?pgbouncer=true` ở cuối!** Đây là bắt buộc cho Transaction pooler.

### 2. FRONTEND_URL
**Hiện tại (SAI cho production):**
```
FRONTEND_URL=http://localhost:3000
```

**Phải sửa thành URL production:**
```
FRONTEND_URL=https://your-app.vercel.app,https://your-app-git-main.vercel.app
```
⚠️ Thay `your-app` bằng domain thực tế của bạn. Có thể thêm nhiều domain cách nhau bởi dấu phẩy.

### 3. NODE_ENV
**Hiện tại (SAI cho production):**
```
NODE_ENV=development
```

**Phải sửa thành:**
```
NODE_ENV=production
```

## ✅ Các biến đã ổn (không cần sửa):

- ✅ `JWT_ACCESS_SECRET` - OK
- ✅ `JWT_REFRESH_SECRET` - OK
- ✅ `JWT_ACCESS_EXPIRES_IN` - OK
- ✅ `JWT_REFRESH_EXPIRES_IN` - OK
- ✅ `PORT` - OK (Render sẽ override thành 10000)
- ✅ `HOST` - OK
- ✅ **KHUYẾN NGHỊ:** Dùng Resend (API-based, không bị block bởi firewall)
  - `MAIL_PROVIDER=resend`
  - `RESEND_API_KEY` = API key từ Resend (xem `SETUP_RESEND.md`)
  - `RESEND_FROM_EMAIL=onboarding@resend.dev` (hoặc email đã verify domain)
  - `MAIL_FROM_NAME=CapyChina`
- ⚠️ **Nếu dùng Gmail:** Có thể bị block trên Render
  - `MAIL_PROVIDER=gmail`
  - `MAIL_USER`, `MAIL_PASS` (App Password), `MAIL_FROM_NAME`
  - `MAIL_USE_SSL` - Tùy chọn: set `true` để dùng port 465
- ✅ `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` - OK
- ✅ `AZURE_SPEECH_KEY`, `AZURE_SPEECH_REGION` - OK
- ✅ `AZURE_OPENAI_*` - OK
- ✅ `GEMINI_API_KEY` - OK
- ✅ `PAYOS_*` - OK
- ✅ `NEXTAUTH_SECRET` - OK

## 📝 Checklist trước khi deploy:

- [ ] Đã thêm `?pgbouncer=true` vào `DATABASE_URL`
- [ ] Đã thay `FRONTEND_URL` bằng URL production
- [ ] Đã đổi `NODE_ENV=production`
- [ ] Đã copy tất cả biến vào Render Dashboard → Environment Variables
- [ ] Đã kiểm tra không có khoảng trắng thừa
- [ ] Đã kiểm tra password trong DATABASE_URL đúng
- [ ] **KHuyến nghị:** Đã setup Resend (xem `SETUP_RESEND.md`) - **Giải pháp tốt nhất để fix mail**
- [ ] Hoặc đã tạo Gmail App Password và cập nhật `MAIL_PASS` (có thể vẫn bị block trên Render)

## 🚀 Sau khi sửa:

1. Copy tất cả biến đã sửa vào Render Dashboard → Environment Variables
2. Save
3. Redeploy service
4. Kiểm tra logs xem app có start thành công không
