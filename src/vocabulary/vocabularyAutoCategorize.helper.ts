export class VocabularyAutoCategorizeHelper {
  /**
   * Phân tích loại từ (danh từ, động từ, tính từ) dựa trên nghĩa tiếng Việt và cấu trúc tiếng Trung
   */
  private analyzeWordType(
    chinese: string,
    pinyin: string,
    meaning: string,
  ): { type: 'noun' | 'verb' | 'adjective' | null; confidence: number } {
    const c = chinese.trim();
    const m = (meaning || '').toLowerCase().trim();
    const p = (pinyin || '').toLowerCase().replace(/\s+/g, '');

    // Loại bỏ dấu câu và phân tách từ
    const cleanedMeaning = m.replace(/[,\s\(\)\[\]]+/g, ' ').trim();
    const meaningWords = cleanedMeaning
      .split(/\s+/)
      .filter((w) => w.length > 0);

    // Chỉ số cho danh từ
    const nounIndicators = {
      // Từ chỉ sự vật, người, địa điểm
      words: [
        'cái',
        'con',
        'chiếc',
        'bài',
        'quyển',
        'cuốn',
        'tờ',
        'tấm',
        'bức',
        'người',
        'vật',
        'đồ',
        'sự',
        'việc',
        'nơi',
        'chỗ',
        'địa điểm',
        'trường',
        'nhà',
        'phòng',
        'đường',
        'thành phố',
        'quốc gia',
        'tiền',
        'cửa',
        'bàn',
        'ghế',
        'sách',
        'vở',
        'bút',
        'giấy',
        'bài học',
        'tình',
        'tình yêu',
        'tình bạn',
        'tình thương',
        'lòng',
        'lòng yêu',
        'lòng thương',
        'lòng nhân ái',
        'cốc',
        'chén',
        'ly',
        'tách',
        'văn phòng',
        'nhà khách',
        'khách sạn',
        'bánh',
        'bánh bao',
        'bánh mì',
        'tiến sĩ',
        'bác sĩ',
        'giáo viên',
        'học sinh',
        'nhân viên',
        'ông chủ',
        'công ty',
        'cơ quan',
        'đơn vị',
        'nhóm',
        'đội',
        'ban',
        'bộ',
        'phòng ban',
        'nhiệm vụ',
        'công tác',
        'trách nhiệm',
        'chức trách',
        'chức vụ',
        'thù lao',
        'tiền công',
        'tiền bảo chứng',
        'tay nắm cửa',
        'chuôi',
        'mũi',
        'lưng',
        'chăn',
        'miền bắc',
        'bản thân',
        'bím tóc',
        'án vụ',
        'trường hợp',
        'án kiện',
        'vật lộn',
        'tủ lạnh',
        'tủ đá',
        'bờ',
        'sông',
        'biển',
        'ung thư',
        'án lệ',
        'bệnh viện',
        'thuốc',
        'bác sĩ',
        'sức khỏe',
        'bệnh',
        'viện',
        'đau',
        'ốm',
        'khám',
        'chữa bệnh',
        'điều trị',
        'khỏe mạnh',
        'yếu',
        'mệt',
      ],
      // Hậu tố danh từ tiếng Trung
      chineseSuffixes: [
        '子',
        '儿',
        '头',
        '家',
        '者',
        '员',
        '师',
        '生',
        '人',
        '手',
        '长',
        '士',
        '物',
        '品',
        '件',
        '个',
        '种',
        '类',
        '型',
        '式',
        '样',
        '场',
        '店',
        '馆',
        '院',
        '室',
        '厅',
        '房',
        '屋',
        '楼',
        '层',
        '机',
        '器',
        '具',
        '械',
        '件',
        '备',
        '地',
        '方',
        '处',
        '所',
        '案',
        '件',
        '例',
        '症',
        '岸',
      ],
      // Mẫu nghĩa tiếng Việt
      patterns: [
        /^(cái|con|chiếc|bài|quyển|cuốn|tờ|tấm|bức)\s+/i,
        /\b(người|vật|đồ|sự|việc|nơi|chỗ|địa điểm|trường|nhà|phòng|đường|thành phố|quốc gia|tiền|cửa|bàn|ghế|sách|vở|bút|giấy)\b/i,
        /\b(tình|tình yêu|tình bạn|tình thương|lòng|lòng yêu|lòng thương|lòng nhân ái)\b/i,
        /\b(trường học|động cơ|cảnh ngộ|hoàn cảnh|bài học|đơn nguyên|hạnh kiểm|thân thích|người thân|sinh lý|sinh động)\b/i,
        /\b(giấy chứng nhận|chứng nhận|danh dự|thí sinh|trường đại học|thí|vào trường|nói chuyện|bàn luận|bằng lòng|mong muốn)\b/i,
        /\b(cốc|chén|ly|tách|văn phòng|nhà khách|khách sạn|bánh|bánh bao|bánh mì)\b/i,
        /\b(tiến sĩ|bác sĩ|giáo viên|học sinh|nhân viên|ông chủ|công ty|cơ quan|đơn vị|nhóm|đội|ban|bộ|phòng ban)\b/i,
        /\b(nhiệm vụ|công tác|trách nhiệm|chức trách|chức vụ|thù lao|tiền công|tiền bảo chứng)\b/i,
        /\b(án vụ|trường hợp|án kiện|vật lộn|tủ lạnh|tủ đá|bờ|sông|biển|ung thư|án lệ)\b/i,
      ],
    };

    // Chỉ số cho động từ
    const verbIndicators = {
      // Từ chỉ hành động
      words: [
        'làm',
        'đi',
        'đến',
        'mua',
        'bán',
        'ăn',
        'uống',
        'ngủ',
        'nghe',
        'nói',
        'viết',
        'đọc',
        'xem',
        'học',
        'dạy',
        'yêu',
        'thích',
        'muốn',
        'cần',
        'phải',
        'chạy',
        'đứng',
        'ngồi',
        'nằm',
        'mở',
        'đóng',
        'đưa',
        'nhận',
        'gửi',
        'thấy',
        'biết',
        'hiểu',
        'nghĩ',
        'tưởng',
        'bị',
        'chịu',
        'gặp',
        'thực hiện',
        'tiến hành',
        'thực thi',
        'thực hành',
        'xử lý',
        'làm việc',
        'yêu quý',
        'bảo vệ',
        'quý trọng',
        'yêu thương',
        'bị',
        'chịu đựng',
        'gặp phải',
        'học thuộc',
        'căn cứ theo',
        'căn cứ',
        'dựa theo',
        'bố trí',
        'ổn thỏa',
        'ổn định',
        'thanh toán',
        'thanh toán chi phí',
        'biến động',
        'thay đổi',
        'biến hóa',
        'biện giải',
        'giải thích',
        'thành lập',
        'xuất hiện',
        'sản sinh',
        'trở thành',
        'chạy nhanh',
        'chạy băng băng',
        'vật lộn',
        'ấn',
        'bấm',
        'xoa bóp',
        'sắp xếp',
        'bố trí',
        'ám thị',
        'ra hiệu',
        'an cư lạc nghiệp',
        'học trước',
        'học trước bài',
        'bài xích',
        'bài bác',
        'người ngoại nghệ',
        'sáng tác',
        'cảm lạnh',
        'nhiễm lạnh',
        'làm lạnh',
        'để nguội',
        'khó chịu',
        'khó khăn',
      ],
      // Hậu tố động từ tiếng Trung
      chineseSuffixes: [
        '化',
        '动',
        '作',
        '行',
        '为',
        '做',
        '弄',
        '搞',
        '办',
        '理',
        '处',
        '置',
        '了',
        '着',
        '过',
        '按',
        '排',
        '示',
      ],
      // Mẫu nghĩa tiếng Việt
      patterns: [
        /\b(làm|đi|đến|mua|bán|ăn|uống|ngủ|nghe|nói|viết|đọc|xem|học|dạy|yêu|thích|muốn|cần|phải|chạy|đứng|ngồi|nằm|mở|đóng|đưa|nhận|gửi|thấy|biết|hiểu|nghĩ|tưởng|bị|chịu|gặp)\b/i,
        /\b(thực hiện|tiến hành|thực thi|thực hành|xử lý|làm việc|yêu quý|bảo vệ|quý trọng|yêu thương)\b/i,
        /\b(bị|chịu đựng|gặp phải|học thuộc|căn cứ theo|căn cứ|dựa theo|bố trí|ổn thỏa|ổn định)\b/i,
        /\b(thanh toán|thanh toán chi phí|biến động|thay đổi|biến hóa|biện giải|giải thích|thành lập|xuất hiện|sản sinh|trở thành)\b/i,
        /\b(ấn|bấm|xoa bóp|sắp xếp|bố trí|ám thị|ra hiệu|an cư lạc nghiệp|học trước|học trước bài|bài xích|bài bác)\b/i,
        /\b(người ngoại nghệ|sáng tác|cảm lạnh|nhiễm lạnh|làm lạnh|để nguội|trừng phạt|huy động)\b/i,
      ],
    };

    // Chỉ số cho tính từ
    const adjectiveIndicators = {
      // Từ chỉ tính chất, đặc điểm
      words: [
        'đẹp',
        'xấu',
        'cao',
        'thấp',
        'to',
        'nhỏ',
        'mới',
        'cũ',
        'nhanh',
        'chậm',
        'nóng',
        'lạnh',
        'xa',
        'gần',
        'dễ',
        'khó',
        'vui',
        'buồn',
        'tốt',
        'xấu',
        'đúng',
        'sai',
        'sáng',
        'tối',
        'rõ',
        'mờ',
        'lớn',
        'bé',
        'dài',
        'ngắn',
        'rộng',
        'hẹp',
        'tối',
        'u ám',
        'thầm',
        'vụng trộm',
        'xẩm tối',
        'bi quan',
        'đau buồn',
        'bị động',
        'tất nhiên',
        'tất yếu',
        'mưa to',
        'khó chịu',
        'chướng',
        'kỳ quặc',
        'tệ nạn',
        'tai hại',
        'sai lầm',
        'chân thành',
        'thành tâm',
        'cố ý',
        'chính quy',
        'khoa chính quy',
        'an toàn',
        'đúng giờ',
        'mập mờ',
        'mờ ám',
      ],
      // Hậu tố tính từ tiếng Trung
      chineseSuffixes: [
        '的',
        '地',
        '得',
        '性',
        '度',
        '级',
        '等',
        '暗',
        '全',
        '时',
      ],
      // Mẫu nghĩa tiếng Việt
      patterns: [
        /\b(đẹp|xấu|cao|thấp|to|nhỏ|mới|cũ|nhanh|chậm|nóng|lạnh|xa|gần|dễ|khó|vui|buồn|tốt|xấu|đúng|sai|sáng|tối|rõ|mờ|lớn|bé|dài|ngắn|rộng|hẹp)\b/i,
        /\b(tối|u ám|thầm|vụng trộm|xẩm tối|bi quan|đau buồn|bị động|tất nhiên|tất yếu|mưa to|khó chịu|chướng|kỳ quặc|tệ nạn|tai hại|sai lầm|chân thành|thành tâm|cố ý|chính quy|khoa chính quy|an toàn|đúng giờ|mập mờ|mờ ám)\b/i,
      ],
    };

    // Tính điểm cho từng loại
    let nounScore = 0;
    let verbScore = 0;
    let adjectiveScore = 0;

    // Kiểm tra danh từ
    for (const word of nounIndicators.words) {
      if (m.includes(word)) {
        nounScore += word.length > 3 ? 2 : 1; // Từ dài có điểm cao hơn
      }
    }
    for (const suffix of nounIndicators.chineseSuffixes) {
      if (c.endsWith(suffix) || c.includes(suffix)) {
        nounScore += 3; // Hậu tố tiếng Trung có điểm cao
      }
    }
    for (const pattern of nounIndicators.patterns) {
      if (pattern.test(m)) {
        nounScore += 2;
      }
    }

    // Kiểm tra động từ
    for (const word of verbIndicators.words) {
      if (m.includes(word)) {
        verbScore += word.length > 3 ? 2 : 1;
      }
    }
    for (const suffix of verbIndicators.chineseSuffixes) {
      if (c.endsWith(suffix) || c.includes(suffix)) {
        verbScore += 3;
      }
    }
    for (const pattern of verbIndicators.patterns) {
      if (pattern.test(m)) {
        verbScore += 2;
      }
    }

    // Kiểm tra tính từ
    for (const word of adjectiveIndicators.words) {
      if (m.includes(word)) {
        adjectiveScore += word.length > 3 ? 2 : 1;
      }
    }
    for (const suffix of adjectiveIndicators.chineseSuffixes) {
      if (c.endsWith(suffix) || c.includes(suffix)) {
        adjectiveScore += 3;
      }
    }
    for (const pattern of adjectiveIndicators.patterns) {
      if (pattern.test(m)) {
        adjectiveScore += 2;
      }
    }

    // Xác định loại từ có điểm số cao nhất
    const scores = [
      { type: 'noun' as const, score: nounScore },
      { type: 'verb' as const, score: verbScore },
      { type: 'adjective' as const, score: adjectiveScore },
    ];

    scores.sort((a, b) => {
      // Sắp xếp theo điểm số giảm dần
      // Ưu tiên điểm số cao hơn, không ưu tiên theo loại từ
      return b.score - a.score;
    });

    const totalScore = nounScore + verbScore + adjectiveScore;
    const confidence =
      totalScore > 0 ? (scores[0].score / totalScore) * 100 : 0;

    // Chỉ trả về loại từ nếu điểm số > 0 và độ tin cậy > 30%
    if (scores[0].score > 0 && confidence > 30) {
      return { type: scores[0].type, confidence };
    }

    return { type: null, confidence: 0 };
  }

  private pick(
    keys: string[],
    nameVi: string,
    chinese: string,
    pinyin: string,
    meaning: string,
    categoriesMap: Map<string, number>,
  ): number | null {
    const lowerName = nameVi.toLowerCase();

    // Đối với "Từ cảm thán", cần kiểm tra chính xác hơn
    if (nameVi === 'Từ cảm thán') {
      return this.pickInterjection(chinese, pinyin, meaning, categoriesMap);
    }

    // Đối với các chủ đề khác, sử dụng logic thông thường nhưng ưu tiên từ khóa dài hơn
    const sortedKeys = keys.sort((a, b) => b.length - a.length);
    const matched = sortedKeys.some((key) => {
      const lowerKey = key.toLowerCase();
      // Kiểm tra từ khóa dài (>= 3 ký tự) - khớp chính xác hơn
      if (key.length >= 3) {
        // Tìm từ khóa như một từ độc lập (có word boundary)
        const regex = new RegExp(`\\b${this.escapeRegex(key)}\\b`, 'i');
        return (
          regex.test(meaning) ||
          meaning.includes(lowerKey) ||
          chinese.includes(key) ||
          (pinyin && pinyin.includes(key.replace(/\s+/g, '')))
        );
      } else {
        // Từ khóa ngắn - chỉ khớp nếu là từ độc lập hoặc trong danh sách cụ thể
        const regex = new RegExp(`\\b${this.escapeRegex(key)}\\b`, 'i');
        return (
          regex.test(meaning) ||
          meaning.split(/[,\s\(\)\[\]]+/).includes(key) ||
          chinese === key ||
          (pinyin && pinyin === key.replace(/\s+/g, ''))
        );
      }
    });

    if (!matched) {
      return null;
    }
    return categoriesMap.get(lowerName) ?? null;
  }

  // Hàm kiểm tra từ cảm thán chính xác hơn
  // CHỈ chấp nhận các từ cảm thán thực sự, loại bỏ các từ khác
  private pickInterjection(
    chinese: string,
    pinyin: string,
    meaning: string,
    categoriesMap: Map<string, number>,
  ): number | null {
    const c = chinese.trim();
    const m = meaning.toLowerCase().trim();
    const p = (pinyin || '').toLowerCase().replace(/\s+/g, '');

    // Danh sách các từ cảm thán tiếng Trung thực sự (chính xác)
    const chineseInterjections = [
      '啊',
      '呵',
      '哎',
      '唉',
      '哦',
      '噢',
      '嗯',
      '哼',
      '嘿',
      '哈',
      '嗬',
      '哎哟',
      '哎呀',
    ];

    // Danh sách các từ cảm thán tiếng Việt thực sự
    const vietnameseInterjections = [
      'a',
      'à',
      'ừ',
      'ờ',
      'ơ',
      'ới',
      'ui',
      'cha',
      'ôi',
      'than ôi',
      'trời ơi',
      'ôi chao',
      'ôi trời',
      'trời đất',
      'ồi',
      'ối',
      'ùi',
      'ui cha',
    ];

    // Danh sách các từ KHÔNG phải từ cảm thán (loại trừ)
    const nonInterjectionKeywords = [
      'tổ',
      'chức',
      'an',
      'toàn',
      'bảo',
      'hiểm',
      'bản',
      'bạn',
      'bàn',
      'bán',
      'báo',
      'bạo',
      'bạc',
      'bác',
      'bắn',
      'bấm',
      'bận',
      'bảng',
      'bắc',
      'bắt',
      'bầu',
      'bền',
      'bến',
      'bệnh',
      'bị',
      'bí',
      'ung',
      'thư',
      'ấn',
      'bấm',
      'án',
      'lệ',
      'xoa',
      'bóp',
      'vụ',
      'hồ',
      'sơ',
      'ủi',
      'huyền',
      'bí',
      'ẩn',
      'lồi',
      'lõm',
      'gồ',
      'ghề',
      'vết',
      'sẹo',
      'nắm',
      'chắc',
      'bắt',
      'trầm',
      'phiên',
      'giúp',
      'đỡ',
      'cóc',
      'tấm',
      'gương',
      'trợ',
      'ván',
      'thủ',
      'bưu',
      'kiện',
      'mập',
      'mờ',
      'ám',
      'mờ',
      'ám',
      'an',
      'toàn',
      '案',
      '按',
      '安',
      '暗',
      '岸',
      '奥',
      '秘',
      '凹',
      '凸',
      '阿',
      '姨',
      '疤',
      '把',
      '握',
      '柏',
      '版',
      '本',
      '帮',
      '忙',
      '绑',
      '架',
      '榜',
      '样',
      '帮',
      '助',
      '板',
      '保',
      '险',
      '保',
      '守',
      '包',
      '裹',
    ];

    // Kiểm tra 1: Nếu nghĩa chứa các từ KHÔNG phải cảm thán, loại bỏ ngay
    if (nonInterjectionKeywords.some((keyword) => m.includes(keyword))) {
      return null;
    }

    // Kiểm tra 2: Tiếng Trung - chỉ chấp nhận các từ cảm thán được liệt kê
    if (chineseInterjections.includes(c)) {
      // Nhưng vẫn cần kiểm tra nghĩa để đảm bảo
      if (
        vietnameseInterjections.some((interj) => m.includes(interj)) ||
        m.length <= 15
      ) {
        return categoriesMap.get('từ cảm thán') ?? null;
      }
    }

    // Kiểm tra 3: Nghĩa tiếng Việt - chỉ chấp nhận các từ cảm thán được liệt kê
    // Loại bỏ dấu câu và khoảng trắng để so sánh
    const cleanedMeaning = m.replace(/[,\s()\[\]]+/g, ' ').trim();
    const meaningWords = cleanedMeaning
      .split(/\s+/)
      .filter((w) => w.length > 0);

    // Chỉ chấp nhận nếu tất cả các từ đều là từ cảm thán
    if (meaningWords.length > 0 && meaningWords.length <= 5) {
      const allInterjections = meaningWords.every((word) =>
        vietnameseInterjections.some(
          (interj) =>
            word === interj ||
            word.startsWith(interj + ',') ||
            word.startsWith(interj + '，') ||
            word === interj.trim(),
        ),
      );

      // Chỉ chấp nhận nếu nghĩa ngắn và tất cả các từ đều là từ cảm thán
      if (allInterjections && m.length <= 20) {
        return categoriesMap.get('từ cảm thán') ?? null;
      }
    }

    // Kiểm tra 4: Các mẫu cụ thể
    const exactPatterns = [
      /^(a|à|ừ|ờ|ơ|ới|ui|cha|ôi|than ôi|trời ơi|ôi chao|ôi trời|trời đất)$/i,
      /^a[,，]\s*(à|ừ|ờ|ơ|ới|ui|cha)/i,
      /^(à|ừ|ờ|ơ|ới|ui|cha)[,，]\s*(a|à|ừ|ờ)/i,
    ];

    if (exactPatterns.some((pattern) => pattern.test(m)) && m.length <= 20) {
      return categoriesMap.get('từ cảm thán') ?? null;
    }

    // Không phải từ cảm thán
    return null;
  }

  // Hàm escape regex để tránh lỗi khi tìm kiếm
  private escapeRegex(str: string): string {
    return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }

  // Lấy tất cả các chủ đề và từ khóa phân loại
  getCategoryRules(): Array<{
    keys: string[];
    nameVi: string;
    nameEn?: string;
  }> {
    return [
      // Số đếm & Số lượng - Ưu tiên cao nhất
      {
        keys: [
          // Số đếm tiếng Trung
          '零',
          '一',
          '二',
          '三',
          '四',
          '五',
          '六',
          '七',
          '八',
          '九',
          '十',
          '百',
          '千',
          '万',
          '亿',
          // Số đếm tiếng Việt
          'số',
          'một',
          'hai',
          'ba',
          'bốn',
          'năm',
          'sáu',
          'bảy',
          'tám',
          'chín',
          'mười',
          'trăm',
          'nghìn',
          'triệu',
          'tỷ',
          'đếm',
          'đếm số',
          // Số lượng, phần trăm
          'phần',
          'phần trăm',
          'chi nhánh',
          'số lượng',
          'khối lượng',
          'trọng lượng',
          'thể tích',
          'dung lượng',
          'kích thước',
          'kích cỡ',
          'độ lớn',
          'tỷ lệ',
          'tỷ số',
          'phần nghìn',
          'phần triệu',
          'tỷ lệ phần trăm',
          // Từ khóa số lượng
          'đủ',
          'thiếu',
          'thừa',
          'nhiều',
          'ít',
          'vừa',
          'vừa đủ',
          'không đủ',
          'đầy đủ',
          'đủ rồi',
          'đủ chưa',
          'đủ không',
          // Từ khóa tổng số
          'tổng số',
          'tổng lượng',
          'tổng cộng',
          'tổng số lượng',
          'tổng khối lượng',
          'tổng trọng lượng',
          'tổng thể tích',
          'tổng dung lượng',
        ],
        nameVi: 'Số đếm & Số lượng',
        nameEn: 'Numbers & Quantity',
      },
      // Thời gian
      {
        keys: [
          'hôm nay',
          'ngày',
          'tháng',
          'năm',
          'giờ',
          'phút',
          'giây',
          'sáng',
          'trưa',
          'tối',
          'đêm',
          'thứ',
          'tuần',
          'lịch',
          'ngày mai',
          'hôm qua',
          'buổi',
          'sáng sớm',
          'chiều',
          'tối',
          'đêm khuya',
          'năm ngoái',
          'năm sau',
          'thời gian',
          'khoảng',
          'lúc',
          'khi',
          'lúc nào',
          'bao giờ',
          'thời điểm',
          'thời kỳ',
          'kỳ',
          'tiết',
          'mùa',
        ],
        nameVi: 'Thời gian',
        nameEn: 'Time',
      },
      // Động từ - Hành động
      {
        keys: [
          'làm',
          'đi',
          'đến',
          'mua',
          'bán',
          'ăn',
          'uống',
          'ngủ',
          'nghe',
          'nói',
          'viết',
          'đọc',
          'xem',
          'học',
          'dạy',
          'yêu',
          'thích',
          'muốn',
          'cần',
          'phải',
          'có thể',
          'chạy',
          'đứng',
          'ngồi',
          'nằm',
          'mở',
          'đóng',
          'đưa',
          'nhận',
          'gửi',
          'thấy',
          'biết',
          'hiểu',
          'nghĩ',
          'tưởng',
          'bị',
          'chịu đựng',
          'gặp phải',
          'quyến luyến',
          'kính yêu',
          'thích',
          'yêu thích',
          'làm việc',
          'thực hiện',
          'thực',
          'hành động',
          'hành',
          'tác động',
          'tác',
          'động',
          'phát',
          'xuất',
          'nhập',
          'truyền',
          'tiếp',
          'kết',
          'hợp',
          'chia',
          'tách',
          'bỏ',
          'thêm',
          'đổi',
          'thay',
          'cho',
          'nhận',
          'được',
          'mất',
          'tìm',
          'thấy',
          'nhìn',
          'xem',
          'nghe',
          'nói',
          'đọc',
          'viết',
          'học',
          'dạy',
          'làm',
          'tạo',
          'xây',
          'dựng',
          'sửa',
          'chữa',
          'bảo vệ',
          'giữ',
          'giải phóng',
          'giải',
          'phát triển',
          'phát',
          'tiến',
          'lùi',
          'đi',
          'đến',
          'về',
          'ra',
          'vào',
          'lên',
          'xuống',
          'mua',
          'bán',
          'trao đổi',
          'giao dịch',
          'thanh toán',
          'trả',
          'cho',
          'nhận',
          'đưa',
          'lấy',
          'bỏ',
          'đặt',
          'để',
          'cất',
          'giữ',
          'mở',
          'đóng',
          'bật',
          'tắt',
          'khởi động',
          'dừng',
          'ngừng',
          'tiếp tục',
          'bắt đầu',
          'kết thúc',
          'hoàn thành',
          'làm xong',
          'xong',
          'sẵn sàng',
          'chuẩn bị',
          'sẵn sàng',
          'sẵn',
          'sàng',
        ],
        nameVi: 'Động từ',
        nameEn: 'Verbs',
      },
      // Tính từ - Mô tả (LOẠI BỎ đủ, thiếu, thừa, nhiều, ít, vừa - đã chuyển sang Số đếm & Số lượng)
      {
        keys: [
          'đẹp',
          'xấu',
          'cao',
          'thấp',
          'to',
          'nhỏ',
          'mới',
          'cũ',
          'nhanh',
          'chậm',
          'nóng',
          'lạnh',
          'xa',
          'gần',
          'dễ',
          'khó',
          'vui',
          'buồn',
          'tốt',
          'xấu',
          'đúng',
          'sai',
          'sáng',
          'tối',
          'rõ',
          'mờ',
          'yên tĩnh',
          'ồn ào',
          'lớn',
          'bé',
          'dài',
          'ngắn',
          'rộng',
          'hẹp',
          'tính',
          'đặc',
          'thường',
          'bình thường',
          'bình',
          'thường',
          'đặc biệt',
          'đặc',
          'biệt',
          'chính',
          'phụ',
          'chính xác',
          'chính',
          'xác',
          'rõ ràng',
          'rõ',
          'ràng',
          'mờ mịt',
          'mờ',
          'mịt',
          'tinh tế',
          'tinh',
          'tế',
          'thô',
          'mịn',
          'nhẵn',
          'nhám',
          'mềm',
          'cứng',
          'mềm mại',
          'mềm',
          'mại',
          'cứng rắn',
          'cứng',
          'rắn',
          'yếu',
          'mạnh',
          'khỏe',
          'mệt',
          'khỏe mạnh',
          'khỏe',
          'mạnh',
          'yếu đuối',
          'yếu',
          'đuối',
          'tươi',
          'cũ',
          'mới',
          'cũ kỹ',
          'cũ',
          'kỹ',
          'mới mẻ',
          'mới',
          'mẻ',
          'sạch',
          'bẩn',
          'sạch sẽ',
          'sạch',
          'sẽ',
          'bẩn thỉu',
          'bẩn',
          'thỉu',
          'đẹp đẽ',
          'xấu xí',
          'tốt đẹp',
          'xấu xa',
          'vui vẻ',
          'buồn bã',
          'hạnh phúc',
          'đau khổ',
          'yêu thương',
          'ghét bỏ',
          'thích thú',
          'nhàm chán',
        ],
        nameVi: 'Tính từ',
        nameEn: 'Adjectives',
      },
      // Danh từ - Sự vật, người, địa điểm (LOẠI BỎ bài tập)
      {
        keys: [
          'người',
          'vật',
          'đồ',
          'địa điểm',
          'trường',
          'nhà',
          'phòng',
          'đường',
          'thành phố',
          'quốc gia',
          'tiền',
          'cửa',
          'bàn',
          'ghế',
          'sách',
          'vở',
          'bút',
          'giấy',
          'quần áo',
          'giày dép',
          'công cụ',
          'thiết bị',
          'danh',
          'sự',
          'việc',
          'vấn đề',
          'vấn',
          'đề',
          'câu hỏi',
          'câu',
          'hỏi',
          'câu trả lời',
          'câu',
          'trả',
          'lời',
          'bài học',
          'bài',
          'học',
        ],
        nameVi: 'Danh từ',
        nameEn: 'Nouns',
      },
      // Thời tiết
      {
        keys: [
          'mưa',
          'nắng',
          'gió',
          'nhiệt độ',
          'trời',
          'tuyết',
          'bão',
          'âm u',
          'quang',
          'mây',
          'sương mù',
          'sấm',
          'chớp',
          'lạnh giá',
          'nóng bức',
          'thời tiết',
          'khí hậu',
          'khí',
          'hậu',
          'thời tiết',
          'thời',
          'tiết',
        ],
        nameVi: 'Thời tiết',
        nameEn: 'Weather',
      },
      // Đồ ăn & thức uống
      {
        keys: [
          'ăn',
          'uống',
          'món',
          'cơm',
          'bánh',
          'thịt',
          'cá',
          'rau',
          'trái cây',
          'nước',
          'trà',
          'cà phê',
          'bữa',
          'đồ ăn',
          'thức uống',
          'canh',
          'súp',
          'cháo',
          'phở',
          'bún',
          'bánh mì',
          'rượu',
          'bia',
          'thực phẩm',
          'đồ uống',
          'bữa ăn',
          'bữa',
          'ăn',
          'bữa sáng',
          'bữa',
          'sáng',
          'bữa trưa',
          'bữa',
          'trưa',
          'bữa tối',
          'bữa',
          'tối',
          'đồ ăn',
          'đồ',
          'ăn',
          'thức uống',
          'thức',
          'uống',
          'thực phẩm',
          'thực',
          'phẩm',
        ],
        nameVi: 'Đồ ăn & thức uống',
        nameEn: 'Food & Drink',
      },
      // Động vật
      {
        keys: [
          'chó',
          'mèo',
          'gà',
          'vịt',
          'bò',
          'heo',
          'cá',
          'chim',
          'ngựa',
          'khỉ',
          'hổ',
          'sư tử',
          'động vật',
          'con vật',
          'thú cưng',
          'thú nuôi',
          'con',
          'vật',
          'động',
          'vật',
        ],
        nameVi: 'Động vật',
        nameEn: 'Animals',
      },
      // Cây cối
      {
        keys: [
          'cây',
          'hoa',
          'lá',
          'rễ',
          'thân',
          'cỏ',
          'cây cối',
          'thực vật',
          'quả',
          'trái cây',
          'rau củ',
          'thực',
          'vật',
        ],
        nameVi: 'Cây cối',
        nameEn: 'Plants',
      },
      // Phương tiện
      {
        keys: [
          'xe',
          'tàu',
          'máy bay',
          'bus',
          'ô tô',
          'xe máy',
          'đi bộ',
          'phương tiện',
          'giao thông',
          'xe đạp',
          'taxi',
          'tàu hỏa',
          'tàu điện',
          'phương',
          'tiện',
          'giao',
          'thông',
        ],
        nameVi: 'Phương tiện',
        nameEn: 'Transportation',
      },
      // Mua sắm
      {
        keys: [
          'mua',
          'bán',
          'giá',
          'tiền',
          'rẻ',
          'đắt',
          'cửa hàng',
          'siêu thị',
          'mua sắm',
          'thanh toán',
          'hóa đơn',
          'giảm giá',
          'khuyến mãi',
          'mua',
          'sắm',
          'bán',
          'hàng',
          'cửa',
          'hàng',
          'siêu',
          'thị',
          'thanh',
          'toán',
          'hóa',
          'đơn',
          'giảm',
          'giá',
          'khuyến',
          'mãi',
        ],
        nameVi: 'Mua sắm',
        nameEn: 'Shopping',
      },
      // Sở thích
      {
        keys: [
          'thích',
          'sở thích',
          'chơi',
          'xem phim',
          'nghe nhạc',
          'đọc sách',
          'thể thao',
          'giải trí',
          'chơi game',
          'ca hát',
          'nhảy múa',
          'sở',
          'thích',
          'giải',
          'trí',
        ],
        nameVi: 'Sở thích',
        nameEn: 'Hobbies',
      },
      // Sức khỏe
      {
        keys: [
          'sức khỏe',
          'đau',
          'ốm',
          'bệnh',
          'khám',
          'thuốc',
          'bác sĩ',
          'bệnh viện',
          'chữa bệnh',
          'điều trị',
          'khỏe mạnh',
          'yếu',
          'mệt',
          'sức',
          'khỏe',
          'bệnh',
          'viện',
          'bác',
          'sĩ',
          'thuốc',
          'điều',
          'trị',
          'chữa',
          'bệnh',
        ],
        nameVi: 'Sức khỏe',
        nameEn: 'Health',
      },
      // Gia đình
      {
        keys: [
          'gia đình',
          'bố',
          'mẹ',
          'cha',
          'ông',
          'bà',
          'anh',
          'chị',
          'em',
          'con',
          'cháu',
          'bạn',
          'bạn bè',
          'họ hàng',
          'gia',
          'đình',
          'bạn',
          'bè',
          'họ',
          'hàng',
        ],
        nameVi: 'Gia đình',
        nameEn: 'Family',
      },
      // Màu sắc
      {
        keys: [
          'màu sắc',
          'đỏ',
          'xanh',
          'vàng',
          'trắng',
          'đen',
          'cam',
          'hồng',
          'nâu',
          'xám',
          'màu',
          'sắc',
        ],
        nameVi: 'Màu sắc',
        nameEn: 'Colors',
      },
      // Công việc & Tổ chức - Ưu tiên trước Giáo dục và Danh từ
      {
        keys: [
          // Công việc
          'công việc',
          'làm việc',
          'nhân viên',
          'ông chủ',
          'công ty',
          'văn phòng',
          'nghề nghiệp',
          'lương',
          // Tổ chức
          'tổ chức',
          'cơ quan',
          'đơn vị',
          'nhóm',
          'đội',
          'ban',
          'bộ',
          'phòng ban',
          // Nhiệm vụ, trách nhiệm
          'nhiệm vụ',
          'công tác',
          'phụ trách',
          'chịu trách nhiệm',
          'trách nhiệm',
          'chức trách',
          'chức vụ',
          // Bài tập, bài làm (ƯU TIÊN - phải có)
          'bài tập',
          'bài làm',
          'bài viết',
          'bài nói',
          'bài đọc',
          'bài nghe',
          'bài xem',
          'bài kiểm tra',
          'bài thi',
        ],
        nameVi: 'Công việc',
        nameEn: 'Work',
      },
      // Thể thao
      {
        keys: [
          'thể thao',
          'bóng đá',
          'bóng rổ',
          'bơi',
          'chạy',
          'tập thể dục',
          'vận động viên',
          'thi đấu',
          'giải đấu',
          'thể',
          'thao',
          'bóng',
          'đá',
          'bóng',
          'rổ',
          'bơi',
          'chạy',
          'tập',
          'thể',
          'dục',
          'vận',
          'động',
          'viên',
          'thi',
          'đấu',
          'giải',
          'đấu',
        ],
        nameVi: 'Thể thao',
        nameEn: 'Sports',
      },
      // Hành động
      {
        keys: [
          // Hành động chung
          'hành động',
          'hoạt động',
          'thực hiện',
          'thực thi',
          'thực hành',
          'tiến hành',
          // Di chuyển
          'đi',
          'đến',
          'về',
          'ra',
          'vào',
          'lên',
          'xuống',
          'đi lại',
          'di chuyển',
          // Đi lại, giao thông
          'đi bộ',
          'đi xe',
          'đi tàu',
          'đi máy bay',
          // Tham gia, tham dự
          'tham gia',
          'tham dự',
          'tham quan',
          'tham mưu',
          'tham chiếu',
          // Biểu diễn, biểu đạt
          'biểu diễn',
          'biểu đạt',
          'diễn tả',
          'thể hiện',
          // Thực hiện các hoạt động
          'xử lý',
          'thực thi',
          'tiến hành',
        ],
        nameVi: 'Hành động',
        nameEn: 'Actions',
      },
      // Cảm xúc
      {
        keys: [
          'cảm xúc',
          'vui',
          'buồn',
          'tức giận',
          'sợ hãi',
          'ngạc nhiên',
          'yêu',
          'ghét',
          'thích',
          'không thích',
          'hạnh phúc',
          'tuyệt vời',
          'cảm',
          'xúc',
          'tức',
          'giận',
          'sợ',
          'hãi',
          'ngạc',
          'nhiên',
          'hạnh',
          'phúc',
          'tuyệt',
          'vời',
        ],
        nameVi: 'Cảm xúc',
        nameEn: 'Emotions',
      },
      // Từ cảm thán - CHỈ các từ cảm thán thực sự
      // Lưu ý: Logic kiểm tra đặc biệt trong hàm pickInterjection
      {
        keys: [
          'than ôi',
          'trời ơi',
          'ôi chao',
          'ôi trời',
          'trời đất',
          'a, à, ừ, ờ',
          'a, à',
          'ừ, ờ',
          'ơ, ới',
          'ui, cha',
        ],
        nameVi: 'Từ cảm thán',
        nameEn: 'Interjections',
      },
      // Quần áo
      {
        keys: [
          'quần áo',
          'áo',
          'quần',
          'giày',
          'dép',
          'mũ',
          'túi',
          'thời trang',
          'quần',
          'áo',
          'giày',
          'dép',
          'mũ',
          'túi',
          'thời',
          'trang',
        ],
        nameVi: 'Quần áo',
        nameEn: 'Clothing',
      },
      // Cơ thể
      {
        keys: [
          'cơ thể',
          'đầu',
          'tay',
          'chân',
          'mắt',
          'mũi',
          'miệng',
          'tai',
          'tóc',
          'cơ',
          'thể',
        ],
        nameVi: 'Cơ thể',
        nameEn: 'Body',
      },
      // Phương hướng
      {
        keys: [
          'phương hướng',
          'trên',
          'dưới',
          'trái',
          'phải',
          'trước',
          'sau',
          'trong',
          'ngoài',
          'bắc',
          'nam',
          'đông',
          'tây',
          'phương',
          'hướng',
        ],
        nameVi: 'Phương hướng',
        nameEn: 'Directions',
      },
      // Từ ngữ pháp - Trợ từ, liên từ, giới từ
      {
        keys: [
          'không',
          'có',
          'là',
          'của',
          'và',
          'hoặc',
          'nhưng',
          'mà',
          'vì',
          'nên',
          'nếu',
          'thì',
          'để',
          'cho',
          'với',
          'về',
          'trong',
          'ngoài',
          'trên',
          'dưới',
          'trước',
          'sau',
          'bên',
          'cạnh',
          'giữa',
          'giữ',
          'của',
          'đến',
          'từ',
          'về',
          'ra',
          'vào',
          'lên',
          'xuống',
          'đi',
          'đến',
          'về',
          'ra',
          'vào',
          'lên',
          'xuống',
          'này',
          'đó',
          'kia',
          'đây',
          'đấy',
          'ấy',
          'nọ',
          'nào',
          'gì',
          'ai',
          'đâu',
          'đâu',
          'sao',
          'thế',
          'nào',
          'thế',
          'nào',
          'làm',
          'sao',
          'tại',
          'sao',
          'vì',
          'sao',
          'thế',
          'nào',
          'làm',
          'gì',
          'để',
          'làm',
          'gì',
          'có',
          'thể',
          'làm',
          'gì',
          'phải',
          'làm',
          'gì',
          'nên',
          'làm',
          'gì',
          'cần',
          'làm',
          'gì',
          'muốn',
          'làm',
          'gì',
          'thích',
          'làm',
          'gì',
          'yêu',
          'làm',
          'gì',
          'ghét',
          'làm',
          'gì',
          'không',
          'thích',
          'làm',
          'gì',
          'không',
          'yêu',
          'làm',
          'gì',
          'không',
          'ghét',
          'làm',
          'gì',
        ],
        nameVi: 'Từ ngữ pháp',
        nameEn: 'Grammar Words',
      },
      // Văn hóa
      {
        keys: [
          'văn hóa',
          'truyền thống',
          'lễ hội',
          'tết',
          'ngày lễ',
          'văn',
          'hóa',
          'truyền',
          'thống',
          'lễ',
          'hội',
          'tết',
          'ngày',
          'lễ',
        ],
        nameVi: 'Văn hóa',
        nameEn: 'Culture',
      },
      // Khoa học
      {
        keys: [
          'khoa học',
          'nghiên cứu',
          'thí nghiệm',
          'phát minh',
          'khám phá',
          'khoa',
          'học',
          'nghiên',
          'cứu',
          'thí',
          'nghiệm',
          'phát',
          'minh',
          'khám',
          'phá',
        ],
        nameVi: 'Khoa học',
        nameEn: 'Science',
      },
      // Kinh tế
      {
        keys: [
          'kinh tế',
          'thị trường',
          'tiền tệ',
          'ngân hàng',
          'đầu tư',
          'kinh',
          'tế',
          'thị',
          'trường',
          'tiền',
          'tệ',
          'ngân',
          'hàng',
          'đầu',
          'tư',
        ],
        nameVi: 'Kinh tế',
        nameEn: 'Economics',
      },
      // Chính trị
      {
        keys: [
          'chính trị',
          'chính phủ',
          'quốc gia',
          'nhà nước',
          'chính',
          'trị',
          'chính',
          'phủ',
          'quốc',
          'gia',
          'nhà',
          'nước',
        ],
        nameVi: 'Chính trị',
        nameEn: 'Politics',
      },
      // Công nghệ
      {
        keys: [
          'công nghệ',
          'máy tính',
          'điện thoại',
          'internet',
          'công',
          'nghệ',
          'máy',
          'tính',
          'điện',
          'thoại',
          'internet',
        ],
        nameVi: 'Công nghệ',
        nameEn: 'Technology',
      },
      // Địa điểm
      {
        keys: [
          'địa điểm',
          'thành phố',
          'quốc gia',
          'tỉnh',
          'huyện',
          'xã',
          'phường',
          'đường',
          'phố',
          'ngõ',
          'hẻm',
          'địa',
          'điểm',
          'thành',
          'phố',
          'quốc',
          'gia',
          'tỉnh',
          'huyện',
          'xã',
          'phường',
          'đường',
          'phố',
          'ngõ',
          'hẻm',
        ],
        nameVi: 'Địa điểm',
        nameEn: 'Places',
      },
      // Từ trừu tượng
      {
        keys: [
          'ý nghĩa',
          'ý',
          'nghĩa',
          'khái niệm',
          'khái',
          'niệm',
          'định nghĩa',
          'định',
          'nghĩa',
          'giải thích',
          'giải',
          'thích',
          'mô tả',
          'mô',
          'tả',
          'tường thuật',
          'tường',
          'thuật',
          'kể',
          'chuyện',
          'kể',
          'chuyện',
          'nói',
          'chuyện',
          'nói',
          'chuyện',
          'kể',
          'lại',
          'kể',
          'lại',
          'nói',
          'lại',
          'nói',
          'lại',
          'nhắc',
          'lại',
          'nhắc',
          'lại',
          'nhớ',
          'lại',
          'nhớ',
          'lại',
          'quên',
          'lại',
          'quên',
          'lại',
        ],
        nameVi: 'Từ trừu tượng',
        nameEn: 'Abstract Words',
      },
    ];
  }

  decideCategoryId(
    chinese: string,
    pinyin: string | undefined,
    meaning: string,
    categoriesMap: Map<string, number>,
    defaultCategoryId: number | null,
  ): number | null {
    const c = (chinese || '').toLowerCase();
    const p = (pinyin || '').toLowerCase().replace(/\s+/g, '');
    const m = (meaning || '').toLowerCase();

    const pick = (keys: string[], nameVi: string) =>
      this.pick(keys, nameVi, chinese, pinyin || '', meaning, categoriesMap);

    // Sử dụng danh sách chủ đề mở rộng
    // Thứ tự ưu tiên: các chủ đề cụ thể trước, các chủ đề chung sau
    const rules = this.getCategoryRules();

    // Ưu tiên các chủ đề cụ thể trước
    // Thứ tự ưu tiên: Số đếm & Số lượng > Công việc > Phân loại theo loại từ (nếu độ tin cậy cao) > Các chủ đề cụ thể khác > Các chủ đề chung
    const priorityCategories = ['Số đếm & Số lượng', 'Công việc'];

    // 1. Kiểm tra các chủ đề ưu tiên trước
    for (const priorityName of priorityCategories) {
      const priorityRule = rules.find((rule) => rule.nameVi === priorityName);
      if (priorityRule) {
        const id = pick(priorityRule.keys, priorityRule.nameVi);
        if (id) {
          return id;
        }
      }
    }

    // 2. Phân tích loại từ và ưu tiên phân loại theo loại từ TRƯỚC các chủ đề cụ thể khác
    const wordTypeAnalysis = this.analyzeWordType(
      chinese,
      pinyin || '',
      meaning,
    );
    if (wordTypeAnalysis.type && wordTypeAnalysis.confidence > 45) {
      // Nếu phân tích loại từ có độ tin cậy cao (> 45%), ưu tiên phân loại theo loại từ
      const typeCategoryMap: Record<string, string> = {
        noun: 'Danh từ',
        verb: 'Động từ',
        adjective: 'Tính từ',
      };
      const categoryName = typeCategoryMap[wordTypeAnalysis.type];
      if (categoryName) {
        const id = categoriesMap.get(categoryName.toLowerCase());
        if (id) {
          return id;
        }
      }
    }

    // 3. Kiểm tra các chủ đề cụ thể khác (không phải Danh từ, Động từ, Tính từ chung)
    // Loại bỏ các chủ đề có thể trùng với phân loại loại từ nếu đã xác định được loại từ
    const excludedCategories = [
      'Danh từ',
      'Động từ',
      'Tính từ',
      'Từ ngữ pháp',
      'Từ trừu tượng',
      'Số đếm & Số lượng',
      'Công việc',
    ];
    // Nếu đã xác định được loại từ với độ tin cậy cao, không kiểm tra các chủ đề cụ thể có thể trùng
    if (wordTypeAnalysis.type && wordTypeAnalysis.confidence > 45) {
      // Chỉ kiểm tra các chủ đề cụ thể không liên quan đến loại từ
      excludedCategories.push('Cảm xúc', 'Sở thích');
    }

    const specificRules = rules.filter(
      (rule) => !excludedCategories.includes(rule.nameVi),
    );

    // Kiểm tra các chủ đề cụ thể trước
    for (const rule of specificRules) {
      const id = pick(rule.keys, rule.nameVi);
      if (id) {
        return id;
      }
    }

    // 4. Nếu không tìm thấy chủ đề cụ thể, kiểm tra các chủ đề chung
    const generalRules = rules.filter((rule) =>
      [
        'Danh từ',
        'Động từ',
        'Tính từ',
        'Từ ngữ pháp',
        'Từ trừu tượng',
      ].includes(rule.nameVi),
    );

    for (const rule of generalRules) {
      const id = pick(rule.keys, rule.nameVi);
      if (id) {
        return id;
      }
    }

    // Nếu vẫn không tìm thấy, trả về null để tạo chủ đề mới dựa trên phân tích
    return null;
  }

  // Lấy tên chủ đề dựa trên nghĩa từ vựng (dùng để tạo chủ đề mới)
  // Phân tích từ vựng để đề xuất chủ đề phù hợp nhất
  // Luôn trả về một chủ đề cụ thể, không bao giờ null
  suggestCategoryName(
    chinese: string,
    pinyin: string | undefined,
    meaning: string,
  ): { nameVi: string; nameEn?: string } {
    const c = (chinese || '').toLowerCase();
    const p = (pinyin || '').toLowerCase().replace(/\s+/g, '');
    const m = (meaning || '').toLowerCase();

    const pick = (keys: string[], nameVi: string, nameEn?: string) => {
      // Tìm từ khóa khớp chính xác nhất (ưu tiên từ khóa dài hơn)
      const sortedKeys = keys.sort((a, b) => b.length - a.length);
      for (const key of sortedKeys) {
        const lowerKey = key.toLowerCase();
        if (
          m.includes(lowerKey) ||
          c.includes(lowerKey) ||
          (p && p.includes(lowerKey.replace(/\s+/g, '')))
        ) {
          return { nameVi, nameEn };
        }
      }
      return null;
    };

    // Ưu tiên các chủ đề cụ thể trước
    // Thứ tự ưu tiên: Số đếm & Số lượng > Công việc > Phân loại theo loại từ (nếu độ tin cậy cao) > Các chủ đề cụ thể khác > Các chủ đề chung
    const rules = this.getCategoryRules();
    const priorityCategories = ['Số đếm & Số lượng', 'Công việc'];

    // 1. Kiểm tra các chủ đề ưu tiên trước
    for (const priorityName of priorityCategories) {
      const priorityRule = rules.find((rule) => rule.nameVi === priorityName);
      if (priorityRule) {
        const result = pick(
          priorityRule.keys,
          priorityRule.nameVi,
          priorityRule.nameEn,
        );
        if (result) {
          return result;
        }
      }
    }

    // 2. Phân tích loại từ và ưu tiên phân loại theo loại từ TRƯỚC các chủ đề cụ thể khác
    const wordTypeAnalysis = this.analyzeWordType(
      chinese,
      pinyin || '',
      meaning,
    );
    if (wordTypeAnalysis.type && wordTypeAnalysis.confidence > 45) {
      // Nếu phân tích loại từ có độ tin cậy cao (> 45%), ưu tiên phân loại theo loại từ
      const typeCategoryMap: Record<
        string,
        { nameVi: string; nameEn: string }
      > = {
        noun: { nameVi: 'Danh từ', nameEn: 'Nouns' },
        verb: { nameVi: 'Động từ', nameEn: 'Verbs' },
        adjective: { nameVi: 'Tính từ', nameEn: 'Adjectives' },
      };
      const category = typeCategoryMap[wordTypeAnalysis.type];
      if (category) {
        return category;
      }
    }

    // 3. Kiểm tra các chủ đề cụ thể khác
    // Loại bỏ các chủ đề có thể trùng với phân loại loại từ
    const excludedCategories = [
      'Danh từ',
      'Động từ',
      'Tính từ',
      'Từ ngữ pháp',
      'Từ trừu tượng',
      'Số đếm & Số lượng',
      'Công việc',
    ];
    // Nếu đã xác định được loại từ với độ tin cậy cao, không kiểm tra các chủ đề cụ thể có thể trùng
    if (wordTypeAnalysis.type && wordTypeAnalysis.confidence > 45) {
      // Chỉ kiểm tra các chủ đề cụ thể không liên quan đến loại từ
      excludedCategories.push('Cảm xúc', 'Sở thích');
    }

    const specificRules = rules.filter(
      (rule) => !excludedCategories.includes(rule.nameVi),
    );

    for (const rule of specificRules) {
      const result = pick(rule.keys, rule.nameVi, rule.nameEn);
      if (result) {
        return result;
      }
    }

    // 4. Nếu không tìm thấy chủ đề cụ thể, kiểm tra các chủ đề chung
    const generalRules = rules.filter((rule) =>
      [
        'Danh từ',
        'Động từ',
        'Tính từ',
        'Từ ngữ pháp',
        'Từ trừu tượng',
      ].includes(rule.nameVi),
    );

    for (const rule of generalRules) {
      const result = pick(rule.keys, rule.nameVi, rule.nameEn);
      if (result) {
        return result;
      }
    }

    // Phân tích từ vựng để đề xuất chủ đề mới
    // Kiểm tra các từ khóa phổ biến trong nghĩa
    const commonWords = m.split(/[,\s\(\)\[\]]+/).filter((w) => w.length > 2);

    // Nếu là từ cảm thán thực sự (kiểm tra chính xác hơn)
    // Loại bỏ các từ không phải cảm thán
    const nonInterjectionKeywords = [
      'tổ',
      'chức',
      'an',
      'toàn',
      'bảo',
      'hiểm',
      'ung',
      'thư',
      'ấn',
      'bấm',
      'án',
      'lệ',
      'xoa',
      'bóp',
      'vụ',
      'hồ',
      'sơ',
      'mập',
      'mờ',
      'ám',
    ];
    if (nonInterjectionKeywords.some((keyword) => m.includes(keyword))) {
      // Không phải từ cảm thán, bỏ qua
    } else {
      // Chỉ chấp nhận các từ cảm thán thực sự
      const chineseInterjections = [
        '啊',
        '呵',
        '哎',
        '唉',
        '哦',
        '噢',
        '嗯',
        '哼',
        '嘿',
        '哈',
        '嗬',
        '哎哟',
        '哎呀',
      ];
      const vietnameseInterjections = [
        'a',
        'à',
        'ừ',
        'ờ',
        'ơ',
        'ới',
        'ui',
        'cha',
        'ôi',
        'than ôi',
        'trời ơi',
        'ôi chao',
        'ôi trời',
        'trời đất',
      ];

      if (
        chineseInterjections.includes(c) ||
        vietnameseInterjections.some(
          (interj) =>
            m === interj ||
            m.startsWith(interj + ',') ||
            m.startsWith(interj + '，'),
        ) ||
        (m.match(
          /^(a|à|ừ|ờ|ơ|ới|ui|cha|ôi|than ôi|trời ơi|ôi chao|ôi trời|trời đất)$/i,
        ) &&
          m.length <= 15) ||
        (m.match(/^a[,，]\s*(à|ừ|ờ|ơ|ới|ui|cha)/i) && m.length <= 20)
      ) {
        return { nameVi: 'Từ cảm thán', nameEn: 'Interjections' };
      }
    }

    // Kiểm tra số lượng TRƯỚC (đủ, thiếu, thừa, nhiều, ít, vừa, số lượng, v.v.) - ƯU TIÊN CAO NHẤT
    if (
      m.match(
        /\b(đủ|thiếu|thừa|nhiều|ít|vừa|vừa đủ|không đủ|đầy đủ|số lượng|khối lượng|trọng lượng|thể tích|dung lượng|kích thước|kích cỡ|độ lớn|tỷ lệ|tỷ số|phần trăm|phần nghìn|phần triệu|tổng số|tổng lượng|tổng cộng|số đếm)\b/,
      )
    ) {
      return { nameVi: 'Số đếm & Số lượng', nameEn: 'Numbers & Quantity' };
    }

    // Kiểm tra công việc TRƯỚC (bài tập, công việc, làm việc, v.v.) - ƯU TIÊN CAO
    if (
      m.match(
        /\b(bài tập|bài|tập|công việc|công|việc|làm việc|làm|việc|nhân viên|nhân|viên|công ty|công|ty|văn phòng|văn|phòng|nghề nghiệp|nghề|nghiệp|lương|tổ chức|tổ|chức|cơ quan|cơ|quan|đơn vị|đơn|vị|nhóm|đội|ban|bộ|phòng ban|phòng|ban|nhiệm vụ|nhiệm|vụ|công tác|công|tác|phụ trách|phụ|trách|trách nhiệm|trách|nhiệm|chức trách|chức|trách|chức vụ|chức|vụ)\b/,
      )
    ) {
      return { nameVi: 'Công việc', nameEn: 'Work' };
    }

    // Sử dụng phân tích loại từ nếu có
    if (wordTypeAnalysis.type) {
      const typeCategoryMap: Record<
        string,
        { nameVi: string; nameEn: string }
      > = {
        noun: { nameVi: 'Danh từ', nameEn: 'Nouns' },
        verb: { nameVi: 'Động từ', nameEn: 'Verbs' },
        adjective: { nameVi: 'Tính từ', nameEn: 'Adjectives' },
      };
      const category = typeCategoryMap[wordTypeAnalysis.type];
      if (category) {
        return category;
      }
    }

    // Nếu là động từ (có các từ chỉ hành động)
    if (
      m.match(
        /\b(làm|đi|đến|mua|bán|ăn|uống|ngủ|nghe|nói|viết|đọc|học|dạy|yêu|thích|muốn|cần|phải|chạy|đứng|ngồi|nằm|mở|đóng|đưa|nhận|gửi|thấy|biết|hiểu|nghĩ|tưởng|bị|chịu|gặp)\b/,
      )
    ) {
      return { nameVi: 'Động từ', nameEn: 'Verbs' };
    }

    // Nếu là tính từ (có các từ mô tả) - LOẠI BỎ "đủ", "nhiều", "ít", "vừa"
    if (
      m.match(
        /\b(đẹp|xấu|cao|thấp|to|nhỏ|mới|cũ|nhanh|chậm|nóng|lạnh|xa|gần|dễ|khó|vui|buồn|tốt|xấu|đúng|sai|sáng|tối|rõ|mờ|lớn|bé|dài|ngắn|rộng|hẹp)\b/,
      ) &&
      !m.match(/\b(đủ|thiếu|thừa|nhiều|ít|vừa|số lượng)\b/)
    ) {
      return { nameVi: 'Tính từ', nameEn: 'Adjectives' };
    }

    // Nếu là danh từ (có các từ chỉ sự vật, người) - LOẠI BỎ "bài tập"
    if (
      m.match(
        /\b(người|vật|đồ|địa điểm|trường|nhà|phòng|đường|thành phố|quốc gia|tiền|cửa|bàn|ghế|sách|vở|bút|giấy|bài học)\b/,
      ) &&
      !m.match(/\b(bài tập|bài|tập)\b/)
    ) {
      return { nameVi: 'Danh từ', nameEn: 'Nouns' };
    }

    // Mặc định là Danh từ nếu không thể phân loại
    return { nameVi: 'Danh từ', nameEn: 'Nouns' };
  }
}
