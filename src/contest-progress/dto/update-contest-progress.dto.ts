import { IsBoolean, IsInt, Min } from 'class-validator';

export class UpdateContestProgressDto {
  @IsInt()
  @Min(1)
  contestId: number;

  @IsInt()
  @Min(1)
  totalQuestions: number;

  // Chỉ khi true mới được cập nhật điểm
  @IsBoolean()
  isCorrect: boolean;
}


