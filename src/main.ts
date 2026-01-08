import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { join } from 'path';
import { NestExpressApplication } from '@nestjs/platform-express';
import { existsSync } from 'fs';
import * as express from 'express';
import * as os from 'os';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  // Tăng body size limit để hỗ trợ audio lớn (50MB)
  // Audio WAV 16kHz mono ~30 giây ≈ 960KB, nhưng base64 encoding tăng ~33% → ~1.3MB
  // Để an toàn, đặt 50MB để hỗ trợ audio dài hơn hoặc chất lượng cao hơn
  app.use(express.json({ limit: '50mb' }));
  app.use(express.urlencoded({ extended: true, limit: '50mb' }));

  // Bật CORS để frontend Next.js có thể gọi API từ localhost và LAN
  const allowedOrigins = process.env.FRONTEND_URL
    ? process.env.FRONTEND_URL.split(',').map((url) => url.trim())
    : ['http://localhost:3000', 'http://192.168.1.10:3000'];

  app.enableCors({
    origin: (origin, callback) => {
      // Cho phép requests không có origin (mobile apps, Postman, etc.)
      if (!origin) return callback(null, true);
      
      // Kiểm tra origin có trong danh sách cho phép không
      if (allowedOrigins.some((allowed) => origin.startsWith(allowed.replace(/:\d+$/, '')))) {
        callback(null, true);
      } else {
        // Cho phép tất cả origin trong development (có thể tắt trong production)
        if (process.env.NODE_ENV !== 'production') {
          callback(null, true);
        } else {
          callback(new Error('Not allowed by CORS'));
        }
      }
    },
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  });

  // Bật validation pipe để tự động validate DTOs
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // Loại bỏ các field không có trong DTO
      forbidNonWhitelisted: true, // Từ chối request có field không hợp lệ
      transform: true, // Tự động transform type
    }),
  );

  // Serve static files từ thư mục uploads
  // Sử dụng process.cwd() để đảm bảo đường dẫn đúng cả khi build
  const uploadsPath = join(process.cwd(), 'uploads');
  
  // Kiểm tra thư mục uploads có tồn tại không
  if (existsSync(uploadsPath)) {
    app.useStaticAssets(uploadsPath, {
      prefix: '/uploads/',
      setHeaders: (res, path, stat) => {
        // Cho phép tất cả origin trong development
        const origin = res.req?.headers?.origin;
        if (origin && (allowedOrigins.some((allowed) => origin.startsWith(allowed.replace(/:\d+$/, ''))) || process.env.NODE_ENV !== 'production')) {
          res.setHeader('Access-Control-Allow-Origin', origin);
        }
        res.setHeader('Access-Control-Allow-Credentials', 'true');
        res.setHeader('Cache-Control', 'public, max-age=31536000');
      },
    });
    console.log(`✅ Static files được serve từ: ${uploadsPath}`);
  } else {
    console.warn(`⚠️  Thư mục uploads không tồn tại: ${uploadsPath}`);
  }

  const port = process.env.PORT || 3001;
  const host = process.env.HOST || '0.0.0.0';
  await app.listen(port, host);
  
  // Lấy IP LAN để hiển thị
  const networkInterfaces = os.networkInterfaces();
  let lanIp = 'localhost';
  for (const interfaceName in networkInterfaces) {
    for (const iface of networkInterfaces[interfaceName] || []) {
      if (iface.family === 'IPv4' && !iface.internal && iface.address.startsWith('192.168.')) {
        lanIp = iface.address;
        break;
      }
    }
    if (lanIp !== 'localhost') break;
  }
  
  console.log(`🚀 Backend NestJS đang chạy tại:`);
  console.log(`   - Local:   http://localhost:${port}`);
  console.log(`   - Network: http://${lanIp}:${port}`);
}
bootstrap();
