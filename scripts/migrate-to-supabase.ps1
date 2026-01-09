# Script migrate dữ liệu từ PostgreSQL local lên Supabase
# Sử dụng: .\migrate-to-supabase.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$LocalDatabaseUrl = "",
    
    [Parameter(Mandatory=$false)]
    [string]$SupabaseUrl = "postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres",
    
    [Parameter(Mandatory=$false)]
    [switch]$Yes = $false
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

# Loại bỏ tham số schema khỏi connection string cho pg_dump (không hỗ trợ)
function Clean-ConnectionString {
    param([string]$connStr)
    if ($connStr -match '\?') {
        return $connStr -replace '\?.*$', ''
    }
    return $connStr
}

$LocalDatabaseUrlClean = Clean-ConnectionString $LocalDatabaseUrl
$SupabaseUrlClean = Clean-ConnectionString $SupabaseUrl

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

# Bước 1: Export toàn bộ (schema + data) thành một file dump.sql
Write-Host "=== Bước 1: Export Database ===" -ForegroundColor Cyan
$dumpFile = Join-Path $tempDir "dump.sql"
Write-Host "Đang export schema và data..." -ForegroundColor Yellow

$dumpArgs = @(
    "--no-owner",
    "--no-privileges",
    "--file=`"$dumpFile`"",
    $LocalDatabaseUrlClean
)

$dumpResult = & $pgDumpPath $dumpArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi khi export database:" -ForegroundColor Red
    Write-Host $dumpResult -ForegroundColor Red
    exit 1
}
Write-Host "✅ Đã export database: $dumpFile" -ForegroundColor Green

# Kiểm tra kích thước file
$dumpSize = (Get-Item $dumpFile).Length / 1MB
Write-Host "Kích thước dump file: $([math]::Round($dumpSize, 2)) MB" -ForegroundColor Cyan
Write-Host ""

# Xác nhận trước khi import
if (-not $Yes) {
    Write-Host "⚠️  CẢNH BÁO: Script sẽ xóa toàn bộ dữ liệu hiện có trong Supabase!" -ForegroundColor Red
    Write-Host "Bạn có muốn tiếp tục? (y/N)" -ForegroundColor Yellow
    $confirm = Read-Host

    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Đã hủy migration" -ForegroundColor Yellow
        exit 0
    }
} else {
    Write-Host "⚠️  CẢNH BÁO: Script sẽ xóa toàn bộ dữ liệu hiện có trong Supabase!" -ForegroundColor Red
    Write-Host "Đang tiếp tục với --Yes flag..." -ForegroundColor Yellow
}

Write-Host ""

# Bước 2: Parse Supabase connection string để lấy thông tin
Write-Host "=== Bước 2: Parse Supabase Connection ===" -ForegroundColor Cyan
# Parse connection string: postgresql://postgres:password@host:port/database
if ($SupabaseUrl -match 'postgresql://([^:]+):([^@]+)@([^:]+):(\d+)/(.+)') {
    $supabaseUser = $matches[1]
    $supabasePassword = $matches[2]
    $supabaseHost = $matches[3]
    $supabasePort = $matches[4]
    $supabaseDatabase = $matches[5] -replace '\?.*$', ''  # Remove query params
    
    Write-Host "Host: $supabaseHost" -ForegroundColor Gray
    Write-Host "Port: $supabasePort" -ForegroundColor Gray
    Write-Host "Database: $supabaseDatabase" -ForegroundColor Gray
    Write-Host "User: $supabaseUser" -ForegroundColor Gray
} else {
    Write-Host "❌ Không thể parse Supabase connection string!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Bước 3: Import database vào Supabase (đúng flow: psql -h host -U user -d database -f dump.sql)
Write-Host "=== Bước 3: Import Database vào Supabase ===" -ForegroundColor Cyan
Write-Host "Đang import dump.sql vào Supabase..." -ForegroundColor Yellow
Write-Host "Command: psql -h $supabaseHost -U $supabaseUser -d $supabaseDatabase -f dump.sql" -ForegroundColor Gray
Write-Host ""

# Set password environment variable
$env:PGPASSWORD = $supabasePassword

# Import với psql command line (đúng flow)
$importArgs = @(
    "-h", $supabaseHost,
    "-p", $supabasePort,
    "-U", $supabaseUser,
    "-d", $supabaseDatabase,
    "-f", "`"$dumpFile`""
)

$importResult = & $psqlPath $importArgs 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi khi import database:" -ForegroundColor Red
    Write-Host $importResult -ForegroundColor Red
    Write-Host ""
    Write-Host "⚠️  Một số lỗi có thể không nghiêm trọng. Vui lòng kiểm tra lại dữ liệu." -ForegroundColor Yellow
} else {
    Write-Host "✅ Đã import database thành công" -ForegroundColor Green
}
Write-Host ""

# Bước 4: Kiểm tra tables và data
Write-Host "=== Bước 4: Kiểm tra Tables và Data ===" -ForegroundColor Cyan
Write-Host "Đang kiểm tra..." -ForegroundColor Yellow

$checkArgs = @(
    "-h", $supabaseHost,
    "-p", $supabasePort,
    "-U", $supabaseUser,
    "-d", $supabaseDatabase,
    "-c", "SELECT schemaname, tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;"
)

$checkResult = & $psqlPath $checkArgs 2>&1
Write-Host $checkResult -ForegroundColor Cyan
Write-Host ""

# Kiểm tra số lượng bản ghi trong một số bảng chính
Write-Host "Đang kiểm tra số lượng bản ghi..." -ForegroundColor Yellow
$countTables = @("users", "vocabulary", "sentences", "vocabulary_categories", "sentence_categories")
foreach ($table in $countTables) {
    $countArgs = @(
        "-h", $supabaseHost,
        "-p", $supabasePort,
        "-U", $supabaseUser,
        "-d", $supabaseDatabase,
        "-c", "SELECT COUNT(*) as count FROM $table;"
    )
    $countResult = & $psqlPath $countArgs 2>&1 | Select-String -Pattern "count|rows"
    if ($countResult) {
        Write-Host "  $table : $countResult" -ForegroundColor Gray
    }
}
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
Write-Host "=== Migration hoan tat! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Tom tat:" -ForegroundColor Cyan
Write-Host "  - File dump: $dumpFile" -ForegroundColor White
Write-Host "  - Supabase Host: $supabaseHost" -ForegroundColor White
Write-Host "  - Database: $supabaseDatabase" -ForegroundColor White
Write-Host ""
Write-Host "Luu y:" -ForegroundColor Yellow
Write-Host "1. Kiem tra lai du lieu tren Supabase Dashboard" -ForegroundColor White
Write-Host "2. Cap nhat DATABASE_URL trong file .env" -ForegroundColor White
Write-Host "3. Chay npx prisma generate" -ForegroundColor White
Write-Host ""
