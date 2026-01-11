const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

/**
 * Script để dump database với encoding UTF-8 đúng cách
 * Sử dụng: node scripts/dump_database_utf8.js
 */

const outputFile = path.join(__dirname, 'temp_migration', 'dump_final.sql');
const backupFile = path.join(__dirname, 'temp_migration', 'dump_final_old.sql');

// Lấy DATABASE_URL từ environment variable hoặc .env
let databaseUrl = process.env.DATABASE_URL;

if (!databaseUrl) {
  // Thử đọc từ .env file
  try {
    const envPath = path.join(__dirname, '..', '.env');
    if (fs.existsSync(envPath)) {
      const envContent = fs.readFileSync(envPath, 'utf8');
      const match = envContent.match(/DATABASE_URL=(.+)/);
      if (match) {
        databaseUrl = match[1].trim().replace(/^["']|["']$/g, '');
      }
    }
  } catch (e) {
    console.log('⚠️  Không thể đọc .env file');
  }
}

if (!databaseUrl) {
  console.error('❌ Không tìm thấy DATABASE_URL!');
  console.log('\n💡 Cách sử dụng:');
  console.log('   1. Set environment variable:');
  console.log('      $env:DATABASE_URL="postgresql://user:pass@host:port/db"');
  console.log('      node scripts/dump_database_utf8.js');
  console.log('\n   2. Hoặc thêm vào .env file:');
  console.log('      DATABASE_URL=postgresql://user:pass@host:port/db');
  console.log('\n   3. Hoặc truyền vào command line:');
  console.log('      DATABASE_URL=postgresql://... node scripts/dump_database_utf8.js');
  process.exit(1);
}

console.log('🔄 Đang parse DATABASE_URL...');

// Parse DATABASE_URL: postgresql://user:password@host:port/database
const urlMatch = databaseUrl.match(/postgresql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/);

if (!urlMatch) {
  console.error('❌ DATABASE_URL không đúng format!');
  console.log('   Format đúng: postgresql://user:password@host:port/database');
  process.exit(1);
}

const [, user, password, host, port, database] = urlMatch;

console.log(`📋 Database: ${database} @ ${host}:${port}`);
console.log(`📋 User: ${user}`);
console.log(`📁 Output: ${outputFile}\n`);

// Backup file cũ nếu có
if (fs.existsSync(outputFile)) {
  console.log('📦 Đang backup file cũ...');
  fs.copyFileSync(outputFile, backupFile);
  console.log(`   → Backup tại: ${backupFile}\n`);
}

console.log('🚀 Đang dump database với encoding UTF-8...');
console.log('   (Có thể mất vài phút tùy vào kích thước database)\n');

// Tìm pg_dump trong các đường dẫn phổ biến
function findPgDump() {
  // Thử tìm trong PATH trước
  try {
    execSync('pg_dump --version', { stdio: 'ignore' });
    return 'pg_dump';
  } catch (e) {}
  
  // Tìm trong các đường dẫn PostgreSQL phổ biến trên Windows
  const commonPaths = [
    'C:\\Program Files\\PostgreSQL\\18\\bin\\pg_dump.exe',
    'C:\\Program Files\\PostgreSQL\\17\\bin\\pg_dump.exe',
    'C:\\Program Files\\PostgreSQL\\16\\bin\\pg_dump.exe',
    'C:\\Program Files\\PostgreSQL\\15\\bin\\pg_dump.exe',
    'C:\\Program Files\\PostgreSQL\\14\\bin\\pg_dump.exe',
    'C:\\Program Files (x86)\\PostgreSQL\\18\\bin\\pg_dump.exe',
    'C:\\Program Files (x86)\\PostgreSQL\\17\\bin\\pg_dump.exe',
  ];
  
  for (const pgDumpPath of commonPaths) {
    if (fs.existsSync(pgDumpPath)) {
      console.log(`   → Tìm thấy pg_dump tại: ${pgDumpPath}\n`);
      return pgDumpPath;
    }
  }
  
  return null;
}

const pgDumpPath = findPgDump();

if (!pgDumpPath) {
  console.error('❌ Không tìm thấy pg_dump!');
  console.error('\n💡 Vui lòng:');
  console.error('   1. Cài đặt PostgreSQL client tools');
  console.error('   2. Hoặc thêm PostgreSQL bin vào PATH');
  console.error('   3. Hoặc chỉnh sửa script để chỉ định đường dẫn pg_dump');
  process.exit(1);
}

try {
  // Set PGPASSWORD environment variable
  process.env.PGPASSWORD = password;
  
  // Parse database name (loại bỏ query string như ?schema=public)
  const dbName = database.split('?')[0];
  
  // Build pg_dump command
  const dumpCommand = [
    `"${pgDumpPath}"`,
    `-h ${host}`,
    `-p ${port}`,
    `-U ${user}`,
    `-d ${dbName}`,
    '--encoding=UTF8',
    '--no-owner',
    '--no-acl',
    '-F p' // Plain text format
  ].join(' ');
  
  console.log(`🔧 Đang chạy pg_dump với encoding UTF-8...\n`);
  
  // Execute pg_dump
  const dumpOutput = execSync(dumpCommand, {
    encoding: 'utf8',
    maxBuffer: 50 * 1024 * 1024, // 50MB buffer
    env: {
      ...process.env,
      PGPASSWORD: password,
      PGCLIENTENCODING: 'UTF8'
    }
  });
  
  // Write to file with UTF-8 encoding
  fs.writeFileSync(outputFile, dumpOutput, 'utf8');
  
  console.log('✅ Đã dump thành công!\n');
  
  // Verify encoding
  const fileContent = fs.readFileSync(outputFile, 'utf8');
  const vietnameseCount = (fileContent.match(/Chào|hỏi|giới|thiệu|Việt|Nam|đình|thông/gi) || []).length;
  const totalLines = fileContent.split('\n').length;
  const vietnameseLines = fileContent.split('\n').filter(line => 
    /[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđĐ]/i.test(line)
  ).length;
  
  console.log('📊 Kết quả:');
  console.log(`   - Tổng số dòng: ${totalLines}`);
  console.log(`   - Dòng có tiếng Việt: ${vietnameseLines}`);
  console.log(`   - Số ký tự tiếng Việt đúng: ${vietnameseCount}`);
  
  if (vietnameseCount > 100) {
    console.log('\n✅ Encoding UTF-8 đúng! Tiếng Việt hiển thị chính xác.');
  } else {
    console.log('\n⚠️  Có thể vẫn còn vấn đề encoding. Kiểm tra lại file.');
  }
  
  // Show sample
  const sampleLines = fileContent.split('\n').filter(line => 
    line.includes('sentence_categories') && line.includes('name_vi')
  ).slice(0, 3);
  
  if (sampleLines.length > 0) {
    console.log('\n📝 Mẫu dòng:');
    sampleLines.forEach((line, idx) => {
      const preview = line.length > 120 ? line.substring(0, 120) + '...' : line;
      console.log(`   ${idx + 1}. ${preview}`);
    });
  }
  
  console.log(`\n✨ Hoàn thành! File đã được lưu tại: ${outputFile}`);
  
} catch (error) {
  console.error('\n❌ Lỗi khi dump database:');
  console.error(`   ${error.message}`);
  
  if (error.message.includes('pg_dump')) {
    console.error('\n💡 Đảm bảo:');
    console.error('   1. PostgreSQL client tools đã được cài đặt (pg_dump)');
    console.error('   2. pg_dump có trong PATH');
    console.error('   3. Database có thể truy cập được');
    console.error('   4. User có quyền đọc database');
  }
  
  process.exit(1);
} finally {
  // Clear PGPASSWORD
  delete process.env.PGPASSWORD;
}
