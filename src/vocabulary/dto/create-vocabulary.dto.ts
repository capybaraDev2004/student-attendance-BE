import {
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateVocabularyDto {
  @IsNotEmpty({ message: 'Từ tiếng Trung không được bỏ trống' })
  @IsString({ message: 'Từ tiếng Trung phải là chuỗi' })
  @MaxLength(255, { message: 'Từ tiếng Trung quá dài' })
  chinese_word!: string;

  @IsOptional()
  @IsString({ message: 'Phiên âm pinyin phải là chuỗi' })
  @MaxLength(255, { message: 'Pinyin quá dài' })
  pinyin?: string | null;

  @IsNotEmpty({ message: 'Nghĩa tiếng Việt không được bỏ trống' })
  @IsString({ message: 'Nghĩa tiếng Việt phải là chuỗi' })
  @MinLength(1, { message: 'Nghĩa tiếng Việt quá ngắn' })
  meaning_vn!: string;

  @IsOptional()
  @IsString({ message: 'Link audio phải là chuỗi' })
  audio_url?: string | null;

  @IsOptional()
  @IsInt({ message: 'category_id phải là số nguyên' })
  category_id?: number | null;
}
