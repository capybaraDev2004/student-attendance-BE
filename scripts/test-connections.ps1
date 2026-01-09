# Script kiểm tra kết nối đến database local và Supabase
# Sử dụng: .\test-connections.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$LocalDatabaseUrl = "",
    
    [Parameter(Mandatory=$false)]
    [string]$SupabaseUrl = "postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres"
)

Write-Host "=== Test Database Connections ===" -ForegroundColor Cyan
Write-Host ""

# Tìm psql
$pgVersions = @("18", "17", "16", "15", "14", "13", "12")
$psqlPath = $null

foreach ($version in $pgVersions) {
    $pgBin = "C:\Program Files\PostgreSQL\$version\bin"
    $sqlPath = Join-Path $pgBin "psql.exe"
    
    if (Test-Path $sqlPath) {
        $psqlPath = $sqlPath
        Write-Host "✅ Tìm thấy PostgreSQL $version" -ForegroundColor Green
        break
    }
}

if (-not $psqlPath) {
    Write-Host "❌ Không tìm thấy psql!" -ForegroundColor Red
    exit 1
}

# Nếu không có LocalDatabaseUrl, yêu cầu nhập
if ([string]::IsNullOrWhiteSpace($LocalDatabaseUrl)) {
    Write-Host "Nhập connection string của database LOCAL (hoặc Enter để bỏ qua):" -ForegroundColor Yellow
    $LocalDatabaseUrl = Read-Host "Local DATABASE_URL"
}

Write-Host ""

# Test Local Database
if (-not [string]::IsNullOrWhiteSpace($LocalDatabaseUrl)) {
    Write-Host "=== Test Local Database ===" -ForegroundColor Cyan
    Write-Host "Connection: $LocalDatabaseUrl" -ForegroundColor Gray
    
    $testLocalArgs = @(
        "-c", "SELECT version();",
        $LocalDatabaseUrl
    )
    
    $localResult = & $psqlPath $testLocalArgs 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Kết nối Local Database thành công!" -ForegroundColor Green
        Write-Host $localResult -ForegroundColor Gray
    } else {
        Write-Host "❌ Không thể kết nối đến Local Database!" -ForegroundColor Red
        Write-Host $localResult -ForegroundColor Red
    }
    Write-Host ""
} else {
    Write-Host "⚠️  Bỏ qua test Local Database" -ForegroundColor Yellow
    Write-Host ""
}

# Test Supabase
Write-Host "=== Test Supabase Database ===" -ForegroundColor Cyan
Write-Host "Connection: $SupabaseUrl" -ForegroundColor Gray

$testSupabaseArgs = @(
    "-c", "SELECT version();",
    $SupabaseUrl
)

$supabaseResult = & $psqlPath $testSupabaseArgs 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Kết nối Supabase thành công!" -ForegroundColor Green
    Write-Host $supabaseResult -ForegroundColor Gray
} else {
    Write-Host "❌ Không thể kết nối đến Supabase!" -ForegroundColor Red
    Write-Host $supabaseResult -ForegroundColor Red
    Write-Host ""
    Write-Host "⚠️  Vui lòng kiểm tra:" -ForegroundColor Yellow
    Write-Host "  1. Connection string đúng" -ForegroundColor White
    Write-Host "  2. Internet connection" -ForegroundColor White
    Write-Host "  3. Supabase database đang hoạt động" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "=== ✅ Test hoàn tất ===" -ForegroundColor Green
Write-Host ""
