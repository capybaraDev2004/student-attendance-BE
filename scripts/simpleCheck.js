const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

(async () => {
  try {
    console.log('Đang kiểm tra...\n');
    
    const total = await prisma.vocabulary.count();
    console.log(`Tổng số từ vựng: ${total}`);
    
    const categories = await prisma.vocabulary_categories.findMany();
    console.log(`\nSố chủ đề: ${categories.length}\n`);
    
    for (const cat of categories) {
      const count = await prisma.vocabulary.count({
        where: { category_id: cat.id }
      });
      console.log(`${cat.name_vi}: ${count} từ`);
      
      // Lấy 3 ví dụ
      const examples = await prisma.vocabulary.findMany({
        where: { category_id: cat.id },
        take: 3,
        select: { chinese_word: true, meaning_vn: true }
      });
      
      examples.forEach(ex => {
        const short = ex.meaning_vn.length > 40 ? ex.meaning_vn.substring(0, 40) + '...' : ex.meaning_vn;
        console.log(`  - ${ex.chinese_word}: ${short}`);
      });
      console.log('');
    }
    
    await prisma.$disconnect();
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
})();

