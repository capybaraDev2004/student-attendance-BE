import {
  BadRequestException,
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';

import { sanitizeVietnameseMeaning } from '../common/utils/validation';
import { translateEnToVi, translateZhToVi } from '../common/utils/translate';
import { PrismaService } from '../prisma/prisma.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import { VocabularyAutoCategorizeHelper } from './vocabularyAutoCategorize.helper';
import { VocabularyEventsService } from './vocabulary-events.service';
import {
  TARGET_VOCABULARY_CATEGORIES,
  VocabularyCategoryClassifier,
} from './vocabularyCategoryClassifier';
import { VocabularyReseedHelper } from './vocabularyReseed.helper';

@Injectable()
export class VocabularyService {
  private readonly autoCategorizeHelper = new VocabularyAutoCategorizeHelper();
  private readonly reseedHelper = new VocabularyReseedHelper();
  private readonly categoryClassifier = new VocabularyCategoryClassifier();

  constructor(
    private readonly prisma: PrismaService,
    private readonly vocabularyEvents: VocabularyEventsService,
  ) {}

  private async getOrCreateUserBox(userId: number) {
    // Dùng findFirst + create để tránh phụ thuộc vào unique key trong Prisma client cũ
    let box = await this.prisma.vocabulary_box.findFirst({
      where: { user_id: userId },
    });

    if (!box) {
      box = await this.prisma.vocabulary_box.create({
        data: { user_id: userId },
      });
    }

    return box;
  }

  async markWordRead(userId: number, vocabId: number) {
    const box = await this.getOrCreateUserBox(userId);

    return this.prisma.vocabulary_box_item.upsert({
      where: {
        box_id_vocab_id: {
          box_id: box.box_id,
          vocab_id: vocabId,
        },
      },
      update: {
        is_read: true,
        listen_count: { increment: 1 },
      },
      create: {
        box_id: box.box_id,
        vocab_id: vocabId,
        is_read: true,
        is_memorized: false,
        correct_count: 0,
        incorrect_count: 0,
        listen_count: 1,
      },
    });
  }

  async updateWordMemorized(
    userId: number,
    vocabId: number,
    isMemorized: boolean,
  ) {
    const box = await this.getOrCreateUserBox(userId);

    return this.prisma.vocabulary_box_item.upsert({
      where: {
        box_id_vocab_id: {
          box_id: box.box_id,
          vocab_id: vocabId,
        },
      },
      update: {
        is_memorized: isMemorized,
      },
      create: {
        box_id: box.box_id,
        vocab_id: vocabId,
        is_read: false,
        is_memorized: isMemorized,
        correct_count: 0,
        incorrect_count: 0,
        listen_count: 0,
      },
    });
  }

  async findAll() {
    return this.prisma.vocabulary.findMany({
      orderBy: { vocab_id: 'asc' },
      include: {
        category: { select: { name_vi: true, name_en: true } },
      },
    });
  }

  async findOne(id: number) {
    const vocab = await this.prisma.vocabulary.findUnique({
      where: { vocab_id: id },
      include: {
        category: { select: { name_vi: true, name_en: true } },
      },
    });
    if (!vocab) {
      throw new NotFoundException('Không tìm thấy từ vựng');
    }
    return vocab;
  }

  async create(dto: CreateVocabularyDto) {
    if (dto.category_id !== undefined && dto.category_id !== null) {
      await this.ensureCategoryExists(dto.category_id);
    }

    const sanitized = sanitizeVietnameseMeaning(dto.meaning_vn);
    if (sanitized.error) {
      throw new BadRequestException(sanitized.error);
    }

    try {
      return await this.prisma.vocabulary.create({
        data: {
          chinese_word: dto.chinese_word,
          pinyin: dto.pinyin ?? '',
          meaning_vn: sanitized.value!,
          audio_url: dto.audio_url ?? null,
          category_id: dto.category_id ?? null,
        },
        include: {
          category: { select: { name_vi: true, name_en: true } },
        },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException('Từ vựng đã tồn tại');
      }
      throw error;
    }
  }

  async update(id: number, dto: UpdateVocabularyDto) {
    await this.ensureVocabularyExists(id);

    if (dto.category_id !== undefined && dto.category_id !== null) {
      await this.ensureCategoryExists(dto.category_id);
    }

    let meaning: string | undefined;
    if (dto.meaning_vn !== undefined) {
      const sanitized = sanitizeVietnameseMeaning(dto.meaning_vn);
      if (sanitized.error) {
        throw new BadRequestException(sanitized.error);
      }
      meaning = sanitized.value!;
    }

    const data: Prisma.vocabularyUpdateInput = {};

    if (dto.chinese_word !== undefined) {
      data.chinese_word = dto.chinese_word;
    }
    if (dto.pinyin !== undefined) {
      // Prisma yêu cầu pinyin là chuỗi nên khi null sẽ chuyển về chuỗi rỗng
      data.pinyin = dto.pinyin ?? '';
    }
    if (meaning !== undefined) {
      data.meaning_vn = meaning;
    }
    if (dto.audio_url !== undefined) {
      data.audio_url = dto.audio_url ?? null;
    }
    if (dto.category_id !== undefined) {
      data.category =
        dto.category_id === null
          ? { disconnect: true }
          : { connect: { id: dto.category_id } };
    }

    try {
      const updated = await this.prisma.vocabulary.update({
        where: { vocab_id: id },
        data,
        include: {
          category: { select: { name_vi: true, name_en: true } },
        },
      });
      this.vocabularyEvents.emitUpdated(updated);
      return updated;
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException('Từ vựng đã tồn tại');
      }
      throw error;
    }
  }

  async remove(id: number) {
    await this.ensureVocabularyExists(id);
    await this.prisma.vocabulary.delete({ where: { vocab_id: id } });
    return { message: 'Đã xóa từ vựng thành công' };
  }

  async adminList() {
    return this.prisma.vocabulary.findMany({
      orderBy: { vocab_id: 'desc' },
      include: {
        category: { select: { id: true, name_vi: true, name_en: true } },
      },
    });
  }

  async countTotal() {
    const [raw] = await this.prisma.$queryRaw<{ count: number }[]>`
      SELECT COUNT(*)::int AS count FROM "vocabulary"
    `;

    const count = raw?.count ?? (await this.prisma.vocabulary.count());
    return { count, source: raw ? 'sql' : 'prisma' };
  }

  async autoCategorize() {
    const categories = await this.prisma.vocabulary_categories.findMany();
    if (!categories.length) {
      throw new BadRequestException(
        'Chưa có danh mục từ vựng nào để phân loại',
      );
    }

    const categoriesMap = new Map<string, number>();
    categories.forEach((cat) => {
      if (cat.name_vi) {
        categoriesMap.set(cat.name_vi.toLowerCase(), cat.id);
      }
    });

    const defaultCategoryId = categoriesMap.get('danh từ') || null;

    const vocabularies = await this.prisma.vocabulary.findMany({
      select: {
        vocab_id: true,
        chinese_word: true,
        pinyin: true,
        meaning_vn: true,
      },
    });

    let updated = 0;
    const skipped: number[] = [];

    for (const vocab of vocabularies) {
      const categoryId = this.autoCategorizeHelper.decideCategoryId(
        vocab.chinese_word,
        vocab.pinyin ?? undefined,
        vocab.meaning_vn ?? '',
        categoriesMap,
        defaultCategoryId,
      );

      if (!categoryId) {
        skipped.push(vocab.vocab_id);
        continue;
      }

      await this.prisma.vocabulary.update({
        where: { vocab_id: vocab.vocab_id },
        data: { category_id: categoryId },
      });
      updated++;
    }

    return { updated, skippedCount: skipped.length, skippedIds: skipped };
  }

  async analyzeMeaningIssues() {
    const total = await this.prisma.vocabulary.count();
    const all = await this.prisma.vocabulary.findMany({
      select: { vocab_id: true, meaning_vn: true },
    });

    let needFix = 0;

    for (const vocab of all) {
      const sanitized = sanitizeVietnameseMeaning(vocab.meaning_vn);
      if (sanitized.error) {
        needFix++;
      }
    }

    return { total, needFix, canAutoFix: 0 };
  }

  async fixMeaningVn() {
    const vocabularies = await this.prisma.vocabulary.findMany({
      select: { vocab_id: true, meaning_vn: true },
    });

    const updated = 0;
    const failed: number[] = [];

    for (const vocab of vocabularies) {
      const sanitized = sanitizeVietnameseMeaning(vocab.meaning_vn);
      if (!sanitized.error) {
        continue;
      }
      failed.push(vocab.vocab_id);
    }

    return { updated, failedCount: failed.length, failedIds: failed };
  }

  async redrawMeaning(ids?: number[]) {
    const where =
      ids && ids.length
        ? {
            vocab_id: { in: ids },
          }
        : undefined;

    const rows = await this.prisma.vocabulary.findMany({
      where,
      select: { vocab_id: true, chinese_word: true },
      orderBy: { vocab_id: 'desc' },
    });

    let updated = 0;
    const errors: { id: number; error: string }[] = [];

    for (const row of rows) {
      try {
        const vi = await translateZhToVi(row.chinese_word);
        const sanitized = sanitizeVietnameseMeaning(vi);
        if (sanitized.error || !sanitized.value) {
          errors.push({
            id: row.vocab_id,
            error: sanitized.error || 'Không hợp lệ sau dịch',
          });
          continue;
        }

        await this.prisma.vocabulary.update({
          where: { vocab_id: row.vocab_id },
          data: { meaning_vn: sanitized.value },
        });
        updated++;
      } catch (error: any) {
        errors.push({
          id: row.vocab_id,
          error: error?.message ?? 'Lỗi không xác định',
        });
      }
    }

    return { total: rows.length, updated, errors };
  }

  async reseed(limit: number) {
    if (limit <= 0) {
      throw new BadRequestException('Giới hạn phải lớn hơn 0');
    }

    const categories = await this.prisma.vocabulary_categories.findMany({
      select: { id: true },
    });

    if (!categories.length) {
      throw new BadRequestException('Thiếu categories để gán dữ liệu');
    }

    const categoryIds = categories.map((c) => c.id);

    const pool = await this.reseedHelper.fetchWordPool(limit);

    let created = 0;
    const failures: string[] = [];

    for (let index = 0; index < pool.length && created < limit; index++) {
      const item = pool[index];
      let meaning = await translateZhToVi(item.chinese_word).catch(() => '');
      if ((!meaning || !meaning.trim()) && item.english) {
        meaning = await translateEnToVi(item.english).catch(() => '');
      }

      let sanitized = sanitizeVietnameseMeaning(meaning);
      if (sanitized.error || !sanitized.value) {
        sanitized = sanitizeVietnameseMeaning('Đang cập nhật');
      }

      const category_id = categoryIds[(created + index) % categoryIds.length];

      try {
        await this.prisma.vocabulary.create({
          data: {
            chinese_word: item.chinese_word,
            pinyin: item.pinyin ?? null,
            meaning_vn: sanitized.value!,
            category_id,
          },
        });
        created++;
      } catch (error) {
        failures.push(item.chinese_word);
      }
    }

    return { requested: limit, created, failures };
  }

  async resetCategories() {
    const vocabularies = await this.prisma.vocabulary.findMany({
      select: {
        vocab_id: true,
        chinese_word: true,
        pinyin: true,
        meaning_vn: true,
      },
      orderBy: { vocab_id: 'asc' },
    });

    await this.prisma.$transaction(async (tx) => {
      await tx.vocabulary.updateMany({ data: { category_id: null } });
      await tx.vocabulary_categories.deleteMany();
      await tx.vocabulary_categories.createMany({
        data: TARGET_VOCABULARY_CATEGORIES.map((name) => ({
          name_vi: name,
          name_en: null,
        })),
      });
    });

    const categories = await this.prisma.vocabulary_categories.findMany();
    const categoryMap = new Map<string, number>();
    categories.forEach((cat) => {
      if (cat.name_vi) {
        categoryMap.set(cat.name_vi, cat.id);
      }
    });

    const stats: Record<string, number> = {};
    TARGET_VOCABULARY_CATEGORIES.forEach((name) => {
      stats[name] = 0;
    });

    const batchSize = 50;

    for (let index = 0; index < vocabularies.length; index += batchSize) {
      const batch = vocabularies.slice(index, index + batchSize);
      const operations = batch.map((vocab) => {
        const predictedName = this.categoryClassifier.classify({
          chinese_word: vocab.chinese_word,
          pinyin: vocab.pinyin,
          meaning_vn: vocab.meaning_vn,
        });

        const resolvedName = categoryMap.has(predictedName)
          ? predictedName
          : this.categoryClassifier.defaultCategory;
        const categoryId = categoryMap.get(resolvedName);
        if (!categoryId) {
          throw new InternalServerErrorException(
            `Không tìm thấy ID cho chủ đề ${resolvedName}`,
          );
        }

        stats[resolvedName] = (stats[resolvedName] ?? 0) + 1;

        return this.prisma.vocabulary.update({
          where: { vocab_id: vocab.vocab_id },
          data: { category_id: categoryId },
        });
      });

      await this.prisma.$transaction(operations);
    }

    return {
      total: vocabularies.length,
      categories: TARGET_VOCABULARY_CATEGORIES.length,
      stats,
    };
  }

  private async ensureVocabularyExists(id: number) {
    const vocab = await this.prisma.vocabulary.findUnique({
      where: { vocab_id: id },
    });
    if (!vocab) {
      throw new NotFoundException('Từ vựng không tồn tại');
    }
  }

  private async ensureCategoryExists(id: number) {
    const category = await this.prisma.vocabulary_categories.findUnique({
      where: { id },
    });
    if (!category) {
      throw new NotFoundException('Danh mục không tồn tại');
    }
  }
}
