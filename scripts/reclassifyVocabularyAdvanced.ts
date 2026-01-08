import { PrismaClient } from '@prisma/client';
import {
  VocabularyCategoryClassifier,
  TARGET_VOCABULARY_CATEGORIES,
} from '../src/vocabulary/vocabularyCategoryClassifier';
import { WordTypeAnalyzerService } from '../src/vocabulary/services/wordTypeAnalyzer.service';

const prisma = new PrismaClient();
const classifier = new VocabularyCategoryClassifier();
const wordTypeAnalyzer = new WordTypeAnalyzerService();

interface Stats {
  [category: string]: number;
}

interface WordTypeStats {
  [type: string]: number;
}

async function main() {
  console.log('🔄 Đang tải toàn bộ từ vựng...');
  const vocabularies = await prisma.vocabulary.findMany({
    select: {
      vocab_id: true,
      chinese_word: true,
      pinyin: true,
      meaning_vn: true,
    },
    orderBy: { vocab_id: 'asc' },
  });
  console.log(`  ➜ Tổng số từ vựng: ${vocabularies.length}`);

  console.log('🗑️  Xóa & seed lại bảng vocabulary_categories...');
  await prisma.$transaction(async (tx) => {
    await tx.vocabulary.updateMany({ data: { category_id: null } });
    await tx.vocabulary_categories.deleteMany();
    await tx.vocabulary_categories.createMany({
      data: TARGET_VOCABULARY_CATEGORIES.map((name) => ({
        name_vi: name,
        name_en: null,
      })),
    });
  });

  const categories = await prisma.vocabulary_categories.findMany();
  const categoryMap = new Map<string, number>();
  categories.forEach((cat) => {
    if (cat.name_vi) {
      categoryMap.set(cat.name_vi, cat.id);
    }
  });

  const stats: Stats = {};
  const wordTypeStats: WordTypeStats = {};
  TARGET_VOCABULARY_CATEGORIES.forEach((name) => {
    stats[name] = 0;
  });

  console.log('📦 Đang phân loại lại từng từ vựng (với phân tích loại từ)...');
  const batchSize = 50;
  let processed = 0;

  for (let index = 0; index < vocabularies.length; index += batchSize) {
    const batch = vocabularies.slice(index, index + batchSize);

    for (const vocab of batch) {
      // Bước 1: Phân tích loại từ
      const wordTypeAnalysis = wordTypeAnalyzer.analyzeWordType(
        vocab.chinese_word,
        vocab.pinyin,
        vocab.meaning_vn,
      );

      // Thống kê loại từ
      wordTypeStats[wordTypeAnalysis.type] = (wordTypeStats[wordTypeAnalysis.type] || 0) + 1;

      // Bước 2: Phân loại chủ đề dựa trên loại từ + ngữ cảnh
      const predictedCategory = classifier.classify(
        {
          chinese_word: vocab.chinese_word,
          pinyin: vocab.pinyin,
          meaning_vn: vocab.meaning_vn,
        },
        wordTypeAnalysis.confidence > 30 ? wordTypeAnalysis.type : undefined,
      );

      const categoryId = categoryMap.get(predictedCategory);
      if (!categoryId) {
        console.error(`❌ Không tìm thấy ID cho chủ đề: ${predictedCategory}`);
        continue;
      }

      stats[predictedCategory] = (stats[predictedCategory] || 0) + 1;

      await prisma.vocabulary.update({
        where: { vocab_id: vocab.vocab_id },
        data: { category_id: categoryId },
      });
    }

    processed += batch.length;
    console.log(`  ➜ Hoàn thành ${processed}/${vocabularies.length} bản ghi`);
  }

  console.log('\n✅ Hoàn tất phân loại!');
  console.log('\n📊 Thống kê theo chủ đề:');
  console.table(
    Object.entries(stats)
      .sort((a, b) => b[1] - a[1])
      .map(([category, count]) => ({
        Chủ_đề: category,
        Số_lượng: count,
      })),
  );

  console.log('\n📊 Thống kê theo loại từ:');
  console.table(
    Object.entries(wordTypeStats)
      .sort((a, b) => b[1] - a[1])
      .map(([type, count]) => ({
        Loại_từ: type,
        Số_lượng: count,
      })),
  );

  await prisma.$disconnect();
}

main().catch((error) => {
  console.error('❌ Lỗi:', error);
  prisma.$disconnect();
  process.exit(1);
});

