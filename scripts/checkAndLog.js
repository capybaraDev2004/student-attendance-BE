const { PrismaClient } = require('@prisma/client');
const fs = require('fs');
const prisma = new PrismaClient();

(async () => {
  const output = [];
  
  output.push('='.repeat(70));
  output.push('KIỂM TRA CHẤT LƯỢNG PHÂN LOẠI TỪ VỰNG');
  output.push('='.repeat(70));
  output.push('');
  
  const total = await prisma.vocabulary.count();
  output.push(`Tổng số từ vựng: ${total}`);
  
  const categories = await prisma.vocabulary_categories.findMany({
    orderBy: { id: 'asc' }
  });
  output.push(`Số chủ đề: ${categories.length}`);
  output.push('');
  
  for (const cat of categories) {
    const count = await prisma.vocabulary.count({
      where: { category_id: cat.id }
    });
    
    output.push('-'.repeat(70));
    output.push(`📁 ${cat.name_vi}: ${count} từ`);
    output.push('-'.repeat(70));
    
    const examples = await prisma.vocabulary.findMany({
      where: { category_id: cat.id },
      take: 5,
      select: { chinese_word: true, pinyin: true, meaning_vn: true }
    });
    
    if (examples.length === 0) {
      output.push('  (Không có từ vựng)');
    } else {
      examples.forEach((ex, i) => {
        const short = ex.meaning_vn.length > 50 ? ex.meaning_vn.substring(0, 50) + '...' : ex.meaning_vn;
        output.push(`  ${i+1}. ${ex.chinese_word} (${ex.pinyin || 'N/A'})`);
        output.push(`     ➜ ${short}`);
      });
    }
    output.push('');
  }
  
  // Kiểm tra các trường hợp nghi ngờ
  output.push('');
  output.push('='.repeat(70));
  output.push('KIỂM TRA CÁC TRƯỜNG HỢP NGH NGỜ');
  output.push('='.repeat(70));
  output.push('');
  
  // Động từ không ở chủ đề động từ
  output.push('1️⃣ Động từ rõ ràng (có "làm") KHÔNG ở chủ đề "Động từ":');
  const verbs = await prisma.$queryRaw`
    SELECT v.chinese_word, v.meaning_vn, c.name_vi as category
    FROM vocabulary v
    LEFT JOIN vocabulary_categories c ON v.category_id = c.id
    WHERE v.meaning_vn ILIKE '%làm%'
      AND c.name_vi != 'Động từ'
    LIMIT 10
  `;
  
  if (verbs.length === 0) {
    output.push('  ✅ Không tìm thấy trường hợp nào');
  } else {
    verbs.forEach(v => {
      const short = v.meaning_vn.substring(0, 45);
      output.push(`  • ${v.chinese_word}: ${short}...`);
      output.push(`    ➜ Chủ đề hiện tại: ${v.category}`);
    });
  }
  output.push('');
  
  // Tính từ không ở chủ đề tính từ
  output.push('2️⃣ Tính từ rõ ràng (có "đẹp") KHÔNG ở "Tính từ & đặc điểm":');
  const adjectives = await prisma.$queryRaw`
    SELECT v.chinese_word, v.meaning_vn, c.name_vi as category
    FROM vocabulary v
    LEFT JOIN vocabulary_categories c ON v.category_id = c.id
    WHERE v.meaning_vn ILIKE '%đẹp%'
      AND c.name_vi != 'Tính từ & đặc điểm'
    LIMIT 10
  `;
  
  if (adjectives.length === 0) {
    output.push('  ✅ Không tìm thấy trường hợp nào');
  } else {
    adjectives.forEach(a => {
      const short = a.meaning_vn.substring(0, 45);
      output.push(`  • ${a.chinese_word}: ${short}...`);
      output.push(`    ➜ Chủ đề hiện tại: ${a.category}`);
    });
  }
  output.push('');
  
  // Trợ từ không ở chủ đề trợ từ
  output.push('3️⃣ Trợ từ (có "trợ từ") KHÔNG ở "Từ loại đặc biệt & trợ từ":');
  const particles = await prisma.$queryRaw`
    SELECT v.chinese_word, v.meaning_vn, c.name_vi as category
    FROM vocabulary v
    LEFT JOIN vocabulary_categories c ON v.category_id = c.id
    WHERE v.meaning_vn ILIKE '%trợ từ%'
      AND c.name_vi != 'Từ loại đặc biệt & trợ từ'
    LIMIT 10
  `;
  
  if (particles.length === 0) {
    output.push('  ✅ Không tìm thấy trường hợp nào');
  } else {
    particles.forEach(p => {
      const short = p.meaning_vn.substring(0, 45);
      output.push(`  • ${p.chinese_word}: ${short}...`);
      output.push(`    ➜ Chủ đề hiện tại: ${p.category}`);
    });
  }
  output.push('');
  
  output.push('='.repeat(70));
  output.push('✅ HOÀN TẤT KIỂM TRA');
  output.push('='.repeat(70));
  
  const result = output.join('\n');
  
  // Ghi ra file
  fs.writeFileSync('classification-report.txt', result, 'utf8');
  console.log('✅ Đã tạo báo cáo: classification-report.txt');
  console.log('\nNội dung báo cáo:\n');
  console.log(result);
  
  await prisma.$disconnect();
})().catch(e => {
  console.error('Lỗi:', e.message);
  process.exit(1);
});

