import { Injectable, Logger } from '@nestjs/common';

export interface DictionaryResult {
  word: string;
  partOfSpeech?: string; // verb, noun, adjective, etc.
  definition?: string;
  examples?: string[];
  source: string;
}

@Injectable()
export class DictionaryApiService {
  private readonly logger = new Logger(DictionaryApiService.name);

  /**
   * Tra cứu từ tiếng Trung qua nhiều API để lấy loại từ
   * Sử dụng nhiều nguồn để tăng độ chính xác
   */
  async lookupChineseWord(chineseWord: string): Promise<DictionaryResult[]> {
    const results: DictionaryResult[] = [];

    // Thử các API song song
    const promises = [
      this.lookupCCDict(chineseWord),
      this.lookupMoeDict(chineseWord),
      // Có thể thêm API khác: Pleco, HanDeDict, etc.
    ];

    const settled = await Promise.allSettled(promises);
    
    for (const result of settled) {
      if (result.status === 'fulfilled' && result.value) {
        results.push(result.value);
      } else if (result.status === 'rejected') {
        this.logger.warn(`API lookup failed: ${result.reason}`);
      }
    }

    return results;
  }

  /**
   * CC-CEDICT API (từ điển Trung-Anh mã nguồn mở)
   */
  private async lookupCCDict(word: string): Promise<DictionaryResult | null> {
    try {
      // CC-CEDICT có thể truy vấn qua API hoặc file tĩnh
      // Ví dụ: https://www.mdbg.net/chinese/dictionary?page=worddict&wdrst=0&wdqb=
      const url = `https://www.mdbg.net/chinese/dictionary?page=worddict&wdrst=0&wdqb=${encodeURIComponent(word)}`;
      
      const response = await fetch(url, {
        headers: { 'User-Agent': 'Mozilla/5.0' },
      });

      // Parse HTML để lấy part of speech
      // (Cần thư viện như cheerio để parse HTML)
      // Tạm thời return null, sẽ implement sau
      
      return null;
    } catch (error) {
      this.logger.debug(`CC-CEDICT lookup failed for ${word}`);
      return null;
    }
  }

  /**
   * 教育部國語辭典 (Từ điển tiếng Trung của Đài Loan)
   */
  private async lookupMoeDict(word: string): Promise<DictionaryResult | null> {
    try {
      // API: https://github.com/g0v/moedict-webkit
      const url = `https://www.moedict.tw/uni/${encodeURIComponent(word)}`;
      
      const response = await fetch(url, {
        headers: { Accept: 'application/json' },
      });
      if (!response.ok) {
        throw new Error(`Request failed with status ${response.status}`);
      }

      const data = await response.json();

      if (data && data.heteronyms) {
        const firstEntry = data.heteronyms[0];
        const definitions = firstEntry?.definitions || [];
        
        return {
          word,
          definition: definitions[0]?.def || '',
          partOfSpeech: this.extractPartOfSpeech(definitions[0]?.def || ''),
          source: 'moedict',
        };
      }

      return null;
    } catch (error) {
      this.logger.debug(`MoeDict lookup failed for ${word}`);
      return null;
    }
  }

  /**
   * Trích xuất loại từ từ định nghĩa
   */
  private extractPartOfSpeech(definition: string): string | undefined {
    const posPatterns = [
      { pattern: /^動\s/, type: 'verb' },
      { pattern: /^名\s/, type: 'noun' },
      { pattern: /^形\s/, type: 'adjective' },
      { pattern: /^副\s/, type: 'adverb' },
      { pattern: /^介\s/, type: 'preposition' },
      { pattern: /^連\s/, type: 'conjunction' },
      { pattern: /^助\s/, type: 'particle' },
    ];

    for (const { pattern, type } of posPatterns) {
      if (pattern.test(definition)) {
        return type;
      }
    }

    return undefined;
  }

  /**
   * Tra cứu nghĩa tiếng Việt qua Google Translate API
   * (Cần API key hoặc dùng unofficial API)
   */
  async translateToVietnamese(chineseWord: string): Promise<string | null> {
    try {
      // Tạm thời return null, cần implement với Google Translate API
      // Hoặc dùng service translate đã có sẵn trong project
      return null;
    } catch (error) {
      this.logger.debug(`Translation failed for ${chineseWord}`);
      return null;
    }
  }
}


