import { Injectable } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class StatsService {
  constructor(private readonly prisma: PrismaService) {}

  async overview() {
    const [users, vocabulary, sentences, flashcards, news] = await Promise.all([
      this.prisma.users.count(),
      this.prisma.vocabulary.count(),
      this.prisma.sentences.count(),
      this.prisma.flashcards.count(),
      (this.prisma as any).news.count(),
    ]);
    return { users, vocabulary, sentences, flashcards, news };
  }

  async leaderboard(
    scope: 'country' | 'region' | 'province',
    region?: string,
    province?: string,
  ) {
    // Lấy tháng hiện tại theo format YYYY-MM để khớp với cột month_cycle
    const now = new Date();
    const monthCycle = `${now.getFullYear()}-${String(
      now.getMonth() + 1,
    ).padStart(2, '0')}`;

    const userWhere: any = {};

    // Lọc theo phạm vi (miền / tỉnh) dựa trên thông tin user
    if (scope === 'region' && region) {
      userWhere.region = region;
    } else if (scope === 'province' && province) {
      userWhere.province = province;
    }

    const results = await this.prisma.user_monthly_scores.findMany({
      where: {
        month_cycle: monthCycle,
        user: userWhere,
      },
      orderBy: { score: 'desc' },
      take: 10,
      select: {
        score: true,
        user: {
          select: {
            user_id: true,
            username: true,
            image_url: true,
            region: true,
            province: true,
            created_at: true,
          },
        },
      },
    });

    return results.map((item, index) => ({
      rank: index + 1,
      user_id: item.user.user_id,
      name: item.user.username,
      avatar_url: item.user.image_url,
      region: item.user.region,
      province: item.user.province,
      xp: item.score ?? 0,
      joined_at: item.user.created_at,
    }));
  }
}
