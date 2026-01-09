# Script chuyển đổi COPY FROM stdin thành INSERT statements cho Supabase
# Sử dụng: .\convert-copy-to-insert.ps1

$inputFile = "dump_clean.sql"
$outputFile = "dump_final.sql"

Write-Host "=== Convert COPY to INSERT ===" -ForegroundColor Cyan
Write-Host "Input: $inputFile" -ForegroundColor Gray
Write-Host "Output: $outputFile" -ForegroundColor Gray
Write-Host ""

if (-not (Test-Path $inputFile)) {
    Write-Host "❌ Không tìm thấy file: $inputFile" -ForegroundColor Red
    exit 1
}

# Đọc file với encoding UTF8 (không BOM)
$lines = [System.IO.File]::ReadAllLines((Resolve-Path $inputFile), [System.Text.Encoding]::UTF8)
$output = New-Object System.Collections.ArrayList
$inCopyBlock = $false
$copyTable = $null
$copyColumns = @()
$copyData = New-Object System.Collections.ArrayList
$lineNumber = 0

foreach ($line in $lines) {
    $lineNumber++
    
    # Kiểm tra COPY command
    if ($line -match '^COPY\s+(\S+)\s+\(([^)]+)\)\s+FROM\s+stdin;') {
        $inCopyBlock = $true
        $copyTable = $matches[1]
        $copyColumns = $matches[2] -split '\s*,\s*'
        $copyData.Clear()
        Write-Host "  Tìm thấy COPY: $copyTable (dòng $lineNumber)" -ForegroundColor Yellow
        continue
    }
    
    # Kiểm tra kết thúc COPY block
    if ($inCopyBlock -and $line -eq '\.') {
        $inCopyBlock = $false
        
        # Chuyển đổi data thành INSERT statements
        if ($copyData.Count -gt 0) {
            Write-Host "    Đang chuyển đổi $($copyData.Count) bản ghi..." -ForegroundColor Gray
            
            # Tạo INSERT statement cho mỗi row
            foreach ($dataLine in $copyData) {
                if ([string]::IsNullOrWhiteSpace($dataLine)) {
                    continue
                }
                
                # Parse tab-separated values
                $values = $dataLine -split "`t"
                
                # Escape và format values
                $formattedValues = @()
                for ($i = 0; $i -lt $values.Length; $i++) {
                    $value = $values[$i]
                    
                    if ($value -eq '\N' -or [string]::IsNullOrWhiteSpace($value)) {
                        $formattedValues += "NULL"
                    } elseif ($value -match '^[0-9]+$') {
                        # Number
                        $formattedValues += $value
                    } elseif ($value -match '^[tf]$') {
                        # Boolean
                        $formattedValues += if ($value -eq 't') { "true" } else { "false" }
                    } else {
                        # String - escape single quotes và backslashes
                        $escaped = $value -replace "\\", "\\\\" -replace "'", "''"
                        # Sử dụng format Unicode string
                        $formattedValues += "'$escaped'"
                    }
                }
                
                # Tạo INSERT statement
                $columnsStr = ($copyColumns | ForEach-Object { "`"$_`"" }) -join ", "
                $valuesStr = $formattedValues -join ", "
                $insert = "INSERT INTO $copyTable ($columnsStr) VALUES ($valuesStr);"
                [void]$output.Add($insert)
            }
        }
        
        $copyTable = $null
        $copyColumns = @()
        continue
    }
    
    # Nếu đang trong COPY block, lưu data
    if ($inCopyBlock) {
        [void]$copyData.Add($line)
        continue
    }
    
    # Các dòng khác giữ nguyên
    [void]$output.Add($line)
}

# Ghi file output
$output | Out-File -FilePath $outputFile -Encoding UTF8 -NoNewline
$separator = "`r`n"
$content = [string]::Join($separator, $output.ToArray())
[System.IO.File]::WriteAllText((Resolve-Path $outputFile), $content, [System.Text.Encoding]::UTF8)

Write-Host ""
Write-Host "✅ Hoàn tất!" -ForegroundColor Green
Write-Host "  File gốc: $((Get-Item $inputFile).Length) bytes" -ForegroundColor Gray
Write-Host "  File mới: $((Get-Item $outputFile).Length) bytes" -ForegroundColor Gray
Write-Host "  Số dòng gốc: $($lines.Count)" -ForegroundColor Gray
Write-Host "  Số dòng mới: $($output.Count)" -ForegroundColor Gray
Write-Host ""
Write-Host "File đã sẵn sàng để import vào Supabase: $outputFile" -ForegroundColor Cyan
Write-Host ""
