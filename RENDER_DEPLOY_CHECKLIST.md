# ✅ Checklist Deploy Render - Fix Lỗi "There's an error above"

## 🔴 Các bước BẮT BUỘC trước khi deploy:

### 1. Tạo JWT Secrets
Chạy lệnh này để tạo 2 secrets:
```bash
node -e "console.log('JWT_ACCESS_SECRET=' + require('crypto').randomBytes(64).toString('base64')); console.log('JWT_REFRESH_SECRET=' + require('crypto').randomBytes(64).toString('base64'));"
```

Copy 2 dòng output và lưu lại.

### 2. Tạo PostgreSQL Database trên Render
1. Vào Render Dashboard
2. Click "New" → "PostgreSQL"
3. Chọn plan (Free tier có giới hạn)
4. Copy `DATABASE_URL` từ database service

### 3. Thêm Environment Variables trong Render
Vào Web Service → Environment, thêm:

**BẮT BUỘC:**
- `JWT_ACCESS_SECRET` = (từ bước 1)
- `JWT_REFRESH_SECRET` = (từ bước 1)
- `DATABASE_URL` = (từ PostgreSQL service)

**KHUYẾN NGHỊ:**
- `FRONTEND_URL` = URL của frontend (ví dụ: `https://your-app.vercel.app`)
- `NODE_ENV` = `production` (đã có trong render.yaml)
- `PORT` = `10000` (đã có trong render.yaml)
- `HOST` = `0.0.0.0` (đã có trong render.yaml)

### 4. Kiểm tra cấu hình
- [ ] File `render.yaml` có trong thư mục `server`
- [ ] Root Directory trong Render được set là `server` (nếu repo có nhiều thư mục)
- [ ] Build Command: `npm install && npm run build`
- [ ] Start Command: `npm run start:prod`

### 5. Deploy và kiểm tra
1. Deploy service
2. Xem build logs - đảm bảo build thành công
3. Xem runtime logs - kiểm tra app có start được không
4. Nếu có lỗi, xem phần Troubleshooting trong `DEPLOY.md`

## 🚨 Lỗi thường gặp và cách fix:

### "Cannot find module"
- ✅ Đã fix: `start:prod` sử dụng `dist/src/main.js`
- Kiểm tra build logs xem file có được tạo không

### "JWT_ACCESS_SECRET chưa được cấu hình"
- ✅ Thêm `JWT_ACCESS_SECRET` vào Environment Variables
- Restart service sau khi thêm

### "Prisma Client not generated"
- ✅ Đã fix: `postinstall` script tự động generate
- Nếu vẫn lỗi, chạy: `npx prisma generate` trong Render Shell

### "Cannot connect to database"
- ✅ Kiểm tra `DATABASE_URL` đúng format
- ✅ Đảm bảo PostgreSQL service đã được start

## 📝 Sau khi deploy thành công:

1. Chạy migrations:
   ```bash
   npx prisma migrate deploy
   ```
   (Qua Render Shell hoặc thêm vào build command)

2. Test API:
   ```bash
   curl https://your-app.onrender.com/
   ```

3. Cập nhật frontend với API URL mới
