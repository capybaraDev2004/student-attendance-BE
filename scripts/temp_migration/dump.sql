--
-- PostgreSQL database dump
--

\restrict uFxq2wIazTeQue9E4xSjx4kbgagqR5xbw971G4C48AjVImHSZpdHHhmncIOoyDY

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: AccountStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountStatus" AS ENUM (
    'normal',
    'vip'
);


--
-- Name: AccountType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountType" AS ENUM (
    'local',
    'google'
);


--
-- Name: Region; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Region" AS ENUM (
    'bac',
    'trung',
    'nam'
);


--
-- Name: Role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Role" AS ENUM (
    'admin',
    'customer'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: daily_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_tasks (
    id integer NOT NULL,
    user_id integer NOT NULL,
    vocabulary_count integer DEFAULT 0 NOT NULL,
    sentence_count integer DEFAULT 0 NOT NULL,
    contest_completed boolean DEFAULT false NOT NULL,
    points_awarded integer DEFAULT 10 NOT NULL,
    points_given boolean DEFAULT false NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: daily_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: daily_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_tasks_id_seq OWNED BY public.daily_tasks.id;


--
-- Name: flashcards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flashcards (
    id integer NOT NULL,
    image_url text,
    answer text NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: flashcards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.flashcards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flashcards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.news (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: sentence_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sentence_categories (
    id integer NOT NULL,
    name_vi text,
    name_en text
);


--
-- Name: sentence_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sentence_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sentence_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sentence_categories_id_seq OWNED BY public.sentence_categories.id;


--
-- Name: sentences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sentences (
    id integer NOT NULL,
    chinese_simplified text,
    pinyin text,
    vietnamese text,
    category_id integer NOT NULL
);


--
-- Name: sentences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sentences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;


--
-- Name: user_daily_scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_daily_scores (
    id integer NOT NULL,
    user_id integer NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    score_date date NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: user_daily_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_daily_scores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_daily_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_daily_scores_id_seq OWNED BY public.user_daily_scores.id;


--
-- Name: user_monthly_scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_monthly_scores (
    id integer NOT NULL,
    user_id integer NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    month_cycle text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: user_monthly_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_monthly_scores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_monthly_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_monthly_scores_id_seq OWNED BY public.user_monthly_scores.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role public."Role" DEFAULT 'customer'::public."Role" NOT NULL,
    email_confirmed boolean DEFAULT false NOT NULL,
    verification_code text,
    verification_code_expires_at timestamp(3) without time zone,
    account_status public."AccountStatus" DEFAULT 'normal'::public."AccountStatus" NOT NULL,
    account_type public."AccountType" DEFAULT 'local'::public."AccountType" NOT NULL,
    must_set_password boolean DEFAULT false NOT NULL,
    reset_code text,
    reset_code_expires_at timestamp(3) without time zone,
    image_url text,
    address text,
    province text,
    region public."Region",
    xp integer DEFAULT 0 NOT NULL,
    streak_days integer DEFAULT 0 NOT NULL
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: vocabulary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vocabulary (
    vocab_id integer NOT NULL,
    chinese_word text NOT NULL,
    pinyin text NOT NULL,
    meaning_vn text NOT NULL,
    audio_url text,
    category_id integer
);


--
-- Name: vocabulary_box; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vocabulary_box (
    box_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: vocabulary_box_box_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vocabulary_box_box_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vocabulary_box_box_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vocabulary_box_box_id_seq OWNED BY public.vocabulary_box.box_id;


--
-- Name: vocabulary_box_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vocabulary_box_item (
    item_id integer NOT NULL,
    box_id integer NOT NULL,
    vocab_id integer NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    is_memorized boolean DEFAULT false NOT NULL,
    correct_count integer DEFAULT 0 NOT NULL,
    incorrect_count integer DEFAULT 0 NOT NULL,
    listen_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: vocabulary_box_item_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vocabulary_box_item_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vocabulary_box_item_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vocabulary_box_item_item_id_seq OWNED BY public.vocabulary_box_item.item_id;


--
-- Name: vocabulary_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vocabulary_categories (
    id integer NOT NULL,
    name_vi text,
    name_en text
);


--
-- Name: vocabulary_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vocabulary_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vocabulary_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vocabulary_categories_id_seq OWNED BY public.vocabulary_categories.id;


--
-- Name: vocabulary_vocab_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vocabulary_vocab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vocabulary_vocab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vocabulary_vocab_id_seq OWNED BY public.vocabulary.vocab_id;


--
-- Name: daily_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_tasks ALTER COLUMN id SET DEFAULT nextval('public.daily_tasks_id_seq'::regclass);


--
-- Name: flashcards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: sentence_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sentence_categories ALTER COLUMN id SET DEFAULT nextval('public.sentence_categories_id_seq'::regclass);


--
-- Name: sentences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);


--
-- Name: user_daily_scores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_daily_scores ALTER COLUMN id SET DEFAULT nextval('public.user_daily_scores_id_seq'::regclass);


--
-- Name: user_monthly_scores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_monthly_scores ALTER COLUMN id SET DEFAULT nextval('public.user_monthly_scores_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: vocabulary vocab_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary ALTER COLUMN vocab_id SET DEFAULT nextval('public.vocabulary_vocab_id_seq'::regclass);


--
-- Name: vocabulary_box box_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box ALTER COLUMN box_id SET DEFAULT nextval('public.vocabulary_box_box_id_seq'::regclass);


--
-- Name: vocabulary_box_item item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box_item ALTER COLUMN item_id SET DEFAULT nextval('public.vocabulary_box_item_item_id_seq'::regclass);


--
-- Name: vocabulary_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_categories ALTER COLUMN id SET DEFAULT nextval('public.vocabulary_categories_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
6645ae2f-5d81-4547-98fc-d78847a9695d	125129ea4fd79415539262108be923c94f57e40961180da1a0b90a620062adba	2026-01-03 18:59:15.918477+07	20251010091705_init_or_update	\N	\N	2026-01-03 18:59:15.910924+07	1
63531f7d-a6cd-4bf6-a9ce-6b0f8bfadb1d	de8a3a311f3d78142b22e32dec8ee53e2db021da3374b4af428d19cb18f01b5c	2026-01-05 19:59:55.368314+07	20250104000000_remove_weekly_contest_progress	\N	\N	2026-01-05 19:59:55.295932+07	1
f6be6bc0-d03f-411e-82f1-082d8000909d	a32a477f573b1f49da0a98a51cea4de38e5befbaed152d18cab23ac995344254	2026-01-03 18:59:16.042957+07	20251202100000_add_user_xp_streak	\N	\N	2026-01-03 18:59:16.039537+07	1
1954515d-4dd5-43a8-ae16-e06148a0c2a4	ffa1c154709073ab419c643b91b360ac1f77ec0c47001c39d8b8751395345eea	2026-01-03 18:59:15.909713+07	20251002093443_init_schema	\N	\N	2026-01-03 18:59:15.765755+07	1
b1efeae0-d67d-4309-995d-7f861a7113ba	852874f96bac40c026d8cd509be73793d7dc2eec323c8b1611856bd0c0485e21	2026-01-03 18:59:16.004067+07	20251117131500_add_user_image_and_files	\N	\N	2026-01-03 18:59:15.988241+07	1
c0f5f11f-0396-4a3f-9716-8e2b89146d81	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2026-01-03 18:59:15.923215+07	20251010092952_init_or_update	\N	\N	2026-01-03 18:59:15.919949+07	1
c6b59e9d-3edc-4860-bdf2-7ad0b2d8acec	1b4534dfa4e0f1266ec559edfc2348c775566d0ec585b19b8104ee87da80161e	2026-01-03 18:59:15.95971+07	20251010164523_add_stages_vocabulary_categories_sentences	\N	\N	2026-01-03 18:59:15.924352+07	1
cbc8fb1f-027f-4f74-8f8a-9612880a49ec	67cb1f0cd85963243c55e0d7e82b3ad9238bcbdb67a63e28c4ce772e93ca7419	2026-01-03 18:59:15.964794+07	20251117091500_add_user_account_fields	\N	\N	2026-01-03 18:59:15.960797+07	1
5157a77f-94be-469a-91ec-0d713b5aa32d	695e34068e234d6197b4bfec1447d16b24acd138c33709647c305061add1b542	2026-01-03 18:59:16.008249+07	20251117133500_add_region_and_address	\N	\N	2026-01-03 18:59:16.005175+07	1
c0bfef16-7426-4952-bcf5-ded53a835ac5	7246e9c52d0c02ff7d527895e2d5697709b70d1dea5b31d919fb0c09974cf5ae	2026-01-03 18:59:15.977661+07	20251117095000_update_account_type_enum	\N	\N	2026-01-03 18:59:15.965532+07	1
a7b2b008-79e7-4401-a0d4-19b7bcae4e34	edd0e588fc3ecb76871956c37433b9ff427452acfec9a07c26f4339ba31b69d0	2026-01-03 18:59:15.982606+07	20251117103000_add_must_set_password	\N	\N	2026-01-03 18:59:15.978689+07	1
13fecfd3-7196-49b1-b289-f7a0dadf04be	d6aa5857df7cca68a3ef2a124258f64d10fd9b6f6b48f04902f6283c96a5dd7f	2026-01-03 18:59:16.071379+07	20251217091000_weekly_contest_daily_lock	\N	\N	2026-01-03 18:59:16.063884+07	1
70c24a95-f2e7-45ae-9e6d-29c856faf901	e18712f748336fa40ee8a99dd49b3994c19f50851a4bde739f762254227eefda	2026-01-03 18:59:15.987249+07	20251117120500_add_reset_code	\N	\N	2026-01-03 18:59:15.983719+07	1
d2594462-19a3-4e3b-af72-331eb0bf1795	e83bdff67e324d0ef1f3b95c88cf6cbe161e259cb733593ddca870008df0a432	2026-01-03 18:59:16.03134+07	20251129222713_add_vocabulary_box_tables	\N	\N	2026-01-03 18:59:16.009208+07	1
4d891d5a-ba1f-42ff-a4ae-4b95f1e4d407	2cefa6b62d102ef83e985a37946bc813a5dc55defb7d6fe4ed3687d2a1e4af68	2026-01-03 18:59:16.052038+07	20251213194326_add_flashcards_table	\N	\N	2026-01-03 18:59:16.044028+07	1
d89e2eab-fe76-41a7-8ba4-1e418764f0af	70a34ffb0642bfd0b5cef4ad3f1d896ee913b4afd30f0f34644f4dd5767d54e3	2026-01-03 18:59:16.03864+07	20251129222909_update_vocabulary_box_one_per_user	\N	\N	2026-01-03 18:59:16.032186+07	1
5b8d1ba4-855b-406a-90b3-355a5fec4553	78bfda6ca7f9abb549bd49c753201764b3614e4d580cbe268161f8126004d96d	2026-01-03 18:59:16.102358+07	20251223120000_add_user_daily_scores	\N	\N	2026-01-03 18:59:16.089703+07	1
e4ff55fc-ff5a-42ae-b6f0-3f2cea5a27f5	04d142ee37a0b4535f7fdc4096fe660ec52c529cced8079d78bf6a3ea4a84041	2026-01-03 18:59:16.062907+07	20251217090000_add_weekly_contest_progress	\N	\N	2026-01-03 18:59:16.052944+07	1
f92ee254-293a-4069-8ab4-a3f5a21ad7ea	c8f7b4a53df491384ee1cbc548d5e3f5e7395eccf03acc3e9f1b4a1f6d52a0a0	2026-01-03 19:06:14.356578+07	20250103130000_change_daily_tasks_date_to_date		\N	2026-01-03 19:06:14.356578+07	0
8308498e-f303-4f56-ac59-c6d1d0067179	c22167644d6151657062ba0f496b343882e46512f27d6c962394db9edcc0cf44	2026-01-03 18:59:16.088477+07	20251217094000_add_user_monthly_scores	\N	\N	2026-01-03 18:59:16.072479+07	1
\.


--
-- Data for Name: daily_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.daily_tasks (id, user_id, vocabulary_count, sentence_count, contest_completed, points_awarded, points_given, date, created_at, updated_at) FROM stdin;
34	4	10	5	t	10	t	2026-01-06	2026-01-06 12:33:41.956	2026-01-06 12:36:30.617
1	2	10	5	t	10	t	2026-01-04	2026-01-05 11:57:25.474	2026-01-05 12:16:23.682
76	4	10	5	t	10	t	2026-01-07	2026-01-07 12:45:25.001	2026-01-07 12:46:13.437
\.


--
-- Data for Name: flashcards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flashcards (id, image_url, answer, status, created_at, updated_at) FROM stdin;
1	/uploads/flashcards/2_1.png	八	active	2026-01-05 11:52:56.037	2026-01-05 11:52:56.037
2	/uploads/flashcards/3_1.png	爸爸	active	2026-01-05 11:53:25.542	2026-01-05 11:53:25.542
3	/uploads/flashcards/4_1.png	鼻子	active	2026-01-05 11:53:37.915	2026-01-05 11:53:37.915
4	/uploads/flashcards/5_1.png	不	active	2026-01-05 11:53:53.14	2026-01-05 11:53:53.14
5	/uploads/flashcards/6_1.png	长	active	2026-01-05 11:54:12.091	2026-01-05 11:54:12.091
6	/uploads/flashcards/7_1.png	吃	active	2026-01-05 11:54:26.02	2026-01-05 11:54:26.02
7	/uploads/flashcards/8_1.png	大	active	2026-01-05 11:54:39.634	2026-01-05 11:54:39.634
8	/uploads/flashcards/9_1.png	多	active	2026-01-05 11:54:52.378	2026-01-05 11:54:52.378
9	/uploads/flashcards/10_1.png	点	active	2026-01-05 11:55:40.018	2026-01-05 11:55:59.943
10	/uploads/flashcards/11_1.png	耳朵	active	2026-01-05 11:56:13.107	2026-01-05 11:56:13.107
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.news (id, title, content, start_date, end_date, created_at, updated_at) FROM stdin;
1	ƯU ĐÃI TRẢI NGHIỆM VIP	Mỗi tháng chúng tôi sẽ xét lấy ra 10 người cao nhất theo toàn quốc, theo miền, theo tỉnh để tặng trải nghiệm VIP 1 tháng.\n- Lưu ý: Khuyến mại không cộng dồn tháng	2026-01-06	2030-11-06	2026-01-06 13:42:07.633	2026-01-06 13:42:07.633
\.


--
-- Data for Name: sentence_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sentence_categories (id, name_vi, name_en) FROM stdin;
1	Chào hỏi	Greetings
2	Giới thiệu bản thân	Self Introduction
3	Gia đình	Family
4	Màu sắc	Colors
5	Số đếm	Numbers
6	Thời gian	Time
7	Thời tiết	Weather
8	Thực phẩm	Food
9	Mua sắm	Shopping
10	Giao thông	Transportation
11	Sức khỏe	Health
12	Học tập	Education
13	Công việc	Work
14	Du lịch	Travel
15	Thể thao	Sports
16	Sở thích	Hobbies
17	Cảm xúc	Emotions
18	Địa điểm	Places
19	Mua bán	Buying and Selling
20	Điện thoại và Internet	Phone and Internet
\.


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) FROM stdin;
1	你好	Nǐ hǎo	Xin chào	1
2	早上好	Zǎoshang hǎo	Chào buổi sáng	1
3	晚上好	Wǎnshang hǎo	Chào buổi tối	1
4	再见	Zàijiàn	Tạm biệt	1
5	谢谢	Xièxie	Cảm ơn	1
6	我叫小明	Wǒ jiào Xiǎomíng	Tôi tên là Tiểu Minh	2
7	我来自越南	Wǒ láizì Yuènán	Tôi đến từ Việt Nam	2
8	我今年二十五岁	Wǒ jīnnián èrshíwǔ suì	Năm nay tôi hai mươi lăm tuổi	2
9	我是学生	Wǒ shì xuésheng	Tôi là sinh viên	2
10	很高兴认识你	Hěn gāoxìng rènshi nǐ	Rất vui được làm quen với bạn	2
11	这是我的家人	Zhè shì wǒ de jiārén	Đây là gia đình tôi	3
12	我有两个兄弟	Wǒ yǒu liǎng gè xiōngdì	Tôi có hai người anh em	3
13	我父母很健康	Wǒ fùmǔ hěn jiànkāng	Bố mẹ tôi rất khỏe mạnh	3
14	我姐姐是老师	Wǒ jiějie shì lǎoshī	Chị gái tôi là giáo viên	3
15	我们一家人很幸福	Wǒmen yījiārén hěn xìngfú	Gia đình chúng tôi rất hạnh phúc	3
16	我喜欢红色	Wǒ xǐhuan hóngsè	Tôi thích màu đỏ	4
17	天空是蓝色的	Tiānkōng shì lánsè de	Bầu trời màu xanh	4
18	这朵花是黄色的	Zhè duǒ huā shì huángsè de	Bông hoa này màu vàng	4
19	黑色是我的最爱	Hēisè shì wǒ de zuì ài	Màu đen là màu yêu thích của tôi	4
20	白色代表纯洁	Báisè dàibiǎo chúnjié	Màu trắng tượng trưng cho sự trong trắng	4
21	一加一等于二	Yī jiā yī děngyú èr	Một cộng một bằng hai	5
22	我有三个苹果	Wǒ yǒu sān gè píngguǒ	Tôi có ba quả táo	5
23	今天是五月十五号	Jīntiān shì wǔyuè shíwǔ hào	Hôm nay là ngày mười lăm tháng năm	5
24	这本书有五百页	Zhè běn shū yǒu wǔbǎi yè	Cuốn sách này có năm trăm trang	5
25	我买了十支笔	Wǒ mǎile shí zhī bǐ	Tôi đã mua mười cây bút	5
26	现在几点了？	Xiànzài jǐ diǎn le?	Bây giờ mấy giờ rồi?	6
27	我每天早上七点起床	Wǒ měitiān zǎoshang qī diǎn qǐchuáng	Mỗi sáng tôi thức dậy lúc bảy giờ	6
28	今天是星期一	Jīntiān shì xīngqīyī	Hôm nay là thứ Hai	6
29	我们下个月去旅行	Wǒmen xià gè yuè qù lǚxíng	Tháng sau chúng tôi sẽ đi du lịch	6
30	会议在下午三点开始	Huìyì zài xiàwǔ sān diǎn kāishǐ	Cuộc họp bắt đầu lúc ba giờ chiều	6
31	今天天气很好	Jīntiān tiānqì hěn hǎo	Hôm nay thời tiết rất đẹp	7
32	外面在下雨	Wàimiàn zài xià yǔ	Bên ngoài đang mưa	7
33	今天很热	Jīntiān hěn rè	Hôm nay rất nóng	7
34	冬天很冷	Dōngtiān hěn lěng	Mùa đông rất lạnh	7
35	明天会晴天	Míngtiān huì qíngtiān	Ngày mai sẽ nắng	7
36	我想吃面条	Wǒ xiǎng chī miàntiáo	Tôi muốn ăn mì	8
37	这个菜很好吃	Zhè gè cài hěn hǎochī	Món ăn này rất ngon	8
38	我喜欢吃水果	Wǒ xǐhuan chī shuǐguǒ	Tôi thích ăn trái cây	8
39	请给我一杯水	Qǐng gěi wǒ yī bēi shuǐ	Xin cho tôi một cốc nước	8
40	我不喜欢吃辣的	Wǒ bù xǐhuan chī là de	Tôi không thích ăn cay	8
41	这件衣服多少钱？	Zhè jiàn yīfu duōshao qián?	Bộ quần áo này bao nhiêu tiền?	9
42	我可以试穿吗？	Wǒ kěyǐ shìchuān ma?	Tôi có thể thử được không?	9
43	太贵了，能便宜点吗？	Tài guì le, néng piányi diǎn ma?	Đắt quá, có thể rẻ hơn một chút không?	9
44	我要买这个	Wǒ yào mǎi zhè gè	Tôi muốn mua cái này	9
45	可以用信用卡吗？	Kěyǐ yòng xìnyòngkǎ ma?	Có thể dùng thẻ tín dụng không?	9
46	我要去机场	Wǒ yào qù jīchǎng	Tôi muốn đi đến sân bay	10
47	怎么去火车站？	Zěnme qù huǒchēzhàn?	Làm sao để đến ga tàu?	10
48	我坐公交车上班	Wǒ zuò gōngjiāochē shàngbān	Tôi đi xe buýt đi làm	10
49	请开慢一点	Qǐng kāi màn yīdiǎn	Xin lái chậm một chút	10
50	这里可以停车吗？	Zhèlǐ kěyǐ tíngchē ma?	Ở đây có thể đỗ xe không?	10
51	我头疼	Wǒ tóuténg	Tôi bị đau đầu	11
52	你需要去看医生	Nǐ xūyào qù kàn yīshēng	Bạn cần đi khám bác sĩ	11
53	我感冒了	Wǒ gǎnmào le	Tôi bị cảm	11
54	多喝水，多休息	Duō hē shuǐ, duō xiūxi	Uống nhiều nước, nghỉ ngơi nhiều	11
55	我感觉好多了	Wǒ gǎnjué hǎo duō le	Tôi cảm thấy khỏe hơn nhiều rồi	11
56	我在学中文	Wǒ zài xué Zhōngwén	Tôi đang học tiếng Trung	12
57	这个字怎么写？	Zhè gè zì zěnme xiě?	Chữ này viết như thế nào?	12
58	请再说一遍	Qǐng zài shuō yībiàn	Xin nói lại một lần nữa	12
59	我明天有考试	Wǒ míngtiān yǒu kǎoshì	Ngày mai tôi có bài thi	12
60	你作业做完了吗？	Nǐ zuòyè zuòwán le ma?	Bạn đã làm xong bài tập chưa?	12
61	我是工程师	Wǒ shì gōngchéngshī	Tôi là kỹ sư	13
62	我九点上班	Wǒ jiǔ diǎn shàngbān	Tôi đi làm lúc chín giờ	13
63	今天工作很忙	Jīntiān gōngzuò hěn máng	Hôm nay công việc rất bận	13
64	我下班了	Wǒ xiàbān le	Tôi đã tan làm	13
65	这个项目很重要	Zhè gè xiàngmù hěn zhòngyào	Dự án này rất quan trọng	13
66	我想去北京旅游	Wǒ xiǎng qù Běijīng lǚyóu	Tôi muốn đi du lịch Bắc Kinh	14
67	这里风景很美	Zhèlǐ fēngjǐng hěn měi	Cảnh đẹp ở đây rất đẹp	14
68	我要订一个房间	Wǒ yào dìng yī gè fángjiān	Tôi muốn đặt một phòng	14
69	请给我一张地图	Qǐng gěi wǒ yī zhāng dìtú	Xin cho tôi một tấm bản đồ	14
70	这个城市很有名	Zhè gè chéngshì hěn yǒumíng	Thành phố này rất nổi tiếng	14
71	我喜欢打篮球	Wǒ xǐhuan dǎ lánqiú	Tôi thích chơi bóng rổ	15
72	我每天跑步	Wǒ měitiān pǎobù	Tôi chạy bộ mỗi ngày	15
73	足球比赛很精彩	Zúqiú bǐsài hěn jīngcǎi	Trận đấu bóng đá rất hay	15
74	我要去健身房	Wǒ yào qù jiànshēnfáng	Tôi muốn đi phòng gym	15
75	运动对身体好	Yùndòng duì shēntǐ hǎo	Tập thể dục tốt cho sức khỏe	15
76	我喜欢听音乐	Wǒ xǐhuan tīng yīnyuè	Tôi thích nghe nhạc	16
77	我爱好读书	Wǒ àihào dúshū	Tôi thích đọc sách	16
78	周末我喜欢看电影	Zhōumò wǒ xǐhuan kàn diànyǐng	Cuối tuần tôi thích xem phim	16
79	我会弹钢琴	Wǒ huì tán gāngqín	Tôi biết chơi đàn piano	16
80	画画是我的爱好	Huàhuà shì wǒ de àihào	Vẽ tranh là sở thích của tôi	16
81	我很高兴	Wǒ hěn gāoxìng	Tôi rất vui	17
82	我有点累	Wǒ yǒudiǎn lèi	Tôi hơi mệt	17
83	我很担心	Wǒ hěn dānxīn	Tôi rất lo lắng	17
84	这让我很生气	Zhè ràng wǒ hěn shēngqì	Điều này làm tôi rất tức giận	17
85	我感到很放松	Wǒ gǎndào hěn fàngsōng	Tôi cảm thấy rất thư giãn	17
86	银行在哪里？	Yínháng zài nǎlǐ?	Ngân hàng ở đâu?	18
87	我要去图书馆	Wǒ yào qù túshūguǎn	Tôi muốn đi thư viện	18
88	医院在那边	Yīyuàn zài nàbiān	Bệnh viện ở đằng kia	18
89	学校离这里很远	Xuéxiào lí zhèlǐ hěn yuǎn	Trường học cách đây rất xa	18
90	超市在左边	Chāoshì zài zuǒbiān	Siêu thị ở bên trái	18
91	我想卖这辆车	Wǒ xiǎng mài zhè liàng chē	Tôi muốn bán chiếc xe này	19
92	这个价格合理吗？	Zhè gè jiàgé hélǐ ma?	Giá này có hợp lý không?	19
93	我要买新手机	Wǒ yào mǎi xīn shǒujī	Tôi muốn mua điện thoại mới	19
94	可以打折吗？	Kěyǐ dǎzhé ma?	Có thể giảm giá không?	19
95	我付现金	Wǒ fù xiànjīn	Tôi trả bằng tiền mặt	19
96	你的电话号码是多少？	Nǐ de diànhuà hàomǎ shì duōshao?	Số điện thoại của bạn là bao nhiêu?	20
97	请给我发微信	Qǐng gěi wǒ fā Wēixìn	Xin gửi cho tôi tin nhắn WeChat	20
98	网络连接不好	Wǎngluò liánjiē bù hǎo	Kết nối mạng không tốt	20
99	我要下载这个应用	Wǒ yào xiàzài zhè gè yìngyòng	Tôi muốn tải ứng dụng này	20
100	请加我微信	Qǐng jiā wǒ Wēixìn	Xin thêm tôi vào WeChat	20
\.


--
-- Data for Name: user_daily_scores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_daily_scores (id, user_id, score, score_date, created_at, updated_at) FROM stdin;
1	2	11	2026-01-04	2026-01-05 11:45:14.87	2026-01-05 11:57:24.391
20	4	13	2026-01-06	2026-01-06 12:34:35.036	2026-01-06 12:36:26.434
33	4	4	2026-01-07	2026-01-07 12:44:39.652	2026-01-07 12:45:23.958
\.


--
-- Data for Name: user_monthly_scores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_monthly_scores (id, user_id, score, month_cycle, created_at, updated_at) FROM stdin;
1	2	21	2026-01	2026-01-05 11:45:14.887	2026-01-05 12:16:23.685
13	4	54	2026-01	2026-01-06 12:21:27.311	2026-01-07 12:46:13.495
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, username, email, password_hash, created_at, role, email_confirmed, verification_code, verification_code_expires_at, account_status, account_type, must_set_password, reset_code, reset_code_expires_at, image_url, address, province, region, xp, streak_days) FROM stdin;
2	Nguyen Toan	toannguyentien10091998@gmail.com	$2b$10$5Yc0roYITIdLfyI7zn2MH.EzCwEek/cSLh1R5DpyWE28WfeSvEKK6	2026-01-05 11:38:49.944	admin	t	\N	\N	normal	google	f	\N	\N	\N		Bắc Ninh	bac	0	0
3	Dev Capybara	capybaradev2004@gmail.com	$2b$10$/fJXe1MCfrmdYqM10Sl3.eUFN0RRulN0wKAvshBPUmaasWDKXnYbG	2026-01-05 12:47:31.37	customer	t	\N	\N	vip	google	f	\N	\N	\N	\N	\N	bac	0	0
4	Toán Nguyễn	toannguyentien28022004@gmail.com	$2b$10$M3diGKavYdpH6TljdwjbReZwuU0VTeDp.6EHeXBWcFgSywV1.zRQm	2026-01-06 12:09:17.768	admin	t	\N	\N	normal	google	f	\N	\N	\N		Hà Nội	bac	0	0
\.


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) FROM stdin;
1275	固然	gùrán	tất nhiên, cố nhiên	\N	34
766	坚定	jiāndìng	kiên định, vững vàng	\N	34
1510	建筑	jiànzhù	tòa nhà	\N	34
1533	教训	jiàoxùn	giáo huấn, dạy bảo	\N	40
2443	启示	qǐshì	gợi ý, gợi cho biết	\N	40
2760	示范	shìfàn	gương sáng, gương tốt	\N	34
1	…分之…	…fēn zhī…	chi nhánh, phần (trăm)	\N	34
463	成熟	chéngshú	thành thục, trưởng thành, chín chắn	\N	30
620	磋商	cuōshāng	bàn bạc, hội ý, trao đổi	\N	40
1793	举世瞩目	jǔshì zhǔmù	thu hút sự chú ý trên toàn thế giới	\N	30
2803	实事求是	shíshìqiúshì	thật thà cầu thị	\N	24
2825	收益	shōuyì	lợi nhuận, thu lợi	\N	30
2947	台	tái	đài, bệ, sân khấu, chiếc	\N	24
3042	停留	tíngliú	dừng lại, ở lại	\N	40
3403	形状	xíngzhuàng	hình dáng, hình dạng	\N	31
3557	烟花爆竹	yānhuā bàozhú	pháo hoa, pháo nổ	\N	25
3829	预兆	yùzhào	điềm báo, dấu hiệu	\N	21
2	啊	a	a, à, ừ, ờ	\N	35
4196	醉	zuì	say rượu, bia	\N	26
1132	工夫	gōngfū	thời gian, người làm thuê, công sức, rảnh rỗi	\N	30
1330	合成	héchéng	hợp thành, câu thành	\N	24
3	呵	ā	ơ, ới, ui, ui cha	\N	34
4	爱	ài	yêu	\N	34
5	矮	ǎi	thấp	\N	34
6	唉	āi	ôi, than ôi, trời ơi	\N	34
7	挨	ái	bị, chịu đựng, gặp phải	\N	34
69	绑架	bǎngjià	bắt cóc	\N	34
8	爱不释手	àibùshìshǒu	quyến luyến không rời	\N	34
796	顶	dǐng	đỉnh	\N	40
9	爱戴	àidài	yêu quý, kính yêu	\N	34
10	爱好	àihào	yêu thích, thích	\N	34
585	出租车	chūzūchē	Taxi	\N	40
11	爱护	àihù	yêu quý, bảo vệ	\N	34
1098	哥	gē	anh	\N	31
12	暧昧	àimèi	mập mờ, mờ ám	\N	34
13	爱情	àiqíng	tình yêu	\N	22
1005	分	fēn	phần, suất	\N	30
14	爱惜	àixī	yêu quý, quý trọng	\N	34
1478	寄	jì	gửi	\N	40
15	爱心	àixīn	lòng nhân ái, yêu thương	\N	40
16	哎哟	āiyō	ôi, ôi chao	\N	34
17	癌症	áizhèng	ung thư	\N	30
18	岸	àn	bờ (sông, biển)	\N	34
1212	管子	guǎnzi	ống	\N	34
19	暗	àn	tối, u ám, thầm, vụng trộm	\N	34
20	按	àn	ấn, bấm	\N	34
2002	另	lìng	khác	\N	30
21	案件	ànjiàn	án vụ, trường hợp, án kiện	\N	34
22	安居乐业	ānjūlèyè	an cư lạc nghiệp	\N	31
23	案例	ànlì	án lệ	\N	31
24	按摩	ànmó	xoa bóp	\N	34
25	按时	ànshí	đúng giờ	\N	34
26	按照	ànzhào	căn cứ theo	\N	34
1214	孤单	gūdān	cô đơn	\N	34
27	安排	ānpái	sắp xếp, bố trí	\N	40
28	安全	ānquán	an toàn	\N	34
29	暗示	ànshì	ám thị, ra hiệu	\N	40
30	案	àn	vụ, án, hồ sơ	\N	34
31	安慰	ānwèi	an ủi	\N	31
32	安详	ānxiáng	êm đềm	\N	21
1321	毫米	háomǐ	milimet	\N	26
1322	好奇	hàoqí	hiếu kỳ	\N	40
1428	汇报	huìbào	báo cáo	\N	34
33	按着	ànzhe	căn cứ, dựa theo	\N	34
4064	粥	zhōu	cháo	\N	34
35	安装	ānzhuāng	lắp đặt	\N	33
52	百	bǎi	trăm	\N	21
57	拜年	bàinián	đi chúc tết	\N	36
65	颁发	bānfā	ban phát	\N	31
66	棒	bàng	gậy	\N	28
34	安置	ànzhì	bố trí ổn thỏa, ổn định	\N	34
36	熬	áo	sắc, hầm	\N	34
37	奥秘	àomì	huyền bí, bí ẩn	\N	40
38	凹凸	āotū	lồi lõm, gồ ghề	\N	34
39	阿姨	Āyí	cô, dì	\N	34
40	吧	ba	nhé, nha	\N	35
41	把	bǎ	lấy, đem	\N	35
42	拔	bá	nhổ, rút ra	\N	34
43	疤	bā	vết sẹo	\N	34
44	爸爸	bàba	bố	\N	34
45	巴不得	bābùdé	ước gì, chỉ mong	\N	35
46	霸道	bàdào	bá đạo, độc tài, chuyên chế	\N	34
47	罢工	bàgōng	đình công	\N	34
49	白	bái	trắng	\N	34
50	摆	bǎi	xếp đặt, bày biện	\N	40
51	柏	bǎi	trầm	\N	34
53	拜	bài	bái, lạy, thờ	\N	40
54	拜访	bàifǎng	đến thăm	\N	34
55	百分点	bǎifēndiǎn	điểm phần trăm	\N	21
56	败坏	bàihuài	hư hỏng	\N	34
58	拜托	bàituō	xin nhờ, kính nhờ	\N	34
59	摆脱	bǎituō	thoát khỏi	\N	34
60	白日梦	báirìmèng	mộng ban ngày	\N	34
61	班	bān	lớp	\N	34
62	版本	bǎnběn	phiên bản	\N	34
63	颁布	bānbù	ban hành	\N	34
64	办法	bànfǎ	biện pháp, cách	\N	40
67	帮	bāng	băng, nhóm	\N	34
68	帮忙	bāngmáng	giúp, giúp đỡ	\N	34
121	保管	bǎoguǎn	bảo quản	\N	27
80	膀胱	bǎngguāng	bàng quang	\N	27
97	报社	bàoshè	tòa soạn, tòa báo	\N	21
84	包庇	bāobì	bao che, che đậy	\N	27
87	宝贵	bǎoguì	quý giá	\N	37
88	包含	bāohán	chứa, bao gồm	\N	27
91	保险	bǎoxiǎn	bảo hiểm	\N	21
119	保姆	bǎomǔ	bảo mẫu, người giúp việc	\N	24
151	奔波	bēnbō	bôn ba	\N	21
117	报答	bàodá	đền đáp	\N	33
71	傍晚	bàngwǎn	xẩm tối	\N	34
72	榜样	bǎngyàng	tấm gương	\N	34
73	帮助	bāngzhù	giúp đỡ, hỗ trợ	\N	34
74	办理	bànlǐ	xử lý	\N	40
75	办事	bànshì	làm việc	\N	40
76	伴侣	bànlǚ	bạn đời, bạn đồng hành	\N	34
78	班主任	bānzhǔrèn	giáo viên chủ nhiệm	\N	34
79	板	bǎn	ván, tấm ván	\N	34
81	抱	bào	ôm, bế	\N	34
82	包	bāo	bọc, túi, gói	\N	27
83	宝贝	bǎobèi	bảo bối, cưng	\N	34
96	暴露	bàolù	bộc lộ	\N	34
85	保持	bǎochí	duy trì, giữ gìn	\N	40
86	保护	bǎohù	bảo vệ	\N	34
123	暴风	bàofēng	bão tố	\N	30
109	包装	bāozhuāng	gói, bọc	\N	40
90	暴力	bàolì	bạo lực	\N	34
155	崩发	bēngfā	bùng ra, phát nổ	\N	40
92	保守	bǎoshǒu	bảo thủ	\N	30
93	保卫	bǎowèi	bảo vệ, ủng hộ	\N	34
94	报名	bàomíng	báo danh, đăng ký	\N	34
95	报告	bàogào	báo cáo, thông báo	\N	34
163	本身	běnshēn	tự bản thân	\N	27
166	本质	běnzhì	bản chất	\N	31
98	报酬	bàochou	thù lao, tiền công	\N	34
99	报纸	bàozhǐ	báo chí	\N	34
100	包裹	bāoguǒ	bưu kiện	\N	40
101	包容	bāoróng	khoan dung, bao dung	\N	34
102	报仇	bàochóu	báo thù	\N	30
104	抱怨	bàoyuàn	oán hận, phàn nàn	\N	34
105	保证	bǎozhèng	đảm bảo	\N	34
106	保重	bǎozhòng	bảo trọng, cẩn thận	\N	34
107	报复	bàofù	trả thù	\N	30
108	报负	bàofù	hoài bão, tham vọng	\N	34
111	报销	bàoxiāo	thanh toán	\N	34
110	报关	bàoguān	khai hải quan	\N	40
112	保安	bǎo’ān	bảo vệ an ninh	\N	40
113	保佑	bǎoyòu	phù hộ	\N	34
114	保障	bǎozhàng	đảm bảo	\N	34
115	保养	bǎoyǎng	bảo dưỡng	\N	34
118	爆炸	bàozhà	nổ, bùng nổ	\N	34
120	暴雨	bàoyǔ	mưa to	\N	30
122	宝石	bǎoshí	đá quý	\N	21
124	保证金	bǎozhèngjīn	tiền bảo chứng	\N	34
125	保存	bǎocún	bảo tồn, lưu giữ	\N	34
126	包子	bāozi	bánh bao	\N	34
128	把戏	bǎxì	xiếc, trò lừa bịp	\N	35
129	倍	bèi	lần, gấp bội	\N	40
130	被	bèi	bị, được	\N	35
131	背	bèi	lưng, học thuộc	\N	34
132	背诵	bèisòng	đọc thuộc lòng	\N	34
133	悲哀	bēi’āi	bi ai, đau buồn	\N	34
135	悲惨	bēicǎn	bi thảm	\N	34
136	被动	bèidòng	bị động	\N	35
137	北方	běifāng	miền Bắc	\N	40
138	备份	bèifèn	dành riêng, bản dự phòng	\N	34
139	被告	bèigào	bị cáo	\N	35
140	悲观	bēiguān	bi quan	\N	40
141	北极	běijí	bắc cực	\N	21
143	北京	běijīng	Bắc Kinh	\N	21
144	贝壳	bèiké	vỏ sò, vỏ ốc	\N	34
145	背叛	bèipàn	phản bội	\N	40
146	备忘录	bèiwànglù	bản ghi nhớ	\N	34
147	被子	bèizi	chăn	\N	35
148	杯子	bēizi	cốc, chén, ly, tách	\N	34
149	笨	bèn	đần, ngốc	\N	34
150	本	běn	quyển, gốc, vốn, thân	\N	34
153	甭	béng	không cần	\N	34
154	蹦	bèng	nhảy, bật, tung ra	\N	40
156	崩溃	bēngkuì	tan vỡ, sụp đổ	\N	34
157	本科	běnkē	khoa chính quy	\N	34
158	本来	běnlái	vốn dĩ, lúc đầu, đáng lẽ	\N	40
159	本领	běnlǐng	bản lĩnh, khả năng	\N	34
160	本能	běnnéng	bản năng	\N	34
161	本钱	běnqián	vốn	\N	34
162	本人	běnrén	bản thân, tôi	\N	34
164	本事	běnshi	khả năng, bản lĩnh	\N	34
165	本着	běnzhe	căn cứ, dựa vào	\N	40
167	笨拙	bènzhuō	vụng về	\N	40
168	臂	bì	cánh tay	\N	34
170	便	biàn	ngay cả, đủ cho, liền	\N	40
171	遍	biàn	lần, khắp	\N	21
172	编	biān	dệt, biên soạn	\N	34
173	遍布	biànbù	phân bố, rải rác	\N	40
174	鞭策	biāncè	thúc giục	\N	30
175	贬低	biǎndī	chê bai, hạ thấp	\N	34
182	边界	biānjiè	ranh giới	\N	30
248	闭塞	bìsè	tắc nghẽn, bế tắc	\N	27
190	贬义	biǎnyì	nghĩa xấu	\N	24
203	表决	biǎojué	biểu quyết, bầu	\N	24
217	必定	bìdìng	nhất định, chắc chắn	\N	31
224	别致	biézhì	độc đáo, mới mẻ, khác thường	\N	30
226	比较	bǐjiào	so với, so sánh	\N	22
230	避免	bìmiǎn	tránh	\N	26
234	病毒	bìngdú	vi rút	\N	24
255	鼻子	bízi	mũi	\N	24
245	必要	bìyào	cần	\N	31
177	辩护	biànhù	biện hộ, bảo vệ	\N	34
178	变化	biànhuà	thay đổi	\N	34
179	编辑	biānjí	biên tập, chỉnh sửa	\N	40
180	边疆	biānjiāng	biên giới	\N	34
181	辩解	biànjiě	biện giải, giải thích	\N	40
183	边境	biānjìng	biên giới	\N	34
184	便利	biànlì	tiện lợi	\N	34
185	辩论	biànlùn	tranh luận	\N	40
186	鞭炮	biānpào	pháo hoa, pháo nổ	\N	34
187	变迁	biànqiān	thay đổi, biến đổi	\N	34
188	辨认	biànrèn	nhận rõ, phân biệt	\N	40
189	便条	biàntiáo	giấy nhắn	\N	40
191	便于	biànyú	tiện lợi, tiện cho	\N	40
193	辩证	biànzhèng	biện chứng	\N	34
194	变质	biànzhì	biến chất, hư hỏng	\N	34
195	编织	biānzhī	bện, đan, tết	\N	34
196	辫子	biànzi	bím tóc	\N	34
197	标本	biāoběn	mẫu, tiêu bản	\N	40
198	表达	biǎodá	biểu đạt, diễn tả	\N	40
199	标点	biāodiǎn	chấm câu	\N	34
200	表格	biǎogé	bảng, biểu	\N	40
201	表哥	biǎogē	anh họ	\N	34
204	表面	biǎomiàn	mặt ngoài, bề ngoài	\N	34
205	表明	biǎomíng	tỏ rõ, chứng tỏ	\N	34
206	表情	biǎoqíng	biểu cảm, nét mặt	\N	34
207	表演	biǎoyǎn	biểu diễn	\N	40
208	表彰	biǎozhāng	tuyên dương, khen ngợi	\N	34
209	表示	biǎoshì	biểu thị	\N	40
210	表态	biǎotài	bày tỏ thái độ	\N	21
211	表扬	biǎoyáng	khen ngợi	\N	34
212	标志	biāozhì	cột mốc, ký hiệu	\N	40
213	标准	biāozhǔn	tiêu chuẩn	\N	40
215	彼此	bǐcǐ	lẫn nhau	\N	24
216	便签	biànqiān	giấy ghi nhớ	\N	34
218	弊端	bìduān	tệ nạn, tai hại	\N	40
219	别	bié	khác, chia lìa	\N	21
220	憋	biē	bịt, nín, kim nén	\N	40
221	别扭	bièniu	khó chịu, chướng, kỳ quặc	\N	34
222	别人	biérén	người khác	\N	34
223	别墅	biéshù	biệt thự	\N	30
225	比方	bǐfāng	ví, so sánh, so bì	\N	34
228	毕竟	bìjìng	rốt cuộc, cuối cùng	\N	34
229	比例	bǐlì	tỷ lệ	\N	21
231	丙	bǐng	thứ ba, Bính	\N	21
232	冰雹	bīngbáo	mưa đá	\N	30
233	并存	bìngcún	cùng tồn tại	\N	34
235	并非	bìngfēi	không	\N	34
236	饼干	bǐnggān	bánh quy	\N	34
238	并且	bìngqiě	đồng thời, và, hơn nữa	\N	34
239	并行	bìngxíng	song hành, song song	\N	34
240	宾馆	bīnguǎn	nhà khách, khách sạn	\N	30
241	冰箱	bīngxiāng	tủ lạnh, tủ đá	\N	34
242	冰激凌	bīngjīlíng	kem	\N	21
243	滨临	bīnlín	kề bên, kề cận	\N	34
244	摈弃	bìnqì	từ bỏ, vứt bỏ	\N	34
246	比如	bǐrú	ví dụ như, chẳng hạn như	\N	30
247	比赛	bǐsài	thi đấu	\N	24
249	泌	bì	tiết (chất lỏng)	\N	34
251	毕业	bìyè	tốt nghiệp	\N	34
252	碧玉	bìyù	ngọc bích	\N	34
253	比喻	bǐyù	ví dụ, ví von	\N	34
254	比重	bǐzhòng	tỷ trọng	\N	34
256	拨打	bōdǎ	gọi (điện thoại)	\N	34
257	博大精深	bódàjīngshēn	uyên bác, uyên thâm	\N	34
258	搏斗	bódòu	vật lộn	\N	34
259	播放	bōfàng	truyền, phát, đưa tin	\N	40
260	波浪	bōlàng	sóng	\N	34
262	玻璃	bōli	thủy tinh	\N	30
263	伯母	bómǔ	bác gái	\N	21
264	博士	bóshì	tiến sĩ	\N	40
265	波涛汹涌	bōtāoxiōngyǒng	sóng cuộn trào dâng	\N	34
266	博物馆	bówùguǎn	viện bảo tàng	\N	34
267	剥削	bōxuē	bóc lột, lợi dụng	\N	34
268	播种	bōzhòng	gieo hạt	\N	40
269	布	bù	vải	\N	40
270	不	bù	không, chưa	\N	34
273	不好意思	bùhǎoyìsi	cảm thấy xấu hổ	\N	34
279	不少	bùshǎo	không ít	\N	34
280	不耐烦	bù nàifán	nóng nảy, sốt ruột	\N	34
281	不相上下	bù xiāng shàngxià	ngang nhau	\N	24
282	不像话	bù xiànghuà	chẳng ra làm sao cả	\N	34
284	不安	bù’ān	bất an, lo lắng	\N	21
294	部分	bùfèn	bộ phận	\N	30
321	擦	cā	lau chùi, chà, cọ	\N	24
323	菜单	càidān	thực đơn	\N	30
335	财务	cáiwù	tài vụ	\N	24
342	参观	cānguān	tham quan	\N	27
343	残疾	cánjí	tàn tật	\N	31
344	参加	cānjiā	tham gia	\N	40
349	残留	cánliú	còn lại	\N	25
357	操劳	cāoláo	làm việc chăm chỉ	\N	40
275	不仅	bùjǐn	không những, không chỉ	\N	34
276	不免	bùmiǎn	không tránh được	\N	34
277	不然	bùrán	nếu không thì	\N	34
278	不如	bùrú	không bằng	\N	34
377	差不多	chàbuduō	xấp xỉ, gần giống nhau	\N	30
285	不必	bùbì	không cần	\N	34
286	补充	bǔchōng	bổ sung	\N	34
287	不但	bùdàn	không những	\N	35
288	不得不	bùdébù	không thể không	\N	35
289	不得了	bùdéliǎo	cực kỳ	\N	35
291	不断	bùduàn	thường xuyên, không ngừng	\N	34
292	步伐	bùfá	tiến độ, nhịp bước	\N	34
293	不妨	bùfáng	đừng ngại, không sao	\N	34
379	柴油	cháiyóu	dầu diesel	\N	24
295	不顾	bùgù	không cần biết đến, bất cần	\N	34
296	不管	bùguǎn	cho dù, bất luận	\N	40
297	不过	bùguò	nhưng, chẳng qua	\N	34
298	不禁	bùjīn	không nhịn được, không nén nổi	\N	34
299	不久	bùjiǔ	bổ cứu, cứu vãn	\N	34
300	布局	bùjú	bố cục	\N	34
301	不堪	bùkān	không chịu nổi	\N	34
303	不愧	bùkuì	xứng đáng	\N	34
304	部落	bùluò	bộ lạc	\N	34
305	部门	bùmén	bộ, ngành	\N	34
306	哺乳	bǔrǔ	nuôi bằng sữa mẹ	\N	34
307	不时	bùshí	đôi khi, thỉnh thoảng	\N	34
308	部署	bùshǔ	sắp xếp, bố trí	\N	40
309	补贴	bǔtiē	tiền trợ cấp	\N	34
310	部位	bùwèi	bộ vị, vị trí	\N	34
311	不惜	bùxī	ngần ngại, không tiếc	\N	34
312	不屑一顾	bùxiè yī gù	không đáng xem	\N	34
313	不药而愈	bùyào ér yù	không sao đâu	\N	35
314	不由得	bùyóude	không được, đành phải	\N	35
316	布置	bùzhì	sắp xếp	\N	40
317	不止	bùzhǐ	không ngớt, không dứt	\N	34
318	步骤	bùzhòu	bước đi, trình tự	\N	34
319	捕捉	bǔzhuō	bắt, tóm, chụp	\N	34
320	不足	bùzú	không đủ	\N	34
322	才	cái	mới (động tác diễn ra muộn)	\N	40
324	采访	cǎifǎng	phỏng vấn, săn tin	\N	34
325	裁缝	cáiféng	thợ may	\N	34
326	财富	cáifù	sự giàu có	\N	34
327	才干	cáigàn	năng lực, tài cán	\N	34
328	采购	cǎigòu	mua, thu mua	\N	30
329	才华	cáihuá	tài năng	\N	34
331	采纳	cǎinà	tiếp nhận, tiếp thu	\N	40
332	裁判	cáipàn	trọng tài	\N	34
333	彩票	cǎipiào	vé số	\N	34
334	采取	cǎiqǔ	lấy, áp dụng	\N	40
337	财政	cáizhèng	tài chính	\N	38
338	舱	cāng	khoang, buồng	\N	34
339	苍白	cāngbái	tái nhợt	\N	34
340	仓促	cāngcù	vội vàng	\N	34
341	仓库	cāngkù	kho	\N	34
345	参考	cānkǎo	tham khảo	\N	34
346	残酷	cánkù	tàn khốc, tàn bạo	\N	34
347	惭愧	cánkuì	xấu hổ	\N	34
348	灿烂	cànlàn	sáng lạng, rực rỡ	\N	34
351	餐厅	cāntīng	phòng ăn, nhà ăn	\N	34
352	参与	cānyù	tham dự	\N	35
353	参照	cānzhào	tham chiếu, bắt trước	\N	34
354	草	cǎo	cỏ	\N	34
355	草案	cǎo’àn	bản thảo	\N	34
356	操场	cāochǎng	sân vận động, bãi tập	\N	34
358	操练	cāoliàn	luyện tập	\N	34
359	草率	cǎoshuài	qua loa, đại khái	\N	34
360	操心	cāoxīn	bận tâm, lo lắng	\N	34
361	嘈杂	cáozá	ồn ào	\N	34
362	操纵	cāozòng	điều khiển, thao túng	\N	34
363	操作	cāozuò	thao tác	\N	34
364	册	cè	sổ, quyển, tập	\N	34
366	测量	cèliáng	đo lường	\N	34
367	策略	cèlüè	sách lược	\N	34
368	侧面	cèmiàn	mặt bên	\N	34
369	层	céng	tầng	\N	31
371	曾经	céngjīng	từng, đã từng	\N	34
372	厕所	cèsuǒ	nhà vệ sinh	\N	35
373	测验	cèyàn	kiểm tra, trắc nghiệm	\N	40
374	茶	chá	trà	\N	26
375	叉	chā	que, ngạnh, rẽ	\N	34
376	差别	chābié	khác nhau	\N	24
378	插座	chāzuò	stổ cắm điện	\N	34
1642	计划	jìhuà	kế hoạch	\N	34
385	产品	chǎnpǐn	sản phẩm	\N	38
415	缠绕	chánrào	quấn, quấn quanh	\N	27
401	尝	cháng	thường thức	\N	34
430	叉子	chāzi	cái nĩa	\N	25
390	长	zhǎng	tăng lên	\N	40
437	秤	chèng	cái cân	\N	31
438	城市	chéngshì	thành phố	\N	29
381	拆	chāi	tháo, gỡ	\N	34
382	拆迁	chāiqiān	di dời, giải tỏa	\N	34
383	缠	chán	vướng, quấn, dây dưa	\N	40
384	馋	chán	ham ăn, tham ăn	\N	34
452	成交	chéngjiāo	giao dịch	\N	37
464	成天	chéngtiān	suốt ngày, cả ngày	\N	30
388	颤抖	chàndǒu	run rẩy	\N	40
389	昌盛	chāngshèng	hưng thịnh, hưng vượng	\N	34
472	乘坐	chéngzuò	đi, cưỡi (tàu, xe, máy bay…)	\N	28
391	常	cháng	thường	\N	34
392	场	chǎng	nơi, bãi, cuộc, trận	\N	34
393	厂	chǎng	xưởng, nhà máy	\N	34
394	长城	chángchéng	Trường Thành	\N	34
395	长处	chángchù	ưu điểm	\N	40
396	长短	chángduǎn	dài ngắn	\N	34
397	长江	chángjiāng	Trường Giang	\N	34
398	常识	chángshí	kiến thức phổ thông	\N	34
399	唱	chàng	hát	\N	31
400	唱歌	chànggē	hát	\N	31
477	沉思	chénsī	suy ngẫm, trầm tư	\N	28
403	偿还	chánghuán	trả nợ, bồi hoàn	\N	40
404	敞开	chǎngkāi	mở rộng, thoải mái	\N	34
405	猖狂	chāngkuáng	ngang ngược, điên cuồng	\N	34
406	场面	chǎngmiàn	tình cảnh	\N	26
407	常年	chángnián	quanh năm, lâu dài, hằng năm	\N	40
408	尝试	chángshì	thử	\N	30
409	场所	chǎngsuǒ	nơi	\N	35
410	畅通	chàngtōng	thông suốt, trôi chảy	\N	34
411	长途	chángtú	dài, đường dài	\N	34
412	常务	chángwù	thường vụ	\N	34
413	长袖	chángxiù	bánh chay	\N	40
387	产业	chǎnyè	sản nghiệp, ngành nghề	\N	34
416	展示	zhǎnshì	trình bày, biểu hiện	\N	40
417	朝	cháo	ngoảnh mặt về, hướng về	\N	40
418	吵	chǎo	ồn ào, tranh cãi	\N	34
419	炒	chǎo	xào, rang	\N	34
420	抄	chāo	copy, sao chép	\N	34
421	超越	chāoyuè	vượt qua	\N	34
422	朝代	cháodài	triều đại	\N	40
423	超出	chāochū	vượt quá, vượt lên	\N	40
424	超级	chāojí	siêu, siêu cấp	\N	40
425	潮流	cháoliú	trào lưu	\N	34
427	潮湿	cháoshī	ẩm ướt	\N	34
428	超市	chāoshì	siêu thị	\N	40
429	诧异	chàyì	ngạc nhiên	\N	40
431	彻底	chèdǐ	triệt để, hoàn toàn	\N	34
432	车库	chēkù	nhà để xe	\N	28
433	趁	chèn	nhân lúc, thừa dịp	\N	30
434	沉淀	chéndiàn	kết tủa	\N	40
435	乘	chéng	đi, cưỡi	\N	34
436	橙	chéng	trái cam	\N	40
440	承办	chéngbàn	đảm đương	\N	34
441	城堡	chéngbǎo	lâu đài	\N	24
442	承包	chéngbāo	ký hợp đồng, nhận thầu	\N	34
443	成本	chéngběn	chi phí, giá thành	\N	22
444	承担	chéngdān	gánh vác, đảm đương	\N	34
445	惩罚	chéngfá	trừng trị	\N	34
446	成分	chéngfèn	thành phần	\N	30
447	成功	chénggōng	thành công	\N	34
448	成果	chéngguǒ	thành quả	\N	30
449	称号	chénghào	tước vị, danh hiệu	\N	34
450	诚恳	chéngkěn	chân thành	\N	22
451	成员	chéngyuán	thành viên	\N	40
453	成立	chénglì	thành lập	\N	30
454	承认	chéngrèn	thừa nhận	\N	40
456	成就	chéngjiù	thành tựu	\N	30
457	成语	chéngyǔ	thành ngữ	\N	30
458	称呼	chénghu	xưng hô	\N	34
459	成全	chéngquán	hoàn thành, giúp hoàn thiện	\N	40
460	成清	chéngqīng	làm rõ	\N	34
461	诚实	chéngshí	thành thực, thật thà	\N	30
462	承受	chéngshòu	chịu đựng	\N	34
465	成为	chéngwéi	trở thành	\N	34
467	呈现	chéngxiàn	lộ ra, phơi bày	\N	40
468	成效	chéngxiào	hiệu quả, công hiệu	\N	34
469	称赞	chēngzàn	khen ngợi	\N	34
470	成长	chéngzhǎng	lớn lên	\N	34
471	诚挚	chéngzhì	chân thành, thân ái	\N	22
473	陈旧	chénjiù	lỗi thời, cũ kỹ	\N	34
474	陈列	chénliè	trưng bày	\N	21
475	沉闷	chénmèn	ngột ngạt, nặng nề	\N	34
476	沉默	chénmò	im lặng	\N	21
478	沉痛	chéntòng	đau thương, bi thống	\N	34
479	沉重	chénzhòng	trách nhiệm, nặng nề	\N	40
480	沉着	chénzhuó	bình tĩnh, vững vàng	\N	34
481	趁机	chènjī	thừa cơ, nhân dịp	\N	30
496	尺子	chǐzi	thước đo	\N	30
502	重复	chóngfù	lặp lại, trùng lặp	\N	25
512	抽烟	chōuyān	hút thuốc	\N	30
522	丑	chǒu	xấu xí	\N	24
533	船舶	chuánbó	thuyền bè	\N	28
544	窗帘	chuānglián	rèm cửa sổ	\N	21
534	传播	chuánbō	truyền bá	\N	21
555	初步	chūbù	sơ bộ, bước đầu	\N	24
483	趁热打铁	chènrè dǎtiě	thừa thắng xông lên	\N	30
484	驰骋	chíchěng	phi nước đại	\N	34
485	迟到	chídào	đến muộn	\N	34
486	赤道	chìdào	xích đạo	\N	34
487	迟缓	chíhuǎn	trì trệ, chậm chạp	\N	34
489	持久	chíjiǔ	kéo dài	\N	34
490	吃苦	chīkǔ	chịu khổ, chịu thiệt	\N	34
491	吃亏	chīkuī	chịu thiệt, bị thiệt hại	\N	40
492	吃力	chīlì	mệt nhọc, tốn sức	\N	34
493	池塘	chítáng	hồ, ao, đầm	\N	34
494	持续	chíxù	tiếp tục	\N	40
495	赤字	chìzì	thâm hụt, bội chi	\N	34
498	冲动	chōngdòng	xung động, kích thích	\N	34
499	充当	chōngdāng	đảm nhận, giữ chức	\N	40
500	充电器	chōngdiànqì	bộ sạc	\N	34
501	充足	chōngzú	đầy đủ	\N	40
503	崇高	chónggāo	cao cả	\N	34
504	崇敬	chóngjìng	tôn kính, kính trọng	\N	34
505	崇拜	chóngbài	sùng bái, tôn thờ	\N	34
506	重叠	chóngdié	chồng chéo	\N	34
508	宠物	chǒngwù	thú cưng, vật nuôi	\N	34
509	宠爱	chǒng’ài	yêu thương, cưng chiều	\N	34
510	抽屉	chōuti	ngăn kéo	\N	34
511	抽象	chōuxiàng	trừu tượng	\N	34
513	抽奖	chōujiǎng	rút thăm trúng thưởng	\N	34
514	臭	chòu	hôi	\N	34
515	出版	chūbǎn	xuất bản	\N	40
516	出差	chūchāi	công tác	\N	34
517	出发	chūfā	xuất phát	\N	40
519	出口	chūkǒu	lối ra / xuất khẩu	\N	40
520	出类拔萃	chūlèi bácuì	xuất chúng, ưu tú	\N	40
521	出色	chūsè	xuất sắc	\N	40
523	筹备	chóubèi	chuẩn bị, trù bị	\N	40
524	踌躇	chóuchú	do dự, trăn trừ	\N	34
525	丑恶	chǒu’è	xấu xí, ác độc	\N	34
527	稠密	chóumì	dày đặc	\N	40
528	除	chú	trừ bỏ, phép chia	\N	34
529	出	chū	ra, xuất, đến	\N	40
530	船	chuán	thuyền, tàu	\N	28
531	串	chuàn	chuỗi, xâu	\N	34
532	穿着	chuānzhuó	mặc, đội	\N	34
536	传单	chuándān	tờ rơi, truyền đơn	\N	34
537	传递	chuándì	truyền, chuyển	\N	34
538	船舱	chuáncāng	khoang tàu, boong	\N	34
539	闯	chuǎng	xông, đâm bổ	\N	34
540	创作	chuàngzuò	sáng tác	\N	31
542	窗户	chuānghu	cửa sổ	\N	34
543	创立	chuànglì	thành lập, sáng lập	\N	30
545	创新	chuàngxīn	cải tiến, đổi mới	\N	34
546	创业	chuàngyè	lập nghiệp, khởi nghiệp	\N	34
548	穿越	chuānyuè	vượt qua, vượt	\N	34
549	传染	chuánrǎn	truyền nhiễm	\N	40
550	传授	chuánshòu	truyền dạy, truyền thụ	\N	40
552	传统	chuántǒng	truyền thống	\N	34
553	传真	chuánzhēn	fax	\N	21
554	储备	chǔbèi	dự trữ, để dành	\N	21
556	储存	chǔcún	dự trữ, để dành	\N	21
557	触犯	chùfàn	xúc phạm, xâm phạm	\N	34
558	厨房	chúfáng	bếp	\N	34
559	除非	chúfēi	trừ phi	\N	21
560	处罚	chǔfá	trừng phạt	\N	34
561	锤	chuí	cái búa	\N	40
562	吹	chuī	thổi	\N	34
563	吹牛	chuīniú	khoác lác, thổi phồng	\N	34
564	吹捧	chuīpěng	tâng bốc, ca tụng	\N	34
565	垂直	chuízhí	vuông góc, thẳng đứng	\N	34
566	初级	chūjí	sơ cấp	\N	34
568	除了	chúle	ngoài ra, trừ ra	\N	35
569	处理	chǔlǐ	xử lý	\N	40
570	出路	chūlù	lối thoát, đường ra	\N	40
571	出卖	chūmài	bán	\N	40
572	春	chūn	mùa xuân	\N	30
573	纯粹	chúncuì	tinh khiết, thuần khiết	\N	40
574	纯洁	chúnjié	thuần khiết, trong sạch	\N	34
575	出神	chūshén	xuất thần, say sưa	\N	40
576	出身	chūshēn	xuất thân	\N	40
577	出生	chūshēng	sinh ra, ra đời	\N	40
578	除夕	chúxī	đêm giao thừa	\N	40
580	出席	chūxí	dự họp, có mặt	\N	34
581	出现	chūxiàn	xuất hiện	\N	40
582	储蓄	chǔxù	dự trữ, dành dụm	\N	21
583	出洋相	chūyángxiàng	xấu mặt, làm trò cười cho thiên hạ	\N	34
584	处置	chǔzhì	xử lý, xử trí	\N	40
1473	胡子	húzi	râu	\N	24
590	磁带	cídài	băng từ	\N	27
616	促进	cùshǐ	thúc đẩy, giúp giã	\N	40
593	刺激	cìjī	kích thích	\N	32
629	打篮球	dǎ lánqiú	chơi bóng rổ	\N	40
633	打扮	dǎbàn	trang điểm, ăn vận	\N	40
652	代价	dàijià	giá phải trả, chi phí	\N	37
654	代理	dàilǐ	đại lý	\N	38
655	带领	dàilǐng	dẫn dắt	\N	31
672	挡	dǎng	ngăn chặn, ngăn cản	\N	24
678	当初	dāngchū	lúc đầu, hồi đó	\N	24
587	次	cì	lần	\N	21
589	次要	cì yào	thứ yếu, không quan trọng	\N	34
2676	深	shēn	sâu, đậm	\N	24
591	词典	cídiǎn	từ điển	\N	40
592	词汇	cíhuì	từ vựng	\N	34
594	此外	cǐwài	ngoài ra	\N	40
595	慈祥	cíxiáng	hiền từ, hiền hậu	\N	40
596	次序	cìxù	trật tự	\N	40
598	丛	cóng	bụi, lùm, khóm	\N	34
599	从	cóng	theo	\N	34
600	从此	cóngcǐ	từ đó	\N	34
601	从而	cóng’ér	do đó, vì vậy	\N	35
602	从来	cónglái	từ trước tới nay	\N	40
603	从容	cóngróng	điềm tĩnh, thong thả	\N	34
604	聪明	cōngmíng	thông minh	\N	34
606	从事	cóngshì	làm, tham gia	\N	40
607	从未	cóngwèi	chưa từng, chưa bao giờ	\N	34
608	从小	cóngxiǎo	từ nhỏ	\N	34
609	从容不迫	cóngróngbùpò	chậm rãi, không vội vàng	\N	34
610	凑合	còuhe	tập hợp, gom góp, quây quần	\N	34
611	醋	cù	giấm	\N	34
612	窜	cuàn	lủi, chuồn, chạy toán loạn	\N	40
613	催	cuī	thúc giục	\N	30
614	摧残	cuīcán	phá hủy, tàn phá	\N	30
615	脆弱	cuìruò	mỏng manh, yếu đuối	\N	34
617	存	cún	tồn tại, bảo tồn	\N	34
618	存在	cúnzài	tồn tại	\N	34
619	撮	cuō	xoay, xoắn, vặn	\N	34
621	措施	cuòshī	biện pháp	\N	40
622	错误	cuòwù	sai, sai lầm	\N	34
623	挫折	cuòzhé	sự thất bại	\N	40
624	粗心	cūxīn	sơ ý, cẩu thả, bất cẩn	\N	24
625	大	dà	to, lớn	\N	34
626	打	dǎ	đánh, mát, đập, phác, khoác	\N	34
627	打电话	dǎ diànhuà	gọi điện thoại	\N	34
628	打官司	dǎ guānsi	kiện	\N	40
630	打喷嚏	dǎ pēntì	hắt xì hơi, nhảy mũi	\N	40
631	大象	dà xiàng	voi, con voi	\N	34
632	答案	dá’àn	đáp án	\N	33
634	打包	dǎbāo	đóng gói, gói lại	\N	34
635	打比方	dǎbǐfāng	lấy ví dụ	\N	40
637	打败	dǎbài	đánh bại	\N	21
638	大臣	dàchén	đại thần	\N	30
639	达成	dáchéng	đạt đến, đạt được	\N	34
640	搭档	dādàng	người hợp tác, cộng tác	\N	34
641	达到	dádào	đến, đạt được	\N	34
642	大方	dàfāng	hào phóng	\N	34
643	大夫	dàifu	bác sĩ	\N	24
644	大概	dàgài	khoảng	\N	34
645	打工	dǎgōng	làm công, làm thuê	\N	34
646	大伙儿	dàhuǒr	mọi người	\N	34
647	带	dài	đem, mang	\N	40
648	戴	dài	đeo, mang, đội	\N	40
649	呆	dāi	ngốc, ngẩn ngơ	\N	34
651	逮捕	dàibǔ	bắt giữ	\N	40
653	贷款	dàikuǎn	cho vay, vay	\N	40
656	待遇	dàiyù	đãi ngộ, đối xử, lạnh nhạt	\N	34
657	代替	dàitì	thay thế	\N	40
658	打击	dǎjí	gõ,đập,đánh	\N	34
659	打交道	dǎjiāodào	giao tiếp, tiếp xúc	\N	34
660	打量	dǎliàng	quan sát, nhìn đánh giá	\N	40
661	打猎	dǎliè	săn bắn	\N	34
662	蛋白质	dànbáizhì	protein	\N	34
663	担保	dānbǎo	đảm bảo	\N	34
665	单调	dāndiào	đơn điệu	\N	34
666	单独	dāndú	đơn độc, một mình	\N	34
667	单位	dānwèi	bài mục, đơn vị	\N	34
668	担任	dānrèn	đảm nhiệm	\N	34
669	单元	dānyuán	bài học, đơn nguyên	\N	34
670	诞辰	dànchén	ngày sinh nhật	\N	40
671	党	dǎng	đảng	\N	31
673	当	dāng	làm, đảm nhiệm, khi	\N	40
675	档案	dàng’àn	hồ sơ	\N	34
676	蛋糕	dàngāo	bánh ga-tô	\N	34
677	当场	dāngchǎng	tại chỗ	\N	34
679	档次	dàngcì	đẳng cấp, cấp bậc	\N	21
680	当代	dāngdài	ngày nay, đương đại	\N	34
681	当面	dāngmiàn	trước mặt	\N	34
682	当前	dāngqián	hiện tại	\N	40
683	当然	dāngrán	đương nhiên	\N	34
685	当事人	dāngshìrén	người có liên quan, đương sự	\N	34
686	当务之急	dāngwùzhījí	việc khẩn cấp trước mắt	\N	34
687	当心	dāngxīn	cẩn thận, coi chừng	\N	34
694	淡忘	dànwàng	lãng quên	\N	29
695	胆小鬼	dǎnxiǎoguǐ	kẻ nhát gan	\N	31
720	打扫	dǎsǎo	quét, quét dọn	\N	39
727	打印	dǎyìn	in ấn	\N	39
732	打折	dǎzhé	chiết khấu, giảm giá	\N	37
741	灯	dēng	đèn	\N	27
762	点	diǎn	điểm, giờ	\N	30
689	淡季	dànjì	trái mùa, mua ế hàng	\N	40
691	诞生	dànshēng	ra đời, sinh ra	\N	40
692	但是	dànshì	nhưng	\N	35
693	淡水	dànshuǐ	nước ngọt	\N	34
696	担心	dānxīn	lo lắng	\N	34
697	倒	dǎo	đổ	\N	34
698	到	dào	đến	\N	34
699	岛	dǎo	đảo	\N	34
700	刀	dāo	đao, dao	\N	34
701	倒闭	dǎobì	sập tiệm, đóng cửa	\N	34
702	到处	dàochù	khắp nơi	\N	34
704	导弹	dǎodàn	hỏa tiễn, đạn đạo	\N	34
705	道德	dàodé	đạo đức	\N	34
706	到底	dàodǐ	đến cùng, rốt cuộc, suy cho cùng	\N	34
707	稻谷	dàogǔ	lúa	\N	40
708	导航	dǎoháng	dẫn đường, hướng dẫn	\N	34
709	道理	dàolǐ	đạo lý	\N	34
710	捣乱	dǎoluàn	phá đám, quấy rối	\N	34
711	倒霉	dǎoméi	xui xẻo	\N	34
713	盗窃	dàoqiè	trộm	\N	34
714	导向	dǎoxiàng	hướng dẫn	\N	34
715	导演	dǎoyǎn	đạo diễn	\N	34
716	导游	dǎoyóu	hướng dẫn viên du lịch	\N	34
717	岛屿	dǎoyǔ	quần đảo	\N	27
718	导致	dǎozhì	dẫn đến	\N	34
719	打算	dǎsuàn	nhịn chung	\N	34
721	大厦	dàshà	tòa nhà	\N	34
722	大使馆	dàshǐguǎn	đại sứ quán	\N	40
724	大体	dàtǐ	thăm dò, nghe ngóng	\N	34
725	大兴	dàxīng	quy mô lớn	\N	34
726	大意	dàyì	không cẩn thận	\N	34
728	答应	dāying	đồng ý, bằng lòng	\N	34
729	大约	dàyuē	khoảng, ước chừng, chắc là	\N	34
730	打仗	dǎzhàng	đánh nhau, đánh trận	\N	24
731	打招呼	dǎzhāohu	chào hỏi	\N	34
733	打针	dǎzhēn	tiêm	\N	40
734	大致	dàzhì	khoảng	\N	34
735	地	de	trợ từ kết cấu	\N	35
736	的	de	của	\N	35
737	得	dé	được, mắc (bệnh)	\N	35
739	得力	délì	được lợi	\N	35
740	瞪	dèng	nhìn chằm chằm	\N	34
742	等	děng	chờ, đợi	\N	34
743	登	dēng	đạp, giẫm	\N	34
744	登机牌	dēngjīpái	thẻ lên máy bay	\N	40
745	登录	dēnglù	đăng nhập	\N	30
746	等待	děngdài	đợi	\N	34
747	等候	děnghòu	đợi	\N	34
748	等级	děngjí	cấp bậc, đẳng cấp	\N	21
749	登记	dēngjì	đăng ký	\N	31
750	灯笼	dēnglóng	đèn lồng	\N	34
751	登陆	dēnglù	bộ, lên bờ	\N	40
752	等于	děngyú	bằng	\N	34
754	得意	déyì	đắc ý	\N	35
755	得罪	dézuì	đắc tội	\N	35
756	递	dì	truyền đạt, chuyển giao	\N	34
757	底	dǐ	đáy, đế, cuối, nền	\N	34
758	低	dī	thấp	\N	34
759	滴	dī	nhỏ giọt	\N	34
760	第一	dì yī	thứ nhất	\N	21
761	垫	diàn	đệm, cái lót	\N	34
763	颠簸	diānbǒ	lắc lư, tròng trành	\N	34
764	电池	diànchí	pin, ắc quy	\N	40
765	颠倒	diāndǎo	lật ngược, đảo lộn	\N	34
767	惦记	diànjì	nghĩ đến, nhớ đến	\N	34
768	电力	diànlì	nghị lực	\N	40
769	电脑	diànnǎo	máy vi tính	\N	40
770	电视	diànshì	truyền hình, ti-vi	\N	40
771	电台	diàntái	trạm phát sóng	\N	34
772	电梯	diàntī	thang máy	\N	30
774	电信	diànxìn	trang miệng	\N	34
775	电影	diànyǐng	phim	\N	31
776	典礼	diǎnlǐ	điển hình, nghi lễ	\N	40
777	电源	diànyuán	nguồn điện	\N	34
778	电子邮件	diànzǐ yóujiàn	e-mail	\N	40
779	吊	diào	treo	\N	34
780	掉	diào	rơi, mất, giảm, hạ	\N	34
781	钓	diào	câu cá	\N	24
782	雕	diāo	ngắm, thả	\N	34
784	调动	diàodòng	điều động, đổi, thay đổi	\N	34
785	雕刻	diāokè	điêu khắc	\N	40
786	雕塑	diāosù	điêu khắc	\N	40
787	跌倒	diēdǎo	ngã, đổ, té	\N	34
788	叠	dié	gấp, chồng, xếp	\N	34
789	地步	dìbù	mức, bước	\N	35
790	地道	dìdao	địa đạo	\N	35
791	地点	dìdiǎn	địa điểm	\N	35
792	弟弟	dìdi	em trai	\N	40
793	跌	diē	ngã, té, rơi	\N	34
1643	忌讳	jìhuì	kiêng kỵ	\N	40
814	冬	dōng	mùa đông, đông	\N	30
877	顿	dùn	tán	\N	31
797	盯	dīng	nhìn chăm chăm	\N	34
817	动画片	dònghuà piàn	phim hoạt hình	\N	31
825	动手	dòngshǒu	bắt đầu làm, bắt tay vào làm	\N	40
837	读	dú	đọc	\N	33
841	端午节	duānwǔ jié	Tết Đoan Ngọ	\N	36
855	对话	duìhuà	đối thoại	\N	33
874	对照	duìzhào	so sánh, đối chiếu	\N	22
876	独立	dúlì	độc lập	\N	33
882	躲藏	duǒcáng	trốn tránh, ẩn náu	\N	24
798	定期	dìngqī	theo kỳ hạn, định kỳ	\N	34
799	定义	dìngyì	định nghĩa	\N	40
800	叮嘱	dīngzhǔ	căn dặn, dặn dò	\N	34
801	地球	dìqiú	trái đất, địa cầu	\N	35
802	地区	dìqū	vùng	\N	35
804	敌人	dírén	kẻ thù	\N	30
805	敌视	díshì	căm thù, coi như kẻ thù	\N	34
806	地势	dìshì	địa thế	\N	35
807	地铁	dìtiě	xe điện ngầm	\N	35
808	地图	dìtú	bản đồ	\N	35
809	地位	dìwèi	địa vị	\N	35
810	地震	dìzhèn	động đất	\N	35
811	地质	dìzhì	địa chất	\N	35
813	东	dōng	phía đông	\N	34
815	动荡	dòngdàng	bấp bênh, rối ren, hỗn loạn	\N	34
816	东道主	dōngdàozhǔ	chủ nhà	\N	30
818	动机	dòngjī	động cơ	\N	34
819	冻结	dòngjié	đóng lại	\N	34
820	动静	dòngjìng	động tĩnh	\N	34
821	动力	dònglì	động lực	\N	34
822	动脉	dòngmài	động mạch	\N	34
823	动身	dòngshēn	khởi hành, lên đường	\N	34
826	动态	dòngtài	động thái	\N	34
827	动物	dòngwù	động vật	\N	34
828	东西	dōngxi	đồ	\N	34
829	洞穴	dòngxué	hang động	\N	34
830	动员	dòngyuán	huy động	\N	34
831	东张西望	dōngzhāngxīwàng	nhìn đông nhìn tây	\N	34
832	动作	dòngzuò	động tác	\N	34
833	逗	dòu	chọc tức	\N	34
834	豆腐	dòufu	đậu phụ	\N	24
835	陡峭	dǒuqiào	dốc đứng, dốc ngược	\N	34
836	斗争	dòuzhēng	đấu tranh	\N	24
838	断	duàn	đứt, đoạn tuyệt, chặt, cai	\N	40
839	段	duàn	đoạn	\N	34
840	端	duān	đầu, đầu mút	\N	24
842	断定	duàndìng	kết luận, nhận định	\N	40
844	短	duǎn	ngắn	\N	34
845	短促	duǎncù	ngắn ngủi, vội vàng	\N	34
846	短期	duǎnqī	ngắn hạn	\N	34
847	短暂	duǎnzàn	ngắn ngủi, thoáng qua	\N	34
848	堆	duī	túi, tụ, chồng chất, đóng	\N	34
849	堆积	duījī	tích tụ, chất đống	\N	34
850	队	duì	đội	\N	34
851	对	duì	đúng	\N	34
852	对比	duìbǐ	so sánh	\N	34
853	对待	duìdài	đối xử, đối đãi	\N	34
856	断断续续	duànduànxùxù	gián đoạn, không liên tục	\N	34
857	锻炼	duànliàn	tập luyện, rèn luyện	\N	34
858	端信	duānxìn	tin nhắn	\N	33
859	端正	duānzhèng	đoan chính, đều đặn, ngay ngắn	\N	34
860	赌博	dǔbó	cờ bạc	\N	34
861	独裁	dúcái	độc tài	\N	34
862	督促	dūcù	thúc giục	\N	30
863	渡过	dùguò	xuyên qua, trải qua	\N	40
865	对不起	duìbuqǐ	xin lỗi	\N	34
866	对策	duìcè	biện pháp đối phó	\N	34
867	对称	duìchèn	tính cân xứng	\N	34
868	兑换	duìhuàn	trao đổi	\N	40
870	对立	duìlì	đối lập	\N	34
871	对联	duìlián	đối liễn	\N	34
872	对应	duìyìng	đối ứng	\N	34
873	对于	duìyú	về, đối với	\N	40
875	独绝	dújué	tiêu độc, ngăn chặn	\N	34
878	盹	dǔn	ngồi xồm	\N	40
880	朵	duǒ	bông	\N	34
881	多	duō	nhiều	\N	40
883	多亏	duōkuī	may mắn, may mà	\N	21
884	堕落	duòluò	sa ngã, trụy lạc	\N	21
885	多么	duōme	bao nhiêu, biết bao	\N	21
886	哆嗦	duōsuo	lạnh cóng, run cầm cập	\N	34
887	多余	duōyú	dư, dư thừa	\N	30
888	多元化	duōyuán huà	đa dạng hóa	\N	34
889	毒品	dúpǐn	thuốc phiện	\N	34
890	阻塞	dūsè	tắc nghẽn, ngăn chặn	\N	34
891	都市	dūshì	đô thị	\N	34
893	肚子	dùzi	bụng	\N	34
894	饿	è	đói	\N	34
895	讹	é	chuyển biến xấu, thay đổi xấu đi	\N	34
897	恶	è	ừ, hừ	\N	21
898	怨恨	yuànhèn	oán hận	\N	34
899	而	ér	và, mà, nhưng	\N	35
901	儿童	értóng	nhi đồng	\N	34
3571	岩石	yánshí	đá	\N	21
908	发表	fābiǎo	phát biểu, tuyên bố	\N	40
912	发达	fādá	phát triển, phồn vinh	\N	34
925	反复	fǎnfù	lặp đi lặp lại	\N	33
922	翻	fān	xoay, lật, trở mình	\N	40
935	反问	fǎnwèn	hỏi lại	\N	33
910	发财	fācái	phát tài, làm giàu	\N	40
927	反面	fǎnmiàn	phản diện, mặt trái	\N	40
954	饭馆	fànguǎn	quán cơm	\N	26
956	访问	fǎnwèn	hỏi lại, hồi vấn lại	\N	33
980	法	fǎ	thể	\N	37
902	二氧化碳	èryǎnghuàtàn	CO₂	\N	34
903	而已	éryǐ	mà thôi, thế thôi	\N	35
904	儿子	érzi	con trai	\N	34
905	额外	éwài	ngoài định mức	\N	34
907	发	fā	phát, gửi	\N	40
916	发挥	fāhuī	phát huy	\N	30
909	发布	fābù	tuyên bố, phát hành, thông báo	\N	34
911	发愁	fāchóu	lo lắng, buồn phiền	\N	34
913	发呆	fādāi	ngẩn người	\N	34
914	发动	fādòng	phát động, bắt đầu	\N	34
915	发抖	fādǒu	run rẩy	\N	40
918	发觉	fājué	phát hiện, phát giác	\N	40
919	发款	fākuǎn	phát tiền	\N	40
920	法律	fǎlǜ	pháp luật	\N	40
921	发明	fāmíng	phát minh	\N	40
924	反常	fǎncháng	dị thường	\N	34
926	反抗	fǎnkàng	phản kháng	\N	30
928	反应	fǎnyìng	phản ứng	\N	34
929	反映	fǎnyìng	phản ánh	\N	30
930	反对	fǎnduì	phản đối	\N	34
931	反转	fǎnzhuǎn	trái lại, ngược lại	\N	34
932	反思	fǎnsī	suy ngẫm, phản tỉnh	\N	34
933	反射	fǎnshè	phản xạ	\N	30
934	反馈	fǎnkuì	phản hồi	\N	34
936	放	fàng	tha, thả	\N	30
938	放暑假	fàng shǔjià	nghỉ hè	\N	40
939	妨碍	fáng'ài	gây trở ngại	\N	34
940	反感	fǎngǎn	ác cảm, bất mãn	\N	34
941	方案	fāng’àn	kế hoạch, phương án	\N	34
943	房东	fángdōng	chủ nhà	\N	30
944	方法	fāngfǎ	phương pháp	\N	34
945	仿佛	fǎngfú	hình như, dường như	\N	34
946	房间	fángjiān	phòng	\N	34
947	方面	fāngmiàn	phương diện, mặt, phía	\N	34
948	放弃	fàngqì	vứt bỏ, từ bỏ	\N	34
949	放射	fàngshè	phóng xạ	\N	34
950	方式	fāngshì	phương thức, cách thức	\N	34
951	防守	fángshǒu	phòng thủ	\N	34
952	放手	fàngshǒu	buông tay	\N	34
953	放松	fàngsōng	thả lỏng, thư giãn	\N	34
955	方向	fāngxiàng	phương hướng	\N	34
958	方言	fāngyán	tiếng địa phương	\N	34
959	防疫	fángyì	phòng dịch	\N	34
960	房屋	fángwū	phòng ở	\N	34
961	方针	fāngzhēn	phương châm	\N	34
962	防治	fángzhì	phòng chống, phòng và chữa trị	\N	34
963	纺织	fǎngzhī	dệt vải	\N	34
964	繁华	fánhuá	phồn hoa, sầm uất	\N	34
965	泛滥	fànlàn	tràn lan	\N	21
966	贩卖	fànmài	buôn bán	\N	34
967	繁忙	fánmáng	bận rộn	\N	34
969	繁荣	fánróng	phồn vinh	\N	34
970	凡是	fánshì	phàm là, hễ là	\N	34
971	繁体字	fántǐzì	chữ phồn thể	\N	34
972	范围	fànwéi	phạm vi	\N	34
973	翻译	fānyì	phiên dịch, dịch	\N	40
974	反正	fǎnzhèng	dù sao cũng	\N	34
975	反之	fǎnzhī	trái lại, ngược lại	\N	34
976	发票	fāpiào	hóa đơn	\N	34
977	法人	fǎrén	pháp nhân	\N	21
978	发烧	fāshāo	phát sốt, sốt	\N	34
979	发生	fāshēng	xảy ra	\N	40
982	发扬	fāyáng	nêu cao, phát huy	\N	34
983	发育	fāyù	trưởng thành, dậy thì	\N	40
984	法院	fǎyuàn	tòa án	\N	34
985	发行	fāxíng	phát hành	\N	31
986	发现	fāxiàn	phát hiện	\N	40
987	发疯	fāfēng	phát điên	\N	40
988	发展	fāzhǎn	phát triển	\N	40
989	肺	fèi	phổi	\N	34
990	非	fēi	không, phi	\N	34
992	非常	fēicháng	rất, đặc biệt	\N	40
993	废除	fèichú	bãi bỏ, huỷ bỏ	\N	40
994	非法	fēifǎ	bất hợp pháp, phi pháp	\N	34
995	费用	fèiyòng	chi phí	\N	40
996	飞机	fēijī	máy bay	\N	21
998	沸腾	fèiténg	sôi sùng sục	\N	34
999	匪徒	fěitú	kẻ cướp, đạo tặc	\N	34
1000	肥沃	féiwò	phì nhiêu, màu mỡ	\N	40
1001	飞翔	fēixiáng	bay lượn	\N	40
1002	废墟	fèixū	đống hoang, đống đổ nát	\N	34
1003	飞跃	fēiyuè	nhảy vọt, vượt bậc	\N	40
1004	肥皂	féizào	xà bông	\N	34
1007	分布	fēnbù	phân bố, phân phát	\N	30
1018	风暴	fēngbào	bão tố	\N	30
1048	杠杆	gànggǎn	đòn bẩy	\N	21
1083	高考	gāokǎo	thí vào trường đại học	\N	40
1021	丰收	fēngshōu	được mùa	\N	30
1030	分配	fēnpèi	phân phối	\N	30
1032	粉碎	fěnsuì	vỡ nát, vỡ tan tành	\N	22
1035	愤慨	fènkǎi	bất bình, phẫn nộ, nổi cáu	\N	24
1038	分明	fēnmíng	rõ ràng, phân minh	\N	30
1011	愤怒	fènnù	căm phẫn, tức giận	\N	27
1046	尴尬	gāngà	khó xử, lúng túng	\N	34
1008	分寸	fēncùn	chừng mực, có chừng mực	\N	34
1009	分担	fēndān	phân đầu	\N	30
1010	奋斗	fèndòu	cố gắng, dồn dập	\N	34
1090	个	gè	cái	\N	25
1013	丰富	fēngfù	phong phú	\N	34
1014	风景	fēngjǐng	phong cảnh	\N	34
1015	风度	fēngdù	phong độ, phong cách	\N	34
1016	风光	fēngguāng	phong cảnh	\N	34
1017	封建	fēngjiàn	phong kiến	\N	34
1092	割	gē	cắt, gặt	\N	28
1019	风俗	fēngsú	phong tục	\N	34
1020	疯狂	fēngkuáng	điên cuồng	\N	34
1097	疙瘩	gēda	mụn, mụn cám	\N	27
1023	风气	fēngqì	bầu không khí, nếp sống	\N	34
1024	风趣	fēngqù	thú vị, dí dỏm	\N	30
1025	封锁	fēngsuǒ	phong toả, bao vây, chặn	\N	34
1026	风土人情	fēngtǔ rénqíng	phong thổ	\N	34
1027	风味	fēngwèi	hương vị	\N	34
1028	奉献	fèngxiàn	hiến dâng	\N	40
1029	风险	fēngxiǎn	rủi ro	\N	34
1099	歌	gē	bài hát	\N	31
1031	分歧	fēnqí	khác biệt, mâu thuẫn, bất đồng	\N	34
1100	革命	gémìng	cách mạng	\N	31
1033	粉末	fěnmò	bụi, bột	\N	40
1034	粉笔	fěnbǐ	phấn viết	\N	40
1101	根	gēn	nguồn gốc, rễ cây	\N	25
1036	分裂	fēnliè	phân tách	\N	30
1039	分手	fēnshǒu	chia tay, ly biệt	\N	40
1040	纷纷	fēnfēn	tấp nập, dồn dập	\N	34
1041	敢	gǎn	dám	\N	34
1042	干活儿	gàn huó er	làm việc, lao động	\N	34
1043	干杯	gānbēi	cạn ly	\N	31
1044	干脆	gāncuì	dứt khoát, thẳng thắn, thành thật	\N	34
1045	感动	gǎndòng	cảm động	\N	34
1047	刚	gāng	vừa, vừa mới	\N	40
1049	刚刚	gānggāng	vừa mới	\N	40
1050	刚强	gāngqiáng	cương linh, chính cương	\N	34
1051	港口	gǎngkǒu	hải cảng	\N	21
1052	纲领	gānglǐng	cương lĩnh, chính cương	\N	34
1053	钢铁	gāngtiě	sắt thép	\N	34
1054	岗	gǎng	cảng, bến cảng	\N	34
1056	干旱	gānhàn	khô	\N	34
1057	感激	gǎnjī	cảm kích, biết ơn	\N	34
1058	赶紧	gǎnjǐn	vội vàng	\N	34
1059	干劲	gànjìn	lòng hăng hái, tinh thần hăng hái	\N	34
1060	干净	gānjìng	sạch sẽ	\N	34
1061	感觉	gǎnjué	cảm thấy, thấy	\N	34
1062	感慨	gǎnkǎi	xúc động	\N	34
1063	赶快	gǎnkuài	nhanh, mau lên	\N	40
1064	感冒	gǎnmào	bị cảm	\N	34
1065	感情	gǎnqíng	tình cảm	\N	34
1066	感染	gǎnrǎn	lây, bị nhiễm	\N	40
1067	干扰	gānrǎo	can thiệp	\N	34
1069	感受	gǎnshòu	cảm nhận	\N	40
1070	感想	gǎnxiǎng	cảm tưởng	\N	34
1071	感谢	gǎnxiè	cảm tạ, bày tỏ lòng cảm ơn	\N	34
1072	干预	gānyù	tham dự, tham gia, can dự	\N	40
1073	搞	gǎo	làm	\N	40
1074	高	gāo	cao	\N	34
1075	告别	gàobié	từ biệt	\N	40
1076	高潮	gāocháo	cao trào, đỉnh điểm	\N	34
1078	高级	gāojí	cao cấp	\N	34
1079	高档	gāodàng	cao cấp	\N	34
1080	高峰	gāofēng	đỉnh cao	\N	34
1081	稿件	gǎojiàn	bài viết, bài vở	\N	34
1082	告诫	gàojiè	khuyên bảo, khuyên răn	\N	34
1084	高明	gāomíng	thông minh	\N	34
1085	高尚	gāoshàng	cao cả, cao thượng	\N	34
1086	告诉	gàosù	báo, kể	\N	34
1088	高兴	gāoxìng	vui vẻ, vui mừng	\N	34
1089	高涨	gāozhǎng	dâng cao, tăng vọt	\N	34
1091	各	gè	các, mỗi, tất cả	\N	40
1093	搁	gē	đặt, để, kê	\N	40
1094	隔壁	gébì	nhà bên cạnh	\N	34
1095	个别	gèbié	riêng biệt, cá biệt	\N	40
1096	胳膊	gēbo	cánh tay	\N	34
1103	跟	gēn	theo	\N	34
1104	根本	gēnběn	căn bản	\N	34
1105	工程	gōngchéng	công trình	\N	34
1106	工程师	gōngchéngshī	kỹ sư	\N	23
1107	更	gèng	hơn nữa, càng, thêm	\N	34
1108	耕地	gēngdì	cày ruộng, cày bừa	\N	35
1181	管理	guǎnlǐ	quản lí	\N	38
1112	跟前	gēnqián	cạnh, gần, bên cạnh	\N	28
1113	根深蒂固	gēnshēndìgù	ăn sâu bén rễ	\N	24
1122	个性	gèxìng	tính cách, cá tính	\N	25
1124	鸽子	gēzi	chim bồ câu	\N	24
1173	观点	guāndiǎn	chính thức	\N	30
1193	光彩	guāngcǎi	hào quang, màu sắc ánh sáng	\N	24
1111	根据信	gēnjù	căn cứ	\N	33
1202	光芒	guāngmáng	tia sáng, hào quang	\N	27
1206	观光	guānguāng	tham quan	\N	27
1114	根源	gēnyuán	căn nguyên, nguồn gốc	\N	34
1115	跟踪	gēnzōng	theo dõi, bám theo	\N	34
1116	个人	gèrén	cá nhân	\N	21
1117	格式	géshì	cách thức, quy cách	\N	30
1119	歌颂	gēsòng	khen ngợi	\N	34
1120	个体	gètǐ	cá thể, cá nhân, đơn lẻ	\N	34
1121	格外	géwài	đặc biệt	\N	34
1209	关心	guānxīn	quan tâm	\N	27
1123	个子	gèzi	dáng vóc	\N	34
1183	关怀	guānhuái	chăm sóc	\N	34
1125	供不应求	gōng bù yìng qiú	cung không đáp ứng được cầu	\N	34
1126	公安局	gōng'ān jú	cục công an	\N	34
1127	公布	gōngbù	thông báo, công bố	\N	34
1128	工厂	gōngchǎng	nhà máy	\N	23
1129	公道	gōngdào	công lý, lẽ phải	\N	34
1130	供电	gōngdiàn	cung điện	\N	34
1131	功夫	gōngfu	công sức, bản lĩnh, thời gian	\N	34
1133	公告	gōnggào	thông báo, thông cáo	\N	34
1134	公共汽车	gōnggòng qìchē	xe buýt	\N	28
1136	共和国	gònghéguó	nước cộng hòa	\N	35
1137	攻击	gōngjī	tấn công, tiến đánh	\N	34
1138	供给	gōngjǐ	cung cấp	\N	34
1139	恭敬	gōngjìng	tôn kính	\N	34
1140	工具	gōngjù	công cụ	\N	34
1141	公开	gōngkāi	công khai	\N	34
1142	功课	gōngkè	bài tập về nhà	\N	40
1143	攻克	gōngkè	tấn công, đánh chiếm	\N	34
1144	功劳	gōngláo	công lao, công trạng	\N	34
1145	公里	gōnglǐ	km	\N	21
1146	公民	gōngmín	công dân	\N	34
1148	公平	gōngpíng	công bằng	\N	34
1149	公婆	gōngpó	cha mẹ chồng	\N	34
1150	公然	gōngrán	ngang nhiên, thẳng thắn	\N	34
1151	工人	gōngrén	công nhân	\N	34
1152	公认	gōngrèn	công nhận	\N	34
1153	公司	gōngsī	công ty	\N	34
1154	公诉	gōngsù	công tố	\N	34
1155	公务	gōngwù	công vụ, việc nước, việc công	\N	34
1156	功效	gōngxiào	công hiệu, công năng	\N	34
1157	功勋	gōngxūn	công hiến	\N	34
1159	工业	gōngyè	công nghiệp	\N	34
1160	工艺品	gōngyìpǐn	đồ thủ công	\N	34
1161	公寓	gōngyù	chung cư	\N	34
1162	公元	gōngyuán	công nguyên	\N	34
1163	公园	gōngyuán	công viên	\N	34
1164	公正	gōngzhèng	công chính, công bằng, chính trực	\N	34
1165	公证	gōngzhèng	công chứng	\N	34
1166	公主	gōngzhǔ	công chúa	\N	34
1167	工资	gōngzī	lương	\N	34
1168	工作	gōngzuò	làm việc	\N	40
1169	够	gòu	đủ	\N	21
1170	狗	gǒu	chó	\N	34
1171	构成	gòuchéng	hình thành, cấu thành	\N	24
1174	沟通	gōutōng	khai thông, nối liền	\N	34
1175	购物	gòuwù	mua sắm	\N	40
1176	够了	gòule	đủ rồi	\N	35
1177	挂	guà	treo, móc	\N	34
1178	乖	guāi	ngoan	\N	34
1179	挂号	guàhào	đăng ký, lấy số	\N	34
1180	拐	guǎi	rẽ, ngoặt	\N	34
1182	观察	guānchá	quan sát, xem xét	\N	40
1185	冠军	guànjūn	quán quân, chức vô địch	\N	34
1186	罐头	guàntóu	đồ hộp	\N	34
1187	管	guǎn	ống	\N	34
1188	贯彻	guànchè	quán triệt, thông suốt	\N	34
1189	逛	guàng	đi dạo	\N	34
1190	光	guāng	ánh sáng, nhẵn, sạch trơn, chỉ	\N	34
1191	灌溉	guàngài	tưới, dẫn nước tưới ruộng	\N	34
1192	广播	guǎngbò	phát thanh, truyền hình	\N	40
1194	广场	guǎngchǎng	quảng trường	\N	34
1195	广大	guǎngdà	rộng lớn	\N	34
1196	广泛	guǎngfàn	rộng rãi	\N	34
1197	广告	guǎnggào	quảng cáo	\N	34
1201	光临	guānglín	sự hiện diện, ghé thăm	\N	34
1203	光明	guāngmíng	ánh sáng	\N	31
1204	光盘	guāngpán	CD	\N	21
1205	光荣	guāngróng	quang vinh	\N	40
1207	观念	guānniàn	quan niệm	\N	40
1208	关系	guānxì	quan hệ, liên quan	\N	40
1210	关于	guānyú	về	\N	40
1211	观众	guānzhòng	khán giả, quần chúng	\N	40
1255	果断	guǒduàn	quả quyết, quả đoán	\N	34
1231	规格	guīgé	quy cách, kiểu mẫu	\N	24
1232	归根到底	guīgēndàodǐ	xét đến cùng, suy nghĩ cho cùng	\N	40
1249	过节	guòjié	qua, đón (tết)	\N	36
1294	还是	háishi	vẫn, còn, hoặc hay	\N	25
1300	喊	hǎn	kêu la	\N	25
1199	光辉	guānghuī	chói lọi, rực rỡ	\N	34
1213	古代	gǔdài	thời cổ đại	\N	34
1215	古典	gǔdiǎn	cổ điển	\N	34
1216	固定	gùdìng	cố định	\N	34
1218	股东	gǔdōng	cổ đông	\N	34
1219	股份	gǔfèn	cổ phần	\N	34
1220	鼓励	gǔlì	cổ vũ, khuyến khích	\N	34
1221	股市	gǔshì	thị trường chứng khoán	\N	34
1222	骨干	gǔgàn	cốt cán, nòng cốt	\N	34
1223	姑姑	gūgu	cô	\N	34
1224	古怪	gǔguài	kỳ quặc	\N	40
1225	贵	guì	đắt, quý	\N	40
1226	归	guī	quy, trở về	\N	34
1227	规律	guīlǜ	quy luật	\N	40
1228	轨道	guǐdào	đường ray	\N	34
1229	规定	guīdìng	quy định	\N	40
1233	规划	guīhuà	kế hoạch, quy hoạch	\N	34
1234	归还	guīhuán	trả về, trả lại	\N	40
1235	规模	guīmó	quy mô	\N	34
1236	归纳	guīnà	quy nạp, tóm tắt	\N	34
1237	柜台	guìtái	quầy hàng, tủ bày hàng	\N	40
1238	规则	guīzé	quy tắc	\N	24
1239	贵族	guìzú	quý tộc	\N	34
1241	顾客	gùkè	khách hàng	\N	38
1242	古老	gǔlǎo	cổ xưa	\N	34
1243	孤立	gūlì	cô lập	\N	34
1244	顾虑	gùlǜ	lo lắng, băn khoăn	\N	34
1245	滚	gǔn	lăn, lộn, cút xéo	\N	34
1246	棍棒	gùnbàng	côn, gậy, gậy gộc	\N	34
1247	姑娘	gūniang	cô gái	\N	34
1248	过	guò	qua	\N	40
1250	过期	guòqí	đã quá, trễ hạn	\N	40
1251	果汁	guǒzhī	nước hoa quả	\N	34
1253	过度	guòdù	quá độ, quá mức	\N	34
1254	过渡	guòdù	chuyển tiếp	\N	34
1256	国防	guófáng	quốc phòng	\N	34
1257	国籍	guójí	quốc tịch	\N	34
1258	国际	guójì	quốc tế	\N	34
1259	国家	guójiā	nhà nước, quốc gia	\N	34
1260	国庆	guóqìng	quốc khánh	\N	34
1261	过滤	guòlǜ	lọc (bụi, nước...)	\N	34
1262	过敏	guòmǐn	dị ứng	\N	34
1264	过分	guòfèn	quá đáng, quá mức	\N	30
1265	过奖	guòjiǎng	quá khen	\N	40
1266	过错	guòcuò	sai lầm	\N	34
1267	果然	guǒrán	quả nhiên, thật vậy	\N	40
1268	果实	guǒshí	trái cây	\N	40
1269	国王	guówáng	hoàng đế, nhà vua	\N	34
1270	国务院	guówùyuàn	quốc vụ viện	\N	34
1272	过于	guòyú	quá chừng, quá đáng	\N	34
1273	股票	gǔpiào	cổ phiếu	\N	34
1276	故事	gùshi	sự cố, tai nạn	\N	34
1277	固体	gùtǐ	thể rắn	\N	40
1278	骨头	gǔtou	xương	\N	34
1279	顾问	gùwèn	cố vấn	\N	34
1280	鼓舞	gǔwǔ	cổ vũ	\N	34
1281	故乡	gùxiāng	quê nhà, quê hương	\N	34
1282	故意	gùyì	cố ý	\N	34
1283	雇佣	gùyōng	thuê	\N	30
1285	故障	gùzhàng	trục trặc, hỏng hóc	\N	34
1287	哈	hā	ha	\N	30
1288	还	hái	còn, vẫn	\N	34
1289	海	hǎi	biển	\N	40
1290	海拔	hǎibá	độ cao so với mặt nước biển	\N	34
1291	海滨	hǎibīn	miền biển, ven biển	\N	40
1292	海关	hǎiguān	hải quan	\N	40
1293	害怕	hàipà	sợ	\N	34
1295	海鲜	hǎixiān	hải sản	\N	21
1296	害羞	hàixiū	xấu hổ, thẹn thùng	\N	34
1298	孩子	háizi	trẻ em, trẻ con, em bé, con	\N	22
1299	汗	hàn	mồ hôi	\N	34
1301	航班	hángbān	chuyến bay	\N	40
1302	航空	hángkōng	hàng không	\N	34
1303	航天	hángtiān	hàng không vũ trụ	\N	34
1304	航行	hángxíng	đi, vận chuyển	\N	40
1305	行业	hángyè	ngành	\N	34
1306	含糊	hánhu	mơ hồ	\N	34
1307	寒假	hánjià	kì nghỉ đông	\N	34
1309	捍卫	hànwèi	bảo vệ, giữ gìn	\N	40
1310	汗水	hànxuè	hãn huyết, hơi han	\N	34
1311	汉语	hànyǔ	tiếng Hán	\N	40
1312	号	hào	số, cờ	\N	34
1313	好	hǎo	tốt, hay	\N	34
1314	好吃	hǎochī	ngon	\N	34
1315	号码	hàomǎ	số, dãy số	\N	34
1316	好处	hǎochu	điểm tốt, ưu điểm	\N	34
1317	耗费	hàofèi	tiêu hao, hao phí, hao mòn	\N	40
1318	豪华	háohuá	sang trọng, hao hoa	\N	34
1319	好客	hàokè	hiếu khách	\N	40
1320	豪迈	háomài	khí phách hào hùng	\N	34
1336	黑	hēi	màu đen	\N	24
1348	狠心	hěnxīn	nhẫn tâm	\N	21
1343	很	hěn	vừa vặn	\N	31
1355	合影	héyǐng	chụp ảnh chung	\N	31
1366	吼	hǒu	gào lên, gào to	\N	40
1367	后代	hòudài	con cháu	\N	24
1371	后来	hòulái	sau, sau rồi	\N	24
1378	画	huà	vẽ, họa, bức tranh	\N	31
1383	花粉	huāfěn	phấn hoa	\N	25
1390	黄	huáng	màu vàng	\N	24
1324	号召	hàozhào	hiệu triệu, kêu gọi	\N	34
1325	和	hé	và, với	\N	35
1326	河	hé	sông	\N	34
1327	喝	hē	uống	\N	34
1328	合不来	hébùlái	hòa tắt, cãi, bất hợp	\N	40
1329	合并	hébìng	hợp lại, hợp nhất	\N	34
1393	皇后	huánghòu	hoàng hậu	\N	24
1331	合法	héfã	hợp pháp	\N	34
1333	合乎	héhū	phù hợp, hợp với	\N	34
1334	合伙	héhuǒ	kết hội, chung vốn	\N	34
1335	嘿	hēi	ối, ư, ô hay, ơ hay	\N	34
1414	话题	huàtí	chủ đề	\N	32
1337	黑板	hēibǎn	bảng đen	\N	34
1338	和解	héjiě	hòa giải	\N	35
1339	何况	hékuàng	hơn nữa	\N	34
1340	合理	hélǐ	hợp lý	\N	34
1341	和睦	hémù	vui vẻ, hòa thuận	\N	35
1342	恨	hèn	hận, ghét	\N	30
1420	化妆	huàzhuāng	trang điểm	\N	40
1345	横	héng	ngang	\N	34
1346	哼	hēng	rên rỉ, ngâm nga	\N	34
1347	痕迹	hénjì	vết tích, dấu vết	\N	40
1425	挥	huī	vẫy	\N	27
1349	和平	hépíng	hòa bình	\N	35
1350	和气	héqì	ôn hòa, điềm đạm	\N	35
1351	合适	héshì	phù hợp	\N	34
1352	合算	hésuàn	có lợi, hiệu quả, tính toán	\N	40
1353	和谐	héxié	hài hòa, dịu dàng	\N	35
1354	核心	héxīn	trung tâm	\N	34
1426	灰	huī	màu xám	\N	24
1356	盒子	hézi	cái hộp	\N	34
1357	合作	hézuò	hợp tác	\N	34
1358	哄	hǒng	dỗ dành	\N	34
1359	洪水	hóngshuǐ	lũ	\N	21
1360	红	hóng	đỏ	\N	34
1362	轰动	hōngdòng	xôn xao, náo động, chấn động	\N	34
1363	宏观	hóngguān	vĩ mô	\N	34
1364	宏伟	hóngwěi	to lớn hào hùng, hùng vĩ	\N	34
1365	厚	hòu	dày	\N	40
1368	后果	hòuguǒ	hậu quả	\N	24
1370	后悔	hòuhuǐ	hối hận	\N	34
1372	喉咙	hóulóng	cổ họng	\N	34
1373	后面	hòumiàn	phía sau, mặt sau, đằng sau	\N	24
1374	后勤	hòuqín	hậu cần	\N	24
1375	候选	hòuxuǎn	người được đề cử, người ứng cử	\N	34
1376	猴子	hóuzi	con khỉ	\N	34
1377	壶	hú	bình, ấm	\N	34
1379	花	huā	hoa, tiêu tiền	\N	34
1381	滑冰	huábīng	trượt băng	\N	34
1382	划船	huáchuán	chèo thuyền	\N	34
1384	坏	huài	xấu, hỏng	\N	34
1385	怀念	huáiniàn	hoài niệm, nhớ nhung	\N	34
1386	怀疑	huáiyí	hoài nghi, nghi ngờ	\N	34
1387	怀孕	huáiyùn	có thai	\N	34
1388	欢乐	huānlè	sự vui mừng	\N	34
1391	皇帝	huángdì	hoàng đế	\N	34
1392	黄瓜	huángguā	dưa chuột	\N	34
1394	黄昏	huánghūn	buổi chiều, hoàng hôn	\N	34
1395	黄金	huángjīn	vàng	\N	34
1396	荒凉	huāngliáng	hoang vu, hoang vắng	\N	34
1397	慌忙	huāngmáng	vội vàng, lật đật	\N	34
1398	荒谬	huāngmiù	sai lầm, vô lý, hoang đường	\N	34
1399	恍然大悟	huǎngrándàwù	bỗng nhiên tỉnh ngộ	\N	34
1400	荒唐	huāngtáng	hoang đường, vô lý	\N	34
1402	缓和	huǎnhé	xoa dịu, hòa hoãn	\N	35
1403	环节	huánjié	mắt xích, phân đoạn, đốt, mấu	\N	34
1404	缓解	huǎnjiě	xoa dịu, làm dịu	\N	34
1405	环境	huánjìng	môi trường, hoàn cảnh	\N	40
1406	幻想	huànxiǎng	ảo tưởng	\N	34
1407	欢迎	huānyíng	đón chào, hoan nghênh	\N	34
1408	焕然一新	huànrányīxīn	trở về trạng thái cũ	\N	34
1409	患者	huànzhě	người bị bệnh	\N	34
1410	华侨	huáqiáo	hoa kiều	\N	34
1411	花生	huāshēng	củ lạc	\N	25
1413	化石	huàshí	hóa thạch	\N	34
1415	话筒	huàtǒng	microphone	\N	34
1416	化学	huàxué	hóa học	\N	34
1417	华裔	huáyì	Hoa kiều	\N	34
1418	华语	huáyǔ	tiếng Hoa	\N	34
1419	花园	huāyuán	hoa viên	\N	34
1421	湖泊	húpō	ao hồ	\N	34
1422	蝴蝶	húdié	bươm bướm, con bướm	\N	34
1423	回	huí	lần, về, quay lại	\N	40
1424	会	huì	hội, họp	\N	34
1427	回报	huíbào	trả lại	\N	40
1435	辉煌	huīhuáng	huy hoàng, rực rỡ, xán lạn	\N	25
1439	回收	huíshōu	thu lại, thu hồi	\N	30
1449	婚姻	hūnyīn	hôn nhân	\N	22
1467	活跃	huóyuè	sôi nổi, hoạt bát	\N	21
1490	家伙	jiāhuo	thằng cha, lão	\N	30
1526	郊游	jiāoyóu	dã ngoại, du ngoạn	\N	31
1529	教学	jiàoxué	giảng dạy	\N	32
1537	缴纳	jiǎonà	nộp (thuế, phí)	\N	30
1546	教员	jiàoyuán	giáo viên, giảng viên	\N	32
1548	接	jiē	tiếp, nhận, nối	\N	40
1429	回避	huíbì	né tránh, trốn tránh	\N	34
1430	灰尘	huīchén	bụi	\N	40
1431	回答	huídá	trả lời	\N	34
1432	恢复	huīfù	khôi phục, phục hồi	\N	34
1434	悔恨	huǐhèn	hối hận, hối lỗi	\N	34
1436	挥霍	huīhuò	phung phí	\N	34
1437	毁灭	huǐmiè	tiêu diệt, hủy diệt	\N	40
1438	汇率	huìlǜ	tỷ giá	\N	21
1440	会晤	huìwù	gặp gỡ, gặp mặt	\N	34
1441	灰心	huīxīn	nản lòng	\N	34
1442	回忆	huíyì	hồi ức, nhớ lại	\N	34
1443	会议	huìyì	hội nghị	\N	34
1445	喇叭	hǔlǎba	loa, qua quýt, tùy tiện	\N	34
1446	忽略	hūlüè	bỏ qua	\N	34
1447	婚礼	hūnlǐ	hôn lễ	\N	34
1448	混乱	hùnluàn	hỗn loạn, lẫn lộn	\N	34
1450	混合	hùnhé	hỗn hợp, trộn, nhào	\N	34
1452	昏迷	hūnmí	hôn mê, mê man	\N	34
1453	混淆	hūnxiáo	lộn xộn, xáo trộn	\N	34
1454	浑浊	hūnzhúo	vẩn đục	\N	31
1455	伙伴	huǒbàn	đối tác	\N	34
1456	货币	huòbì	tiền tệ	\N	40
1457	火柴	huǒchái	diêm	\N	40
1458	火车站	huǒchē zhàn	ga tàu	\N	28
1459	获得	huòdé	giành được, đạt được	\N	35
1460	活动	huódòng	hoạt động	\N	34
1461	活该	huógāi	đáng đời	\N	34
1463	活力	huólì	sức sống	\N	34
1464	活泼	huópō	hoạt bát, nhanh nhẹn	\N	34
1465	或	huò	hoặc	\N	35
1466	火药	huǒyào	thuốc súng	\N	34
1468	忽然	hūrán	đột nhiên, chợt	\N	34
1469	护士	hùshi	y tá	\N	24
1470	胡说	húshuō	nói nhảm, tào lao	\N	34
1471	胡同	hútòng	ngõ, hẻm	\N	34
1472	呼吸	hūxī	hô hấp, hít thở	\N	34
1475	呼喊	hūhǎn	hô hào, kêu gọi	\N	34
1476	护照	hùzhào	hộ chiếu	\N	34
1477	极	jí	rất, hết, cực	\N	40
1479	机	jī	máy, vải	\N	40
1480	家	jiā	gia, lấy chồng	\N	40
1481	家庭	jiātíng	gia đình, nhà	\N	22
1482	假	jiǎ	giả, giả định, giả như	\N	22
1483	价	jià	giá, giá cả	\N	37
1485	加班	jiābān	tăng ca	\N	32
1486	嘉宾	jiābīn	khách	\N	30
1488	价格	jiàgé	giá cả	\N	37
1489	加工	jiāgōng	gia công, chế biến	\N	34
1491	加剧	jiājù	trầm trọng thêm	\N	34
1492	家具	jiājù	gia cụ, đồ dùng trong nhà	\N	34
1493	件	jiàn	chiếc, cái, kiện	\N	40
1494	简单	jiǎndān	đơn giản	\N	34
1495	拣	jiǎn	lựa chọn, nhặt lấy	\N	40
1496	煎	jiān	rán, chiên	\N	40
1497	间	jiān	giữa, trong	\N	34
1498	建立	jiànlì	thiết lập	\N	40
1499	监督	jiāndū	giám sát, đôn thúc	\N	34
1501	坚决	jiānjué	kiên quyết, dứt khoát	\N	34
1502	建设	jiànshè	xây dựng	\N	40
1503	坚持	jiānchí	kiên trì, vững chắc	\N	34
1504	剪刀	jiǎndāo	kéo, cái kéo	\N	40
1505	减少	jiǎnshǎo	giảm bớt, giảm thiểu	\N	34
1506	检查	jiǎnchá	kiểm tra	\N	40
1507	简历	jiǎnlì	sơ yếu lý lịch	\N	34
1508	检讨	jiǎntǎo	thảo luận, tự kiểm	\N	40
1509	简直	jiǎnzhí	quả thực, thật là	\N	30
1511	剪	jiǎn	cắt, xén	\N	40
1513	尖锐	jiānruì	sắc bén, gay gắt	\N	40
1514	健康	jiànkāng	khỏe mạnh	\N	34
1515	讲	jiǎng	nói, kể, giảng	\N	34
1516	降低	jiàngdī	hạ thấp, giảm bớt	\N	34
1517	奖金	jiǎngjīn	tiền thưởng	\N	34
1518	将来	jiānglái	tương lai	\N	34
1519	奖励	jiǎnglì	khen thưởng	\N	34
1520	奖	jiǎng	thưởng, giải thưởng	\N	34
1521	降	jiàng	hạ xuống, rơi xuống	\N	40
1522	讲座	jiǎngzuò	tọa đàm, báo cáo	\N	34
1527	教师	jiàoshī	giáo viên	\N	34
1528	教堂	jiàotáng	nhà thờ	\N	34
1536	搅拌	jiǎobàn	khuấy, trộn	\N	34
1540	饺	jiǎo	bánh chẻo	\N	34
1549	街道	jiēdào	đường phố	\N	34
1550	节	jié	tiết, đốt, khúc, phần	\N	34
1551	监视	jiānshì	giám thị, theo dõi	\N	34
1554	间歇字	jiànxīzì	chữ gián thệ	\N	37
1535	骄傲	jiāo’ào	kiêu ngạo, tự hào	\N	27
1524	交	jiāo	giao, nộp, kết giao	\N	34
1633	节奏	jiézòu	nhịp điệu, tiết tấu	\N	24
1541	教	jiào	dạy	\N	32
1573	娇气	jiāoqì	duyên dáng, thanh nhã	\N	30
1562	监狱	jiānyù	nhà tù, nhà giam	\N	27
1630	介质	jièzhì	chất trung gian	\N	40
1581	加油站	jiāyóuzhàn	trạm xăng	\N	28
1604	界限	jièxiàn	ranh giới	\N	30
1523	交流	jiāoliú	giao lưu	\N	34
1615	姐姐	jiějie	chị gái	\N	28
1525	郊区	jiāoqū	ngoại ô	\N	34
1530	教育	jiàoyù	giáo dục	\N	34
1531	交换	jiāohuàn	trao đổi	\N	40
1620	介绍	jièshào	giới thiệu	\N	30
1625	解释	jiěshì	giải thích	\N	37
1538	角	jiǎo	sừng, góc	\N	34
1539	脚	jiǎo	chân	\N	30
1627	截止	jiézhǐ	kết thúc	\N	40
1634	激发	jīfā	kích thích	\N	32
1543	教练	jiàoliàn	huấn luyện viên	\N	40
1544	教授	jiàoshòu	giáo sư	\N	34
1545	教室	jiàoshì	lớp, phòng học	\N	34
1547	叫	jiào	gọi, kêu	\N	34
1553	舰艇	jiàntǐng	chiến hạm	\N	34
1637	机构	jīgòu	cơ cấu, đơn vị, cơ quan	\N	24
1555	见闻	jiànwén	hiểu biết, sự từng trải	\N	40
1556	检验	jiǎnyàn	kiểm nghiệm, kiểm tra	\N	40
1557	减弱	jiǎnruò	giảm dần, kém yếu	\N	34
1558	建议	jiànyì	đề xuất, kiến nghị	\N	40
1559	坚硬	jiānyìng	cứng, chắc, rắn	\N	34
1560	兼而又为勇为	jiānyǒngwéi	giám làm việc nghĩa	\N	35
1561	鉴于	jiànyú	thấy rằng, xét thấy	\N	40
1639	机关	jīguān	cơ quan	\N	27
1564	坚执	jiānzhí	kiên chấp	\N	40
1565	浇	jiāo	tưới, đổ, dội	\N	34
1566	交叉	jiāochā	đan xen, đan chéo	\N	34
1567	交际	jiāojì	giao tế, giao tiếp	\N	34
1568	教会	jiàohuì	giáo hội	\N	34
1569	角度	jiǎodù	góc, góc độ	\N	34
1570	焦虑	jiāolǜ	lo lắng, nôn nóng	\N	34
1571	角落	jiǎoluò	góc xó xỉnh	\N	34
1572	交纳	jiāonà	nộp, giao nộp	\N	34
1641	几乎	jīhū	hầu như, cơ hồ	\N	24
1575	胶水	jiāoshuǐ	keo nước, hồ dán	\N	34
1576	交通	jiāotōng	giao thông	\N	34
1577	假如	jiǎrú	nếu như	\N	40
1578	假设	jiǎshè	giả thuyết	\N	30
1579	家属	jiāshǔ	người nhà	\N	34
1580	家务	jiāwù	việc nhà	\N	40
1542	教材	jiàocái	tài liệu giảng dạy	\N	40
1582	佳肴	jiāyáo	món ăn ngon	\N	34
1583	家喻户晓	jiāyùhùxiǎo	nhà nhà đều biết	\N	40
1584	假装	jiǎzhuāng	giả vờ	\N	34
1585	价值	jiàzhí	giá trị	\N	37
1586	架子	jiàzi	cái kệ	\N	40
1587	嫉妒	jídù	đố kỵ, ganh ghét	\N	34
1588	级别	jíbié	trình độ	\N	34
1590	机场	jīchǎng	sân bay	\N	21
1591	继承	jìchéng	kế thừa, kế tục	\N	30
1592	基础	jīchǔ	cơ sở, nền tảng	\N	34
1593	鸡蛋	jīdàn	trứng gà	\N	34
1594	记得	jìde	nhớ, nhớ được	\N	35
1595	基地	jīdì	căn cứ	\N	35
1597	季度	jìdù	quý, 3 tháng	\N	30
1598	极端	jíduān	cực đoan	\N	34
1599	即	jí	tức, liền	\N	40
1600	截	jié	đoạn, khúc	\N	34
1601	皆	jiē	đều	\N	40
1602	结	jié	kết	\N	40
1605	解放	jiěfàng	giải phóng	\N	34
1606	结构	jiégòu	kết cấu	\N	24
1607	结果	jiéguǒ	kết quả	\N	40
1608	结合	jiéhé	kết hợp	\N	34
1609	借鉴	jièjiàn	rút kinh nghiệm	\N	40
1610	接近	jiējìn	tiếp cận	\N	34
1612	结晶	jiéjīng	kết tinh	\N	40
1613	结局	jiéjú	kết cục	\N	40
1614	解决	jiějué	giải quyết	\N	40
1616	接连	jiēlián	liên tiếp	\N	34
1617	结论	jiélùn	kết luận	\N	40
1618	节目	jiémù	tiết mục	\N	40
1619	介入	jièrù	xen vào, tham dự	\N	34
1621	节省	jiéshěng	tiết kiệm	\N	40
1622	结束	jiéshù	kết thúc	\N	40
1624	结算	jiésuàn	thanh toán	\N	34
1626	接触	jiēchù	tiếp xúc	\N	34
1628	节约	jiéyuē	tiết kiệm	\N	40
1629	接着	jiēzhe	tiếp theo	\N	34
1631	戒指	jièzhǐ	nhẫn	\N	21
1635	及格	jígé	hợp cách, đạt tiêu chuẩn	\N	40
1636	机关前进	jīgōngjìnlǐ	vi cãi trước mặt	\N	34
1638	籍贯	jíguàn	quê quán	\N	40
1640	集合	jíhé	tập hợp, tập trung	\N	34
1713	今天	jīntiān	hôm nay	\N	30
1649	纪律	jìlǜ	kỷ luật	\N	40
1698	精细	jīngxì	tỉ mỉ	\N	26
1664	进步	jìnbù	tiến bộ	\N	40
1685	精英	jīngyīng	tinh anh	\N	31
1673	警察	jǐngchá	cảnh sát	\N	26
1724	集体	jítǐ	tập thể	\N	37
1660	紧密	jǐnmì	chặt chẽ	\N	40
1672	精彩	jīngcǎi	tuyệt vời	\N	34
1687	经商	jīngshāng	kinh doanh	\N	38
1681	精神	jīngshén	tinh thần	\N	30
1677	精确	jīngquè	chính xác	\N	34
1645	即将	jíjiāng	sắp tới	\N	34
1646	积极	jījí	tích cực, hăng hái	\N	21
1647	计较	jìjiào	so bì, tính toán	\N	34
1648	季节	jìjié	mùa, mùa khí hậu	\N	30
1650	纪念	jìniàn	kỷ niệm	\N	40
1651	急忙	jímáng	vội vã, hấp tấp	\N	34
1652	纪实	jìshí	ký sự	\N	23
1653	及时	jíshí	kịp thời	\N	34
1654	积蓄	jīxù	tích lũy	\N	40
1656	激烈	jīliè	mãnh liệt	\N	34
1657	机灵	jīlíng	thông minh	\N	34
1658	记录	jìlù	ghi chép	\N	34
1659	激忙	jīmáng	vội vàng	\N	34
1735	久	jiǔ	lâu, lâu đời	\N	24
1661	进行	jìnxíng	tiến hành	\N	40
1662	进	jìn	tiến, vào	\N	40
1663	紧	jǐn	chặt	\N	30
1738	纠纷	jiūfēn	tranh chấp, bất hòa	\N	22
1666	技能	jìnéng	kỹ năng	\N	34
1667	进而	jìn'ér	tiến tới, triển khai kế tiếp	\N	35
1668	井	jǐng	giếng, hầm, lò	\N	34
1669	静	jìng	thản cây	\N	25
1670	敬业乐业	jìng yè yè	cẩn trọng, cẩn thận, cần cù	\N	34
1671	敬爱	jìng'ài	kính yêu	\N	34
1739	救护车	jiùhùchē	xe cứu hộ	\N	28
1741	就近	jiùjìn	lân cận, vùng phụ cận	\N	25
1675	精诚	jīngchéng	thành thật	\N	31
1676	精湛	jīngzhàn	tinh tế	\N	40
1743	酒精	jiǔjīng	cồn, rượu cồn	\N	26
1678	景象	jǐngxiàng	cảnh tượng	\N	40
1679	警告	jǐnggào	cảnh cáo	\N	34
1680	经过	jīngguò	quá trình, qua, đi qua	\N	40
1750	迹象	jìxiàng	dấu hiệu	\N	24
1682	精力	jīnglì	tinh lực, sức lực	\N	40
1683	经济	jīngjì	kinh tế	\N	40
1684	经验	jīngyàn	kinh nghiệm	\N	40
1723	记忆	jìyì	trí nhớ	\N	34
1686	景色	jǐngsè	phong cảnh	\N	34
1690	经济学	jīngjìxué	kinh tế học	\N	34
1691	经理	jīnglǐ	giám đốc	\N	34
1692	竟然	jìngrán	mà, lại, vậy mà	\N	40
1693	精美	jīngměi	tinh xảo, đẹp đẽ	\N	34
1694	进攻	jìngōng	tấn công	\N	34
1695	惊奇	jīngqí	kinh ngạc, lấy làm lạ	\N	40
1696	竞赛	jìngsài	cuộc thi	\N	34
1697	精通	jīngtōng	tinh thông	\N	34
1699	经管	jīngguǎn	cai quản	\N	40
1701	进口	jìnkǒu	nhập khẩu	\N	24
1702	进取	jìnqǔ	cầu tiến	\N	40
1703	进入	jìnrù	tiến vào	\N	40
1704	近来	jìnlái	gần đây	\N	40
1705	尽力	jìnlì	hết sức	\N	40
1706	尽量	jǐnliàng	tận lực	\N	31
1707	浸泡	jìnpào	ngâm, nhúng	\N	34
1708	紧迫	jǐnpò	cấp bách	\N	21
1710	谨慎	jǐnshèn	cẩn thận	\N	30
1711	晋升	jìnshēng	thăng tiến	\N	40
1712	金属	jīnshǔ	kim loại	\N	34
1714	劲头	jìntóu	sức mạnh	\N	34
1715	锦绣前程	jǐnxiù qiánchéng	tương lai tươi sáng	\N	34
1716	进展	jìnzhǎn	tiến triển	\N	40
1717	紧张	jǐnzhāng	căng thẳng	\N	30
1718	禁止	jìnzhǐ	cấm	\N	34
1719	机器	jīqì	máy móc	\N	34
1720	极其	jíqí	cực kỳ	\N	21
1722	紧急	jǐnjí	cấp thiết	\N	40
1726	计算	jìsuàn	tính toán	\N	34
1728	技术	jìshù	kỹ thuật	\N	30
1729	继续	jìxù	tiếp tục	\N	40
1730	即使	jíshǐ	cho dù	\N	40
1732	寂寞	jìmò	cô đơn	\N	34
1733	救	jiù	cứu	\N	21
1734	旧	jiù	cũ	\N	21
1736	九	jiǔ	chín	\N	21
1737	酒吧	jiǔbā	quán bar	\N	35
1742	究竟	jiūjìng	rốt cuộc, cuối cùng	\N	34
1744	就业	jiùyè	có công ăn việc làm, đi làm	\N	34
1745	纠正	jiūzhèng	uốn nắn, sửa chữa	\N	34
1746	就职	jiùzhí	nhận chức, nhậm chức	\N	40
1748	极限	jíxiàn	cao nhất, cực độ	\N	34
1749	吉祥	jíxiáng	may mắn, cát tường	\N	34
1751	讥笑	jīxiào	châm biếm, nhạo báng, chế giễu	\N	34
1752	机械	jīxiè	máy móc	\N	34
1753	纪要	jìyào	kỷ yếu, tóm tắt	\N	34
1854	课题	kètí	đề tài	\N	32
1727	记者	jìzhě	nhà báo	\N	30
1837	刻	kè	“khắc” = 15 phút	\N	30
1761	举	jǔ	nâng, nhấc, giơ	\N	30
1762	俱乐部	jù lè bù	câu lạc bộ	\N	24
1780	鞠躬	jūgōng	cúi chào, cúi đầu	\N	24
1788	军事	jūnshì	quân sự	\N	27
1789	均匀	jūnyún	đều, dàn	\N	31
1794	据说	jùshuō	nghe nói	\N	33
1800	卡车	kǎchē	xe tải	\N	28
1803	开除	kāichú	khai trừ, đuổi	\N	21
1754	给予	jǐyǔ	dành cho, cho	\N	40
1755	基于	jīyú	dựa trên, căn cứ vào	\N	40
1757	记载	jìzǎi	ghi lại, ghi chép	\N	34
1758	急躁	jízào	nóng vội, hấp tấp	\N	34
1759	及早	jízǎo	sớm, kịp thời	\N	34
1760	机智	jīzhì	lanh trí, tinh nhanh	\N	34
1827	考察	kǎochá	khảo sát, quan sát	\N	27
1828	考古学	kǎogǔxué	khảo cổ học	\N	32
1763	捐	juān	tặng, quyên góp	\N	34
1764	举办	jǔbàn	tổ chức	\N	40
1765	具备	jùbèi	có đủ, có sẵn	\N	34
1766	剧本	jùběn	kịch bản	\N	34
1767	局部	júbù	cục bộ, bộ phận	\N	34
1768	举动	jǔdòng	hành động, động tác	\N	34
1769	决定	juédìng	quyết định	\N	40
1770	绝对	juéduì	tuyệt đối	\N	34
1771	决断	juéduàn	quyết đoán	\N	34
1772	觉察	juéchá	phát giác	\N	40
1774	角色	juésè	vai (vai trò)	\N	34
1775	绝望	juéwàng	tuyệt vọng	\N	34
1776	觉醒	juéxǐng	tỉnh ngộ	\N	34
1777	决议	juéyì	nghị quyết	\N	40
1778	绝缘	juéyuán	cách ly, cách điện	\N	40
1779	拒绝	jùjué	từ chối, cự tuyệt	\N	40
1841	客气	kèqi	khách sáo	\N	30
1781	剧情	jùqíng	tình tiết	\N	40
1782	聚精会神	jùjīnghuìshén	tập trung tinh thần	\N	34
1783	拘谨	jūjǐn	nhút nhát, dè dặt	\N	34
1784	拘留	jūliú	tạm giam, tạm giữ	\N	34
1785	距离	jùlí	khoảng cách	\N	34
1786	剧烈	jùliè	mãnh liệt	\N	34
1857	栭	kě	cây, ngọn	\N	25
1790	居然	jūrán	lại, vậy mà	\N	40
1791	局势	júshì	thế cục, tình hình	\N	40
1792	举世闻名	jǔshì wénmíng	nổi tiếng thế giới	\N	34
1848	颗	kē	hạt, hòn, viên	\N	34
1795	据悉	jùxī	được biết	\N	34
1796	局限	júxiàn	hạn chế, giới hạn	\N	30
1797	举行	jǔxíng	tổ chức, cử hành	\N	40
1798	居住	jūzhù	cư trú, sinh sống	\N	34
1799	举足轻重	jǔzú qīngzhòng	có ảnh hưởng quyết định	\N	34
1801	咖啡	kāfēi	cà phê	\N	26
1802	开	kāi	mở	\N	34
1804	开发	kāifā	khai phá, mở mang	\N	40
1805	开放	kāifàng	mở cửa	\N	40
1806	开朗	kāilǎng	rộng rãi, thoáng mát, sáng sủa	\N	34
1807	开幕式	kāimù shì	lễ khai mạc	\N	40
1808	开辟	kāipì	mở, khai phá, khai thác	\N	40
1809	开始	kāishǐ	bắt đầu	\N	40
1810	开玩笑	kāiwánxiào	đùa, giỡn	\N	40
1811	开心	kāixīn	vui vẻ, hạnh phúc	\N	40
1812	开展	kāizhǎn	triển khai, mở rộng	\N	34
1813	开支	kāizhī	chi tiêu	\N	40
1814	看	kàn	nhìn, xem	\N	40
1816	看来	kànlái	xem ra	\N	40
1817	看不起	kànbuqǐ	coi thường	\N	34
1818	刊登	kāndēng	đăng, xuất bản	\N	40
1819	看法	kànfǎ	quan điểm	\N	40
1820	扛	káng	gánh, vác	\N	28
1822	慷慨激昂	kāngkǎi jī’áng	khảng khái, hùng hồn	\N	34
1823	看见	kànjiàn	nhìn thấy	\N	40
1824	勘探	kāntàn	khảo sát, trinh sát	\N	34
1825	看望	kànwàng	vấn an, thăm hỏi	\N	34
1826	刊物	kānwù	sách báo, ấn phẩm	\N	34
1829	考虑	kǎolǜ	suy nghĩ, cân nhắc	\N	31
1830	考试	kǎoshì	thi cử	\N	32
1831	烤鸭	kǎoyā	vịt nướng	\N	34
1832	考验	kǎoyàn	khảo nghiệm, thử thách	\N	30
1833	卡通	kǎtōng	hoạt hình	\N	34
1834	克	kè	gram	\N	34
1835	渴	kě	khát	\N	30
1836	课	kè	môn, bài	\N	34
1838	客	kè	khách	\N	30
1849	刻苦	kèkǔ	chịu khó, cần cù	\N	34
1850	殼（壳）	ké	vỏ (vật)	\N	34
1851	咳嗽	késou	ho	\N	34
1852	坷垃	kělā	đất vón cục (nếu có)	\N	34
1853	恪守	kèshǒu	tuân thủ nghiêm (nếu có)	\N	40
1858	磕	kē	gõ, đập	\N	34
1859	可爱	kě’ài	đáng yêu, dễ thương	\N	40
1860	刻不容缓	kèbùrónghuǎn	cấp bách, vô cùng khẩn cấp	\N	34
1843	可靠	kěkào	đáng tin cậy	\N	25
1881	口气	kǒuqì	khẩu khí, giọng nói	\N	30
1902	拦	lán	ngăn cản, chặn	\N	24
1909	老	lǎo	già	\N	37
1937	栏目	lánmù	chuyên mục	\N	27
1951	累	lèi	mệt	\N	22
1960	礼拜	lǐbài	lễ, tuần lễ	\N	36
1844	可口	kěkǒu	ngon miệng, vừa miệng	\N	34
1845	可能	kěnéng	có thể, có lẽ	\N	34
1846	可怕	kěpà	đáng sợ	\N	34
1847	可怜	kělián	đáng thương	\N	34
1861	克服	kèfú	vượt qua, khắc phục	\N	34
1862	客户	kèhù	khách hàng	\N	38
1864	科目	kēmù	khoa, môn, môn học	\N	34
1865	肯	kěn	gặm, ria	\N	34
1866	肯定	kěndìng	khẳng định	\N	30
1867	坑	kēng	hố, lỗ	\N	34
1868	恳切	kěnqiè	tha thiết, khẩn thiết	\N	40
1869	客人	kèrén	khách	\N	30
1870	可惜	kěxī	đáng tiếc	\N	40
1872	科学	kēxué	khoa học	\N	34
1873	可以	kěyǐ	có thể	\N	34
1874	孔	kǒng	lỗ	\N	34
1875	恐怕	kǒngpà	e rằng, sợ rằng	\N	34
1876	恐怖	kǒngbù	khủng bố	\N	34
1877	控制	kòngzhì	kiểm soát, khống chế	\N	34
1878	空	kōng	rỗng, trống	\N	34
1879	空气	kōngqì	không khí	\N	34
1880	口	kǒu	miệng, khẩu	\N	24
1882	口语	kǒuyǔ	khẩu ngữ, tiếng nói	\N	34
1883	哭	kū	khóc	\N	34
1884	苦	kǔ	khổ, đắng	\N	34
1886	跨	kuà	bước dài, xoài bước	\N	34
1887	快	kuài	nhanh	\N	34
1888	快乐	kuàilè	vui vẻ, sung sướng	\N	34
1889	筷子	kuàizi	đũa	\N	40
1890	宽	kuān	rộng, khoan dung	\N	34
1891	款待	kuǎndài	khoản đãi, chiêu đãi	\N	34
1892	框架	kuàngjià	khung, sườn, dàn giáo	\N	34
1893	矿泉水	kuàngquánshuǐ	nước khoáng	\N	34
1894	况且	kuàngqiě	vả lại, hơn nữa	\N	34
1896	困难	kùnnán	khó khăn, trở ngại	\N	34
1897	扩大	kuòdà	mở rộng, khuếch trương	\N	34
1898	扩充	kuòchōng	khuếch tán, lan rộng	\N	34
1899	扩展	kuòzhǎn	phát triển, mở rộng	\N	34
1900	拉	lā	kéo	\N	34
1901	辣椒	làjiāo	ớt	\N	34
1903	蓝	lán	xanh lam	\N	34
1904	烂	làn	nát, thối rữa	\N	40
1905	懒	lǎn	lười biếng	\N	34
1906	狼	láng	chó sói	\N	34
1907	浪费	làngfèi	lãng phí	\N	21
1908	浪漫	làngmàn	lãng mạn	\N	21
1911	老百姓	lǎobǎixìng	dân thường	\N	34
1912	老师	lǎoshī	giáo viên	\N	34
1913	老鼠	lǎoshǔ	chuột	\N	34
1914	宽敞	kuānchǎng	rộng lớn	\N	34
1915	宽带	kuāndài	băng thông rộng	\N	34
1916	潰	kuì	hủy hoại	\N	34
1917	苦恼	kǔnǎo	đau khổ, khổ não	\N	34
1918	苦涩	kǔsè	đắng chát	\N	31
1920	库	kù	kho	\N	34
1921	裤子	kùzi	quần	\N	27
1922	块	kuài	miếng, viên, bánh	\N	34
1923	捆	kǔn	bó, buộc	\N	34
1924	捆绑	kǔnbǎng	trói, buộc, ràng buộc	\N	34
1925	困虫	kùnchóng	côn trùng	\N	34
1926	扩	kuò	mở rộng	\N	34
1927	扩张	kuòzhāng	mở rộng, bành trướng	\N	40
1928	来	lái	đến, tới	\N	34
1929	来不及	láibùjí	không kịp	\N	34
1930	来得及	láidéjí	kịp thời	\N	35
1931	来历	láilì	lai lịch, nguồn gốc	\N	34
1932	来源	láiyuán	nguồn gốc	\N	34
1933	来自	láizì	đến từ	\N	40
1935	狼狈	lángbèi	nhếch nhác, chẳng ra làm sao cả	\N	34
1936	朗读	lǎngdú	đọc to, đọc diễn cảm	\N	34
1938	劳动	láodòng	lao động	\N	34
1939	老虎	lǎohǔ	con hổ	\N	34
1940	老实	lǎoshí	thật thà	\N	30
1941	老婆	lǎopó	vợ	\N	34
1943	老婆心	lǎopoxīn	lòng nhân từ	\N	34
1944	老人	lǎorén	người già	\N	34
1945	蜡烛	làzhú	cây nến, nến	\N	40
1946	勒	lēi	buộc, trói	\N	34
1947	了	le	rồi	\N	35
1948	乐观	lèguān	lạc quan	\N	31
1949	雷	léi	sấm	\N	34
1950	类	lèi	loại, thể loại	\N	34
1952	雷达	léidá	radar	\N	40
1953	类似	lèisì	na ná, tương tự, giống	\N	34
1954	冷	lěng	lạnh	\N	34
1955	冷淡	lěngdàn	lạnh nhạt, lãnh đạm	\N	34
1956	冷静	lěngjìng	vắng vẻ, yên tĩnh	\N	34
1958	里	lǐ	trong	\N	34
1959	里边	lǐbiān	bên trong	\N	34
1961	礼节	lǐjié	lễ nghi, phép lịch sự	\N	36
1962	礼貌	lǐmào	lễ phép	\N	34
1981	体谅	tǐliàn	rèn luyện	\N	34
2031	理智	lǐzhì	lý trí	\N	38
1979	连年	liánnián	liên tục nhiều năm	\N	40
2008	立体	lìtǐ	lập thể	\N	37
1963	礼物	lǐwù	quà, lễ vật	\N	40
2052	论文	lùnwén	luận văn	\N	33
2055	落后	luòhòu	lạc hậu, rơi lại phía sau	\N	24
2057	落实	luòshí	đầy đủ chu đáo, làm cho chắc chắn	\N	40
1964	礼堂	lǐtáng	lễ đường	\N	34
1965	立场	lìchǎng	lập trường	\N	34
1966	立方	lìfāng	hình lập phương	\N	34
1967	利害	lìhài	lợi hại, ghê gớm	\N	34
1968	立即	lìjí	ngay lập tức	\N	30
1969	利益	lìyì	lợi ích	\N	34
1971	立刻	lìkè	ngay lập tức	\N	30
1972	粮食	liángshi	thức ăn	\N	30
1973	良心	liángxīn	lương tâm	\N	34
1974	联合	liánhé	liên hiệp	\N	34
1975	联欢	liánhuān	liên hoan	\N	34
1976	廉洁	liánjié	trong sạch, liêm khiết	\N	34
1977	联系	liánluò	liên lạc, liên hệ	\N	40
1978	联盟	liánméng	liên minh	\N	40
1980	连锁	liánsuǒ	dây chuyền, móc nối	\N	40
1982	领会	liǎngkuai	mát mẻ	\N	34
1984	连系	liánxì	liên hệ	\N	40
1985	练习	liànxí	luyện tập	\N	34
1986	练功	liàngtóng	luyện công, rèn luyện	\N	34
1987	连续剧	liánxùjù	phim nhiều tập	\N	40
1988	了解	liǎojiě	hiểu rõ, biết rõ	\N	35
1989	了不起	liǎobuqǐ	tài ba, giỏi lắm	\N	35
1991	料	liào	nguyên liệu	\N	40
1992	料理	liàolǐ	nấu ăn, quản lý	\N	40
1993	列车	lièchē	xe lửa, tàu hỏa	\N	28
1994	烈士	lièshì	liệt sĩ	\N	40
1996	烈焰	lièyàn	ngọn lửa dữ	\N	34
1997	力气	lìqi	sức lực	\N	30
1998	领域	lǐngyù	lĩnh vực	\N	40
1999	邻居	línjū	hàng xóm	\N	34
2000	淋浴	línyù	tắm vòi	\N	34
2001	临时	línshí	tạm thời	\N	34
2003	例如	lìrú	ví dụ	\N	40
2004	利润	lìrùn	lợi nhuận	\N	34
2005	历史	lìshǐ	lịch sử	\N	36
2006	理所当然	lǐsuǒdāngrán	tất nhiên	\N	35
2009	力图	lìtú	mưu cầu, gắng đạt được	\N	24
2010	留	liú	ở lại, lưu lại, giữ lại	\N	34
2011	流	liú	chảy	\N	40
2012	滑	huá	trượt	\N	34
2013	流传	liúchuán	lưu truyền	\N	34
2014	浏览	liúlǎn	xem lướt qua	\N	34
2015	流浪	liúlàng	lang thang, lưu lạc	\N	30
2016	流泪	liúlèi	chảy nước mắt	\N	34
2017	流量	liúliàng	lưu lượng	\N	34
2018	留恋	liúliàn	lưu luyến, không muốn rời xa	\N	34
2019	流露	liúlù	bộc lộ, thổ lộ	\N	34
2020	流氓	liúmáng	lưu manh	\N	34
2022	留意	liúyì	lưu ý, để ý cẩn thận	\N	30
2023	流通	liútōng	lưu thông, thoáng, không bí	\N	34
2024	流行	liúxíng	thịnh hành, lưu hành	\N	30
2025	留学	liúxué	du học	\N	34
2026	例外	lìwài	ngoại lệ	\N	34
2027	理想	lǐxiǎng	lý tưởng	\N	34
2028	利息	lìxī	lãi, lợi tức	\N	34
2029	利用	lìyòng	lợi dụng	\N	34
2030	理由	lǐyóu	lý do	\N	34
2033	立足	lìzú	đứng chân, chỗ dựa, chỗ đứng	\N	34
2034	龙	lóng	con rồng	\N	34
2035	聋哑	lóng yǎ	người câm điếc	\N	34
2036	垄断	lǒngduàn	lũng đoạn, độc quyền	\N	34
2037	隆重	lóngzhòng	long trọng, linh đình	\N	34
2038	漏	lòu	rò rỉ	\N	34
2039	搂	lǒu	ôm	\N	34
2040	楼	lóu	lầu, tầng	\N	24
2041	露	lù	sương	\N	34
2042	绿	lǜ	xanh	\N	34
2043	陆续	lùxù	lần lượt	\N	34
2044	乱	luàn	lộn xộn, bừa bãi	\N	34
2045	屡次	lǚcì	nhiều lần, liên tiếp	\N	34
2046	掠夺	lüèduó	cướp đoạt	\N	34
2047	略微	lüèwēi	hơi	\N	34
2049	轮廓	lúnkuò	đường viền	\N	34
2050	轮流	lúnliú	thay phiên nhau	\N	40
2051	论坛	lùntán	diễn đàn	\N	40
2053	论证	lùnzhèng	luận chứng, chứng minh	\N	40
2054	落成	luòchéng	hoàn thành, khánh thành	\N	40
2056	逻辑	luójí	logic	\N	34
2058	螺丝钉	luósīdīng	đinh ốc	\N	34
2059	啰嗦	luōsuo	lắm lời	\N	34
2061	录取	lùqǔ	tuyển chọn, nhận vào	\N	40
2062	律师	lǜshī	luật sư	\N	40
2063	旅行	lǚxíng	thực hiện, thực thi	\N	40
2064	录音	lùyīn	ghi âm	\N	34
2065	旅游	lǚyóu	du lịch	\N	31
2066	炉灶	lúzào	bếp lò	\N	34
2067	吗	ma	à, ư	\N	35
2069	马	mǎ	ngựa	\N	25
2081	妈妈	māma	mẹ	\N	22
2082	麻木	mámù	tê	\N	36
2093	慢性	mànxìng	mãn tính	\N	31
2106	码头	mǎtóu	bến tàu	\N	28
2124	谜语	míyǔ	câu đố	\N	33
2070	麻	má	gai, tê	\N	40
2072	麻烦	máfan	làm phiền, phiền hà	\N	40
2073	马虎	mǎhu	qua loa, đại khái, tạm tạm	\N	34
2074	卖	mài	bán	\N	40
2075	迈	mài	đi bước dài	\N	34
2076	买	mǎi	mua	\N	40
2077	脉搏	màibó	mạch	\N	21
2078	埋伏	máifú	mai phục	\N	40
2079	麦克风	màikèfēng	microphone	\N	34
2083	慢	màn	chậm, từ từ	\N	34
2084	满	mǎn	đầy, chất	\N	40
2085	漫长	màncháng	dài dằng dặc, dài đằng đẵng	\N	34
2086	忙	máng	bận	\N	34
2087	忙碌	mánglù	bận rộn	\N	34
2088	茫茫	mángmáng	mênh mông, mịt mù	\N	34
2089	盲目	mángmù	mù quáng	\N	27
2091	漫画	mànhuà	hoạt họa	\N	34
2092	馒头	mántou	màn thầu, bánh bao không nhân	\N	21
2094	蔓延	mànyán	lan tràn, lan ra	\N	40
2095	满意	mǎnyì	hài lòng	\N	34
2096	埋怨	mányuàn	oán trách, oán hận	\N	34
2097	满足	mǎnzú	thỏa mãn, làm thỏa mãn	\N	34
2098	毛	máo	lông	\N	34
2099	猫	māo	mèo	\N	34
2101	矛盾	máodùn	mâu thuẫn	\N	30
2102	冒险	màoxiǎn	mạo hiểm, phiêu lưu	\N	34
2103	贸易	màoyì	buôn bán	\N	34
2104	帽子	màozi	mũ	\N	27
2105	马上	mǎshàng	ngay	\N	40
2107	麻醉	mázuì	gây tê	\N	40
2108	枚	méi	cái, tấm	\N	34
2109	没	méi	chưa, không	\N	34
2110	每	měi	mỗi	\N	34
2111	美	měi	đẹp	\N	34
2113	美满	měimǎn	cuộc sống đầy đủ, đầm ấm, mỹ mãn	\N	34
2114	眉毛	méimáo	lông mày	\N	34
2115	媒体	méitǐ	truyền thông	\N	34
2116	美容	měiróng	làm đẹp	\N	34
2117	美术	měishù	mỹ thuật	\N	30
2118	美味	měiwèi	ngon miệng	\N	34
2119	美元	měiyuán	đô la Mỹ	\N	34
2120	妹妹	mèimei	em gái	\N	40
2121	魅力	mèilì	sức quyến rũ	\N	34
2122	门	mén	cửa	\N	40
2125	没辙	méizhé	bế tắc, chịu	\N	40
2126	梦	mèng	mộng, giấc mơ	\N	34
2127	猛	měng	dữ dội	\N	34
2128	猛烈	měngliè	dữ dội	\N	34
2129	梦想	mèngxiǎng	giấc mơ	\N	34
2130	萌芽	méngyá	mầm, chồi non	\N	34
2131	门诊	ménzhěn	phòng khám bệnh	\N	34
2132	米	mǐ	gạo	\N	34
2133	眯	mī	chớp mắt	\N	34
2134	面对	miàn duì	đối mặt	\N	34
2135	面包	miànbāo	bánh mì	\N	26
2136	免得	miǎnde	để tránh	\N	35
2138	棉花	miánhuā	bông	\N	34
2139	勉励	miǎnlì	khuyến khích	\N	40
2140	面临	miànlín	đối mặt với	\N	34
2141	勉强	miǎnqiáng	gượng gạo, miễn cưỡng	\N	34
2142	面条	miàntiáo	mì	\N	26
2143	面子	miànzi	mặt	\N	34
2144	描写	miáoxiě	miêu tả	\N	40
2145	弥补	míbǔ	bù đắp, đền bù	\N	34
2146	密度	mìdù	độ dày, mật độ	\N	34
2147	蔑视	mièshì	khinh miệt	\N	40
2148	灭亡	mièwáng	chết	\N	40
2149	密封	mìfēng	niêm phong	\N	34
2151	迷惑	míhuò	mê hoặc	\N	34
2152	迷路	mílù	lạc đường	\N	34
2153	密码	mìmǎ	mật mã	\N	34
2154	迷茫	mímáng	mù mịt, mờ mịt	\N	34
2155	秘密	mìmì	bí mật	\N	34
2156	敏感	mǐngǎn	nhạy cảm	\N	40
2157	明白	míngbai	rõ ràng	\N	34
2158	名次	míngcì	thứ tự	\N	30
2160	名副其实	míngfùqíshí	đúng sự thật	\N	34
2161	命令	mìnglìng	mệnh lệnh	\N	40
2162	明明	míngmíng	rõ ràng	\N	34
2163	命名	mìngmíng	đặt tên	\N	40
2164	名牌	míngpái	thương hiệu	\N	34
2165	明显	míngxiǎn	rõ ràng	\N	34
2166	明信片	míngxìnpiàn	bưu thiếp	\N	34
2167	名誉	míngyù	danh dự	\N	31
2168	名字	míngzi	tên	\N	34
2170	敏捷	mǐnjié	nhanh nhẹn	\N	34
2171	敏锐	mǐnruì	sắc sảo	\N	34
2172	民用	mínyòng	dân dụng	\N	40
2173	民主	mínzhǔ	dân chủ	\N	31
2174	民族	mínzú	dân tộc	\N	34
2175	密切	mìqiè	mật thiết	\N	40
2176	迷人	mírén	cuốn hút	\N	34
2178	秘书	mìshū	thư ký	\N	30
2179	迷信	míxìn	mê tín	\N	40
2233	捏	niē	nhón, nhặt, cầm	\N	34
2242	女士	nǚshì	cô, chị, bà	\N	34
2251	哪儿	nǎr	chỗ nào, đâu	\N	24
2189	模式	móshì	kiểu mẫu	\N	24
2236	牛	niú	trâu, bò	\N	26
2213	难看	nánkàn	xấu xí	\N	24
2221	馁	něi	nản chí	\N	31
2225	能干	nénggàn	tài giỏi, giỏi giang	\N	30
2227	年	nián	năm	\N	30
2273	牛仔裤	niúzǎikù	quần jean	\N	27
2288	呕吐	ǒutù	nôn mửa	\N	30
2256	嫩	nèn	mềm, non	\N	22
2262	年度	niándù	năm	\N	30
2180	摸	mō	mò	\N	34
2182	模仿	mófǎng	bắt chước	\N	34
2183	魔鬼	móguǐ	ma quỷ	\N	21
2184	磨合	móhé	chạy thử	\N	40
2185	模糊	móhu	mờ, mơ hồ	\N	34
2187	默默	mòmò	âm thầm	\N	34
2188	陌生	mòshēng	lạ	\N	32
2247	派	pài	phái, cử, đát cử	\N	40
2190	牧师	mùshī	mục sư	\N	32
2192	模型	móxíng	mô hình	\N	34
2193	目标	mùbiāo	mục tiêu	\N	40
2194	目的	mùdì	mục đích	\N	35
2195	目光	mùguāng	ánh mắt	\N	34
2196	目录	mùlù	mục lục	\N	27
2197	母亲	mǔqīn	mẹ	\N	22
2199	模样	múyàng	dáng dấp	\N	33
2200	沐浴	mùyù	tắm gội	\N	34
2201	拿	ná	cầm, lấy	\N	40
2202	那	nà	kia, đó	\N	34
2203	奶奶	nǎinai	bà	\N	21
2205	耐用	nàiyòng	bền	\N	40
2206	纳闷儿	nàmèn er	bối rối	\N	40
2207	南	nán	phía nam	\N	40
2208	难	nán	khó	\N	34
2209	难道	nándào	lẽ nào	\N	34
2210	难得	nándé	khó có được	\N	35
2211	难怪	nánguài	thảo nào	\N	34
2283	女人	nǚrén	con gái, phụ nữ	\N	22
2214	难免	nánmiǎn	không tránh khỏi	\N	34
2215	难能可贵	nánnéngkěguì	đáng khen ngợi	\N	34
2216	男人	nánrén	đàn ông	\N	34
2217	难受	nánshòu	khó chịu	\N	34
2218	脑袋	nǎodai	đầu	\N	24
2220	呢	ne	thế, nhỉ, vậy, nhé, cơ	\N	35
2249	盘子	pánzi	đĩa, mâm, khay	\N	34
2222	内	nèi	bên trong, nội	\N	34
2223	内容	nèiróng	nội dung	\N	34
2224	内科	nèikē	nội khoa	\N	34
2226	能力	nénglì	năng lực	\N	34
2228	年级	niánjí	lớp	\N	34
2229	年纪	niánjì	tuổi tác	\N	34
2231	念	niàn	nhớ, suy nghĩ, đọc	\N	34
2232	鸟	niǎo	chim	\N	25
2234	宁可	níngkě	thà rằng	\N	30
2235	宁愿	níngyuàn	thà, thà rằng	\N	30
2237	农民	nóngmín	nông dân	\N	34
2239	浓	nóng	đặc, đậm	\N	34
2240	暖和	nuǎnhuo	ấm áp	\N	35
2241	女儿	nǚ’ér	con gái	\N	34
2243	怕	pà	sợ	\N	34
2244	拍	pāi	vỗ, đập	\N	34
2245	排	pái	hàng, xếp	\N	34
2246	牌	pái	thẻ, bảng	\N	34
2250	判断	pànduàn	phán đoán	\N	34
2252	拿手	náshǒu	sở trường, tài năng	\N	34
2253	内涵	nèihán	nội hàm	\N	34
2254	内幕	nèimù	nội tình, tình hình bên trong	\N	34
2255	内在	nèizài	bên trong, nội tại	\N	34
2257	能	néng	có thể	\N	34
2259	能源	néngyuán	nguồn năng lượng	\N	34
2260	你	nǐ	anh, chị, ông, bà…	\N	34
2261	年代	niándài	niên đại, thời đại	\N	34
2263	年轻	niánqīng	trẻ	\N	30
2264	拟定	nǐdìng	định ra, vạch ra	\N	40
2265	您	nín	ngài, ông	\N	34
2266	宁	níng	yên, tĩnh	\N	40
2268	凝结	níngjié	ngưng tụ, đông lại	\N	34
2269	凝视	níngshì	nhìn chòng chọc	\N	34
2270	宁静	níngjìng	yên tĩnh, bình lặng	\N	40
2271	纽扣儿	niǔkòur	cúc áo	\N	34
2272	牛奶	niúnǎi	sữa bò	\N	34
2274	扭转	niǔzhuǎn	xoay, quay	\N	34
2275	弄	nòng	làm	\N	40
2276	农村	nóngcūn	nông thôn	\N	34
2277	农夫	nóngfū	nông dân	\N	34
2278	农历	nónglì	âm lịch	\N	34
2280	奴隶	núlì	nô lệ	\N	34
2281	努力	nǔlì	cố gắng, nỗ lực	\N	34
2282	挪	nuó	di chuyển	\N	40
2284	哦	ó	hừ, hả	\N	30
2285	欧打	ōudǎ	đánh nhau	\N	24
2286	偶尔	ǒu’ěr	thỉnh thoảng, ngẫu nhiên	\N	34
2287	偶然	ǒurán	tình cờ, ngẫu nhiên	\N	34
2290	派对	pàiduì	tiệc	\N	40
2291	排放	páifàng	thải ra	\N	40
2292	排斥	páichì	bài xích, bài bác	\N	21
2293	排除	páichú	loại trừ	\N	34
2304	盘旋	pánxuán	quanh quẩn, luẩn quẩn	\N	27
2315	盆	pén	chậu, bồn	\N	24
2321	朋友	péngyǒu	bạn, bạn bè	\N	22
2322	匹	pǐ	con (ngựa, la...)	\N	25
2341	平等	píngděng	bình đẳng	\N	31
2347	评估	pínggū	đánh giá	\N	37
2361	品行	pǐnxíng	hạnh kiểm	\N	22
2366	皮鞋	píxié	giày da	\N	27
2398	铅笔	qiānbǐ	bút chì	\N	22
2295	排列	páiliè	sắp xếp, sắp đặt	\N	40
2296	派遣	pàiqiǎn	cử, phái, điều động	\N	34
2297	派球	páiqiú	bóng chuyền	\N	34
2298	盘	pán	đĩa, mâm, khay	\N	34
2299	胖	pàng	béo	\N	34
2300	盼望	pànwàng	mong mỏi, trông chờ	\N	34
2301	判	pàn	phán quyết, kết án	\N	30
2303	庞大	pángdà	to lớn	\N	34
2305	跑	pǎo	chạy	\N	40
2306	跑步	pǎobù	chạy bộ	\N	40
2307	抛弃	pāoqì	vứt bỏ, quăng đi	\N	40
2308	爬山	páshān	leo núi	\N	40
2309	陪	péi	dẫn dắt, cùng đưa	\N	40
2310	配备	pèibèi	phân phối	\N	34
2312	配套	pèitào	đồng bộ	\N	34
2313	培训	péixùn	bồi dưỡng, đào tạo	\N	34
2314	培养	péiyǎng	rèn luyện, bồi dưỡng	\N	34
2316	盆地	péndì	thung lũng, lòng chảo	\N	35
2317	膨胀	péngzhàng	bành trướng, phình to	\N	34
2318	碰	pèng	đụng, va	\N	34
2319	碰见	pèngjiàn	gặp	\N	28
2320	烹饪	pēngrèn	nấu ăn	\N	24
2323	批	pī	bó, chẻ	\N	34
2324	批发	pīfā	bán sỉ	\N	40
2326	批准	pīzhǔn	phê chuẩn	\N	40
2327	疲惫	píbèi	kiệt quệ	\N	40
2328	皮	pí	da	\N	21
2329	皮肤	pífū	da	\N	21
2330	屁股	pìgu	mông, đít	\N	34
2331	啤酒	píjiǔ	bia	\N	26
2332	疲劳	píláo	mệt mỏi	\N	40
2334	品尝	pǐncháng	nếm, thử	\N	30
2335	频道	píndào	kênh	\N	34
2336	品德	pǐndé	đạo đức	\N	34
2337	贫乏	pínfá	nghèo	\N	34
2338	频繁	pínfán	thường xuyên	\N	34
2339	平	píng	dựa vào	\N	40
2340	平常	píngcháng	thông thường	\N	34
2342	平凡	píngfán	bình thường	\N	34
2344	评价	píngjià	đánh giá	\N	37
2345	苹果	píngguǒ	quả táo	\N	34
2346	平衡	pínghéng	cân bằng	\N	34
2348	平静	píngjìng	yên lặng	\N	34
2349	评论	pínglùn	bình luận, nhận xét	\N	40
2350	平面	píngmiàn	mặt bằng, mặt phẳng	\N	34
2351	乒乓球	pīngpāngqiú	bóng bàn	\N	34
2353	平坦	píngtǎn	bằng phẳng	\N	34
2354	平行	píngxíng	song song	\N	34
2355	平原	píngyuán	đồng bằng	\N	34
2356	屏障	píngzhàng	rào chắn	\N	34
2357	瓶子	píngzi	lọ, bình	\N	34
2358	贫穷	pínqióng	nghèo nàn	\N	34
2359	频率	pínlǜ	tần số	\N	34
2360	品味	pǐnwèi	khiếu thẩm mỹ	\N	34
2362	品质	pǐnzhì	chất lượng	\N	34
2363	品种	pǐnzhǒng	giống, loại, chủng loại	\N	34
2365	譬如	pìrú	ví dụ	\N	40
2367	泼	pō	hắt, giội, vẩy (nước)	\N	30
2368	迫	pò	vỡ, thũng, phá vỡ	\N	34
2369	破	pò	sườn dốc, dốc	\N	34
2370	颇	pō	rất, tương đối, khá	\N	34
2371	迫不及待	pòbùjídài	không thể chờ đợi	\N	34
2372	破产	pòchǎn	phá sản	\N	30
2373	破坏	pòhuài	phá hoại	\N	34
2374	破裂	pòliè	phá vỡ, nứt vỡ	\N	34
2375	魄力	pòlì	kiên quyết, quyết đoán	\N	34
2376	迫切	pòqiè	bức thiết, cấp bách	\N	40
2377	铺	pū	trải, dọn	\N	34
2378	普遍	pǔbiàn	phổ biến, rộng rãi	\N	34
2379	普及	pǔjí	thịnh hành	\N	30
2381	仆人	púrén	đầy tớ	\N	34
2382	朴素	pǔsù	giản dị, mộc mạc	\N	34
2383	普通话	pǔtōnghuà	tiếng phổ thông	\N	34
2384	七	qī	bảy	\N	21
2385	卡	qiǎ	kẹt, véo	\N	34
2386	恰当	qiàdàng	thích hợp, thỏa đáng	\N	34
2387	恰到好处	qiàdàohǎochù	đúng dịp, đúng mục đích	\N	34
2388	钱	qián	tiền	\N	40
2389	浅	qiǎn	nông, nhạt	\N	34
2391	前提	qiántí	tiền đề	\N	40
2392	潜力	qiánlì	tiềm năng	\N	34
2393	潜水	qiánshuǐ	lặn	\N	21
2394	签	qiān	ký	\N	21
2395	签订	qiāndìng	ký kết	\N	40
2399	千方百计	qiānfāngbǎijì	tất cả mọi thủ đoạn	\N	40
2400	墙	qiáng	tường, bức tường	\N	34
2401	抢	qiǎng	cướp lấy, vồ lấy	\N	40
2402	抢夺	qiǎngduó	cướp lấy	\N	40
2405	强烈	qiángliè	mạnh mẽ	\N	22
2437	起初	qǐchǐ	lúc đầu	\N	24
2420	牵头	qiāntóu	đứng đầu	\N	24
2451	请求	qǐngqiú	yêu cầu, xin	\N	24
2468	青	qīng	màu xanh, thanh	\N	24
2479	请教	qǐngjiāo	thỉnh giáo, xin chỉ bảo	\N	32
2495	庆祝	qìngzhù	chúc mừng	\N	36
2503	亲身	qīnshēn	bản thân, tự mình	\N	22
2403	抢劫	qiǎngjié	cướp tài sản	\N	34
2404	强调	qiángdiào	nhấn mạnh	\N	34
2406	强迫	qiǎngpò	ép buộc	\N	34
2407	强制	qiángzhì	cưỡng chế	\N	34
2408	抢救	qiǎngjiù	cứu giúp	\N	40
2410	谦虚	qiānxū	khiêm tốn	\N	34
2411	前面	qiánmiàn	phía trước	\N	34
2412	前途	qiántú	tương lai, triển vọng	\N	34
2413	前进	qiánjìn	tiến lên	\N	40
2414	谦逊	qiānxùn	khiêm nhường	\N	34
2415	谴责	qiǎnzé	lên án	\N	40
2416	欠	qiàn	nợ	\N	34
2417	嵌入	qiànrù	nhúng vào	\N	34
2418	牵挂	qiānguà	lo lắng	\N	34
2421	迁就	qiānjiù	nhân nhượng, cả nể	\N	34
2422	迁移	qiānyí	di chuyển	\N	40
2423	谦让	qiānràng	nhường nhịn	\N	34
2424	潜移默化	qiānyímóhuà	thay đổi một cách vô tri vô giác	\N	40
2425	牵制	qiānzhì	kiềm chế, hàm chứa	\N	40
2426	签字	qiānzi	ký tên	\N	34
2427	桥	qiáo	cây cầu	\N	24
2428	瞧	qiáo	nhìn	\N	40
2429	乔	qiáo	vênh, vểnh, bảnh	\N	34
2430	敲	qiāo	gõ, khua, bật dậy	\N	40
2431	巧克力	qiǎokèlì	sô cô la	\N	34
2432	巧妙	qiǎomiào	khéo léo, tài tình	\N	40
2433	悄悄	qiāoqiāo	lặng lẽ	\N	21
2435	洽谈	qiàtán	trò chuyện, bàn luận	\N	34
2436	器材	qìcái	khí tài, dụng cụ	\N	40
2438	启程	qǐchéng	khởi hành, lên đường	\N	34
2439	起床	qǐchuáng	ngủ dậy	\N	39
2440	其次	qícì	thứ hai, tiếp đó	\N	34
2441	期待	qídài	kỳ vọng, mong đợi	\N	34
2442	锲而不舍	qǐ'érbùshě	kiên nhẫn, miệt mài	\N	35
2444	启发	qǐfā	gợi ý	\N	34
2445	起飞	qǐfēi	cất cánh	\N	40
2446	起伏	qǐfú	không khí	\N	34
2447	起句	qǐjǔ	nhập nho, lên xuống	\N	34
2449	起海	qǐhài	khí khái, khí phách	\N	21
2450	请	qǐng	xin, mời	\N	34
2452	气功	qìgōng	khí công	\N	34
2453	奇怪	qíguài	kỳ lạ, quái lạ	\N	34
2454	器官	qìguān	cơ quan	\N	34
2455	起哄	qǐhòng	đùa bỡn, giỡn cợt	\N	40
2456	气候	qìhòu	khí hậu	\N	30
2457	奇迹	qǐjì	kỳ tích, kỳ công	\N	34
2459	迄今为止	qíjīn wèizhǐ	cho đến nay	\N	40
2460	起来	qǐlái	đứng dậy, ngồi dậy	\N	40
2461	凄凉	qǐliáng	lạnh lẽo, tiêu điều	\N	34
2462	奇妙	qímiào	kỳ diệu, tinh xảo	\N	34
2463	亲爱	qīn'ài	thân ái, thương yêu	\N	34
2464	侵犯	qīnfàn	xâm phạm, can thiệp	\N	34
2465	勤奋	qínfèn	siêng năng, cần cù	\N	34
2466	晴	qíng	trời nắng	\N	34
2467	轻	qīng	nhẹ, nhẹ nhàng	\N	34
2469	清	qīng	trong, sạch	\N	34
2470	情报	qíngbào	tình báo, thông tin	\N	34
2471	清澈	qīngchè	trong veo, trong suốt	\N	34
2472	清晨	qīngchén	sáng sớm	\N	34
2474	青春	qīngchūn	tuổi trẻ	\N	34
2475	轻淡	qīngdàn	nhạt, loãng, nhẹ	\N	34
2476	轻而易举	qīng'éryìjiǎo	dễ dàng	\N	35
2477	请假	qǐngjià	xin nghỉ	\N	40
2478	请柬	qǐngjiǎn	thiệp mời	\N	34
2480	情节	qíngjié	tình tiết, trường hợp	\N	34
2481	清静	qīngjìng	yên tĩnh	\N	40
2482	请客	qǐngkè	mời khách, đãi khách	\N	34
2483	情况	qíngkuàng	tình hình	\N	40
2484	晴朗	qínglǎng	nắng, trong sáng	\N	34
2485	情理	qínglǐ	lý lẽ, đạo lý	\N	34
2486	青年	qīngnián	thanh niên	\N	40
2488	轻视	qīngshì	khinh thường	\N	34
2489	轻松	qīngsōng	nhẹ nhõm, thoải mái	\N	34
2490	倾听	qīngtīng	lắng nghe, chú ý nghe	\N	33
2491	清晰	qīngxī	rõ ràng, rõ rệt	\N	34
2492	倾斜	qīngxié	nghiêng, lệch, xiêu vẹo	\N	34
2493	清醒	qīngxǐng	tỉnh táo	\N	34
2494	情绪	qíngxù	tâm trạng, cảm xúc	\N	34
2496	勤俭	qínjiǎn	tiết kiệm	\N	40
2498	侵略	qīnlüè	xâm lược	\N	34
2499	钦佩	qīnpèi	khâm phục	\N	34
2500	亲戚	qīnqī	thân thích, người thân	\N	34
2501	亲切	qīnqiè	thân thiết	\N	40
2502	亲热	qīnre	thân mật, nồng nhiệt	\N	34
2504	穷	qióng	nghèo	\N	34
2520	企业	qǐyè	xí nghiệp	\N	38
2545	热爱	rè’ài	yêu nhiệt thành	\N	22
2555	任何	rènhé	bất kì	\N	40
2580	荣登	róngdēng	vinh danh	\N	31
2512	其余	qíyú	ngoài ra, còn lại	\N	40
2550	热心	rèxīn	nhiệt tình, sốt sắng	\N	24
2553	仍然	réngrán	vẫn	\N	31
2564	仍旧	réngjiù	như cũ, như trước	\N	34
2505	旗袍	qípáo	sườn xám	\N	34
2506	欺骗	qīpiàn	lừa dối	\N	34
2508	齐全	qíquán	đầy đủ	\N	40
2509	气色	qìsè	thần sắc, khí sắc	\N	30
2510	其实	qíshí	kỳ thực, thực ra	\N	40
2511	气势	qìshì	khí thế	\N	40
2513	企图	qǐtú	mưu đồ, ý đồ	\N	34
2514	球迷	qiúmí	người hâm mộ	\N	34
2515	气味	qìwèi	mùi vị	\N	30
2517	气象	qìxiàng	khí tượng học	\N	34
2518	齐心协力	qíxīn xiélì	đồng tâm hiệp lực	\N	34
2519	气压	qìyā	áp suất khí quyển	\N	40
2521	起义	qǐyì	khởi nghĩa	\N	34
2522	汽油	qìyóu	xăng	\N	28
2523	岂有此理	qǐ yǒu cǐ lǐ	lẽ nào lại như vậy	\N	40
2524	起源	qǐyuán	bắt nguồn	\N	34
2525	其中	qízhōng	trong số đó	\N	34
2526	妻子	qīzi	vợ	\N	34
2527	娶	qǔ	lấy vợ	\N	40
2528	去世	qùshì	qua đời	\N	40
2530	去年	qùnián	năm ngoái	\N	34
2531	群众	qúnzhòng	quần chúng	\N	34
2532	裙子	qúnzi	váy	\N	27
2533	趋势	qūshì	khuynh hướng, xu thế	\N	34
2534	曲折	qūzhé	quanh co, khúc khuỷu	\N	34
2535	驱逐	qūzhú	trục xuất	\N	40
2536	燃	rán	nhuộm	\N	34
2538	让	ràng	nhường, mời	\N	34
2539	嚷	rǎng	kêu gào	\N	34
2540	让步	ràngbù	nhượng bộ	\N	34
2541	然后	ránhòu	sau đó, tiếp đó	\N	34
2542	燃烧	ránshāo	đốt cháy	\N	34
2543	扰乱	rǎoluàn	quấy nhiễu, hỗn loạn	\N	40
2544	热	rè	nhiệt, nóng	\N	34
2546	热烈	rèliè	nhiệt liệt, sôi nổi	\N	34
2547	热闹	rènào	náo nhiệt, sôi nổi	\N	34
2548	忍	rěn	nhẫn, chịu	\N	40
2551	认识	rènshi	biết, nhận biết	\N	40
2552	任务	rènwu	nhiệm vụ	\N	40
2554	扔	rēng	ném, quăng	\N	40
2556	人	rén	người	\N	34
2557	忍耐	rěnnài	kiên nhẫn, nhẫn lại	\N	40
2558	忍受	rěnshòu	chịu đựng	\N	34
2559	热身	rèshēn	khởi động	\N	34
2560	热水器	rèshuǐqì	bình nước nóng	\N	34
2561	热情	rèqíng	nhiệt tình	\N	40
2563	忍心	rěnxīn	nỡ lòng	\N	34
2565	日程	rìchéng	lịch trình	\N	30
2566	日期	rìqī	ngày tháng	\N	30
2567	日记	rìjì	nhật ký	\N	30
2568	日用品	rìyòngpǐn	đồ dùng hằng ngày	\N	40
2569	荣誉	róngyù	vinh dự	\N	40
2570	容易	róngyì	dễ dàng	\N	34
2571	容忍	róngrěn	khoan dung	\N	34
2572	容貌	róngmào	dung mạo	\N	34
2574	容纳	róngnà	chứa đựng	\N	34
2575	融化	rónghuà	tan chảy	\N	40
2576	容器	róngqì	đồ chứa	\N	34
2577	荣幸	róngxìng	vinh hạnh	\N	30
2579	荣华富贵	rónghuá fùguì	vinh hoa phú quý	\N	34
2581	荣耀	róngyào	vinh quang	\N	40
2582	荣军	róngjūn	quân nhân xuất ngũ	\N	40
2583	荣膺	róngyīng	được vinh dự nhận	\N	40
2584	容光焕发	róngguāng huànfā	tươi sáng, rạng rỡ	\N	34
2585	容身	róngshēn	trú thân	\N	21
2586	容不下	róng bù xià	không thể chấp nhận	\N	34
2587	人才	réncái	người tài năng	\N	34
2588	仁慈	réncí	nhân từ	\N	21
2589	人道	réndào	nhân đạo	\N	34
2590	认定	rèndìng	cho rằng, nhận định	\N	40
2591	人格	réngé	nhân cách	\N	21
2592	人工	réngōng	nhân tạo	\N	34
2594	人间	rénjiān	nhân gian, thế giới	\N	30
2595	人可	rénkě	cho phép, đồng ý	\N	34
2596	人口	rénkǒu	dân số	\N	34
2597	人类	rénlèi	nhân loại	\N	34
2598	人民币	rénmínbì	nhân dân tệ	\N	40
2599	任命	rènmìng	bổ nhiệm	\N	40
2600	人生	rénshēng	đời sống, cuộc đời	\N	34
2601	人士	rénshì	nhân sự	\N	21
2602	人为	rénwéi	con người làm ra	\N	40
2603	认为	rènwéi	cho rằng, cho là	\N	40
2604	人物	rénwù	nhân vật	\N	40
2606	任性	rènxìng	tùy hứng	\N	34
2607	任意	rènyì	tùy ý	\N	27
2608	人员	rényuán	nhân viên	\N	40
2609	认真	rènzhēn	chăm chỉ, nghiêm túc	\N	34
2613	鳃	sāi	mang cá	\N	31
2685	剩	shèng	thừa, còn lại	\N	30
2620	三角	sānjiǎo	tam giác	\N	21
2624	啥	shá	cái gì	\N	25
2632	擅长	shàncháng	giỏi	\N	30
2645	商品	shāngpǐn	hàng hóa	\N	38
2672	摄影	shèyǐng	nhiếp ảnh	\N	31
2696	声调	shēngdiào	thanh điệu, giọng	\N	30
2702	生理	shēnglǐ	sinh lý	\N	32
2718	绳子	shéngzi	dây thừng	\N	30
2611	洒	sǎ	rắc, tung, vẩy	\N	40
2612	撒谎	sāhuǎng	nói dối	\N	34
2674	设想	shèxiǎng	tưởng tượng	\N	34
2614	伞	sǎn	ô	\N	34
2615	三	sān	ba	\N	21
2617	散发	sànfā	toả ra, phát ra	\N	40
2618	丧失	sàngshī	mất đi, mất mát	\N	34
2619	嗓子	sǎngzi	cổ họng, giọng	\N	34
2621	散文	sǎnwén	văn xuôi	\N	34
2623	森林	sēnlín	rừng rậm, rừng sâu	\N	34
2625	傻	shǎ	ngu ngốc	\N	34
2626	杀	shā	giết	\N	40
2627	刹车	shāchē	phanh, thắng xe	\N	30
2628	沙发	shāfā	ghế xô-pha	\N	34
2629	晒	shài	phơi nắng	\N	34
2631	沙漠	shāmò	sa mạc	\N	29
2633	删除	shānchú	xóa bỏ	\N	34
2634	闪电	shǎndiàn	tia chớp, sét	\N	40
2635	上	shàng	trên, phía trên	\N	40
2636	伤脑筋	shāng nǎojīn	hại não, tốn tâm trí	\N	34
2637	上班	shàngbān	đi làm	\N	40
2638	商标	shāngbiāo	thương hiệu	\N	34
2639	上当	shàngdàng	bị lừa	\N	40
2640	商店	shāngdiàn	cửa hàng	\N	37
2642	上课	shàngkè	học, lên lớp	\N	40
2643	上进心	shàngjìnxīn	chí tiến thủ	\N	40
2644	商量	shāngliáng	thương lượng, bàn thảo	\N	34
2646	上任	shàngrèn	nhậm chức	\N	34
2647	上网	shàngwǎng	lên mạng	\N	40
2648	上午	shàngwǔ	buổi sáng	\N	34
2649	伤心	shāngxīn	thương tâm, đau lòng	\N	34
2650	上学	shàngxué	đi học	\N	34
2651	上瘾	shàngyǐn	nghiện	\N	40
2652	上游	shàngyóu	thượng du	\N	34
2654	山脉	shānmài	rặng núi, dãy núi	\N	40
2655	闪烁	shǎnshuò	nhấp nháy	\N	40
2656	善于	shànyú	giỏi về	\N	40
2657	扇子	shànzi	cái quạt	\N	40
2658	稍	shāo	hơi, một chút, sơ qua	\N	40
2659	哨	shào	đồn, trạm gác	\N	34
2660	少	shǎo	ít, trẻ	\N	40
2661	捎	shāo	mang hộ, mang giùm	\N	34
2662	烧	shāo	ngon	\N	34
2663	稍微	shāowēi	hơi, một chút, sơ qua	\N	40
2664	勺子	sháozi	cái muỗng	\N	34
2665	沙滩	shātān	bãi biển	\N	40
2666	蛇	shé	con rắn	\N	34
2668	舍不得	shěbude	luyến tiếc, không nỡ	\N	35
2669	射击	shèjī	bắn, xạ kích	\N	34
2670	设计	shèjì	thiết kế	\N	40
2671	社会	shèhuì	xã hội	\N	34
2675	伸	shēn	căng ra, duỗi ra	\N	40
2678	申请	shēn qǐng	xin	\N	40
2679	深奥	shēn’ào	sâu	\N	24
2680	申报	shēnbào	trình báo	\N	34
2681	身材	shēncái	vóc dáng, dáng người	\N	34
2682	审查	shěnchá	xem xét, thẩm tra	\N	34
2683	深沉	shēnchén	sâu lắng	\N	21
2684	身份	shēnfèn	thân phận	\N	30
2686	盛	shèng	chứa, đựng, dung nạp	\N	40
2687	省	shěng	tỉnh, tinh lược, tiết kiệm	\N	34
2688	升	shēng	lít	\N	40
2689	胜负	shèng fù	thắng bại, được thua	\N	30
2690	生锈	shēng xiù	rỉ sét	\N	40
2692	盛产	shèngchǎn	sản xuất nhiều	\N	40
2693	生产	shēngchǎn	sản xuất	\N	38
2694	牲畜	shēngchù	chăn nuôi	\N	34
2695	生存	shēngcún	sống sót	\N	34
2697	生动	shēngdòng	sinh động	\N	34
2698	省会	shěnghuì	thủ phủ của tỉnh	\N	30
2699	生活	shēnghuó	cuộc sống, sống	\N	34
2700	生机	shēngjī	sức sống	\N	34
2701	盛开	shèngkāi	nở hoa	\N	34
2703	省略	shěnglüè	lược bỏ	\N	34
2705	生命	shēngmìng	tính mạng, sinh mạng	\N	40
2706	生气	shēngqì	giận, tức giận	\N	30
2707	深情	shēnqíng	thâm tình	\N	34
2708	生日	shēngrì	sinh nhật	\N	30
2709	声势	shēngshì	thanh thế	\N	30
2710	生疏	shēngshū	mới lạ	\N	34
2711	生态	shēngtài	sinh thái	\N	21
2712	生物	shēngwù	sinh vật	\N	40
2713	生效	shēngxiào	có hiệu lực	\N	34
2714	盛行	shèngxíng	thịnh hành	\N	30
2716	声誉	shēngyù	danh tiếng	\N	40
2717	生育	shēngyù	sinh đẻ	\N	40
2720	审问	shěnwèn	thẩm vấn	\N	34
2725	审判	shěnpàn	xét xử	\N	28
2807	试图	shìtú	tính toán, thử, định	\N	30
2820	实用	shíyòng	sử dụng	\N	40
2732	渗透	shèntòu	thấm thấu	\N	24
2737	摄取	shèqǔ	hấp thu, (dinh dưỡng)	\N	30
2755	时常	shícháng	thường	\N	30
2758	世代	shìdài	thế hệ	\N	37
2762	时光	shíguāng	thời gian	\N	30
2769	实惠	shíhuì	lợi ích thực tế	\N	30
2776	时间	shíjiān	thời gian	\N	30
2715	声音	shēngyīn	tiếng, âm thanh	\N	34
2721	深刻	shēnkè	sâu sắc	\N	24
2723	审美	shěnměi	thẩm mỹ	\N	34
2724	神秘	shénmì	thần bí, bí ẩn	\N	30
2778	世界	shìjiè	thế giới	\N	30
2726	神气	shénqì	thần sắc, thần khí	\N	30
2727	深情厚谊	shēnqíng hòuyì	tình bạn thân thiết	\N	40
2728	神色	shénsè	thần sắc	\N	30
2729	神圣	shénshèng	thiêng liêng, thần thánh	\N	40
2730	绅士	shēnshì	thân sĩ	\N	30
2784	视力	shìlì	thị lực	\N	32
2733	神仙	shénxiān	thần tiên	\N	40
2734	审讯	shěnxùn	thẩm vấn	\N	34
2735	甚至	shènzhì	thậm chí	\N	34
2736	慎重	shènzhòng	cẩn thận	\N	30
2793	时尚	shíshàng	thời thượng, mốt	\N	30
2738	社区	shèqū	cộng đồng	\N	34
2739	摄氏度	shèshìdù	độ C	\N	34
2740	舌头	shétou	lưỡi	\N	34
2741	设置	shèzhì	thiết lập	\N	40
2742	拾	shí	nhặt, mót	\N	34
2743	十	shí	mười	\N	21
2744	是	shì	là	\N	25
2745	试	shì	thi	\N	32
2746	使	shǐ	khiến, sai bảo, dùng	\N	34
2747	诗	shī	thơ	\N	34
2749	十分	shí fēn	vô cùng, rất	\N	34
2750	失败	shībài	thất bại	\N	40
2751	势必	shìbì	tất phải, buộc phải	\N	34
2752	识别	shíbié	phân biệt	\N	40
2753	士兵	shìbīng	binh lính	\N	40
2754	时差	shíchā	sự chênh lệch thời gian	\N	34
2757	时代	shídài	thời kỳ, thời đại	\N	34
2814	实习	shíxí	tập luyện, thực tập	\N	30
2759	时而	shí’ér	đôi khi	\N	35
2818	试验	shìyàn	thí nghiệm	\N	32
2761	释放	shìfàng	phóng thích	\N	34
2795	实验	shíyàn	thực nghiệm, thí nghiệm	\N	30
2763	是否	shìfǒu	phải chăng, hay không	\N	34
2764	师傅	shīfu	thợ cả, chú	\N	34
2765	事故	shìgù	sự cố, tai nạn	\N	34
2766	适合	shìhé	phù hợp	\N	34
2767	时候	shíhou	lúc, khi	\N	30
2770	实际	shíjì	thực tế	\N	30
2771	时机	shíjī	cơ hội, thời cơ	\N	34
2772	世纪	shìjì	thế kỉ	\N	40
2773	事迹	shìjì	sự tích, câu truyện	\N	40
2774	施加	shījiā	gây, làm (áp lực, ảnh hưởng)	\N	34
2775	实践	shíjiàn	thực hiện, thực hành	\N	40
2777	事件	shìjiàn	sự kiện	\N	40
2780	使劲儿	shǐ jìn er	gắng sức, ra sức	\N	40
2781	诗句	shījù	bài thơ	\N	34
2782	时刻	shíkè	thời khắc, thời gian	\N	30
2783	实力	shílì	sức mạnh	\N	34
2785	时髦	shímáo	thời trang	\N	34
2786	失眠	shīmián	mất ngủ	\N	34
2787	使命	shǐmìng	nhiệm vụ, sứ mệnh	\N	40
2788	食品	shípǐn	thực phẩm	\N	30
2789	时期	shíqī	thời kì	\N	34
2791	失去	shīqù	mất	\N	34
2792	湿润	shīrùn	ướt, ẩm ướt	\N	34
2794	失业	shīyè	thất nghiệp	\N	40
2796	事业	shìyè	sự nghiệp, công cuộc	\N	34
2797	实行	shíxíng	thực hiện	\N	40
2798	使用	shǐyòng	sử dụng, dùng vào thực tế	\N	40
2799	时事	shíshì	thời sự	\N	34
2800	实施	shíshī	thực hiện	\N	40
2801	事实	shìshí	sự thực	\N	30
2802	逝世	shìshì	chết	\N	40
2804	事态	shìtài	tình thế, tình hình	\N	40
2805	尸体	shītǐ	thể thi, tử thi	\N	40
2806	石头	shítou	đá	\N	21
2808	失望	shīwàng	thất vọng	\N	34
2809	示威	shìwēi	thị uy, ra oai	\N	40
2810	食物	shíwù	thức ăn	\N	30
2811	事务	shìwù	công việc	\N	34
2813	失误	shīwù	lỗi lầm, sai lầm	\N	34
2815	视线	shìxiàn	đường nhìn, tầm mắt	\N	40
2816	事先	shìxiān	trước, trước tiên	\N	34
2817	事项	shìxiàng	hạng mục công việc	\N	34
2819	视野	shìyě	phạm vi nhìn, tầm nhìn	\N	34
2821	适应	shìyìng	thích ứng, hợp với	\N	34
2822	失恋	shīliàn	thất tình	\N	40
3037	体积	tǐjī	thể tích	\N	40
2833	竖	shù	thẳng đứng	\N	30
2834	书	shū	sách	\N	32
2843	涮火锅	shuànhuǒguō	lẩu nhúng	\N	24
2845	双胞胎	shuāngbāotāi	anh em sinh đôi	\N	22
2861	水利	shuǐlì	thủy lợi	\N	30
2866	书架	shūjià	giá sách	\N	32
2871	数码	shùmǎ	kỹ thuật số	\N	30
2875	顺利	shùnlì	thuận lợi	\N	30
2884	属于	shǔyú	thuộc về	\N	30
2887	四	sì	bốn	\N	21
2824	手艺	shǒuyì	tay nghề, kỹ thuật	\N	40
2895	思考	sīkǎo	suy nghĩ	\N	32
2826	收音机	shōuyīnjī	radio	\N	34
2827	授予	shòuyǔ	trao tặng	\N	34
2828	手指	shǒuzhǐ	ngón tay	\N	34
2829	受罪	shòuzuì	mang vạ, bị giày vò	\N	40
2830	数	shù	số, đếm	\N	21
2831	束	shù	bó	\N	34
2832	树	shù	cây	\N	25
2900	思维	sīwéi	tư duy, suy nghĩ	\N	27
2903	思绪	sīxù	tâm tư, ý nghĩ	\N	27
2835	输	shū	thua	\N	30
2836	耍	shuǎ	chơi	\N	34
2837	帅	shuài	đẹp trai	\N	40
2839	摔	shuāi	ngã, rơi	\N	34
2840	衰老	shuāilǎo	già yếu	\N	34
2841	率领	shuàilǐng	dẫn đầu, chỉ huy	\N	24
2842	甩掉	shuǎidiào	vứt bỏ, trút bỏ	\N	34
2905	四肢	sìzhī	tứ chi, chân tay	\N	24
2844	双	shuāng	đôi, hai	\N	34
2922	随手	suíshǒu	tiện tay, thuận tay	\N	40
2846	双方	shuāngfāng	cả hai bên	\N	40
2848	刷牙	shuāyá	đánh răng	\N	39
2849	鼠标	shǔbiāo	chuột máy tính	\N	34
2850	蔬菜	shūcài	rau	\N	26
2851	舒畅	shūchàng	khoan khoái, dễ chịu	\N	34
2852	书法	shūfǎ	thư pháp	\N	30
2853	束缚	shùfù	ràng buộc, gò bó	\N	34
2854	舒服	shūfu	thỏa mái, dễ chịu	\N	34
2855	疏忽	shūhu	sơ suất	\N	34
2856	谁	shuí	ai	\N	40
2857	税	shuì	thuế	\N	30
2858	水	shuǐ	nước	\N	34
2860	睡觉	shuìjiào	ngủ	\N	21
2928	孙子	sūnzi	cháu trai	\N	24
2862	水龙头	shuǐlóngtóu	vòi nước	\N	34
2863	水平	shuǐpíng	trình độ	\N	34
2864	书籍	shūjí	sách vở	\N	34
2865	书记	shūjì	bí thư	\N	30
2867	数据	shùjù	dữ liệu	\N	40
2869	熟练	shúliàn	thành thạo, thuần thục	\N	30
2870	数量	shùliàng	số lượng	\N	34
2872	书面	shūmiàn	văn bản	\N	34
2873	数目	shùmù	con số	\N	34
2874	顺便	shùnbiàn	nhân tiện	\N	40
2876	顺序	shùnxù	trật tự, thứ tự	\N	30
2877	说不定	shuō bu dìng	có thể, chưa biết chừng	\N	34
2878	说明	shuōmíng	thuyết minh, giải thích	\N	30
2879	说服	shuōfú	thuyết phục	\N	30
2880	朔	shuò	đầu tháng	\N	30
2881	输入	shūrù	nhập vào	\N	40
2883	熟悉	shúxī	quen thuộc	\N	34
2885	数字	shùzì	con số, số	\N	34
2886	梳子	shūzi	lược, cái lược	\N	34
2888	死	sǐ	chết	\N	40
2889	撕	sī	xé rách	\N	40
2890	死亡	sǐwáng	chết, tử vong	\N	34
2891	司法	sīfǎ	tư pháp	\N	30
2893	似乎	sìhū	có vẻ như	\N	34
2894	司机	sījī	lái xe	\N	28
2896	思念	sīniàn	nhớ	\N	34
2897	私人	sīrén	riêng tư, cá nhân	\N	40
2898	思想	sīxiǎng	tư tưởng, tư duy	\N	34
2899	思索	sīsuǒ	suy nghĩ	\N	40
2901	斯文	sīwén	nhã nhặn, lịch sự	\N	30
2904	饲养	sìyǎng	chăn nuôi	\N	34
2906	私自	sīzì	tự ý, một mình	\N	34
2907	送	sòng	tặng, đưa, tiễn	\N	40
2908	艘	sōu	con (tàu, thuyền)	\N	34
2909	算	suàn	tính toán, đếm	\N	34
2910	酸	suān	chua	\N	40
2911	算了	suànle	thôi được rồi	\N	35
2912	算数	suànshù	tính, đếm	\N	40
2913	速度	sùdù	tốc độ	\N	34
2914	俗话	súhuà	tục ngữ	\N	33
2915	岁	suì	tuổi	\N	34
2916	碎	suì	vỡ, nát	\N	34
2917	随便	suíbiàn	tùy tiện, tùy ý	\N	40
2918	隧道	suìdào	đường hầm	\N	34
2919	随即	suíjí	ngay lập tức	\N	30
2920	虽然	suīrán	tuy, mặc dù	\N	27
2923	随意	suíyì	tùy ý	\N	27
2924	随著	suízhe	theo, cùng với	\N	34
2925	塑料袋	sùliàodài	túi ni-lông	\N	34
2926	损坏	sǔnhuài	hư hỏng	\N	34
2927	损失	sǔnshī	thua thiệt, mất mát	\N	40
2929	所	suǒ	chỗ, nơi	\N	35
2930	锁	suǒ	khoá	\N	34
2931	缩短	suōduǎn	rút ngắn	\N	34
2952	台风	táifēng	bão	\N	30
2972	坦率	tǎnshuài	thẳng thắn, bộc trực	\N	30
3007	天空	tiānkōng	bầu trời	\N	24
3008	天伦之乐	tiānlún zhī lè	niềm vui gia đình	\N	22
2932	索赔	suǒpéi	bồi thường	\N	34
2933	所谓	suǒwèi	cái gọi là	\N	35
2934	缩小	suōxiǎo	thu nhỏ	\N	34
2935	缩写	suōxiě	viết tắt	\N	40
2936	所有	suǒyǒu	tất cả, toàn bộ	\N	35
2937	宿舍	sùshè	ký túc xá	\N	27
2939	诉讼	sùsòng	kiện tụng	\N	34
2940	素质	sùzhì	tố chất	\N	34
2941	塑造	sùzào	nặn, tạo hình	\N	34
2942	塔	tǎ	tháp	\N	34
2943	他	tā	ông ấy, chú ấy, anh ấy	\N	34
2944	塌	tā	sập	\N	33
2945	她	tā	bà ấy, cô ấy, chị ấy	\N	34
2946	它	tā	nó	\N	34
2948	抬	tái	nâng lên, khiêng, nhấc	\N	40
2949	太	tài	cực, nhất, quá, lắm	\N	40
2950	泰斗	tàidǒu	ngôi sao sáng, nhân vật vĩ đại	\N	40
2951	态度	tàidù	thái độ	\N	34
2954	台阶	táijiē	bậc thềm	\N	21
2955	太空	tàikōng	vũ trụ, bầu trời cao	\N	34
2956	太太	tàitai	vợ	\N	34
2957	太阳	tàiyáng	mặt trời	\N	34
2958	谈	tán	nói chuyện, bàn luận	\N	34
2959	摊儿	tānr	sạp, quầy hàng	\N	40
2960	弹钢琴	tán gāngqín	đánh đàn piano	\N	34
2961	坦白	tǎnbái	thẳng thắn	\N	30
2962	探测	tàncè	thăm dò	\N	34
2963	糖	táng	đường, kẹo	\N	34
2964	躺	tǎng	nằm	\N	40
2965	烫	tàng	nóng, bỏng	\N	34
2967	堂	táng	phòng lớn, nhà chính	\N	34
2968	塘	táng	ao, đầm, hồ	\N	34
2969	倘若	tǎngruò	nếu như, giả sử	\N	40
2970	叹	tàn	thở dài	\N	34
2971	瘫痪	tānhuàn	bại liệt	\N	40
2973	谈判	tánpàn	cuộc đàm phán	\N	34
2974	叹气	tànqì	thở dài	\N	34
2976	探讨	tàntǎo	thảo luận, bàn bạc	\N	34
2977	探望	tànwàng	thăm hỏi, viếng thăm	\N	34
2978	贪污	tānwū	tham ô, tham nhũng	\N	34
2979	弹性	tánxìng	đàn hồi, linh hoạt	\N	34
2980	桃	táo	quả đào	\N	34
2981	逃	táo	trốn thoát	\N	34
2982	套	tào	bộ, tập	\N	34
2984	讨价还价	tǎojià huánjià	mặc cả, trả giá	\N	37
2985	讨论	tǎolùn	thảo luận	\N	34
2986	淘气	táoqì	nghịch ngợm	\N	34
2987	逃避	táobì	trốn tránh	\N	34
2988	讨厌	tǎoyàn	ghét, chán ghét	\N	30
2989	踏实	tāshi	chân thật, thực tế	\N	30
2990	特别	tèbié	đặc biệt	\N	34
2991	特长	tècháng	sở trường	\N	34
2992	特点	tèdiǎn	đặc điểm	\N	34
2994	疼	téng	đau	\N	24
2995	疼爱	téng’ài	thương yêu	\N	34
2996	特色	tèsè	đặc sắc	\N	21
2997	特意	tèyì	cố ý, đặc biệt là	\N	34
2998	特征	tèzhēng	đặc trưng	\N	34
2999	剔	ti	nhặt ra, gỡ ra	\N	40
3000	题	tí	đề mục, đề tài	\N	40
3001	踢足球	tī zúqiú	đá bóng	\N	34
3002	甜	tián	ngọt	\N	34
3003	舔	tiǎn	liếm	\N	40
3005	田径	tiánjìng	điền kinh	\N	40
3006	填空	tiánkòng	điền vào chỗ trống	\N	40
3009	天气	tiānqì	thời tiết	\N	30
3010	天然气	tiānránqì	khí đốt tự nhiên	\N	34
3011	天生	tiānshēng	trời sinh	\N	34
3012	天堂	tiāntáng	thiên đường	\N	34
3013	天文	tiānwén	thiên văn học	\N	34
3014	田野	tiányě	đồng ruộng	\N	34
3016	条	tiáo	cành, mảnh, sợi, con (rắn, cá,…)	\N	34
3017	挑拨	tiǎobō	gây xích mích	\N	40
3018	调和	tiáohé	hòa giải	\N	35
3019	调节	tiáojié	điều chỉnh	\N	40
3020	条件	tiáojiàn	điều kiện	\N	40
3021	调整	tiáozhěng	điều chỉnh	\N	40
3022	调解	tiáojiě	hòa giải	\N	34
3023	条款	tiáokuǎn	điều khoản	\N	34
3025	调料	tiáoliào	đồ gia vị	\N	34
3026	调皮	tiáopí	nghịch ngợm	\N	34
3027	挑剔	tiāotì	soi mói, bắt lỗi	\N	40
3028	挑选	tiāoxuǎn	lựa chọn	\N	34
3029	挑战	tiǎozhàn	thách thức	\N	30
3030	提拔	tíbá	đề bạt, cất nhắc	\N	40
3031	题材	tícái	chủ đề, nội dung	\N	34
3032	提倡	tíchàng	đề xướng, khởi xướng	\N	34
3033	提纲	tígāng	đề cương, dàn ý	\N	34
3034	提高	tígāo	nâng cao	\N	34
3035	提供	tígōng	cung cấp	\N	34
3036	体会	tǐhuì	cảm nhận, nhận thức	\N	40
3048	提前	tíqián	sớm, trước	\N	21
3112	逃脱	tuōtuō	thoát ra, thoát khỏi	\N	40
3073	统统	tǒngtǒng	tất cả	\N	25
3096	退	tuì	rút lui, lùi lại	\N	25
3099	推迟	tuīchí	hoãn lại, trì hoãn	\N	25
3104	推理	tuīlǐ	suy luận	\N	38
3105	推论	tuīlùn	suy luận, lý luận	\N	31
3123	兔子	tùzi	con thỏ	\N	25
3111	土壤	tǔrǎng	đất	\N	40
3137	玩	wán	chơi	\N	31
3038	体面	tǐmiàn	vẻ vang, danh giá	\N	40
3039	题目	tímù	đề mục, tiêu đề	\N	40
3040	体贴	tǐtiē	chăm sóc, quan tâm	\N	34
3041	听	tīng	nghe	\N	33
3043	停车	tíngchē	dừng xe, đỗ xe	\N	34
3044	停泊	tíngbó	cập bến, neo đậu	\N	34
3046	停滞	tíngzhì	đình trệ, dừng lại	\N	40
3047	亭子	tíngzi	đình, chòi	\N	34
3049	提示	tíshì	nhắc nhở, gợi ý	\N	34
3050	提问	tíwèn	đặt câu hỏi	\N	33
3051	体系	tǐxì	hệ thống	\N	34
3052	体形	tǐxíng	hình thể, vóc dáng	\N	34
3053	提醒	tíxǐng	nhắc nhở	\N	34
3054	体验	tǐyàn	trải nghiệm, thử nghiệm	\N	40
3055	提议	tíyì	đề nghị, đề xuất	\N	40
3056	体育	tǐyù	thể thao	\N	34
3057	铜	tóng	đồng	\N	34
3058	桶	tǒng	xô, thùng	\N	34
3060	铜矿	tóng kuàng	quặng đồng	\N	34
3061	同胞	tóngbāo	đồng bào	\N	34
3062	通常	tōngcháng	thông thường	\N	34
3063	统筹兼顾	tǒngchóu jiāngù	tính toán mọi bề	\N	40
3064	通过	tōngguò	vượt qua, thông qua, đi qua	\N	34
3065	童话	tónghuà	truyện cổ tích	\N	34
3066	统计	tǒngjì	thống kê	\N	34
3067	痛苦	tòngkǔ	đau khổ	\N	34
3068	痛快	tòngkuài	vui sướng, dễ chịu	\N	34
3070	同时	tóngshí	đồng thời	\N	34
3071	同事	tóngshì	đồng nghiệp	\N	34
3072	通俗	tōngsú	phổ biến, thông tục	\N	34
3074	同学	tóngxué	bạn học	\N	34
3075	通讯	tōngxùn	truyền thông	\N	34
3076	统一	tǒngyī	thống nhất	\N	34
3077	通用	tōngyòng	chung dùng, thông dụng	\N	34
3078	统治	tǒngzhì	thống trị	\N	34
3079	通知	tōngzhī	thông báo	\N	34
3080	头发	tóufa	tóc	\N	34
3081	头	tóu	đầu	\N	24
3082	透明	tòumíng	trong suốt, minh bạch	\N	34
3083	投票	tóupiào	bỏ phiếu	\N	40
3084	投掷	tóuzhì	ném, quăng	\N	40
3085	投资	tóuzī	đầu tư	\N	38
3087	团	tuán	nhóm, đoàn	\N	34
3088	图案	tú’àn	hoa văn, hình vẽ	\N	40
3089	团结	tuánjié	đoàn kết	\N	34
3090	团体	tuántǐ	tập thể, đoàn thể	\N	34
3091	团员	tuányuán	đoàn viên	\N	34
3092	突出	tūchū	nổi bật, xuất sắc	\N	40
3093	徒弟	túdì	đồ đệ	\N	34
3094	土豆	tǔdòu	khoai tây	\N	34
3097	退步	tuìbù	thụt lùi, đi lùi	\N	30
3098	推测	tuīcè	suy đoán, dự đoán	\N	34
3100	推辞	tuīcí	từ chối	\N	34
3101	推翻	tuīfān	lật đổ, đảo ngược	\N	34
3102	推广	tuīguǎng	mở rộng, phổ biến	\N	34
3106	推销	tuīxiāo	bán hàng	\N	40
3107	退休	tuìxiū	nghỉ hưu	\N	40
3108	途径	tújìng	con đường, cách thức	\N	34
3109	涂抹	túmǒ	bôi, quét, tô	\N	40
3110	屠杀	túshā	tàn sát, đồ sát	\N	34
3113	拖	tuō	kéo, lôi	\N	40
3114	脱	tuō	cởi, thoát, gỡ ra	\N	40
3116	拖拉	tuōlā	kéo lê, lề mề	\N	34
3117	拓展	tuòzhǎn	mở rộng, phát triển	\N	34
3118	椭圆	tuǒyuán	hình bầu dục	\N	24
3119	托运	tuōyùn	ủy thác vận chuyển	\N	34
3120	突破	tūpò	đột phá	\N	34
3121	突然	tūrán	đột nhiên	\N	34
3122	图书馆	túshū guǎn	thư viện	\N	40
3124	哇	wa	oa, oà, oe, ồ	\N	34
3125	外	wài	ngoài	\N	34
3127	外表	wàibiǎo	vẻ ngoài, bề ngoài	\N	40
3128	外行	wàiháng	người ngoại nghề	\N	40
3129	外交	wàijiāo	ngoại giao	\N	34
3130	外界	wàijiè	thế giới bên ngoài	\N	34
3131	歪曲	wāiqū	xuyên tạc	\N	34
3132	外向	wàixiàng	hướng ngoại	\N	34
3134	挖掘	wājué	khai quật, đào bới	\N	40
3135	丸	wán	viên thuốc	\N	34
3136	完	wán	xong, kết thúc	\N	34
3138	万	wàn	vạn, mười nghìn	\N	21
3140	弯	wān	cong, uốn cong	\N	34
3141	万一	wànyī	vạn nhất, ngộ nhỡ	\N	34
3142	完备	wánbèi	hoàn toàn, đầy đủ	\N	34
3194	围绕	wéirào	bao quanh, xoay quanh	\N	27
3149	网络	wǎngluò	mạng	\N	31
3177	位于	wèiyú	nằm ở, tọa lạc tại	\N	40
3221	文明	wénmíng	văn minh	\N	26
3152	往往	wǎngwǎng	thường hay, thường thường	\N	30
3157	挽救	wǎnjiù	cứu vãn, cứu giúp	\N	31
3161	玩具	wánjù	đồ chơi	\N	31
3139	碗	wǎn	bát	\N	21
3188	畏惧	wèijù	sợ hãi, e ngại	\N	21
3189	胃口	wèikǒu	khẩu vị, sự thèm ăn	\N	24
3176	委屈	wěiqu	oan ức, tủi thân	\N	27
3203	威信	wēixìn	uy tín	\N	33
3143	完毕	wánbì	hoàn tất	\N	34
3144	完成	wánchéng	hoàn thành	\N	40
3145	万分	wànfēn	vô cùng	\N	34
3146	完全	wánquán	hoàn toàn	\N	34
3147	顽强	wánqiáng	ngoan cường	\N	34
3148	完整	wánzhěng	hoàn chỉnh	\N	34
3210	问	wèn	hỏi	\N	33
3150	网球	wǎngqiú	bóng bàn	\N	34
3217	文凭	wénpíng	bằng cấp	\N	33
3153	妄想	wàngxiǎng	mộng tưởng, ảo tưởng	\N	34
3154	网站	wǎngzhàn	trang web, website	\N	40
3155	王子	wángzǐ	hoàng tử	\N	34
3156	挽回	wǎnhuí	xoay chuyển, cứu vãn	\N	34
3239	五	wǔ	năm	\N	21
3158	完美	wánměi	hoàn hảo	\N	34
3159	晚上	wǎnshang	buổi tối	\N	34
3224	文学	wénxué	văn học	\N	33
3162	娃娃	wáwa	búp bê	\N	40
3163	挖	wā	đào, bới	\N	40
3164	位	wèi	vị trí, chỗ, nơi	\N	34
3165	为	wèi	vì, để	\N	40
3166	喂	wèi	alo, này	\N	34
3167	畏	wèi	sợ, e ngại	\N	34
3168	胃	wèi	dạ dày	\N	24
3169	未必	wèibì	chưa hẳn, không nhất thiết	\N	34
3170	唯独	wéidú	chỉ riêng, duy nhất	\N	40
3171	为了	wèile	để, vì	\N	35
3172	围	wéi	vây quanh, bao quanh	\N	27
3174	维护	wéihù	duy trì, bảo vệ	\N	40
3175	尾巴	wěiba	đuôi	\N	34
3227	文章	wénzhāng	bài văn, bài viết	\N	33
3229	问题	wèntí	vấn đề	\N	32
3179	维持	wéichí	duy trì	\N	40
3180	伟大	wěidà	vĩ đại	\N	40
3181	味道	wèidào	mùi vị, hương vị	\N	34
3182	违法	wéifǎ	vi phạm pháp luật	\N	40
3183	微风	wēifēng	vi phong, gió nhẹ	\N	34
3184	微观	wēiguān	vi mô	\N	34
3185	危害	wēihài	nguy hại	\N	21
3186	危机	wēijī	nguy cơ, khủng hoảng	\N	34
3187	围巾	wéijīn	khăn choàng cổ	\N	40
3232	文学家	wénxuéjiā	nhà văn học	\N	33
3219	文件	wénjiàn	tài liệu	\N	40
3190	未来	wèilái	tương lai	\N	34
3192	未免	wèimiǎn	có hơi, khó tránh	\N	34
3193	为难	wéinán	lúng túng, khó xử	\N	34
3245	无耻	wúchǐ	vô liêm sỉ	\N	22
3195	为什么	wèishénme	tại sao, vì sao	\N	34
3196	卫生间	wèishēngjiān	nhà vệ sinh	\N	40
3197	维生素	wéishēngsù	vitamin	\N	34
3198	为首	wéishǒu	đứng đầu, cầm đầu	\N	34
3199	委托	wěituō	ủy thác, nhờ vả	\N	34
3200	慰问	wèiwèn	thăm hỏi, an ủi	\N	34
3201	危险	wēixiǎn	nguy hiểm	\N	40
3202	威胁	wēixié	đe dọa, uy hiếp	\N	34
3204	卫星	wèixīng	vệ tinh	\N	40
3206	唯一	wéiyī	duy nhất	\N	21
3207	委员	wěiyuán	ủy viên	\N	40
3208	伪造	wěizào	giả mạo	\N	34
3209	位置	wèizhì	vị trí, chỗ	\N	34
3211	吻	wěn	hôn	\N	34
3212	温带	wēndài	ôn đới	\N	34
3213	稳定	wěndìng	ổn định	\N	34
3214	温度	wēndù	nhiệt độ	\N	34
3216	文献	wénxiàn	văn hiến, tài liệu	\N	40
3218	文化	wénhuà	văn hóa	\N	34
3220	文具	wénjù	dụng cụ học tập	\N	34
3222	文盲	wénmáng	mù chữ	\N	33
3223	温暖	wēnnuǎn	ấm áp	\N	34
3225	文雅	wényǎ	tao nhã	\N	34
3228	问候	wènhòu	hỏi thăm	\N	34
3230	吻合	wěnhé	phù hợp, ăn khớp	\N	34
3231	文物	wénwù	di vật, cổ vật	\N	34
3233	文书	wénshū	văn thư	\N	30
3234	我们	wǒmen	chúng ta	\N	34
3236	握手	wòshǒu	bắt tay	\N	34
3237	无	wú	không có	\N	34
3238	雾	wù	sương mù	\N	34
3241	无论如何	wúlùn rúhé	dù sao đi nữa	\N	34
3242	务必	wùbì	nhất thiết phải	\N	40
3243	无比	wúbǐ	không gì sánh bằng	\N	34
3244	无偿	wúcháng	không hoàn lại, không có đền bù	\N	34
3246	无从	wúcóng	không biết từ đâu	\N	34
3247	舞蹈	wǔdǎo	nhảy múa	\N	40
3249	无非	wúfēi	chẳng qua là, chỉ là	\N	22
3319	相关	xiāngguān	có liên quan	\N	40
3277	下	xià	xuống, dưới, kế tiếp	\N	40
3284	下令	xiàlìng	ban lệnh	\N	40
3287	弦	xián	dây đàn	\N	31
3349	小吃	xiǎochī	đồ ăn vặt, món ăn nhẹ	\N	26
3293	显示	xiǎnshì	thể hiện, trình bày	\N	40
3250	乌黑	wūhēi	đen sì	\N	40
3251	误会	wùhuì	hiểu nhầm	\N	34
3252	无赖	wúlài	lưu manh, vô lại	\N	34
3253	无精打采	wújīng dǎcǎi	phờ phạc, ủ rũ	\N	34
3255	无礼	wúlǐ	vô lễ, bất lịch sự	\N	40
3256	无聊	wúliáo	nhạt nhẽo, vô vị	\N	34
3257	无能	wúnéng	bất lực, vô năng	\N	34
3258	无论	wúlùn	bất luận	\N	40
3259	无辜	wúgū	vô tội	\N	34
3260	无微不至	wúwēi bú zhì	chu đáo, tỉ mỉ	\N	34
3261	武器	wǔqì	vũ khí	\N	40
3262	无穷无尽	wúqióng wújìn	vô cùng vô tận	\N	34
3263	污染	wūrǎn	ô nhiễm	\N	34
3264	侮辱	wǔrǔ	lăng nhục, sỉ nhục	\N	21
3265	务实	wùshí	thực tế, thiết thực	\N	30
3266	无所谓	wúsuǒwèi	không sao, không quan trọng	\N	35
3267	无知	wúzhī	ngu dốt	\N	34
3268	物质	wùzhì	vật chất	\N	30
3270	屋子	wūzi	ngôi nhà	\N	34
3271	系	xì	buộc, cột, hệ	\N	34
3272	洗	xǐ	giặt, rửa	\N	40
3273	溪	xī	suối, khe	\N	34
3274	西	xī	tây	\N	34
3275	系领带	xì lǐngdài	thắt cà vạt	\N	30
3278	瞎	xiā	mù, mù quáng	\N	27
3279	夏	xià	mùa hè	\N	30
3280	峡	xiá	hẻm núi, khe sâu	\N	21
3281	下雨	xià yǔ	trời mưa	\N	40
3282	狭隘	xiá’ài	hẹp hòi, thiển cận	\N	34
3285	鲜	xiān	tươi, mới	\N	34
3286	嫌	xián	ghét, chán ghét	\N	30
3288	贤	xián	hiền lành, tài giỏi	\N	34
3289	县	xiàn	huyện	\N	34
3291	限	xiàn	hạn, giới hạn	\N	30
3292	显	xiǎn	rõ ràng, hiện rõ	\N	34
3294	显然	xiǎnrán	hiển nhiên, rõ ràng	\N	34
3295	显著	xiǎnzhù	rõ rệt, nổi bật	\N	40
3296	现场	xiànchǎng	hiện trường	\N	34
3297	现代	xiàndài	hiện đại	\N	40
3298	陷害	xiànhài	hãm hại	\N	34
3300	馅儿	xiàn er	nhân (bánh)	\N	21
3301	现成	xiànchéng	có sẵn, vốn có	\N	34
3302	显得	xiǎnde	lộ ra, hiện ra	\N	35
3303	像	xiàng	giống	\N	34
3304	向	xiàng	hướng, về phía	\N	34
3305	巷	xiàng	ngõ, hẻm	\N	34
3306	项	xiàng	hạng mục	\N	30
3307	响	xiǎng	tiếng vang, vang lên	\N	40
3308	想	xiǎng	nghĩ, muốn	\N	34
3309	香	xiāng	thơm	\N	34
3311	相处	xiāngchǔ	sống chung, hòa hợp	\N	34
3312	相当	xiāngdāng	tương đương, tương xứng	\N	34
3313	相对	xiāngduì	tương đối	\N	34
3314	相等	xiāngděng	bằng, ngang nhau	\N	34
3316	相辅相成	xiāngfǔxiāngchéng	bổ trợ cho nhau	\N	40
3317	相互	xiānghù	lẫn nhau	\N	24
3318	相连	xiānglián	liên kết, nối liền	\N	34
3320	相声	xiàngsheng	tấu hài	\N	24
3321	响亮	xiǎngliàng	vang dội	\N	34
3322	享受	xiǎngshòu	hưởng thụ	\N	34
3323	橡皮	xiàngpí	cục tẩy	\N	34
3324	象棋	xiàngqí	cờ tướng	\N	34
3325	相亲相爱	xiāngqīnxiāng’ài	yêu thương nhau	\N	34
3326	想象	xiǎngxiàng	tưởng tượng	\N	34
3327	相信	xiāngxìn	tin tưởng	\N	34
3328	响应	xiǎngyìng	đáp lại, hưởng ứng	\N	34
3329	相应	xiāngyìng	tương ứng	\N	34
3330	象征	xiàngzhēng	tượng trưng	\N	34
3331	贤惠	xiánhuì	hiền thục	\N	40
3333	先进	xiānjìn	tiên tiến	\N	40
3334	羡慕	xiànmù	ngưỡng mộ	\N	34
3335	鲜明	xiānmíng	tươi sáng, rõ nét	\N	34
3336	鲜艳	xiānyàn	sáng, tươi đẹp, rực rỡ	\N	34
3337	纤维	xiānwéi	sợi, chất xơ	\N	34
3338	现实	xiànshí	thực tế	\N	30
3339	现象	xiànxiàng	hiện tượng	\N	34
3340	献身	xiànshēn	hiến thân, cống hiến	\N	34
3341	限制	xiànzhì	hạn chế	\N	30
3342	嫌弃	xiánqì	chê, ghét bỏ	\N	34
3344	嫌疑	xiányí	nghi ngờ	\N	34
3345	现在	xiànzài	bây giờ	\N	40
3346	现状	xiànzhuàng	hiện trạng	\N	34
3347	笑	xiào	cười	\N	34
3348	小	xiǎo	nhỏ	\N	34
3350	消除	xiāochú	loại bỏ, loại trừ	\N	40
3352	消防	xiāofáng	chữa cháy, cứu hỏa	\N	40
3363	小麦	xiǎomài	lúa mì	\N	40
3380	鞋	xié	giày	\N	27
3447	信心	xìnxīn	niềm tin	\N	40
3385	血压	xiěyā	huyết áp	\N	33
3388	鞋子	xiézi	đôi giày	\N	27
3389	写	xiě	viết	\N	33
3400	性别	xìngbié	giới tính	\N	30
3401	性格	xìnggé	tính cách	\N	25
3404	西红柿	xīhóngshì	cà chua	\N	25
3405	喜欢	xǐhuan	thích	\N	32
3414	信封	xìnfēng	phong bì, bao thư	\N	30
3354	效果	xiàoguǒ	hiệu quả	\N	40
3355	消耗	xiāohào	tiêu hao	\N	34
3356	笑话	xiàohuà	truyện cười	\N	34
3357	消化	xiāohuà	tiêu hóa	\N	34
3358	销毁	xiāohuǐ	tiêu hủy, phá hủy	\N	40
3359	小伙子	xiǎohuǒzi	thanh niên	\N	40
3360	消息	xiāoxi	tin tức, thông tin	\N	34
3361	消极	xiāojí	tiêu cực	\N	40
3364	消灭	xiāomiè	tiêu diệt	\N	40
3365	小气	xiǎoqì	keo kiệt, bủn xỉn	\N	40
3366	小时	xiǎoshí	tiếng, giờ	\N	34
3367	消失	xiāoshī	biến mất	\N	34
3368	销售	xiāoshòu	bán hàng, tiêu thụ	\N	40
3369	小说	xiǎoshuō	tiểu thuyết	\N	30
3370	小偷	xiǎotōu	kẻ trộm, tên trộm	\N	34
3371	肖像	xiàoxiàng	chân dung	\N	34
3372	小心	xiǎoxīn	cẩn thận	\N	30
3373	小心翼翼	xiǎoxīnyìyì	thận trọng, tỉ mỉ	\N	34
3374	效益	xiàoyì	lợi ích	\N	34
3375	校长	xiàozhǎng	hiệu trưởng	\N	34
3376	下属	xiàshǔ	cấp dưới	\N	34
3378	细胞	xìbāo	tế bào	\N	34
3379	斜	xié	nghiêng, xiên	\N	40
3429	兴趣	xìngqù	hứng thú	\N	30
3381	携带	xiédài	mang theo	\N	34
3382	协会	xiéhuì	hiệp hội	\N	34
3383	协调	xiétiáo	phối hợp, điều hòa	\N	34
3384	泄漏	xièlòu	rò rỉ	\N	34
3440	信赖	xìnlài	tin cậy	\N	25
3387	协助	xiézhù	giúp đỡ, hỗ trợ	\N	34
3445	新娘	xīnniáng	cô dâu	\N	24
3452	心血	xīnxuè	tâm huyết, tâm sức	\N	24
3390	谢谢	xièxie	cảm ơn	\N	34
3391	斜坡	xiépō	dốc nghiêng	\N	34
3392	卸	xiè	tháo dỡ, dỡ hàng	\N	34
3393	辛苦	xīnkǔ	vất vả, cực khổ	\N	34
3394	新	xīn	mới	\N	34
3395	心	xīn	tim, lòng	\N	34
3396	信	xìn	thư, tin, tín hiệu	\N	30
3397	行动	xíngdòng	hành động	\N	34
3398	行	xíng	được, đi, làm, giỏi	\N	34
3457	信誉	xìnyù	danh dự, uy tín	\N	33
3402	行为	xíngwéi	hành vi	\N	30
3406	袭击	xíjí	tập kích, tấn công	\N	34
3407	细节	xìjié	chi tiết	\N	40
3408	戏剧	xìjù	kịch, tuồng	\N	34
3409	细菌	xìjūn	vi khuẩn	\N	40
3410	系列	xìliè	chuỗi, loạt, hàng loạt	\N	34
3411	熄灭	xīmiè	dập tắt, tắt ngấm	\N	34
3413	心得	xīndé	tâm đắc, điều tâm đắc	\N	35
3415	姓	xìng	họ	\N	34
3416	醒	xǐng	tỉnh, tỉnh táo	\N	34
3417	腥	xīng	tanh	\N	31
3418	形成	xíngchéng	hình thành	\N	30
3419	幸福	xìngfú	hạnh phúc	\N	30
3420	性感	xìnggǎn	gợi cảm, hấp dẫn	\N	34
3421	兴高采烈	xìnggāocǎiliè	vô cùng phấn khởi	\N	34
3422	幸运	xìngyùn	may mắn	\N	21
3423	行李箱	xínglǐ xiāng	va-li, hành lý	\N	30
3424	兴隆	xīnglóng	hưng thịnh, thịnh vượng	\N	34
3425	性命	xìngmìng	tính mạng, sinh mệnh	\N	40
3426	兴盛	xīngshèng	hưng thịnh	\N	34
3427	星期	xīngqī	ngày thứ	\N	30
3430	行人	xíngrén	người đi bộ	\N	40
3431	形容	xíngróng	hình dung, miêu tả	\N	40
3432	刑事	xíngshì	hình sự	\N	40
3433	形式	xíngshì	hình thức	\N	30
3434	形态	xíngtài	hình thái	\N	21
3435	兴旺	xīngwàng	hưng thịnh, phồn vinh	\N	34
3436	形象	xíngxiàng	hình tượng, hình ảnh	\N	34
3437	行政	xíngzhèng	hành chính	\N	22
3438	性质	xìngzhì	tính chất	\N	40
3439	信号	xìnhào	tín hiệu	\N	40
3442	心理	xīnlǐ	tâm lý	\N	34
3443	心灵	xīnlíng	tâm linh	\N	34
3444	信念	xìnniàn	niềm tin, lòng tin	\N	34
3446	新鲜	xīnxiān	tươi	\N	34
3449	信使	xìnshǐ	sứ giả, người đưa tin	\N	34
3450	心痛	xīntòng	đau lòng, thương xót	\N	34
3451	欣欣向荣	xīnxīnxiàngróng	phát triển tươi tốt, thịnh vượng	\N	34
3453	心眼儿	xīnyǎnr	nội tâm, lòng dạ	\N	34
3454	信仰	xìnyǎng	tín ngưỡng	\N	34
3455	新颖	xīnyǐng	mới mẻ, độc đáo	\N	40
3456	信用卡	xìnyòngkǎ	thẻ tín dụng	\N	40
3462	雄厚	xiónghòu	hùng hậu	\N	24
3473	修	xiū	sửa chữa, tu sửa	\N	26
3474	绣	xiù	thêu	\N	37
3475	修理	xiūlǐ	sửa chữa	\N	26
3486	洗澡	xǐzǎo	tắm, tắm rửa	\N	39
3490	宣传	xuānchuán	tuyên truyền	\N	27
3495	宣誓	xuānshì	tuyên thệ	\N	27
3496	选手	xuǎnshǒu	tuyển thủ, đấu thủ	\N	30
3508	学生	xuéshēng	sinh viên, học sinh	\N	32
3459	胸	xiōng	ngực	\N	21
3461	凶恶	xiōng’è	hung ác	\N	34
3509	学术	xuéshù	học thuật	\N	30
3463	胸怀	xiōnghuái	lòng dạ, tấm lòng	\N	34
3464	熊猫	xióngmāo	gấu trúc	\N	24
3465	凶手	xiōngshǒu	kẻ giết người	\N	34
3466	胸膛	xiōngtáng	lồng ngực	\N	34
3468	昔日	xīrì	ngày xưa, trước kia	\N	40
3469	牺牲	xīshēng	hi sinh	\N	40
3470	吸收	xīshōu	hấp thụ, hấp thu	\N	30
3471	洗手间	xǐshǒujiān	nhà vệ sinh	\N	40
3472	习俗	xísú	tập tục, phong tục	\N	34
3513	学习	xuéxí	học tập	\N	32
3524	殉道	xùndào	tử vì đạo	\N	27
3532	序言	xùyán	lời nói đầu	\N	24
3476	休息	xiūxi	nghỉ ngơi	\N	34
3477	休闲	xiūxián	nghỉ ngơi, giải trí	\N	34
3478	修养	xiūyǎng	tu dưỡng, điều dưỡng	\N	34
3479	希望	xīwàng	hy vọng	\N	34
3481	续	xù	tiếp tục	\N	40
3482	夕阳	xīyáng	mặt trời lặn	\N	34
3483	洗衣机	xǐyījī	máy giặt	\N	40
3484	吸引	xīyǐn	thu hút, hấp dẫn	\N	30
3485	喜悦	xǐyuè	vui mừng, sung sướng	\N	34
3535	牙膏	yágāo	kem đánh răng	\N	22
3487	细致	xìzhì	tỉ mỉ, kỹ lưỡng	\N	34
3488	叙述	xùshù	tường thuật	\N	34
3489	宣布	xuānbù	tuyên bố, công bố	\N	34
3537	亚军	yàjūn	á quân	\N	27
3491	宣扬	xuānyáng	tuyên dương, ca ngợi	\N	34
3492	选举	xuǎnjǔ	bầu cử	\N	24
3493	旋律	xuánlǜ	giai điệu	\N	40
3539	盐	yán	muối	\N	21
3550	羊肉	yángròu	thịt dê	\N	26
3497	悬殊	xuánshū	khác xa, chênh lệch	\N	34
3498	悬崖峭壁	xuányáqiàobì	vách núi hiểm trở	\N	34
3499	选	xuǎn	chọn, tuyển chọn	\N	34
3500	旋转	xuánzhuǎn	quay tròn, xoay chuyển	\N	34
3501	许多	xǔduō	nhiều, rất nhiều	\N	40
3502	血	xuè	máu	\N	24
3503	雪	xuě	tuyết	\N	30
3504	学历	xuélì	học vấn, trình độ học vấn	\N	34
3505	学期	xuéqī	học kỳ	\N	34
3506	虚弱	xūruò	suy yếu	\N	34
3510	学说	xuéshuō	học thuyết	\N	33
3511	学位	xuéwèi	học vị	\N	34
3512	学问	xuéwèn	học vấn, tri thức	\N	33
3514	学校	xuéxiào	trường học	\N	34
3515	虚假	xūjiǎ	giả tạo, giả dối	\N	34
3516	酗酒	xùjiǔ	say rượu, nghiện rượu	\N	34
3517	许可	xǔkě	giấy phép	\N	40
3518	恤	xù	thương xót	\N	34
3519	循环	xúnhuán	tuần hoàn	\N	34
3520	训练	xùnliàn	huấn luyện	\N	40
3521	巡逻	xúnluó	đi tuần	\N	40
3522	寻觅	xúnmì	tìm kiếm	\N	40
3523	迅速	xùnsù	nhanh chóng	\N	34
3525	询问	xúnwèn	hỏi, hỏi thăm	\N	34
3527	寻找	xúnzhǎo	tìm kiếm	\N	40
3528	熏	xūn	hun, xông	\N	34
3529	勋章	xūnzhāng	huân chương	\N	34
3530	虚伪	xūwěi	giả dối, đạo đức giả	\N	34
3531	序号	xùhào	số thứ tự	\N	21
3533	需要	xūyào	cần, cần thiết	\N	40
3534	呀	ya	a, à, nhé…	\N	35
3536	押金	yājīn	tiền đặt cọc	\N	34
3538	压力	yālì	áp lực	\N	33
3541	延长	yáncháng	kéo dài	\N	34
3542	演出	yǎnchū	biểu diễn	\N	40
3543	养	yǎng	nuôi dưỡng	\N	34
3545	养成	yǎngchéng	nuôi nấng, hình thành	\N	34
3546	掩盖	yǎngài	che đậy, bao phủ	\N	34
3547	阳光	yángguāng	ánh sáng mặt trời	\N	34
3548	样品	yàngpǐn	hàng mẫu	\N	24
3549	氧气	yǎngqì	oxy	\N	34
3552	宴会	yànhuì	bữa tiệc	\N	40
3553	眼光	yǎnguāng	ánh mắt, tầm nhìn	\N	40
3554	沿海	yánhǎi	duyên hải	\N	40
3555	严寒	yánhán	rét đậm, rét hại	\N	34
3556	掩护	yǎnhù	che chở, bảo vệ	\N	40
3558	言行	yánxíng	lời nói và hành động	\N	40
3559	研究生	yánjiūshēng	nghiên cứu sinh	\N	40
3560	严谨	yánjǐn	nghiêm túc, cẩn trọng	\N	34
3561	严厉	yánlì	nghiêm khắc	\N	40
3562	言论	yánlùn	ngôn luận, lời bàn	\N	34
3582	摇	yáo	rung, lắc, đung đưa	\N	25
3615	一	yī	số một	\N	21
3661	营业	yíngyè	kinh doanh	\N	38
3583	药	yào	thuốc	\N	24
3616	亿	yì	một trăm triệu	\N	21
3620	一辈子	yībèizi	cả đời, một đời	\N	21
3623	遗产	yíchǎn	di sản	\N	38
3624	移民	yímín	di dân	\N	31
3626	依次	yīcì	lần lượt, theo thứ tự	\N	30
3628	一定	yídìng	nhất định, chắc chắn	\N	31
3563	严密	yánmì	chặt chẽ, kín đáo	\N	40
3564	淹没	yānmò	chìm ngập, nhấn chìm	\N	40
3566	炎热	yánrè	nóng bức, gay gắt	\N	34
3567	颜色	yánsè	màu sắc	\N	24
3568	眼色	yǎnsè	ánh mắt, năng lực quan sát	\N	34
3569	延伸	yánshēn	kéo dài, mở rộng	\N	34
3570	眼神	yǎnshén	ánh mắt, thị lực	\N	34
3572	掩饰	yǎnshì	che giấu, che đậy	\N	40
3573	验收	yànshōu	nghiệm thu	\N	30
3574	严肃	yánsù	nghiêm túc	\N	40
3575	厌恶	yànwù	ghét, chán ghét	\N	30
3576	演习	yǎnxí	diễn tập	\N	40
3577	延续	yánxù	tiếp tục	\N	40
3579	演员	yǎnyuán	diễn viên	\N	40
3580	验证	yànzhèng	kiểm chứng, xác nhận	\N	40
3581	演奏	yǎnzòu	diễn tấu, biểu diễn nhạc	\N	40
3636	以后	yǐhòu	sau này, sau khi	\N	24
3653	饮料	yǐnliào	nước uống, đồ uống	\N	26
3584	要	yào	cần, phải, muốn	\N	40
3585	咬	yǎo	cắn	\N	31
3586	要不	yàobù	nếu không thì	\N	34
3587	要不然	yàobùrán	nếu không thì, bằng không	\N	34
3588	摇摆	yáobǎi	đung đưa, lắc lư	\N	34
3589	腰	yāo	eo, thắt lưng	\N	34
3591	耀眼	yàoyǎn	chói mắt, lóa mắt	\N	34
3592	遥远	yáoyuǎn	xa xôi	\N	34
3593	要素	yàosù	yếu tố	\N	34
3594	摇晃	yáohuàng	đung đưa, lắc lư	\N	34
3595	遥控	yáokòng	điều khiển từ xa	\N	40
3596	要命	yàomìng	chết người, kinh khủng	\N	34
3597	邀请	yāoqǐng	mời	\N	34
3598	要求	yāoqiú	yêu cầu, đòi hỏi	\N	34
3599	钥匙	yàoshi	chìa khóa	\N	34
3600	压抑	yāyì	kiềm chế, nén lại	\N	40
3601	压岁钱	yāsuìqián	tiền mừng tuổi	\N	34
3602	亚洲	yàzhōu	châu Á	\N	24
3603	压迫	yāpò	áp bức	\N	33
3605	压榨	yāzhà	ép, bóp, vắt	\N	34
3606	压制	yāzhì	áp chế, kìm nén	\N	40
3607	夜	yè	đêm	\N	21
3608	页	yè	trang, tờ	\N	34
3609	也	yě	cũng	\N	34
3610	业余	yèyú	nghiệp dư	\N	34
3611	业务	yèwù	nghiệp vụ	\N	34
3612	野蛮	yěmán	man rợ	\N	34
3613	野心	yěxīn	dã tâm	\N	34
3654	隐蔽	yǐnbì	ẩn náu, giấu kín	\N	24
3617	乙	yǐ	thứ hai, Ất, B	\N	30
3618	以	yǐ	lấy, bởi vì, để, nhằm	\N	40
3621	一边	yībiān	một bên, một mặt, vừa... vừa...	\N	34
3622	以便	yǐbiàn	để, nhằm	\N	34
3625	遗传	yíchuán	di truyền	\N	40
3627	一会儿	yíhuìr	một lát, chốc lát	\N	40
3629	移动	yídòng	di chuyển	\N	40
3630	一度	yídù	một lần	\N	21
3633	一共	yīgòng	tổng cộng	\N	34
3634	以免	yǐmiǎn	tránh, khỏi	\N	34
3637	疑惑	yíhuò	nghi ngờ	\N	34
3638	以及	yǐjí	và, cùng với	\N	34
3639	意见	yìjiàn	ý kiến, quan điểm	\N	40
3640	已经	yǐjīng	đã, rồi	\N	34
3641	依旧	yījiù	như cũ, vẫn như trước	\N	34
3642	依靠	yīkào	dựa vào	\N	40
3643	一举两得	yījǔliǎngdé	một công đôi việc	\N	35
3644	以来	yǐlái	từ nay, trở lại	\N	40
3645	医疗	yīliáo	y tế, chữa bệnh	\N	24
3646	遗留	yíliú	để lại, lưu lại	\N	40
3647	一流	yīliú	hạng nhất, loại một	\N	40
3648	一律	yīlǜ	đều, như nhau	\N	24
3650	一目了然	yīmù liǎorán	nhìn một cái là hiểu ngay	\N	35
3651	银	yín	bạc	\N	21
3652	阴	yīn	âm, trời râm	\N	34
3655	因此	yīncǐ	vì thế, do đó	\N	34
3656	引导	yǐndǎo	hướng dẫn	\N	34
3657	因而	yīn’ér	vì thế, do đó	\N	35
3658	硬	yìng	cứng, rắn	\N	34
3659	硬币	yìngbì	tiền xu	\N	40
3660	迎接	yíngjiē	đón tiếp, nghênh đón	\N	34
3662	英俊	yīngjùn	anh tuấn, khôi ngô	\N	34
3663	盈利	yínglì	lợi nhuận	\N	34
3664	英明	yīngmíng	sáng suốt, anh minh	\N	34
3666	影响	yǐngxiǎng	ảnh hưởng	\N	34
3668	应付	yìngfu	ứng phó, đối phó	\N	34
3670	应聘	yìngpìn	ứng tuyển	\N	34
3677	银行	yínháng	ngân hàng	\N	37
3688	音响	yīnxiǎng	nhạc cụ	\N	30
3679	隐瞒	yǐnmán	che giấu	\N	24
3680	阴谋	yīnmóu	âm mưu	\N	27
3684	印刷	yìnshuā	in ấn	\N	31
3708	意味着	yìwèizhè	nghĩa là	\N	25
3710	义务	yìwù	nghĩa vụ	\N	23
3717	意志	yìzhì	ý chí	\N	22
3763	幼稚	yòuzhì	ấu trĩ, non nớt	\N	24
3734	用途	yòngtú	công dụng, phạm vi sử dụng	\N	34
3635	以往	yǐwǎng	trước kia, trong quá khứ	\N	34
3665	英雄	yīngxióng	anh hùng	\N	34
3669	应用	yìngyòng	ứng dụng	\N	40
3671	应酬	yìngchou	tiệc tùng, xã giao	\N	34
3672	应邀	yìngyāo	nhận lời mời	\N	40
3673	应当	yìngdāng	nên, phải	\N	40
3675	影子	yǐngzi	bóng, hình bóng	\N	34
3676	迎合	yínghé	đón ý, chiều lòng	\N	34
3678	隐患	yǐnhuàn	tai hoạ ngầm	\N	34
3682	引擎	yǐnqíng	động cơ	\N	34
3683	饮食	yǐnshí	ăn uống	\N	34
3685	因素	yīnsù	nhân tố	\N	34
3686	因为	yīnwèi	bởi vì	\N	40
3687	印象	yìnxiàng	ấn tượng	\N	34
3689	引用	yǐnyòng	trích dẫn	\N	40
3690	隐约	yǐnyuē	lờ mờ, thấp thoáng	\N	34
3691	音乐	yīnyuè	âm nhạc	\N	31
3693	以前	yǐqián	trước đây, trước kia	\N	34
3694	一切	yīqiè	tất cả	\N	21
3695	毅然	yìrán	kiên quyết, không do dự	\N	34
3696	依然	yīrán	như cũ, vẫn	\N	31
3697	一如既往	yīrújìwǎng	trước sau như một	\N	21
3698	医生	yīshēng	bác sĩ	\N	24
3699	仪式	yíshì	nghi lễ, nghi thức	\N	36
3700	意识	yìshí	ý thức	\N	30
3702	意思	yìsi	ý nghĩa	\N	40
3703	一丝不苟	yīsībùgǒu	cẩn thận, không sơ suất	\N	34
3704	意图	yìtú	mục đích, ý đồ	\N	34
3705	依托	yītuō	dựa vào, nhờ vào	\N	34
3706	意外	yìwài	bất ngờ, ngoài ý muốn	\N	34
3707	以为	yǐwéi	tưởng rằng, cho rằng	\N	40
3709	疑问	yíwèn	nghi ngờ	\N	34
3712	一样	yíyàng	giống như	\N	34
3713	意义	yìyì	ý nghĩa	\N	40
3714	医院	yīyuàn	bệnh viện	\N	24
3715	一再	yízài	nhiều lần, hết lần này đến lần khác	\N	40
3716	一直	yīzhí	liên tục, suốt, luôn luôn	\N	34
3718	抑制	yìzhì	kiềm chế, kìm hãm	\N	34
3719	一致	yízhì	nhất trí, đồng lòng	\N	34
3720	以致	yǐzhì	do đó, khiến cho	\N	40
3721	椅子	yǐzi	ghế	\N	27
3722	拥抱	yōngbào	ôm, cái ôm	\N	34
3724	用功	yònggōng	chăm chỉ, siêng năng	\N	34
3725	永恒	yǒnghéng	vĩnh hằng, mãi mãi	\N	30
3726	用户	yònghù	người sử dụng	\N	40
3727	拥护	yōnghù	ủng hộ, tán thành	\N	34
3728	拥挤	yōngjǐ	chật chội, đông đúc	\N	34
3729	勇气	yǒngqì	dũng cảm, can đảm	\N	40
3730	用	yòng	dùng	\N	40
3731	勇于	yǒngyú	dám, có gan	\N	34
3733	用人	yòngrén	dùng người	\N	40
3735	庸俗	yōngsú	tầm thường, dung tục	\N	40
3736	涌现	yǒngxiàn	tuôn ra, xuất hiện nhiều	\N	40
3737	拥有	yǒngyǒu	có, sở hữu	\N	34
3738	永远	yǒngyuǎn	vĩnh viễn, mãi mãi	\N	40
3739	踊跃	yǒngyuè	nhảy nhót, hăng hái	\N	34
3740	由	yóu	do, bởi, từ	\N	40
3741	又	yòu	lại, vừa…lại	\N	40
3742	有	yǒu	có	\N	34
3744	油炸	yóu zhá	rán bằng dầu mỡ	\N	34
3745	右边	yòubiān	bên phải	\N	40
3746	幼儿园	yòu’éryuán	trường mẫu giáo	\N	34
3747	友好	yǒuhǎo	bạn thân, thân thiện	\N	34
3748	优惠	yōuhuì	ưu đãi	\N	40
3749	有害	yǒuhài	có hại	\N	34
3750	有趣	yǒuqù	thú vị, lý thú	\N	30
3751	有名	yǒumíng	nổi tiếng	\N	34
3752	幽默	yōumò	hài hước, vui tính	\N	34
3753	游泳	yóuyǒng	bơi	\N	40
3754	优秀	yōuxiù	ưu tú, xuất sắc	\N	40
3755	游戏	yóuxì	trò chơi	\N	31
3757	友谊	yǒuyì	tình hữu nghị, bạn bè	\N	40
3758	优异	yōuyì	xuất sắc, vượt trội	\N	40
3759	由于	yóuyú	bởi vì, do	\N	40
3760	犹豫	yóuyù	do dự, ngập ngừng	\N	34
3761	忧郁	yōuyù	buồn rầu, u sầu	\N	34
3762	优越	yōuyuè	ưu việt, vượt trội	\N	34
3764	鱼	yú	cá	\N	25
3765	愈	yù	khoẻ bệnh, hết bệnh	\N	34
3766	与	yǔ	với, cùng	\N	35
3768	圆	yuán	tròn, viên mãn	\N	34
3769	远	yuǎn	xa, xa xôi	\N	34
3770	元旦	yuándàn	tết Dương lịch	\N	34
3792	阅读	yuèdú	đọc hiểu	\N	33
3806	运气	yùnqì	vận khí, may mắn	\N	40
3836	灾难	zāinàn	tai nạn	\N	24
3872	扎	zhā	chích, đâm, đâm vào	\N	34
3793	岳父	yuèfù	bố vợ	\N	22
3801	舆论	yúlùn	dư luận	\N	31
3823	预习	yùxí	học trước bài	\N	21
3844	杂志	zázhì	tạp chí	\N	33
3858	遭受	zāoshòu	gặp, bị, chịu	\N	28
3862	咋	zǎ	thì	\N	32
3772	原谅	yuánliàng	thứ lỗi, tha thứ	\N	30
3773	原料	yuánliào	nguyên liệu	\N	40
3775	园林	yuánlín	vườn, công viên	\N	34
3776	原始	yuánshǐ	nguyên thuỷ, ban sơ	\N	34
3777	原先	yuánxiān	trước kia, ban đầu	\N	34
3778	元首	yuánshǒu	nguyên thủ, người đứng đầu	\N	34
3779	远处	yuǎnchù	nơi xa, chỗ xa	\N	40
3780	元素	yuánsù	nguyên tố	\N	34
3781	愿望	yuànwàng	nguyện vọng, mong muốn	\N	34
3782	冤枉	yuānwǎng	bị oan, oan uổng	\N	34
3783	元宵节	yuánxiāojié	Tết Nguyên Tiêu	\N	40
3784	愿意	yuànyì	bằng lòng, mong muốn	\N	40
3785	原因	yuányīn	nguyên nhân	\N	40
3786	原则	yuánzé	nguyên tắc	\N	34
3788	愚蠢	yúchǔn	ngu xuẩn, ngốc nghếch	\N	40
3789	预订	yùdìng	đặt trước, dự định	\N	34
3790	月	yuè	tháng	\N	30
3791	越	yuè	vượt qua, ngày càng	\N	34
3794	约会	yuēhuì	hẹn hò	\N	34
3795	月亮	yuèliang	mặt trăng	\N	34
3797	约束	yuēshù	hạn chế, ràng buộc	\N	34
3798	语法	yǔfǎ	ngữ pháp	\N	33
3799	愉快	yúkuài	vui vẻ, hạnh phúc	\N	40
3800	娱乐	yúlè	giải trí	\N	31
3802	羽毛球	yǔmáoqiú	cầu lông	\N	34
3803	玉米	yùmǐ	ngô	\N	34
3804	允许	yǔnxǔ	cho phép	\N	34
3807	运动	yùndòng	vận động, thể thao	\N	34
3808	云	yún	mây	\N	21
3809	晕	yūn	say (xe, tàu), chóng mặt	\N	34
3810	孕妇	yùnfù	phụ nữ mang thai	\N	40
3811	运用	yùnyòng	vận dụng	\N	40
3813	运算	yùnsuàn	tính toán, làm toán	\N	34
3814	运行	yùnxíng	vận hành	\N	30
3815	预期	yùqī	dự tính, mong đợi	\N	34
3816	与其	yǔqí	thà... còn hơn	\N	35
3817	语气	yǔqì	ngữ khí	\N	35
3818	与日俱增	yǔrìjùzēng	tăng lên từng ngày	\N	35
3819	制服	yùfú	đồng phục	\N	34
3820	预算	yùsuàn	dự toán	\N	34
3821	于是	yúshì	thế là, do đó	\N	34
3822	欲望	yùwàng	ham muốn	\N	34
3824	预先	yùxiān	trước tiên, sẵn	\N	34
3825	语言	yǔyán	ngôn ngữ	\N	33
3827	寓言	yùyán	truyện ngụ ngôn	\N	34
3828	预言	yùyán	tiên đoán	\N	34
3830	宇宙	yǔzhòu	vũ trụ	\N	21
3831	杂	zá	tạp, pha tạp	\N	30
3832	咱	zán	chúng ta	\N	34
3833	再	zài	lại, nữa	\N	40
3835	灾害	zāihài	tai hoạ, thiên tai	\N	34
3837	在	zài	tại, ở	\N	34
3838	再见	zàijiàn	tạm biệt	\N	34
3839	在乎	zàihū	lưu ý, để ý	\N	40
3840	再接再厉	zàijiēzàilì	không ngừng cố gắng, nỗ lực	\N	34
3841	栽培	zāipéi	vun xới, vun trồng	\N	34
3842	在意	zàiyì	lưu ý, lưu tâm	\N	34
3843	杂技	zájì	tạp kỹ, xiếc	\N	40
3846	赞成	zànchéng	tán thành, đồng ý	\N	34
3847	脏	zāng	bẩn	\N	34
3848	赞美	zànměi	khen ngợi	\N	34
3849	咱们	zánmen	chúng ta	\N	34
3850	暂时	zànshí	tạm thời	\N	34
3851	赞叹	zàntàn	khen ngợi	\N	34
3852	赞同	zàntóng	tán đồng	\N	34
3854	赞助	zànzhù	tài trợ	\N	34
3855	造反	zàofǎn	phản loạn	\N	34
3856	糟糕	zāogāo	hỏng bét, gay go	\N	34
3857	早晨	zǎochén	buổi sáng	\N	34
3859	造成	zàochéng	tạo thành	\N	34
3860	遭遇	zāoyù	gặp gỡ	\N	34
3861	噪音	zàoyīn	tiếng ồn	\N	34
3863	责备	zébèi	khiển trách	\N	40
3864	责怪	zéguài	khiển trách	\N	40
3865	贼	zéi	kẻ trộm	\N	34
3866	增加	zēngjiā	tăng thêm, tăng lên	\N	40
3868	增长	zēngzhǎng	tăng lên	\N	40
3869	怎么	zěnme	thế nào, sao, làm sao	\N	34
3870	怎么样	zěnme yàng	thế nào	\N	34
3871	责任	zérèn	trách nhiệm	\N	40
3873	窄	zhǎi	hẹp, chật	\N	34
3874	摘	zhāi	hái, bẻ, ngắt, lấy	\N	40
3875	债券	zhàiquàn	phiếu công trái	\N	34
3876	摘要	zhāiyào	trích yếu, tóm tắt	\N	34
3919	折	zhé	gập lại	\N	28
3895	占据	zhànjù	chiếm, giữ	\N	22
3953	真实	zhēnshí	chân thật, chân thực	\N	30
3900	占有	zhànyǒu	chiếm	\N	22
3902	找	zhǎo	tìm	\N	24
3905	着急	zháojí	sốt ruột, lo lắng	\N	21
3894	照片	zhàopiàn	bức ảnh	\N	31
3927	珍贵	zhēnguì	quý giá	\N	37
3954	征收	zhēngshōu	trưng thu	\N	30
3879	战斗	zhàndòu	chiến đấu, đánh nhau	\N	40
3880	涨	zhǎng	lớn, căng, trướng	\N	34
3881	障碍	zhàng’ài	chướng ngại	\N	34
3882	长辈	zhǎngbèi	đàn anh, trưởng bối	\N	40
3883	章程	zhāngchéng	điều lệ, quy tắc	\N	40
3884	丈夫	zhàngfu	chồng	\N	34
3885	账户	zhànghù	tài khoản	\N	34
3886	帐篷	zhàngpeng	lều	\N	40
3887	掌握	zhǎngwò	nắm vững	\N	34
3888	掌声	zhǎngshēng	tiếng vỗ tay	\N	34
3889	照常	zhàocháng	như thường lệ	\N	34
3890	照顾	zhàogù	chăm sóc	\N	34
3891	召开	zhàokāi	triệu tập, mời dự họp	\N	40
3892	照亮	zhàoliàng	soi sáng	\N	34
3965	真理	zhēnlǐ	chân lí, sự thật	\N	31
3973	震压	zhènyā	đàn áp, trấn áp	\N	26
3896	展现	zhǎnxiàn	bày ra, hiện ra	\N	40
3897	崭新	zhǎnxīn	mới tinh	\N	34
3898	瞻仰	zhānyǎng	chiêm ngưỡng, nhìn cung kính	\N	34
3899	战役	zhànyì	chiến dịch	\N	40
3977	只	zhī	chỉ	\N	22
3901	战争	zhànzhēng	chiến tranh	\N	40
3903	招投标	zhāo tóubiāo	đấu thầu	\N	24
3904	招待	zhāodài	chiêu đãi	\N	40
3906	着凉	zháoliáng	cảm lạnh, nhiễm lạnh	\N	34
3907	照料	zhàoliào	chăm sóc	\N	34
3908	着迷	zháomí	say mê, say sưa	\N	40
3910	朝气蓬勃	zhāoqì péngbó	tràn đầy khí bồng bột như khởi ban mai	\N	34
3911	招收	zhāoshōu	chiêu mộ, tuyển nhận	\N	40
3912	照样	zhàoyàng	như thường lệ	\N	34
3913	照耀	zhàoyào	chiếu sáng	\N	40
3914	照应	zhàoyìng	phối hợp, ăn khớp	\N	34
3915	沼泽	zhǎozé	đầm lầy	\N	34
3916	诈骗	zhàpiàn	lừa dối, lừa bịp	\N	34
3917	扎实	zhāshi	vững chắc, chắc chắn	\N	34
3918	者	zhě	người	\N	34
3921	折磨	zhémó	dằn vặt, giày vò	\N	40
3922	阵	zhèn	trận, cơn	\N	34
3923	震荡	zhèndàng	trấn động, rung động	\N	34
3924	针对	zhēnduì	nhằm vào, chĩa vào	\N	34
3925	振奋	zhènfèn	phấn chấn, phấn khởi	\N	34
3926	真	zhēn	thật, chính xác	\N	34
3928	诊断	zhěnduàn	chẩn đoán	\N	34
3929	振动	zhèndòng	rung động	\N	34
3931	镇静	zhènjìng	trấn tĩnh, điềm tĩnh	\N	40
3932	正	zhèng	chính, ngay	\N	40
3933	政府	zhèngfǔ	chính phủ	\N	21
3934	正确	zhèngquè	chính xác	\N	34
3935	政策	zhèngcè	chính sách	\N	34
3936	正常	zhèngcháng	bình thường	\N	34
3937	正当	zhèngdàng	giữa lúc, trong lúc	\N	34
3938	争端	zhēngduān	tranh chấp	\N	22
3939	争夺	zhēngduó	tranh đoạt, tranh giành	\N	40
3940	整顿	zhěngdùn	sắp xếp, chỉnh đốn	\N	40
3941	正派	zhèngpài	ngay thẳng, đoan chính	\N	30
3942	整齐	zhěngqí	ngăn nắp, trật tự	\N	34
3943	正规	zhèngguī	chính quy, nề nếp	\N	34
3944	正好	zhènghǎo	vừa hay	\N	40
3946	正经	zhèngjīng	đoan trang, chính phái	\N	34
3947	证据	zhèngjù	chứng cứ	\N	34
3948	整理	zhěnglǐ	chỉnh lí, thu xếp, thu dọn	\N	34
3949	争论	zhēnglùn	tranh cãi, tranh luận	\N	40
3950	证明	zhèngmíng	chứng minh	\N	34
3951	正气	zhèngqì	bầu không khí lành mạnh	\N	34
3952	争取	zhēngqǔ	tranh thủ	\N	30
3955	证书	zhèngshū	giấy chứng nhận	\N	40
3957	争先恐后	zhēngxiānkǒnghòu	chen lấn lên trước sợ rớt lại sau	\N	40
3958	正义	zhèngyì	chính nghĩa	\N	21
3959	争议	zhēngyì	tranh luận	\N	40
3960	正在	zhèngzài	đang	\N	31
3961	政治	zhèngzhì	chính trị	\N	21
3962	郑重	zhèngzhòng	nghiêm túc, trịnh trọng	\N	34
3963	症状	zhèngzhuàng	bệnh trạng, triệu chứng	\N	34
3964	震动	zhèndòng	trấn tĩnh	\N	40
3966	阵容	zhènróng	đội hình, đội ngũ	\N	34
3967	侦探	zhēntàn	trinh thám	\N	34
3968	枕头	zhěntou	cái gối	\N	34
3969	珍惜	zhēnxī	quý, trân trọng	\N	34
3970	珍珠	zhēnzhū	ngọc trai	\N	34
3971	真相	zhēnxiàng	sự thật	\N	30
3974	折腾	zhēteng	đi qua đi lại, lăn lại	\N	40
3975	哲学	zhéxué	triết học	\N	34
3976	直	zhí	thẳng	\N	30
3980	支	zhī	đội, đơn vị (văn, bài cây, cán)	\N	25
3992	指定	zhǐdìng	chỉ định	\N	22
3998	指挥	zhǐhuī	chỉ huy	\N	22
4002	知觉	zhījué	tri giác	\N	37
4018	智商	zhìshāng	IQ	\N	37
4019	指使	zhǐshǐ	khiến cho, làm cho	\N	40
4020	指示	zhǐshì	chỉ thị	\N	32
4022	职位	zhíwèi	chức vị	\N	23
4027	职业	zhíyè	nghề nghiệp	\N	23
4031	制造	zhìzào	chế tạo, làm ra	\N	40
3979	之	zhī	tới, cái đó, ngôn từ, của	\N	34
4046	中立	zhōnglì	trung lập	\N	25
3981	枝	zhī	cành, nhánh	\N	34
3982	治安	zhì’ān	trị an, cảnh sát	\N	40
3983	直播	zhíbō	phát sóng trực tiếp	\N	34
3984	支持	zhīchí	chống đỡ	\N	34
3986	指出	zhǐchū	chỉ ra	\N	40
3987	指导	zhǐdǎo	chỉ đạo, hướng dẫn	\N	34
3988	知道	zhīdào	biết	\N	40
3989	值得	zhíde	xứng đáng, đáng	\N	35
3990	制定	zhìdìng	chế định, lập ra	\N	40
3991	制订	zhìdìng	quy định, định ra	\N	40
4065	舟	zhōu	thuyền	\N	30
3993	制度	zhìdù	chế độ	\N	34
3994	脂肪	zhīfáng	mỡ, chất béo	\N	40
3996	只好	zhǐhǎo	đành phải	\N	21
3997	智慧	zhìhuì	trí tuệ	\N	40
3999	指甲	zhǐjiǎ	móng tay	\N	34
4000	直接	zhíjiē	trực tiếp	\N	34
4001	至今	zhìjīn	cho đến nay	\N	40
4003	智力	zhìlì	trí lực, trí khôn	\N	34
4005	置于	zhì yú	dốc sức cho	\N	40
4006	质量	zhìliàng	chất lượng	\N	34
4007	治疗	zhìliáo	điều trị	\N	40
4008	指令	zhǐlìng	mệnh lệnh, chỉ thị	\N	40
4009	滞留	zhìliú	ngưng lại, dừng lại	\N	40
4010	支流	zhīliú	nhánh sông, dòng chảy	\N	40
4011	植物	zhíwù	thực vật	\N	30
4012	指南针	zhǐnánzhēn	kim chỉ nam	\N	40
4014	智能	zhìnéng	trí tuệ, chí thị	\N	40
4015	支配	zhīpèi	an bài, sắp xếp	\N	40
4016	支票	zhīpiào	chi phiếu	\N	40
4017	执勤	zhíqín	chấp hành	\N	22
4021	指望	zhǐwàng	trông chờ, mong đợi	\N	34
4023	植树	zhíshù	cây cối	\N	25
4024	职务	zhíwù	chức vụ	\N	23
4025	秩序	zhìxù	trật tự	\N	40
4028	志愿	zhìyuàn	ước nguyện, chí nguyện, giúp đỡ	\N	34
4029	志愿者	zhìyuàn zhě	tình nguyện viên	\N	40
4030	制约	zhìyuē	chế ước, kiềm hãm	\N	34
4032	执照	zhízhào	giấy phép	\N	40
4033	支柱	zhīzhù	cây trụ, trụ chống	\N	34
4035	制作	zhìzuò	chế tạo, làm ra, chế ra	\N	40
4036	重	zhòng	nặng	\N	34
4037	种	zhǒng	loại, kiểu	\N	34
4038	钟	zhōng	chuông	\N	34
4039	终	zhōng	kết thúc	\N	40
4040	重点	zhòngdiǎn	trọng điểm	\N	34
4041	终点	zhōngdiǎn	điểm cuối, điểm kết thúc	\N	40
4042	终于	zhōngyú	cuối cùng	\N	34
4043	中国	zhōngguó	Trung Quốc	\N	34
4044	中间	zhōngjiān	ở giữa, bên trong	\N	34
4045	终究	zhōngjiū	chung quy, cuối cùng	\N	34
4047	重量	zhòngliàng	trọng lượng	\N	34
4048	肿瘤	zhǒngliú	bướu	\N	34
4050	终身	zhōngshēn	suốt đời	\N	34
4051	重视	zhòngshì	coi trọng, xem trọng	\N	34
4052	忠实	zhōngshí	trung thành	\N	34
4053	众所周知	zhòngsuǒzhōuzhī	ai ai cũng biết	\N	35
4054	中文	zhōngwén	tiếng Trung	\N	34
4055	中午	zhōngwǔ	buổi trưa	\N	34
4056	中心	zhōngxīn	trung tâm	\N	34
4057	重新	chóngxīn	chán nản	\N	30
4059	中央	zhōngyāng	trung tâm	\N	34
4060	重要	zhòngyào	quan trọng	\N	34
4061	种子	zhǒngzi	hạt	\N	30
4062	种族	zhǒngzú	chủng tộc	\N	34
4063	州	zhōu	châu (đơn vị hành chính)	\N	22
4066	周边	zhōubiān	chu vi, xung quanh	\N	40
4067	周到	zhōudào	chu đáo	\N	34
4068	周密	zhōumì	chu đáo chặt chẽ	\N	34
4069	周末	zhōumò	cuối tuần	\N	34
4070	周年	zhōunián	đầy năm	\N	40
4071	周围	zhōuwéi	xung quanh	\N	34
4072	皱纹	zhòuwén	nếp nhăn	\N	34
4073	昼夜	zhòuyè	ngày và đêm	\N	40
4075	周转	zhōuzhuǎn	quay vòng (dòng vốn)	\N	34
4076	住	zhù	ở, cư trú, dừng	\N	34
4077	祝	zhù	chúc, chúc mừng	\N	34
4078	柱	zhù	cột, chống (gậy)	\N	34
4079	煮	zhǔ	nấu	\N	24
4080	株	zhū	cây	\N	25
4081	猪	zhū	con lợn	\N	34
4082	抓	zhuā	nắm, bắt	\N	40
4083	抓紧	zhuājǐn	nắm chắc, nắm vững	\N	34
4119	指引	zhǐyǐn	dẫn dắt	\N	31
4091	装备	zhuāngbèi	trang thiết bị	\N	40
4137	自卑	zìbēi	tự ti	\N	27
4095	壮烈	zhuàngliè	lừng lẫy, oanh liệt	\N	40
4098	庄严	zhuāngyán	tráng nghiêm	\N	40
551	传说	zhuànshuō	truyền kỳ, tiểu thuyết	\N	40
4144	自豪	zìháo	tự hào	\N	27
4138	资本	zīběn	vốn	\N	38
4126	资格	zīgé	tư cách	\N	27
4145	自己	zìjǐ	tự mình, bản thân	\N	27
4147	咨询	zīxún	tư vấn, trưng cầu	\N	24
4084	赚	zhuàn	kiếm tiền, lợi nhuận	\N	34
4085	转弯	zhuǎnwān	ngồi	\N	40
4087	专长	zhuāncháng	chuyên môn, đặc trưng	\N	34
4088	专程	zhuānchéng	chuyến đi đặc biệt	\N	34
4089	撞	zhuàng	đụng, va chạm	\N	34
4090	装	zhuāng	hóa trang, trang phục	\N	34
4149	自力更生	zìlìgēngshēng	tự lực cánh sinh	\N	26
4092	壮观	zhuàngguān	đồ sộ, tráng lệ	\N	34
4093	状况	zhuàngkuàng	tình hình, tình trạng	\N	34
4094	壮丽	zhuànglì	tráng lệ	\N	34
4151	字幕	zìmù	phụ đề	\N	33
4096	装饰	zhuāngshì	trang trí, trang sức	\N	34
4097	状态	zhuàngtài	trạng thái	\N	34
4152	字母	zìmǔ	chữ cái	\N	33
4099	专业	zhuānyè	chuyên ngành	\N	34
4100	专利	zhuānlì	bằng sáng chế	\N	34
4102	转让	zhuǎnràng	chuyển nhượng	\N	34
4103	专题	zhuāntí	chủ đề đặc biệt, chuyên đề	\N	34
4104	专心	zhuānxīn	chuyên tâm	\N	34
4105	转移	zhuǎnyí	thay đổi vị trí	\N	34
4106	转折	zhuǎnzhé	chuyển ngoặt, chuyển hướng	\N	34
4107	主管	zhǔguǎn	người chủ trì tổ chức	\N	40
4108	逐步	zhúbù	lần lượt, từng bước	\N	34
4109	注册	zhùcè	đăng ký	\N	31
4110	主持	zhǔchí	chủ trì	\N	40
4111	主导	zhǔdǎo	chủ đạo	\N	34
4112	主动	zhǔdòng	chủ động	\N	34
4113	祝福	zhùfú	chúc phúc	\N	36
4115	祝贺	zhùhè	chúc mừng	\N	34
4116	追求	zhuīqiú	theo đuổi	\N	34
4117	追悼	zhuīdào	tưởng niệm	\N	34
4118	追究	zhuījiū	truy cứu, truy vấn	\N	21
4154	姿势	zīshì	tư thế	\N	37
4121	著名	zhùmíng	nổi tiếng	\N	34
4122	准备	zhǔnbèi	chuẩn bị	\N	40
4123	准确	zhǔnquè	chính xác, đúng đắn	\N	34
4124	准时	zhǔnshí	đúng giờ	\N	34
4125	准则	zhǔnzé	nguyên tắc	\N	34
4157	滋味	zīwèi	mùi vị	\N	24
4127	磨练	móliàn	rèn luyện, tập luyện	\N	34
4128	护手	hùshǒu	bảo vệ tay, chăm sóc	\N	34
4129	着想	zhuóxiǎng	suy nghĩ, lo nghĩ	\N	34
4130	卓越	zhuóyuè	nổi bật, trác việt, lỗi lạc	\N	40
4131	着重	zhuózhòng	nhấn mạnh, chú trọng	\N	34
4132	竹子	zhúzi	cây trúc	\N	25
4133	作品	zuòpǐn	tác phẩm	\N	34
4134	字	zì	chữ	\N	33
4135	紫	zǐ	màu tím	\N	24
4159	自信	zìxìn	tự tin	\N	33
4162	自愿	zìyuàn	tự nguyện	\N	27
4139	资产	zīchǎn	tài sản	\N	38
4140	自动	zìdòng	tự động	\N	34
4141	子弹	zǐdàn	đạn	\N	31
4142	字典	zìdiǎn	từ điển	\N	40
4143	自发	zìfā	tự phát	\N	30
4172	踪迹	zōngjì	dấu vết	\N	24
4148	资料	zīliào	tư liệu, dữ liệu	\N	40
4150	自满	zìmǎn	tự mãn	\N	27
4153	自然	zìrán	tự nhiên, thiên nhiên	\N	40
4155	自私	zìsī	ích kỷ	\N	40
4158	仔细	zǐxì	tỉ mỉ, cẩn thận	\N	30
4160	自行车	zìxíngchē	xe đạp	\N	28
4161	自由	zìyóu	tự do	\N	34
4163	资源	zīyuán	tài nguyên	\N	40
4164	滋长	zīzhǎng	phát sinh, nảy sinh	\N	40
4165	资助	zīzhù	trợ cấp	\N	34
4166	总是	zǒng shì	luôn luôn, lúc nào cũng	\N	34
4168	总共	zǒnggòng	tổng cộng, tất cả	\N	34
4169	综合	zōnghé	tổng hợp	\N	34
4170	总和	zǒnghé	tổng hợp, tổng số	\N	35
4171	纵横	zònghéng	tung hoành, ngang dọc	\N	34
4173	宗教	zōngjiào	tôn giáo	\N	34
4174	总结	zǒngjié	tổng kết	\N	34
4175	总理	zǒnglǐ	thủ tướng	\N	40
4176	棕色	zōngsè	màu nâu	\N	24
4177	总算	zǒngsuàn	cuối cùng cũng, nhìn chung	\N	34
4178	总统	zǒngtǒng	tổng thống	\N	34
4180	宗旨	zōngzhǐ	tôn chỉ, mục đích	\N	34
4181	揍	zòu	đánh đập	\N	33
4182	走	zǒu	đi, đi bộ	\N	40
4183	走廊	zǒuláng	hành lang	\N	21
4184	走漏	zǒulòu	rò rỉ ra ngoài	\N	40
4185	走私	zǒusī	buôn lậu	\N	34
116	报到	bàodào	điểm danh, báo danh	\N	21
455	程序	chéngxù	chương trình, trình tự	\N	34
4219	作者	zuòzhě	tác giả	\N	37
336	裁员	cáiyuán	giảm biên chế, cắt giảm nhân viên	\N	40
365	策划	cèhuà	lên kế hoạch	\N	40
48	把握	bǎwò	cầm, nắm, nắm bắt	\N	35
70	办公室	bàngōngshì	văn phòng	\N	34
77	半途而废	bàntú’érfèi	bỏ cuộc giữa chừng	\N	35
89	保留	bǎoliú	giữ nguyên, bảo tồn	\N	34
103	爆发	bàofā	bùng nổ, bộc phát	\N	34
127	把手	bǎshǒu	tay nắm cửa, chuôi	\N	35
134	卑鄙	bēibǐ	hèn hạ, ti tiện	\N	40
142	背景	bèijǐng	bối cảnh, nền	\N	40
152	奔驰	bēnchí	chạy nhanh, chạy băng băng	\N	40
169	比	bǐ	so, so với, ví	\N	34
176	变动	biàndòng	biến động, thay đổi	\N	34
192	边缘	biānyuán	giáp danh, vùng ven, biên giới	\N	34
202	标识	biāozhì	cột mốc, ký hiệu	\N	40
214	弊病	bìbìng	tệ nạn, tai hại, sai lầm	\N	34
227	笔记本	bǐjìběn	vở ghi chép	\N	34
237	并列	bìngliè	đặt cạnh nhau, ngang hàng	\N	24
250	必须	bìxū	phải, cần phải	\N	21
261	博览会	bólǎnhuì	hội chợ	\N	34
271	补偿	bǔcháng	bồi thường, đền bù	\N	34
272	不当	bùdàng	không đáng	\N	34
274	不见得	bùjiànde	chưa chắc, không nhất thiết	\N	35
283	不言而喻	bù yán ér yù	không nói cũng rõ	\N	35
290	不得已	bùdéyǐ	bất đắc dĩ, bất đắc phải	\N	35
302	不可思议	bùkěsīyì	phi thường, không thể tưởng tượng	\N	34
315	不择手段	bùzéshǒuduàn	không từ thủ đoạn	\N	34
330	材料	cáiliào	vật liệu, tư liệu	\N	40
350	参谋	cānmóu	tham mưu, cố vấn	\N	34
370	层出不穷	céngchūbùqióng	liên tiếp xuất hiện, tầng tầng lớp lớp	\N	34
380	差距	chājù	khoảng cách	\N	34
386	产生	chǎnshēng	xuất hiện, sản sinh	\N	40
402	场合	chǎnghé	trường hợp	\N	34
414	倡议	chàngyì	đề xuất, sáng kiến	\N	40
426	嘲笑	cháoxiào	nhạo báng	\N	34
439	成心	chéngxīn	thành tâm, cố ý	\N	34
466	乘务员	chéngwùyuán	nhân viên phục vụ (trên tàu, máy bay)	\N	40
482	称心如意	chènxīn rúyì	vừa lòng đẹp ý	\N	34
497	冲	chōng	va đập, đột kích	\N	34
507	重阳节	chóngyáng jié	tết Trùng Dương	\N	34
518	出国	chūguó	ra nước ngoài	\N	40
526	抽空	chōukòng	dành thời gian, tranh thủ	\N	30
535	传达	zhuǎndá	truyền tải	\N	40
541	床单	chuángdān	khăn trải giường	\N	34
547	川流不息	chuānliúbùxī	dòng nước chảy liên tục, không ngừng	\N	34
579	出息	chūxī	triển vọng, tiến bộ	\N	34
586	刺	cì	đâm, chọc, chích	\N	34
588	次品	cì pǐn	loại hai, thứ phẩm	\N	34
4187	租	zū	thuê, mướn, cho thuê, tiền thuê	\N	40
4188	阻碍	zǔ’ài	cản trở	\N	34
4189	钻石	zuànshí	kim cương	\N	34
4190	钻研	zuānyán	nghiên cứu	\N	40
4214	做生意	zuò shēngyì	làm kinh doanh	\N	40
4192	祖父	zǔfù	ông nội	\N	34
4194	组合	zǔhé	tổ hợp	\N	34
4195	最	zuì	nhất	\N	30
4197	嘴	zuǐ	miệng, mồm	\N	34
4198	最好	zuì hǎo	tốt nhất	\N	34
4199	嘴唇	zuǐchún	môi	\N	34
4200	罪犯	zuìfàn	tội phạm	\N	34
4201	最后	zuìhòu	cuối cùng	\N	34
4202	最近	zuìjìn	gần đây, dạo này	\N	34
4203	阻止	zǔzhǐ	ngăn cản, ngăn trở	\N	34
4204	租赁	zūlìn	thuê, cho thuê	\N	40
4206	尊敬	zūnjìng	tôn kính	\N	34
4207	遵守	zūnshǒu	tuân thủ	\N	30
4208	遵循	zūnxún	theo, tuân theo	\N	34
4209	尊严	zūnyán	tôn nghiêm	\N	34
4210	尊重	zūnzhòng	tôn trọng	\N	34
4211	坐	zuò	ngồi	\N	40
4212	座	zuò	chỗ ngồi, đệm, tòa	\N	40
4213	作东	zuòdōng	làm chủ	\N	40
4218	作为	zuòwéi	hành vi, việc làm	\N	40
4216	作文	zuòwén	viết văn, làm văn	\N	40
4217	作用	zuòyòng	tác dụng	\N	40
488	吃惊	chījīng	giật mình, sợ hãi	\N	21
4220	昨天	zuótiān	hôm qua	\N	34
4221	左边	zuǒbiān	bên trái	\N	40
4222	作废	zuòfèi	xóa bỏ, mất hiệu lực	\N	34
4223	作风	zuòfēng	phong cách	\N	34
4224	座位	zuòwèi	chỗ ngồi	\N	40
4225	作业	zuòyè	bài tập	\N	32
4227	足够	zúgòu	đủ	\N	21
4228	祖先	zǔxiān	tổ tiên	\N	34
4229	组织	zǔzhī	tổ chức	\N	40
567	处境	chǔjìng	cảnh ngộ, hoàn cảnh	\N	25
4191	组成	zǔchéng	cấu thành, tạo thành	\N	24
597	辞职	cízhí	từ chức	\N	27
605	从前	cóngqián	trước đây, ngày trước	\N	34
636	打抱不平	dǎbàobùpíng	bênh vực, bênh kẻ yếu	\N	34
650	代表	dàibiǎo	đại biểu, đại diện	\N	40
664	单纯	dānchún	đơn giản, đơn thuần	\N	34
674	当地	dāngdì	bản địa, bản xứ	\N	35
684	当时	dāngshí	lúc đó, khi đó	\N	34
688	党选	dǎngxuǎn	trúng cử	\N	34
690	淡却	dànquè	nhạt đi, phai nhạt	\N	40
703	到达	dàodá	đến nơi, đạt đến	\N	34
723	大使	dàshǐ	trạng trọng, không kiêng nể	\N	34
738	得不偿失	débùchángshī	hại nhiều hơn lợi, lợi ít hại nhiều	\N	35
753	得天独厚	détiāndúhòu	gặp may mắn, được ưu ái	\N	35
773	电头	diàntóu	gật đầu	\N	24
783	调查	diàochá	điều tra	\N	40
794	地方	dìfāng	địa phương, chỗ, nơi, vùng	\N	35
795	抵抗	dǐkàng	chống lại, đề kháng, chống cự	\N	34
803	的确	díquè	thật, đích thực	\N	35
824	董事长	dǒngshì zhǎng	chủ tịch hội đồng quản trị	\N	34
843	断绝	duànjué	cắt đứt, đoạn tuyệt	\N	34
854	对方	duìfāng	phía bên kia, đối phương	\N	34
879	顿时	dùnshí	ngay, liền, tức khắc	\N	40
892	读书	dúshū	đọc sách	\N	34
896	恶心	ěxīn	buồn nôn	\N	34
900	而且	érqiě	mà còn, hơn nữa	\N	35
917	发火	fāhuǒ	nổi giận	\N	34
923	反驳	fǎnbó	bác bỏ, phản đối	\N	34
937	方	fāng	vuông	\N	34
942	方便	fāngbiàn	thuận tiện, thuận lợi	\N	34
957	放映	fàngyìng	trình chiếu, chiếu phim	\N	40
968	烦恼	fánnǎo	phiền não, phiền muộn	\N	34
981	发言	fāyán	phát biểu	\N	40
991	诽谤	fěibàng	nói xấu, phỉ báng, gièm pha	\N	34
997	飞禽走兽	fēiqín zǒushòu	chim bay cá nhảy, chim trời cá nước	\N	40
1006	分别	fēnbié	phân biệt	\N	30
1012	丰盛	fēngshèng	phong phú, nhiều, giàu có	\N	34
1022	丰满	fēngmǎn	sung túc, đầy đủ, đầy ắp	\N	34
1037	分量	fènliàng	trọng lượng, sức nặng	\N	34
1055	岗位	gǎngwèi	cương vị, vị trí công tác	\N	34
1068	干涉	gānshè	can thiệp	\N	34
1077	高超	gāochāo	cao siêu, tuyệt vời	\N	34
1087	高速公路	gāosù gōnglù	đường cao tốc	\N	34
1102	根据	gēnjù	căn cứ, dựa vào	\N	40
1109	更新	gēngxīn	thay mới, đổi mới, canh tân	\N	40
1118	各抒己见	gèshūjǐjiàn	mỗi người đưa ra ý kiến của riêng mình	\N	40
1135	公关	gōngguān	giao tiếp, đối ngoại, xã hội	\N	34
1147	功能	gōngnéng	công năng, tác dụng	\N	34
1158	功用	gōngyòng	công năng, công hiệu	\N	34
1172	购结	gòujié	câu kết, thông đồng	\N	34
1184	关键	guānjiàn	then chốt, mấu chốt	\N	34
1198	光滑	guānghuá	trơn tru, nhẵn bóng	\N	34
1200	广阔	guǎngkuò	rộng lớn, bát ngát	\N	34
1217	鼓动	gǔdòng	cổ động, khuyến khích, xúi giục	\N	34
1230	规范	guīfàn	quy tắc, tiêu chuẩn	\N	40
1240	估计	gūjì	đánh giá, ước đoán	\N	34
1252	过程	guòchéng	quá trình	\N	40
1271	过瘾	guòyǐn	thỏa nguyện, thỏa thích	\N	34
1274	暂且	zànqiě	tạm thời	\N	34
1284	固有	gùyǒu	vốn có, sẵn có, cố hữu	\N	34
1286	顽固	wángù	bướng bỉnh	\N	34
1297	海洋	hǎiyáng	biển, đại dương	\N	34
1308	罕见	hǎnjiàn	hiếm thấy, ít thấy	\N	40
1323	好像	hǎoxiàng	hình như, dường như	\N	34
1332	合格	hégé	hợp lệ, đạt chuẩn	\N	40
1344	恨不得	hěnbùdé	hận không thể, muốn	\N	35
1361	红包	hóngbāo	tiền thưởng, tiền lì xì	\N	34
1369	后顾之忧	hòugùzhīyōu	nỗi lo về sau	\N	40
1380	花瓣	huābàn	cánh hoa	\N	25
1389	换	huàn	đổi, thay đổi, trao đổi	\N	40
1401	慌张	huāngzhāng	hoang mang, rối loạn	\N	34
1412	画蛇添足	huàshétiānzú	vẽ rắn thêm chân, vẽ vời vô ích, làm chuyện dư thừa	\N	40
1433	回顾	huígù	nhìn lại, hồi tưởng	\N	34
1444	互联网	hùliánwǎng	internet	\N	40
1451	浑身	húnshēn	toàn thân, khắp người	\N	34
1462	火箭	huǒjiàn	tên lửa, hỏa tiễn	\N	34
1474	呼啸	hūxiào	gào thét, rít, hò hét	\N	34
1500	坚强	jiānqiáng	mạnh mẽ, kiên cường	\N	34
712	道歉	dàoqiàn	xin thứ lỗi, xin chịu lỗi	\N	30
869	对抗	duìkàng	đối kháng, đối đầu	\N	24
1487	家常	jiācháng	việc thường ngày, chuyện nhà	\N	30
812	抵制	dǐzhì	ngăn chặn, ngăn lại	\N	24
864	推	tuī	đẩy, đùn, mở rộng	\N	34
906	制止	zhìzhǐ	ngăn cấm, chặn đứng	\N	34
1110	更改	gēnggǎi	cải chính, đính chính, sửa lại	\N	25
1263	国庆节	guóqìngjié	ngày quốc khánh	\N	30
1484	驾驶	jiàshǐ	lái xe	\N	28
1512	剪影	jiǎnyǐng	bóng cắt, hình bóng	\N	34
1532	交往	jiāowǎng	qua lại, lui tới	\N	34
1534	饺子	jiǎozi	bánh chẻo, sủi cảo	\N	21
1552	践踏	jiàntà	dẫm, giẫm, giày xéo	\N	34
1563	坚贞	jiānzhēn	quả là, thật là	\N	40
1574	交涉	jiāoshè	can thiệp, đàm phán	\N	34
1589	疾病	jíbìng	bệnh tật	\N	40
1596	激动	jīdòng	kích động	\N	34
1603	节日	jiérì	ngày tết, ngày lễ	\N	30
1611	竭尽全力	jiéjìn quánlì	dốc toàn lực	\N	34
1623	接受	jiēshòu	tiếp nhận	\N	40
1632	借助	jièzhù	nhờ vào, cậy vào	\N	34
1644	机会	jīhuì	cơ hội, dịp	\N	34
1655	激励	jīlì	khích lệ, khuyến khích	\N	40
1674	经常	jīngcháng	thường, thường xuyên	\N	34
1688	精致	jīngzhì	tinh tế	\N	40
1700	精准	jīngzhǔn	chính xác	\N	34
1709	金融	jīnróng	tài chính	\N	38
1721	技巧	jìqiǎo	kỹ xảo	\N	34
1725	集中	jízhōng	tập trung	\N	34
1731	计算机	jìsuànjī	máy tính	\N	40
1747	继往开来	jìwǎng kāilái	tiếp nối người trước, mở lối cho người sau	\N	40
1756	急于求成	jíyú qiúchéng	vội vàng mong đạt được thành công	\N	34
1773	决赛	juésài	trận chung kết	\N	40
1787	军队	jūnduì	quân đội	\N	34
1815	砍	kǎn	chặt	\N	30
1821	慷慨	kāngkǎi	hào phóng, hùng hồn	\N	34
1839	客房	kèfáng	phòng khách (khách sạn)	\N	34
1840	客观	kèguān	khách quan	\N	30
1842	课程	kèchéng	lịch dạy học	\N	34
1855	课堂	kètáng	lớp học, giảng đường	\N	34
1856	客栈	kèzhàn	quán trọ (nếu trong ảnh dừng ở 2163 khác, bạn cho mình ảnh rõ dòng cuối để mình sửa đúng)	\N	40
1863	可见	kějiàn	có thể thấy	\N	34
1871	可笑	kěxiào	nực cười, buồn cười	\N	34
1885	挎	kuà	cắp, xách, khoác, đai	\N	34
1895	困	kùn	khốn khổ, khó khăn, mệt, buồn ngủ	\N	34
1910	老板	lǎobǎn	ông chủ	\N	34
1919	苦笑	kǔxiào	cười khổ, cười gượng	\N	34
1942	老婆婆	lǎopopo	bà nội, bà ngoại	\N	34
1957	冷却	lěngquè	làm lạnh, để nguội	\N	34
1970	厉害	lìhài	lợi hại, dữ dội, gay gắt	\N	40
1990	聊天	liáotiān	tán gẫu, trò chuyện	\N	34
1995	烈性	lièxìng	mạnh mẽ, dữ dội, gay gắt	\N	34
2007	力所能及	lìsuǒnéngjí	khả năng cho phép	\N	35
2021	留念	liúniàn	lưu niệm, kỷ niệm	\N	40
2032	理直气壮	lǐzhíqìzhuàng	cây ngay không sợ chết đứng	\N	34
2048	轮船	lúnchuán	thuyền chạy bằng hơi nước	\N	40
2060	络绎不绝	luòyì bù jué	lũ lượt kéo đến	\N	34
2068	嘛	ma	mà, nhỉ	\N	40
2071	麻痹	mábì	bệnh tê liệt	\N	40
2080	埋葬	máizàng	chôn giấu, chôn cất	\N	34
2090	茫然	mángrán	mù tịt, chẳng biết gì	\N	40
2100	毛病	máobìng	lỗi, tật xấu	\N	34
2112	美丽	měilì	đẹp, xinh đẹp	\N	34
2123	美妙	měimiào	tuyệt vời, tươi đẹp	\N	34
2137	免费	miǎnfèi	miễn phí	\N	40
2150	蜜蜂	mìfēng	ong	\N	34
2159	名额	míng'é	số người	\N	34
2177	迷失	míshī	mất phương hướng	\N	34
2181	摩擦	mócā	ma sát	\N	40
2186	莫名其妙	mòmíngqímiào	không hiểu ra sao	\N	34
2191	搜索	sōusuǒ	tìm kiếm	\N	40
2198	木头	mùtou	gỗ	\N	34
2204	耐心	nàixīn	kiên nhẫn	\N	40
2212	难堪	nánkān	khó chịu	\N	34
2230	年龄	niánlíng	tuổi	\N	34
2238	农业	nóngyè	nông nghiệp	\N	34
2248	攀登	pāndēng	leo, trèo	\N	34
2258	能量	néngliàng	năng lượng	\N	34
2267	凝固	nínggù	cứng lại, đông đặc	\N	34
2279	虐待	nüèdài	hành hạ, ngược đãi	\N	34
2289	欧洲	ōuzhōu	châu Âu	\N	24
2294	排队	páiduì	xếp hàng, sắp xếp	\N	40
2302	旁边	pángbiān	bên cạnh	\N	34
2311	配偶	pèi’ǒu	vợ, chồng, phối ngẫu	\N	34
2325	批评	pīpíng	chỉ trích, phê bình	\N	40
2333	拼搏	pīnbó	đấu tranh	\N	24
2343	平方	píngfāng	vuông, bình phương	\N	34
2380	曝光	pùguāng	phơi bày, lộ ra	\N	40
2390	前	qián	trước	\N	34
2396	签署	qiānshǔ	ký tên, ký	\N	34
1665	近代	jìndài	cận đại	\N	31
1740	救济	jiùjì	cứu tế	\N	36
2364	脾气	píqi	tính khí, tâm trạng, tính tình, tính cách	\N	34
2397	签证	qiānzhèng	visa	\N	40
2169	民间	mínjiān	dân gian	\N	37
1934	垃圾桶	lājītǒng	thùng rác	\N	30
1983	连同	liántóng	tính cả, góp lại, kể cả	\N	25
1689	竞争	zhēngzhēng	ngo ngoe, vung vẫy, đấu tranh	\N	34
2219	闹钟	nàozhōng	đồng hồ báo thức	\N	30
2352	平时	píngshí	bình thường, ngày thường	\N	30
2409	强忍	qiángrěn	nhẫn nhịn, nín nhịn	\N	40
2419	牵强附会	qiānqiángfùhuì	gượng ép, cưỡng giải thích	\N	34
2434	巧巧	qiàqiǎo	đúng lúc, vừa khéo	\N	34
2448	起负	qǐfù	ân hiệp, bật lại	\N	40
2458	期间	qíjiān	dịp, thời kỳ, thời gian	\N	34
2473	清楚	qīngchu	rõ ràng, minh mẫn, hiểu rõ	\N	40
2487	清爽	qīngshuǎng	dễ chịu, mát mẻ	\N	34
2497	勤劳	qínláo	siêng năng, cần cù, cần mẫn	\N	34
2507	气魄	qìpò	khí thế, quang cảnh	\N	40
2516	期限	qīxiàn	kỳ hạn, thời hạn	\N	34
2537	染	rǎn	nhuộm, mà, thế mà, song	\N	34
2549	忍不住	rěn bù zhù	không thể cưỡng lại	\N	34
2562	热心肠	rèxīncháng	tốt bụng, nhiệt tâm	\N	34
2573	容量	róngliàng	dung lượng	\N	34
2578	荣誉证书	róngyù zhèngshū	giấy chứng nhận danh dự	\N	40
2593	人家	rénjiā	những người khác	\N	34
2605	人性	rénxìng	nhân tính	\N	40
2610	人质	rénzhì	con tin	\N	34
2616	散步	sànbù	đi dạo	\N	34
2622	色彩	sècǎi	màu sắc	\N	24
2630	筛选	shāixuǎn	sàng lọc, chọn lọc	\N	34
2641	上级	shàngjí	cấp trên, thượng cấp	\N	34
2653	善良	shànliáng	hảo tâm, lương thiện	\N	34
2667	设备	shèbèi	thiết bị	\N	40
2673	设施	shèshī	thiết bị, công trình	\N	34
2677	神奇	shén qí	thần kỳ	\N	30
2691	生病	shēngbìng	bị ốm, sinh bệnh	\N	34
2704	声明	shēngmíng	tuyên bố, thanh minh	\N	34
2748	似的	shì de	dường như, tựa như	\N	35
2756	市场	shìchǎng	thị trường, chợ	\N	34
2768	实话	shíhuà	sự thật, nói thật	\N	34
2779	世界观	shìjièguān	thế giới quan	\N	40
2790	事情	shìqíng	sự tình, sự việc	\N	40
2812	事物	shìwù	điều, vật, thứ	\N	40
2823	施展	shīzhǎn	phát huy, thi thố (năng lực)	\N	34
2838	甩	shuǎi	vung, quăng, ném	\N	40
2847	爽快	shuǎngkuài	sảng khoái, dễ chịu	\N	34
2859	水果	shuǐguǒ	hoa quả	\N	34
2868	树立	shùlì	thành lập, xây dựng	\N	40
2882	舒适	shūshì	dễ chịu, thoải mái	\N	34
2892	丝毫	sīháo	ti, tí, mảy may, chút nào	\N	34
2902	肆无忌惮	sìwújìdàn	trắng trợn, không kiêng nể gì cả	\N	34
2921	随身	suíshēn	mang theo, tùy thân	\N	34
2938	素食主义	sùshí zhǔyì	chủ nghĩa ăn chay	\N	40
2953	太极拳	tàijíquán	thái cực quyền	\N	40
2966	趟	tàng	chuyến đi, lượt	\N	34
2975	探索	tànsuǒ	khám phá	\N	34
2983	陶瓷	táocí	đồ gốm	\N	34
2993	特定	tèdìng	đặc biệt, đặc sắc	\N	34
3004	天才	tiāncái	thiên tài	\N	40
3015	天真	tiānzhēn	ngây thơ, hồn nhiên	\N	34
3024	条例	tiáolì	luật lệ, điều lệ	\N	40
3045	停顿	tíngdùn	tạm ngừng, ngắt quãng	\N	34
3059	通货膨胀	tōng huò péngzhàng	sự lạm phát	\N	34
3069	同情	tóngqíng	đồng cảm, thông cảm	\N	34
3086	土	tǔ	đất, thổ	\N	34
3095	腿	tuǐ	chân, đùi	\N	30
3115	拖延	tuōyán	trì hoãn, kéo dài	\N	34
3126	歪	wāi	nghiêng, lệch, xiêu vẹo	\N	34
3133	瓦解	wǎjiě	sụp đổ, tan rã	\N	34
3151	往事	wǎngshì	chuyện cũ, quá khứ	\N	40
3160	惋惜	wǎnxī	thương tiếc, xót thương	\N	34
3173	违反	wéifǎn	vi phạm	\N	34
3178	微不足道	wēibùzúdào	không có ý nghĩa	\N	34
3191	威力	wēilì	sức mạnh, uy lực	\N	34
3215	温和	wēnhé	ôn hòa, nhẹ nhàng	\N	35
3226	文艺	wényì	văn nghệ	\N	33
3235	卧室	wòshì	phòng ngủ	\N	34
3240	无可奉告	wúkě fènggào	không có gì để nói, miễn bình luận	\N	34
3248	无动于衷	wúdòngyúzhōng	thờ ơ, lãnh đạm	\N	34
3269	武装	wǔzhuāng	vũ trang	\N	34
3276	霞	xiá	ráng mây (sáng hoặc tối)	\N	40
3283	狭窄	xiázhǎi	hẹp, chật hẹp	\N	34
3299	陷阱	xiànjǐng	cái bẫy	\N	40
3315	相反	xiāngfǎn	tương phản, ngược lại	\N	40
3332	衔接	xiánjiē	liên kết, nối tiếp	\N	34
3343	现任	xiànrèn	đang giữ chức vụ	\N	23
3351	消毒	xiāodú	tẩy uế, khử trùng	\N	34
3353	消费	xiāofèi	tiêu thụ, tiêu dùng	\N	40
3362	效率	xiàolǜ	hiệu suất, năng suất	\N	40
3377	下午	xiàwǔ	buổi chiều	\N	40
2529	群	qún	bầy, đàn, tốp	\N	21
3290	线	xiàn	sợi, đường	\N	34
2719	神话	shénhuà	truyền thuyết	\N	30
2722	审理	shěnlǐ	thẩm tra xử lý	\N	40
2731	身体	shēntǐ	cơ thể, thân thể	\N	24
3103	推荐	tuījiàn	giới thiệu, đề cử	\N	30
3205	维修	wéixiū	sửa chữa, duy tu	\N	26
3254	无可奈何	wúkěnàihé	đành chịu, bất lực	\N	22
3310	相似	xiāngsì	giống, tương tự	\N	34
3386	协议	xiéyì	hiệp nghị, thỏa thuận	\N	34
3399	兴奋	xīngfèn	hưng phấn, phấn khích	\N	34
3412	新陈代谢	xīnchéndàixiè	sự thay cũ đổi mới, trao đổi chất	\N	40
3428	性情	xìngqíng	tính tình, tính nết	\N	40
3441	新郎	xīnláng	chú rể	\N	40
3448	信任	xìnrèn	tin tưởng, tín nhiệm	\N	34
3458	心脏	xīnzàng	tim	\N	24
3460	兄弟	xiōngdì	anh em trai	\N	40
3467	雄伟	xióngwěi	hùng vĩ, tráng lệ	\N	34
3480	喜闻乐见	xǐwénlèjiàn	rất hoan nghênh, vui tai vui mắt	\N	34
3494	悬念	xuánniàn	hồi hộp, thấp thỏm	\N	34
3507	雪上加霜	xuěshàngjiāshuāng	thêm khổ này đến khổ khác, liên tiếp gặp nạn	\N	34
3526	循序渐进	xúnxùjiànjìn	tiến hành theo trật tự	\N	40
3540	演变	yǎnbiàn	phát triển, biến đổi	\N	34
3544	严重	yánzhòng	nghiêm trọng	\N	34
3551	样式	yàngshì	hình thức, kiểu dáng	\N	30
3565	延期	yánqī	dời ngày, kéo dài thời hạn	\N	34
3578	演绎	yǎnyì	diễn dịch, suy luận	\N	40
3590	咬牙切齿	yǎoyáqièchǐ	nghiến răng nghiến lợi	\N	34
3604	压缩	yāsuō	nén, ép	\N	34
3614	液体	yètǐ	chất lỏng	\N	34
3619	一般	yībān	bình thường, phổ biến	\N	34
3631	一帆风顺	yīfān fēngshùn	thuận buồm xuôi gió	\N	30
3632	衣服	yīfu	quần áo	\N	27
3649	一路平安	yīlù píng’ān	thượng lộ bình an	\N	34
3667	营养	yíngyǎng	dinh dưỡng	\N	34
3681	引起	yǐnqǐ	gây nên, dẫn tới	\N	34
3701	艺术	yìshù	nghệ thuật	\N	40
3723	勇敢	yǒnggǎn	dũng cảm	\N	34
3732	用处	yòngchu	công dụng, tác dụng	\N	40
3743	有条不紊	yǒutiáo bù wěn	gọn gàng, trật tự	\N	34
3756	优先	yōuxiān	quyền ưu tiên	\N	40
3771	原告	yuángào	nguyên cáo	\N	34
3774	原来	yuánlái	vốn dĩ, ban đầu	\N	34
3787	预报	yùbào	dự báo	\N	34
3796	乐谱	yuèpǔ	bản nhạc, nhạc phổ	\N	34
3805	运输	yùnshū	vận chuyển	\N	34
3826	语音	yǔyīn	âm thanh, tiếng nói	\N	34
3834	再三	zàisān	nhiều lần, lặp lại	\N	21
3845	攒	zǎn	tích lũy, trữ, gom lại	\N	34
3853	赞扬	zànyáng	khen ngợi, tán dương	\N	34
3867	赠送	zèngsòng	biếu, tặng	\N	40
3877	站	zhàn	đứng	\N	34
3878	斩钉截铁	zhǎndīngjiétiě	chém đinh chặt sắt, dứt khoát	\N	34
3893	照相机	zhàoxiàngjī	máy chụp ảnh	\N	21
3909	招聘	zhāopìn	tuyển dụng	\N	34
3920	遮挡	zhēdǎng	che, ngăn che	\N	34
3930	阵地	zhèndì	trận địa, mặt trận	\N	35
3945	证件	zhèngjiàn	giấy chứng nhận	\N	40
3956	整体	zhěngtǐ	toàn thể, tổng thể	\N	34
3972	震兴	zhènxīng	chấn hưng, hưng thịnh	\N	34
3995	支付	zhīfù	đồng phục	\N	34
4004	治理	zhìlǐ	thống trị, quản lý	\N	34
4013	职能	zhínéng	chức năng, công năng	\N	34
4034	知足常乐	zhīzú cháng lè	tri túc thì vui	\N	34
4049	终年	zhōngnián	suốt cả năm	\N	34
4058	中旬	zhōngxún	trung tuần, giữa tháng	\N	40
4074	拙劣	zhuōliè	trục trặc, trắc trở	\N	34
4086	转变	zhuǎnbiàn	chuyển biến, thay đổi	\N	34
4101	专门	zhuānmén	chuyên môn, chuyên	\N	34
4120	主流	zhǔliú	chủ yếu, xu hướng	\N	34
4136	资深	zīshēn	từng trải, thâm niên	\N	34
4146	资金	zījīn	tiền vốn, quỹ	\N	34
4167	总而言之	zǒng’éryánzhī	nói tóm lại	\N	35
4179	总之	zǒngzhī	nói chung, tóm lại	\N	34
4186	组	zǔ	nhóm, tổ	\N	34
4193	祖国	zǔguó	tổ quốc	\N	34
4205	阻挠	zǔnáo	cản trở, ngăn cản, phá rối	\N	34
4215	作息	zuòxī	làm việc và nghỉ ngơi	\N	40
4226	座右铭	zuòyòumíng	lời răn, lời cách ngôn	\N	34
3692	一起	yīqǐ	cùng nhau	\N	24
3711	意向	yìxiàng	ý định, mục đích	\N	27
3767	遇到	yù dào	gặp phải, gặp được	\N	33
3812	酝酿	yùnniàng	ủ rượu, chuẩn bị (kỹ lưỡng)	\N	40
3978	指	zhǐ	chỉ ra, ngón tay	\N	40
4156	姿态	zītài	tư thế, dáng dấp	\N	37
4026	只要	zhǐyào	chỉ cần	\N	31
4114	主观	zhǔguān	chủ quan	\N	27
3985	知识	zhīshi	tri thức, kiến thức	\N	40
3674	英勇	yīngyǒng	anh dũng	\N	34
\.


--
-- Data for Name: vocabulary_box; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vocabulary_box (box_id, user_id, created_at, updated_at) FROM stdin;
1	2	2026-01-05 11:57:47.748	2026-01-05 11:57:47.748
2	4	2026-01-06 12:20:46.343	2026-01-06 12:20:46.343
\.


--
-- Data for Name: vocabulary_box_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) FROM stdin;
1	1	32	t	f	0	0	1	2026-01-05 11:57:47.755	2026-01-05 11:57:47.755
2	1	52	t	f	0	0	1	2026-01-05 11:57:48.774	2026-01-05 11:57:48.774
3	1	55	t	f	0	0	1	2026-01-05 11:57:49.225	2026-01-05 11:57:49.225
4	1	141	t	f	0	0	1	2026-01-05 11:57:49.67	2026-01-05 11:57:49.67
5	1	122	t	f	0	0	1	2026-01-05 11:57:50.19	2026-01-05 11:57:50.19
6	1	210	t	f	0	0	1	2026-01-05 11:57:50.624	2026-01-05 11:57:50.624
7	1	219	t	f	0	0	1	2026-01-05 11:57:50.789	2026-01-05 11:57:50.789
8	1	229	t	f	0	0	1	2026-01-05 11:57:51.159	2026-01-05 11:57:51.159
9	1	143	t	f	0	0	1	2026-01-05 11:57:51.53	2026-01-05 11:57:51.53
10	1	151	t	f	0	0	1	2026-01-05 11:57:51.883	2026-01-05 11:57:51.883
14	2	97	t	f	0	0	1	2026-01-06 12:20:48.466	2026-01-06 12:20:48.466
15	2	91	t	f	0	0	1	2026-01-06 12:20:48.849	2026-01-06 12:20:48.849
16	2	151	t	f	0	0	1	2026-01-06 12:20:49.554	2026-01-06 12:20:49.554
17	2	143	t	f	0	0	1	2026-01-06 12:20:49.891	2026-01-06 12:20:49.891
11	2	32	t	t	0	0	2	2026-01-06 12:20:46.358	2026-01-06 12:33:41.841
12	2	52	t	f	0	0	3	2026-01-06 12:20:47.618	2026-01-06 12:33:42.85
13	2	55	t	f	0	0	2	2026-01-06 12:20:48.128	2026-01-06 12:33:43.335
18	2	141	t	f	0	0	2	2026-01-06 12:20:50.232	2026-01-06 12:33:43.656
19	2	122	t	f	0	0	2	2026-01-06 12:20:50.619	2026-01-06 12:33:44.033
20	2	116	t	f	0	0	2	2026-01-06 12:20:51.822	2026-01-06 12:33:44.376
31	2	171	t	f	0	0	1	2026-01-06 12:33:44.772	2026-01-06 12:33:44.772
32	2	210	t	f	0	0	1	2026-01-06 12:33:45.088	2026-01-06 12:33:45.088
33	2	219	t	f	0	0	1	2026-01-06 12:33:45.469	2026-01-06 12:33:45.469
34	2	229	t	f	0	0	1	2026-01-06 12:33:45.866	2026-01-06 12:33:45.866
35	2	284	t	f	0	0	1	2026-01-06 12:33:46.208	2026-01-06 12:33:46.208
36	2	1652	t	f	0	0	1	2026-01-07 12:45:47.488	2026-01-07 12:45:47.488
39	2	4027	t	f	0	0	1	2026-01-07 12:45:50.205	2026-01-07 12:45:50.205
40	2	3343	t	f	0	0	1	2026-01-07 12:45:50.764	2026-01-07 12:45:50.764
41	2	3710	t	f	0	0	1	2026-01-07 12:45:51.348	2026-01-07 12:45:51.348
42	2	4022	t	f	0	0	1	2026-01-07 12:45:52.544	2026-01-07 12:45:52.544
43	2	1106	t	f	0	0	1	2026-01-07 12:45:52.956	2026-01-07 12:45:52.956
37	2	1128	t	f	0	0	2	2026-01-07 12:45:48.967	2026-01-07 12:45:53.343
38	2	4024	t	f	0	0	2	2026-01-07 12:45:49.85	2026-01-07 12:45:54.184
\.


--
-- Data for Name: vocabulary_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vocabulary_categories (id, name_vi, name_en) FROM stdin;
21	Số đếm & số lượng	\N
22	Con người & quan hệ xã hội	\N
23	Nghề nghiệp & công việc	\N
24	Sức khỏe & cơ thể	\N
25	Động vật & thực vật	\N
26	Món ăn & đồ uống	\N
27	Đồ dùng & quần áo	\N
28	Phương tiện & giao thông	\N
29	Địa điểm & môi trường	\N
30	Thời gian & thời tiết	\N
31	Giải trí & sở thích	\N
32	Trường học & học tập	\N
33	Ngôn ngữ & giao tiếp	\N
34	Tính từ & đặc điểm	\N
35	Từ loại đặc biệt & trợ từ	\N
36	Văn hóa – thói quen – lễ nghi	\N
37	Mua sắm & giao dịch	\N
38	Công việc, kinh doanh	\N
39	Hoạt động thường ngày	\N
40	Động từ	\N
\.


--
-- Name: daily_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.daily_tasks_id_seq', 91, true);


--
-- Name: flashcards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.flashcards_id_seq', 10, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.news_id_seq', 2, true);


--
-- Name: sentence_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sentence_categories_id_seq', 20, true);


--
-- Name: sentences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sentences_id_seq', 100, true);


--
-- Name: user_daily_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_daily_scores_id_seq', 36, true);


--
-- Name: user_monthly_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_monthly_scores_id_seq', 39, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);


--
-- Name: vocabulary_box_box_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vocabulary_box_box_id_seq', 2, true);


--
-- Name: vocabulary_box_item_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vocabulary_box_item_item_id_seq', 45, true);


--
-- Name: vocabulary_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vocabulary_categories_id_seq', 40, true);


--
-- Name: vocabulary_vocab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vocabulary_vocab_id_seq', 4229, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: daily_tasks daily_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_tasks
    ADD CONSTRAINT daily_tasks_pkey PRIMARY KEY (id);


--
-- Name: daily_tasks daily_tasks_user_id_date_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_tasks
    ADD CONSTRAINT daily_tasks_user_id_date_key UNIQUE (user_id, date);


--
-- Name: flashcards flashcards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: sentence_categories sentence_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sentence_categories
    ADD CONSTRAINT sentence_categories_pkey PRIMARY KEY (id);


--
-- Name: sentences sentences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);


--
-- Name: user_daily_scores user_daily_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_daily_scores
    ADD CONSTRAINT user_daily_scores_pkey PRIMARY KEY (id);


--
-- Name: user_monthly_scores user_monthly_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_monthly_scores
    ADD CONSTRAINT user_monthly_scores_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: vocabulary_box_item vocabulary_box_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box_item
    ADD CONSTRAINT vocabulary_box_item_pkey PRIMARY KEY (item_id);


--
-- Name: vocabulary_box vocabulary_box_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box
    ADD CONSTRAINT vocabulary_box_pkey PRIMARY KEY (box_id);


--
-- Name: vocabulary_categories vocabulary_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_categories
    ADD CONSTRAINT vocabulary_categories_pkey PRIMARY KEY (id);


--
-- Name: vocabulary vocabulary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_pkey PRIMARY KEY (vocab_id);


--
-- Name: user_daily_scores_user_id_score_date_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_daily_scores_user_id_score_date_key ON public.user_daily_scores USING btree (user_id, score_date);


--
-- Name: user_monthly_scores_user_id_month_cycle_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_monthly_scores_user_id_month_cycle_key ON public.user_monthly_scores USING btree (user_id, month_cycle);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: vocabulary_box_item_box_id_vocab_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vocabulary_box_item_box_id_vocab_id_key ON public.vocabulary_box_item USING btree (box_id, vocab_id);


--
-- Name: vocabulary_box_user_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vocabulary_box_user_id_key ON public.vocabulary_box USING btree (user_id);


--
-- Name: daily_tasks daily_tasks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_tasks
    ADD CONSTRAINT daily_tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: sentences sentences_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.sentence_categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_daily_scores user_daily_scores_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_daily_scores
    ADD CONSTRAINT user_daily_scores_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_monthly_scores user_monthly_scores_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_monthly_scores
    ADD CONSTRAINT user_monthly_scores_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vocabulary_box_item vocabulary_box_item_box_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box_item
    ADD CONSTRAINT vocabulary_box_item_box_id_fkey FOREIGN KEY (box_id) REFERENCES public.vocabulary_box(box_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vocabulary_box_item vocabulary_box_item_vocab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box_item
    ADD CONSTRAINT vocabulary_box_item_vocab_id_fkey FOREIGN KEY (vocab_id) REFERENCES public.vocabulary(vocab_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: vocabulary_box vocabulary_box_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary_box
    ADD CONSTRAINT vocabulary_box_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: vocabulary vocabulary_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.vocabulary_categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict uFxq2wIazTeQue9E4xSjx4kbgagqR5xbw971G4C48AjVImHSZpdHHhmncIOoyDY

