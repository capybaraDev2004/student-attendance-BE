import { Module } from '@nestjs/common';

import { PrismaModule } from '../prisma/prisma.module';
import { FlashcardsController } from './flashcards.controller';
import { FlashcardsPublicController } from './flashcards-public.controller';
import { FlashcardsService } from './flashcards.service';

@Module({
  imports: [PrismaModule],
  controllers: [FlashcardsController, FlashcardsPublicController],
  providers: [FlashcardsService],
  exports: [FlashcardsService],
})
export class FlashcardsModule {}
