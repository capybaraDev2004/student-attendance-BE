import { Module } from '@nestjs/common';
import { StatsService } from './stats.service';
import { StatsController } from './stats.controller';
import { LeaderboardController } from './leaderboard.controller';

@Module({
  providers: [StatsService],
  controllers: [StatsController, LeaderboardController],
})
export class StatsModule {}
