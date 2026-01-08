import { Controller, Get, Query } from '@nestjs/common';
import { StatsService } from './stats.service';

type LeaderboardScope = 'country' | 'region' | 'province';

@Controller('leaderboard')
export class LeaderboardController {
  constructor(private readonly statsService: StatsService) {}

  @Get()
  async getLeaderboard(
    @Query('scope') scope: LeaderboardScope = 'country',
    @Query('region') region?: string,
    @Query('province') province?: string,
  ) {
    const normalized: LeaderboardScope =
      scope === 'region' || scope === 'province' ? scope : 'country';

    return this.statsService.leaderboard(normalized, region, province);
  }
}


