export const TARGET_VOCABULARY_CATEGORIES = [
  'Số đếm & số lượng',
  'Con người & quan hệ xã hội',
  'Nghề nghiệp & công việc',
  'Sức khỏe & cơ thể',
  'Động vật & thực vật',
  'Món ăn & đồ uống',
  'Đồ dùng & quần áo',
  'Phương tiện & giao thông',
  'Địa điểm & môi trường',
  'Thời gian & thời tiết',
  'Giải trí & sở thích',
  'Trường học & học tập',
  'Ngôn ngữ & giao tiếp',
  'Tính từ & đặc điểm',
  'Từ loại đặc biệt & trợ từ',
  'Văn hóa – thói quen – lễ nghi',
  'Mua sắm & giao dịch',
  'Công việc, kinh doanh',
  'Hoạt động thường ngày',
  'Động từ',
];

interface ClassificationInput {
  chinese_word: string;
  pinyin?: string | null;
  meaning_vn: string;
}

interface ClassificationContext {
  chinese: string;
  normalizedMeaning: string;
  rawMeaning: string;
  words: string[];
  wordSet: Set<string>;
}

interface CategoryRule {
  name: string;
  priority: number;
  keywords?: string[];
  hanzi?: string[];
  startsWith?: string[];
  regex?: RegExp[];
  customScore?: (ctx: ClassificationContext) => number;
}

interface InternalRule extends CategoryRule {
  normalizedKeywords: string[];
  normalizedStartsWith: string[];
}

