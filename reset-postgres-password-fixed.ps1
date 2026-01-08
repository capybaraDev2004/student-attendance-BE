# Script reset mật khẩu PostgreSQL - Phiên bản đã sửa
# CHẠY VỚI QUYỀN ADMINISTRATOR

param(
    [Parameter(Mandatory=$true)]
    [string]$NewPassword
)

Write-Host "=== Reset PostgreSQL Password (Fixed Version) ===" -ForegroundColor Cyan
Write-Host ""

# Đường dẫn PostgreSQL
$pgVersion = "18"
$pgBase = "C:\Program Files\PostgreSQL\$pgVersion"
$pgBin = Join-Path $pgBase "bin"
$pgData = Join-Path $pgBase "data"
$psqlPath = Join-Path $pgBin "psql.exe"
$pgHbaPath = Join-Path $pgData "pg_hba.conf"

# Kiểm tra
if (-not (Test-Path $psqlPath)) {
    Write-Host "ERROR: Không tìm thấy psql.exe!" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $pgHbaPath)) {
    Write-Host "ERROR: Không tìm thấy pg_hba.conf!" -ForegroundColor Red
    exit 1
}

Write-Host "PostgreSQL: $pgBase" -ForegroundColor Green
Write-Host ""

# Tìm service
$service = Get-Service | Where-Object { 
    $_.Name -like "*postgresql*" -or 
    $_.DisplayName -like "*postgresql*" -or
    $_.Name -like "*postgres*"
} | Select-Object -First 1

if (-not $service) {
    Write-Host "ERROR: Không tìm thấy PostgreSQL service!" -ForegroundColor Red
    exit 1
}

Write-Host "Service: $($service.Name) - Status: $($service.Status)" -ForegroundColor Green
Write-Host ""

# Backup
Write-Host "=== Bước 1: Backup pg_hba.conf ===" -ForegroundColor Cyan
$backupPath = "$pgHbaPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
Copy-Item $pgHbaPath $backupPath -Force
Write-Host "✅ Backup: $backupPath" -ForegroundColor Green
Write-Host ""

# Đọc file với encoding ASCII
Write-Host "=== Bước 2: Sửa pg_hba.conf ===" -ForegroundColor Cyan
$content = [System.IO.File]::ReadAllText($pgHbaPath, [System.Text.Encoding]::ASCII)
$lines = $content -split "`r?`n"
$newLines = @()
$modified = $false

foreach ($line in $lines) {
    $trimmed = $line.Trim()
    
    # Bỏ qua comment và dòng trống
    if ($trimmed -match "^#" -or $trimmed -eq "") {
        $newLines += $line
        continue
    }
    
    # Sửa các dòng authentication
    if ($trimmed -match "^local\s+all\s+postgres\s+") {
        $newLines += "local   all             postgres                                trust"
        $modified = $true
        Write-Host "  Đã sửa: local postgres -> trust" -ForegroundColor Yellow
    }
    elseif ($trimmed -match "^host\s+all\s+all\s+127\.0\.0\.1/32\s+") {
        $newLines += "host    all             all             127.0.0.1/32            trust"
        $modified = $true
        Write-Host "  Đã sửa: host 127.0.0.1 -> trust" -ForegroundColor Yellow
    }
    elseif ($trimmed -match "^host\s+all\s+all\s+::1/128\s+") {
        $newLines += "host    all             all             ::1/128                 trust"
        $modified = $true
        Write-Host "  Đã sửa: host ::1 -> trust" -ForegroundColor Yellow
    }
    else {
        $newLines += $line
    }
}

# Thêm dòng mới nếu cần
if (-not $modified) {
    Write-Host "  Thêm dòng mới..." -ForegroundColor Yellow
    $newLines += ""
    $newLines += "# Temporary trust for password reset"
    $newLines += "host    all             all             127.0.0.1/32            trust"
    $newLines += "local   all             postgres                                trust"
}

# Ghi file với encoding ASCII (không BOM)
$newContent = $newLines -join "`r`n"
[System.IO.File]::WriteAllText($pgHbaPath, $newContent, [System.Text.Encoding]::ASCII)
Write-Host "✅ Đã cập nhật pg_hba.conf" -ForegroundColor Green
Write-Host ""

# Restart service
Write-Host "=== Bước 3: Restart PostgreSQL service ===" -ForegroundColor Cyan
Write-Host "Đang dừng service..." -ForegroundColor Yellow
Stop-Service -Name $service.Name -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3

Write-Host "Đang khởi động service..." -ForegroundColor Yellow
Start-Service -Name $service.Name
Start-Sleep -Seconds 5

$serviceStatus = (Get-Service -Name $service.Name).Status
if ($serviceStatus -ne "Running") {
    Write-Host "❌ Service không khởi động được!" -ForegroundColor Red
    Write-Host "Đang khôi phục backup..." -ForegroundColor Yellow
    Copy-Item $backupPath $pgHbaPath -Force
    Restart-Service -Name $service.Name -Force
    exit 1
}

Write-Host "✅ Service đã khởi động" -ForegroundColor Green
Write-Host ""

# Đặt lại mật khẩu
Write-Host "=== Bước 4: Đặt lại mật khẩu ===" -ForegroundColor Cyan
$escapedPassword = $NewPassword.Replace("'", "''")
$sqlCommand = "ALTER USER postgres WITH PASSWORD '$escapedPassword';"

Write-Host "Đang thực thi SQL..." -ForegroundColor Yellow
$env:PGPASSWORD = ""

$result = & $psqlPath -U postgres -d postgres -c $sqlCommand 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Đã đặt lại mật khẩu thành công!" -ForegroundColor Green
} else {
    Write-Host "❌ Lỗi khi đặt lại mật khẩu:" -ForegroundColor Red
    Write-Host $result -ForegroundColor Red
    Write-Host ""
    Write-Host "Đang khôi phục backup..." -ForegroundColor Yellow
    Copy-Item $backupPath $pgHbaPath -Force
    Restart-Service -Name $service.Name -Force
    exit 1
}

Write-Host ""

# Khôi phục pg_hba.conf
Write-Host "=== Bước 5: Khôi phục pg_hba.conf ===" -ForegroundColor Cyan
Copy-Item $backupPath $pgHbaPath -Force
Write-Host "✅ Đã khôi phục pg_hba.conf" -ForegroundColor Green

# Restart lại service
Write-Host "Đang restart service..." -ForegroundColor Yellow
Restart-Service -Name $service.Name -Force
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "=== ✅ Hoàn tất! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Mật khẩu mới: $NewPassword" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  CẬP NHẬT FILE .env:" -ForegroundColor Yellow
Write-Host "DATABASE_URL=postgresql://postgres:$NewPassword@localhost:5432/learning_chinese?schema=public" -ForegroundColor White
Write-Host ""

