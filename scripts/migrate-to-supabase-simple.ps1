# Script migrate đơn giản - Chỉ cần chạy và nhập thông tin
# Sử dụng: .\migrate-to-supabase-simple.ps1

Write-Host "=== Migrate Database to Supabase (Simple) ===" -ForegroundColor Cyan
Write-Host ""

# Connection string Supabase (đã cung cấp)
$SupabaseUrl = "postgresql://postgres:bich10091998@db.nccehlxhghzfowssxluf.supabase.co:5432/postgres"

# Yêu cầu nhập connection string local
Write-Host "Nhập connection string của database LOCAL:" -ForegroundColor Yellow
Write-Host "Ví dụ: postgresql://postgres:password@localhost:5432/learning_chinese?schema=public" -ForegroundColor Gray
Write-Host ""
$LocalDatabaseUrl = Read-Host "Local DATABASE_URL"

if ([string]::IsNullOrWhiteSpace($LocalDatabaseUrl)) {
    Write-Host "❌ Connection string không được để trống!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Bạn có chắc chắn muốn migrate dữ liệu?" -ForegroundColor Yellow
Write-Host "Local: $LocalDatabaseUrl" -ForegroundColor Cyan
Write-Host "Supabase: $SupabaseUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  CẢNH BÁO: Dữ liệu hiện có trên Supabase sẽ bị xóa!" -ForegroundColor Red
Write-Host "Nhấn Enter để tiếp tục hoặc Ctrl+C để hủy..." -ForegroundColor Yellow
Read-Host

# Gọi script chính
$scriptPath = Join-Path $PSScriptRoot "migrate-to-supabase.ps1"
& $scriptPath -LocalDatabaseUrl $LocalDatabaseUrl -SupabaseUrl $SupabaseUrl
