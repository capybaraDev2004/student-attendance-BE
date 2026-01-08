type RawWord = {
  hanzi?: string;
  simplified?: string;
  traditional?: string;
  pinyin?: string;
  definition?: string;
  english?: string;
  translation?: string;
  pos?: string;
};

export type VocabularySeedItem = {
  chinese_word: string;
  pinyin: string;
  english?: string;
};

const BACKUP_WORDS: VocabularySeedItem[] = [
  { chinese_word: '一', pinyin: 'yī', english: 'one' },
  { chinese_word: '二', pinyin: 'èr', english: 'two' },
  { chinese_word: '三', pinyin: 'sān', english: 'three' },
  { chinese_word: '人', pinyin: 'rén', english: 'person' },
  { chinese_word: '好', pinyin: 'hǎo', english: 'good' },
  { chinese_word: '爱', pinyin: 'ài', english: 'love' },
  { chinese_word: '学', pinyin: 'xué', english: 'study' },
  { chinese_word: '吃', pinyin: 'chī', english: 'eat' },
  { chinese_word: '喝', pinyin: 'hē', english: 'drink' },
  { chinese_word: '水', pinyin: 'shuǐ', english: 'water' },
  { chinese_word: '茶', pinyin: 'chá', english: 'tea' },
  { chinese_word: '书', pinyin: 'shū', english: 'book' },
  { chinese_word: '车', pinyin: 'chē', english: 'vehicle' },
  { chinese_word: '天', pinyin: 'tiān', english: 'sky' },
  { chinese_word: '雨', pinyin: 'yǔ', english: 'rain' },
  { chinese_word: '热', pinyin: 'rè', english: 'hot' },
  { chinese_word: '冷', pinyin: 'lěng', english: 'cold' },
  { chinese_word: '猫', pinyin: 'māo', english: 'cat' },
  { chinese_word: '狗', pinyin: 'gǒu', english: 'dog' },
  { chinese_word: '鱼', pinyin: 'yú', english: 'fish' },
];

const SOURCES: string[] = [
  'https://raw.githubusercontent.com/glxxyz/hsk-vocab-list/main/hsk1-4.json',
  'https://raw.githubusercontent.com/waynezhanghk/hsk-vocabulary/master/hsk1.json',
  'https://raw.githubusercontent.com/waynezhanghk/hsk-vocabulary/master/hsk2.json',
  'https://raw.githubusercontent.com/waynezhanghk/hsk-vocabulary/master/hsk3.json',
];

export class VocabularyReseedHelper {
  async fetchWordPool(limit: number): Promise<VocabularySeedItem[]> {
    const rawWords = await this.fetchAllSources();
    const items: VocabularySeedItem[] = [];
    const seen = new Set<string>();

    for (const raw of rawWords) {
      if (items.length >= limit * 2) {
        break;
      }

      const hanzi = (
        raw.hanzi ||
        raw.simplified ||
        raw.traditional ||
        ''
      ).trim();
      const pinyin = (raw.pinyin || '').trim();
      if (!hanzi || !pinyin) {
        continue;
      }
      if (seen.has(hanzi)) {
        continue;
      }

      seen.add(hanzi);
      items.push({
        chinese_word: hanzi,
        pinyin,
        english: (
          raw.english ||
          raw.definition ||
          raw.translation ||
          ''
        ).trim(),
      });
    }

    if (!items.length) {
      return BACKUP_WORDS.slice(0, limit);
    }

    return items.slice(0, limit * 2);
  }

  private async fetchAllSources(): Promise<RawWord[]> {
    const results: RawWord[] = [];

    for (const url of SOURCES) {
      try {
        const res = await fetch(url, { cache: 'no-store' });
        if (!res.ok) {
          continue;
        }
        const contentType = res.headers.get('content-type') || '';

        if (contentType.includes('application/json')) {
          const data = await res.json();
          if (Array.isArray(data)) {
            results.push(...(data as RawWord[]));
          } else if (Array.isArray(data?.words)) {
            results.push(...(data.words as RawWord[]));
          }
        } else {
          const text = await res.text();
          const lines = text.split(/\r?\n/).slice(1);
          for (const line of lines) {
            const parts = line.split(',');
            if (parts.length >= 3) {
              results.push({
                hanzi: parts[0],
                pinyin: parts[1],
                english: parts.slice(2).join(','),
              });
            }
          }
        }
      } catch {
        // Bỏ qua nguồn lỗi
      }
    }

    return results;
  }
}
