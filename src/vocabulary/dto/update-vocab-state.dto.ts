import { IsBoolean, IsInt } from 'class-validator';

export class MarkVocabReadDto {
  @IsInt()
  vocabId: number;
}

export class UpdateVocabMemorizedDto {
  @IsInt()
  vocabId: number;

  @IsBoolean()
  isMemorized: boolean;
}


