# 🔧 Fix Lỗi "invalid port number in database URL"

## ❌ Lỗi hiện tại:
```
PrismaClientInitializationError: The provided database string is invalid. 
Error parsing connection string: invalid port number in database URL.
```

## 🔍 Nguyên nhân:
Connection string có vấn đề về format, có thể:
1. **Password có ký tự đặc biệt** chưa được URL-encode (`@`, `#`, `%`, `:`, v.v.)
2. **Port bị sai format** hoặc có ký tự lạ
3. **Connection string có khoảng trắng** hoặc ký tự đặc biệt khác

## ✅ CÁCH FIX NGAY:

### Bước 1: Lấy Connection String từ Supabase (Khuyến nghị)
1. Vào Supabase Dashboard → Settings → Database
2. Click **"Connect to your project"**
3. Chọn tab **"ORMs"** → **"Prisma"**
4. Copy **toàn bộ** dòng `DATABASE_URL` (bao gồm cả dấu ngoặc kép nếu có)
5. **QUAN TRỌNG:** Supabase sẽ tự động URL-encode password nếu cần

### Bước 2: Xử lý Password có ký tự đặc biệt

Nếu password có ký tự đặc biệt, cần **URL-encode**:

**Các ký tự cần encode:**
- `@` → `%40`
- `#` → `%23`
- `%` → `%25`
- `:` → `%3A`
- `/` → `%2F`
- `?` → `%3F`
- `&` → `%26`
- `=` → `%3D`
- `+` → `%2B`
- Space → `%20`

**Ví dụ:**
- Password: `pass@word#123`
- Sau khi encode: `pass%40word%23123`

### Bước 3: Cập nhật trong Render
1. Vào Render Dashboard → Web Service → Environment
2. Tìm `DATABASE_URL`
3. **XÓA** giá trị cũ hoàn toàn
4. **PASTE** connection string mới từ Supabase
5. **Kiểm tra:**
   - ✅ Không có khoảng trắng ở đầu/cuối
   - ✅ Port là `6543` (số nguyên, không có ký tự)
   - ✅ Có `?pgbouncer=true` ở cuối
   - ✅ Password đã được URL-encode nếu có ký tự đặc biệt
   - ✅ Không có dấu ngoặc kép `"` ở đầu/cuối (xóa nếu có)
6. **SAVE**

## 📝 Format ĐÚNG:

### Nếu password KHÔNG có ký tự đặc biệt:
```
postgresql://postgres.nccehlxhghzfowssxluf:password123@aws-1-ap-south-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```

### Nếu password CÓ ký tự đặc biệt (đã encode):
```
postgresql://postgres.nccehlxhghzfowssxluf:pass%40word%23123@aws-1-ap-south-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```

## 🔍 Debug Connection String:

### Kiểm tra format:
1. Phải bắt đầu bằng `postgresql://`
2. Format: `postgresql://[USER]:[PASSWORD]@[HOST]:[PORT]/[DATABASE]?[OPTIONS]`
3. Port phải là số nguyên (6543)
4. Không có khoảng trắng

### Test connection string:
Nếu có thể, test connection string bằng:
```bash
# Trong Render Shell hoặc local
psql "your_connection_string"
```

## ⚠️ Lưu ý QUAN TRỌNG:

1. **Tốt nhất:** Copy connection string trực tiếp từ Supabase (tab ORMs → Prisma)
   - Supabase sẽ tự động URL-encode password
   - Đảm bảo format đúng

2. **Nếu tự tạo:** Phải URL-encode password nếu có ký tự đặc biệt

3. **Kiểm tra trong Render:**
   - Xem giá trị `DATABASE_URL` có đúng không
   - Không có khoảng trắng thừa
   - Port là số nguyên `6543`

## ✅ Checklist:

- [ ] Đã copy connection string từ Supabase (tab ORMs → Prisma)
- [ ] Password đã được URL-encode nếu có ký tự đặc biệt
- [ ] Port là `6543` (số nguyên)
- [ ] Có `?pgbouncer=true` ở cuối
- [ ] Không có khoảng trắng trong URL
- [ ] Không có dấu ngoặc kép `"` ở đầu/cuối
- [ ] Đã Save trong Render
- [ ] Đã đợi redeploy xong

## 🚨 Nếu vẫn lỗi:

1. **Reset password trong Supabase:**
   - Tạo password mới chỉ có chữ và số (không có ký tự đặc biệt)
   - Ví dụ: `MyPassword123456`

2. **Copy connection string mới từ Supabase:**
   - Tab ORMs → Prisma
   - Copy toàn bộ connection string

3. **Paste vào Render:**
   - Xóa giá trị cũ
   - Paste mới
   - Save
