"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const client_1 = require("@prisma/client");
const vocabularyCategoryClassifier_1 = require("../src/vocabulary/vocabularyCategoryClassifier");
const prisma = new client_1.PrismaClient();
const classifier = new vocabularyCategoryClassifier_1.VocabularyCategoryClassifier();
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
            data: vocabularyCategoryClassifier_1.TARGET_VOCABULARY_CATEGORIES.map((name) => ({
                name_vi: name,
                name_en: null,
            })),
        });
    });
    const categories = await prisma.vocabulary_categories.findMany();
    const categoryMap = new Map();
    categories.forEach((cat) => {
        if (cat.name_vi) {
            categoryMap.set(cat.name_vi, cat.id);
        }
    });
    const stats = {};
    vocabularyCategoryClassifier_1.TARGET_VOCABULARY_CATEGORIES.forEach((name) => {
        stats[name] = 0;
    });
    console.log('📦 Đang phân loại lại từng từ vựng...');
    const batchSize = 50;
    for (let index = 0; index < vocabularies.length; index += batchSize) {
        const batch = vocabularies.slice(index, index + batchSize);
        await prisma.$transaction(batch.map((vocab) => {
            const predicted = classifier.classify({
                chinese_word: vocab.chinese_word,
                pinyin: vocab.pinyin,
                meaning_vn: vocab.meaning_vn,
            });
            const resolved = categoryMap.has(predicted) ? predicted : classifier.defaultCategory;
            const categoryId = categoryMap.get(resolved);
            if (!categoryId) {
                throw new Error(`Không tìm thấy ID cho chủ đề "${resolved}"`);
            }
            stats[resolved] = (stats[resolved] ?? 0) + 1;
            return prisma.vocabulary.update({
                where: { vocab_id: vocab.vocab_id },
                data: { category_id: categoryId },
            });
        }));
        process.stdout.write(`  ➜ Hoàn thành ${Math.min(index + batch.length, vocabularies.length)}/${vocabularies.length} bản ghi\r`);
    }
    process.stdout.write('\n');
    console.log('✅ Hoàn tất phân loại!');
    console.table(Object.entries(stats).map(([name, count]) => ({ Chủ_đề: name, Số_lượng: count })));
}
main()
    .catch((error) => {
    console.error('❌ Đã xảy ra lỗi:', error);
    process.exitCode = 1;
})
    .finally(async () => {
    await prisma.$disconnect();
});
//# sourceMappingURL=resetVocabularyCategories.js.map