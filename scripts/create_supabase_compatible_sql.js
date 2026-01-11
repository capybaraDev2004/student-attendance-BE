const fs = require('fs');
const path = require('path');

/**
 * Script để tạo file SQL tương thích với Supabase SQL Editor
 * Loại bỏ các SET commands và psql-specific statements
 * Sử dụng: node scripts/create_supabase_compatible_sql.js
 */

const inputFile = path.join(__dirname, 'temp_migration', 'dump_final.sql');
const outputFile = path.join(__dirname, 'temp_migration', 'dump_final_supabase.sql');

console.log('🔄 Đang đọc file SQL...');

if (!fs.existsSync(inputFile)) {
  console.error(`❌ Không tìm thấy file: ${inputFile}`);
  process.exit(1);
}

const content = fs.readFileSync(inputFile, 'utf8');
const lines = content.split('\n');

console.log(`📊 Tổng số dòng: ${lines.length}`);
console.log('🔧 Đang tạo file tương thích với Supabase...\n');

let result = [];
let skipCount = 0;

// Các SET commands không cần thiết cho Supabase
const skipPatterns = [
  /^SET\s+statement_timeout/i,
  /^SET\s+lock_timeout/i,
  /^SET\s+idle_in_transaction_session_timeout/i,
  /^SET\s+transaction_timeout/i,
  /^SET\s+standard_conforming_strings/i,
  /^SET\s+check_function_bodies/i,
  /^SET\s+xmloption/i,
  /^SET\s+client_min_messages/i,
  /^SET\s+row_security/i,
  /^SET\s+default_tablespace/i,
  /^SET\s+default_table_access_method/i,
  /^SELECT\s+pg_catalog\.set_config/i,
];

// Các psql meta-commands cần loại bỏ hoàn toàn
const psqlMetaCommands = [
  /^\\restrict/i,
  /^\\connect/i,
  /^\\c\s/i,
  /^\\setenv/i,
  /^\\cd/i,
  /^\\echo/i,
  /^\\timing/i,
  /^\\!/i,
  /^\\g/i,
  /^\\gx/i,
  /^\\gexec/i,
  /^\\watch/i,
];

for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  const trimmed = line.trim();
  
  // Skip các dòng bắt đầu bằng \ (psql meta-commands) - trừ \. và comments
  if (trimmed.startsWith('\\') && !trimmed.startsWith('\\--') && trimmed !== '\\.') {
    // Check nếu là psql meta-command
    let isMetaCommand = false;
    for (const pattern of psqlMetaCommands) {
      if (pattern.test(trimmed)) {
        isMetaCommand = true;
        console.log(`   → Loại bỏ psql meta-command: ${trimmed.substring(0, 50)}`);
        skipCount++;
        break;
      }
    }
    // Nếu là bất kỳ dòng nào bắt đầu bằng \ và không phải comment
    if (!isMetaCommand && !trimmed.match(/^\\\s*$/)) {
      console.log(`   ⚠️  Loại bỏ dòng có \\: ${trimmed.substring(0, 50)}`);
      skipCount++;
    }
    if (isMetaCommand || !trimmed.match(/^\\\s*$/)) {
      continue;
    }
  }
  
  // Skip các SET commands không cần thiết
  let shouldSkip = false;
  for (const pattern of skipPatterns) {
    if (pattern.test(trimmed)) {
      shouldSkip = true;
      skipCount++;
      break;
    }
  }
  
  if (shouldSkip) {
    continue;
  }
  
  // Skip các dòng trống ở đầu file
  if (result.length === 0 && !trimmed) {
    continue;
  }
  
  // Giữ lại tất cả các dòng khác
  result.push(line);
}

console.log(`📊 Đã loại bỏ ${skipCount} dòng SET commands không cần thiết`);
console.log(`📊 Số dòng còn lại: ${result.length}`);

// Remove leading/trailing empty lines
while (result.length > 0 && !result[0].trim()) {
  result.shift();
}
while (result.length > 0 && !result[result.length - 1].trim()) {
  result.pop();
}

// Loại bỏ duplicate SET client_encoding
const cleanedResult = [];
let hasSetEncoding = false;
for (const line of result) {
  if (line.trim().toUpperCase() === "SET CLIENT_ENCODING = 'UTF8';" || 
      line.trim().toUpperCase() === "SET client_encoding = 'UTF8';") {
    if (!hasSetEncoding) {
      cleanedResult.push(line);
      hasSetEncoding = true;
    }
    // Skip duplicate
  } else {
    cleanedResult.push(line);
  }
}

// Thêm SET client_encoding = 'UTF8' ở đầu (quan trọng cho Supabase) nếu chưa có
const finalContent = hasSetEncoding 
  ? cleanedResult.join('\n')
  : [
      "-- Supabase-compatible SQL dump",
      "-- Generated from PostgreSQL dump",
      "",
      "SET client_encoding = 'UTF8';",
      "",
      ...cleanedResult
    ].join('\n');

// Write file
fs.writeFileSync(outputFile, finalContent, 'utf8');
console.log(`✅ Đã tạo file: ${outputFile}`);

// Verify encoding
const vietnameseCount = (finalContent.match(/Chào|hỏi|giới|thiệu|Việt|Nam/gi) || []).length;
console.log(`✅ Encoding UTF-8: ${vietnameseCount} ký tự tiếng Việt đúng`);

// Check for problematic patterns
const problematicPatterns = [
  /\\restrict/i,
  /\\connect/i,
  /\\c\s/,
  /^\\[a-zA-Z]/,
];

const foundProblems = [];
for (const pattern of problematicPatterns) {
  if (pattern.test(finalContent)) {
    foundProblems.push(pattern.toString());
  }
}

if (foundProblems.length > 0) {
  console.log(`\n⚠️  Tìm thấy các pattern có thể gây vấn đề: ${foundProblems.join(', ')}`);
} else {
  console.log(`\n✅ Không tìm thấy psql meta-commands!`);
}

// Show first few lines
console.log(`\n📝 Mẫu đầu file:`);
finalContent.split('\n').slice(0, 10).forEach((line, idx) => {
  console.log(`   ${idx + 1}. ${line}`);
});

console.log(`\n✨ Hoàn thành! File đã sẵn sàng để import vào Supabase SQL Editor.`);
console.log(`\n💡 Sử dụng file: ${outputFile}`);
