# 🔧 Fix Lỗi CORS - Frontend không kết nối được với Backend

## 🚨 Lỗi hiện tại:

```
Access to fetch at 'https://student-attendance-be.onrender.com/...' 
from origin 'https://student-attendance-fe-ten.vercel.app' 
has been blocked by CORS policy: Response to preflight request doesn't pass access control check: 
No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

## ✅ Giải pháp:

Backend trên Render **chưa được cấu hình** để cho phép requests từ domain Vercel. Cần thêm biến môi trường `FRONTEND_URL` trên Render.

### Các bước thực hiện:

1. **Vào Render Dashboard**
   - Đăng nhập vào https://dashboard.render.com
   - Vào Web Service của backend

2. **Thêm Environment Variable**
   - Vào tab **Environment**
   - Tìm biến `FRONTEND_URL` (nếu chưa có thì tạo mới)
   - Set giá trị:
     ```
     https://student-attendance-fe-ten.vercel.app
     ```
   
   **Lưu ý:** Nếu có nhiều domain (ví dụ preview deployments), có thể thêm cách nhau bởi dấu phẩy:
     ```
     https://student-attendance-fe-ten.vercel.app,https://student-attendance-fe-ten-git-main.vercel.app
     ```

3. **Save và Redeploy**
   - Click **Save Changes**
   - Render sẽ tự động redeploy service
   - Hoặc có thể click **Manual Deploy** để deploy ngay

4. **Kiểm tra logs**
   - Vào tab **Logs**
   - Tìm dòng: `🌐 Allowed CORS origins: [...]`
   - Đảm bảo domain Vercel có trong danh sách

5. **Test lại**
   - Mở frontend trên Vercel
   - Kiểm tra console không còn lỗi CORS
   - Test các API calls

## 📋 Checklist:

- [ ] Đã thêm `FRONTEND_URL` vào Environment Variables trên Render
- [ ] Giá trị đúng format: `https://student-attendance-fe-ten.vercel.app`
- [ ] Đã save changes
- [ ] Service đã redeploy thành công
- [ ] Logs hiển thị domain trong danh sách allowed origins
- [ ] Frontend test lại và không còn lỗi CORS

## 🔍 Debug:

Nếu vẫn còn lỗi sau khi thêm `FRONTEND_URL`:

1. **Kiểm tra format URL:**
   - ✅ Đúng: `https://student-attendance-fe-ten.vercel.app`
   - ❌ Sai: `http://student-attendance-fe-ten.vercel.app` (thiếu s)
   - ❌ Sai: `student-attendance-fe-ten.vercel.app` (thiếu protocol)
   - ❌ Sai: `https://student-attendance-fe-ten.vercel.app/` (có trailing slash cũng OK, code đã xử lý)

2. **Kiểm tra logs trên Render:**
   - Tìm dòng `🌐 Allowed CORS origins:`
   - Xem domain có trong danh sách không
   - Nếu có dòng `⚠️  CORS blocked origin: ...` thì domain chưa được thêm đúng

3. **Kiểm tra NODE_ENV:**
   - Đảm bảo `NODE_ENV=production` trên Render
   - Code đã được update để log và handle CORS tốt hơn

4. **Clear browser cache:**
   - Đôi khi browser cache lỗi cũ
   - Thử hard refresh (Ctrl+Shift+R) hoặc clear cache

## 🎯 Code đã được cải thiện:

Code trong `src/main.ts` đã được cập nhật để:
- ✅ Log allowed origins để dễ debug
- ✅ So sánh exact match chính xác hơn
- ✅ Xử lý trailing slash và case-insensitive
- ✅ Log warning khi block origin để debug
