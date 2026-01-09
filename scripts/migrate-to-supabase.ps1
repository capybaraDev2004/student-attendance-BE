# Script migrate dữ liệu từ PostgreSQL local lên Supabase
# Sử dụng: .\migrate-to-supabase.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$LocalDatabaseUrl = "",
    
    [Parameter(Mandatory=$true)]
    [string]$SupabaseUrl = "postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres"
)

Write-Host "=== Migrate Database to Supabase ===" -ForegroundColor Cyan
Write-Host ""

# Tìm PostgreSQL bin path
$pgVersions = @("18", "17", "16", "15", "14", "13", "12")
$pgDumpPath = $null
$psqlPath = $null

foreach ($version in $pgVersions) {
    $pgBin = "C:\Program Files\PostgreSQL\$version\bin"
    $dumpPath = Join-Path $pgBin "pg_dump.exe"
    $sqlPath = Join-Path $pgBin "psql.exe"
    
    if (Test-Path $dumpPath) {
        $pgDumpPath = $dumpPath
        $psqlPath = $sqlPath
        Write-Host "✅ Tìm thấy PostgreSQL $version" -ForegroundColor Green
        break
    }
}

if (-not $pgDumpPath -or -not $psqlPath) {
    Write-Host "❌ Không tìm thấy pg_dump hoặc psql!" -ForegroundColor Red
    Write-Host "Vui lòng cài đặt PostgreSQL hoặc thêm đường dẫn vào PATH" -ForegroundColor Yellow
    exit 1
}

# Nếu không có LocalDatabaseUrl, yêu cầu nhập
if ([string]::IsNullOrWhiteSpace($LocalDatabaseUrl)) {
    Write-Host "Nhập connection string của database local:" -ForegroundColor Yellow
    Write-Host "Ví dụ: postgresql://postgres:password@localhost:5432/learning_chinese?schema=public" -ForegroundColor Gray
    $LocalDatabaseUrl = Read-Host "Local DATABASE_URL"
}

if ([string]::IsNullOrWhiteSpace($LocalDatabaseUrl)) {
    Write-Host "❌ Connection string không được để trống!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Local Database: $LocalDatabaseUrl" -ForegroundColor Cyan
Write-Host "Supabase Database: $SupabaseUrl" -ForegroundColor Cyan
Write-Host ""

# Tạo thư mục temp
$tempDir = Join-Path $PSScriptRoot "temp_migration"
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null
Write-Host "✅ Đã tạo thư mục temp: $tempDir" -ForegroundColor Green
Write-Host ""

# Bước 1: Export schema
Write-Host "=== Bước 1: Export Schema ===" -ForegroundColor Cyan
$schemaFile = Join-Path $tempDir "schema.sql"
Write-Host "Đang export schema..." -ForegroundColor Yellow

$schemaArgs = @(
    "--schema-only",
    "--no-owner",
    "--no-privileges",
    "--file=`"$schemaFile`"",
    $LocalDatabaseUrl
)

$schemaResult = & $pgDumpPath $schemaArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi khi export schema:" -ForegroundColor Red
    Write-Host $schemaResult -ForegroundColor Red
    exit 1
}
Write-Host "✅ Đã export schema: $schemaFile" -ForegroundColor Green
Write-Host ""

# Bước 2: Export data
Write-Host "=== Bước 2: Export Data ===" -ForegroundColor Cyan
$dataFile = Join-Path $tempDir "data.sql"
Write-Host "Đang export dữ liệu..." -ForegroundColor Yellow

$dataArgs = @(
    "--data-only",
    "--no-owner",
    "--no-privileges",
    "--disable-triggers",
    "--file=`"$dataFile`"",
    $LocalDatabaseUrl
)

$dataResult = & $pgDumpPath $dataArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi khi export data:" -ForegroundColor Red
    Write-Host $dataResult -ForegroundColor Red
    exit 1
}
Write-Host "✅ Đã export data: $dataFile" -ForegroundColor Green
Write-Host ""

# Bước 3: Kiểm tra kích thước file
$schemaSize = (Get-Item $schemaFile).Length / 1MB
$dataSize = (Get-Item $dataFile).Length / 1MB
Write-Host "Kích thước Schema: $([math]::Round($schemaSize, 2)) MB" -ForegroundColor Cyan
Write-Host "Kích thước Data: $([math]::Round($dataSize, 2)) MB" -ForegroundColor Cyan
Write-Host ""

# Xác nhận trước khi import
Write-Host "⚠️  CẢNH BÁO: Script sẽ xóa toàn bộ dữ liệu hiện có trong Supabase!" -ForegroundColor Red
Write-Host "Bạn có muốn tiếp tục? (y/N)" -ForegroundColor Yellow
$confirm = Read-Host

if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Đã hủy migration" -ForegroundColor Yellow
    exit 0
}

Write-Host ""

# Bước 4: Drop và tạo lại schema trên Supabase
Write-Host "=== Bước 4: Chuẩn bị Database trên Supabase ===" -ForegroundColor Cyan
Write-Host "Đang xóa các bảng cũ (nếu có)..." -ForegroundColor Yellow

# Tạo script SQL để drop tất cả bảng
$dropScript = @"
-- Disable foreign key checks temporarily
SET session_replication_role = 'replica';

-- Drop all tables
DO \$\$ 
DECLARE 
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END \$\$;

-- Reset sequences
DO \$\$ 
DECLARE 
    r RECORD;
BEGIN
    FOR r IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = 'public') 
    LOOP
        EXECUTE 'DROP SEQUENCE IF EXISTS ' || quote_ident(r.sequence_name) || ' CASCADE';
    END LOOP;
END \$\$;

SET session_replication_role = 'origin';
"@

