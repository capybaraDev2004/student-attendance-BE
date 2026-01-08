import {
  Body,
  Controller,
  Get,
  MessageEvent,
  Param,
  ParseIntPipe,
  Post,
  Sse,
  UseGuards,
} from '@nestjs/common';
import { Observable } from 'rxjs';

import { VocabularyService } from './vocabulary.service';
import { VocabularyEventsService } from './vocabulary-events.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import {
  MarkVocabReadDto,
  UpdateVocabMemorizedDto,
} from './dto/update-vocab-state.dto';

@Controller('vocabulary')
export class VocabularyController {
  constructor(
    private readonly vocabularyService: VocabularyService,
    private readonly vocabularyEvents: VocabularyEventsService,
  ) {}

  @Get()
  findAll() {
    return this.vocabularyService.findAll();
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.vocabularyService.findOne(id);
  }

  @Sse('updates')
  updates(): Observable<MessageEvent> {
    return this.vocabularyEvents.stream();
  }

  @UseGuards(JwtAuthGuard)
  @Post('state/read')
  markRead(@Body() dto: MarkVocabReadDto, @CurrentUser() user: any) {
    return this.vocabularyService.markWordRead(user.user_id, dto.vocabId);
  }

  @UseGuards(JwtAuthGuard)
  @Post('state/memorized')
  updateMemorized(
    @Body() dto: UpdateVocabMemorizedDto,
    @CurrentUser() user: any,
  ) {
    return this.vocabularyService.updateWordMemorized(
      user.user_id,
      dto.vocabId,
      dto.isMemorized,
    );
  }
}
