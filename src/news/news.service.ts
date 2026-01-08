import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class NewsService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Tạo Date object chỉ có ngày (không có giờ)
   * Sử dụng UTC date với ngày đúng từ local timezone để tránh timezone shift khi Prisma lưu vào PostgreSQL
   */
  private getTodayDateOnly(): Date {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth();
    const day = now.getDate();
    return new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
  }

  /**
   * Lấy tin tức đang active (trong khoảng thời gian start_date và end_date)
   */
  async getActiveNews() {
    const today = this.getTodayDateOnly();

    const news = await this.prisma.news.findMany({
      where: {
        start_date: {
          lte: today,
        },
        end_date: {
          gte: today,
        },
      },
      orderBy: {
        created_at: 'desc',
      },
    });

    return news;
  }

  /**
   * Lấy tất cả tin tức (cho admin)
   */
  async getAllNews() {
    return this.prisma.news.findMany({
      orderBy: {
        created_at: 'desc',
      },
    });
  }

  /**
   * Tạo tin tức mới (cho admin)
   */
  async createNews(data: {
    title: string;
    content: string;
    start_date: Date;
    end_date: Date;
  }) {
    return this.prisma.news.create({
      data: {
        title: data.title,
        content: data.content,
        start_date: data.start_date,
        end_date: data.end_date,
      },
    });
  }

  /**
   * Cập nhật tin tức (cho admin)
   */
  async updateNews(
    id: number,
    data: {
      title?: string;
      content?: string;
      start_date?: Date;
      end_date?: Date;
    },
  ) {
    return this.prisma.news.update({
      where: { id },
      data,
    });
  }

  /**
   * Xóa tin tức (cho admin)
   */
  async deleteNews(id: number) {
    return this.prisma.news.delete({
      where: { id },
    });
  }
}

