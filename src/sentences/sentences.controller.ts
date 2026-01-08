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
import { SentencesService } from './sentences.service';
import type { CreateSentenceDto, UpdateSentenceDto } from './sentences.service';

@Controller('admin/sentences')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('admin')
export class SentencesController {
  constructor(private readonly sentencesService: SentencesService) {}

  @Get()
  list() {
    return this.sentencesService.list();
  }

  @Post()
  create(@Body() dto: CreateSentenceDto) {
    return this.sentencesService.create(dto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: UpdateSentenceDto,
  ) {
    return this.sentencesService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.sentencesService.remove(id);
  }
}
