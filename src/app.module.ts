import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { VocabularyModule } from './vocabulary/vocabulary.module';
import { CategoriesModule } from './categories/categories.module';
import { SentencesModule } from './sentences/sentences.module';
import { StatsModule } from './stats/stats.module';
import { FlashcardsModule } from './flashcards/flashcards.module';
import { ContestProgressModule } from './contest-progress/contest-progress.module';
import { SpeechModule } from './speech/speech.module';
import { DailyTasksModule } from './daily-tasks/daily-tasks.module';
import { NewsModule } from './news/news.module';

@Module({
  imports: [
    // Cấu hình để đọc file .env
    ConfigModule.forRoot({
      isGlobal: true, // Làm cho ConfigModule có thể dùng ở mọi nơi
      envFilePath: '.env',
    }),
    PrismaModule,
    AuthModule,
    UsersModule,
    VocabularyModule,
    CategoriesModule,
    SentencesModule,
    StatsModule,
    FlashcardsModule,
    ContestProgressModule,
    SpeechModule,
    DailyTasksModule,
    NewsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
