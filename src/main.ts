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

  // Log allowed origins để debug
  console.log('🌐 Allowed CORS origins:', allowedOrigins);

  app.enableCors({
    origin: (origin, callback) => {
      // Cho phép requests không có origin (mobile apps, Postman, etc.)
      if (!origin) return callback(null, true);
      
      // Hàm normalize origin để so sánh (bỏ trailing slash, lowercase)
      const normalizeOrigin = (url: string) => url.toLowerCase().replace(/\/$/, '');
      
      // Kiểm tra exact match trước
      const isExactMatch = allowedOrigins.some((allowed) => 
        normalizeOrigin(origin) === normalizeOrigin(allowed)
      );
      
      if (isExactMatch) {
        callback(null, true);
        return;
      }
      
      // Kiểm tra match với port flexibility (http://localhost:3000 matches http://localhost:PORT)
      const originWithoutPort = origin.replace(/:\d+$/, '');
      const isMatchWithoutPort = allowedOrigins.some((allowed) => {
        const allowedWithoutPort = allowed.replace(/:\d+$/, '');
        return normalizeOrigin(originWithoutPort) === normalizeOrigin(allowedWithoutPort);
      });
      
      if (isMatchWithoutPort) {
        callback(null, true);
        return;
      }
      
      // Cho phép tất cả origin trong development (có thể tắt trong production)
      if (process.env.NODE_ENV !== 'production') {
        callback(null, true);
      } else {
        console.warn(`⚠️  CORS blocked origin: ${origin}`);
        callback(new Error('Not allowed by CORS'));
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

  // Đọc port và host từ environment variables
  // Render tự động set PORT, nhưng có thể override bằng env var
  const port = parseInt(process.env.PORT || '3001', 10);
  const host = process.env.HOST || '0.0.0.0';
  
  // Log environment variables để debug
  console.log('📋 Environment Variables:');
  console.log(`   - NODE_ENV: ${process.env.NODE_ENV || 'not set'}`);
  console.log(`   - PORT: ${process.env.PORT || 'not set (using default 3001)'}`);
  console.log(`   - HOST: ${process.env.HOST || 'not set (using default 0.0.0.0)'}`);
  
  await app.listen(port, host);
  
  // Hiển thị thông tin server
  if (process.env.NODE_ENV === 'production') {
    // Production: hiển thị port và host từ env
    console.log(`🚀 Backend NestJS đang chạy tại:`);
    console.log(`   - Host: ${host}`);
    console.log(`   - Port: ${port}`);
    console.log(`   - Environment: ${process.env.NODE_ENV}`);
    console.log(`   - URL: http://${host}:${port}`);
  } else {
    // Development: hiển thị IP LAN
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
}
bootstrap();
