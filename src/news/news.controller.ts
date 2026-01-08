import { Controller, Get, Post, Put, Delete, Body, Param, ParseIntPipe, UseGuards } from '@nestjs/common';
import { NewsService } from './news.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';

@Controller('news')
export class NewsController {
  constructor(private readonly newsService: NewsService) {}

  /**
   * Lấy tin tức đang active (public, không cần auth)
   */
  @Get('active')
  async getActiveNews() {
    return this.newsService.getActiveNews();
  }

  /**
   * Lấy tất cả tin tức (chỉ admin)
   */
  @Get()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  async getAllNews() {
    return this.newsService.getAllNews();
  }

  /**
   * Tạo tin tức mới (chỉ admin)
   */
  @Post()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  async createNews(@Body() data: { title: string; content: string; start_date: string; end_date: string }) {
    return this.newsService.createNews({
      title: data.title,
      content: data.content,
      start_date: new Date(data.start_date),
      end_date: new Date(data.end_date),
    });
  }

  /**
   * Cập nhật tin tức (chỉ admin)
   */
  @Put(':id')
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  async updateNews(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: { title?: string; content?: string; start_date?: string; end_date?: string },
  ) {
    const updateData: any = {};
    if (data.title !== undefined) updateData.title = data.title;
    if (data.content !== undefined) updateData.content = data.content;
    if (data.start_date !== undefined) updateData.start_date = new Date(data.start_date);
    if (data.end_date !== undefined) updateData.end_date = new Date(data.end_date);

    return this.newsService.updateNews(id, updateData);
  }

  /**
   * Xóa tin tức (chỉ admin)
   */
  @Delete(':id')
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('admin')
  async deleteNews(@Param('id', ParseIntPipe) id: number) {
    return this.newsService.deleteNews(id);
  }
}

