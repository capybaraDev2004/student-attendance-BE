import { IsInt, Min } from 'class-validator';

export class FinishContestDto {
  @IsInt()
  @Min(1)
  contestId: number;

  @IsInt()
  @Min(1)
  totalQuestions: number;

  @IsInt()
  @Min(0)
  correctCount: number;
}