const normalizeVi = (value: string) =>
  (value || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();

const adjectiveKeywords = [
  'đẹp',
  'xấu',
  'cao',
  'thấp',
  'lớn',
  'nhỏ',
  'dài',
  'ngắn',
  'mạnh',
  'yếu',
  'nhanh',
  'chậm',
  'nặng',
  'nhẹ',
  'ấm',
  'lạnh',
  'nóng',
  'mát',
  'vui',
  'buồn',
  'tốt',
  'đúng',
  'sai',
  'sạch',
  'bẩn',
  'trắng',
  'đen',
  'đỏ',
  'xanh',
  'vàng',
  'giàu',
  'nghèo',
  'an toàn',
  'thông minh',
  'ngu ngốc',
  'dễ',
  'khó',
  'đặc biệt',
  'khác biệt',
  'đơn giản',
  'phức tạp',
  'kỳ lạ',
  'đông',
  'tây',
  'cao cấp',
  'phổ biến',
  'chính xác',
  'tạm thời',
];

const particleCharacters = ['了', '吗', '吧', '呢', '啊', '呀', '把', '被', '得', '地', '的', '所', '与'];

const CATEGORY_RULES: CategoryRule[] = [
  {
    name: 'Số đếm & số lượng',
    priority: 100,
    keywords: [
      'số',
      'số lượng',
      'số đếm',
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
      'mươi',
      'trăm',
      'nghìn',
      'ngàn',
      'triệu',
      'tỷ',
      'phần trăm',
      'phần nghìn',
      'phân số',
      'tỷ lệ',
      'bao nhiêu',
      'mấy',
      'lần',
      'đếm',
      'cộng',
      'trừ',
      'nhân',
      'chia',
      'số thứ tự',
      'thứ nhất',
      'thứ hai',
      'thứ ba',
    ],
    hanzi: [
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
      '第',
      '几',
      '多',
      '少',
    ],
    regex: [
      /^[0-9]+$/,
      /[0-9]+(\\.[0-9]+)?%/,
      /^[零一二三四五六七八九十百千万亿两0-9]+$/,
    ],
  },
  {
    name: 'Con người & quan hệ xã hội',
    priority: 50,
    keywords: [
      'con người',
      'gia đình',
      'cha',
      'mẹ',
      'bố',
      'anh',
      'chị',
      'em',
      'bạn bè',
      'bạn thân',
      'quan hệ',
      'tình yêu',
      'hôn nhân',
      'kết hôn',
      'vợ',
      'chồng',
      'con trai',
      'con gái',
      'trẻ em',
      'em bé',
      'họ hàng',
      'xã hội',
      'cộng đồng',
      'đồng đội',
      'hàng xóm',
      'đồng nghiệp',
    ],
    hanzi: ['人', '友', '亲', '婚', '爱', '伴'],
  },
  {
    name: 'Nghề nghiệp & công việc',
    priority: 60,
    keywords: [
      'nghề nghiệp',
      'công việc',
      'làm việc',
      'công ty',
      'doanh nghiệp',
      'văn phòng',
      'nhân viên',
      'sếp',
      'giám đốc',
      'kỹ sư',
      'công nhân',
      'thư ký',
      'hợp đồng',
      'lương',
      'phỏng vấn',
      'tuyển dụng',
      'chức vụ',
      'thăng chức',
      'ca làm',
      'nghỉ việc',
      'kinh doanh',
      'khởi nghiệp',
    ],
    hanzi: ['工', '职', '员', '企', '务', '厂', '司', '班', '组'],
  },
  {
    name: 'Sức khỏe & cơ thể',
    priority: 70,
    keywords: [
      'sức khỏe',
      'cơ thể',
      'bộ phận',
      'tay',
      'chân',
      'đầu',
      'mắt',
      'tai',
      'mũi',
      'miệng',
      'tim',
      'gan',
      'phổi',
      'dạ dày',
      'bệnh',
      'đau',
      'ốm',
      'khám bệnh',
      'chữa bệnh',
      'bệnh viện',
      'thuốc',
      'thể dục',
      'dinh dưỡng',
      'khỏe mạnh',
      'y tế',
      'bác sĩ',
      'y tá',
      'sốt',
    ],
    hanzi: ['心', '病', '医', '药', '体', '健', '痛', '血'],
  },
  {
    name: 'Động vật & thực vật',
    priority: 55,
    keywords: [
      'động vật',
      'thực vật',
      'con',
      'cây',
      'hoa',
      'lá',
      'rừng',
      'thảo mộc',
      'chim',
      'cá',
      'thú nuôi',
      'nuôi',
      'trồng',
      'giống',
      'nông nghiệp',
    ],
    hanzi: ['花', '草', '木', '树', '鱼', '鸟', '牛', '羊', '马', '犬', '猫', '兔', '虫'],
  },
  {
    name: 'Món ăn & đồ uống',
    priority: 80,
    keywords: [
      'món ăn',
      'đồ ăn',
      'đồ uống',
      'ẩm thực',
      'thực phẩm',
      'bữa ăn',
      'cơm',
      'canh',
      'cháo',
      'mì',
      'bún',
      'bánh',
      'rau',
      'thịt',
      'gia vị',
      'sữa',
      'trà',
      'cà phê',
      'rượu',
      'bia',
      'nước uống',
      'tráng miệng',
      'ăn nhẹ',
    ],
    hanzi: ['饭', '菜', '米', '面', '汤', '饮', '吃', '喝', '酒', '茶', '糖', '肉'],
  },
  {
    name: 'Đồ dùng & quần áo',
    priority: 65,
    keywords: [
      'quần áo',
      'áo',
      'quần',
      'váy',
      'đầm',
      'giày',
      'dép',
      'mũ',
      'nón',
      'túi',
      'phụ kiện',
      'trang phục',
      'đồ dùng',
      'đồ gia dụng',
      'nội thất',
      'bàn',
      'ghế',
      'giường',
      'tủ',
      'đèn',
      'thiết bị',
      'dụng cụ',
    ],
    hanzi: ['衣', '服', '裤', '裙', '鞋', '帽', '包', '桌', '椅', '柜', '灯', '具', '机'],
  },
  {
    name: 'Phương tiện & giao thông',
    priority: 75,
    keywords: [
      'phương tiện',
      'giao thông',
      'xe',
      'tàu',
      'thuyền',
      'máy bay',
      'xe buýt',
      'xe lửa',
      'xe đạp',
      'xe máy',
      'ô tô',
      'lái xe',
      'trạm',
      'ga',
      'bến',
      'cao tốc',
      'đường bộ',
      'vận tải',
      'vận chuyển',
    ],
    hanzi: ['车', '船', '航', '机', '站', '路', '铁', '汽', '巴', '轨'],
  },
  {
    name: 'Địa điểm & môi trường',
    priority: 45,
    keywords: [
      'địa điểm',
      'nơi chốn',
      'vị trí',
      'khu vực',
      'thành phố',
      'thị trấn',
      'làng',
      'quê',
      'công viên',
      'núi',
      'sông',
      'biển',
      'sa mạc',
      'khí hậu',
      'môi trường',
      'thiên nhiên',
      'cảnh quan',
      'địa lý',
      'tòa nhà',
      'nhà cửa',
      'phòng',
      'khu phố',
    ],
    hanzi: ['市', '村', '镇', '岛', '山', '河', '海', '湖', '园', '馆', '场', '地'],
  },
  {
    name: 'Thời gian & thời tiết',
    priority: 85,
    keywords: [
      'thời gian',
      'giờ',
      'phút',
      'giây',
      'lịch',
      'ngày',
      'tháng',
      'năm',
      'thứ',
      'mùa',
      'xuân',
      'hạ',
      'thu',
      'đông',
      'thời tiết',
      'nhiệt độ',
      'nắng',
      'mưa',
      'gió',
      'bão',
      'tuyết',
      'khí hậu',
      'lịch trình',
      'hôm nay',
      'ngày mai',
      'quá khứ',
      'tương lai',
    ],
    hanzi: ['时', '分', '秒', '天', '月', '年', '日', '季', '春', '夏', '秋', '冬', '晴', '雨', '雪', '风', '候', '气'],
  },
  {
    name: 'Giải trí & sở thích',
    priority: 58,
    keywords: [
      'giải trí',
      'sở thích',
      'thú vui',
      'chơi',
      'trò chơi',
      'game',
      'âm nhạc',
      'nhạc',
      'hát',
      'vẽ',
      'múa',
      'phim',
      'điện ảnh',
      'du lịch',
      'thể thao',
      'bóng đá',
      'bóng rổ',
      'bơi',
      'đọc sách',
      'nghệ thuật',
      'đàn',
      'sưu tầm',
    ],
    hanzi: ['乐', '游', '玩', '球', '舞', '画', '旅', '歌', '唱', '影'],
  },
  {
    name: 'Trường học & học tập',
    priority: 77,
    keywords: [
      'trường học',
      'học tập',
      'học sinh',
      'sinh viên',
      'giáo viên',
      'giảng viên',
      'bài học',
      'bài giảng',
      'bài tập',
      'thi',
      'kỳ thi',
      'điểm số',
      'lớp học',
      'phòng học',
      'thư viện',
      'giáo trình',
      'sách',
      'vở',
      'nghiên cứu',
      'trường đại học',
      'môn học',
    ],
    hanzi: ['学', '校', '课', '教', '师', '生', '班', '考', '试', '题', '书'],
  },
  {
    name: 'Ngôn ngữ & giao tiếp',
    priority: 72,
    keywords: [
      'ngôn ngữ',
      'ngữ pháp',
      'từ vựng',
      'câu',
      'cụm từ',
      'phiên âm',
      'dịch',
      'giao tiếp',
      'đối thoại',
      'nói chuyện',
      'trò chuyện',
      'thư',
      'email',
      'tin nhắn',
      'viết',
      'đọc',
      'nghe',
      'phát âm',
      'ngôn từ',
      'hỏi',
      'đáp',
      'thảo luận',
      'thuyết trình',
    ],
    hanzi: ['语', '言', '话', '问', '答', '说', '听', '读', '写', '信', '文', '句', '字'],
  },
  {
    name: 'Tính từ & đặc điểm',
    priority: 40, // Giảm priority để ưu tiên các category cụ thể hơn
    keywords: adjectiveKeywords,
    customScore: (ctx) => {
      let score = 0;
      for (const word of adjectiveKeywords) {
        const normalized = normalizeVi(word);
        if (normalized && ctx.normalizedMeaning.includes(normalized)) {
          score += 2; // Giảm điểm từ 3 xuống 2
        }
      }
      if (/^tinh tu\b/i.test(ctx.rawMeaning)) {
        score += 5;
      }
      if (ctx.rawMeaning.toLowerCase().includes('đặc điểm')) {
        score += 4;
      }
      return score;
    },
  },
  {
    name: 'Từ loại đặc biệt & trợ từ',
    priority: 95,
    keywords: [
      'trợ từ',
      'giới từ',
      'liên từ',
      'phó từ',
      'ngữ khí',
      'tiểu từ',
      'lượng từ',
      'từ nối',
      'từ cảm thán',
      'trợ từ kết cấu',
    ],
    hanzi: particleCharacters,
    customScore: (ctx) => {
      const text = ctx.rawMeaning.toLowerCase();
      return text.includes('trợ từ') ||
        text.includes('giới từ') ||
        text.includes('liên từ') ||
        text.includes('phó từ')
        ? 10
        : 0;
    },
  },
  {
    name: 'Văn hóa – thói quen – lễ nghi',
    priority: 62,
    keywords: [
      'văn hóa',
      'lễ nghi',
      'lễ hội',
      'truyền thống',
      'phong tục',
      'thói quen',
      'tập quán',
      'nghi lễ',
      'tôn giáo',
      'chúc mừng',
      'cúng',
      'tế',
      'lịch sử',
      'biểu tượng',
      'cổ truyền',
      'nghi thức',
      'chào hỏi',
    ],
    hanzi: ['礼', '俗', '习', '庆', '节', '福', '拜'],
  },
  {
    name: 'Mua sắm & giao dịch',
    priority: 78,
    keywords: [
      'mua sắm',
      'mua hàng',
      'bán hàng',
      'giao dịch',
      'thanh toán',
      'tiền',
      'giá',
      'giảm giá',
      'khuyến mãi',
      'siêu thị',
      'cửa hàng',
      'chợ',
      'đặt hàng',
      'đơn hàng',
      'vận chuyển',
      'giao hàng',
      'hóa đơn',
      'biên lai',
      'trả góp',
      'tiền mặt',
      'thẻ',
      'ngân hàng',
      'mặc cả',
      'chi tiêu',
      'tiết kiệm',
      'đổi trả',
    ],
    hanzi: ['买', '卖', '钱', '价', '费', '账', '店', '商', '购', '付', '银', '币'],
  },
  {
    name: 'Công việc, kinh doanh',
    priority: 65,
    keywords: [
      'kinh doanh',
      'thương mại',
      'doanh nghiệp',
      'công ty',
      'tập đoàn',
      'hợp tác',
      'đối tác',
      'khách hàng',
      'thị trường',
      'cạnh tranh',
      'lợi nhuận',
      'doanh thu',
      'đầu tư',
      'vốn',
      'tài chính',
      'kế toán',
      'báo cáo',
      'hợp đồng',
      'thỏa thuận',
      'đàm phán',
      'chiến lược',
      'quản lý',
      'điều hành',
      'marketing',
      'bán hàng',
      'xuất khẩu',
      'nhập khẩu',
      'sản xuất',
      'chất lượng',
      'hiệu quả',
    ],
    hanzi: ['商', '业', '企', '财', '资', '营', '销', '管', '理', '产', '品', '质'],
  },
  {
    name: 'Hoạt động thường ngày',
    priority: 68,
    keywords: [
      'thức dậy',
      'ngủ dậy',
      'đánh răng',
      'rửa mặt',
      'tắm',
      'ăn sáng',
      'ăn trưa',
      'ăn tối',
      'nấu ăn',
      'dọn dẹp',
      'quét nhà',
      'lau nhà',
      'giặt giũ',
      'phơi quần áo',
      'đi chợ',
      'mua sắm',
      'nấu cơm',
      'rửa bát',
      'xem tivi',
      'đọc báo',
      'nghe nhạc',
      'tập thể dục',
      'đi bộ',
      'chạy bộ',
      'đi xe đạp',
      'gặp bạn',
      'trò chuyện',
      'gọi điện',
      'nhắn tin',
      'làm việc nhà',
      'chăm sóc',
      'sinh hoạt',
      'thói quen',
      'hàng ngày',
      'buổi sáng',
      'buổi chiều',
      'buổi tối',
    ],
    hanzi: ['起', '洗', '吃', '做', '看', '听', '走', '跑', '骑', '打', '扫', '煮'],
  },
  {
    name: 'Động từ',
    priority: 35, // Giảm priority để ưu tiên các category cụ thể hơn
    keywords: [
      'làm',
      'đi',
      'đến',
      'về',
      'ra',
      'vào',
      'lên',
      'xuống',
      'mở',
      'đóng',
      'bắt đầu',
      'kết thúc',
      'tiếp tục',
      'dừng lại',
      'chạy',
      'đi bộ',
      'nhảy',
      'bay',
      'bơi',
      'leo',
      'ngồi',
      'đứng',
      'nằm',
      'cầm',
      'nắm',
      'bỏ',
      'để',
      'đặt',
      'lấy',
      'cho',
      'nhận',
      'mang',
      'đưa',
      'gửi',
      'ném',
      'kéo',
      'đẩy',
      'mua',
      'bán',
      'trao đổi',
      'sử dụng',
      'dùng',
      'thực hiện',
      'hoàn thành',
      'giải quyết',
      'xử lý',
      'chuẩn bị',
      'sắp xếp',
      'tổ chức',
      'tham gia',
      'rời khỏi',
    ],
    hanzi: ['做', '去', '来', '走', '跑', '飞', '游', '坐', '站', '躺', '拿', '放', '给', '买', '卖', '用', '开', '关', '进', '出', '上', '下'],
    customScore: (ctx) => {
      const verbPatterns = [
        /\b(làm|đi|đến|về|ra|vào|lên|xuống|mở|đóng|chạy|ngồi|đứng|nằm|cầm|lấy|cho|nhận|mua|bán|dùng)\b/i,
        /\b(thực hiện|tiến hành|hoàn thành|giải quyết|xử lý|chuẩn bị|sắp xếp|tổ chức)\b/i,
      ];
      let score = 0;
      for (const pattern of verbPatterns) {
        if (pattern.test(ctx.rawMeaning)) {
          score += 4;
        }
      }
      return score;
    },
  },
];

export class VocabularyCategoryClassifier {
  readonly defaultCategory = TARGET_VOCABULARY_CATEGORIES[0];
  private readonly rules: InternalRule[];

  constructor() {
    this.rules = CATEGORY_RULES.map((rule) => ({
      ...rule,
      normalizedKeywords: (rule.keywords ?? []).map(normalizeVi),
      normalizedStartsWith: (rule.startsWith ?? []).map(normalizeVi),
    }));
  }

  /**
   * Phân loại với phân tích loại từ nâng cao
   * @param input - Thông tin từ vựng
   * @param wordType - Loại từ đã được phân tích (verb/noun/adjective/etc.)
   */
  classify(input: ClassificationInput, wordType?: string): string {
    const context = this.createContext(input);
    
    // Nếu có thông tin loại từ, ưu tiên phân loại theo đó
    if (wordType) {
      const categoryByWordType = this.getCategoryByWordType(wordType, context);
      if (categoryByWordType) {
        return categoryByWordType;
      }
    }

    // Phân loại theo rules thông thường
    let bestRule: InternalRule | null = null;
    let bestScore = Number.NEGATIVE_INFINITY;

    for (const rule of this.rules) {
      const score = this.scoreRule(rule, context);
      if (score > bestScore || (score === bestScore && rule.priority > (bestRule?.priority ?? -Infinity))) {
        bestScore = score;
        bestRule = rule;
      }
    }

    // Nếu score quá thấp hoặc là 2 category chung chung, ưu tiên category cụ thể hơn
    if (!bestRule || bestScore <= 0) {
      return this.defaultCategory;
    }

    // Nếu bestRule là "Tính từ & đặc điểm" hoặc "Động từ" nhưng có category khác có score gần bằng, ưu tiên category cụ thể
    if ((bestRule.name === 'Tính từ & đặc điểm' || bestRule.name === 'Động từ') && bestScore < 15) {
      // Tìm category cụ thể có score cao nhất
      let bestSpecificRule: InternalRule | null = null;
      let bestSpecificScore = 0;
      
      for (const rule of this.rules) {
        if (rule.name === 'Tính từ & đặc điểm' || rule.name === 'Động từ') {
          continue;
        }
        const score = this.scoreRule(rule, context);
        if (score > bestSpecificScore) {
          bestSpecificScore = score;
          bestSpecificRule = rule;
        }
      }
      
      // Nếu có category cụ thể với score > 8, dùng nó thay vì category chung chung
      if (bestSpecificRule && bestSpecificScore > 8) {
        return bestSpecificRule.name;
      }
    }

    return bestRule.name;
  }

  /**
   * Lấy chủ đề dựa trên loại từ
   */
  private getCategoryByWordType(wordType: string, context: ClassificationContext): string | null {
    switch (wordType) {
      case 'verb':
        // Kiểm tra xem có phải động từ đặc thù của chủ đề nào không
        // Ưu tiên các category cụ thể, chỉ dùng "Động từ" khi không có category nào phù hợp
        let bestVerbCategory: string | null = null;
        let bestVerbScore = 0;
        
        for (const rule of this.rules) {
          if (rule.name === 'Tính từ & đặc điểm' || rule.name === 'Động từ') {
            continue; // Bỏ qua 2 category chung chung này
          }
          const score = this.scoreRule(rule, context);
          if (score > bestVerbScore) {
            bestVerbScore = score;
            bestVerbCategory = rule.name;
          }
        }
        
        // Chỉ trả về "Động từ" nếu không có category cụ thể nào phù hợp (score > 12)
        if (bestVerbScore > 12) {
          return bestVerbCategory;
        }
        return 'Động từ';
      
      case 'adjective':
        // Ưu tiên các category cụ thể trước, chỉ dùng "Tính từ & đặc điểm" khi không có category nào phù hợp
        let bestAdjCategory: string | null = null;
        let bestAdjScore = 0;
        
        for (const rule of this.rules) {
          if (rule.name === 'Tính từ & đặc điểm' || rule.name === 'Động từ') {
            continue; // Bỏ qua 2 category chung chung này
          }
          const score = this.scoreRule(rule, context);
          if (score > bestAdjScore) {
            bestAdjScore = score;
            bestAdjCategory = rule.name;
          }
        }
        
        // Chỉ trả về "Tính từ & đặc điểm" nếu không có category cụ thể nào phù hợp (score > 12)
        if (bestAdjScore > 12) {
          return bestAdjCategory;
        }
        return 'Tính từ & đặc điểm';
      
      case 'particle':
        return 'Từ loại đặc biệt & trợ từ';
      
      case 'noun':
        // Danh từ cần phân loại theo ngữ cảnh
        for (const rule of this.rules) {
          const score = this.scoreRule(rule, context);
          if (score > 10 && rule.name !== 'Động từ' && rule.name !== 'Tính từ & đặc điểm') {
            return rule.name;
          }
        }
        return this.defaultCategory;
      
      default:
        return null;
    }
  }

  private createContext(input: ClassificationInput): ClassificationContext {
    const rawMeaning = (input.meaning_vn || '').trim();
    const normalizedMeaning = normalizeVi(rawMeaning);
    const words = normalizedMeaning.split(' ').filter(Boolean);
    return {
      chinese: input.chinese_word || '',
      rawMeaning,
      normalizedMeaning,
      words,
      wordSet: new Set(words),
    };
  }

  private scoreRule(rule: InternalRule, ctx: ClassificationContext): number {
    let score = 0;

    for (const keyword of rule.normalizedKeywords) {
      if (!keyword) continue;
      if (ctx.normalizedMeaning.includes(keyword)) {
        score += keyword.length >= 5 ? 3 : 2;
      }
    }

    for (const prefix of rule.normalizedStartsWith) {
      if (prefix && ctx.normalizedMeaning.startsWith(prefix)) {
        score += 4;
      }
    }

    if (rule.hanzi && rule.hanzi.length) {
      for (const char of rule.hanzi) {
        if (char && ctx.chinese.includes(char)) {
          score += 2;
        }
      }
    }

    if (rule.regex && rule.regex.length) {
      for (const pattern of rule.regex) {
        if (pattern.test(ctx.rawMeaning)) {
          score += 3;
        }
      }
    }

    if (rule.customScore) {
      score += rule.customScore(ctx);
    }

    return score;
  }
}

