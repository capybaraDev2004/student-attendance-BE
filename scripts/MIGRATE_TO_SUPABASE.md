# Hướng dẫn Migrate Database lên Supabase

## 📋 Yêu cầu

1. PostgreSQL đã được cài đặt trên máy (để có `pg_dump` và `psql`)
2. Connection string của database local
3. Connection string Supabase (đã có sẵn)

## 🚀 Cách sử dụng

### Cách 1: Script đơn giản (Khuyến nghị)

```powershell
cd server/scripts
.\migrate-to-supabase-simple.ps1
```

Script sẽ yêu cầu bạn nhập connection string của database local.

### Cách 2: Script đầy đủ

```powershell
cd server/scripts
.\migrate-to-supabase.ps1 -LocalDatabaseUrl "postgresql://postgres:password@localhost:5432/learning_chinese?schema=public"
```

Hoặc không truyền tham số, script sẽ hỏi bạn:

```powershell
.\migrate-to-supabase.ps1
```

## 📝 Connection String Supabase

Connection string Supabase đã được cấu hình sẵn trong script:
```
postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres
```

## ⚠️ Lưu ý quan trọng

1. **Backup trước khi migrate**: Script sẽ xóa toàn bộ dữ liệu hiện có trên Supabase
2. **Kiểm tra kết nối**: Đảm bảo có thể kết nối đến cả database local và Supabase
3. **Thời gian**: Quá trình migrate có thể mất vài phút tùy vào lượng dữ liệu

## 🔄 Quy trình migrate

Script sẽ thực hiện các bước sau:

1. ✅ Export schema từ database local
2. ✅ Export data từ database local
3. ⚠️ Xác nhận trước khi xóa dữ liệu trên Supabase
4. 🗑️ Xóa các bảng cũ trên Supabase (nếu có)
5. 📥 Import schema vào Supabase
6. 📥 Import data vào Supabase
7. 🔄 Reset sequences
8. ✅ Kiểm tra dữ liệu

## 🐛 Xử lý lỗi

### Lỗi: Không tìm thấy pg_dump hoặc psql

**Giải pháp**: 
- Đảm bảo PostgreSQL đã được cài đặt
- Thêm đường dẫn PostgreSQL vào PATH:
  ```
  C:\Program Files\PostgreSQL\18\bin
  ```

### Lỗi: Không thể kết nối đến database

**Giải pháp**:
- Kiểm tra connection string đúng format
- Kiểm tra database đang chạy
- Kiểm tra firewall/network

### Lỗi khi import data

**Giải pháp**:
- Một số lỗi có thể không nghiêm trọng (ví dụ: duplicate key)
- Kiểm tra lại dữ liệu trên Supabase sau khi migrate
- Xem log trong file temp để biết chi tiết

## 📂 File temp

Script sẽ tạo các file temp trong thư mục `server/scripts/temp_migration/`:
- `schema.sql` - Schema export
- `data.sql` - Data export
- Các file SQL khác

Bạn có thể giữ lại các file này để kiểm tra hoặc migrate lại nếu cần.

## ✅ Sau khi migrate

1. **Cập nhật DATABASE_URL** trong file `.env`:
   ```
   DATABASE_URL=postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres
   ```

2. **Cập nhật Prisma Client**:
   ```bash
   npx prisma generate
   ```

3. **Kiểm tra kết nối**:
   ```bash
   npx prisma db pull
   ```

4. **Test ứng dụng** để đảm bảo mọi thứ hoạt động bình thường

## 🔍 Kiểm tra dữ liệu

Sau khi migrate, bạn có thể kiểm tra dữ liệu bằng cách:

```powershell
# Kết nối đến Supabase
psql "postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres"

# Kiểm tra số lượng bản ghi
SELECT 
    schemaname,
    tablename,
    (xpath('/row/cnt/text()', xml_count))[1]::text::int as row_count
FROM (
    SELECT 
        schemaname, 
        tablename, 
        query_to_xml(format('select count(*) as cnt from %I.%I', schemaname, tablename), false, true, '') as xml_count
    FROM pg_tables 
    WHERE schemaname = 'public'
) t
ORDER BY tablename;
```

## 📞 Hỗ trợ

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra log trong console
2. Kiểm tra file temp trong `server/scripts/temp_migration/`
3. Thử migrate lại với file đã export
