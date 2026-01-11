# Script để dump database với encoding UTF-8 đúng cách cho tiếng Việt
# Sử dụng: .\dump_with_utf8.ps1

param(
    [string]$DatabaseUrl = $env:DATABASE_URL,
    [string]$OutputFile = "scripts\temp_migration\dump_final_utf8.sql"
)

Write-Host "🔄 Đang dump database với encoding UTF-8..." -ForegroundColor Cyan

if (-not $DatabaseUrl) {
    Write-Host "❌ Cần set DATABASE_URL environment variable hoặc truyền vào parameter" -ForegroundColor Red
    Write-Host "   Ví dụ: `$env:DATABASE_URL='postgresql://user:pass@host:port/db'" -ForegroundColor Yellow
    exit 1
}

# Parse DATABASE_URL
if ($DatabaseUrl -match "postgresql://([^:]+):([^@]+)@([^:]+):(\d+)/(.+)") {
    $user = $matches[1]
    $pass = $matches[2]
    $host = $matches[3]
    $port = $matches[4]
    $db = $matches[5]
    
    Write-Host "📋 Database: $db @ $host:$port" -ForegroundColor Green
    
    # Tạo pg_dump command với encoding UTF-8
    $env:PGPASSWORD = $pass
    
    # Dump với encoding UTF-8
    $dumpCommand = "pg_dump -h $host -p $port -U $user -d $db --encoding=UTF8 --no-owner --no-acl -F p > $OutputFile"
    
    Write-Host "🚀 Đang chạy: pg_dump với encoding UTF-8..." -ForegroundColor Cyan
    
    # Chạy pg_dump
    try {
        & pg_dump -h $host -p $port -U $user -d $db --encoding=UTF8 --no-owner --no-acl | Out-File -FilePath $OutputFile -Encoding UTF8
        Write-Host "✅ Đã dump thành công vào: $OutputFile" -ForegroundColor Green
        
        # Verify file
        $fileContent = Get-Content $OutputFile -Encoding UTF8 -Raw
        if ($fileContent -match "Chào|hỏi|giới") {
            Write-Host "✅ Encoding UTF-8 đúng! Tiếng Việt hiển thị chính xác." -ForegroundColor Green
        } else {
            Write-Host "⚠️  Cảnh báo: Có thể vẫn còn vấn đề encoding" -ForegroundColor Yellow
        }
        
    } catch {
        Write-Host "❌ Lỗi khi dump: $_" -ForegroundColor Red
        exit 1
    } finally {
        $env:PGPASSWORD = $null
    }
    
} else {
    Write-Host "❌ DATABASE_URL không đúng format" -ForegroundColor Red
    Write-Host "   Format: postgresql://user:password@host:port/database" -ForegroundColor Yellow
    exit 1
}
