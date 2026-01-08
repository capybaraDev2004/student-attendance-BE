const { PrismaClient } = require('@prisma/client');
const { writeFileSync } = require('fs');
const { join } = require('path');

async function main() {
  const prisma = new PrismaClient();
  const filePath = join(process.cwd(), 'categories-dump.json');

  try {
    const categories = await prisma.vocabulary_categories.findMany({
      orderBy: { id: 'asc' },
      include: {
        _count: {
          select: { vocabulary: true },
        },
      },
    });

    const output = categories.map((cat) => ({
      id: cat.id,
      name: cat.name_vi,
      vocabCount: cat._count.vocabulary,
    }));

    writeFileSync(filePath, JSON.stringify(output, null, 2), 'utf8');
  } catch (error) {
    writeFileSync(
      filePath,
      JSON.stringify(
        { error: error?.message || 'Unknown error', stack: error?.stack },
        null,
        2,
      ),
      'utf8',
    );
    process.exitCode = 1;
  } finally {
    await prisma.$disconnect();
  }
}

main();

