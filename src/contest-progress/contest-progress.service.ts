import { Injectable } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ContestProgressService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Tạo Date object chỉ có ngày (không có giờ)
   * Sử dụng UTC date với ngày đúng từ local timezone để tránh timezone shift khi Prisma lưu vào PostgreSQL
   * PostgreSQL DATE type lưu dạng YYYY-MM-DD, Prisma sẽ convert Date object sang UTC trước khi lưu
   * Nên cần tạo UTC date với year, month, day từ local timezone để đảm bảo đúng ngày
   */
  private todayLocalDate(): Date {
    const now = new Date();
    // Lấy ngày hiện tại theo local timezone
    const year = now.getFullYear();
    const month = now.getMonth();
    const day = now.getDate();
    // Tạo UTC date với year, month, day từ local timezone
    // Điều này đảm bảo khi Prisma convert sang DATE type sẽ đúng ngày (không bị lùi về ngày hôm qua)
    return new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
  }

  private normalizeDateOnly(date: Date): Date {
    // Đảm bảo normalize đúng bằng cách lấy year, month, day từ date object
    // Tạo UTC date để tránh timezone issues khi so sánh với date từ database
    if (date instanceof Date && !isNaN(date.getTime())) {
      // Nếu date đã là Date object, lấy year, month, day trực tiếp
      // Tạo UTC date để đảm bảo consistency với cách lưu vào database
      const year = date.getUTCFullYear();
      const month = date.getUTCMonth();
      const day = date.getUTCDate();
      return new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
    }
    // Fallback: tạo UTC date mới
    const year = date.getUTCFullYear();
    const month = date.getUTCMonth();
    const day = date.getUTCDate();
    return new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
  }

  private monthCycleLocal(now = new Date()): string {
    const yyyy = now.getFullYear();
    const mm = String(now.getMonth() + 1).padStart(2, '0');
    return `${yyyy}-${mm}`;
  }

  /**
   * Tăng số câu đúng cho 1 user trong 1 cuộc thi (bài) cụ thể.
   * Chỉ được gọi khi trả lời đúng.
   * Lưu điểm vào user_daily_scores và user_monthly_scores.
   */
  async incrementCorrectAnswer(params: {
    userId: number;
    contestId: number;
    totalQuestions: number;
  }) {
    const { userId } = params;
    const scoreDate = this.todayLocalDate();
    const monthCycle = this.monthCycleLocal();

    return this.prisma.$transaction(async (tx) => {
      // Ghi điểm ngày (tích luỹ từng câu đúng)
      await tx.user_daily_scores.upsert({
        where: {
          user_id_score_date: {
            user_id: userId,
            score_date: scoreDate,
          },
        },
        update: {
          score: { increment: 1 },
        },
        create: {
          user_id: userId,
          score_date: scoreDate,
          score: 1,
        },
      });

      // Ghi điểm tháng (tích luỹ từng câu đúng)
      await tx.user_monthly_scores.upsert({
        where: {
          user_id_month_cycle: {
            user_id: userId,
            month_cycle: monthCycle,
          },
        },
        update: {
          score: { increment: 1 },
        },
        create: {
          user_id: userId,
          month_cycle: monthCycle,
          score: 1,
        },
      });

      return { success: true };
    });
  }

  /**
   * Lấy tiến độ hiện tại của user trong 1 cuộc thi
   * (Không còn dùng weekly_contest_progress, trả về null)
   */
  async getProgress(userId: number, contestId: number) {
    return null;
  }

  /**
   * Tính chuỗi chuyên cần liên tục dựa trên ngày (không quan tâm giờ).
   * - Dữ liệu lấy từ bảng user_daily_scores, tính ngày có điểm (score > 0).
   * - Tính chuỗi liên tục từ ngày gần nhất có hoạt động về trước.
   * - Nếu ngày 30 có lịch sử và ngày 31 cũng có thì chuỗi là 2 ngày.
   * - Chỉ quan tâm đến ngày, không quan tâm giờ trong ngày.
   */
  async getAttendanceStreak(userId: number) {
    const today = this.todayLocalDate();

    // Lấy tất cả các điểm ngày của user từ user_daily_scores
    // Có hoạt động = có điểm (score > 0)
    const allScores = await this.prisma.user_daily_scores.findMany({
      where: {
        user_id: userId,
        score: { gt: 0 },
      },
      select: { 
        score_date: true,
        score: true,
      },
      orderBy: { score_date: 'desc' },
    });

    // Debug log đã được xóa để tránh spam console

    if (allScores.length === 0) {
      return {
        streakDays: 0,
        hasToday: false,
        lastActiveDate: null,
      };
    }

    // Loại bỏ trùng lặp ngày (vì có thể có nhiều record cùng ngày)
    // Date từ database (DATE type) được Prisma trả về dưới dạng UTC Date object
    // Cần dùng UTC methods để lấy đúng year, month, day
    const normalizedDatesMap = new Map<string, Date>();
    allScores.forEach((row: any) => {
      // score_date từ database có thể là Date object hoặc string
      // Cần parse đúng để tránh timezone issues
      let dateObj: Date;
      if (row.score_date instanceof Date) {
        // Date từ database là UTC, dùng UTC methods để lấy đúng year, month, day
        const year = row.score_date.getUTCFullYear();
        const month = row.score_date.getUTCMonth();
        const day = row.score_date.getUTCDate();
        dateObj = new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
      } else if (typeof row.score_date === 'string') {
        // Parse từ string (YYYY-MM-DD) - tránh timezone issues
        const dateStr = row.score_date.split('T')[0]; // Lấy phần date nếu có time
        const [year, month, day] = dateStr.split('-').map(Number);
        dateObj = new Date(Date.UTC(year, month - 1, day, 0, 0, 0, 0));
      } else {
        // Fallback: tạo UTC date mới
        const tempDate = new Date(row.score_date);
        const year = tempDate.getUTCFullYear();
        const month = tempDate.getUTCMonth();
        const day = tempDate.getUTCDate();
        dateObj = new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
      }
      
      // Tạo date key từ UTC date để đảm bảo consistency
      const dateKey = `${dateObj.getUTCFullYear()}-${String(dateObj.getUTCMonth() + 1).padStart(2, '0')}-${String(dateObj.getUTCDate()).padStart(2, '0')}`;
      
      // Chỉ lưu nếu chưa có (tránh trùng lặp)
      if (!normalizedDatesMap.has(dateKey)) {
        normalizedDatesMap.set(dateKey, dateObj);
      }
    });

    const normalizedDates = Array.from(normalizedDatesMap.values());
    
    // Sắp xếp giảm dần (ngày mới nhất trước)
    const sortedDates = normalizedDates.sort((a, b) => b.getTime() - a.getTime());
    
    // Tạo Set để kiểm tra nhanh - sử dụng string key từ UTC date để tránh timezone issues
    const dateSet = new Set<string>();
    sortedDates.forEach((d) => {
      const dateKey = `${d.getUTCFullYear()}-${String(d.getUTCMonth() + 1).padStart(2, '0')}-${String(d.getUTCDate()).padStart(2, '0')}`;
      dateSet.add(dateKey);
    });

    if (sortedDates.length === 0) {
      return {
        streakDays: 0,
        hasToday: false,
        lastActiveDate: null,
      };
    }

    // Kiểm tra xem hôm nay có trong danh sách không
    // Dùng UTC methods để đảm bảo consistency với date từ database
    const todayKey = `${today.getUTCFullYear()}-${String(today.getUTCMonth() + 1).padStart(2, '0')}-${String(today.getUTCDate()).padStart(2, '0')}`;
    const hasToday = dateSet.has(todayKey);
    
    // Tính ngày hôm qua (trừ đi 1 ngày trong UTC)
    const yesterday = new Date(Date.UTC(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate() - 1, 0, 0, 0, 0));
    const yesterdayKey = `${yesterday.getUTCFullYear()}-${String(yesterday.getUTCMonth() + 1).padStart(2, '0')}-${String(yesterday.getUTCDate()).padStart(2, '0')}`;
    const hasYesterday = dateSet.has(yesterdayKey);

    // Nếu không có hôm nay và hôm qua => reset về 0
    if (!hasToday && !hasYesterday) {
      return {
        streakDays: 0,
        hasToday: false,
        lastActiveDate: null,
      };
    }

    // Bắt đầu từ hôm nay (để lấy dữ liệu), nếu hôm nay không có thì từ hôm qua
    // Đây là điểm bắt đầu để tính streak
    const startDate = hasToday ? today : yesterday;
    // Tạo UTC cursor để đảm bảo consistency
    let cursor = new Date(Date.UTC(startDate.getUTCFullYear(), startDate.getUTCMonth(), startDate.getUTCDate(), 0, 0, 0, 0));
    let streak = 0;
    let lastActive: Date | null = startDate; // Ngày bắt đầu của chuỗi (hôm nay hoặc hôm qua)

    // Đi ngược lại về quá khứ chỉ để đếm chuỗi ngày liên tiếp
    // Dừng lại khi gặp ngày không có hoạt động
    while (true) {
      const cursorKey = `${cursor.getUTCFullYear()}-${String(cursor.getUTCMonth() + 1).padStart(2, '0')}-${String(cursor.getUTCDate()).padStart(2, '0')}`;
      
      if (!dateSet.has(cursorKey)) {
        break; // Dừng khi gặp ngày không có hoạt động
      }
      
      streak += 1;
      
      // Lùi về ngày trước đó (trừ đi 1 ngày trong UTC) - chỉ để đếm, không lấy dữ liệu
      cursor = new Date(Date.UTC(cursor.getUTCFullYear(), cursor.getUTCMonth(), cursor.getUTCDate() - 1, 0, 0, 0, 0));
    }

    // Đảm bảo luôn trả về object hợp lệ
    return {
      streakDays: streak || 0,
      hasToday: hasToday || false,
      lastActiveDate: lastActive ? lastActive.toISOString() : null,
    };
  }

  /**
   * Đánh dấu hoàn thành bài hôm nay.
   * Chỉ đánh dấu contest_completed trong daily_tasks.
   * KHÔNG cộng điểm vào user_daily_scores vì điểm đã được cộng từng câu qua incrementCorrectAnswer() rồi.
   */
  async finishToday(params: {
    userId: number;
    contestId: number;
    totalQuestions: number;
    correctCount: number;
  }) {
    const today = this.todayLocalDate();
    
    return this.prisma.$transaction(async (tx) => {
      // Đảm bảo có record trong user_daily_scores (nếu chưa có thì tạo với score = 0)
      // Điều này đảm bảo streak tracking hoạt động đúng
      const scoreDate = this.todayLocalDate();
      await tx.user_daily_scores.upsert({
        where: {
          user_id_score_date: {
            user_id: params.userId,
            score_date: scoreDate,
          },
        },
        update: {
          // Không cập nhật score ở đây vì đã được cộng từng câu rồi
        },
        create: {
          user_id: params.userId,
          score_date: scoreDate,
          score: 0, // Tạo với score = 0, điểm đã được cộng từng câu qua incrementCorrectAnswer()
        },
      });

      // Đánh dấu đã hoàn thành contest trong daily_tasks
      await (tx as any).daily_tasks.upsert({
        where: {
          user_id_date: {
            user_id: params.userId,
            date: today,
          },
        },
        update: {
          contest_completed: true,
        },
        create: {
          user_id: params.userId,
          date: today,
          vocabulary_count: 0,
          sentence_count: 0,
          contest_completed: true,
          points_awarded: 10,
          points_given: false,
        },
      });

      return { success: true };
    });
  }

  /**
   * Danh sách bài đã hoàn thành trong ngày (để disable UI)
   * Kiểm tra từ daily_tasks xem đã hoàn thành contest chưa
   */
  async listCompletedToday(userId: number) {
    const today = this.todayLocalDate();
    
    const task = await (this.prisma as any).daily_tasks.findUnique({
      where: {
        user_id_date: {
          user_id: userId,
          date: today,
        },
      },
    });

    // Nếu đã hoàn thành contest hôm nay, trả về tất cả contest (vì không track contest cụ thể nữa)
    // Frontend có thể disable tất cả contest nếu đã hoàn thành
    if (task && task.contest_completed) {
      // Trả về một mảng rỗng với flag để frontend biết đã hoàn thành
      // Hoặc có thể trả về tất cả contest_id nếu cần
      return [{ all_completed: true }];
    }

    return [];
  }
}


