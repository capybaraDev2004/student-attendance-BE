import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  async onModuleInit(): Promise<void> {
    // Kết nối tới database khi module được khởi tạo
    await this.$connect();
  }

  async onModuleDestroy(): Promise<void> {
    // Đảm bảo đóng kết nối khi ứng dụng shutdown
    await this.$disconnect();
  }
}
