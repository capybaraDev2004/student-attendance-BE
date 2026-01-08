import { PrismaClient } from '@prisma/client';
import { writeFileSync } from 'node:fs';
import { join } from 'node:path';

const prisma = new PrismaClient();

async function main() {
  const categories = await prisma.vocabulary_categories.findMany({
    orderBy: { id: 'asc' },
  });

  const numberCategory = categories.find(
    (cat) => cat.name_vi === 'Số đếm & số lượng',
  );

  const count = await prisma.vocabulary.count({
    where: {
      category: { name_vi: 'Số đếm & số lượng' },
    },
  });

  const samples = await prisma.vocabulary.findMany({
    where: {
      category: { name_vi: 'Số đếm & số lượng' },
    },
    take: 20,
    orderBy: { vocab_id: 'asc' },
    select: {
      vocab_id: true,
      chinese_word: true,
      meaning_vn: true,
    },
  });

  const report = {
    categories: categories.map((cat) => ({ id: cat.id, name_vi: cat.name_vi })),
    numberCategory,
    count,
    samples,
  };

  const filePath = join(process.cwd(), 'number-category-report.json');
  writeFileSync(filePath, JSON.stringify(report, null, 2), 'utf8');
  console.log(`📄 Đã ghi báo cáo tại: ${filePath}`);
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

