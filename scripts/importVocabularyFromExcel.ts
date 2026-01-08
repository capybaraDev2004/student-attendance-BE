import * as XLSX from 'xlsx';
import { PrismaClient } from '@prisma/client';
import { join } from 'path';
import { VocabularyCategoryClassifier } from '../src/vocabulary/vocabularyCategoryClassifier';
import { sanitizeVietnameseMeaning } from '../src/common/utils/validation';

const prisma = new PrismaClient();
const classifier = new VocabularyCategoryClassifier();

interface ExcelRow {
  [key: string]: any;
  'Từ tiếng Trung'?: string;
  'Pinyin'?: string;
  'Nghĩa tiếng Việt'?: string;
  'Thể loại'?: string;
  'Từ vựng'?: string;
  'Phiên âm'?: string;
  'Nghĩa'?: string;
  'Category'?: string;
  'Loại từ'?: string;
}

async function getOrCreateCategory(categoryName: string): Promise<number | null> {
  if (!categoryName || !categoryName.trim()) {
    return null;
  }

  // Tìm category theo tên
  let category = await prisma.vocabulary_categories.findFirst({
    where: {
      OR: [
        { name_vi: { equals: categoryName.trim(), mode: 'insensitive' } },
        { name_en: { equals: categoryName.trim(), mode: 'insensitive' } },
      ],
    },
  });

  if (category) {
    return category.id;
  }

  // Nếu không tìm thấy, tạo mới
  category = await prisma.vocabulary_categories.create({
    data: {
      name_vi: categoryName.trim(),
      name_en: null,
    },
  });

  return category.id;
}

async function classifyVocabulary(
  chinese_word: string,
  pinyin: string | null,
  meaning_vn: string,
): Promise<number | null> {
  try {
    const categoryName = classifier.classify({
      chinese_word,
      pinyin: pinyin || null,
      meaning_vn,
    });

    if (categoryName) {
      return await getOrCreateCategory(categoryName);
    }
  } catch (error) {
    console.error(`Lỗi khi phân loại từ "${chinese_word}":`, error);
  }

  return null;
}

