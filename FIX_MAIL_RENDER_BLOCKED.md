# 🚨 Fix Lỗi Mail - Render Block SMTP Connection

## ❌ Vấn đề:

Render.com **có thể block outbound SMTP connections** đến Gmail, dẫn đến lỗi "Connection timeout". Đây là vấn đề phổ biến trên các hosting platform.

## ✅ Giải pháp: Dùng Dịch vụ Email API-based

Thay vì dùng SMTP (có thể bị block), nên dùng **API-based email service** như SendGrid, Resend, hoặc Mailgun.

### 🎯 Khuyến nghị: **Resend** (Dễ nhất, Free tier tốt)

**Ưu điểm:**
- ✅ Free: 3,000 emails/month
- ✅ API đơn giản, dễ tích hợp
- ✅ Không cần SMTP (dùng REST API)
- ✅ Không bị block bởi firewall
- ✅ Dashboard tốt, logs chi tiết

### 📦 Cách tích hợp Resend:

#### Bước 1: Tạo tài khoản Resend

1. Vào https://resend.com
2. Sign up (có thể dùng Google)
3. Vào API Keys → Create API Key
4. Copy API key

#### Bước 2: Verify Domain (hoặc dùng test domain)

- Resend cung cấp test domain để test: `onboarding@resend.dev`
- Hoặc verify domain của bạn để dùng custom domain

#### Bước 3: Cài đặt package

```bash
npm install resend
```

#### Bước 4: Update code (xem file mới)

---

## 🔧 Giải pháp tạm thời: Thử Port 465 (SSL)

Nếu muốn thử Gmail trước, có thể thử port 465:

1. Vào Render Dashboard → Environment Variables
2. Thêm: `MAIL_USE_SSL=true`
3. Save và redeploy

**Lưu ý:** Có thể vẫn không work nếu Render block cả port 465.

---

## 📋 So sánh các dịch vụ:

| Service | Free Tier | Setup | API | Recommended |
|---------|-----------|-------|-----|-------------|
| **Resend** | 3,000/month | ⭐⭐⭐ Dễ | REST | ✅ **Khuyến nghị** |
| SendGrid | 100/day | ⭐⭐ Trung bình | REST | ✅ Tốt |
| Mailgun | 5,000/month | ⭐⭐ Trung bình | REST/SMTP | ✅ Tốt |
| Amazon SES | Pay as you go | ⭐ Khó | REST/SMTP | ⚠️ Phức tạp |

---

## ✅ Đã tích hợp Resend!

Code đã được update để support Resend. Làm theo các bước sau:

## 🚀 Next Steps:

1. **Làm theo hướng dẫn:** Xem file `SETUP_RESEND.md` để setup Resend
2. **Cấu hình env variables trên Render:**
   ```
   MAIL_PROVIDER=resend
   RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxx
   RESEND_FROM_EMAIL=onboarding@resend.dev
   MAIL_FROM_NAME=CapyChina
   ```
3. **Redeploy và test**

## 📋 Quick Start:

1. Tạo tài khoản tại https://resend.com
2. Tạo API Key (Dashboard → API Keys)
3. Copy API Key
4. Thêm env variables trên Render (xem trên)
5. Redeploy
6. Test đăng ký → Email sẽ gửi thành công! 🎉
