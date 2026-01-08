import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma } from '@prisma/client';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CategoriesService {
  constructor(private readonly prisma: PrismaService) {}

  // Public lists
  listVocabularyCategories() {
    return this.prisma.vocabulary_categories.findMany({
      orderBy: { id: 'asc' },
    });
  }

  listSentenceCategories() {
    return this.prisma.sentence_categories.findMany({
      orderBy: { id: 'asc' },
    });
  }

  // Admin CRUD - vocabulary categories
  async createVocabularyCategory(data: { name_vi?: string; name_en?: string }) {
    return this.prisma.vocabulary_categories.create({ data });
  }

  async updateVocabularyCategory(
    id: number,
    data: { name_vi?: string | null; name_en?: string | null },
  ) {
    await this.ensureVocabCategory(id);
    return this.prisma.vocabulary_categories.update({ where: { id }, data });
  }

  async deleteVocabularyCategory(id: number) {
    await this.ensureVocabCategory(id);
    await this.prisma.vocabulary_categories.delete({ where: { id } });
    return { message: 'Đã xóa danh mục từ vựng' };
  }

  // Admin CRUD - sentence categories
  async createSentenceCategory(data: { name_vi?: string; name_en?: string }) {
    return this.prisma.sentence_categories.create({ data });
  }

  async updateSentenceCategory(
    id: number,
    data: { name_vi?: string | null; name_en?: string | null },
  ) {
    await this.ensureSentenceCategory(id);
    return this.prisma.sentence_categories.update({ where: { id }, data });
  }

  async deleteSentenceCategory(id: number) {
    await this.ensureSentenceCategory(id);
    await this.prisma.sentence_categories.delete({ where: { id } });
    return { message: 'Đã xóa danh mục câu' };
  }

  private async ensureVocabCategory(id: number) {
    const exists = await this.prisma.vocabulary_categories.findUnique({
      where: { id },
    });
    if (!exists) throw new NotFoundException('Danh mục từ vựng không tồn tại');
  }

  private async ensureSentenceCategory(id: number) {
    const exists = await this.prisma.sentence_categories.findUnique({
      where: { id },
    });
    if (!exists) throw new NotFoundException('Danh mục câu không tồn tại');
  }
}
