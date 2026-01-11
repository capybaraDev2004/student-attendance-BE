const fs = require('fs');
const path = require('path');

/**
 * Script để fix encoding tiếng Việt trong file dump_final.sql
 * Vấn đề: File có thể bị lỗi encoding do được dump với encoding sai
 * Giải pháp: Thử nhiều cách decode và chọn phương pháp tốt nhất
 */

const inputFile = path.join(__dirname, 'temp_migration', 'dump_final.sql');
const outputFile = path.join(__dirname, 'temp_migration', 'dump_final_utf8.sql');
const backupFile = path.join(__dirname, 'temp_migration', 'dump_final_backup.sql');

console.log('🔄 Đang đọc file...');

try {
  // Đọc file như binary để preserve bytes
  const fileBuffer = fs.readFileSync(inputFile);
  
  console.log('🔧 Đang thử các phương pháp fix encoding...\n');
  
  let bestContent = null;
  let bestScore = 0;
  let bestMethod = '';
  const methods = [];
  
  // Method 1: UTF-8 (default)
  try {
    const content = fileBuffer.toString('utf8');
    const score = (content.match(/Chào|hỏi|giới|thiệu|Việt|Nam|đình|thông/gi) || []).length;
    methods.push({ name: 'UTF-8', score });
    console.log(`   Method 1 (UTF-8): ${score} ký tự tiếng Việt đúng`);
    if (score > bestScore) {
      bestScore = score;
      bestContent = content;
      bestMethod = 'UTF-8';
    }
  } catch (e) {
    console.log(`   Method 1 (UTF-8): FAILED - ${e.message}`);
  }
  
  // Method 2: Latin1 → UTF-8 (double decode attempt 1)
  try {
    const step1 = fileBuffer.toString('latin1');
    const content = Buffer.from(step1, 'utf8').toString('utf8');
    const score = (content.match(/Chào|hỏi|giới|thiệu|Việt|Nam|đình|thông/gi) || []).length;
    methods.push({ name: 'Latin1→UTF8 (attempt 1)', score });
    console.log(`   Method 2 (Latin1→UTF8 attempt 1): ${score} ký tự tiếng Việt đúng`);
    if (score > bestScore) {
      bestScore = score;
      bestContent = content;
      bestMethod = 'Latin1→UTF8 (attempt 1)';
    }
  } catch (e) {
    console.log(`   Method 2: FAILED - ${e.message}`);
  }
  
  // Method 3: Double decode attempt 2 (UTF-8 → Latin1 → UTF-8)
  try {
    const step1 = fileBuffer.toString('utf8');
    const step2 = Buffer.from(step1, 'latin1');
    const content = step2.toString('utf8');
    const score = (content.match(/Chào|hỏi|giới|thiệu|Việt|Nam|đình|thông/gi) || []).length;
    methods.push({ name: 'UTF-8→Latin1→UTF-8', score });
    console.log(`   Method 3 (UTF-8→Latin1→UTF-8): ${score} ký tự tiếng Việt đúng`);
    if (score > bestScore) {
      bestScore = score;
      bestContent = content;
      bestMethod = 'UTF-8→Latin1→UTF-8';
    }
  } catch (e) {
    console.log(`   Method 3: FAILED - ${e.message}`);
  }
  
  // Method 4: Binary decode
  try {
    const binary = fileBuffer.toString('binary');
    const content = Buffer.from(binary, 'latin1').toString('utf8');
    const score = (content.match(/Chào|hỏi|giới|thiệu|Việt|Nam|đình|thông/gi) || []).length;
    methods.push({ name: 'Binary→Latin1→UTF-8', score });
    console.log(`   Method 4 (Binary→Latin1→UTF-8): ${score} ký tự tiếng Việt đúng`);
    if (score > bestScore) {
      bestScore = score;
      bestContent = content;
      bestMethod = 'Binary→Latin1→UTF-8';
    }
  } catch (e) {
    console.log(`   Method 4: FAILED - ${e.message}`);
  }
  
  // Hiển thị kết quả
  console.log(`\n📊 Kết quả: Phương pháp tốt nhất là "${bestMethod}" với ${bestScore} ký tự tiếng Việt đúng\n`);
  
  if (bestContent && bestScore > 10) {
    console.log(`✅ Đã tìm thấy phương pháp fix tốt!`);
    
    // Backup file gốc nếu chưa có
    if (!fs.existsSync(backupFile)) {
      fs.copyFileSync(inputFile, backupFile);
      console.log(`📦 Đã backup file gốc: ${backupFile}`);
    }
    
    // Ghi file mới
    fs.writeFileSync(outputFile, bestContent, 'utf8');
    console.log(`✅ Đã tạo file mới: ${outputFile}`);
    
    // Thay thế file gốc
    fs.writeFileSync(inputFile, bestContent, 'utf8');
    console.log(`✅ Đã thay thế file gốc (${inputFile}) với encoding đúng!\n`);
    
    // Đếm số dòng có tiếng Việt
    const lines = bestContent.split('\n');
    const vietnameseLines = lines.filter(line => 
      /[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđĐ]/i.test(line)
    ).length;
    
    console.log(`📊 Thống kê:`);
    console.log(`   - Tổng số dòng: ${lines.length}`);
    console.log(`   - Dòng có tiếng Việt: ${vietnameseLines}`);
    
    // Show sample để verify
    const sampleLines = lines.filter(line => 
      line.includes('sentence_categories') || line.includes('Chào') || line.includes('hỏi')
    ).slice(0, 3);
    
    if (sampleLines.length > 0) {
      console.log(`\n📝 Mẫu dòng đã fix:`);
      sampleLines.forEach((line, idx) => {
        const preview = line.length > 120 ? line.substring(0, 120) + '...' : line;
        console.log(`   ${idx + 1}. ${preview}`);
      });
    }
    
    console.log(`\n✨ Hoàn thành! File đã được fix với encoding UTF-8 đúng cách.`);
    
  } else {
    console.log('❌ Không thể fix tự động. Vấn đề encoding quá phức tạp hoặc file đã bị corrupt.');
    console.log('\n💡 Đề xuất: Dump lại từ database với encoding UTF-8 đúng cách:');
    console.log('   1. Kết nối database: psql -h HOST -U USER -d DATABASE');
    console.log('   2. Set encoding: SET client_encoding = \'UTF8\';');
    console.log('   3. Dump lại: pg_dump --encoding=UTF8 -h HOST -U USER -d DATABASE > dump_final.sql');
    console.log('\n   Hoặc sử dụng script PowerShell: .\\scripts\\dump_with_utf8.ps1');
    process.exit(1);
  }
  
} catch (error) {
  console.error('❌ Lỗi:', error.message);
  console.error(error.stack);
  process.exit(1);
}