async function importVocabulary() {
  try {
    // Đường dẫn file Excel
    const excelPath = join(process.cwd(), '../document/chineseVocabulary.xlsx');
    console.log(`Đang đọc file Excel: ${excelPath}`);

    // Đọc file Excel
    const workbook = XLSX.readFile(excelPath);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];

    // Chuyển đổi sang JSON
    const rows: ExcelRow[] = XLSX.utils.sheet_to_json(worksheet);
    console.log(`Tìm thấy ${rows.length} dòng dữ liệu`);

    if (rows.length === 0) {
      console.log('Không có dữ liệu để import!');
      return;
    }

    // Debug: In ra cấu trúc dòng đầu tiên để xem tên cột
    if (rows.length > 0) {
      console.log('\n=== CẤU TRÚC DỮ LIỆU (dòng đầu tiên) ===');
      console.log(JSON.stringify(rows[0], null, 2));
      console.log('\nTên các cột:', Object.keys(rows[0]));
      console.log('==========================================\n');
    }

    // Lấy tất cả categories hiện có
    const existingCategories = await prisma.vocabulary_categories.findMany();
    const categoryMap = new Map<string, number>();
    existingCategories.forEach((cat) => {
      if (cat.name_vi) {
        categoryMap.set(cat.name_vi.toLowerCase(), cat.id);
      }
    });

    let imported = 0;
    let skipped = 0;
    let errors: string[] = [];

    // Xử lý từng dòng
    for (let i = 0; i < rows.length; i++) {
      const row = rows[i];
      
      try {
        // Lấy dữ liệu từ các cột có thể có
        const chinese_word =
          row['Tiếng Trung'] ||
          row['Từ tiếng Trung'] ||
          row['Từ vựng'] ||
          row['Chinese'] ||
          row['Word'] ||
          '';
        const pinyin =
          row['Phiên âm'] ||
          row['Pinyin'] ||
          row['拼音'] ||
          '';
        const meaning_vn =
          row['Nghĩa tiếng Việt'] ||
          row['Nghĩa'] ||
          row['Meaning'] ||
          row['Vietnamese'] ||
          '';
        const categoryName =
          row['Thể loại'] ||
          row['Category'] ||
          row['Loại từ'] ||
          row['Type'] ||
          '';

        // Bỏ qua dòng trống
        if (!chinese_word || !chinese_word.toString().trim()) {
          if (i < 5) {
            console.log(`Dòng ${i + 2}: Bỏ qua vì thiếu từ tiếng Trung`);
          }
          skipped++;
          continue;
        }

        const chineseWord = chinese_word.toString().trim();
        const pinyinValue = pinyin ? pinyin.toString().trim() : '';
        const meaningValue = meaning_vn ? meaning_vn.toString().trim() : '';

        if (!meaningValue) {
          if (i < 5) {
            console.log(`Dòng ${i + 2}: Bỏ qua vì thiếu nghĩa - "${chineseWord}"`);
          }
          skipped++;
          continue;
        }

        // Sanitize nghĩa tiếng Việt
        const sanitized = sanitizeVietnameseMeaning(meaningValue);
        if (sanitized.error || !sanitized.value) {
          if (i < 5 || errors.length < 10) {
            console.log(
              `Dòng ${i + 2}: Nghĩa không hợp lệ - "${chineseWord}": ${sanitized.error}`,
            );
          }
          skipped++;
          continue;
        }

        // Xác định category
        let category_id: number | null = null;

        if (categoryName && categoryName.toString().trim()) {
          // Nếu có category trong Excel, dùng category đó
          category_id = await getOrCreateCategory(categoryName.toString().trim());
        } else {
          // Nếu không có, tự động phân loại
          category_id = await classifyVocabulary(
            chineseWord,
            pinyinValue || null,
            sanitized.value,
          );
        }

        // Kiểm tra xem từ đã tồn tại chưa
        const existing = await prisma.vocabulary.findFirst({
          where: {
            chinese_word: chineseWord,
          },
        });

        if (existing) {
          // Cập nhật nếu đã tồn tại
          await prisma.vocabulary.update({
            where: { vocab_id: existing.vocab_id },
            data: {
              pinyin: pinyinValue || '',
              meaning_vn: sanitized.value,
              category_id: category_id || existing.category_id,
            },
          });
          if (imported < 10 || imported % 100 === 0) {
            console.log(`✓ Cập nhật: ${chineseWord} (${sanitized.value})`);
          }
        } else {
          // Tạo mới
          await prisma.vocabulary.create({
            data: {
              chinese_word: chineseWord,
              pinyin: pinyinValue || '',
              meaning_vn: sanitized.value,
              category_id: category_id,
            },
          });
          if (imported < 10 || imported % 100 === 0) {
            console.log(`✓ Thêm mới: ${chineseWord} (${sanitized.value})`);
          }
        }

        imported++;
        
        // Hiển thị tiến độ mỗi 100 từ
        if (imported % 100 === 0) {
          console.log(`📊 Đã import ${imported}/${rows.length} từ vựng...`);
        }
      } catch (error: any) {
        const errorMsg = `Dòng ${i + 2}: ${error?.message || 'Lỗi không xác định'}`;
        console.error(errorMsg);
        errors.push(errorMsg);
      }
    }

    console.log('\n=== KẾT QUẢ ===');
    console.log(`✓ Đã import: ${imported} từ vựng`);
    console.log(`⚠ Bỏ qua: ${skipped} dòng`);
    console.log(`❌ Lỗi: ${errors.length} dòng`);
    if (errors.length > 0) {
      console.log('\nChi tiết lỗi:');
      errors.forEach((err) => console.log(`  - ${err}`));
    }
  } catch (error: any) {
    console.error('Lỗi khi import:', error);
    throw error;
  } finally {
    await prisma.$disconnect();
  }
}

// Chạy import
importVocabulary()
  .then(() => {
    console.log('\n✅ Hoàn tất import dữ liệu!');
    process.exit(0);
  })
  .catch((error) => {
    console.error('\n❌ Lỗi khi import:', error);
    process.exit(1);
  });

