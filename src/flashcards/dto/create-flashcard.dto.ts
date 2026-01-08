import { IsString, IsOptional, IsNotEmpty } from 'class-validator';

export class CreateFlashcardDto {
  @IsOptional()
  @IsString()
  image_url?: string;

  @IsNotEmpty()
  @IsString()
  answer: string;

  @IsOptional()
  @IsString()
  status?: string;
}

