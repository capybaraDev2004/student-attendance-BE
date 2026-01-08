import { Module } from '@nestjs/common';

import { VocabularyAdminController } from './vocabulary-admin.controller';
import { VocabularyController } from './vocabulary.controller';
import { VocabularyEventsService } from './vocabulary-events.service';
import { VocabularyService } from './vocabulary.service';

@Module({
  providers: [VocabularyService, VocabularyEventsService],
  controllers: [VocabularyController, VocabularyAdminController],
  exports: [VocabularyService],
})
export class VocabularyModule {}
