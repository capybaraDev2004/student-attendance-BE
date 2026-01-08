import { Controller, Get, Post, UseGuards } from '@nestjs/common';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { DailyTasksService } from './daily-tasks.service';

@Controller('daily-tasks')
@UseGuards(JwtAuthGuard)
export class DailyTasksController {
  constructor(private readonly dailyTasksService: DailyTasksService) {}

  @Get('today')
  async getTodayTask(@CurrentUser() user: any) {
    const userId = user?.user_id;
    if (!userId) {
      return { vocabulary_count: 0, sentence_count: 0, contest_completed: false };
    }
    const task = await this.dailyTasksService.getTodayTask(userId);
    return task || { vocabulary_count: 0, sentence_count: 0, contest_completed: false };
  }

  @Post('increment-vocabulary')
  async incrementVocabulary(@CurrentUser() user: any) {
    const userId = user?.user_id;
    if (!userId) {
      throw new Error('User not found');
    }
    return this.dailyTasksService.incrementVocabulary(userId);
  }

  @Post('increment-sentence')
  async incrementSentence(@CurrentUser() user: any) {
    const userId = user?.user_id;
    if (!userId) {
      throw new Error('User not found');
    }
    return this.dailyTasksService.incrementSentence(userId);
  }

  @Post('mark-contest-completed')
  async markContestCompleted(@CurrentUser() user: any) {
    const userId = user?.user_id;
    if (!userId) {
      throw new Error('User not found');
    }
    return this.dailyTasksService.markContestCompleted(userId);
  }
}

