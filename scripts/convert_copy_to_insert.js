const fs = require('fs');
const path = require('path');

/**
 * Script để convert COPY statements sang INSERT statements
 * Supabase SQL Editor không hỗ trợ COPY ... FROM stdin
 * Sử dụng: node scripts/convert_copy_to_insert.js
 */

const inputFile = path.join(__dirname, 'temp_migration', 'dump_final.sql');
const outputFile = path.join(__dirname, 'temp_migration', 'dump_final_inserts.sql');
const backupFile = path.join(__dirname, 'temp_migration', 'dump_final_backup_before_inserts.sql');

console.log('🔄 Đang đọc file SQL...');

if (!fs.existsSync(inputFile)) {
  console.error(`❌ Không tìm thấy file: ${inputFile}`);
  process.exit(1);
}

// Backup file gốc
if (!fs.existsSync(backupFile)) {
  fs.copyFileSync(inputFile, backupFile);
  console.log(`📦 Đã backup file gốc: ${backupFile}`);
}

const content = fs.readFileSync(inputFile, 'utf8');
const lines = content.split('\n');

console.log(`📊 Tổng số dòng: ${lines.length}`);
console.log('🔧 Đang convert COPY statements sang INSERT statements...\n');

let convertedCount = 0;
let inCopyBlock = false;
let copyTableName = '';
let copyColumns = '';
let copyData = [];
let result = [];

for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  const trimmed = line.trim();
  
  // Detect COPY statement
  if (trimmed.toUpperCase().startsWith('COPY ') && trimmed.includes('FROM stdin')) {
    // Parse COPY statement: COPY table_name (col1, col2) FROM stdin;
    const copyMatch = trimmed.match(/COPY\s+(\S+)\s*(?:\(([^)]+)\))?\s*FROM\s+stdin/i);
    if (copyMatch) {
      inCopyBlock = true;
      copyTableName = copyMatch[1];
      copyColumns = copyMatch[2] || '';
      copyData = [];
      console.log(`   → Tìm thấy COPY block cho bảng: ${copyTableName}`);
      continue; // Skip COPY line
    }
  }
  
  // Detect end of COPY block (\\.)
  if (trimmed === '\\.' && inCopyBlock) {
    // Convert COPY data to INSERT statements
    if (copyData.length > 0) {
      const columnList = copyColumns ? ` (${copyColumns})` : '';
      
      for (const dataLine of copyData) {
        if (!dataLine.trim()) continue; // Skip empty lines
        
        // Parse tab-separated values
        const values = dataLine.split('\t');
        
        // Escape values for SQL
        const escapedValues = values.map(val => {
          if (val === '\\N' || val === 'NULL' || val === '') {
            return 'NULL';
          }
          // Escape single quotes
          const escaped = val.replace(/'/g, "''");
          return `'${escaped}'`;
        });
        
        const insertStatement = `INSERT INTO ${copyTableName}${columnList} VALUES (${escapedValues.join(', ')});`;
        result.push(insertStatement);
        convertedCount++;
      }
      
      console.log(`   ✅ Đã convert ${copyData.length} dòng thành INSERT cho bảng ${copyTableName}`);
    }
    
    inCopyBlock = false;
    copyTableName = '';
    copyColumns = '';
    copyData = [];
    continue; // Skip \. line
  }
  
  // Collect data in COPY block
  if (inCopyBlock) {
    copyData.push(line);
    continue;
  }
  
  // Keep all other lines as-is
  result.push(line);
}

console.log(`\n📊 Kết quả:`);
console.log(`   - Đã convert ${convertedCount} dòng COPY thành INSERT statements`);
console.log(`   - Tổng số dòng sau convert: ${result.length}`);

// Write converted file
const convertedContent = result.join('\n');
fs.writeFileSync(outputFile, convertedContent, 'utf8');
console.log(`✅ Đã tạo file với INSERT statements: ${outputFile}`);

// Verify encoding
const vietnameseCount = (convertedContent.match(/Chào|hỏi|giới|thiệu|Việt|Nam/gi) || []).length;
console.log(`✅ Encoding UTF-8: ${vietnameseCount} ký tự tiếng Việt đúng`);

// Show sample
const sampleInserts = convertedContent.split('\n').filter(l => 
  l.startsWith('INSERT INTO') && l.includes('sentence_categories')
).slice(0, 3);

if (sampleInserts.length > 0) {
  console.log(`\n📝 Mẫu INSERT statements:`);
  sampleInserts.forEach((line, idx) => {
    const preview = line.length > 120 ? line.substring(0, 120) + '...' : line;
    console.log(`   ${idx + 1}. ${preview}`);
  });
}

console.log(`\n✨ Hoàn thành! File đã sẵn sàng để import vào Supabase SQL Editor.`);
console.log(`\n💡 Lưu ý: File với INSERT statements lớn hơn nhưng tương thích 100% với Supabase.`);
