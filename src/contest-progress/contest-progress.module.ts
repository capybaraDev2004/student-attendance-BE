import { Module } from '@nestjs/common';

import { PrismaModule } from '../prisma/prisma.module';
import { ContestProgressController } from './contest-progress.controller';
import { ContestProgressService } from './contest-progress.service';

@Module({
  imports: [PrismaModule],
  controllers: [ContestProgressController],
  providers: [ContestProgressService],
  exports: [ContestProgressService],
})
export class ContestProgressModule {}


