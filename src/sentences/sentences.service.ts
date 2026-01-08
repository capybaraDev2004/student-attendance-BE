import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

export type CreateSentenceDto = {
  chinese_simplified?: string | null;
  pinyin?: string | null;
  vietnamese?: string | null;
  category_id: number;
};

export type UpdateSentenceDto = Partial<CreateSentenceDto>;

@Injectable()
export class SentencesService {
  constructor(private readonly prisma: PrismaService) {}

  async list() {
    return this.prisma.sentences.findMany({
      include: {
        category: { select: { name_vi: true, name_en: true } },
      },
      orderBy: { id: 'desc' },
    });
  }

  async create(dto: CreateSentenceDto) {
    await this.ensureSentenceCategory(dto.category_id);
    return this.prisma.sentences.create({
      data: {
        chinese_simplified: dto.chinese_simplified ?? null,
        pinyin: dto.pinyin ?? null,
        vietnamese: dto.vietnamese ?? null,
        category_id: dto.category_id,
      },
      include: {
        category: { select: { name_vi: true, name_en: true } },
      },
    });
  }

  async update(id: number, dto: UpdateSentenceDto) {
    await this.ensureSentence(id);
    if (dto.category_id !== undefined) {
      await this.ensureSentenceCategory(dto.category_id);
    }
    return this.prisma.sentences.update({
      where: { id },
      data: {
        chinese_simplified: dto.chinese_simplified ?? null,
        pinyin: dto.pinyin ?? null,
        vietnamese: dto.vietnamese ?? null,
        category_id: dto.category_id,
      },
      include: {
        category: { select: { name_vi: true, name_en: true } },
      },
    });
  }

  async remove(id: number) {
    await this.ensureSentence(id);
    await this.prisma.sentences.delete({ where: { id } });
    return { message: 'Đã xóa câu nói thành công' };
  }

  private async ensureSentence(id: number) {
    const s = await this.prisma.sentences.findUnique({ where: { id } });
    if (!s) throw new NotFoundException('Câu nói không tồn tại');
  }

  private async ensureSentenceCategory(id: number) {
    const c = await this.prisma.sentence_categories.findUnique({
      where: { id },
    });
    if (!c) throw new NotFoundException('Danh mục không tồn tại');
  }
}
