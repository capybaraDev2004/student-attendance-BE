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
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import { VocabularyService } from './vocabulary.service';

@Controller('admin/vocabulary')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('admin')
export class VocabularyAdminController {
  constructor(private readonly vocabularyService: VocabularyService) {}

  @Get()
  findAll() {
    return this.vocabularyService.adminList();
  }

  @Post()
  create(@Body() dto: CreateVocabularyDto) {
    return this.vocabularyService.create(dto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: UpdateVocabularyDto,
  ) {
    return this.vocabularyService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.vocabularyService.remove(id);
  }

  @Post('auto-categorize')
  autoCategorize() {
    // Sử dụng helper heuristic để phân loại nhanh dựa trên meaning/pinyin
    return this.vocabularyService.autoCategorize();
  }

  @Post('reset-categories')
  resetCategories() {
    return this.vocabularyService.resetCategories();
  }

  @Get('count')
  count() {
    return this.vocabularyService.countTotal();
  }

  @Get('fix-meaning-vn')
  analyzeMeaning() {
    return this.vocabularyService.analyzeMeaningIssues();
  }

  @Post('fix-meaning-vn')
  fixMeaning() {
    return this.vocabularyService.fixMeaningVn();
  }

  @Post('redraw-meaning')
  redrawMeaning(@Body() body: { ids?: number[] }) {
    const ids = Array.isArray(body.ids)
      ? body.ids
          .map((id) => Number(id))
          .filter((parsed) => Number.isFinite(parsed) && parsed > 0)
      : undefined;
    return this.vocabularyService.redrawMeaning(ids);
  }

  @Post('reseed')
  reseed(@Body() body: { limit?: number }) {
    const parsedLimit = Number(body.limit ?? 100);
    const limit =
      Number.isFinite(parsedLimit) && parsedLimit > 0
        ? Math.floor(parsedLimit)
        : 100;
    return this.vocabularyService.reseed(limit);
  }
}
