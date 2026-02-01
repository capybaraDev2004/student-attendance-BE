"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const prisma = new client_1.PrismaClient();
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
            take: 10,
            orderBy: { vocab_id: 'asc' },
        });
        if (samples.length === 0) {
            console.log('  (Không có từ vựng)');
            continue;
        }
        samples.forEach((vocab, index) => {
            console.log(`  ${index + 1}. ${vocab.chinese_word} (${vocab.pinyin || 'N/A'})`);
            console.log(`     ➜ ${vocab.meaning_vn}`);
        });
    }
    console.log('\n\n🔎 Kiểm tra các từ nghi ngờ phân loại sai:\n');
    console.log('1️⃣ Động từ rõ ràng không ở chủ đề "Động từ":');
    const verbKeywords = ['làm', 'đi', 'chạy', 'ăn', 'uống', 'ngủ', 'học', 'viết', 'đọc'];
    const suspectedVerbs = await prisma.vocabulary.findMany({
        where: {
            meaning_vn: {
                contains: 'làm',
            },
            category: {
                name_vi: {
                    not: 'Động từ',
                },
            },
        },
        include: {
            category: {
                select: { name_vi: true },
            },
        },
        take: 10,
    });
    suspectedVerbs.forEach((vocab) => {
        console.log(`  • ${vocab.chinese_word}: ${vocab.meaning_vn}`);
        console.log(`    ➜ Chủ đề hiện tại: ${vocab.category?.name_vi || 'N/A'}`);
    });
    console.log('\n2️⃣ Tính từ rõ ràng không ở chủ đề "Tính từ & đặc điểm":');
    const suspectedAdjectives = await prisma.vocabulary.findMany({
        where: {
            meaning_vn: {
                contains: 'đẹp',
            },
            category: {
                name_vi: {
                    not: 'Tính từ & đặc điểm',
                },
            },
        },
        include: {
            category: {
                select: { name_vi: true },
            },
        },
        take: 10,
    });
    suspectedAdjectives.forEach((vocab) => {
        console.log(`  • ${vocab.chinese_word}: ${vocab.meaning_vn}`);
        console.log(`    ➜ Chủ đề hiện tại: ${vocab.category?.name_vi || 'N/A'}`);
    });
    console.log('\n3️⃣ Trợ từ không ở chủ đề "Từ loại đặc biệt & trợ từ":');
    const suspectedParticles = await prisma.vocabulary.findMany({
        where: {
            meaning_vn: {
                contains: 'trợ từ',
            },
            category: {
                name_vi: {
                    not: 'Từ loại đặc biệt & trợ từ',
                },
            },
        },
        include: {
            category: {
                select: { name_vi: true },
            },
        },
        take: 10,
    });
    suspectedParticles.forEach((vocab) => {
        console.log(`  • ${vocab.chinese_word}: ${vocab.meaning_vn}`);
        console.log(`    ➜ Chủ đề hiện tại: ${vocab.category?.name_vi || 'N/A'}`);
    });
    await prisma.$disconnect();
}
main().catch((error) => {
    console.error('❌ Lỗi:', error);
    prisma.$disconnect();
    process.exit(1);
});
//# sourceMappingURL=validateClassification.js.map