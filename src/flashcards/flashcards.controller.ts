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
  UseInterceptors,
  UploadedFile,
  BadRequestException,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { existsSync } from 'fs';
import { join } from 'path';
import type { Express } from 'express';

import { Roles } from '../auth/decorators/roles.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { CreateFlashcardDto } from './dto/create-flashcard.dto';
import { UpdateFlashcardDto } from './dto/update-flashcard.dto';
import { FlashcardsService } from './flashcards.service';

const flashcardStorage = diskStorage({
  destination: './uploads/flashcards',
  filename: (_req, file, cb) => {
    // Giữ nguyên tên file gốc, nếu trùng thì thêm số thứ tự
    const originalName = file.originalname;
    const uploadPath = join('./uploads/flashcards', originalName);
    
    if (existsSync(uploadPath)) {
      // Nếu file đã tồn tại, thêm số thứ tự
      const nameWithoutExt = originalName.substring(0, originalName.lastIndexOf('.')) || originalName;
      const ext = originalName.substring(originalName.lastIndexOf('.')) || '';
      let counter = 1;
      let newName = `${nameWithoutExt}_${counter}${ext}`;
      
      while (existsSync(join('./uploads/flashcards', newName))) {
        counter++;
        newName = `${nameWithoutExt}_${counter}${ext}`;
      }
      
      cb(null, newName);
    } else {
      // Giữ nguyên tên file gốc
      cb(null, originalName);
    }
  },
});

function flashcardFileFilter(
  _req: any,
  file: Express.Multer.File,
  cb: (error: Error | null, acceptFile: boolean) => void,
) {
  if (!file.mimetype.startsWith('image/')) {
    cb(new BadRequestException('File phải là hình ảnh') as any, false);
    return;
  }
  cb(null, true);
}

@Controller('admin/flashcards')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('admin')
export class FlashcardsController {
  constructor(private readonly flashcardsService: FlashcardsService) {}

  @Get()
  findAll() {
    return this.flashcardsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.flashcardsService.findOne(id);
  }

  @Post()
  @UseInterceptors(
    FileInterceptor('image', {
      storage: flashcardStorage,
      fileFilter: flashcardFileFilter,
      limits: { fileSize: 10 * 1024 * 1024 }, // 10MB
    }),
  )
  create(
    @Body() dto: CreateFlashcardDto,
    @UploadedFile() image?: Express.Multer.File,
  ) {
    const imageUrl = image ? `/uploads/flashcards/${image.filename}` : dto.image_url;
    return this.flashcardsService.create({
      ...dto,
      image_url: imageUrl,
    });
  }

  @Patch(':id')
  @UseInterceptors(
    FileInterceptor('image', {
      storage: flashcardStorage,
      fileFilter: flashcardFileFilter,
      limits: { fileSize: 10 * 1024 * 1024 }, // 10MB
    }),
  )
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: UpdateFlashcardDto,
    @UploadedFile() image?: Express.Multer.File,
  ) {
    const imageUrl = image ? `/uploads/flashcards/${image.filename}` : dto.image_url;
    return this.flashcardsService.update(id, {
      ...dto,
      image_url: imageUrl,
    });
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.flashcardsService.remove(id);
  }
}

