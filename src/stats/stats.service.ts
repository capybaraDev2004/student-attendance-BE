import { Injectable } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class StatsService {
  constructor(private readonly prisma: PrismaService) {}

  async overview() {
    const [
      users,
      vocabulary,
      sentences,
      flashcards,
      news,
      payments,
      vocabularyCategories,
      sentenceCategories,
    ] = await Promise.all([
      this.prisma.users.count(),
      this.prisma.vocabulary.count(),
      this.prisma.sentences.count(),
      this.prisma.flashcards.count(),
      this.prisma.news.count(),
      this.prisma.payments.count(),
      this.prisma.vocabulary_categories.count(),
      this.prisma.sentence_categories.count(),
    ]);
    return {
      users,
      vocabulary,
      sentences,
      flashcards,
      news,
      payments,
      vocabularyCategories,
      sentenceCategories,
    };
  }

  /** Thống kê giao dịch cho biểu đồ */
  async paymentsChart() {
    const [byStatus, byVipPackage, byMonthRows] = await Promise.all([
      this.prisma.payments.groupBy({
        by: ['status'],
        _count: { payment_id: true },
        _sum: { amount: true },
      }),
      this.prisma.payments.groupBy({
        by: ['vip_package_type'],
        _count: { payment_id: true },
        _sum: { amount: true },
      }),
      this.prisma.$queryRaw<
        { month: string; count: bigint; total: bigint }[]
      >`
        SELECT
          to_char(created_at, 'YYYY-MM') as month,
          count(*)::int as count,
          coalesce(sum(amount), 0)::bigint as total
        FROM payments
        WHERE created_at >= (current_date - interval '12 months')
        GROUP BY to_char(created_at, 'YYYY-MM')
        ORDER BY month ASC
      `,
    ]);

    const statusLabel: Record<string, string> = {
      pending: 'Chờ xử lý',
      paid: 'Đã thanh toán',
      cancelled: 'Đã hủy',
      cancel: 'Đã hủy',
      expired: 'Hết hạn',
    };
    const vipLabel: Record<string, string> = {
      one_day: '1 Ngày',
      one_week: '1 Tuần',
      one_month: '1 Tháng',
      one_year: '1 Năm',
      lifetime: 'Vĩnh viễn',
    };

    return {
      byStatus: byStatus.map((s) => ({
        status: s.status,
        label: statusLabel[s.status] ?? s.status,
        count: s._count.payment_id,
        amount: Number(s._sum.amount ?? 0),
      })),
      byVipPackage: byVipPackage.map((v) => ({
        package: v.vip_package_type,
        label: vipLabel[v.vip_package_type] ?? v.vip_package_type,
        count: v._count.payment_id,
        amount: Number(v._sum.amount ?? 0),
      })),
      byMonth: byMonthRows.map((r) => ({
        month: r.month,
        count: Number(r.count ?? 0),
        amount: Number(r.total ?? 0),
      })),
    };
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
