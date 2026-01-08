import { Controller, Get } from '@nestjs/common';

import { FlashcardsService } from './flashcards.service';

@Controller('flashcards')
export class FlashcardsPublicController {
  constructor(private readonly flashcardsService: FlashcardsService) {}

  // Public endpoint: trả về tối đa 25 flashcard đang hoạt động
  @Get()
  async getActiveFlashcards() {
    return this.flashcardsService.findActive(25);
  }
}


