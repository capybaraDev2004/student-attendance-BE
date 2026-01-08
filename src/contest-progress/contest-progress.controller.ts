import {
  BadRequestException,
  Body,
  Controller,
  Get,
  Post,
  Query,
  UnauthorizedException,
  UseGuards,
} from '@nestjs/common';

import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ContestProgressService } from './contest-progress.service';
import { UpdateContestProgressDto } from './dto/update-contest-progress.dto';
import { FinishContestDto } from './dto/finish-contest.dto';

@Controller('contest-progress')
@UseGuards(JwtAuthGuard)
export class ContestProgressController {
  constructor(private readonly contestProgressService: ContestProgressService) {}

  /**
   * Ghi nhận 1 câu trả lời đúng cho cuộc thi.
   * Chỉ khi isCorrect = true mới cập nhật DB; nếu sai thì bỏ qua.
   */
  @Post()
  async updateProgress(
    @CurrentUser() user: any,
    @Body() body: UpdateContestProgressDto,
  ) {
    const userId = user?.user_id;
    if (!userId) {
      // Phòng trường hợp token không hợp lệ
      throw new UnauthorizedException('Không xác định được người dùng');
    }

    // Nếu không đúng thì không ghi nhận vào DB
    if (!body.isCorrect) {
      return this.contestProgressService.getProgress(userId, body.contestId);
    }

    return this.contestProgressService.incrementCorrectAnswer({
      userId,
      contestId: body.contestId,
      totalQuestions: body.totalQuestions,
    });
  }

  /**
   * Chốt bài trong ngày (đánh dấu đã hoàn thành) để khoá 1 lần/ngày/bài
   */
  @Post('finish')
  async finish(@CurrentUser() user: any, @Body() body: FinishContestDto) {
    const userId = user?.user_id;
    if (!userId) throw new UnauthorizedException('Không xác định được người dùng');

    return this.contestProgressService.finishToday({
      userId,
      contestId: body.contestId,
      totalQuestions: body.totalQuestions,
      correctCount: body.correctCount,
    });
  }

  /**
   * Danh sách bài đã hoàn thành trong ngày (để UI disable)
   */
  @Get('today')
  async today(@CurrentUser() user: any) {
    const userId = user?.user_id;
    if (!userId) throw new UnauthorizedException('Không xác định được người dùng');
    const items = await this.contestProgressService.listCompletedToday(userId);
    return { items };
  }

  /**
   * Chuỗi chuyên cần (dựa vào bảng user_daily_scores)
   */
  @Get('streak')
  async attendanceStreak(@CurrentUser() user: any) {
    const userId = user?.user_id;
    if (!userId) throw new UnauthorizedException('Không xác định được người dùng');
    return this.contestProgressService.getAttendanceStreak(userId);
  }

  /**
   * Lấy tiến độ làm bài hiện tại của user cho 1 cuộc thi
   */
  @Get()
  async getProgress(
    @CurrentUser() user: any,
    @Query('contestId') contestId: string,
  ) {
    const userId = user?.user_id;
    const id = Number(contestId);
    if (!userId || !id) {
      if (!userId) throw new UnauthorizedException('Không xác định được người dùng');
      throw new BadRequestException('Thiếu hoặc sai contestId');
    }
    return this.contestProgressService.getProgress(userId, id);
  }
}


