import { Controller, Get, Res, Param, All, Req } from '@nestjs/common';
import { AppService } from './app.service';
import type { Response, Request } from 'express';
import { join } from 'path';
import { existsSync } from 'fs';
import { readFileSync } from 'fs';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  // Serve static files từ uploads folder (fallback nếu useStaticAssets không hoạt động)
  // Pattern: /uploads/flashcards/1.png hoặc /uploads/images/avatar.png
  @All('uploads/:folder/:filename')
  serveStaticFile(
    @Param('folder') folder: string,
    @Param('filename') filename: string,
    @Req() req: Request,
    @Res() res: Response,
  ) {
    const filePath = join(process.cwd(), 'uploads', folder, filename);
    
    console.log(`📁 Request file: ${req.url} -> ${filePath}`);
    
    if (!existsSync(filePath)) {
      console.error(`❌ File not found: ${filePath}`);
      return res.status(404).json({
        message: 'File not found',
        error: 'Not Found',
        statusCode: 404,
      });
    }

    // Xác định content type dựa trên extension
    const ext = filename.split('.').pop()?.toLowerCase();
    const contentTypes: Record<string, string> = {
      png: 'image/png',
      jpg: 'image/jpeg',
      jpeg: 'image/jpeg',
      gif: 'image/gif',
      webp: 'image/webp',
      svg: 'image/svg+xml',
      pdf: 'application/pdf',
      txt: 'text/plain',
    };

    const contentType = contentTypes[ext || ''] || 'application/octet-stream';

    // Set headers
    res.setHeader('Content-Type', contentType);
    res.setHeader('Access-Control-Allow-Origin', process.env.FRONTEND_URL || 'http://localhost:3000');
    res.setHeader('Access-Control-Allow-Credentials', 'true');
    res.setHeader('Cache-Control', 'public, max-age=31536000');

    // Đọc và gửi file
    try {
      const file = readFileSync(filePath);
      console.log(`✅ Serving file: ${filePath} (${file.length} bytes)`);
      return res.send(file);
    } catch (error) {
      console.error(`❌ Error reading file: ${filePath}`, error);
      return res.status(500).json({
        message: 'Error reading file',
        error: 'Internal Server Error',
        statusCode: 500,
      });
    }
  }
}
