const fs = require('fs');
const path = require('path');

/**
 * Script để clean file SQL dump, loại bỏ các psql meta-commands
 * để tương thích với Supabase SQL Editor
 * Sử dụng: node scripts/clean_sql_for_supabase.js
 */

const inputFile = path.join(__dirname, 'temp_migration', 'dump_final.sql');
const outputFile = path.join(__dirname, 'temp_migration', 'dump_final_clean.sql');
const backupFile = path.join(__dirname, 'temp_migration', 'dump_final_backup_before_clean.sql');

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

// Các psql meta-commands cần loại bỏ
const psqlCommands = [
  '\\connect',
  '\\c',
  '\\restrict',
  '\\set',
  '\\echo',
  '\\timing',
  '\\setenv',
  '\\cd',
  '\\copy',
  '\\!',
  '\\g',
  '\\gx',
  '\\gexec',
  '\\watch',
  '\\encoding',
  '\\password',
  '\\conninfo',
  '\\host',
  '\\dbname',
  '\\port',
  '\\user',
  '\\prompt',
];

let removedCount = 0;
let cleanedLines = [];
let inCopyBlock = false;
let copyTableName = '';

for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  const trimmed = line.trim();
  
  // Loại bỏ các dòng bắt đầu bằng \ (psql meta-commands)
  // Trừ \. (end of COPY block) và các dòng trong COPY block
  if (trimmed.startsWith('\\') && trimmed !== '\\.') {
    // Kiểm tra xem có phải là psql meta-command không
    const isMetaCommand = psqlCommands.some(cmd => 
      trimmed.toLowerCase().startsWith(cmd.toLowerCase())
    );
    
    if (isMetaCommand) {
      console.log(`   → Loại bỏ psql command: ${trimmed.substring(0, 50)}`);
      removedCount++;
      continue;
    }
    
    // Nếu không phải meta-command đã biết, nhưng bắt đầu bằng \
    // và không phải là comment hoặc \. thì cũng loại bỏ
    if (!trimmed.startsWith('\\--') && trimmed !== '\\.') {
      console.log(`   ⚠️  Loại bỏ dòng không rõ: ${trimmed.substring(0, 50)}`);
      removedCount++;
      continue;
    }
  }
  
  // Xử lý COPY blocks
  if (trimmed.toUpperCase().startsWith('COPY ') && trimmed.includes('FROM stdin')) {
    inCopyBlock = true;
    // Extract table name
    const match = trimmed.match(/COPY\s+(\S+)\s+/i);
    if (match) {
      copyTableName = match[1];
    }
    cleanedLines.push(line);
    continue;
  }
  
  // Kết thúc COPY block
  if (trimmed === '\\.') {
    inCopyBlock = false;
    cleanedLines.push(line);
    continue;
  }
  
  // Giữ lại tất cả các dòng khác
  cleanedLines.push(line);
}

console.log(`\n📊 Kết quả:`);
console.log(`   - Đã loại bỏ ${removedCount} dòng psql meta-commands`);
console.log(`   - Số dòng sau khi clean: ${cleanedLines.length}`);

// Ghi file đã clean
const cleanedContent = cleanedLines.join('\n');
fs.writeFileSync(outputFile, cleanedContent, 'utf8');

console.log(`✅ Đã tạo file clean: ${outputFile}`);

// Thay thế file gốc
fs.writeFileSync(inputFile, cleanedContent, 'utf8');
console.log(`✅ Đã cập nhật file gốc: ${inputFile}`);

// Verify file không còn psql commands
const verifyContent = fs.readFileSync(outputFile, 'utf8');
const remainingCommands = psqlCommands.filter(cmd => 
  new RegExp(`^\\\\${cmd.replace('\\', '')}`, 'im').test(verifyContent)
);

if (remainingCommands.length > 0) {
  console.log(`\n⚠️  Vẫn còn một số commands: ${remainingCommands.join(', ')}`);
} else {
  console.log(`\n✅ File đã sạch, không còn psql meta-commands!`);
}

// Verify encoding vẫn đúng
const vietnameseCount = (cleanedContent.match(/Chào|hỏi|giới|thiệu|Việt|Nam/gi) || []).length;
console.log(`\n✅ Encoding UTF-8: ${vietnameseCount} ký tự tiếng Việt đúng`);

console.log(`\n✨ Hoàn thành! File đã sẵn sàng để import vào Supabase.`);
