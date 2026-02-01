"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const vocabularyCategoryClassifier_1 = require("../src/vocabulary/vocabularyCategoryClassifier");
const NUMBER_CATEGORY_NAME = 'Số đếm & số lượng';
const prisma = new client_1.PrismaClient();
const classifier = new vocabularyCategoryClassifier_1.VocabularyCategoryClassifier();
async function ensureNumberCategory() {
    let category = await prisma.vocabulary_categories.findFirst({
        where: { name_vi: NUMBER_CATEGORY_NAME },
    });
    if (!category) {
        if (!vocabularyCategoryClassifier_1.TARGET_VOCABULARY_CATEGORIES.includes(NUMBER_CATEGORY_NAME)) {
            throw new Error(`Chưa thêm "${NUMBER_CATEGORY_NAME}" vào TARGET_VOCABULARY_CATEGORIES`);
        }
        category = await prisma.vocabulary_categories.create({
            data: {
                name_vi: NUMBER_CATEGORY_NAME,
                name_en: 'Numbers',
            },
        });
    }
    return category.id;
}
async function main() {
    console.log('🔢 Đang thêm thể loại "Số đếm & số lượng" và lọc lại các từ liên quan\n');
    const numberCategoryId = await ensureNumberCategory();
    console.log(`  ➜ ID chủ đề số đếm: ${numberCategoryId}`);
    const vocabularies = await prisma.vocabulary.findMany({
        select: {
            vocab_id: true,
            chinese_word: true,
            pinyin: true,
            meaning_vn: true,
            category_id: true,
        },
        orderBy: { vocab_id: 'asc' },
    });
    console.log(`  ➜ Tổng số từ vựng cần kiểm tra: ${vocabularies.length}`);
    let updated = 0;
    const reclassified = [];
    for (const vocab of vocabularies) {
        const predictedCategory = classifier.classify({
            chinese_word: vocab.chinese_word,
            pinyin: vocab.pinyin,
            meaning_vn: vocab.meaning_vn,
        });
        if (predictedCategory !== NUMBER_CATEGORY_NAME) {
            continue;
        }
        if (vocab.category_id === numberCategoryId) {
            continue;
        }
        await prisma.vocabulary.update({
            where: { vocab_id: vocab.vocab_id },
            data: { category_id: numberCategoryId },
        });
        updated++;
        reclassified.push({
            id: vocab.vocab_id,
            chinese: vocab.chinese_word,
            meaning: vocab.meaning_vn,
        });
    }
    console.log('\n✅ Hoàn tất lọc số đếm!');
    console.log(`  ➜ Đã chuyển ${updated} từ sang chủ đề "Số đếm & số lượng"`);
    if (reclassified.length) {
        console.log('\n📋 Một vài ví dụ đã chuyển:');
        reclassified.slice(0, 20).forEach((item) => {
            const meaningShort = item.meaning.length > 40 ? `${item.meaning.slice(0, 40)}...` : item.meaning;
            console.log(`  • (#${item.id}) ${item.chinese} – ${meaningShort}`);
        });
    }
    else {
        console.log('  ➜ Không có bản ghi nào cần cập nhật (có thể đã đúng trước đó).');
    }
    await prisma.$disconnect();
}
main().catch(async (error) => {
    console.error('❌ Lỗi:', error);
    await prisma.$disconnect();
    process.exit(1);
});
//# sourceMappingURL=reclassifyNumbersOnly.js.map