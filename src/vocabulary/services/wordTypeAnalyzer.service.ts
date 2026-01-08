import { Injectable } from '@nestjs/common';

export type WordType = 'verb' | 'noun' | 'adjective' | 'adverb' | 'particle' | 'unknown';

export interface WordTypeAnalysis {
  type: WordType;
  confidence: number; // 0-100
  reasons: string[];
}

@Injectable()
export class WordTypeAnalyzerService {
  /**
   * Phân tích loại từ dựa trên nghĩa tiếng Việt
   * Sử dụng nhiều tầng kiểm tra để đảm bảo độ chính xác
   */
  analyzeWordType(
    chineseWord: string,
    pinyin: string | null,
    meaningVn: string,
  ): WordTypeAnalysis {
    const normalized = this.normalizeMeaning(meaningVn);
    const words = normalized.split(/\s+/).filter(Boolean);

    // Kiểm tra theo thứ tự ưu tiên
    const checks = [
      this.checkParticle(meaningVn, chineseWord),
      this.checkVerb(meaningVn, normalized, words, chineseWord),
      this.checkAdjective(meaningVn, normalized, words, chineseWord),
      this.checkNoun(meaningVn, normalized, words, chineseWord),
      this.checkAdverb(meaningVn, normalized, words),
    ];

    // Lấy kết quả có confidence cao nhất
    const best = checks.reduce((prev, curr) =>
      curr.confidence > prev.confidence ? curr : prev,
    );

    return best.confidence > 0 ? best : { type: 'unknown', confidence: 0, reasons: [] };
  }

