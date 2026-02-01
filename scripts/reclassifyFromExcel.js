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
const wordTypeAnalyzer_service_1 = require("../src/vocabulary/services/wordTypeAnalyzer.service");
const prisma = new client_1.PrismaClient();
const classifier = new vocabularyCategoryClassifier_1.VocabularyCategoryClassifier();
const wordTypeAnalyzer = new wordTypeAnalyzer_service_1.WordTypeAnalyzerService();
async function main() {
    console.log('📖 Đang đọc file Excel...');
    const excelPath = (0, path_1.join)(process.cwd(), '../document/chineseVocabulary.xlsx');
    const workbook = XLSX.readFile(excelPath);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json(worksheet);
    console.log(`  ➜ Tìm thấy ${rows.length} dòng trong Excel`);
    console.log('🗑️  Đảm bảo categories tồn tại...');
    const existingCategories = await prisma.vocabulary_categories.findMany();
    const categoryMap = new Map();
    existingCategories.forEach((cat) => {
        if (cat.name_vi) {
            categoryMap.set(cat.name_vi, cat.id);
        }
    });
    for (const catName of vocabularyCategoryClassifier_1.TARGET_VOCABULARY_CATEGORIES) {
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
    const stats = {};
    const wordTypeStats = {};
    const notFound = [];
    const updated = [];
    vocabularyCategoryClassifier_1.TARGET_VOCABULARY_CATEGORIES.forEach((name) => {
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
                const vocab = await prisma.vocabulary.findFirst({
                    where: {
                        chinese_word: chinese_word,
                    },
                });
                if (!vocab) {
                    notFound.push(chinese_word);
                    continue;
                }
                const wordTypeAnalysis = wordTypeAnalyzer.analyzeWordType(chinese_word, pinyin || null, meaning_vn);
                wordTypeStats[wordTypeAnalysis.type] = (wordTypeStats[wordTypeAnalysis.type] || 0) + 1;
                const predictedCategory = classifier.classify({
                    chinese_word: chinese_word,
                    pinyin: pinyin || null,
                    meaning_vn: meaning_vn,
                }, wordTypeAnalysis.confidence > 30 ? wordTypeAnalysis.type : undefined);
                const categoryId = categoryMap.get(predictedCategory);
                if (!categoryId) {
                    console.error(`❌ Không tìm thấy ID cho chủ đề: ${predictedCategory}`);
                    continue;
                }
                if (vocab.category_id !== categoryId) {
                    await prisma.vocabulary.update({
                        where: { vocab_id: vocab.vocab_id },
                        data: { category_id: categoryId },
                    });
                    updated.push(vocab.vocab_id);
                }
                stats[predictedCategory] = (stats[predictedCategory] || 0) + 1;
                processed++;
            }
            catch (error) {
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
    console.table(Object.entries(stats)
        .sort((a, b) => b[1] - a[1])
        .map(([category, count]) => ({
        Chủ_đề: category,
        Số_lượng: count,
    })));
    console.log('\n📊 Thống kê theo loại từ:');
    console.table(Object.entries(wordTypeStats)
        .sort((a, b) => b[1] - a[1])
        .map(([type, count]) => ({
        Loại_từ: type,
        Số_lượng: count,
    })));
    await prisma.$disconnect();
}
main().catch((error) => {
    console.error('❌ Lỗi:', error);
    prisma.$disconnect();
    process.exit(1);
});
//# sourceMappingURL=reclassifyFromExcel.js.map