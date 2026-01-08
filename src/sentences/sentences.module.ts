import { Module } from '@nestjs/common';
import { SentencesService } from './sentences.service';
import { SentencesController } from './sentences.controller';

@Module({
  providers: [SentencesService],
  controllers: [SentencesController],
})
export class SentencesModule {}