  private normalizeMeaning(meaning: string): string {
    return meaning
      .toLowerCase()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^a-z0-9\s]/g, ' ')
      .replace(/\s+/g, ' ')
      .trim();
  }

  /**
   * Kiểm tra trợ từ, giới từ, liên từ
   */
  private checkParticle(raw: string, chinese: string): WordTypeAnalysis {
    const reasons: string[] = [];
    let score = 0;

    // Chữ Hán đặc trưng của trợ từ
    const particleChars = ['了', '吗', '吧', '呢', '啊', '呀', '把', '被', '得', '地', '的', '所', '与', '和', '或', '但', '而'];
    if (particleChars.some((char) => chinese.includes(char))) {
      score += 40;
      reasons.push('Chứa chữ Hán trợ từ');
    }

    // Từ khóa rõ ràng
    const particleKeywords = [
      'trợ từ',
      'giới từ',
      'liên từ',
      'phó từ',
      'ngữ khí',
      'tiểu từ',
      'lượng từ',
      'từ nối',
      'từ cảm thán',
    ];
    const lower = raw.toLowerCase();
    for (const keyword of particleKeywords) {
      if (lower.includes(keyword)) {
        score += 50;
        reasons.push(`Có từ khóa "${keyword}"`);
        break;
      }
    }

    return { type: 'particle', confidence: Math.min(score, 100), reasons };
  }

  /**
   * Kiểm tra động từ - CẦN KỸ LƯỠNG
   */
  private checkVerb(
    raw: string,
    normalized: string,
    words: string[],
    chinese: string,
  ): WordTypeAnalysis {
    const reasons: string[] = [];
    let score = 0;

    // 1. Từ khóa chỉ hành động rõ ràng (động từ thuần túy)
    const strongVerbKeywords = [
      'lam', 'di', 'den', 've', 'chay', 'nhay', 'bay', 'boi', 'leo',
      'ngoi', 'dung', 'nam', 'cam', 'nam', 'bo', 'de', 'dat', 'lay',
      'cho', 'nhan', 'mang', 'dua', 'gui', 'nem', 'keo', 'day',
      'mua', 'ban', 'trao doi', 'su dung', 'dung',
      'thuc hien', 'hoan thanh', 'giai quyet', 'xu ly',
      'chuan bi', 'sap xep', 'to chuc', 'tham gia', 'roi khoi',
      'mo', 'dong', 'bat dau', 'ket thuc', 'tiep tuc', 'dung lai',
      'an', 'uong', 'ngu', 'thuc day', 'tam', 'rua', 'danh rang',
      'nau', 'don dep', 'quet', 'lau', 'giat', 'phoi',
      'xem', 'nghe', 'doc', 'viet', 'noi', 'hoc', 'day',
      'biet', 'hieu', 'nghi', 'tuong', 'nho', 'quen',
      'yeu', 'thich', 'ghet', 'muon', 'can', 'phai',
      'gap', 'tim', 'mat', 'thay', 'nhin', 'quan sat',
      'xay dung', 'pha huy', 'tao ra', 'san xuat', 'che tao',
      'tang', 'giam', 'thay doi', 'bien doi', 'chuyen doi',
    ];

    for (const verb of strongVerbKeywords) {
      if (normalized.includes(verb)) {
        score += 8;
        reasons.push(`Chứa động từ "${verb}"`);
        if (score >= 30) break; // Đủ tin cậy
      }
    }

    // 2. Hậu tố động từ tiếng Trung
    const verbSuffixes = ['化', '动', '作', '行', '为', '做', '弄', '搞', '办', '理', '处', '置'];
    if (verbSuffixes.some((suffix) => chinese.endsWith(suffix))) {
      score += 15;
      reasons.push('Có hậu tố động từ tiếng Trung');
    }

    // 3. Mẫu câu động từ tiếng Việt
    const verbPatterns = [
      /^(lam|di|den|ve|chay|an|uong|ngu|hoc|day|viet|doc|noi)\s/i,
      /\b(thuc hien|tien hanh|hoan thanh|giai quyet|xu ly)\b/i,
      /\b(chuan bi|sap xep|to chuc|tham gia)\b/i,
      /\b(bat dau|ket thuc|tiep tuc|dung lai)\b/i,
    ];

    for (const pattern of verbPatterns) {
      if (pattern.test(raw)) {
        score += 12;
        reasons.push('Khớp mẫu động từ');
        break;
      }
    }

    // 4. Loại trừ nếu có dấu hiệu tính từ mạnh
    const adjectiveIndicators = ['dep', 'xau', 'cao', 'thap', 'lon', 'nho', 'tot', 'xau', 'moi', 'cu'];
    if (adjectiveIndicators.some((adj) => normalized.includes(adj)) && score < 20) {
      score = Math.max(0, score - 10);
      reasons.push('Có dấu hiệu tính từ, giảm điểm');
    }

    return { type: 'verb', confidence: Math.min(score, 100), reasons };
  }

  /**
   * Kiểm tra tính từ
   */
  private checkAdjective(
    raw: string,
    normalized: string,
    words: string[],
    chinese: string,
  ): WordTypeAnalysis {
    const reasons: string[] = [];
    let score = 0;

    // Từ khóa tính từ
    const adjectiveKeywords = [
      'dep', 'xau', 'cao', 'thap', 'lon', 'nho', 'dai', 'ngan',
      'manh', 'yeu', 'nhanh', 'cham', 'nang', 'nhe',
      'am', 'lanh', 'nong', 'mat', 'vui', 'buon', 'tot', 'dung', 'sai',
      'sach', 'ban', 'trang', 'den', 'do', 'xanh', 'vang',
      'giau', 'ngheo', 'an toan', 'thong minh', 'ngu ngoc',
      'de', 'kho', 'dac biet', 'khac biet', 'don gian', 'phuc tap',
      'ky la', 'cao cap', 'pho bien', 'chinh xac', 'tam thoi',
      'toi', 'sang', 'ro', 'mo', 'rong', 'hep', 'day', 'rong',
    ];

    for (const adj of adjectiveKeywords) {
      if (normalized.includes(adj)) {
        score += 6;
        reasons.push(`Chứa tính từ "${adj}"`);
        if (score >= 25) break;
      }
    }

    // Hậu tố tính từ
    const adjectiveSuffixes = ['的', '性', '度', '级', '等'];
    if (adjectiveSuffixes.some((suffix) => chinese.endsWith(suffix))) {
      score += 10;
      reasons.push('Có hậu tố tính từ');
    }

    // Mẫu tính từ
    if (/^(rat|kha|hoi|qua|cuc ky)\s/i.test(raw)) {
      score += 8;
      reasons.push('Có phó từ bổ nghĩa tính từ');
    }

    return { type: 'adjective', confidence: Math.min(score, 100), reasons };
  }

  /**
   * Kiểm tra danh từ
   */
  private checkNoun(
    raw: string,
    normalized: string,
    words: string[],
    chinese: string,
  ): WordTypeAnalysis {
    const reasons: string[] = [];
    let score = 0;

    // Từ khóa danh từ
    const nounKeywords = [
      'cai', 'con', 'chiec', 'bai', 'quyen', 'cuon', 'to', 'tam', 'buc',
      'nguoi', 'vat', 'do', 'su', 'viec', 'noi', 'cho', 'dia diem',
      'truong', 'nha', 'phong', 'duong', 'thanh pho', 'quoc gia',
      'tien', 'cua', 'ban', 'ghe', 'sach', 'vo', 'but', 'giay',
      'cha', 'me', 'anh', 'chi', 'em', 'ban', 'thay', 'co',
      'tay', 'chan', 'dau', 'mat', 'tai', 'mui', 'mieng',
    ];

    for (const noun of nounKeywords) {
      if (normalized.includes(noun)) {
        score += 5;
        reasons.push(`Chứa danh từ "${noun}"`);
        if (score >= 20) break;
      }
    }

    // Hậu tố danh từ
    const nounSuffixes = ['子', '儿', '头', '家', '者', '员', '师', '生', '人', '物', '品', '件'];
    if (nounSuffixes.some((suffix) => chinese.endsWith(suffix))) {
      score += 12;
      reasons.push('Có hậu tố danh từ');
    }

    return { type: 'noun', confidence: Math.min(score, 100), reasons };
  }

  /**
   * Kiểm tra phó từ
   */
  private checkAdverb(raw: string, normalized: string, words: string[]): WordTypeAnalysis {
    const reasons: string[] = [];
    let score = 0;

    const adverbKeywords = [
      'rat', 'kha', 'hoi', 'qua', 'cuc ky', 'dac biet',
      'luon', 'thuong', 'hay', 'it khi', 'khong bao gio',
      'da', 'dang', 'se', 'chua', 'roi',
    ];

    for (const adv of adverbKeywords) {
      if (normalized.includes(adv)) {
        score += 8;
        reasons.push(`Chứa phó từ "${adv}"`);
        break;
      }
    }

    return { type: 'adverb', confidence: Math.min(score, 100), reasons };
  }
}


