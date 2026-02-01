import { Controller, Get, UseGuards } from '@nestjs/common';

import { Roles } from '../auth/decorators/roles.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { StatsService } from './stats.service';

@Controller('admin/stats')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('admin')
export class StatsController {
  constructor(private readonly statsService: StatsService) {}

  @Get()
  overview() {
    return this.statsService.overview();
  }

  @Get('payments-chart')
  paymentsChart() {
    return this.statsService.paymentsChart();
  }
}
