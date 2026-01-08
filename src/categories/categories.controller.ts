import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';

import { Roles } from '../auth/decorators/roles.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { CategoriesService } from './categories.service';

@Controller()
export class CategoriesController {
  constructor(private readonly categoriesService: CategoriesService) {}

  // Public endpoints
  @Get('vocabulary-categories')
  vocabCategories() {
    return this.categoriesService.listVocabularyCategories();
  }

  @Get('sentence-categories')
  sentenceCategories() {
    return this.categoriesService.listSentenceCategories();
  }

  // Admin endpoints
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Get('admin/vocabulary-categories')
  adminVocabCategories() {
    // Admin cần quyền xem danh sách để quản lý nên vẫn tái sử dụng service chung
    return this.categoriesService.listVocabularyCategories();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Post('admin/vocabulary-categories')
  createVocab(@Body() body: { name_vi?: string; name_en?: string }) {
    return this.categoriesService.createVocabularyCategory(body);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Patch('admin/vocabulary-categories/:id')
  updateVocab(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: { name_vi?: string | null; name_en?: string | null },
  ) {
    return this.categoriesService.updateVocabularyCategory(id, body);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Delete('admin/vocabulary-categories/:id')
  deleteVocab(@Param('id', ParseIntPipe) id: number) {
    return this.categoriesService.deleteVocabularyCategory(id);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Get('admin/sentence-categories')
  adminSentenceCategories() {
    return this.categoriesService.listSentenceCategories();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Post('admin/sentence-categories')
  createSentence(@Body() body: { name_vi?: string; name_en?: string }) {
    return this.categoriesService.createSentenceCategory(body);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Patch('admin/sentence-categories/:id')
  updateSentence(
    @Param('id', ParseIntPipe) id: number,
    @Body() body: { name_vi?: string | null; name_en?: string | null },
  ) {
    return this.categoriesService.updateSentenceCategory(id, body);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  @Delete('admin/sentence-categories/:id')
  deleteSentence(@Param('id', ParseIntPipe) id: number) {
    return this.categoriesService.deleteSentenceCategory(id);
  }
}
