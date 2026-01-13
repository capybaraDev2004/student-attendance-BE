import { Injectable, Logger } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class VipExpirationService {
  private readonly logger = new Logger(VipExpirationService.name);

  constructor(private readonly prisma: PrismaService) {
    // Log khi service được khởi tạo để đảm bảo nó được load
    this.logger.log('✅ VipExpirationService đã được khởi tạo');
  }

  /**
   * Method để kiểm tra và hạ VIP cho các tài khoản đã hết hạn
   * Có thể gọi thủ công hoặc được gọi bởi cron job
   */
  async checkAndExpireVip() {
    this.logger.log('🔍 [CRON] Bắt đầu kiểm tra tài khoản VIP đã hết hạn...');

    try {
      const now = new Date();

      // Tìm tất cả user có account_status = 'vip' và vip_expires_at < now
      const expiredVipUsers = await this.prisma.users.findMany({
        where: {
          account_status: 'vip',
          vip_expires_at: {
            not: null,
            lt: now, // Less than now = đã hết hạn
          },
        },
        select: {
          user_id: true,
          username: true,
          email: true,
          vip_expires_at: true,
          vip_package_type: true,
        },
      });

      if (expiredVipUsers.length === 0) {
        this.logger.log('✅ Không có tài khoản VIP nào đã hết hạn');
        return { count: 0, users: [] };
      }

      this.logger.log(
        `📋 Tìm thấy ${expiredVipUsers.length} tài khoản VIP đã hết hạn`,
      );

      // Cập nhật tất cả user đã hết hạn
      const updateResult = await this.prisma.users.updateMany({
        where: {
          account_status: 'vip',
          vip_expires_at: {
            not: null,
            lt: now,
          },
        },
        data: {
          account_status: 'normal',
          vip_package_type: null,
          vip_expires_at: null,
        },
      });

      this.logger.log(
        `✅ Đã hạ VIP cho ${updateResult.count} tài khoản:`,
      );

      // Log chi tiết từng user đã được hạ VIP
      expiredVipUsers.forEach((user) => {
        this.logger.log(
          `   - User ID: ${user.user_id}, Email: ${user.email}, Username: ${user.username}, Hết hạn: ${user.vip_expires_at?.toISOString()}`,
        );
      });

      return {
        count: updateResult.count,
        users: expiredVipUsers.map((u) => ({
          user_id: u.user_id,
          email: u.email,
          username: u.username,
        })),
      };
    } catch (error) {
      this.logger.error('❌ Lỗi khi kiểm tra và hạ VIP đã hết hạn:', error);
      throw error;
    }
  }

  /**
   * Scheduled task chạy mỗi 5 phút để kiểm tra và hạ VIP cho các tài khoản đã hết hạn
   * Cron expression: mỗi 5 phút
   */
  @Cron('*/5 * * * *') // Chạy mỗi 5 phút
  async handleExpiredVip() {
    await this.checkAndExpireVip();
  }
}
