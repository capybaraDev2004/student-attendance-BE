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

Render sẽ tự động detect file `render.yaml` nếu có, hoặc bạn có thể cấu hình thủ công:

- **Build Command:** `npm install && npm run build`
- **Start Command:** `npm run start:prod`
- **Environment:** `Node`
- **Node Version:** `22` (hoặc version bạn đang dùng)

**Lưu ý:** File `render.yaml` đã được tạo sẵn trong project, Render sẽ tự động sử dụng nó.

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

### Lỗi: "Cannot connect to database"
- Kiểm tra `DATABASE_URL` format đúng
- Kiểm tra database có cho phép connections từ Render IPs
- Nếu dùng external DB, whitelist Render IPs
- Đảm bảo database service đã được start trong Render

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

### Lỗi: "Build failed" hoặc "Module not found"
- Kiểm tra tất cả dependencies đã được install
- Đảm bảo `node_modules` không bị ignore trong `.gitignore`
- Kiểm tra Node version trong Render (khuyến nghị: Node 22)

### Lỗi: "Migrations failed"
- Chạy migrations thủ công qua Render Shell: `npx prisma migrate deploy`
- Kiểm tra `DATABASE_URL` đúng format
- Đảm bảo database đã được tạo và accessible

---

## 📚 Tài liệu tham khảo

- [Railway Documentation](https://docs.railway.app)
- [Render Documentation](https://render.com/docs)
- [NestJS Deployment](https://docs.nestjs.com/faq/serverless)

