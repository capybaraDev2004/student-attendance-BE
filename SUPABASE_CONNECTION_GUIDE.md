# 🔗 Hướng dẫn lấy Connection URI từ Supabase

## ❌ KHÔNG dùng `psql` command
Supabase hiển thị `psql` command như này:
```bash
psql -h aws-1-ap-south-1.pooler.supabase.com -p 6543 -d postgres -U postgres.nccehlxhghzfowssxluf
```
**Đây KHÔNG phải connection URI cho Prisma!**

## ✅ Cách lấy Connection URI đúng:

### Cách 1: Từ tab "ORMs" (Khuyến nghị)
1. Vào Supabase Dashboard → Settings → Database
2. Click "Connect to your project"
3. Chọn tab **"ORMs"** (không phải "Connection String")
4. Chọn **"Prisma"**
5. Chọn **Method: Transaction pooler** (hoặc Session pooler)
6. Copy connection URI - sẽ có format:
   ```
   postgresql://postgres.nccehlxhghzfowssxluf:[PASSWORD]@aws-1-ap-south-1.pooler.supabase.com:6543/postgres?pgbouncer=true
   ```

### Cách 2: Từ tab "Connection String"
1. Vào Supabase Dashboard → Settings → Database
2. Click "Connect to your project"
3. Chọn tab **"Connection String"**
4. Chọn **Type: URI** (không phải PSQL)
5. Chọn **Method: Transaction pooler**
6. Copy connection URI

### Cách 3: Tự tạo từ `psql` command
Nếu chỉ thấy `psql` command, bạn có thể tự convert:

**Từ:**
```bash
psql -h aws-1-ap-south-1.pooler.supabase.com -p 6543 -d postgres -U postgres.nccehlxhghzfowssxluf
```

**Thành:**
```
postgresql://postgres.nccehlxhghzfowssxluf:[PASSWORD]@aws-1-ap-south-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```

**Công thức:**
```
postgresql://[USERNAME]:[PASSWORD]@[HOST]:[PORT]/[DATABASE]?pgbouncer=true
```

**Với thông tin từ `psql` command của bạn:**
- Username: `postgres.nccehlxhghzfowssxluf`
- Host: `aws-1-ap-south-1.pooler.supabase.com`
- Port: `6543`
- Database: `postgres`
- Password: **[CẦN LẤY TỪ SUPABASE]**

## 🔑 Lấy Password:

1. Vào Supabase Dashboard → Settings → Database
2. Tìm phần "Reset your database password"
3. Click "Reset database password" (nếu chưa biết password)
4. Tạo password mới và lưu lại
5. Thay `[PASSWORD]` trong connection URI

## 📝 Ví dụ Connection URI hoàn chỉnh:

```
postgresql://postgres.nccehlxhghzfowssxluf:your_password_here@aws-1-ap-south-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```

## ⚠️ Lưu ý quan trọng:

1. **Phải có `?pgbouncer=true`** ở cuối nếu dùng Transaction/Session pooler
2. **Password phải được URL-encode** nếu có ký tự đặc biệt:
   - `@` → `%40`
   - `#` → `%23`
   - `%` → `%25`
   - Space → `%20`
3. **Không có khoảng trắng** trong connection URI
4. **Copy đầy đủ** từ đầu đến cuối

## 🚀 Sau khi có Connection URI:

1. Vào Render Dashboard → Environment Variables
2. Tìm `DATABASE_URL`
3. Paste connection URI vừa lấy
4. Save và redeploy
