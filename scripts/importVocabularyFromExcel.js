"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const XLSX = __importStar(require("xlsx"));
const client_1 = require("@prisma/client");
const path_1 = require("path");
const vocabularyCategoryClassifier_1 = require("../src/vocabulary/vocabularyCategoryClassifier");
const validation_1 = require("../src/common/utils/validation");
const prisma = new client_1.PrismaClient();
const classifier = new vocabularyCategoryClassifier_1.VocabularyCategoryClassifier();
async function getOrCreateCategory(categoryName) {
    if (!categoryName || !categoryName.trim()) {
        return null;
    }
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
    category = await prisma.vocabulary_categories.create({
        data: {
            name_vi: categoryName.trim(),
            name_en: null,
        },
    });
    return category.id;
}
async function classifyVocabulary(chinese_word, pinyin, meaning_vn) {
    try {
        const categoryName = classifier.classify({
            chinese_word,
            pinyin: pinyin || null,
            meaning_vn,
        });
        if (categoryName) {
            return await getOrCreateCategory(categoryName);
        }
    }
    catch (error) {
        console.error(`Lỗi khi phân loại từ "${chinese_word}":`, error);
    }
    return null;
}
async function importVocabulary() {
    try {
        const excelPath = (0, path_1.join)(process.cwd(), '../document/chineseVocabulary.xlsx');
        console.log(`Đang đọc file Excel: ${excelPath}`);
        const workbook = XLSX.readFile(excelPath);
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const rows = XLSX.utils.sheet_to_json(worksheet);
        console.log(`Tìm thấy ${rows.length} dòng dữ liệu`);
        if (rows.length === 0) {
            console.log('Không có dữ liệu để import!');
            return;
        }
        if (rows.length > 0) {
            console.log('\n=== CẤU TRÚC DỮ LIỆU (dòng đầu tiên) ===');
            console.log(JSON.stringify(rows[0], null, 2));
            console.log('\nTên các cột:', Object.keys(rows[0]));
            console.log('==========================================\n');
        }
        const existingCategories = await prisma.vocabulary_categories.findMany();
        const categoryMap = new Map();
        existingCategories.forEach((cat) => {
            if (cat.name_vi) {
                categoryMap.set(cat.name_vi.toLowerCase(), cat.id);
            }
        });
        let imported = 0;
        let skipped = 0;
        let errors = [];
        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            try {
                const chinese_word = row['Tiếng Trung'] ||
                    row['Từ tiếng Trung'] ||
                    row['Từ vựng'] ||
                    row['Chinese'] ||
                    row['Word'] ||
                    '';
                const pinyin = row['Phiên âm'] ||
                    row['Pinyin'] ||
                    row['拼音'] ||
                    '';
                const meaning_vn = row['Nghĩa tiếng Việt'] ||
                    row['Nghĩa'] ||
                    row['Meaning'] ||
                    row['Vietnamese'] ||
                    '';
                const categoryName = row['Thể loại'] ||
                    row['Category'] ||
                    row['Loại từ'] ||
                    row['Type'] ||
                    '';
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
                const sanitized = (0, validation_1.sanitizeVietnameseMeaning)(meaningValue);
                if (sanitized.error || !sanitized.value) {
                    if (i < 5 || errors.length < 10) {
                        console.log(`Dòng ${i + 2}: Nghĩa không hợp lệ - "${chineseWord}": ${sanitized.error}`);
                    }
                    skipped++;
                    continue;
                }
                let category_id = null;
                if (categoryName && categoryName.toString().trim()) {
                    category_id = await getOrCreateCategory(categoryName.toString().trim());
                }
                else {
                    category_id = await classifyVocabulary(chineseWord, pinyinValue || null, sanitized.value);
                }
                const existing = await prisma.vocabulary.findFirst({
                    where: {
                        chinese_word: chineseWord,
                    },
                });
                if (existing) {
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
                }
                else {
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
                if (imported % 100 === 0) {
                    console.log(`📊 Đã import ${imported}/${rows.length} từ vựng...`);
                }
            }
            catch (error) {
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
    }
    catch (error) {
        console.error('Lỗi khi import:', error);
        throw error;
    }
    finally {
        await prisma.$disconnect();
    }
}
importVocabulary()
    .then(() => {
    console.log('\n✅ Hoàn tất import dữ liệu!');
    process.exit(0);
})
    .catch((error) => {
    console.error('\n❌ Lỗi khi import:', error);
    process.exit(1);
});
//# sourceMappingURL=importVocabularyFromExcel.js.map