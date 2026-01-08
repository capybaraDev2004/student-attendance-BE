const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  console.log('🔍 Kiểm tra mẫu ngẫu nhiên để đảm bảo chất lượng phân loại\n');

  const categories = await prisma.vocabulary_categories.findMany({
    orderBy: { id: 'asc' },
  });

  for (const category of categories) {
    console.log(`\n📁 Chủ đề: ${category.name_vi}`);
    console.log('─'.repeat(60));

    const samples = await prisma.vocabulary.findMany({
      where: { category_id: category.id },
      select: {
        chinese_word: true,
        pinyin: true,
        meaning_vn: true,
      },
      take: 8,
      orderBy: { vocab_id: 'asc' },
    });

    if (samples.length === 0) {
      console.log('  (Không có từ vựng)');
      continue;
    }

    samples.forEach((vocab, index) => {
      const meaningShort = vocab.meaning_vn.length > 50 
        ? vocab.meaning_vn.substring(0, 50) + '...' 
        : vocab.meaning_vn;
      console.log(`  ${index + 1}. ${vocab.chinese_word} (${vocab.pinyin || 'N/A'})`);
      console.log(`     ➜ ${meaningShort}`);
    });
  }

  // Kiểm tra các từ có thể bị phân loại sai
  console.log('\n\n🔎 Kiểm tra các từ nghi ngờ phân loại sai:\n');

  // 1. Động từ rõ ràng nhưng không ở chủ đề "Động từ"
  console.log('1️⃣ Động từ có "làm" không ở chủ đề "Động từ":');
  const suspectedVerbs = await prisma.$queryRaw`
    SELECT v.chinese_word, v.meaning_vn, c.name_vi as category
    FROM vocabulary v
    LEFT JOIN vocabulary_categories c ON v.category_id = c.id
    WHERE v.meaning_vn ILIKE '%làm%'
      AND c.name_vi != 'Động từ'
    LIMIT 10
  `;

  suspectedVerbs.forEach((vocab) => {
    console.log(`  • ${vocab.chinese_word}: ${vocab.meaning_vn.substring(0, 40)}...`);
    console.log(`    ➜ Chủ đề: ${vocab.category || 'N/A'}`);
  });

  // 2. Tính từ rõ ràng
  console.log('\n2️⃣ Tính từ có "đẹp/xấu/tốt" không ở "Tính từ & đặc điểm":');
  const suspectedAdjectives = await prisma.$queryRaw`
    SELECT v.chinese_word, v.meaning_vn, c.name_vi as category
    FROM vocabulary v
    LEFT JOIN vocabulary_categories c ON v.category_id = c.id
    WHERE (v.meaning_vn ILIKE '%đẹp%' OR v.meaning_vn ILIKE '%xấu%' OR v.meaning_vn ILIKE '%tốt%')
      AND c.name_vi != 'Tính từ & đặc điểm'
    LIMIT 10
  `;

  suspectedAdjectives.forEach((vocab) => {
    console.log(`  • ${vocab.chinese_word}: ${vocab.meaning_vn.substring(0, 40)}...`);
    console.log(`    ➜ Chủ đề: ${vocab.category || 'N/A'}`);
  });

  // 3. Trợ từ
  console.log('\n3️⃣ Trợ từ không ở "Từ loại đặc biệt & trợ từ":');
  const suspectedParticles = await prisma.$queryRaw`
    SELECT v.chinese_word, v.meaning_vn, c.name_vi as category
    FROM vocabulary v
    LEFT JOIN vocabulary_categories c ON v.category_id = c.id
    WHERE v.meaning_vn ILIKE '%trợ từ%'
      AND c.name_vi != 'Từ loại đặc biệt & trợ từ'
    LIMIT 10
  `;

  suspectedParticles.forEach((vocab) => {
    console.log(`  • ${vocab.chinese_word}: ${vocab.meaning_vn.substring(0, 40)}...`);
    console.log(`    ➜ Chủ đề: ${vocab.category || 'N/A'}`);
  });

  console.log('\n✅ Hoàn tất kiểm tra!\n');

  await prisma.$disconnect();
}

main().catch((error) => {
  console.error('❌ Lỗi:', error);
  prisma.$disconnect();
  process.exit(1);
});

