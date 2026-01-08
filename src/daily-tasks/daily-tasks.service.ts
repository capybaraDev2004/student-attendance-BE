import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class DailyTasksService {
  private readonly logger = new Logger(DailyTasksService.name);
  
  constructor(private readonly prisma: PrismaService) {}

  // Type assertion tạm thời cho đến khi Prisma client được generate lại
  private get dailyTasks() {
    return (this.prisma as any).daily_tasks;
  }

  /**
   * Tạo Date object chỉ có ngày (không có giờ)
   * Sử dụng UTC date với ngày đúng từ local timezone để tránh timezone shift khi Prisma lưu vào PostgreSQL
   * PostgreSQL DATE type lưu dạng YYYY-MM-DD, Prisma sẽ convert Date object sang UTC trước khi lưu
   * Nên cần tạo UTC date với year, month, day từ local timezone để đảm bảo đúng ngày
   */
  private getTodayDateOnly(): Date {
    const now = new Date();
    // Lấy ngày hiện tại theo local timezone (UTC+7 cho VN)
    const year = now.getFullYear();
    const month = now.getMonth();
    const day = now.getDate();
    // Tạo UTC date với year, month, day từ local timezone
    // Điều này đảm bảo khi Prisma convert sang DATE type sẽ đúng ngày (không bị lùi về ngày hôm qua)
    const today = new Date(Date.UTC(year, month, day, 0, 0, 0, 0));
    return today;
  }
  
  /**
   * Normalize date để so sánh (chỉ lấy YYYY-MM-DD, bỏ qua timezone)
   * Date từ database (DATE type) được Prisma trả về dưới dạng UTC Date object
   * Nên dùng UTC methods để lấy đúng year, month, day
   */
  private normalizeDateOnly(date: Date | string): string {
    let dateObj: Date;
    if (date instanceof Date) {
      // Date từ database là UTC, dùng UTC methods để lấy đúng year, month, day
      const year = date.getUTCFullYear();
      const month = date.getUTCMonth() + 1;
      const day = date.getUTCDate();
      return `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    } else if (typeof date === 'string') {
      // Parse từ string YYYY-MM-DD - trả về trực tiếp vì đã là string format đúng
      return date.split('T')[0];
    } else {
      // Fallback: parse và dùng UTC methods
      dateObj = new Date(date);
      const year = dateObj.getUTCFullYear();
      const month = dateObj.getUTCMonth() + 1;
      const day = dateObj.getUTCDate();
      return `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    }
  }

  /**
   * Lấy hoặc tạo daily_tasks cho user trong ngày hiện tại
   */
  async getOrCreateTodayTask(userId: number) {
    const todayDate = this.getTodayDateOnly();

    return this.dailyTasks.upsert({
      where: {
        user_id_date: {
          user_id: userId,
          date: todayDate,
        },
      },
      update: {},
      create: {
        user_id: userId,
        date: todayDate,
        vocabulary_count: 0,
        sentence_count: 0,
        contest_completed: false,
        points_awarded: 10,
        points_given: false,
      },
    });
  }

  /**
   * Tăng số từ vựng đã học (tối đa 10)
   * Sử dụng transaction để tránh race condition
   */
  async incrementVocabulary(userId: number) {
    const todayDate = this.getTodayDateOnly();

    // Sử dụng transaction để đảm bảo atomicity và tránh race condition
    return this.prisma.$transaction(async (tx) => {
      const dailyTasks = (tx as any).daily_tasks;

      // Lấy task hiện tại trong transaction
      const existingTask = await dailyTasks.findUnique({
        where: {
          user_id_date: {
            user_id: userId,
            date: todayDate,
          },
        },
      });

      // Nếu đã đạt giới hạn 10, không tăng nữa
      if (existingTask && existingTask.vocabulary_count >= 10) {
        return existingTask;
      }

      // Upsert với điều kiện: chỉ tăng nếu chưa đạt 10
      const task = await dailyTasks.upsert({
        where: {
          user_id_date: {
            user_id: userId,
            date: todayDate,
          },
        },
        update: {
          vocabulary_count: {
            // Chỉ tăng nếu chưa đạt 10
            increment: existingTask && existingTask.vocabulary_count < 10 ? 1 : 0,
          },
        },
        create: {
          user_id: userId,
          date: todayDate,
          vocabulary_count: 1,
          sentence_count: 0,
          contest_completed: false,
          points_awarded: 10,
          points_given: false,
        },
      });

      // Đảm bảo không vượt quá 10 (double check)
      if (task.vocabulary_count > 10) {
        const updatedTask = await dailyTasks.update({
          where: { id: task.id },
          data: { vocabulary_count: 10 },
        });
        await this.checkAndAwardPoints(userId, updatedTask);
        return updatedTask;
      }

      // Kiểm tra và cập nhật điểm nếu đủ điều kiện
      await this.checkAndAwardPoints(userId, task);

      return task;
    });
  }

  /**
   * Tăng số câu nói đã học (tối đa 5)
   * Sử dụng transaction để tránh race condition
   */
  async incrementSentence(userId: number) {
    const todayDate = this.getTodayDateOnly();
    this.logger.log(`[incrementSentence] userId: ${userId}, date: ${todayDate.toISOString().split('T')[0]}`);

    // Sử dụng transaction để đảm bảo atomicity và tránh race condition
    return this.prisma.$transaction(async (tx) => {
      const dailyTasks = (tx as any).daily_tasks;

      // Lấy task hiện tại trong transaction
      const existingTask = await dailyTasks.findUnique({
        where: {
          user_id_date: {
            user_id: userId,
            date: todayDate,
          },
        },
      });

      this.logger.log(`[incrementSentence] existingTask: ${existingTask ? JSON.stringify({ sentence_count: existingTask.sentence_count, contest_completed: existingTask.contest_completed }) : 'null'}`);

      // Nếu đã đạt giới hạn 5 VÀ đã hoàn thành contest, không tăng nữa
      // Cho phép tăng đến 5 ngay cả khi chưa hoàn thành contest
      if (existingTask && existingTask.sentence_count >= 5 && existingTask.contest_completed) {
        this.logger.log(`[incrementSentence] Blocked: already at 5 and contest completed`);
        return existingTask;
      }

      // Upsert với điều kiện: chỉ tăng nếu chưa đạt 5 hoặc chưa hoàn thành contest
      const task = await dailyTasks.upsert({
        where: {
          user_id_date: {
            user_id: userId,
            date: todayDate,
          },
        },
        update: {
          sentence_count: {
            // Chỉ tăng nếu chưa đạt 5, hoặc đã đạt 5 nhưng chưa hoàn thành contest
            increment: existingTask && existingTask.sentence_count < 5 ? 1 : 0,
          },
        },
        create: {
          user_id: userId,
          date: todayDate,
          vocabulary_count: 0,
          sentence_count: 1,
          contest_completed: false,
          points_awarded: 10,
          points_given: false,
        },
      });

      // Đảm bảo không vượt quá 5 (double check)
      if (task.sentence_count > 5) {
        const updatedTask = await dailyTasks.update({
          where: { id: task.id },
          data: { sentence_count: 5 },
        });
        await this.checkAndAwardPoints(userId, updatedTask);
        this.logger.log(`[incrementSentence] Updated task (capped at 5): sentence_count=${updatedTask.sentence_count}`);
        return updatedTask;
      }

      // Kiểm tra và cập nhật điểm nếu đủ điều kiện
      await this.checkAndAwardPoints(userId, task);

      this.logger.log(`[incrementSentence] Updated task: sentence_count=${task.sentence_count}`);
      return task;
    });
  }

  /**
   * Đánh dấu đã hoàn thành bài trong cuộc thi (chỉ 1 lần)
   */
  async markContestCompleted(userId: number) {
    const todayDate = this.getTodayDateOnly();

    // Lấy task hiện tại
    const existingTask = await this.dailyTasks.findUnique({
      where: {
        user_id_date: {
          user_id: userId,
          date: todayDate,
        },
      },
    });

    // Nếu đã hoàn thành rồi, không cập nhật nữa
    if (existingTask && existingTask.contest_completed) {
      return existingTask;
    }

    const task = await this.dailyTasks.upsert({
      where: {
        user_id_date: {
          user_id: userId,
          date: todayDate,
        },
      },
      update: {
        contest_completed: true,
      },
      create: {
        user_id: userId,
        date: todayDate,
        vocabulary_count: 0,
        sentence_count: 0,
        contest_completed: true,
        points_awarded: 10,
        points_given: false,
      },
    });

    // Kiểm tra và cập nhật điểm nếu đủ điều kiện
    await this.checkAndAwardPoints(userId, task);

    return task;
  }

  /**
   * Kiểm tra và cập nhật điểm nếu đủ điều kiện
   */
  private async checkAndAwardPoints(userId: number, task: any) {
    // Lấy lại task mới nhất để đảm bảo có dữ liệu chính xác
    const latestTask = await this.dailyTasks.findUnique({
      where: { id: task.id },
    });

    if (!latestTask) {
      this.logger.warn(`[checkAndAwardPoints] Task not found: id=${task.id}`);
      return;
    }

    this.logger.log(`[checkAndAwardPoints] Checking for userId=${userId}: vocab=${latestTask.vocabulary_count}, sentence=${latestTask.sentence_count}, contest=${latestTask.contest_completed}, points_given=${latestTask.points_given}`);

    // Chỉ cập nhật nếu chưa tặng điểm và đủ điều kiện
    if (
      !latestTask.points_given &&
      latestTask.vocabulary_count >= 10 &&
      latestTask.sentence_count >= 5 &&
      latestTask.contest_completed
    ) {
      const today = this.getTodayDateOnly();
      const monthCycle = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}`;

      this.logger.log(`[checkAndAwardPoints] Awarding ${latestTask.points_awarded} points to userId=${userId} for monthCycle=${monthCycle}`);

      // Cập nhật trong transaction
      await this.prisma.$transaction(async (tx) => {
        // Cập nhật points_given = true
        await (tx as any).daily_tasks.update({
          where: { id: latestTask.id },
          data: { points_given: true },
        });

        // Cộng điểm vào user_monthly_scores
        await tx.user_monthly_scores.upsert({
          where: {
            user_id_month_cycle: {
              user_id: userId,
              month_cycle: monthCycle,
            },
          },
          update: {
            score: { increment: latestTask.points_awarded },
          },
          create: {
            user_id: userId,
            month_cycle: monthCycle,
            score: latestTask.points_awarded,
          },
        });
      });

      this.logger.log(`[checkAndAwardPoints] Successfully awarded ${latestTask.points_awarded} points to userId=${userId}`);
    } else {
      if (latestTask.points_given) {
        this.logger.log(`[checkAndAwardPoints] Points already given for userId=${userId}`);
      } else {
        this.logger.log(`[checkAndAwardPoints] Conditions not met for userId=${userId}: vocab=${latestTask.vocabulary_count}/10, sentence=${latestTask.sentence_count}/5, contest=${latestTask.contest_completed}`);
      }
    }
  }

  /**
   * Lấy thông tin nhiệm vụ hôm nay
   * Đảm bảo lấy đúng record có date = ngày hôm nay (theo local timezone)
   * Tự động kiểm tra và tặng điểm nếu đủ điều kiện nhưng chưa được tặng
   */
  async getTodayTask(userId: number) {
    const todayDate = this.getTodayDateOnly();
    
    // Query với date chính xác của ngày hôm nay
    // Prisma sẽ so sánh DATE type với Date object, cần đảm bảo timezone đúng
    const task = await this.dailyTasks.findUnique({
      where: {
        user_id_date: {
          user_id: userId,
          date: todayDate,
        },
      },
    });

    // Nếu không tìm thấy, trả về null (controller sẽ xử lý)
    if (!task) {
      return null;
    }

    // Tự động kiểm tra và tặng điểm nếu đủ điều kiện nhưng chưa được tặng
    // Điều này đảm bảo điểm được tặng ngay cả khi user đã hoàn thành hết trước đó
    await this.checkAndAwardPoints(userId, task);

    // Lấy lại task sau khi có thể đã được cập nhật (points_given có thể đã thay đổi)
    const updatedTask = await this.dailyTasks.findUnique({
      where: {
        user_id_date: {
          user_id: userId,
          date: todayDate,
        },
      },
    });

    return updatedTask;
  }
}

