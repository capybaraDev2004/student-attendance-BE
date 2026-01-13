import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';

import { Roles } from '../auth/decorators/roles.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UsersService } from './users.service';
import { VipExpirationService } from './vip-expiration.service';

@Controller('admin/users')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('admin')
export class AdminUsersController {
  constructor(
    private readonly usersService: UsersService,
    private readonly vipExpirationService: VipExpirationService,
  ) {}

  @Get()
  findAll() {
    // Admin cần xem toàn bộ danh sách người dùng cùng thời gian tạo
    return this.usersService.findAll();
  }

  @Post()
  create(@Body() dto: CreateUserDto) {
    return this.usersService.create(dto);
  }

  @Patch(':id')
  update(@Param('id', ParseIntPipe) id: number, @Body() dto: UpdateUserDto) {
    return this.usersService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.usersService.remove(id);
  }

  /**
   * Endpoint để test thủ công việc kiểm tra và hạ VIP đã hết hạn
   * GET /admin/users/check-expired-vip
   */
  @Get('check-expired-vip')
  async checkExpiredVip() {
    await this.vipExpirationService.checkAndExpireVip();
    return { message: 'Đã kiểm tra và cập nhật VIP đã hết hạn' };
  }
}
