import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';
import { CreateFlashcardDto } from './dto/create-flashcard.dto';
import { UpdateFlashcardDto } from './dto/update-flashcard.dto';

@Injectable()
export class FlashcardsService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    return this.prisma.flashcards.findMany({
      orderBy: { id: 'desc' },
    });
  }

  async findActive(limit = 25) {
    return this.prisma.flashcards.findMany({
      where: { status: 'active' },
      orderBy: { id: 'desc' },
      take: limit,
    });
  }

  async findOne(id: number) {
    const flashcard = await this.prisma.flashcards.findUnique({
      where: { id },
    });
    if (!flashcard) {
      throw new NotFoundException('Flashcard không tồn tại');
    }
    return flashcard;
  }

  async create(dto: CreateFlashcardDto) {
    return this.prisma.flashcards.create({
      data: {
        image_url: dto.image_url ?? null,
        answer: dto.answer,
        status: dto.status ?? 'active',
      },
    });
  }

  async update(id: number, dto: UpdateFlashcardDto) {
    await this.findOne(id); // Kiểm tra tồn tại
    return this.prisma.flashcards.update({
      where: { id },
      data: {
        ...(dto.image_url !== undefined && { image_url: dto.image_url }),
        ...(dto.answer !== undefined && { answer: dto.answer }),
        ...(dto.status !== undefined && { status: dto.status }),
      },
    });
  }

  async remove(id: number) {
    await this.findOne(id); // Kiểm tra tồn tại
    await this.prisma.flashcards.delete({ where: { id } });
    return { message: 'Đã xóa flashcard thành công' };
  }
}

