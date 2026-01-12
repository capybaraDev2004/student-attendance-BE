# 🎯 Hướng dẫn setup PayOS cho thanh toán VIP

## ✅ Đã hoàn thành

- ✅ Cài đặt `@payos/node` package
- ✅ Tạo Payment model trong Prisma
- ✅ Tạo PayOSService, PaymentService và PaymentController
- ✅ Tạo WebhookController để xử lý thanh toán
- ✅ Frontend modal chọn gói VIP
- ✅ Frontend hiển thị QR code thanh toán

## 📋 Environment Variables cần set

### Backend (Render):

```env
PAYOS_CLIENT_ID=your_client_id
PAYOS_API_KEY=your_api_key
PAYOS_CHECKSUM_KEY=your_checksum_key
FRONTEND_URL=https://your-frontend.vercel.app
```

### Frontend (.env.local):

```env
NEXT_PUBLIC_API_URL=https://your-backend.onrender.com
```

## 🔑 Cách lấy PayOS credentials

1. Đăng ký tài khoản tại: https://payos.vn/
2. Login vào dashboard
3. Vào: **Cài đặt → Thông tin kết nối**
4. Copy:
   - **Client ID**
   - **API Key**
   - **Checksum Key**

## 🔔 Setup Webhook URL

1. Vào PayOS Dashboard → **Cài đặt → Webhook**
2. Thêm webhook URL:
   - **Local**: `https://your-ngrok-url.ngrok-free.app/payment/webhook/payos`
   - **Production**: `https://your-backend.onrender.com/payment/webhook/payos`

## 🧪 Test Local với ngrok

1. Chạy backend: `npm run dev`
2. Chạy ngrok: `ngrok http 3001`
3. Copy URL ngrok (ví dụ: `https://abc123.ngrok-free.app`)
4. Set webhook URL trong PayOS dashboard
5. Test thanh toán

## 📝 Các gói VIP

- **VIP 1 Ngày**: 1,000 VND
- **VIP 1 Tuần**: 1,000 VND
- **VIP 1 Tháng**: 1,000 VND
- **VIP 1 Năm**: 1,000 VND

## 🚀 Flow thanh toán

1. User click "Mua VIP Ngay" trong header
2. Modal hiện ra với các gói VIP
3. User chọn gói và click "Tạo Giao Dịch"
4. Backend tạo payment với PayOS
5. Frontend hiển thị QR code
6. User quét QR bằng MB Bank app
7. PayOS gửi webhook về backend
8. Backend cập nhật VIP cho user
9. Frontend tự động reload để hiển thị VIP status

## ⚠️ Lưu ý

- `orderCode` phải là số và không trùng
- Phải verify webhook data từ PayOS
- QR code là base64 string từ PayOS
- Frontend sẽ poll payment status mỗi 5 giây
