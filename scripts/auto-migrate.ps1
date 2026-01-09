# Script tự động migrate - Thử các connection string phổ biến
# Sử dụng: .\auto-migrate.ps1

$SupabaseUrl = "postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres"

# Danh sách connection string phổ biến để thử
$commonConnections = @(
    "postgresql://postgres@localhost:5432/learning_chinese?schema=public",
    "postgresql://postgres:postgres@localhost:5432/learning_chinese?schema=public",
    "postgresql://postgres:admin@localhost:5432/learning_chinese?schema=public",
    "postgresql://postgres:123456@localhost:5432/learning_chinese?schema=public",
    "postgresql://postgres@localhost:5432/postgres?schema=public",
    "postgresql://postgres:postgres@localhost:5432/postgres?schema=public"
)

Write-Host "=== Auto Migrate to Supabase ===" -ForegroundColor Cyan
Write-Host "Đang thử kết nối đến database local..." -ForegroundColor Yellow
Write-Host ""

# Tìm psql
$pgVersions = @("18", "17", "16", "15", "14", "13", "12")
$psqlPath = $null

foreach ($version in $pgVersions) {
    $pgBin = "C:\Program Files\PostgreSQL\$version\bin"
    $sqlPath = Join-Path $pgBin "psql.exe"
    
    if (Test-Path $sqlPath) {
        $psqlPath = $sqlPath
        break
    }
}

if (-not $psqlPath) {
    Write-Host "❌ Không tìm thấy psql!" -ForegroundColor Red
    Write-Host "Vui lòng cài đặt PostgreSQL" -ForegroundColor Yellow
    exit 1
}

# Thử kết nối với các connection string phổ biến
$localDbUrl = $null
foreach ($connStr in $commonConnections) {
    Write-Host "Thử: $connStr" -ForegroundColor Gray
    $testArgs = @("-c", "SELECT 1;", $connStr)
    $result = & $psqlPath $testArgs 2>&1 | Out-String
    
    if ($LASTEXITCODE -eq 0) {
        $localDbUrl = $connStr
        Write-Host "✅ Tìm thấy database local!" -ForegroundColor Green
        Write-Host "Connection: $localDbUrl" -ForegroundColor Cyan
        break
    }
}

# Nếu không tìm thấy, yêu cầu nhập
if (-not $localDbUrl) {
    Write-Host ""
    Write-Host "❌ Không thể tự động tìm thấy database local" -ForegroundColor Red
    Write-Host "Vui lòng nhập connection string thủ công:" -ForegroundColor Yellow
    Write-Host "Ví dụ: postgresql://postgres:password@localhost:5432/learning_chinese?schema=public" -ForegroundColor Gray
    Write-Host ""
    $localDbUrl = Read-Host "Local DATABASE_URL"
    
    if ([string]::IsNullOrWhiteSpace($localDbUrl)) {
        Write-Host "❌ Connection string không được để trống!" -ForegroundColor Red
        exit 1
    }
    
    # Test connection
    Write-Host "Đang kiểm tra kết nối..." -ForegroundColor Yellow
    $testArgs = @("-c", "SELECT 1;", $localDbUrl)
    $result = & $psqlPath $testArgs 2>&1 | Out-String
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Không thể kết nối đến database local!" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✅ Kết nối thành công!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Bắt đầu migrate ===" -ForegroundColor Cyan
Write-Host ""

# Gọi script migrate chính
$migrateScript = Join-Path $PSScriptRoot "migrate-to-supabase.ps1"
& $migrateScript -LocalDatabaseUrl $localDbUrl -SupabaseUrl $SupabaseUrl
