import { IsString, IsOptional } from 'class-validator';

export class UpdateFlashcardDto {
  @IsOptional()
  @IsString()
  image_url?: string;

  @IsOptional()
  @IsString()
  answer?: string;

  @IsOptional()
  @IsString()
  status?: string;
}

