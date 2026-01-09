# Hướng dẫn Deploy Backend (NestJS) lên Railway

## 📋 Yêu cầu

1. Tài khoản Railway hoặc Render
2. Database PostgreSQL (có thể dùng Railway Postgres hoặc external)
3. GitHub repository đã push code

## 🚂 Deploy lên Railway (Khuyến nghị)

### Bước 1: Tạo Project trên Railway

1. Đăng nhập [Railway.app](https://railway.app)
2. Click "New Project"
3. Chọn "Deploy from GitHub repo"
4. Chọn repository và **chọn thư mục `server`**

### Bước 2: Cấu hình Build Settings

Railway sẽ tự động detect NestJS, nhưng bạn có thể kiểm tra:

- **Root Directory:** `server`
- **Build Command:** `npm install && npm run build`
- **Start Command:** `npm run start:prod`

### Bước 3: Thêm Environment Variables

Trong Railway Dashboard → Variables, thêm:

```bash
# Database (nếu dùng Railway Postgres, tự động có DATABASE_URL)
DATABASE_URL=postgresql://user:password@host:port/database?schema=public

# JWT Secrets (tạo bằng: openssl rand -base64 64)
JWT_ACCESS_SECRET=your-access-secret-here
JWT_REFRESH_SECRET=your-refresh-secret-here

# Frontend URL (cho CORS)
FRONTEND_URL=https://your-app.vercel.app,https://your-app-git-main.vercel.app

# Server Configuration
PORT=3001
HOST=0.0.0.0
NODE_ENV=production

# Azure Speech (nếu dùng)
AZURE_SPEECH_KEY=your-azure-key
AZURE_SPEECH_REGION=your-azure-region
```

### Bước 4: Tạo Database (nếu chưa có)

1. Trong Railway Project, click "New"
2. Chọn "Database" → "Add PostgreSQL"
3. Railway sẽ tự động tạo và set `DATABASE_URL`

### Bước 5: Chạy Migrations

Sau khi deploy, chạy Prisma migrations:

```bash
# Option 1: Qua Railway CLI
railway run npx prisma migrate deploy

# Option 2: Qua Railway Dashboard
# Thêm vào Deploy Command:
npm install && npm run build && npx prisma migrate deploy
```

### Bước 6: Lấy Public URL

1. Railway sẽ tự động tạo public URL
2. Copy URL này (ví dụ: `https://your-app.railway.app`)
3. Thêm vào `NEXT_PUBLIC_API_URL` trong Vercel

---

## 🎨 Deploy lên Render

### Bước 1: Tạo Web Service

1. Đăng nhập [Render.com](https://render.com)
2. Click "New" → "Web Service"
3. Connect GitHub repository
4. **Quan trọng:** Chọn **Root Directory** là `server` (nếu repo có nhiều thư mục)

### Bước 2: Cấu hình Build

⚠️ **QUAN TRỌNG:** Render có thể không tự động đọc `render.yaml`. Phải cấu hình thủ công trong Dashboard:

1. Vào Web Service → Settings
2. Cấu hình như sau:
   - **Build Command:** `npm install && npm run build` 
   - **Lưu ý:** Script `build` trong `package.json` đã tự động install devDependencies, nên không cần `--include=dev` trong build command
   - **Start Command:** `npm start` (hoặc `npm run start:prod`)
   - **Environment:** `Node`
   - **Node Version:** `22`

**Lưu ý:** 
- File `render.yaml` đã được tạo sẵn, nhưng nên cấu hình thủ công để đảm bảo
- Script `start` trong `package.json` đã được set để chạy production mode
- Nếu gặp lỗi memory, thêm `NODE_OPTIONS=--max-old-space-size=512` vào Environment Variables

### Bước 3: Thêm Environment Variables (BẮT BUỘC TRƯỚC KHI DEPLOY)

⚠️ **QUAN TRỌNG:** App sẽ **CRASH** nếu thiếu các biến bắt buộc. Phải thêm **TRƯỚC KHI DEPLOY** hoặc ngay sau khi deploy lần đầu.

Trong Render Dashboard → Environment, thêm các biến sau:

#### Biến BẮT BUỘC (phải có):
```bash
# Database (sẽ được set tự động nếu dùng Render PostgreSQL)
# Nếu chưa có database, tạo PostgreSQL service trước
DATABASE_URL=postgresql://user:password@host:port/database?schema=public

# JWT Secrets - BẮT BUỘC (app sẽ crash nếu thiếu)
# Tạo bằng: node -e "console.log(require('crypto').randomBytes(64).toString('base64'))"
JWT_ACCESS_SECRET=<tạo-secret-ngẫu-nhiên-64-bytes-base64>
JWT_REFRESH_SECRET=<tạo-secret-ngẫu-nhiên-64-bytes-base64>
```

#### Biến KHUYẾN NGHỊ:
```bash
# Frontend URL (cho CORS) - thêm tất cả các domain có thể
FRONTEND_URL=https://your-app.vercel.app,https://your-app-git-main.vercel.app

# Server Configuration (đã có trong render.yaml, nhưng có thể override)
PORT=10000
HOST=0.0.0.0
NODE_ENV=production

# Azure Speech (chỉ cần nếu dùng tính năng speech)
AZURE_SPEECH_KEY=your-azure-key
AZURE_SPEECH_REGION=your-azure-region
```

**Lưu ý:** 
- Render sử dụng port `10000` mặc định, đảm bảo code đọc từ `process.env.PORT` (đã có trong code)
- `NODE_ENV`, `PORT`, `HOST` đã được set trong `render.yaml`, nhưng có thể override nếu cần

### Bước 4: Tạo Database

1. Trong Render Dashboard, click "New" → "PostgreSQL"
2. Chọn plan phù hợp (Free tier có giới hạn)
3. Render sẽ tự động set `DATABASE_URL` environment variable
4. Copy `DATABASE_URL` và thêm vào Web Service environment variables

### Bước 5: Chạy Migrations

Sau khi deploy lần đầu, chạy Prisma migrations:

**Option 1: Qua Render Shell**
1. Vào Web Service → Shell
2. Chạy: `npx prisma migrate deploy`

**Option 2: Thêm vào Build Command**
Có thể thêm vào build command (nhưng không khuyến nghị vì sẽ chạy mỗi lần deploy):
```bash
npm install && npm run build && npx prisma migrate deploy
```

**Option 3: Tạo Script riêng**
Thêm script vào `package.json`:
```json
"deploy": "npm run build && npx prisma migrate deploy && npm run start:prod"
```

### Bước 6: Lấy Public URL

1. Render sẽ tự động tạo public URL sau khi deploy thành công
2. Copy URL này (ví dụ: `https://your-app.onrender.com`)
3. Thêm vào `NEXT_PUBLIC_API_URL` trong Vercel
4. Thêm URL này vào `FRONTEND_URL` trong Render (nếu cần)

---

## 🔧 Cấu hình CORS

Đảm bảo trong `server/src/main.ts`:

```typescript
const allowedOrigins = process.env.FRONTEND_URL
  ? process.env.FRONTEND_URL.split(',').map((url) => url.trim())
  : ['http://localhost:3000'];

app.enableCors({
  origin: (origin, callback) => {
    if (!origin || allowedOrigins.some((allowed) => origin.startsWith(allowed.replace(/:\d+$/, ''))) || process.env.NODE_ENV !== 'production') {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
});
```

---

## 📝 Checklist

- [ ] Database đã được tạo và migrations đã chạy
- [ ] Tất cả environment variables đã được set
- [ ] `FRONTEND_URL` trỏ đúng Vercel domain
- [ ] CORS đã được cấu hình đúng
- [ ] Public URL đã được copy vào Vercel env
- [ ] Test API endpoints hoạt động

---

## 🧪 Test API sau khi deploy

```bash
# Test health check
curl https://your-api.railway.app/

# Test login endpoint
curl -X POST https://your-api.railway.app/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test123"}'
```

---

## 🔍 Troubleshooting

### Lỗi: "There's an error above. Please fix it to continue."
**Đây là lỗi chung của Render, thường do:**

1. **Thiếu Environment Variables BẮT BUỘC:**
   - App sử dụng `getOrThrow` cho `JWT_ACCESS_SECRET` và `JWT_REFRESH_SECRET`
   - Nếu thiếu, app sẽ crash ngay khi start
   - **Giải pháp:** 
     - Vào Render Dashboard → Environment
     - Thêm `JWT_ACCESS_SECRET` và `JWT_REFRESH_SECRET`
     - Tạo secrets bằng: `node -e "console.log(require('crypto').randomBytes(64).toString('base64'))"`
     - Restart service sau khi thêm

2. **Thiếu DATABASE_URL:**
   - Prisma cần `DATABASE_URL` để generate client
   - **Giải pháp:** Tạo PostgreSQL service trên Render hoặc thêm `DATABASE_URL` từ external database

3. **render.yaml có lỗi:**
   - Kiểm tra YAML syntax (indentation phải là spaces, không phải tabs)
   - File đã được fix với `nodeVersion: 22`
   - Đảm bảo file nằm ở root của thư mục `server`

4. **Build failed:**
   - Xem build logs trong Render Dashboard để biết lỗi cụ thể
   - Đảm bảo `npm install && npm run build` chạy thành công
   - File `dist/src/main.js` phải tồn tại sau khi build

**Checklist để fix:**
- [ ] Đã thêm `JWT_ACCESS_SECRET` vào Environment Variables
- [ ] Đã thêm `JWT_REFRESH_SECRET` vào Environment Variables  
- [ ] Đã có `DATABASE_URL` (từ Render PostgreSQL hoặc external)
- [ ] Build command chạy thành công (check logs)
- [ ] File `render.yaml` có syntax đúng (đã được fix)
- [ ] Root Directory trong Render được set đúng là `server` (nếu repo có nhiều thư mục)

### Lỗi: "Cannot find module '/opt/render/project/src/dist/main'"
**Đã fix:** File `package.json` đã được cập nhật với:
- `postinstall` script để generate Prisma Client
- `build` script bao gồm `prisma generate`
- `start:prod` sử dụng đúng path `dist/main.js`

**Kiểm tra:**
- Đảm bảo build command chạy thành công: `npm install && npm run build`
- Kiểm tra file `dist/main.js` có tồn tại sau khi build
- Render sẽ tự động detect `render.yaml` nếu có

### Lỗi: "Authentication failed" hoặc "database credentials are not valid"
**Lỗi cụ thể:** `PrismaClientInitializationError: Authentication failed against database server, the provided database credentials for 'postgres' are not valid.`

**Nguyên nhân:**
- Password trong `DATABASE_URL` không đúng
- Password đã bị thay đổi nhưng `DATABASE_URL` chưa được cập nhật
- Connection string format không đúng

**Cách fix:**

1. **Reset password trong Supabase:**
   - Vào Supabase Dashboard → Settings → Database
   - Click "Reset database password" hoặc "Reset your database password"
   - Tạo password mới (lưu lại an toàn)
   - Copy connection string mới với password mới

2. **Cập nhật DATABASE_URL trong Render:**
   - Vào Render Dashboard → Web Service → Environment
   - Tìm `DATABASE_URL`
   - Thay thế bằng connection string mới (có password mới)
   - Format đúng: `postgresql://postgres:[PASSWORD]@[HOST]:[PORT]/postgres?[OPTIONS]`
   - **Lưu ý:** Nếu dùng Transaction pooler, đảm bảo URL có `?pgbouncer=true`

3. **Kiểm tra connection string format:**
   ```
   postgresql://postgres:[PASSWORD]@db.xxx.supabase.co:6543/postgres?pgbouncer=true
   ```
   - `[PASSWORD]` phải là password mới vừa reset
   - Port `6543` cho Transaction pooler, `5432` cho Direct connection
   - `?pgbouncer=true` bắt buộc nếu dùng pooler

4. **Save và redeploy:**
   - Save Environment Variables
   - Render sẽ tự động redeploy hoặc click "Manual Deploy"

**Lưu ý quan trọng:**
- Password trong connection string phải được URL-encode nếu có ký tự đặc biệt
- Không có khoảng trắng trong password
- Đảm bảo copy đầy đủ connection string (không bị cắt)

### Lỗi: "Cannot connect to database" hoặc "Can't reach database server"
**Lỗi cụ thể:** `PrismaClientInitializationError: Can't reach database server at ...`

**Nguyên nhân thường gặp:**

1. **DATABASE_URL không đúng format hoặc thiếu:**
   - Kiểm tra `DATABASE_URL` có được set trong Environment Variables
   - Format đúng: `postgresql://user:password@host:port/database?schema=public`

2. **Supabase Database không accessible từ Render:**
   - Supabase có thể chặn connections từ external IPs
   - Free tier có thể bị pause sau khi không dùng
   - Cần kiểm tra Supabase Dashboard → Settings → Database

3. **Cần dùng Connection Pooling URL (nếu dùng Supabase):**
   - Supabase có 2 loại connection string:
     - **Direct connection:** `postgresql://...@db.xxx.supabase.co:5432/...`
     - **Connection pooling:** `postgresql://...@db.xxx.supabase.co:6543/...` (port 6543)
   - **Giải pháp:** Dùng connection pooling URL (port 6543) thay vì direct connection (port 5432)
   - Lấy từ Supabase Dashboard → Settings → Database → Connection Pooling

4. **Database bị pause (Supabase Free tier):**
   - Supabase free tier tự động pause database sau 1 tuần không dùng
   - **Giải pháp:** Vào Supabase Dashboard và resume database

5. **Firewall/Network issues:**
   - Kiểm tra Supabase có cho phép connections từ external IPs
   - Có thể cần whitelist Render IPs (nhưng Supabase thường cho phép tất cả)

**Cách fix:**

**Option 1: Dùng Connection Pooling URL (Khuyến nghị cho Supabase)**
1. Vào Supabase Dashboard → Settings → Database → "Connect to your project"
2. Chọn tab **"Connection String"** hoặc **"ORMs"** → **"Prisma"**
3. Chọn **Method: Transaction pooler** (hoặc Session pooler nếu Transaction không work)
4. Copy **Connection URI** (format `postgresql://...`, KHÔNG phải `psql` command)
5. Format đúng: `postgresql://postgres.[project-ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true`
6. Thay thế `DATABASE_URL` trong Render Environment Variables với URI này
7. **Lưu ý:** Transaction pooler không support PREPARE statements, nếu Prisma lỗi thì thử Session pooler

**Option 2: Tạo PostgreSQL trên Render (Đơn giản hơn)**
1. Trong Render Dashboard, tạo PostgreSQL service mới
2. Render sẽ tự động set `DATABASE_URL`
3. Copy `DATABASE_URL` và thêm vào Web Service Environment Variables
4. Chạy migrations: `npx prisma migrate deploy`

**Option 3: Kiểm tra và Resume Supabase Database**
1. Vào Supabase Dashboard
2. Kiểm tra database có bị pause không
3. Nếu pause, click Resume
4. Đợi vài phút để database start
5. Redeploy trên Render

### Lỗi: "Prisma Client not generated"
**Đã fix:** Script `postinstall` đã được thêm vào `package.json` để tự động generate Prisma Client sau khi `npm install`.

Nếu vẫn gặp lỗi:
```bash
# Chạy thủ công trong Render Shell
npx prisma generate
```

### Lỗi: "Port already in use"
- Render tự động set `PORT=10000` (hoặc port khác)
- Đảm bảo code đọc từ `process.env.PORT` (đã có trong `main.ts`)
- Không hardcode port trong code

### Lỗi: "JavaScript heap out of memory" hoặc "Exited with status 134"
**Nguyên nhân:**
- Render đang chạy `npm run start` (dev mode) thay vì production mode
- Dev mode tốn nhiều memory hơn và có thể gây out of memory

**Đã fix:**
- Script `start` trong `package.json` đã được sửa để chạy production mode: `node dist/src/main.js`
- Thêm `NODE_OPTIONS=--max-old-space-size=512` vào Environment Variables trong render.yaml

**Cách fix thủ công:**
1. Vào Render Dashboard → Web Service → Settings
2. Đảm bảo **Start Command** là: `npm start` hoặc `npm run start:prod`
3. Vào Environment Variables, thêm:
   - Key: `NODE_OPTIONS`
   - Value: `--max-old-space-size=512`
4. Save và redeploy

### Lỗi: "No open ports detected"
**Nguyên nhân:**
- App không start được hoặc không bind đúng port
- Render không detect được port đang listen

**Cách fix:**
- Đảm bảo code đọc port từ `process.env.PORT` (đã có trong `main.ts`)
- Đảm bảo `HOST=0.0.0.0` (không phải `localhost`)
- Kiểm tra app có start thành công không (xem runtime logs)
- Nếu app crash ngay khi start, xem logs để tìm lỗi (thường là thiếu env variables)

### Lỗi: "nest: not found" hoặc "could not determine executable to run"
**Lỗi cụ thể:** `sh: 1: nest: not found` hoặc `npm error could not determine executable to run`

**Nguyên nhân:**
- `@nestjs/cli` nằm trong `devDependencies` và không được install trong production
- Render có thể skip devDependencies khi `NODE_ENV=production`

**Đã fix:**
- Build script đã được sửa: tự động install devDependencies trước khi build
- Build script: `prisma generate && npm install --include=dev && node_modules/.bin/nest build`
- Build command trong `render.yaml`: `npm install && npm run build` (script sẽ tự xử lý devDependencies)

**Cách fix thủ công:**
1. Vào Render Dashboard → Web Service → Settings
2. Đảm bảo **Build Command** là: `npm install && npm run build`
3. Script `build` trong `package.json` đã tự động install devDependencies, không cần `--include=dev` trong build command
4. Save và redeploy

### Lỗi: "Build failed" hoặc "Module not found"
- Kiểm tra tất cả dependencies đã được install
- Đảm bảo `node_modules` không bị ignore trong `.gitignore`
- Kiểm tra Node version trong Render (khuyến nghị: Node 22)
- Build script đã tự động install devDependencies, không cần thêm `--include=dev` trong build command

### Lỗi: "Migrations failed"
- Chạy migrations thủ công qua Render Shell: `npx prisma migrate deploy`
- Kiểm tra `DATABASE_URL` đúng format
- Đảm bảo database đã được tạo và accessible

---

## 📚 Tài liệu tham khảo

- [Railway Documentation](https://docs.railway.app)
- [Render Documentation](https://render.com/docs)
- [NestJS Deployment](https://docs.nestjs.com/faq/serverless)

