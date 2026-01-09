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
- `NODE_OPTIONS` = `--max-old-space-size=512` (để tránh out of memory)

### 4. Kiểm tra cấu hình trong Render Dashboard
⚠️ **QUAN TRỌNG:** Phải cấu hình thủ công trong Render Dashboard, không chỉ dựa vào `render.yaml`:

1. Vào Web Service → Settings
2. Kiểm tra:
   - [ ] Root Directory: `server` (nếu repo có nhiều thư mục)
   - [ ] Build Command: `npm install && npm run build`
   - [ ] Start Command: `npm start` (hoặc `npm run start:prod`)
   - [ ] Environment: `Node`
   - [ ] Node Version: `22`

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

### "JavaScript heap out of memory" hoặc "Exited with status 134"
- ✅ Đảm bảo Start Command là `npm start` (không phải `npm run start` với dev mode)
- ✅ Thêm `NODE_OPTIONS=--max-old-space-size=512` vào Environment Variables
- ✅ Kiểm tra script `start` trong package.json chạy production mode

### "No open ports detected"
- ✅ Đảm bảo app đọc port từ `process.env.PORT` (đã có trong code)
- ✅ Đảm bảo `HOST=0.0.0.0` (không phải `localhost`)
- ✅ Kiểm tra app có start thành công không (xem runtime logs)

### "Authentication failed" hoặc "database credentials are not valid"
**Lỗi:** `Authentication failed against database server, the provided database credentials for 'postgres' are not valid.`

**Cách fix:**
1. ✅ Vào Supabase Dashboard → Settings → Database
2. ✅ Click "Reset database password" hoặc "Reset your database password"
3. ✅ Tạo password mới và lưu lại
4. ✅ Copy connection string mới (với password mới)
5. ✅ Vào Render Dashboard → Environment Variables
6. ✅ Cập nhật `DATABASE_URL` với connection string mới
7. ✅ Đảm bảo format đúng: `postgresql://postgres:[PASSWORD]@[HOST]:[PORT]/postgres?pgbouncer=true`
8. ✅ Save và redeploy

**Kiểm tra:**
- Password trong URL phải đúng (vừa reset)
- Connection string không bị cắt
- Nếu dùng pooler, có `?pgbouncer=true` ở cuối

### "Cannot connect to database" hoặc "Can't reach database server"
**Nếu dùng Supabase:**
- ✅ Kiểm tra database có bị pause không (Supabase free tier tự pause sau 1 tuần)
- ✅ Dùng **Transaction pooler** hoặc **Session pooler** (port 6543) thay vì direct connection (port 5432)
- ✅ Lấy từ Supabase Dashboard → Settings → Database → "Connect to your project"
- ✅ Chọn tab "Connection String" hoặc "ORMs" → "Prisma"
- ✅ Copy **Connection URI** (format `postgresql://...`, KHÔNG phải `psql` command)
- ✅ Format: `postgresql://postgres.[ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true`
- ✅ **Lưu ý:** Transaction pooler không support PREPARE statements, nếu Prisma lỗi thì thử Session pooler

**Nếu dùng Render PostgreSQL:**
- ✅ Kiểm tra `DATABASE_URL` đúng format
- ✅ Đảm bảo PostgreSQL service đã được start trong Render
- ✅ Copy `DATABASE_URL` từ PostgreSQL service và thêm vào Web Service Environment Variables

**Kiểm tra chung:**
- ✅ `DATABASE_URL` có được set trong Environment Variables
- ✅ Format đúng: `postgresql://user:password@host:port/database?schema=public`
- ✅ Test connection bằng cách chạy: `npx prisma db pull` (trong Render Shell)

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