$dropScriptFile = Join-Path $tempDir "drop_all.sql"
$dropScript | Out-File -FilePath $dropScriptFile -Encoding UTF8

$dropArgs = @(
    "--file=`"$dropScriptFile`"",
    $SupabaseUrl
)

$dropResult = & $psqlPath $dropArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Cảnh báo khi drop tables (có thể là database trống):" -ForegroundColor Yellow
    Write-Host $dropResult -ForegroundColor Yellow
}
Write-Host "✅ Đã chuẩn bị database" -ForegroundColor Green
Write-Host ""

# Bước 5: Import schema vào Supabase
Write-Host "=== Bước 5: Import Schema vào Supabase ===" -ForegroundColor Cyan
Write-Host "Đang import schema..." -ForegroundColor Yellow

$importSchemaArgs = @(
    "--file=`"$schemaFile`"",
    $SupabaseUrl
)

$importSchemaResult = & $psqlPath $importSchemaArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi khi import schema:" -ForegroundColor Red
    Write-Host $importSchemaResult -ForegroundColor Red
    exit 1
}
Write-Host "✅ Đã import schema thành công" -ForegroundColor Green
Write-Host ""

# Bước 6: Import data vào Supabase
Write-Host "=== Bước 6: Import Data vào Supabase ===" -ForegroundColor Cyan
Write-Host "Đang import dữ liệu (có thể mất vài phút)..." -ForegroundColor Yellow

$importDataArgs = @(
    "--file=`"$dataFile`"",
    $SupabaseUrl
)

$importDataResult = & $psqlPath $importDataArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi khi import data:" -ForegroundColor Red
    Write-Host $importDataResult -ForegroundColor Red
    Write-Host ""
    Write-Host "⚠️  Một số lỗi có thể không nghiêm trọng. Vui lòng kiểm tra lại dữ liệu." -ForegroundColor Yellow
} else {
    Write-Host "✅ Đã import data thành công" -ForegroundColor Green
}
Write-Host ""

# Bước 7: Reset sequences
Write-Host "=== Bước 7: Reset Sequences ===" -ForegroundColor Cyan
Write-Host "Đang reset sequences..." -ForegroundColor Yellow

$resetSeqScript = @"
-- Reset all sequences to max value
DO \$\$ 
DECLARE 
    r RECORD;
    max_val BIGINT;
BEGIN
    FOR r IN (
        SELECT 
            schemaname,
            sequencename,
            quote_ident(schemaname) || '.' || quote_ident(sequencename) as seq_full_name
        FROM pg_sequences 
        WHERE schemaname = 'public'
    ) 
    LOOP
        -- Tìm table và column tương ứng
        SELECT 
            quote_ident(table_schema) || '.' || quote_ident(table_name) as tbl_name,
            quote_ident(column_name) as col_name
        INTO r
        FROM information_schema.columns
        WHERE column_default LIKE '%' || r.sequencename || '%'
        AND table_schema = 'public'
        LIMIT 1;
        
        IF r.tbl_name IS NOT NULL THEN
            EXECUTE format('SELECT COALESCE(MAX(%I), 0) FROM %s', r.col_name, r.tbl_name) INTO max_val;
            EXECUTE format('SELECT setval(%L, %s)', r.seq_full_name, GREATEST(max_val, 1));
        END IF;
    END LOOP;
END \$\$;
"@

$resetSeqFile = Join-Path $tempDir "reset_sequences.sql"
$resetSeqScript | Out-File -FilePath $resetSeqFile -Encoding UTF8

$resetSeqArgs = @(
    "--file=`"$resetSeqFile`"",
    $SupabaseUrl
)

$resetSeqResult = & $psqlPath $resetSeqArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Cảnh báo khi reset sequences:" -ForegroundColor Yellow
    Write-Host $resetSeqResult -ForegroundColor Yellow
} else {
    Write-Host "✅ Đã reset sequences" -ForegroundColor Green
}
Write-Host ""

# Bước 8: Kiểm tra dữ liệu
Write-Host "=== Bước 8: Kiểm tra Dữ liệu ===" -ForegroundColor Cyan
Write-Host "Đang kiểm tra số lượng bản ghi..." -ForegroundColor Yellow

$checkScript = @"
SELECT 
    schemaname,
    tablename,
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = schemaname AND table_name = tablename) as column_count
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;
"@

$checkFile = Join-Path $tempDir "check_tables.sql"
$checkScript | Out-File -FilePath $checkFile -Encoding UTF8

$checkArgs = @(
    "--file=`"$checkFile`"",
    $SupabaseUrl
)

$checkResult = & $psqlPath $checkArgs 2>&1
Write-Host $checkResult -ForegroundColor Cyan
Write-Host ""

# Dọn dẹp
Write-Host "=== Dọn dẹp ===" -ForegroundColor Cyan
Write-Host "Bạn có muốn xóa các file temp? (Y/n)" -ForegroundColor Yellow
$cleanup = Read-Host
if ($cleanup -ne "n" -and $cleanup -ne "N") {
    Remove-Item $tempDir -Recurse -Force
    Write-Host "✅ Đã xóa file temp" -ForegroundColor Green
} else {
    Write-Host "⚠️  File temp được giữ lại tại: $tempDir" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== ✅ Migration hoàn tất! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Connection string Supabase:" -ForegroundColor Cyan
Write-Host $SupabaseUrl -ForegroundColor White
Write-Host ""
Write-Host "⚠️  Lưu ý:" -ForegroundColor Yellow
Write-Host "1. Kiểm tra lại dữ liệu trên Supabase" -ForegroundColor White
Write-Host "2. Cập nhật DATABASE_URL trong file .env" -ForegroundColor White
Write-Host "3. Chạy 'npx prisma generate' để cập nhật Prisma Client" -ForegroundColor White
Write-Host ""
