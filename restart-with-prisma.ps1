# Script để restart server sau khi generate Prisma Client
Write-Host "Đang dừng tất cả Node processes..." -ForegroundColor Yellow

# Dừng các process Node.js đang chạy server
Get-Process node -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -eq "" -or $_.Path -like "*learningChinese*" } | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "Đang chờ 2 giây..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

Write-Host "Đang generate Prisma Client..." -ForegroundColor Green
npx prisma generate

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Prisma Client đã được generate thành công!" -ForegroundColor Green
    Write-Host "Bạn có thể khởi động lại server bằng: npm run dev" -ForegroundColor Cyan
} else {
    Write-Host "❌ Lỗi khi generate Prisma Client" -ForegroundColor Red
}

