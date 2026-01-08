import * as XLSX from 'xlsx';
import { PrismaClient } from '@prisma/client';
import { join } from 'path';
import {
  VocabularyCategoryClassifier,
  TARGET_VOCABULARY_CATEGORIES,
} from '../src/vocabulary/vocabularyCategoryClassifier';
import { WordTypeAnalyzerService } from '../src/vocabulary/services/wordTypeAnalyzer.service';

const prisma = new PrismaClient();
const classifier = new VocabularyCategoryClassifier();
const wordTypeAnalyzer = new WordTypeAnalyzerService();

interface ExcelRow {
  [key: string]: any;
  'STT'?: number;
  'Tiếng Trung'?: string;
  'Phiên âm'?: string;
  'Nghĩa tiếng Việt'?: string;
}

interface Stats {
  [category: string]: number;
}

interface WordTypeStats {
  [type: string]: number;
}

async function main() {
  console.log('📖 Đang đọc file Excel...');
  const excelPath = join(process.cwd(), '../document/chineseVocabulary.xlsx');
  const workbook = XLSX.readFile(excelPath);
  const sheetName = workbook.SheetNames[0];
  const worksheet = workbook.Sheets[sheetName];
  const rows: ExcelRow[] = XLSX.utils.sheet_to_json(worksheet);
  
  console.log(`  ➜ Tìm thấy ${rows.length} dòng trong Excel`);

  // Đảm bảo categories tồn tại
  console.log('🗑️  Đảm bảo categories tồn tại...');
  const existingCategories = await prisma.vocabulary_categories.findMany();
  const categoryMap = new Map<string, number>();
  
  existingCategories.forEach((cat) => {
    if (cat.name_vi) {
      categoryMap.set(cat.name_vi, cat.id);
    }
  });

  // Tạo categories nếu chưa có
  for (const catName of TARGET_VOCABULARY_CATEGORIES) {
    if (!categoryMap.has(catName)) {
      const newCat = await prisma.vocabulary_categories.create({
        data: {
          name_vi: catName,
          name_en: null,
        },
      });
      categoryMap.set(catName, newCat.id);
      console.log(`  ➜ Đã tạo category: ${catName}`);
    }
  }

  const stats: Stats = {};
  const wordTypeStats: WordTypeStats = {};
  const notFound: string[] = [];
  const updated: number[] = [];
  
  TARGET_VOCABULARY_CATEGORIES.forEach((name) => {
    stats[name] = 0;
  });

  console.log('\n📦 Đang đọc từng từ từ Excel và phân loại lại...');
  const batchSize = 50;
  let processed = 0;

  for (let i = 0; i < rows.length; i += batchSize) {
    const batch = rows.slice(i, i + batchSize);

    for (const row of batch) {
      try {
        const chinese_word = row['Tiếng Trung']?.toString().trim() || '';
        const pinyin = row['Phiên âm']?.toString().trim() || '';
        const meaning_vn = row['Nghĩa tiếng Việt']?.toString().trim() || '';

        if (!chinese_word || !meaning_vn) {
          continue;
        }

        // Tìm từ trong database
        const vocab = await prisma.vocabulary.findFirst({
          where: {
            chinese_word: chinese_word,
          },
        });

        if (!vocab) {
          notFound.push(chinese_word);
          continue;
        }

        // Phân tích loại từ
        const wordTypeAnalysis = wordTypeAnalyzer.analyzeWordType(
          chinese_word,
          pinyin || null,
          meaning_vn,
        );

        wordTypeStats[wordTypeAnalysis.type] = (wordTypeStats[wordTypeAnalysis.type] || 0) + 1;

        // Phân loại chủ đề
        const predictedCategory = classifier.classify(
          {
            chinese_word: chinese_word,
            pinyin: pinyin || null,
            meaning_vn: meaning_vn,
          },
          wordTypeAnalysis.confidence > 30 ? wordTypeAnalysis.type : undefined,
        );

        const categoryId = categoryMap.get(predictedCategory);
        if (!categoryId) {
          console.error(`❌ Không tìm thấy ID cho chủ đề: ${predictedCategory}`);
          continue;
        }

        // Cập nhật category
        if (vocab.category_id !== categoryId) {
          await prisma.vocabulary.update({
            where: { vocab_id: vocab.vocab_id },
            data: { category_id: categoryId },
          });
          updated.push(vocab.vocab_id);
        }

        stats[predictedCategory] = (stats[predictedCategory] || 0) + 1;
        processed++;
      } catch (error: any) {
        console.error(`Lỗi ở dòng ${i + 1}:`, error.message);
      }
    }

    if (processed % 100 === 0 || processed === rows.length) {
      console.log(`  ➜ Đã xử lý ${processed}/${rows.length} từ vựng...`);
    }
  }

  console.log('\n✅ Hoàn tất phân loại lại!');
  console.log(`\n📊 Đã cập nhật: ${updated.length} từ vựng`);
  console.log(`📊 Không tìm thấy trong DB: ${notFound.length} từ`);
  
  if (notFound.length > 0 && notFound.length <= 20) {
    console.log('\nCác từ không tìm thấy:');
    notFound.forEach((word) => console.log(`  - ${word}`));
  }

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

