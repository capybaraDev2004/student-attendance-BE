"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const prisma = new client_1.PrismaClient();
const categories = [
    { name_vi: 'Chào hỏi', name_en: 'Greetings' },
    { name_vi: 'Giới thiệu bản thân', name_en: 'Self Introduction' },
    { name_vi: 'Gia đình', name_en: 'Family' },
    { name_vi: 'Màu sắc', name_en: 'Colors' },
    { name_vi: 'Số đếm', name_en: 'Numbers' },
    { name_vi: 'Thời gian', name_en: 'Time' },
    { name_vi: 'Thời tiết', name_en: 'Weather' },
    { name_vi: 'Thực phẩm', name_en: 'Food' },
    { name_vi: 'Mua sắm', name_en: 'Shopping' },
    { name_vi: 'Giao thông', name_en: 'Transportation' },
    { name_vi: 'Sức khỏe', name_en: 'Health' },
    { name_vi: 'Học tập', name_en: 'Education' },
    { name_vi: 'Công việc', name_en: 'Work' },
    { name_vi: 'Du lịch', name_en: 'Travel' },
    { name_vi: 'Thể thao', name_en: 'Sports' },
    { name_vi: 'Sở thích', name_en: 'Hobbies' },
    { name_vi: 'Cảm xúc', name_en: 'Emotions' },
    { name_vi: 'Địa điểm', name_en: 'Places' },
    { name_vi: 'Mua bán', name_en: 'Buying and Selling' },
    { name_vi: 'Điện thoại và Internet', name_en: 'Phone and Internet' },
];
const sentencesData = [
    {
        categoryIndex: 0,
        chinese_simplified: '你好',
        pinyin: 'Nǐ hǎo',
        vietnamese: 'Xin chào',
    },
    {
        categoryIndex: 0,
        chinese_simplified: '早上好',
        pinyin: 'Zǎoshang hǎo',
        vietnamese: 'Chào buổi sáng',
    },
    {
        categoryIndex: 0,
        chinese_simplified: '晚上好',
        pinyin: 'Wǎnshang hǎo',
        vietnamese: 'Chào buổi tối',
    },
    {
        categoryIndex: 0,
        chinese_simplified: '再见',
        pinyin: 'Zàijiàn',
        vietnamese: 'Tạm biệt',
    },
    {
        categoryIndex: 0,
        chinese_simplified: '谢谢',
        pinyin: 'Xièxie',
        vietnamese: 'Cảm ơn',
    },
    {
        categoryIndex: 1,
        chinese_simplified: '我叫小明',
        pinyin: 'Wǒ jiào Xiǎomíng',
        vietnamese: 'Tôi tên là Tiểu Minh',
    },
    {
        categoryIndex: 1,
        chinese_simplified: '我来自越南',
        pinyin: 'Wǒ láizì Yuènán',
        vietnamese: 'Tôi đến từ Việt Nam',
    },
    {
        categoryIndex: 1,
        chinese_simplified: '我今年二十五岁',
        pinyin: 'Wǒ jīnnián èrshíwǔ suì',
        vietnamese: 'Năm nay tôi hai mươi lăm tuổi',
    },
    {
        categoryIndex: 1,
        chinese_simplified: '我是学生',
        pinyin: 'Wǒ shì xuésheng',
        vietnamese: 'Tôi là sinh viên',
    },
    {
        categoryIndex: 1,
        chinese_simplified: '很高兴认识你',
        pinyin: 'Hěn gāoxìng rènshi nǐ',
        vietnamese: 'Rất vui được làm quen với bạn',
    },
    {
        categoryIndex: 2,
        chinese_simplified: '这是我的家人',
        pinyin: 'Zhè shì wǒ de jiārén',
        vietnamese: 'Đây là gia đình tôi',
    },
    {
        categoryIndex: 2,
        chinese_simplified: '我有两个兄弟',
        pinyin: 'Wǒ yǒu liǎng gè xiōngdì',
        vietnamese: 'Tôi có hai người anh em',
    },
    {
        categoryIndex: 2,
        chinese_simplified: '我父母很健康',
        pinyin: 'Wǒ fùmǔ hěn jiànkāng',
        vietnamese: 'Bố mẹ tôi rất khỏe mạnh',
    },
    {
        categoryIndex: 2,
        chinese_simplified: '我姐姐是老师',
        pinyin: 'Wǒ jiějie shì lǎoshī',
        vietnamese: 'Chị gái tôi là giáo viên',
    },
    {
        categoryIndex: 2,
        chinese_simplified: '我们一家人很幸福',
        pinyin: 'Wǒmen yījiārén hěn xìngfú',
        vietnamese: 'Gia đình chúng tôi rất hạnh phúc',
    },
    {
        categoryIndex: 3,
        chinese_simplified: '我喜欢红色',
        pinyin: 'Wǒ xǐhuan hóngsè',
        vietnamese: 'Tôi thích màu đỏ',
    },
    {
        categoryIndex: 3,
        chinese_simplified: '天空是蓝色的',
        pinyin: 'Tiānkōng shì lánsè de',
        vietnamese: 'Bầu trời màu xanh',
    },
    {
        categoryIndex: 3,
        chinese_simplified: '这朵花是黄色的',
        pinyin: 'Zhè duǒ huā shì huángsè de',
        vietnamese: 'Bông hoa này màu vàng',
    },
    {
        categoryIndex: 3,
        chinese_simplified: '黑色是我的最爱',
        pinyin: 'Hēisè shì wǒ de zuì ài',
        vietnamese: 'Màu đen là màu yêu thích của tôi',
    },
    {
        categoryIndex: 3,
        chinese_simplified: '白色代表纯洁',
        pinyin: 'Báisè dàibiǎo chúnjié',
        vietnamese: 'Màu trắng tượng trưng cho sự trong trắng',
    },
    {
        categoryIndex: 4,
        chinese_simplified: '一加一等于二',
        pinyin: 'Yī jiā yī děngyú èr',
        vietnamese: 'Một cộng một bằng hai',
    },
    {
        categoryIndex: 4,
        chinese_simplified: '我有三个苹果',
        pinyin: 'Wǒ yǒu sān gè píngguǒ',
        vietnamese: 'Tôi có ba quả táo',
    },
    {
        categoryIndex: 4,
        chinese_simplified: '今天是五月十五号',
        pinyin: 'Jīntiān shì wǔyuè shíwǔ hào',
        vietnamese: 'Hôm nay là ngày mười lăm tháng năm',
    },
    {
        categoryIndex: 4,
        chinese_simplified: '这本书有五百页',
        pinyin: 'Zhè běn shū yǒu wǔbǎi yè',
        vietnamese: 'Cuốn sách này có năm trăm trang',
    },
    {
        categoryIndex: 4,
        chinese_simplified: '我买了十支笔',
        pinyin: 'Wǒ mǎile shí zhī bǐ',
        vietnamese: 'Tôi đã mua mười cây bút',
    },
    {
        categoryIndex: 5,
        chinese_simplified: '现在几点了？',
        pinyin: 'Xiànzài jǐ diǎn le?',
        vietnamese: 'Bây giờ mấy giờ rồi?',
    },
    {
        categoryIndex: 5,
        chinese_simplified: '我每天早上七点起床',
        pinyin: 'Wǒ měitiān zǎoshang qī diǎn qǐchuáng',
        vietnamese: 'Mỗi sáng tôi thức dậy lúc bảy giờ',
    },
    {
        categoryIndex: 5,
        chinese_simplified: '今天是星期一',
        pinyin: 'Jīntiān shì xīngqīyī',
        vietnamese: 'Hôm nay là thứ Hai',
    },
    {
        categoryIndex: 5,
        chinese_simplified: '我们下个月去旅行',
        pinyin: 'Wǒmen xià gè yuè qù lǚxíng',
        vietnamese: 'Tháng sau chúng tôi sẽ đi du lịch',
    },
    {
        categoryIndex: 5,
        chinese_simplified: '会议在下午三点开始',
        pinyin: 'Huìyì zài xiàwǔ sān diǎn kāishǐ',
        vietnamese: 'Cuộc họp bắt đầu lúc ba giờ chiều',
    },
    {
        categoryIndex: 6,
        chinese_simplified: '今天天气很好',
        pinyin: 'Jīntiān tiānqì hěn hǎo',
        vietnamese: 'Hôm nay thời tiết rất đẹp',
    },
    {
        categoryIndex: 6,
        chinese_simplified: '外面在下雨',
        pinyin: 'Wàimiàn zài xià yǔ',
        vietnamese: 'Bên ngoài đang mưa',
    },
    {
        categoryIndex: 6,
        chinese_simplified: '今天很热',
        pinyin: 'Jīntiān hěn rè',
        vietnamese: 'Hôm nay rất nóng',
    },
    {
        categoryIndex: 6,
        chinese_simplified: '冬天很冷',
        pinyin: 'Dōngtiān hěn lěng',
        vietnamese: 'Mùa đông rất lạnh',
    },
    {
        categoryIndex: 6,
        chinese_simplified: '明天会晴天',
        pinyin: 'Míngtiān huì qíngtiān',
        vietnamese: 'Ngày mai sẽ nắng',
    },
    {
        categoryIndex: 7,
        chinese_simplified: '我想吃面条',
        pinyin: 'Wǒ xiǎng chī miàntiáo',
        vietnamese: 'Tôi muốn ăn mì',
    },
    {
        categoryIndex: 7,
        chinese_simplified: '这个菜很好吃',
        pinyin: 'Zhè gè cài hěn hǎochī',
        vietnamese: 'Món ăn này rất ngon',
    },
    {
        categoryIndex: 7,
        chinese_simplified: '我喜欢吃水果',
        pinyin: 'Wǒ xǐhuan chī shuǐguǒ',
        vietnamese: 'Tôi thích ăn trái cây',
    },
    {
        categoryIndex: 7,
        chinese_simplified: '请给我一杯水',
        pinyin: 'Qǐng gěi wǒ yī bēi shuǐ',
        vietnamese: 'Xin cho tôi một cốc nước',
    },
    {
        categoryIndex: 7,
        chinese_simplified: '我不喜欢吃辣的',
        pinyin: 'Wǒ bù xǐhuan chī là de',
        vietnamese: 'Tôi không thích ăn cay',
    },
    {
        categoryIndex: 8,
        chinese_simplified: '这件衣服多少钱？',
        pinyin: 'Zhè jiàn yīfu duōshao qián?',
        vietnamese: 'Bộ quần áo này bao nhiêu tiền?',
    },
    {
        categoryIndex: 8,
        chinese_simplified: '我可以试穿吗？',
        pinyin: 'Wǒ kěyǐ shìchuān ma?',
        vietnamese: 'Tôi có thể thử được không?',
    },
    {
        categoryIndex: 8,
        chinese_simplified: '太贵了，能便宜点吗？',
        pinyin: 'Tài guì le, néng piányi diǎn ma?',
        vietnamese: 'Đắt quá, có thể rẻ hơn một chút không?',
    },
    {
        categoryIndex: 8,
        chinese_simplified: '我要买这个',
        pinyin: 'Wǒ yào mǎi zhè gè',
        vietnamese: 'Tôi muốn mua cái này',
    },
    {
        categoryIndex: 8,
        chinese_simplified: '可以用信用卡吗？',
        pinyin: 'Kěyǐ yòng xìnyòngkǎ ma?',
        vietnamese: 'Có thể dùng thẻ tín dụng không?',
    },
    {
        categoryIndex: 9,
        chinese_simplified: '我要去机场',
        pinyin: 'Wǒ yào qù jīchǎng',
        vietnamese: 'Tôi muốn đi đến sân bay',
    },
    {
        categoryIndex: 9,
        chinese_simplified: '怎么去火车站？',
        pinyin: 'Zěnme qù huǒchēzhàn?',
        vietnamese: 'Làm sao để đến ga tàu?',
    },
    {
        categoryIndex: 9,
        chinese_simplified: '我坐公交车上班',
        pinyin: 'Wǒ zuò gōngjiāochē shàngbān',
        vietnamese: 'Tôi đi xe buýt đi làm',
    },
    {
        categoryIndex: 9,
        chinese_simplified: '请开慢一点',
        pinyin: 'Qǐng kāi màn yīdiǎn',
        vietnamese: 'Xin lái chậm một chút',
    },
    {
        categoryIndex: 9,
        chinese_simplified: '这里可以停车吗？',
        pinyin: 'Zhèlǐ kěyǐ tíngchē ma?',
        vietnamese: 'Ở đây có thể đỗ xe không?',
    },
    {
        categoryIndex: 10,
        chinese_simplified: '我头疼',
        pinyin: 'Wǒ tóuténg',
        vietnamese: 'Tôi bị đau đầu',
    },
    {
        categoryIndex: 10,
        chinese_simplified: '你需要去看医生',
        pinyin: 'Nǐ xūyào qù kàn yīshēng',
        vietnamese: 'Bạn cần đi khám bác sĩ',
    },
    {
        categoryIndex: 10,
        chinese_simplified: '我感冒了',
        pinyin: 'Wǒ gǎnmào le',
        vietnamese: 'Tôi bị cảm',
    },
    {
        categoryIndex: 10,
        chinese_simplified: '多喝水，多休息',
        pinyin: 'Duō hē shuǐ, duō xiūxi',
        vietnamese: 'Uống nhiều nước, nghỉ ngơi nhiều',
    },
    {
        categoryIndex: 10,
        chinese_simplified: '我感觉好多了',
        pinyin: 'Wǒ gǎnjué hǎo duō le',
        vietnamese: 'Tôi cảm thấy khỏe hơn nhiều rồi',
    },
    {
        categoryIndex: 11,
        chinese_simplified: '我在学中文',
        pinyin: 'Wǒ zài xué Zhōngwén',
        vietnamese: 'Tôi đang học tiếng Trung',
    },
    {
        categoryIndex: 11,
        chinese_simplified: '这个字怎么写？',
        pinyin: 'Zhè gè zì zěnme xiě?',
        vietnamese: 'Chữ này viết như thế nào?',
    },
    {
        categoryIndex: 11,
        chinese_simplified: '请再说一遍',
        pinyin: 'Qǐng zài shuō yībiàn',
        vietnamese: 'Xin nói lại một lần nữa',
    },
    {
        categoryIndex: 11,
        chinese_simplified: '我明天有考试',
        pinyin: 'Wǒ míngtiān yǒu kǎoshì',
        vietnamese: 'Ngày mai tôi có bài thi',
    },
    {
        categoryIndex: 11,
        chinese_simplified: '你作业做完了吗？',
        pinyin: 'Nǐ zuòyè zuòwán le ma?',
        vietnamese: 'Bạn đã làm xong bài tập chưa?',
    },
    {
        categoryIndex: 12,
        chinese_simplified: '我是工程师',
        pinyin: 'Wǒ shì gōngchéngshī',
        vietnamese: 'Tôi là kỹ sư',
    },
    {
        categoryIndex: 12,
        chinese_simplified: '我九点上班',
        pinyin: 'Wǒ jiǔ diǎn shàngbān',
        vietnamese: 'Tôi đi làm lúc chín giờ',
    },
    {
        categoryIndex: 12,
        chinese_simplified: '今天工作很忙',
        pinyin: 'Jīntiān gōngzuò hěn máng',
        vietnamese: 'Hôm nay công việc rất bận',
    },
    {
        categoryIndex: 12,
        chinese_simplified: '我下班了',
        pinyin: 'Wǒ xiàbān le',
        vietnamese: 'Tôi đã tan làm',
    },
    {
        categoryIndex: 12,
        chinese_simplified: '这个项目很重要',
        pinyin: 'Zhè gè xiàngmù hěn zhòngyào',
        vietnamese: 'Dự án này rất quan trọng',
    },
    {
        categoryIndex: 13,
        chinese_simplified: '我想去北京旅游',
        pinyin: 'Wǒ xiǎng qù Běijīng lǚyóu',
        vietnamese: 'Tôi muốn đi du lịch Bắc Kinh',
    },
    {
        categoryIndex: 13,
        chinese_simplified: '这里风景很美',
        pinyin: 'Zhèlǐ fēngjǐng hěn měi',
        vietnamese: 'Cảnh đẹp ở đây rất đẹp',
    },
    {
        categoryIndex: 13,
        chinese_simplified: '我要订一个房间',
        pinyin: 'Wǒ yào dìng yī gè fángjiān',
        vietnamese: 'Tôi muốn đặt một phòng',
    },
    {
        categoryIndex: 13,
        chinese_simplified: '请给我一张地图',
        pinyin: 'Qǐng gěi wǒ yī zhāng dìtú',
        vietnamese: 'Xin cho tôi một tấm bản đồ',
    },
    {
        categoryIndex: 13,
        chinese_simplified: '这个城市很有名',
        pinyin: 'Zhè gè chéngshì hěn yǒumíng',
        vietnamese: 'Thành phố này rất nổi tiếng',
    },
    {
        categoryIndex: 14,
        chinese_simplified: '我喜欢打篮球',
        pinyin: 'Wǒ xǐhuan dǎ lánqiú',
        vietnamese: 'Tôi thích chơi bóng rổ',
    },
    {
        categoryIndex: 14,
        chinese_simplified: '我每天跑步',
        pinyin: 'Wǒ měitiān pǎobù',
        vietnamese: 'Tôi chạy bộ mỗi ngày',
    },
    {
        categoryIndex: 14,
        chinese_simplified: '足球比赛很精彩',
        pinyin: 'Zúqiú bǐsài hěn jīngcǎi',
        vietnamese: 'Trận đấu bóng đá rất hay',
    },
    {
        categoryIndex: 14,
        chinese_simplified: '我要去健身房',
        pinyin: 'Wǒ yào qù jiànshēnfáng',
        vietnamese: 'Tôi muốn đi phòng gym',
    },
    {
        categoryIndex: 14,
        chinese_simplified: '运动对身体好',
        pinyin: 'Yùndòng duì shēntǐ hǎo',
        vietnamese: 'Tập thể dục tốt cho sức khỏe',
    },
    {
        categoryIndex: 15,
        chinese_simplified: '我喜欢听音乐',
        pinyin: 'Wǒ xǐhuan tīng yīnyuè',
        vietnamese: 'Tôi thích nghe nhạc',
    },
    {
        categoryIndex: 15,
        chinese_simplified: '我爱好读书',
        pinyin: 'Wǒ àihào dúshū',
        vietnamese: 'Tôi thích đọc sách',
    },
    {
        categoryIndex: 15,
        chinese_simplified: '周末我喜欢看电影',
        pinyin: 'Zhōumò wǒ xǐhuan kàn diànyǐng',
        vietnamese: 'Cuối tuần tôi thích xem phim',
    },
    {
        categoryIndex: 15,
        chinese_simplified: '我会弹钢琴',
        pinyin: 'Wǒ huì tán gāngqín',
        vietnamese: 'Tôi biết chơi đàn piano',
    },
    {
        categoryIndex: 15,
        chinese_simplified: '画画是我的爱好',
        pinyin: 'Huàhuà shì wǒ de àihào',
        vietnamese: 'Vẽ tranh là sở thích của tôi',
    },
    {
        categoryIndex: 16,
        chinese_simplified: '我很高兴',
        pinyin: 'Wǒ hěn gāoxìng',
        vietnamese: 'Tôi rất vui',
    },
    {
        categoryIndex: 16,
        chinese_simplified: '我有点累',
        pinyin: 'Wǒ yǒudiǎn lèi',
        vietnamese: 'Tôi hơi mệt',
    },
    {
        categoryIndex: 16,
        chinese_simplified: '我很担心',
        pinyin: 'Wǒ hěn dānxīn',
        vietnamese: 'Tôi rất lo lắng',
    },
    {
        categoryIndex: 16,
        chinese_simplified: '这让我很生气',
        pinyin: 'Zhè ràng wǒ hěn shēngqì',
        vietnamese: 'Điều này làm tôi rất tức giận',
    },
    {
        categoryIndex: 16,
        chinese_simplified: '我感到很放松',
        pinyin: 'Wǒ gǎndào hěn fàngsōng',
        vietnamese: 'Tôi cảm thấy rất thư giãn',
    },
    {
        categoryIndex: 17,
        chinese_simplified: '银行在哪里？',
        pinyin: 'Yínháng zài nǎlǐ?',
        vietnamese: 'Ngân hàng ở đâu?',
    },
    {
        categoryIndex: 17,
        chinese_simplified: '我要去图书馆',
        pinyin: 'Wǒ yào qù túshūguǎn',
        vietnamese: 'Tôi muốn đi thư viện',
    },
    {
        categoryIndex: 17,
        chinese_simplified: '医院在那边',
        pinyin: 'Yīyuàn zài nàbiān',
        vietnamese: 'Bệnh viện ở đằng kia',
    },
    {
        categoryIndex: 17,
        chinese_simplified: '学校离这里很远',
        pinyin: 'Xuéxiào lí zhèlǐ hěn yuǎn',
        vietnamese: 'Trường học cách đây rất xa',
    },
    {
        categoryIndex: 17,
        chinese_simplified: '超市在左边',
        pinyin: 'Chāoshì zài zuǒbiān',
        vietnamese: 'Siêu thị ở bên trái',
    },
    {
        categoryIndex: 18,
        chinese_simplified: '我想卖这辆车',
        pinyin: 'Wǒ xiǎng mài zhè liàng chē',
        vietnamese: 'Tôi muốn bán chiếc xe này',
    },
    {
        categoryIndex: 18,
        chinese_simplified: '这个价格合理吗？',
        pinyin: 'Zhè gè jiàgé hélǐ ma?',
        vietnamese: 'Giá này có hợp lý không?',
    },
    {
        categoryIndex: 18,
        chinese_simplified: '我要买新手机',
        pinyin: 'Wǒ yào mǎi xīn shǒujī',
        vietnamese: 'Tôi muốn mua điện thoại mới',
    },
    {
        categoryIndex: 18,
        chinese_simplified: '可以打折吗？',
        pinyin: 'Kěyǐ dǎzhé ma?',
        vietnamese: 'Có thể giảm giá không?',
    },
    {
        categoryIndex: 18,
        chinese_simplified: '我付现金',
        pinyin: 'Wǒ fù xiànjīn',
        vietnamese: 'Tôi trả bằng tiền mặt',
    },
    {
        categoryIndex: 19,
        chinese_simplified: '你的电话号码是多少？',
        pinyin: 'Nǐ de diànhuà hàomǎ shì duōshao?',
        vietnamese: 'Số điện thoại của bạn là bao nhiêu?',
    },
    {
        categoryIndex: 19,
        chinese_simplified: '请给我发微信',
        pinyin: 'Qǐng gěi wǒ fā Wēixìn',
        vietnamese: 'Xin gửi cho tôi tin nhắn WeChat',
    },
    {
        categoryIndex: 19,
        chinese_simplified: '网络连接不好',
        pinyin: 'Wǎngluò liánjiē bù hǎo',
        vietnamese: 'Kết nối mạng không tốt',
    },
    {
        categoryIndex: 19,
        chinese_simplified: '我要下载这个应用',
        pinyin: 'Wǒ yào xiàzài zhè gè yìngyòng',
        vietnamese: 'Tôi muốn tải ứng dụng này',
    },
    {
        categoryIndex: 19,
        chinese_simplified: '请加我微信',
        pinyin: 'Qǐng jiā wǒ Wēixìn',
        vietnamese: 'Xin thêm tôi vào WeChat',
    },
];
async function main() {
    console.log('Bắt đầu thêm dữ liệu mẫu...');
    const createdCategories = [];
    for (const cat of categories) {
        const existing = await prisma.sentence_categories.findFirst({
            where: {
                OR: [
                    { name_vi: cat.name_vi },
                    { name_en: cat.name_en },
                ],
            },
        });
        if (existing) {
            console.log(`Chủ đề "${cat.name_vi}" đã tồn tại, bỏ qua.`);
            createdCategories.push(existing);
        }
        else {
            const created = await prisma.sentence_categories.create({
                data: cat,
            });
            console.log(`Đã tạo chủ đề: ${cat.name_vi} (${cat.name_en})`);
            createdCategories.push(created);
        }
    }
    console.log(`\nĐã tạo/tìm thấy ${createdCategories.length} chủ đề.\n`);
    let createdCount = 0;
    let skippedCount = 0;
    for (const sentence of sentencesData) {
        const category = createdCategories[sentence.categoryIndex];
        const existing = await prisma.sentences.findFirst({
            where: {
                chinese_simplified: sentence.chinese_simplified,
                category_id: category.id,
            },
        });
        if (existing) {
            skippedCount++;
            continue;
        }
        await prisma.sentences.create({
            data: {
                chinese_simplified: sentence.chinese_simplified,
                pinyin: sentence.pinyin,
                vietnamese: sentence.vietnamese,
                category_id: category.id,
            },
        });
        createdCount++;
        if (createdCount % 10 === 0) {
            console.log(`Đã tạo ${createdCount} câu...`);
        }
    }
    console.log(`\nHoàn thành!`);
    console.log(`- Đã tạo mới: ${createdCount} câu`);
    console.log(`- Đã bỏ qua (đã tồn tại): ${skippedCount} câu`);
    console.log(`- Tổng cộng: ${createdCount + skippedCount} câu`);
}
main()
    .catch((e) => {
    console.error('Lỗi:', e);
    process.exit(1);
})
    .finally(async () => {
    await prisma.$disconnect();
});
//# sourceMappingURL=seedSentences.js.map