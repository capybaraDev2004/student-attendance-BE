import {
  Controller,
  Post,
  Get,
  Body,
  Query,
  BadRequestException,
  Logger,
  Res,
} from '@nestjs/common';
import { SpeechService } from './speech.service';
import type { Response } from 'express';
import * as fs from 'fs';
import * as path from 'path';

@Controller('speech')
export class SpeechController {
  private readonly logger = new Logger(SpeechController.name);

  constructor(private readonly speechService: SpeechService) {}

  @Post('pronunciation')
  async assessPronunciation(
    @Body('audioBase64') audioBase64: string,
    @Body('text') referenceText: string,
  ) {
    if (!audioBase64) {
      throw new BadRequestException('Audio data is required');
    }

    if (!referenceText || referenceText.trim().length === 0) {
      throw new BadRequestException('Reference text is required');
    }

    try {
      // Tạo thư mục uploads/audio nếu chưa tồn tại
      const uploadsDir = path.join(process.cwd(), 'uploads', 'audio');
      if (!fs.existsSync(uploadsDir)) {
        fs.mkdirSync(uploadsDir, { recursive: true });
      }

      // Chuyển đổi base64 sang buffer và lưu file tạm
      const audioBuffer = Buffer.from(audioBase64, 'base64');
      const fileName = `audio_${Date.now()}.wav`;
      const filePath = path.join(uploadsDir, fileName);

      fs.writeFileSync(filePath, audioBuffer);

      this.logger.log(`Saved audio file: ${filePath}`);

      // Gọi service để chấm điểm
      const result = await this.speechService.assessPronunciation(
        filePath,
        referenceText.trim(),
      );

      return result;
    } catch (error: any) {
      this.logger.error('Error in pronunciation assessment:', error);
      throw new BadRequestException(
        error.message || 'Lỗi khi chấm điểm phát âm',
      );
    }
  }

  @Get('text-to-speech')
  async textToSpeech(
    @Query('text') text: string,
    @Query('language') language: string = 'zh-CN',
    @Res() res: Response,
  ) {
    if (!text || text.trim().length === 0) {
      throw new BadRequestException('Text is required');
    }

    try {
      const audioBuffer = await this.speechService.textToSpeech(
        text.trim(),
        language,
      );

      res.setHeader('Content-Type', 'audio/mpeg');
      res.setHeader('Content-Length', audioBuffer.length);
      res.send(audioBuffer);
    } catch (error: any) {
      this.logger.error('Error in text-to-speech:', error);
      throw new BadRequestException(
        error.message || 'Lỗi khi tạo phát âm',
      );
    }
  }
}

