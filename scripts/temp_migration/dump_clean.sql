--
-- PostgreSQL database dump
--


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
1	/uploads/flashcards/2_1.png	å…«	active	2026-01-05 11:52:56.037	2026-01-05 11:52:56.037
2	/uploads/flashcards/3_1.png	çˆ¸çˆ¸	active	2026-01-05 11:53:25.542	2026-01-05 11:53:25.542
3	/uploads/flashcards/4_1.png	é¼»å­	active	2026-01-05 11:53:37.915	2026-01-05 11:53:37.915
4	/uploads/flashcards/5_1.png	ä¸	active	2026-01-05 11:53:53.14	2026-01-05 11:53:53.14
5	/uploads/flashcards/6_1.png	é•¿	active	2026-01-05 11:54:12.091	2026-01-05 11:54:12.091
6	/uploads/flashcards/7_1.png	åƒ	active	2026-01-05 11:54:26.02	2026-01-05 11:54:26.02
7	/uploads/flashcards/8_1.png	å¤§	active	2026-01-05 11:54:39.634	2026-01-05 11:54:39.634
8	/uploads/flashcards/9_1.png	å¤	active	2026-01-05 11:54:52.378	2026-01-05 11:54:52.378
9	/uploads/flashcards/10_1.png	ç‚¹	active	2026-01-05 11:55:40.018	2026-01-05 11:55:59.943
10	/uploads/flashcards/11_1.png	è€³æœµ	active	2026-01-05 11:56:13.107	2026-01-05 11:56:13.107
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.news (id, title, content, start_date, end_date, created_at, updated_at) FROM stdin;
1	Æ¯U ÄĂƒI TRáº¢I NGHIá»†M VIP	Má»—i thĂ¡ng chĂºng tĂ´i sáº½ xĂ©t láº¥y ra 10 ngÆ°á»i cao nháº¥t theo toĂ n quá»‘c, theo miá»n, theo tá»‰nh Ä‘á»ƒ táº·ng tráº£i nghiá»‡m VIP 1 thĂ¡ng.\n- LÆ°u Ă½: Khuyáº¿n máº¡i khĂ´ng cá»™ng dá»“n thĂ¡ng	2026-01-06	2030-11-06	2026-01-06 13:42:07.633	2026-01-06 13:42:07.633
\.


--
-- Data for Name: sentence_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sentence_categories (id, name_vi, name_en) FROM stdin;
1	ChĂ o há»i	Greetings
2	Giá»›i thiá»‡u báº£n thĂ¢n	Self Introduction
3	Gia Ä‘Ă¬nh	Family
4	MĂ u sáº¯c	Colors
5	Sá»‘ Ä‘áº¿m	Numbers
6	Thá»i gian	Time
7	Thá»i tiáº¿t	Weather
8	Thá»±c pháº©m	Food
9	Mua sáº¯m	Shopping
10	Giao thĂ´ng	Transportation
11	Sá»©c khá»e	Health
12	Há»c táº­p	Education
13	CĂ´ng viá»‡c	Work
14	Du lá»‹ch	Travel
15	Thá»ƒ thao	Sports
16	Sá»Ÿ thĂ­ch	Hobbies
17	Cáº£m xĂºc	Emotions
18	Äá»‹a Ä‘iá»ƒm	Places
19	Mua bĂ¡n	Buying and Selling
20	Äiá»‡n thoáº¡i vĂ  Internet	Phone and Internet
\.


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) FROM stdin;
1	ä½ å¥½	NÇ hÇo	Xin chĂ o	1
2	æ—©ä¸å¥½	ZÇoshang hÇo	ChĂ o buá»•i sĂ¡ng	1
3	æ™ä¸å¥½	WÇnshang hÇo	ChĂ o buá»•i tá»‘i	1
4	å†è§	ZĂ ijiĂ n	Táº¡m biá»‡t	1
5	è°¢è°¢	XiĂ¨xie	Cáº£m Æ¡n	1
6	æˆ‘å«å°æ˜	WÇ’ jiĂ o XiÇomĂ­ng	TĂ´i tĂªn lĂ  Tiá»ƒu Minh	2
7	æˆ‘æ¥è‡ªè¶å—	WÇ’ lĂ¡izĂ¬ YuĂ¨nĂ¡n	TĂ´i Ä‘áº¿n tá»« Viá»‡t Nam	2
8	æˆ‘ä»å¹´äºŒåäº”å²	WÇ’ jÄ«nniĂ¡n Ă¨rshĂ­wÇ” suĂ¬	NÄƒm nay tĂ´i hai mÆ°Æ¡i lÄƒm tuá»•i	2
9	æˆ‘æ˜¯å­¦ç”Ÿ	WÇ’ shĂ¬ xuĂ©sheng	TĂ´i lĂ  sinh viĂªn	2
10	å¾ˆé«˜å…´è®¤è¯†ä½ 	HÄ›n gÄoxĂ¬ng rĂ¨nshi nÇ	Ráº¥t vui Ä‘Æ°á»£c lĂ m quen vá»›i báº¡n	2
11	è¿™æ˜¯æˆ‘ç„å®¶äºº	ZhĂ¨ shĂ¬ wÇ’ de jiÄrĂ©n	ÄĂ¢y lĂ  gia Ä‘Ă¬nh tĂ´i	3
12	æˆ‘æœ‰ä¸¤ä¸ªå…„å¼Ÿ	WÇ’ yÇ’u liÇng gĂ¨ xiÅngdĂ¬	TĂ´i cĂ³ hai ngÆ°á»i anh em	3
13	æˆ‘çˆ¶æ¯å¾ˆå¥åº·	WÇ’ fĂ¹mÇ” hÄ›n jiĂ nkÄng	Bá»‘ máº¹ tĂ´i ráº¥t khá»e máº¡nh	3
14	æˆ‘å§å§æ˜¯è€å¸ˆ	WÇ’ jiÄ›jie shĂ¬ lÇoshÄ«	Chá»‹ gĂ¡i tĂ´i lĂ  giĂ¡o viĂªn	3
15	æˆ‘ä»¬ä¸€å®¶äººå¾ˆå¹¸ç¦	WÇ’men yÄ«jiÄrĂ©n hÄ›n xĂ¬ngfĂº	Gia Ä‘Ă¬nh chĂºng tĂ´i ráº¥t háº¡nh phĂºc	3
16	æˆ‘å–œæ¬¢çº¢è‰²	WÇ’ xÇhuan hĂ³ngsĂ¨	TĂ´i thĂ­ch mĂ u Ä‘á»	4
17	å¤©ç©ºæ˜¯è“è‰²ç„	TiÄnkÅng shĂ¬ lĂ¡nsĂ¨ de	Báº§u trá»i mĂ u xanh	4
18	è¿™æœµè±æ˜¯é»„è‰²ç„	ZhĂ¨ duÇ’ huÄ shĂ¬ huĂ¡ngsĂ¨ de	BĂ´ng hoa nĂ y mĂ u vĂ ng	4
19	é»‘è‰²æ˜¯æˆ‘ç„æœ€çˆ±	HÄ“isĂ¨ shĂ¬ wÇ’ de zuĂ¬ Ă i	MĂ u Ä‘en lĂ  mĂ u yĂªu thĂ­ch cá»§a tĂ´i	4
20	ç™½è‰²ä»£è¡¨çº¯æ´	BĂ¡isĂ¨ dĂ ibiÇo chĂºnjiĂ©	MĂ u tráº¯ng tÆ°á»£ng trÆ°ng cho sá»± trong tráº¯ng	4
21	ä¸€å ä¸€ç­‰äºäºŒ	YÄ« jiÄ yÄ« dÄ›ngyĂº Ă¨r	Má»™t cá»™ng má»™t báº±ng hai	5
22	æˆ‘æœ‰ä¸‰ä¸ªè‹¹æœ	WÇ’ yÇ’u sÄn gĂ¨ pĂ­ngguÇ’	TĂ´i cĂ³ ba quáº£ tĂ¡o	5
23	ä»å¤©æ˜¯äº”æœˆåäº”å·	JÄ«ntiÄn shĂ¬ wÇ”yuĂ¨ shĂ­wÇ” hĂ o	HĂ´m nay lĂ  ngĂ y mÆ°á»i lÄƒm thĂ¡ng nÄƒm	5
24	è¿™æœ¬ä¹¦æœ‰äº”ç™¾é¡µ	ZhĂ¨ bÄ›n shÅ« yÇ’u wÇ”bÇi yĂ¨	Cuá»‘n sĂ¡ch nĂ y cĂ³ nÄƒm trÄƒm trang	5
25	æˆ‘ä¹°äº†åæ”¯ç¬”	WÇ’ mÇile shĂ­ zhÄ« bÇ	TĂ´i Ä‘Ă£ mua mÆ°á»i cĂ¢y bĂºt	5
26	ç°åœ¨å‡ ç‚¹äº†ï¼Ÿ	XiĂ nzĂ i jÇ diÇn le?	BĂ¢y giá» máº¥y giá» rá»“i?	6
27	æˆ‘æ¯å¤©æ—©ä¸ä¸ƒç‚¹èµ·åº	WÇ’ mÄ›itiÄn zÇoshang qÄ« diÇn qÇchuĂ¡ng	Má»—i sĂ¡ng tĂ´i thá»©c dáº­y lĂºc báº£y giá»	6
28	ä»å¤©æ˜¯æ˜ŸæœŸä¸€	JÄ«ntiÄn shĂ¬ xÄ«ngqÄ«yÄ«	HĂ´m nay lĂ  thá»© Hai	6
29	æˆ‘ä»¬ä¸‹ä¸ªæœˆå»æ—…è¡Œ	WÇ’men xiĂ  gĂ¨ yuĂ¨ qĂ¹ lÇxĂ­ng	ThĂ¡ng sau chĂºng tĂ´i sáº½ Ä‘i du lá»‹ch	6
30	ä¼è®®åœ¨ä¸‹åˆä¸‰ç‚¹å¼€å§‹	HuĂ¬yĂ¬ zĂ i xiĂ wÇ” sÄn diÇn kÄishÇ	Cuá»™c há»p báº¯t Ä‘áº§u lĂºc ba giá» chiá»u	6
31	ä»å¤©å¤©æ°”å¾ˆå¥½	JÄ«ntiÄn tiÄnqĂ¬ hÄ›n hÇo	HĂ´m nay thá»i tiáº¿t ráº¥t Ä‘áº¹p	7
32	å¤–é¢åœ¨ä¸‹é›¨	WĂ imiĂ n zĂ i xiĂ  yÇ”	BĂªn ngoĂ i Ä‘ang mÆ°a	7
33	ä»å¤©å¾ˆçƒ­	JÄ«ntiÄn hÄ›n rĂ¨	HĂ´m nay ráº¥t nĂ³ng	7
34	å†¬å¤©å¾ˆå†·	DÅngtiÄn hÄ›n lÄ›ng	MĂ¹a Ä‘Ă´ng ráº¥t láº¡nh	7
35	æ˜å¤©ä¼æ™´å¤©	MĂ­ngtiÄn huĂ¬ qĂ­ngtiÄn	NgĂ y mai sáº½ náº¯ng	7
36	æˆ‘æƒ³åƒé¢æ¡	WÇ’ xiÇng chÄ« miĂ ntiĂ¡o	TĂ´i muá»‘n Äƒn mĂ¬	8
37	è¿™ä¸ªèœå¾ˆå¥½åƒ	ZhĂ¨ gĂ¨ cĂ i hÄ›n hÇochÄ«	MĂ³n Äƒn nĂ y ráº¥t ngon	8
38	æˆ‘å–œæ¬¢åƒæ°´æœ	WÇ’ xÇhuan chÄ« shuÇguÇ’	TĂ´i thĂ­ch Äƒn trĂ¡i cĂ¢y	8
39	è¯·ç»™æˆ‘ä¸€æ¯æ°´	QÇng gÄ›i wÇ’ yÄ« bÄ“i shuÇ	Xin cho tĂ´i má»™t cá»‘c nÆ°á»›c	8
40	æˆ‘ä¸å–œæ¬¢åƒè¾£ç„	WÇ’ bĂ¹ xÇhuan chÄ« lĂ  de	TĂ´i khĂ´ng thĂ­ch Äƒn cay	8
41	è¿™ä»¶è¡£æœå¤å°‘é’±ï¼Ÿ	ZhĂ¨ jiĂ n yÄ«fu duÅshao qiĂ¡n?	Bá»™ quáº§n Ă¡o nĂ y bao nhiĂªu tiá»n?	9
42	æˆ‘å¯ä»¥è¯•ç©¿å—ï¼Ÿ	WÇ’ kÄ›yÇ shĂ¬chuÄn ma?	TĂ´i cĂ³ thá»ƒ thá»­ Ä‘Æ°á»£c khĂ´ng?	9
43	å¤ªè´µäº†ï¼Œèƒ½ä¾¿å®œç‚¹å—ï¼Ÿ	TĂ i guĂ¬ le, nĂ©ng piĂ¡nyi diÇn ma?	Äáº¯t quĂ¡, cĂ³ thá»ƒ ráº» hÆ¡n má»™t chĂºt khĂ´ng?	9
44	æˆ‘è¦ä¹°è¿™ä¸ª	WÇ’ yĂ o mÇi zhĂ¨ gĂ¨	TĂ´i muá»‘n mua cĂ¡i nĂ y	9
45	å¯ä»¥ç”¨ä¿¡ç”¨å¡å—ï¼Ÿ	KÄ›yÇ yĂ²ng xĂ¬nyĂ²ngkÇ ma?	CĂ³ thá»ƒ dĂ¹ng tháº» tĂ­n dá»¥ng khĂ´ng?	9
46	æˆ‘è¦å»æœºåœº	WÇ’ yĂ o qĂ¹ jÄ«chÇng	TĂ´i muá»‘n Ä‘i Ä‘áº¿n sĂ¢n bay	10
47	æ€ä¹ˆå»ç«è½¦ç«™ï¼Ÿ	ZÄ›nme qĂ¹ huÇ’chÄ“zhĂ n?	LĂ m sao Ä‘á»ƒ Ä‘áº¿n ga tĂ u?	10
48	æˆ‘åå…¬äº¤è½¦ä¸ç­	WÇ’ zuĂ² gÅngjiÄochÄ“ shĂ ngbÄn	TĂ´i Ä‘i xe buĂ½t Ä‘i lĂ m	10
49	è¯·å¼€æ…¢ä¸€ç‚¹	QÇng kÄi mĂ n yÄ«diÇn	Xin lĂ¡i cháº­m má»™t chĂºt	10
50	è¿™é‡Œå¯ä»¥åœè½¦å—ï¼Ÿ	ZhĂ¨lÇ kÄ›yÇ tĂ­ngchÄ“ ma?	á» Ä‘Ă¢y cĂ³ thá»ƒ Ä‘á»— xe khĂ´ng?	10
51	æˆ‘å¤´ç–¼	WÇ’ tĂ³utĂ©ng	TĂ´i bá»‹ Ä‘au Ä‘áº§u	11
52	ä½ éœ€è¦å»çœ‹åŒ»ç”Ÿ	NÇ xÅ«yĂ o qĂ¹ kĂ n yÄ«shÄ“ng	Báº¡n cáº§n Ä‘i khĂ¡m bĂ¡c sÄ©	11
53	æˆ‘æ„Ÿå†’äº†	WÇ’ gÇnmĂ o le	TĂ´i bá»‹ cáº£m	11
54	å¤å–æ°´ï¼Œå¤ä¼‘æ¯	DuÅ hÄ“ shuÇ, duÅ xiÅ«xi	Uá»‘ng nhiá»u nÆ°á»›c, nghá»‰ ngÆ¡i nhiá»u	11
55	æˆ‘æ„Ÿè§‰å¥½å¤äº†	WÇ’ gÇnjuĂ© hÇo duÅ le	TĂ´i cáº£m tháº¥y khá»e hÆ¡n nhiá»u rá»“i	11
56	æˆ‘åœ¨å­¦ä¸­æ–‡	WÇ’ zĂ i xuĂ© ZhÅngwĂ©n	TĂ´i Ä‘ang há»c tiáº¿ng Trung	12
57	è¿™ä¸ªå­—æ€ä¹ˆå†™ï¼Ÿ	ZhĂ¨ gĂ¨ zĂ¬ zÄ›nme xiÄ›?	Chá»¯ nĂ y viáº¿t nhÆ° tháº¿ nĂ o?	12
58	è¯·å†è¯´ä¸€é	QÇng zĂ i shuÅ yÄ«biĂ n	Xin nĂ³i láº¡i má»™t láº§n ná»¯a	12
59	æˆ‘æ˜å¤©æœ‰è€ƒè¯•	WÇ’ mĂ­ngtiÄn yÇ’u kÇoshĂ¬	NgĂ y mai tĂ´i cĂ³ bĂ i thi	12
60	ä½ ä½œä¸åå®Œäº†å—ï¼Ÿ	NÇ zuĂ²yĂ¨ zuĂ²wĂ¡n le ma?	Báº¡n Ä‘Ă£ lĂ m xong bĂ i táº­p chÆ°a?	12
61	æˆ‘æ˜¯å·¥ç¨‹å¸ˆ	WÇ’ shĂ¬ gÅngchĂ©ngshÄ«	TĂ´i lĂ  ká»¹ sÆ°	13
62	æˆ‘ä¹ç‚¹ä¸ç­	WÇ’ jiÇ” diÇn shĂ ngbÄn	TĂ´i Ä‘i lĂ m lĂºc chĂ­n giá»	13
63	ä»å¤©å·¥ä½œå¾ˆå¿™	JÄ«ntiÄn gÅngzuĂ² hÄ›n mĂ¡ng	HĂ´m nay cĂ´ng viá»‡c ráº¥t báº­n	13
64	æˆ‘ä¸‹ç­äº†	WÇ’ xiĂ bÄn le	TĂ´i Ä‘Ă£ tan lĂ m	13
65	è¿™ä¸ªé¡¹ç›®å¾ˆé‡è¦	ZhĂ¨ gĂ¨ xiĂ ngmĂ¹ hÄ›n zhĂ²ngyĂ o	Dá»± Ă¡n nĂ y ráº¥t quan trá»ng	13
66	æˆ‘æƒ³å»åŒ—äº¬æ—…æ¸¸	WÇ’ xiÇng qĂ¹ BÄ›ijÄ«ng lÇyĂ³u	TĂ´i muá»‘n Ä‘i du lá»‹ch Báº¯c Kinh	14
67	è¿™é‡Œé£æ™¯å¾ˆç¾	ZhĂ¨lÇ fÄ“ngjÇng hÄ›n mÄ›i	Cáº£nh Ä‘áº¹p á»Ÿ Ä‘Ă¢y ráº¥t Ä‘áº¹p	14
68	æˆ‘è¦è®¢ä¸€ä¸ªæˆ¿é—´	WÇ’ yĂ o dĂ¬ng yÄ« gĂ¨ fĂ¡ngjiÄn	TĂ´i muá»‘n Ä‘áº·t má»™t phĂ²ng	14
69	è¯·ç»™æˆ‘ä¸€å¼ åœ°å›¾	QÇng gÄ›i wÇ’ yÄ« zhÄng dĂ¬tĂº	Xin cho tĂ´i má»™t táº¥m báº£n Ä‘á»“	14
70	è¿™ä¸ªåŸå¸‚å¾ˆæœ‰å	ZhĂ¨ gĂ¨ chĂ©ngshĂ¬ hÄ›n yÇ’umĂ­ng	ThĂ nh phá»‘ nĂ y ráº¥t ná»•i tiáº¿ng	14
71	æˆ‘å–œæ¬¢æ‰“ç¯®çƒ	WÇ’ xÇhuan dÇ lĂ¡nqiĂº	TĂ´i thĂ­ch chÆ¡i bĂ³ng rá»•	15
72	æˆ‘æ¯å¤©è·‘æ­¥	WÇ’ mÄ›itiÄn pÇobĂ¹	TĂ´i cháº¡y bá»™ má»—i ngĂ y	15
73	è¶³çƒæ¯”èµ›å¾ˆç²¾å½©	ZĂºqiĂº bÇsĂ i hÄ›n jÄ«ngcÇi	Tráº­n Ä‘áº¥u bĂ³ng Ä‘Ă¡ ráº¥t hay	15
74	æˆ‘è¦å»å¥èº«æˆ¿	WÇ’ yĂ o qĂ¹ jiĂ nshÄ“nfĂ¡ng	TĂ´i muá»‘n Ä‘i phĂ²ng gym	15
75	è¿å¨å¯¹èº«ä½“å¥½	YĂ¹ndĂ²ng duĂ¬ shÄ“ntÇ hÇo	Táº­p thá»ƒ dá»¥c tá»‘t cho sá»©c khá»e	15
76	æˆ‘å–œæ¬¢å¬éŸ³ä¹	WÇ’ xÇhuan tÄ«ng yÄ«nyuĂ¨	TĂ´i thĂ­ch nghe nháº¡c	16
77	æˆ‘çˆ±å¥½è¯»ä¹¦	WÇ’ Ă ihĂ o dĂºshÅ«	TĂ´i thĂ­ch Ä‘á»c sĂ¡ch	16
78	å‘¨æœ«æˆ‘å–œæ¬¢çœ‹ç”µå½±	ZhÅumĂ² wÇ’ xÇhuan kĂ n diĂ nyÇng	Cuá»‘i tuáº§n tĂ´i thĂ­ch xem phim	16
79	æˆ‘ä¼å¼¹é’¢ç´	WÇ’ huĂ¬ tĂ¡n gÄngqĂ­n	TĂ´i biáº¿t chÆ¡i Ä‘Ă n piano	16
80	ç”»ç”»æ˜¯æˆ‘ç„çˆ±å¥½	HuĂ huĂ  shĂ¬ wÇ’ de Ă ihĂ o	Váº½ tranh lĂ  sá»Ÿ thĂ­ch cá»§a tĂ´i	16
81	æˆ‘å¾ˆé«˜å…´	WÇ’ hÄ›n gÄoxĂ¬ng	TĂ´i ráº¥t vui	17
82	æˆ‘æœ‰ç‚¹ç´¯	WÇ’ yÇ’udiÇn lĂ¨i	TĂ´i hÆ¡i má»‡t	17
83	æˆ‘å¾ˆæ‹…å¿ƒ	WÇ’ hÄ›n dÄnxÄ«n	TĂ´i ráº¥t lo láº¯ng	17
84	è¿™è®©æˆ‘å¾ˆç”Ÿæ°”	ZhĂ¨ rĂ ng wÇ’ hÄ›n shÄ“ngqĂ¬	Äiá»u nĂ y lĂ m tĂ´i ráº¥t tá»©c giáº­n	17
85	æˆ‘æ„Ÿåˆ°å¾ˆæ”¾æ¾	WÇ’ gÇndĂ o hÄ›n fĂ ngsÅng	TĂ´i cáº£m tháº¥y ráº¥t thÆ° giĂ£n	17
86	é“¶è¡Œåœ¨å“ªé‡Œï¼Ÿ	YĂ­nhĂ¡ng zĂ i nÇlÇ?	NgĂ¢n hĂ ng á»Ÿ Ä‘Ă¢u?	18
87	æˆ‘è¦å»å›¾ä¹¦é¦†	WÇ’ yĂ o qĂ¹ tĂºshÅ«guÇn	TĂ´i muá»‘n Ä‘i thÆ° viá»‡n	18
88	åŒ»é™¢åœ¨é‚£è¾¹	YÄ«yuĂ n zĂ i nĂ biÄn	Bá»‡nh viá»‡n á»Ÿ Ä‘áº±ng kia	18
89	å­¦æ ¡ç¦»è¿™é‡Œå¾ˆè¿œ	XuĂ©xiĂ o lĂ­ zhĂ¨lÇ hÄ›n yuÇn	TrÆ°á»ng há»c cĂ¡ch Ä‘Ă¢y ráº¥t xa	18
90	è¶…å¸‚åœ¨å·¦è¾¹	ChÄoshĂ¬ zĂ i zuÇ’biÄn	SiĂªu thá»‹ á»Ÿ bĂªn trĂ¡i	18
91	æˆ‘æƒ³å–è¿™è¾†è½¦	WÇ’ xiÇng mĂ i zhĂ¨ liĂ ng chÄ“	TĂ´i muá»‘n bĂ¡n chiáº¿c xe nĂ y	19
92	è¿™ä¸ªä»·æ ¼åˆç†å—ï¼Ÿ	ZhĂ¨ gĂ¨ jiĂ gĂ© hĂ©lÇ ma?	GiĂ¡ nĂ y cĂ³ há»£p lĂ½ khĂ´ng?	19
93	æˆ‘è¦ä¹°æ–°æ‰‹æœº	WÇ’ yĂ o mÇi xÄ«n shÇ’ujÄ«	TĂ´i muá»‘n mua Ä‘iá»‡n thoáº¡i má»›i	19
94	å¯ä»¥æ‰“æ˜å—ï¼Ÿ	KÄ›yÇ dÇzhĂ© ma?	CĂ³ thá»ƒ giáº£m giĂ¡ khĂ´ng?	19
95	æˆ‘ä»˜ç°é‡‘	WÇ’ fĂ¹ xiĂ njÄ«n	TĂ´i tráº£ báº±ng tiá»n máº·t	19
96	ä½ ç„ç”µè¯å·ç æ˜¯å¤å°‘ï¼Ÿ	NÇ de diĂ nhuĂ  hĂ omÇ shĂ¬ duÅshao?	Sá»‘ Ä‘iá»‡n thoáº¡i cá»§a báº¡n lĂ  bao nhiĂªu?	20
97	è¯·ç»™æˆ‘å‘å¾®ä¿¡	QÇng gÄ›i wÇ’ fÄ WÄ“ixĂ¬n	Xin gá»­i cho tĂ´i tin nháº¯n WeChat	20
98	ç½‘ç»œè¿æ¥ä¸å¥½	WÇngluĂ² liĂ¡njiÄ“ bĂ¹ hÇo	Káº¿t ná»‘i máº¡ng khĂ´ng tá»‘t	20
99	æˆ‘è¦ä¸‹è½½è¿™ä¸ªåº”ç”¨	WÇ’ yĂ o xiĂ zĂ i zhĂ¨ gĂ¨ yĂ¬ngyĂ²ng	TĂ´i muá»‘n táº£i á»©ng dá»¥ng nĂ y	20
100	è¯·å æˆ‘å¾®ä¿¡	QÇng jiÄ wÇ’ WÄ“ixĂ¬n	Xin thĂªm tĂ´i vĂ o WeChat	20
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
2	Nguyen Toan	toannguyentien10091998@gmail.com	$2b$10$5Yc0roYITIdLfyI7zn2MH.EzCwEek/cSLh1R5DpyWE28WfeSvEKK6	2026-01-05 11:38:49.944	admin	t	\N	\N	normal	google	f	\N	\N	\N		Báº¯c Ninh	bac	0	0
3	Dev Capybara	capybaradev2004@gmail.com	$2b$10$/fJXe1MCfrmdYqM10Sl3.eUFN0RRulN0wKAvshBPUmaasWDKXnYbG	2026-01-05 12:47:31.37	customer	t	\N	\N	vip	google	f	\N	\N	\N	\N	\N	bac	0	0
4	ToĂ¡n Nguyá»…n	toannguyentien28022004@gmail.com	$2b$10$M3diGKavYdpH6TljdwjbReZwuU0VTeDp.6EHeXBWcFgSywV1.zRQm	2026-01-06 12:09:17.768	admin	t	\N	\N	normal	google	f	\N	\N	\N		HĂ  Ná»™i	bac	0	0
\.


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) FROM stdin;
1275	å›ºç„¶	gĂ¹rĂ¡n	táº¥t nhiĂªn, cá»‘ nhiĂªn	\N	34
766	åå®	jiÄndĂ¬ng	kiĂªn Ä‘á»‹nh, vá»¯ng vĂ ng	\N	34
1510	å»ºç­‘	jiĂ nzhĂ¹	tĂ²a nhĂ 	\N	34
1533	æ•™è®­	jiĂ oxĂ¹n	giĂ¡o huáº¥n, dáº¡y báº£o	\N	40
2443	å¯ç¤º	qÇshĂ¬	gá»£i Ă½, gá»£i cho biáº¿t	\N	40
2760	ç¤ºèŒƒ	shĂ¬fĂ n	gÆ°Æ¡ng sĂ¡ng, gÆ°Æ¡ng tá»‘t	\N	34
1	â€¦åˆ†ä¹‹â€¦	â€¦fÄ“n zhÄ«â€¦	chi nhĂ¡nh, pháº§n (trÄƒm)	\N	34
463	æˆç†Ÿ	chĂ©ngshĂº	thĂ nh thá»¥c, trÆ°á»Ÿng thĂ nh, chĂ­n cháº¯n	\N	30
620	ç£‹å•†	cuÅshÄng	bĂ n báº¡c, há»™i Ă½, trao Ä‘á»•i	\N	40
1793	ä¸¾ä¸–ç©ç›®	jÇ”shĂ¬ zhÇ”mĂ¹	thu hĂºt sá»± chĂº Ă½ trĂªn toĂ n tháº¿ giá»›i	\N	30
2803	å®äº‹æ±‚æ˜¯	shĂ­shĂ¬qiĂºshĂ¬	tháº­t thĂ  cáº§u thá»‹	\N	24
2825	æ”¶ç›	shÅuyĂ¬	lá»£i nhuáº­n, thu lá»£i	\N	30
2947	å°	tĂ¡i	Ä‘Ă i, bá»‡, sĂ¢n kháº¥u, chiáº¿c	\N	24
3042	åœç•™	tĂ­ngliĂº	dá»«ng láº¡i, á»Ÿ láº¡i	\N	40
3403	å½¢ç¶	xĂ­ngzhuĂ ng	hĂ¬nh dĂ¡ng, hĂ¬nh dáº¡ng	\N	31
3557	çƒŸè±çˆ†ç«¹	yÄnhuÄ bĂ ozhĂº	phĂ¡o hoa, phĂ¡o ná»•	\N	25
3829	é¢„å…†	yĂ¹zhĂ o	Ä‘iá»m bĂ¡o, dáº¥u hiá»‡u	\N	21
2	å•	a	a, Ă , á»«, á»	\N	35
4196	é†‰	zuĂ¬	say rÆ°á»£u, bia	\N	26
1132	å·¥å¤«	gÅngfÅ«	thá»i gian, ngÆ°á»i lĂ m thuĂª, cĂ´ng sá»©c, ráº£nh rá»—i	\N	30
1330	åˆæˆ	hĂ©chĂ©ng	há»£p thĂ nh, cĂ¢u thĂ nh	\N	24
3	å‘µ	Ä	Æ¡, á»›i, ui, ui cha	\N	34
4	çˆ±	Ă i	yĂªu	\N	34
5	çŸ®	Çi	tháº¥p	\N	34
6	å”‰	Äi	Ă´i, than Ă´i, trá»i Æ¡i	\N	34
7	æŒ¨	Ă¡i	bá»‹, chá»‹u Ä‘á»±ng, gáº·p pháº£i	\N	34
69	ç»‘æ¶	bÇngjiĂ 	báº¯t cĂ³c	\N	34
8	çˆ±ä¸é‡æ‰‹	Ă ibĂ¹shĂ¬shÇ’u	quyáº¿n luyáº¿n khĂ´ng rá»i	\N	34
796	é¡¶	dÇng	Ä‘á»‰nh	\N	40
9	çˆ±æˆ´	Ă idĂ i	yĂªu quĂ½, kĂ­nh yĂªu	\N	34
10	çˆ±å¥½	Ă ihĂ o	yĂªu thĂ­ch, thĂ­ch	\N	34
585	å‡ºç§Ÿè½¦	chÅ«zÅ«chÄ“	Taxi	\N	40
11	çˆ±æ¤	Ă ihĂ¹	yĂªu quĂ½, báº£o vá»‡	\N	34
1098	å“¥	gÄ“	anh	\N	31
12	æ§æ˜§	Ă imĂ¨i	máº­p má», má» Ă¡m	\N	34
13	çˆ±æƒ…	Ă iqĂ­ng	tĂ¬nh yĂªu	\N	22
1005	åˆ†	fÄ“n	pháº§n, suáº¥t	\N	30
14	çˆ±æƒœ	Ă ixÄ«	yĂªu quĂ½, quĂ½ trá»ng	\N	34
1478	å¯„	jĂ¬	gá»­i	\N	40
15	çˆ±å¿ƒ	Ă ixÄ«n	lĂ²ng nhĂ¢n Ă¡i, yĂªu thÆ°Æ¡ng	\N	40
16	å“å“Ÿ	ÄiyÅ	Ă´i, Ă´i chao	\N	34
17	ç™Œç—‡	Ă¡izhĂ¨ng	ung thÆ°	\N	30
18	å²¸	Ă n	bá» (sĂ´ng, biá»ƒn)	\N	34
1212	ç®¡å­	guÇnzi	á»‘ng	\N	34
19	æ—	Ă n	tá»‘i, u Ă¡m, tháº§m, vá»¥ng trá»™m	\N	34
20	æŒ‰	Ă n	áº¥n, báº¥m	\N	34
2002	å¦	lĂ¬ng	khĂ¡c	\N	30
21	æ¡ˆä»¶	Ă njiĂ n	Ă¡n vá»¥, trÆ°á»ng há»£p, Ă¡n kiá»‡n	\N	34
22	å®‰å±…ä¹ä¸	ÄnjÅ«lĂ¨yĂ¨	an cÆ° láº¡c nghiá»‡p	\N	31
23	æ¡ˆä¾‹	Ă nlĂ¬	Ă¡n lá»‡	\N	31
24	æŒ‰æ‘©	Ă nmĂ³	xoa bĂ³p	\N	34
25	æŒ‰æ—¶	Ă nshĂ­	Ä‘Ăºng giá»	\N	34
26	æŒ‰ç…§	Ă nzhĂ o	cÄƒn cá»© theo	\N	34
1214	å­¤å•	gÅ«dÄn	cĂ´ Ä‘Æ¡n	\N	34
27	å®‰æ’	ÄnpĂ¡i	sáº¯p xáº¿p, bá»‘ trĂ­	\N	40
28	å®‰å…¨	ÄnquĂ¡n	an toĂ n	\N	34
29	æ—ç¤º	Ă nshĂ¬	Ă¡m thá»‹, ra hiá»‡u	\N	40
30	æ¡ˆ	Ă n	vá»¥, Ă¡n, há»“ sÆ¡	\N	34
31	å®‰æ…°	ÄnwĂ¨i	an á»§i	\N	31
32	å®‰è¯¦	ÄnxiĂ¡ng	Ăªm Ä‘á»m	\N	21
1321	æ¯«ç±³	hĂ¡omÇ	milimet	\N	26
1322	å¥½å¥‡	hĂ oqĂ­	hiáº¿u ká»³	\N	40
1428	æ±‡æ¥	huĂ¬bĂ o	bĂ¡o cĂ¡o	\N	34
33	æŒ‰ç€	Ă nzhe	cÄƒn cá»©, dá»±a theo	\N	34
4064	ç²¥	zhÅu	chĂ¡o	\N	34
35	å®‰è£…	ÄnzhuÄng	láº¯p Ä‘áº·t	\N	33
52	ç™¾	bÇi	trÄƒm	\N	21
57	æ‹œå¹´	bĂ iniĂ¡n	Ä‘i chĂºc táº¿t	\N	36
65	é¢å‘	bÄnfÄ	ban phĂ¡t	\N	31
66	æ£’	bĂ ng	gáº­y	\N	28
34	å®‰ç½®	Ă nzhĂ¬	bá»‘ trĂ­ á»•n thá»a, á»•n Ä‘á»‹nh	\N	34
36	ç†¬	Ă¡o	sáº¯c, háº§m	\N	34
37	å¥¥ç§˜	Ă omĂ¬	huyá»n bĂ­, bĂ­ áº©n	\N	40
38	å‡¹å‡¸	ÄotÅ«	lá»“i lĂµm, gá»“ ghá»	\N	34
39	é˜¿å§¨	Ä€yĂ­	cĂ´, dĂ¬	\N	34
40	å§	ba	nhĂ©, nha	\N	35
41	æ	bÇ	láº¥y, Ä‘em	\N	35
42	æ‹”	bĂ¡	nhá»•, rĂºt ra	\N	34
43	ç–¤	bÄ	váº¿t sáº¹o	\N	34
44	çˆ¸çˆ¸	bĂ ba	bá»‘	\N	34
45	å·´ä¸å¾—	bÄbĂ¹dĂ©	Æ°á»›c gĂ¬, chá»‰ mong	\N	35
46	éœ¸é“	bĂ dĂ o	bĂ¡ Ä‘áº¡o, Ä‘á»™c tĂ i, chuyĂªn cháº¿	\N	34
47	ç½¢å·¥	bĂ gÅng	Ä‘Ă¬nh cĂ´ng	\N	34
49	ç™½	bĂ¡i	tráº¯ng	\N	34
50	æ‘†	bÇi	xáº¿p Ä‘áº·t, bĂ y biá»‡n	\N	40
51	æŸ	bÇi	tráº§m	\N	34
53	æ‹œ	bĂ i	bĂ¡i, láº¡y, thá»	\N	40
54	æ‹œè®¿	bĂ ifÇng	Ä‘áº¿n thÄƒm	\N	34
55	ç™¾åˆ†ç‚¹	bÇifÄ“ndiÇn	Ä‘iá»ƒm pháº§n trÄƒm	\N	21
56	è´¥å	bĂ ihuĂ i	hÆ° há»ng	\N	34
58	æ‹œæ‰˜	bĂ ituÅ	xin nhá», kĂ­nh nhá»	\N	34
59	æ‘†è„±	bÇituÅ	thoĂ¡t khá»i	\N	34
60	ç™½æ—¥æ¢¦	bĂ¡irĂ¬mĂ¨ng	má»™ng ban ngĂ y	\N	34
61	ç­	bÄn	lá»›p	\N	34
62	ç‰ˆæœ¬	bÇnbÄ›n	phiĂªn báº£n	\N	34
63	é¢å¸ƒ	bÄnbĂ¹	ban hĂ nh	\N	34
64	åæ³•	bĂ nfÇ	biá»‡n phĂ¡p, cĂ¡ch	\N	40
67	å¸®	bÄng	bÄƒng, nhĂ³m	\N	34
68	å¸®å¿™	bÄngmĂ¡ng	giĂºp, giĂºp Ä‘á»¡	\N	34
121	ä¿ç®¡	bÇoguÇn	báº£o quáº£n	\N	27
80	è†€èƒ±	bÇngguÄng	bĂ ng quang	\N	27
97	æ¥ç¤¾	bĂ oshĂ¨	tĂ²a soáº¡n, tĂ²a bĂ¡o	\N	21
84	åŒ…åº‡	bÄobĂ¬	bao che, che Ä‘áº­y	\N	27
87	å®è´µ	bÇoguĂ¬	quĂ½ giĂ¡	\N	37
88	åŒ…å«	bÄohĂ¡n	chá»©a, bao gá»“m	\N	27
91	ä¿é™©	bÇoxiÇn	báº£o hiá»ƒm	\N	21
119	ä¿å§†	bÇomÇ”	báº£o máº«u, ngÆ°á»i giĂºp viá»‡c	\N	24
151	å¥”æ³¢	bÄ“nbÅ	bĂ´n ba	\N	21
117	æ¥ç­”	bĂ odĂ¡	Ä‘á»n Ä‘Ă¡p	\N	33
71	å‚æ™	bĂ ngwÇn	xáº©m tá»‘i	\N	34
72	æ¦œæ ·	bÇngyĂ ng	táº¥m gÆ°Æ¡ng	\N	34
73	å¸®å©	bÄngzhĂ¹	giĂºp Ä‘á»¡, há»— trá»£	\N	34
74	åç†	bĂ nlÇ	xá»­ lĂ½	\N	40
75	åäº‹	bĂ nshĂ¬	lĂ m viá»‡c	\N	40
76	ä¼´ä¾£	bĂ nlÇ	báº¡n Ä‘á»i, báº¡n Ä‘á»“ng hĂ nh	\N	34
78	ç­ä¸»ä»»	bÄnzhÇ”rĂ¨n	giĂ¡o viĂªn chá»§ nhiá»‡m	\N	34
79	æ¿	bÇn	vĂ¡n, táº¥m vĂ¡n	\N	34
81	æ±	bĂ o	Ă´m, báº¿	\N	34
82	åŒ…	bÄo	bá»c, tĂºi, gĂ³i	\N	27
83	å®è´	bÇobĂ¨i	báº£o bá»‘i, cÆ°ng	\N	34
96	æ´éœ²	bĂ olĂ¹	bá»™c lá»™	\N	34
85	ä¿æŒ	bÇochĂ­	duy trĂ¬, giá»¯ gĂ¬n	\N	40
86	ä¿æ¤	bÇohĂ¹	báº£o vá»‡	\N	34
123	æ´é£	bĂ ofÄ“ng	bĂ£o tá»‘	\N	30
109	åŒ…è£…	bÄozhuÄng	gĂ³i, bá»c	\N	40
90	æ´å›	bĂ olĂ¬	báº¡o lá»±c	\N	34
155	å´©å‘	bÄ“ngfÄ	bĂ¹ng ra, phĂ¡t ná»•	\N	40
92	ä¿å®ˆ	bÇoshÇ’u	báº£o thá»§	\N	30
93	ä¿å«	bÇowĂ¨i	báº£o vá»‡, á»§ng há»™	\N	34
94	æ¥å	bĂ omĂ­ng	bĂ¡o danh, Ä‘Äƒng kĂ½	\N	34
95	æ¥å‘	bĂ ogĂ o	bĂ¡o cĂ¡o, thĂ´ng bĂ¡o	\N	34
163	æœ¬èº«	bÄ›nshÄ“n	tá»± báº£n thĂ¢n	\N	27
166	æœ¬è´¨	bÄ›nzhĂ¬	báº£n cháº¥t	\N	31
98	æ¥é…¬	bĂ ochou	thĂ¹ lao, tiá»n cĂ´ng	\N	34
99	æ¥çº¸	bĂ ozhÇ	bĂ¡o chĂ­	\N	34
100	åŒ…è£¹	bÄoguÇ’	bÆ°u kiá»‡n	\N	40
101	åŒ…å®¹	bÄorĂ³ng	khoan dung, bao dung	\N	34
102	æ¥ä»‡	bĂ ochĂ³u	bĂ¡o thĂ¹	\N	30
104	æ±æ€¨	bĂ oyuĂ n	oĂ¡n háº­n, phĂ n nĂ n	\N	34
105	ä¿è¯	bÇozhĂ¨ng	Ä‘áº£m báº£o	\N	34
106	ä¿é‡	bÇozhĂ²ng	báº£o trá»ng, cáº©n tháº­n	\N	34
107	æ¥å¤	bĂ ofĂ¹	tráº£ thĂ¹	\N	30
108	æ¥è´Ÿ	bĂ ofĂ¹	hoĂ i bĂ£o, tham vá»ng	\N	34
111	æ¥é”€	bĂ oxiÄo	thanh toĂ¡n	\N	34
110	æ¥å…³	bĂ oguÄn	khai háº£i quan	\N	40
112	ä¿å®‰	bÇoâ€™Än	báº£o vá»‡ an ninh	\N	40
113	ä¿ä½‘	bÇoyĂ²u	phĂ¹ há»™	\N	34
114	ä¿éœ	bÇozhĂ ng	Ä‘áº£m báº£o	\N	34
115	ä¿å…»	bÇoyÇng	báº£o dÆ°á»¡ng	\N	34
118	çˆ†ç‚¸	bĂ ozhĂ 	ná»•, bĂ¹ng ná»•	\N	34
120	æ´é›¨	bĂ oyÇ”	mÆ°a to	\N	30
122	å®çŸ³	bÇoshĂ­	Ä‘Ă¡ quĂ½	\N	21
124	ä¿è¯é‡‘	bÇozhĂ¨ngjÄ«n	tiá»n báº£o chá»©ng	\N	34
125	ä¿å­˜	bÇocĂºn	báº£o tá»“n, lÆ°u giá»¯	\N	34
126	åŒ…å­	bÄozi	bĂ¡nh bao	\N	34
128	ææˆ	bÇxĂ¬	xiáº¿c, trĂ² lá»«a bá»‹p	\N	35
129	å€	bĂ¨i	láº§n, gáº¥p bá»™i	\N	40
130	è¢«	bĂ¨i	bá»‹, Ä‘Æ°á»£c	\N	35
131	èƒŒ	bĂ¨i	lÆ°ng, há»c thuá»™c	\N	34
132	èƒŒè¯µ	bĂ¨isĂ²ng	Ä‘á»c thuá»™c lĂ²ng	\N	34
133	æ‚²å“€	bÄ“iâ€™Äi	bi ai, Ä‘au buá»“n	\N	34
135	æ‚²æƒ¨	bÄ“icÇn	bi tháº£m	\N	34
136	è¢«å¨	bĂ¨idĂ²ng	bá»‹ Ä‘á»™ng	\N	35
137	åŒ—æ–¹	bÄ›ifÄng	miá»n Báº¯c	\N	40
138	å¤‡ä»½	bĂ¨ifĂ¨n	dĂ nh riĂªng, báº£n dá»± phĂ²ng	\N	34
139	è¢«å‘	bĂ¨igĂ o	bá»‹ cĂ¡o	\N	35
140	æ‚²è§‚	bÄ“iguÄn	bi quan	\N	40
141	åŒ—æ	bÄ›ijĂ­	báº¯c cá»±c	\N	21
143	åŒ—äº¬	bÄ›ijÄ«ng	Báº¯c Kinh	\N	21
144	è´å£³	bĂ¨ikĂ©	vá» sĂ², vá» á»‘c	\N	34
145	èƒŒå›	bĂ¨ipĂ n	pháº£n bá»™i	\N	40
146	å¤‡å¿˜å½•	bĂ¨iwĂ nglĂ¹	báº£n ghi nhá»›	\N	34
147	è¢«å­	bĂ¨izi	chÄƒn	\N	35
148	æ¯å­	bÄ“izi	cá»‘c, chĂ©n, ly, tĂ¡ch	\N	34
149	ç¬¨	bĂ¨n	Ä‘áº§n, ngá»‘c	\N	34
150	æœ¬	bÄ›n	quyá»ƒn, gá»‘c, vá»‘n, thĂ¢n	\N	34
153	ç”­	bĂ©ng	khĂ´ng cáº§n	\N	34
154	è¹¦	bĂ¨ng	nháº£y, báº­t, tung ra	\N	40
156	å´©æºƒ	bÄ“ngkuĂ¬	tan vá»¡, sá»¥p Ä‘á»•	\N	34
157	æœ¬ç§‘	bÄ›nkÄ“	khoa chĂ­nh quy	\N	34
158	æœ¬æ¥	bÄ›nlĂ¡i	vá»‘n dÄ©, lĂºc Ä‘áº§u, Ä‘Ă¡ng láº½	\N	40
159	æœ¬é¢†	bÄ›nlÇng	báº£n lÄ©nh, kháº£ nÄƒng	\N	34
160	æœ¬èƒ½	bÄ›nnĂ©ng	báº£n nÄƒng	\N	34
161	æœ¬é’±	bÄ›nqiĂ¡n	vá»‘n	\N	34
162	æœ¬äºº	bÄ›nrĂ©n	báº£n thĂ¢n, tĂ´i	\N	34
164	æœ¬äº‹	bÄ›nshi	kháº£ nÄƒng, báº£n lÄ©nh	\N	34
165	æœ¬ç€	bÄ›nzhe	cÄƒn cá»©, dá»±a vĂ o	\N	40
167	ç¬¨æ‹™	bĂ¨nzhuÅ	vá»¥ng vá»	\N	40
168	è‡‚	bĂ¬	cĂ¡nh tay	\N	34
170	ä¾¿	biĂ n	ngay cáº£, Ä‘á»§ cho, liá»n	\N	40
171	é	biĂ n	láº§n, kháº¯p	\N	21
172	ç¼–	biÄn	dá»‡t, biĂªn soáº¡n	\N	34
173	éå¸ƒ	biĂ nbĂ¹	phĂ¢n bá»‘, ráº£i rĂ¡c	\N	40
174	é­ç­–	biÄncĂ¨	thĂºc giá»¥c	\N	30
175	è´¬ä½	biÇndÄ«	chĂª bai, háº¡ tháº¥p	\N	34
182	è¾¹ç•Œ	biÄnjiĂ¨	ranh giá»›i	\N	30
248	é—­å¡	bĂ¬sĂ¨	táº¯c ngháº½n, báº¿ táº¯c	\N	27
190	è´¬ä¹‰	biÇnyĂ¬	nghÄ©a xáº¥u	\N	24
203	è¡¨å†³	biÇojuĂ©	biá»ƒu quyáº¿t, báº§u	\N	24
217	å¿…å®	bĂ¬dĂ¬ng	nháº¥t Ä‘á»‹nh, cháº¯c cháº¯n	\N	31
224	åˆ«è‡´	biĂ©zhĂ¬	Ä‘á»™c Ä‘Ă¡o, má»›i máº», khĂ¡c thÆ°á»ng	\N	30
226	æ¯”è¾ƒ	bÇjiĂ o	so vá»›i, so sĂ¡nh	\N	22
230	é¿å…	bĂ¬miÇn	trĂ¡nh	\N	26
234	ç—…æ¯’	bĂ¬ngdĂº	vi rĂºt	\N	24
255	é¼»å­	bĂ­zi	mÅ©i	\N	24
245	å¿…è¦	bĂ¬yĂ o	cáº§n	\N	31
177	è¾©æ¤	biĂ nhĂ¹	biá»‡n há»™, báº£o vá»‡	\N	34
178	å˜åŒ–	biĂ nhuĂ 	thay Ä‘á»•i	\N	34
179	ç¼–è¾‘	biÄnjĂ­	biĂªn táº­p, chá»‰nh sá»­a	\N	40
180	è¾¹ç–†	biÄnjiÄng	biĂªn giá»›i	\N	34
181	è¾©è§£	biĂ njiÄ›	biá»‡n giáº£i, giáº£i thĂ­ch	\N	40
183	è¾¹å¢ƒ	biÄnjĂ¬ng	biĂªn giá»›i	\N	34
184	ä¾¿åˆ©	biĂ nlĂ¬	tiá»‡n lá»£i	\N	34
185	è¾©è®º	biĂ nlĂ¹n	tranh luáº­n	\N	40
186	é­ç‚®	biÄnpĂ o	phĂ¡o hoa, phĂ¡o ná»•	\N	34
187	å˜è¿	biĂ nqiÄn	thay Ä‘á»•i, biáº¿n Ä‘á»•i	\N	34
188	è¾¨è®¤	biĂ nrĂ¨n	nháº­n rĂµ, phĂ¢n biá»‡t	\N	40
189	ä¾¿æ¡	biĂ ntiĂ¡o	giáº¥y nháº¯n	\N	40
191	ä¾¿äº	biĂ nyĂº	tiá»‡n lá»£i, tiá»‡n cho	\N	40
193	è¾©è¯	biĂ nzhĂ¨ng	biá»‡n chá»©ng	\N	34
194	å˜è´¨	biĂ nzhĂ¬	biáº¿n cháº¥t, hÆ° há»ng	\N	34
195	ç¼–ç»‡	biÄnzhÄ«	bá»‡n, Ä‘an, táº¿t	\N	34
196	è¾«å­	biĂ nzi	bĂ­m tĂ³c	\N	34
197	æ ‡æœ¬	biÄobÄ›n	máº«u, tiĂªu báº£n	\N	40
198	è¡¨è¾¾	biÇodĂ¡	biá»ƒu Ä‘áº¡t, diá»…n táº£	\N	40
199	æ ‡ç‚¹	biÄodiÇn	cháº¥m cĂ¢u	\N	34
200	è¡¨æ ¼	biÇogĂ©	báº£ng, biá»ƒu	\N	40
201	è¡¨å“¥	biÇogÄ“	anh há»	\N	34
204	è¡¨é¢	biÇomiĂ n	máº·t ngoĂ i, bá» ngoĂ i	\N	34
205	è¡¨æ˜	biÇomĂ­ng	tá» rĂµ, chá»©ng tá»	\N	34
206	è¡¨æƒ…	biÇoqĂ­ng	biá»ƒu cáº£m, nĂ©t máº·t	\N	34
207	è¡¨æ¼”	biÇoyÇn	biá»ƒu diá»…n	\N	40
208	è¡¨å½°	biÇozhÄng	tuyĂªn dÆ°Æ¡ng, khen ngá»£i	\N	34
209	è¡¨ç¤º	biÇoshĂ¬	biá»ƒu thá»‹	\N	40
210	è¡¨æ€	biÇotĂ i	bĂ y tá» thĂ¡i Ä‘á»™	\N	21
211	è¡¨æ‰¬	biÇoyĂ¡ng	khen ngá»£i	\N	34
212	æ ‡å¿—	biÄozhĂ¬	cá»™t má»‘c, kĂ½ hiá»‡u	\N	40
213	æ ‡å‡†	biÄozhÇ”n	tiĂªu chuáº©n	\N	40
215	å½¼æ­¤	bÇcÇ	láº«n nhau	\N	24
216	ä¾¿ç­¾	biĂ nqiÄn	giáº¥y ghi nhá»›	\N	34
218	å¼ç«¯	bĂ¬duÄn	tá»‡ náº¡n, tai háº¡i	\N	40
219	åˆ«	biĂ©	khĂ¡c, chia lĂ¬a	\N	21
220	æ†‹	biÄ“	bá»‹t, nĂ­n, kim nĂ©n	\N	40
221	åˆ«æ‰­	biĂ¨niu	khĂ³ chá»‹u, chÆ°á»›ng, ká»³ quáº·c	\N	34
222	åˆ«äºº	biĂ©rĂ©n	ngÆ°á»i khĂ¡c	\N	34
223	åˆ«å¢…	biĂ©shĂ¹	biá»‡t thá»±	\N	30
225	æ¯”æ–¹	bÇfÄng	vĂ­, so sĂ¡nh, so bĂ¬	\N	34
228	æ¯•ç«Ÿ	bĂ¬jĂ¬ng	rá»‘t cuá»™c, cuá»‘i cĂ¹ng	\N	34
229	æ¯”ä¾‹	bÇlĂ¬	tá»· lá»‡	\N	21
231	ä¸™	bÇng	thá»© ba, BĂ­nh	\N	21
232	å†°é›¹	bÄ«ngbĂ¡o	mÆ°a Ä‘Ă¡	\N	30
233	å¹¶å­˜	bĂ¬ngcĂºn	cĂ¹ng tá»“n táº¡i	\N	34
235	å¹¶é	bĂ¬ngfÄ“i	khĂ´ng	\N	34
236	é¥¼å¹²	bÇnggÄn	bĂ¡nh quy	\N	34
238	å¹¶ä¸”	bĂ¬ngqiÄ›	Ä‘á»“ng thá»i, vĂ , hÆ¡n ná»¯a	\N	34
239	å¹¶è¡Œ	bĂ¬ngxĂ­ng	song hĂ nh, song song	\N	34
240	å®¾é¦†	bÄ«nguÇn	nhĂ  khĂ¡ch, khĂ¡ch sáº¡n	\N	30
241	å†°ç®±	bÄ«ngxiÄng	tá»§ láº¡nh, tá»§ Ä‘Ă¡	\N	34
242	å†°æ¿€å‡Œ	bÄ«ngjÄ«lĂ­ng	kem	\N	21
243	æ»¨ä¸´	bÄ«nlĂ­n	ká» bĂªn, ká» cáº­n	\N	34
244	æ‘ˆå¼ƒ	bĂ¬nqĂ¬	tá»« bá», vá»©t bá»	\N	34
246	æ¯”å¦‚	bÇrĂº	vĂ­ dá»¥ nhÆ°, cháº³ng háº¡n nhÆ°	\N	30
247	æ¯”èµ›	bÇsĂ i	thi Ä‘áº¥u	\N	24
249	æ³Œ	bĂ¬	tiáº¿t (cháº¥t lá»ng)	\N	34
251	æ¯•ä¸	bĂ¬yĂ¨	tá»‘t nghiá»‡p	\N	34
252	ç¢§ç‰	bĂ¬yĂ¹	ngá»c bĂ­ch	\N	34
253	æ¯”å–»	bÇyĂ¹	vĂ­ dá»¥, vĂ­ von	\N	34
254	æ¯”é‡	bÇzhĂ²ng	tá»· trá»ng	\N	34
256	æ‹¨æ‰“	bÅdÇ	gá»i (Ä‘iá»‡n thoáº¡i)	\N	34
257	åå¤§ç²¾æ·±	bĂ³dĂ jÄ«ngshÄ“n	uyĂªn bĂ¡c, uyĂªn thĂ¢m	\N	34
258	ææ–—	bĂ³dĂ²u	váº­t lá»™n	\N	34
259	æ’­æ”¾	bÅfĂ ng	truyá»n, phĂ¡t, Ä‘Æ°a tin	\N	40
260	æ³¢æµª	bÅlĂ ng	sĂ³ng	\N	34
262	ç»ç’ƒ	bÅli	thá»§y tinh	\N	30
263	ä¼¯æ¯	bĂ³mÇ”	bĂ¡c gĂ¡i	\N	21
264	åå£«	bĂ³shĂ¬	tiáº¿n sÄ©	\N	40
265	æ³¢æ¶›æ±¹æ¶Œ	bÅtÄoxiÅngyÇ’ng	sĂ³ng cuá»™n trĂ o dĂ¢ng	\N	34
266	åç‰©é¦†	bĂ³wĂ¹guÇn	viá»‡n báº£o tĂ ng	\N	34
267	å‰¥å‰	bÅxuÄ“	bĂ³c lá»™t, lá»£i dá»¥ng	\N	34
268	æ’­ç§	bÅzhĂ²ng	gieo háº¡t	\N	40
269	å¸ƒ	bĂ¹	váº£i	\N	40
270	ä¸	bĂ¹	khĂ´ng, chÆ°a	\N	34
273	ä¸å¥½æ„æ€	bĂ¹hÇoyĂ¬si	cáº£m tháº¥y xáº¥u há»•	\N	34
279	ä¸å°‘	bĂ¹shÇo	khĂ´ng Ă­t	\N	34
280	ä¸è€çƒ¦	bĂ¹ nĂ ifĂ¡n	nĂ³ng náº£y, sá»‘t ruá»™t	\N	34
281	ä¸ç›¸ä¸ä¸‹	bĂ¹ xiÄng shĂ ngxiĂ 	ngang nhau	\N	24
282	ä¸åƒè¯	bĂ¹ xiĂ nghuĂ 	cháº³ng ra lĂ m sao cáº£	\N	34
284	ä¸å®‰	bĂ¹â€™Än	báº¥t an, lo láº¯ng	\N	21
294	éƒ¨åˆ†	bĂ¹fĂ¨n	bá»™ pháº­n	\N	30
321	æ“¦	cÄ	lau chĂ¹i, chĂ , cá»	\N	24
323	èœå•	cĂ idÄn	thá»±c Ä‘Æ¡n	\N	30
335	è´¢å¡	cĂ¡iwĂ¹	tĂ i vá»¥	\N	24
342	å‚è§‚	cÄnguÄn	tham quan	\N	27
343	æ®‹ç–¾	cĂ¡njĂ­	tĂ n táº­t	\N	31
344	å‚å 	cÄnjiÄ	tham gia	\N	40
349	æ®‹ç•™	cĂ¡nliĂº	cĂ²n láº¡i	\N	25
357	æ“å³	cÄolĂ¡o	lĂ m viá»‡c chÄƒm chá»‰	\N	40
275	ä¸ä»…	bĂ¹jÇn	khĂ´ng nhá»¯ng, khĂ´ng chá»‰	\N	34
276	ä¸å…	bĂ¹miÇn	khĂ´ng trĂ¡nh Ä‘Æ°á»£c	\N	34
277	ä¸ç„¶	bĂ¹rĂ¡n	náº¿u khĂ´ng thĂ¬	\N	34
278	ä¸å¦‚	bĂ¹rĂº	khĂ´ng báº±ng	\N	34
377	å·®ä¸å¤	chĂ buduÅ	xáº¥p xá»‰, gáº§n giá»‘ng nhau	\N	30
285	ä¸å¿…	bĂ¹bĂ¬	khĂ´ng cáº§n	\N	34
286	è¡¥å……	bÇ”chÅng	bá»• sung	\N	34
287	ä¸ä½†	bĂ¹dĂ n	khĂ´ng nhá»¯ng	\N	35
288	ä¸å¾—ä¸	bĂ¹dĂ©bĂ¹	khĂ´ng thá»ƒ khĂ´ng	\N	35
289	ä¸å¾—äº†	bĂ¹dĂ©liÇo	cá»±c ká»³	\N	35
291	ä¸æ–­	bĂ¹duĂ n	thÆ°á»ng xuyĂªn, khĂ´ng ngá»«ng	\N	34
292	æ­¥ä¼	bĂ¹fĂ¡	tiáº¿n Ä‘á»™, nhá»‹p bÆ°á»›c	\N	34
293	ä¸å¦¨	bĂ¹fĂ¡ng	Ä‘á»«ng ngáº¡i, khĂ´ng sao	\N	34
379	æŸ´æ²¹	chĂ¡iyĂ³u	dáº§u diesel	\N	24
295	ä¸é¡¾	bĂ¹gĂ¹	khĂ´ng cáº§n biáº¿t Ä‘áº¿n, báº¥t cáº§n	\N	34
296	ä¸ç®¡	bĂ¹guÇn	cho dĂ¹, báº¥t luáº­n	\N	40
297	ä¸è¿‡	bĂ¹guĂ²	nhÆ°ng, cháº³ng qua	\N	34
298	ä¸ç¦	bĂ¹jÄ«n	khĂ´ng nhá»‹n Ä‘Æ°á»£c, khĂ´ng nĂ©n ná»•i	\N	34
299	ä¸ä¹…	bĂ¹jiÇ”	bá»• cá»©u, cá»©u vĂ£n	\N	34
300	å¸ƒå±€	bĂ¹jĂº	bá»‘ cá»¥c	\N	34
301	ä¸å ª	bĂ¹kÄn	khĂ´ng chá»‹u ná»•i	\N	34
303	ä¸æ„§	bĂ¹kuĂ¬	xá»©ng Ä‘Ă¡ng	\N	34
304	éƒ¨è½	bĂ¹luĂ²	bá»™ láº¡c	\N	34
305	éƒ¨é—¨	bĂ¹mĂ©n	bá»™, ngĂ nh	\N	34
306	å“ºä¹³	bÇ”rÇ”	nuĂ´i báº±ng sá»¯a máº¹	\N	34
307	ä¸æ—¶	bĂ¹shĂ­	Ä‘Ă´i khi, thá»‰nh thoáº£ng	\N	34
308	éƒ¨ç½²	bĂ¹shÇ”	sáº¯p xáº¿p, bá»‘ trĂ­	\N	40
309	è¡¥è´´	bÇ”tiÄ“	tiá»n trá»£ cáº¥p	\N	34
310	éƒ¨ä½	bĂ¹wĂ¨i	bá»™ vá»‹, vá»‹ trĂ­	\N	34
311	ä¸æƒœ	bĂ¹xÄ«	ngáº§n ngáº¡i, khĂ´ng tiáº¿c	\N	34
312	ä¸å±‘ä¸€é¡¾	bĂ¹xiĂ¨ yÄ« gĂ¹	khĂ´ng Ä‘Ă¡ng xem	\N	34
313	ä¸è¯è€Œæ„ˆ	bĂ¹yĂ o Ă©r yĂ¹	khĂ´ng sao Ä‘Ă¢u	\N	35
314	ä¸ç”±å¾—	bĂ¹yĂ³ude	khĂ´ng Ä‘Æ°á»£c, Ä‘Ă nh pháº£i	\N	35
316	å¸ƒç½®	bĂ¹zhĂ¬	sáº¯p xáº¿p	\N	40
317	ä¸æ­¢	bĂ¹zhÇ	khĂ´ng ngá»›t, khĂ´ng dá»©t	\N	34
318	æ­¥éª¤	bĂ¹zhĂ²u	bÆ°á»›c Ä‘i, trĂ¬nh tá»±	\N	34
319	æ•æ‰	bÇ”zhuÅ	báº¯t, tĂ³m, chá»¥p	\N	34
320	ä¸è¶³	bĂ¹zĂº	khĂ´ng Ä‘á»§	\N	34
322	æ‰	cĂ¡i	má»›i (Ä‘á»™ng tĂ¡c diá»…n ra muá»™n)	\N	40
324	é‡‡è®¿	cÇifÇng	phá»ng váº¥n, sÄƒn tin	\N	34
325	è£ç¼	cĂ¡ifĂ©ng	thá»£ may	\N	34
326	è´¢å¯Œ	cĂ¡ifĂ¹	sá»± giĂ u cĂ³	\N	34
327	æ‰å¹²	cĂ¡igĂ n	nÄƒng lá»±c, tĂ i cĂ¡n	\N	34
328	é‡‡è´­	cÇigĂ²u	mua, thu mua	\N	30
329	æ‰å	cĂ¡ihuĂ¡	tĂ i nÄƒng	\N	34
331	é‡‡çº³	cÇinĂ 	tiáº¿p nháº­n, tiáº¿p thu	\N	40
332	è£åˆ¤	cĂ¡ipĂ n	trá»ng tĂ i	\N	34
333	å½©ç¥¨	cÇipiĂ o	vĂ© sá»‘	\N	34
334	é‡‡å–	cÇiqÇ”	láº¥y, Ă¡p dá»¥ng	\N	40
337	è´¢æ”¿	cĂ¡izhĂ¨ng	tĂ i chĂ­nh	\N	38
338	èˆ±	cÄng	khoang, buá»“ng	\N	34
339	è‹ç™½	cÄngbĂ¡i	tĂ¡i nhá»£t	\N	34
340	ä»“ä¿ƒ	cÄngcĂ¹	vá»™i vĂ ng	\N	34
341	ä»“åº“	cÄngkĂ¹	kho	\N	34
345	å‚è€ƒ	cÄnkÇo	tham kháº£o	\N	34
346	æ®‹é…·	cĂ¡nkĂ¹	tĂ n khá»‘c, tĂ n báº¡o	\N	34
347	æƒ­æ„§	cĂ¡nkuĂ¬	xáº¥u há»•	\N	34
348	ç¿çƒ‚	cĂ nlĂ n	sĂ¡ng láº¡ng, rá»±c rá»¡	\N	34
351	é¤å…	cÄntÄ«ng	phĂ²ng Äƒn, nhĂ  Äƒn	\N	34
352	å‚ä¸	cÄnyĂ¹	tham dá»±	\N	35
353	å‚ç…§	cÄnzhĂ o	tham chiáº¿u, báº¯t trÆ°á»›c	\N	34
354	è‰	cÇo	cá»	\N	34
355	è‰æ¡ˆ	cÇoâ€™Ă n	báº£n tháº£o	\N	34
356	æ“åœº	cÄochÇng	sĂ¢n váº­n Ä‘á»™ng, bĂ£i táº­p	\N	34
358	æ“ç»ƒ	cÄoliĂ n	luyá»‡n táº­p	\N	34
359	è‰ç‡	cÇoshuĂ i	qua loa, Ä‘áº¡i khĂ¡i	\N	34
360	æ“å¿ƒ	cÄoxÄ«n	báº­n tĂ¢m, lo láº¯ng	\N	34
361	å˜ˆæ‚	cĂ¡ozĂ¡	á»“n Ă o	\N	34
362	æ“çºµ	cÄozĂ²ng	Ä‘iá»u khiá»ƒn, thao tĂºng	\N	34
363	æ“ä½œ	cÄozuĂ²	thao tĂ¡c	\N	34
364	å†Œ	cĂ¨	sá»•, quyá»ƒn, táº­p	\N	34
366	æµ‹é‡	cĂ¨liĂ¡ng	Ä‘o lÆ°á»ng	\N	34
367	ç­–ç•¥	cĂ¨lĂ¼Ă¨	sĂ¡ch lÆ°á»£c	\N	34
368	ä¾§é¢	cĂ¨miĂ n	máº·t bĂªn	\N	34
369	å±‚	cĂ©ng	táº§ng	\N	31
371	æ›¾ç»	cĂ©ngjÄ«ng	tá»«ng, Ä‘Ă£ tá»«ng	\N	34
372	å•æ‰€	cĂ¨suÇ’	nhĂ  vá»‡ sinh	\N	35
373	æµ‹éªŒ	cĂ¨yĂ n	kiá»ƒm tra, tráº¯c nghiá»‡m	\N	40
374	èŒ¶	chĂ¡	trĂ 	\N	26
375	å‰	chÄ	que, ngáº¡nh, ráº½	\N	34
376	å·®åˆ«	chÄbiĂ©	khĂ¡c nhau	\N	24
378	æ’åº§	chÄzuĂ²	stá»• cáº¯m Ä‘iá»‡n	\N	34
1642	è®¡åˆ’	jĂ¬huĂ 	káº¿ hoáº¡ch	\N	34
385	äº§å“	chÇnpÇn	sáº£n pháº©m	\N	38
415	ç¼ ç»•	chĂ¡nrĂ o	quáº¥n, quáº¥n quanh	\N	27
401	å°	chĂ¡ng	thÆ°á»ng thá»©c	\N	34
430	å‰å­	chÄzi	cĂ¡i nÄ©a	\N	25
390	é•¿	zhÇng	tÄƒng lĂªn	\N	40
437	ç§¤	chĂ¨ng	cĂ¡i cĂ¢n	\N	31
438	åŸå¸‚	chĂ©ngshĂ¬	thĂ nh phá»‘	\N	29
381	æ‹†	chÄi	thĂ¡o, gá»¡	\N	34
382	æ‹†è¿	chÄiqiÄn	di dá»i, giáº£i tá»a	\N	34
383	ç¼ 	chĂ¡n	vÆ°á»›ng, quáº¥n, dĂ¢y dÆ°a	\N	40
384	é¦‹	chĂ¡n	ham Äƒn, tham Äƒn	\N	34
452	æˆäº¤	chĂ©ngjiÄo	giao dá»‹ch	\N	37
464	æˆå¤©	chĂ©ngtiÄn	suá»‘t ngĂ y, cáº£ ngĂ y	\N	30
388	é¢¤æ–	chĂ ndÇ’u	run ráº©y	\N	40
389	æ˜Œç››	chÄngshĂ¨ng	hÆ°ng thá»‹nh, hÆ°ng vÆ°á»£ng	\N	34
472	ä¹˜å	chĂ©ngzuĂ²	Ä‘i, cÆ°á»¡i (tĂ u, xe, mĂ¡y bayâ€¦)	\N	28
391	å¸¸	chĂ¡ng	thÆ°á»ng	\N	34
392	åœº	chÇng	nÆ¡i, bĂ£i, cuá»™c, tráº­n	\N	34
393	å‚	chÇng	xÆ°á»Ÿng, nhĂ  mĂ¡y	\N	34
394	é•¿åŸ	chĂ¡ngchĂ©ng	TrÆ°á»ng ThĂ nh	\N	34
395	é•¿å¤„	chĂ¡ngchĂ¹	Æ°u Ä‘iá»ƒm	\N	40
396	é•¿çŸ­	chĂ¡ngduÇn	dĂ i ngáº¯n	\N	34
397	é•¿æ±Ÿ	chĂ¡ngjiÄng	TrÆ°á»ng Giang	\N	34
398	å¸¸è¯†	chĂ¡ngshĂ­	kiáº¿n thá»©c phá»• thĂ´ng	\N	34
399	å”±	chĂ ng	hĂ¡t	\N	31
400	å”±æ­Œ	chĂ nggÄ“	hĂ¡t	\N	31
477	æ²‰æ€	chĂ©nsÄ«	suy ngáº«m, tráº§m tÆ°	\N	28
403	å¿è¿˜	chĂ¡nghuĂ¡n	tráº£ ná»£, bá»“i hoĂ n	\N	40
404	æ•å¼€	chÇngkÄi	má»Ÿ rá»™ng, thoáº£i mĂ¡i	\N	34
405	çŒ–ç‹‚	chÄngkuĂ¡ng	ngang ngÆ°á»£c, Ä‘iĂªn cuá»“ng	\N	34
406	åœºé¢	chÇngmiĂ n	tĂ¬nh cáº£nh	\N	26
407	å¸¸å¹´	chĂ¡ngniĂ¡n	quanh nÄƒm, lĂ¢u dĂ i, háº±ng nÄƒm	\N	40
408	å°è¯•	chĂ¡ngshĂ¬	thá»­	\N	30
409	åœºæ‰€	chÇngsuÇ’	nÆ¡i	\N	35
410	ç•…é€	chĂ ngtÅng	thĂ´ng suá»‘t, trĂ´i cháº£y	\N	34
411	é•¿é€”	chĂ¡ngtĂº	dĂ i, Ä‘Æ°á»ng dĂ i	\N	34
412	å¸¸å¡	chĂ¡ngwĂ¹	thÆ°á»ng vá»¥	\N	34
413	é•¿è¢–	chĂ¡ngxiĂ¹	bĂ¡nh chay	\N	40
387	äº§ä¸	chÇnyĂ¨	sáº£n nghiá»‡p, ngĂ nh nghá»	\N	34
416	å±•ç¤º	zhÇnshĂ¬	trĂ¬nh bĂ y, biá»ƒu hiá»‡n	\N	40
417	æœ	chĂ¡o	ngoáº£nh máº·t vá», hÆ°á»›ng vá»	\N	40
418	åµ	chÇo	á»“n Ă o, tranh cĂ£i	\N	34
419	ç‚’	chÇo	xĂ o, rang	\N	34
420	æ„	chÄo	copy, sao chĂ©p	\N	34
421	è¶…è¶	chÄoyuĂ¨	vÆ°á»£t qua	\N	34
422	æœä»£	chĂ¡odĂ i	triá»u Ä‘áº¡i	\N	40
423	è¶…å‡º	chÄochÅ«	vÆ°á»£t quĂ¡, vÆ°á»£t lĂªn	\N	40
424	è¶…çº§	chÄojĂ­	siĂªu, siĂªu cáº¥p	\N	40
425	æ½®æµ	chĂ¡oliĂº	trĂ o lÆ°u	\N	34
427	æ½®æ¹¿	chĂ¡oshÄ«	áº©m Æ°á»›t	\N	34
428	è¶…å¸‚	chÄoshĂ¬	siĂªu thá»‹	\N	40
429	è¯§å¼‚	chĂ yĂ¬	ngáº¡c nhiĂªn	\N	40
431	å½»åº•	chĂ¨dÇ	triá»‡t Ä‘á»ƒ, hoĂ n toĂ n	\N	34
432	è½¦åº“	chÄ“kĂ¹	nhĂ  Ä‘á»ƒ xe	\N	28
433	è¶	chĂ¨n	nhĂ¢n lĂºc, thá»«a dá»‹p	\N	30
434	æ²‰æ·€	chĂ©ndiĂ n	káº¿t tá»§a	\N	40
435	ä¹˜	chĂ©ng	Ä‘i, cÆ°á»¡i	\N	34
436	æ©™	chĂ©ng	trĂ¡i cam	\N	40
440	æ‰¿å	chĂ©ngbĂ n	Ä‘áº£m Ä‘Æ°Æ¡ng	\N	34
441	åŸå ¡	chĂ©ngbÇo	lĂ¢u Ä‘Ă i	\N	24
442	æ‰¿åŒ…	chĂ©ngbÄo	kĂ½ há»£p Ä‘á»“ng, nháº­n tháº§u	\N	34
443	æˆæœ¬	chĂ©ngbÄ›n	chi phĂ­, giĂ¡ thĂ nh	\N	22
444	æ‰¿æ‹…	chĂ©ngdÄn	gĂ¡nh vĂ¡c, Ä‘áº£m Ä‘Æ°Æ¡ng	\N	34
445	æƒ©ç½	chĂ©ngfĂ¡	trá»«ng trá»‹	\N	34
446	æˆåˆ†	chĂ©ngfĂ¨n	thĂ nh pháº§n	\N	30
447	æˆåŸ	chĂ©nggÅng	thĂ nh cĂ´ng	\N	34
448	æˆæœ	chĂ©ngguÇ’	thĂ nh quáº£	\N	30
449	ç§°å·	chĂ©nghĂ o	tÆ°á»›c vá»‹, danh hiá»‡u	\N	34
450	è¯æ³	chĂ©ngkÄ›n	chĂ¢n thĂ nh	\N	22
451	æˆå‘˜	chĂ©ngyuĂ¡n	thĂ nh viĂªn	\N	40
453	æˆç«‹	chĂ©nglĂ¬	thĂ nh láº­p	\N	30
454	æ‰¿è®¤	chĂ©ngrĂ¨n	thá»«a nháº­n	\N	40
456	æˆå°±	chĂ©ngjiĂ¹	thĂ nh tá»±u	\N	30
457	æˆè¯­	chĂ©ngyÇ”	thĂ nh ngá»¯	\N	30
458	ç§°å‘¼	chĂ©nghu	xÆ°ng hĂ´	\N	34
459	æˆå…¨	chĂ©ngquĂ¡n	hoĂ n thĂ nh, giĂºp hoĂ n thiá»‡n	\N	40
460	æˆæ¸…	chĂ©ngqÄ«ng	lĂ m rĂµ	\N	34
461	è¯å®	chĂ©ngshĂ­	thĂ nh thá»±c, tháº­t thĂ 	\N	30
462	æ‰¿å—	chĂ©ngshĂ²u	chá»‹u Ä‘á»±ng	\N	34
465	æˆä¸º	chĂ©ngwĂ©i	trá»Ÿ thĂ nh	\N	34
467	å‘ˆç°	chĂ©ngxiĂ n	lá»™ ra, phÆ¡i bĂ y	\N	40
468	æˆæ•ˆ	chĂ©ngxiĂ o	hiá»‡u quáº£, cĂ´ng hiá»‡u	\N	34
469	ç§°èµ	chÄ“ngzĂ n	khen ngá»£i	\N	34
470	æˆé•¿	chĂ©ngzhÇng	lá»›n lĂªn	\N	34
471	è¯æŒ	chĂ©ngzhĂ¬	chĂ¢n thĂ nh, thĂ¢n Ă¡i	\N	22
473	é™ˆæ—§	chĂ©njiĂ¹	lá»—i thá»i, cÅ© ká»¹	\N	34
474	é™ˆåˆ—	chĂ©nliĂ¨	trÆ°ng bĂ y	\N	21
475	æ²‰é—·	chĂ©nmĂ¨n	ngá»™t ngáº¡t, náº·ng ná»	\N	34
476	æ²‰é»˜	chĂ©nmĂ²	im láº·ng	\N	21
478	æ²‰ç—›	chĂ©ntĂ²ng	Ä‘au thÆ°Æ¡ng, bi thá»‘ng	\N	34
479	æ²‰é‡	chĂ©nzhĂ²ng	trĂ¡ch nhiá»‡m, náº·ng ná»	\N	40
480	æ²‰ç€	chĂ©nzhuĂ³	bĂ¬nh tÄ©nh, vá»¯ng vĂ ng	\N	34
481	è¶æœº	chĂ¨njÄ«	thá»«a cÆ¡, nhĂ¢n dá»‹p	\N	30
496	å°ºå­	chÇzi	thÆ°á»›c Ä‘o	\N	30
502	é‡å¤	chĂ³ngfĂ¹	láº·p láº¡i, trĂ¹ng láº·p	\N	25
512	æ½çƒŸ	chÅuyÄn	hĂºt thuá»‘c	\N	30
522	ä¸‘	chÇ’u	xáº¥u xĂ­	\N	24
533	èˆ¹èˆ¶	chuĂ¡nbĂ³	thuyá»n bĂ¨	\N	28
544	çª—å¸˜	chuÄngliĂ¡n	rĂ¨m cá»­a sá»•	\N	21
534	ä¼ æ’­	chuĂ¡nbÅ	truyá»n bĂ¡	\N	21
555	åˆæ­¥	chÅ«bĂ¹	sÆ¡ bá»™, bÆ°á»›c Ä‘áº§u	\N	24
483	è¶çƒ­æ‰“é“	chĂ¨nrĂ¨ dÇtiÄ›	thá»«a tháº¯ng xĂ´ng lĂªn	\N	30
484	é©°éª‹	chĂ­chÄ›ng	phi nÆ°á»›c Ä‘áº¡i	\N	34
485	è¿Ÿåˆ°	chĂ­dĂ o	Ä‘áº¿n muá»™n	\N	34
486	èµ¤é“	chĂ¬dĂ o	xĂ­ch Ä‘áº¡o	\N	34
487	è¿Ÿç¼“	chĂ­huÇn	trĂ¬ trá»‡, cháº­m cháº¡p	\N	34
489	æŒä¹…	chĂ­jiÇ”	kĂ©o dĂ i	\N	34
490	åƒè‹¦	chÄ«kÇ”	chá»‹u khá»•, chá»‹u thiá»‡t	\N	34
491	åƒäº	chÄ«kuÄ«	chá»‹u thiá»‡t, bá»‹ thiá»‡t háº¡i	\N	40
492	åƒå›	chÄ«lĂ¬	má»‡t nhá»c, tá»‘n sá»©c	\N	34
493	æ± å¡˜	chĂ­tĂ¡ng	há»“, ao, Ä‘áº§m	\N	34
494	æŒç»­	chĂ­xĂ¹	tiáº¿p tá»¥c	\N	40
495	èµ¤å­—	chĂ¬zĂ¬	thĂ¢m há»¥t, bá»™i chi	\N	34
498	å†²å¨	chÅngdĂ²ng	xung Ä‘á»™ng, kĂ­ch thĂ­ch	\N	34
499	å……å½“	chÅngdÄng	Ä‘áº£m nháº­n, giá»¯ chá»©c	\N	40
500	å……ç”µå™¨	chÅngdiĂ nqĂ¬	bá»™ sáº¡c	\N	34
501	å……è¶³	chÅngzĂº	Ä‘áº§y Ä‘á»§	\N	40
503	å´‡é«˜	chĂ³nggÄo	cao cáº£	\N	34
504	å´‡æ•¬	chĂ³ngjĂ¬ng	tĂ´n kĂ­nh, kĂ­nh trá»ng	\N	34
505	å´‡æ‹œ	chĂ³ngbĂ i	sĂ¹ng bĂ¡i, tĂ´n thá»	\N	34
506	é‡å 	chĂ³ngdiĂ©	chá»“ng chĂ©o	\N	34
508	å® ç‰©	chÇ’ngwĂ¹	thĂº cÆ°ng, váº­t nuĂ´i	\N	34
509	å® çˆ±	chÇ’ngâ€™Ă i	yĂªu thÆ°Æ¡ng, cÆ°ng chiá»u	\N	34
510	æ½å±‰	chÅuti	ngÄƒn kĂ©o	\N	34
511	æ½è±¡	chÅuxiĂ ng	trá»«u tÆ°á»£ng	\N	34
513	æ½å¥–	chÅujiÇng	rĂºt thÄƒm trĂºng thÆ°á»Ÿng	\N	34
514	è‡­	chĂ²u	hĂ´i	\N	34
515	å‡ºç‰ˆ	chÅ«bÇn	xuáº¥t báº£n	\N	40
516	å‡ºå·®	chÅ«chÄi	cĂ´ng tĂ¡c	\N	34
517	å‡ºå‘	chÅ«fÄ	xuáº¥t phĂ¡t	\N	40
519	å‡ºå£	chÅ«kÇ’u	lá»‘i ra / xuáº¥t kháº©u	\N	40
520	å‡ºç±»æ‹”èƒ	chÅ«lĂ¨i bĂ¡cuĂ¬	xuáº¥t chĂºng, Æ°u tĂº	\N	40
521	å‡ºè‰²	chÅ«sĂ¨	xuáº¥t sáº¯c	\N	40
523	ç­¹å¤‡	chĂ³ubĂ¨i	chuáº©n bá»‹, trĂ¹ bá»‹	\N	40
524	è¸Œèº‡	chĂ³uchĂº	do dá»±, trÄƒn trá»«	\N	34
525	ä¸‘æ¶	chÇ’uâ€™Ă¨	xáº¥u xĂ­, Ă¡c Ä‘á»™c	\N	34
527	ç¨ å¯†	chĂ³umĂ¬	dĂ y Ä‘áº·c	\N	40
528	é™¤	chĂº	trá»« bá», phĂ©p chia	\N	34
529	å‡º	chÅ«	ra, xuáº¥t, Ä‘áº¿n	\N	40
530	èˆ¹	chuĂ¡n	thuyá»n, tĂ u	\N	28
531	ä¸²	chuĂ n	chuá»—i, xĂ¢u	\N	34
532	ç©¿ç€	chuÄnzhuĂ³	máº·c, Ä‘á»™i	\N	34
536	ä¼ å•	chuĂ¡ndÄn	tá» rÆ¡i, truyá»n Ä‘Æ¡n	\N	34
537	ä¼ é€’	chuĂ¡ndĂ¬	truyá»n, chuyá»ƒn	\N	34
538	èˆ¹èˆ±	chuĂ¡ncÄng	khoang tĂ u, boong	\N	34
539	é—¯	chuÇng	xĂ´ng, Ä‘Ă¢m bá»•	\N	34
540	åˆ›ä½œ	chuĂ ngzuĂ²	sĂ¡ng tĂ¡c	\N	31
542	çª—æˆ·	chuÄnghu	cá»­a sá»•	\N	34
543	åˆ›ç«‹	chuĂ nglĂ¬	thĂ nh láº­p, sĂ¡ng láº­p	\N	30
545	åˆ›æ–°	chuĂ ngxÄ«n	cáº£i tiáº¿n, Ä‘á»•i má»›i	\N	34
546	åˆ›ä¸	chuĂ ngyĂ¨	láº­p nghiá»‡p, khá»Ÿi nghiá»‡p	\N	34
548	ç©¿è¶	chuÄnyuĂ¨	vÆ°á»£t qua, vÆ°á»£t	\N	34
549	ä¼ æŸ“	chuĂ¡nrÇn	truyá»n nhiá»…m	\N	40
550	ä¼ æˆ	chuĂ¡nshĂ²u	truyá»n dáº¡y, truyá»n thá»¥	\N	40
552	ä¼ ç»Ÿ	chuĂ¡ntÇ’ng	truyá»n thá»‘ng	\N	34
553	ä¼ çœŸ	chuĂ¡nzhÄ“n	fax	\N	21
554	å‚¨å¤‡	chÇ”bĂ¨i	dá»± trá»¯, Ä‘á»ƒ dĂ nh	\N	21
556	å‚¨å­˜	chÇ”cĂºn	dá»± trá»¯, Ä‘á»ƒ dĂ nh	\N	21
557	è§¦ç¯	chĂ¹fĂ n	xĂºc pháº¡m, xĂ¢m pháº¡m	\N	34
558	å¨æˆ¿	chĂºfĂ¡ng	báº¿p	\N	34
559	é™¤é	chĂºfÄ“i	trá»« phi	\N	21
560	å¤„ç½	chÇ”fĂ¡	trá»«ng pháº¡t	\N	34
561	é”¤	chuĂ­	cĂ¡i bĂºa	\N	40
562	å¹	chuÄ«	thá»•i	\N	34
563	å¹ç‰›	chuÄ«niĂº	khoĂ¡c lĂ¡c, thá»•i phá»“ng	\N	34
564	å¹æ§	chuÄ«pÄ›ng	tĂ¢ng bá»‘c, ca tá»¥ng	\N	34
565	å‚ç›´	chuĂ­zhĂ­	vuĂ´ng gĂ³c, tháº³ng Ä‘á»©ng	\N	34
566	åˆçº§	chÅ«jĂ­	sÆ¡ cáº¥p	\N	34
568	é™¤äº†	chĂºle	ngoĂ i ra, trá»« ra	\N	35
569	å¤„ç†	chÇ”lÇ	xá»­ lĂ½	\N	40
570	å‡ºè·¯	chÅ«lĂ¹	lá»‘i thoĂ¡t, Ä‘Æ°á»ng ra	\N	40
571	å‡ºå–	chÅ«mĂ i	bĂ¡n	\N	40
572	æ˜¥	chÅ«n	mĂ¹a xuĂ¢n	\N	30
573	çº¯ç²¹	chĂºncuĂ¬	tinh khiáº¿t, thuáº§n khiáº¿t	\N	40
574	çº¯æ´	chĂºnjiĂ©	thuáº§n khiáº¿t, trong sáº¡ch	\N	34
575	å‡ºç¥	chÅ«shĂ©n	xuáº¥t tháº§n, say sÆ°a	\N	40
576	å‡ºèº«	chÅ«shÄ“n	xuáº¥t thĂ¢n	\N	40
577	å‡ºç”Ÿ	chÅ«shÄ“ng	sinh ra, ra Ä‘á»i	\N	40
578	é™¤å¤•	chĂºxÄ«	Ä‘Ăªm giao thá»«a	\N	40
580	å‡ºå¸­	chÅ«xĂ­	dá»± há»p, cĂ³ máº·t	\N	34
581	å‡ºç°	chÅ«xiĂ n	xuáº¥t hiá»‡n	\N	40
582	å‚¨è“„	chÇ”xĂ¹	dá»± trá»¯, dĂ nh dá»¥m	\N	21
583	å‡ºæ´‹ç›¸	chÅ«yĂ¡ngxiĂ ng	xáº¥u máº·t, lĂ m trĂ² cÆ°á»i cho thiĂªn háº¡	\N	34
584	å¤„ç½®	chÇ”zhĂ¬	xá»­ lĂ½, xá»­ trĂ­	\N	40
1473	èƒ¡å­	hĂºzi	rĂ¢u	\N	24
590	ç£å¸¦	cĂ­dĂ i	bÄƒng tá»«	\N	27
616	ä¿ƒè¿›	cĂ¹shÇ	thĂºc Ä‘áº©y, giĂºp giĂ£	\N	40
593	åˆºæ¿€	cĂ¬jÄ«	kĂ­ch thĂ­ch	\N	32
629	æ‰“ç¯®çƒ	dÇ lĂ¡nqiĂº	chÆ¡i bĂ³ng rá»•	\N	40
633	æ‰“æ‰®	dÇbĂ n	trang Ä‘iá»ƒm, Äƒn váº­n	\N	40
652	ä»£ä»·	dĂ ijiĂ 	giĂ¡ pháº£i tráº£, chi phĂ­	\N	37
654	ä»£ç†	dĂ ilÇ	Ä‘áº¡i lĂ½	\N	38
655	å¸¦é¢†	dĂ ilÇng	dáº«n dáº¯t	\N	31
672	æŒ¡	dÇng	ngÄƒn cháº·n, ngÄƒn cáº£n	\N	24
678	å½“åˆ	dÄngchÅ«	lĂºc Ä‘áº§u, há»“i Ä‘Ă³	\N	24
587	æ¬¡	cĂ¬	láº§n	\N	21
589	æ¬¡è¦	cĂ¬ yĂ o	thá»© yáº¿u, khĂ´ng quan trá»ng	\N	34
2676	æ·±	shÄ“n	sĂ¢u, Ä‘áº­m	\N	24
591	è¯å…¸	cĂ­diÇn	tá»« Ä‘iá»ƒn	\N	40
592	è¯æ±‡	cĂ­huĂ¬	tá»« vá»±ng	\N	34
594	æ­¤å¤–	cÇwĂ i	ngoĂ i ra	\N	40
595	æ…ˆç¥¥	cĂ­xiĂ¡ng	hiá»n tá»«, hiá»n háº­u	\N	40
596	æ¬¡åº	cĂ¬xĂ¹	tráº­t tá»±	\N	40
598	ä¸›	cĂ³ng	bá»¥i, lĂ¹m, khĂ³m	\N	34
599	ä»	cĂ³ng	theo	\N	34
600	ä»æ­¤	cĂ³ngcÇ	tá»« Ä‘Ă³	\N	34
601	ä»è€Œ	cĂ³ngâ€™Ă©r	do Ä‘Ă³, vĂ¬ váº­y	\N	35
602	ä»æ¥	cĂ³nglĂ¡i	tá»« trÆ°á»›c tá»›i nay	\N	40
603	ä»å®¹	cĂ³ngrĂ³ng	Ä‘iá»m tÄ©nh, thong tháº£	\N	34
604	èªæ˜	cÅngmĂ­ng	thĂ´ng minh	\N	34
606	ä»äº‹	cĂ³ngshĂ¬	lĂ m, tham gia	\N	40
607	ä»æœª	cĂ³ngwĂ¨i	chÆ°a tá»«ng, chÆ°a bao giá»	\N	34
608	ä»å°	cĂ³ngxiÇo	tá»« nhá»	\N	34
609	ä»å®¹ä¸è¿«	cĂ³ngrĂ³ngbĂ¹pĂ²	cháº­m rĂ£i, khĂ´ng vá»™i vĂ ng	\N	34
610	å‡‘åˆ	cĂ²uhe	táº­p há»£p, gom gĂ³p, quĂ¢y quáº§n	\N	34
611	é†‹	cĂ¹	giáº¥m	\N	34
612	çªœ	cuĂ n	lá»§i, chuá»“n, cháº¡y toĂ¡n loáº¡n	\N	40
613	å‚¬	cuÄ«	thĂºc giá»¥c	\N	30
614	æ‘§æ®‹	cuÄ«cĂ¡n	phĂ¡ há»§y, tĂ n phĂ¡	\N	30
615	è„†å¼±	cuĂ¬ruĂ²	má»ng manh, yáº¿u Ä‘uá»‘i	\N	34
617	å­˜	cĂºn	tá»“n táº¡i, báº£o tá»“n	\N	34
618	å­˜åœ¨	cĂºnzĂ i	tá»“n táº¡i	\N	34
619	æ’®	cuÅ	xoay, xoáº¯n, váº·n	\N	34
621	æªæ–½	cuĂ²shÄ«	biá»‡n phĂ¡p	\N	40
622	é”™è¯¯	cuĂ²wĂ¹	sai, sai láº§m	\N	34
623	æŒ«æ˜	cuĂ²zhĂ©	sá»± tháº¥t báº¡i	\N	40
624	ç²—å¿ƒ	cÅ«xÄ«n	sÆ¡ Ă½, cáº©u tháº£, báº¥t cáº©n	\N	24
625	å¤§	dĂ 	to, lá»›n	\N	34
626	æ‰“	dÇ	Ä‘Ă¡nh, mĂ¡t, Ä‘áº­p, phĂ¡c, khoĂ¡c	\N	34
627	æ‰“ç”µè¯	dÇ diĂ nhuĂ 	gá»i Ä‘iá»‡n thoáº¡i	\N	34
628	æ‰“å®˜å¸	dÇ guÄnsi	kiá»‡n	\N	40
630	æ‰“å–·å	dÇ pÄ“ntĂ¬	háº¯t xĂ¬ hÆ¡i, nháº£y mÅ©i	\N	40
631	å¤§è±¡	dĂ  xiĂ ng	voi, con voi	\N	34
632	ç­”æ¡ˆ	dĂ¡â€™Ă n	Ä‘Ă¡p Ă¡n	\N	33
634	æ‰“åŒ…	dÇbÄo	Ä‘Ă³ng gĂ³i, gĂ³i láº¡i	\N	34
635	æ‰“æ¯”æ–¹	dÇbÇfÄng	láº¥y vĂ­ dá»¥	\N	40
637	æ‰“è´¥	dÇbĂ i	Ä‘Ă¡nh báº¡i	\N	21
638	å¤§è‡£	dĂ chĂ©n	Ä‘áº¡i tháº§n	\N	30
639	è¾¾æˆ	dĂ¡chĂ©ng	Ä‘áº¡t Ä‘áº¿n, Ä‘áº¡t Ä‘Æ°á»£c	\N	34
640	æ­æ¡£	dÄdĂ ng	ngÆ°á»i há»£p tĂ¡c, cá»™ng tĂ¡c	\N	34
641	è¾¾åˆ°	dĂ¡dĂ o	Ä‘áº¿n, Ä‘áº¡t Ä‘Æ°á»£c	\N	34
642	å¤§æ–¹	dĂ fÄng	hĂ o phĂ³ng	\N	34
643	å¤§å¤«	dĂ ifu	bĂ¡c sÄ©	\N	24
644	å¤§æ¦‚	dĂ gĂ i	khoáº£ng	\N	34
645	æ‰“å·¥	dÇgÅng	lĂ m cĂ´ng, lĂ m thuĂª	\N	34
646	å¤§ä¼™å„¿	dĂ huÇ’r	má»i ngÆ°á»i	\N	34
647	å¸¦	dĂ i	Ä‘em, mang	\N	40
648	æˆ´	dĂ i	Ä‘eo, mang, Ä‘á»™i	\N	40
649	å‘†	dÄi	ngá»‘c, ngáº©n ngÆ¡	\N	34
651	é€®æ•	dĂ ibÇ”	báº¯t giá»¯	\N	40
653	è´·æ¬¾	dĂ ikuÇn	cho vay, vay	\N	40
656	å¾…é‡	dĂ iyĂ¹	Ä‘Ă£i ngá»™, Ä‘á»‘i xá»­, láº¡nh nháº¡t	\N	34
657	ä»£æ›¿	dĂ itĂ¬	thay tháº¿	\N	40
658	æ‰“å‡»	dÇjĂ­	gĂµ,Ä‘áº­p,Ä‘Ă¡nh	\N	34
659	æ‰“äº¤é“	dÇjiÄodĂ o	giao tiáº¿p, tiáº¿p xĂºc	\N	34
660	æ‰“é‡	dÇliĂ ng	quan sĂ¡t, nhĂ¬n Ä‘Ă¡nh giĂ¡	\N	40
661	æ‰“çŒ	dÇliĂ¨	sÄƒn báº¯n	\N	34
662	è›‹ç™½è´¨	dĂ nbĂ¡izhĂ¬	protein	\N	34
663	æ‹…ä¿	dÄnbÇo	Ä‘áº£m báº£o	\N	34
665	å•è°ƒ	dÄndiĂ o	Ä‘Æ¡n Ä‘iá»‡u	\N	34
666	å•ç‹¬	dÄndĂº	Ä‘Æ¡n Ä‘á»™c, má»™t mĂ¬nh	\N	34
667	å•ä½	dÄnwĂ¨i	bĂ i má»¥c, Ä‘Æ¡n vá»‹	\N	34
668	æ‹…ä»»	dÄnrĂ¨n	Ä‘áº£m nhiá»‡m	\N	34
669	å•å…ƒ	dÄnyuĂ¡n	bĂ i há»c, Ä‘Æ¡n nguyĂªn	\N	34
670	è¯è¾°	dĂ nchĂ©n	ngĂ y sinh nháº­t	\N	40
671	å…	dÇng	Ä‘áº£ng	\N	31
673	å½“	dÄng	lĂ m, Ä‘áº£m nhiá»‡m, khi	\N	40
675	æ¡£æ¡ˆ	dĂ ngâ€™Ă n	há»“ sÆ¡	\N	34
676	è›‹ç³•	dĂ ngÄo	bĂ¡nh ga-tĂ´	\N	34
677	å½“åœº	dÄngchÇng	táº¡i chá»—	\N	34
679	æ¡£æ¬¡	dĂ ngcĂ¬	Ä‘áº³ng cáº¥p, cáº¥p báº­c	\N	21
680	å½“ä»£	dÄngdĂ i	ngĂ y nay, Ä‘Æ°Æ¡ng Ä‘áº¡i	\N	34
681	å½“é¢	dÄngmiĂ n	trÆ°á»›c máº·t	\N	34
682	å½“å‰	dÄngqiĂ¡n	hiá»‡n táº¡i	\N	40
683	å½“ç„¶	dÄngrĂ¡n	Ä‘Æ°Æ¡ng nhiĂªn	\N	34
685	å½“äº‹äºº	dÄngshĂ¬rĂ©n	ngÆ°á»i cĂ³ liĂªn quan, Ä‘Æ°Æ¡ng sá»±	\N	34
686	å½“å¡ä¹‹æ€¥	dÄngwĂ¹zhÄ«jĂ­	viá»‡c kháº©n cáº¥p trÆ°á»›c máº¯t	\N	34
687	å½“å¿ƒ	dÄngxÄ«n	cáº©n tháº­n, coi chá»«ng	\N	34
694	æ·¡å¿˜	dĂ nwĂ ng	lĂ£ng quĂªn	\N	29
695	èƒ†å°é¬¼	dÇnxiÇoguÇ	káº» nhĂ¡t gan	\N	31
720	æ‰“æ‰«	dÇsÇo	quĂ©t, quĂ©t dá»n	\N	39
727	æ‰“å°	dÇyĂ¬n	in áº¥n	\N	39
732	æ‰“æ˜	dÇzhĂ©	chiáº¿t kháº¥u, giáº£m giĂ¡	\N	37
741	ç¯	dÄ“ng	Ä‘Ă¨n	\N	27
762	ç‚¹	diÇn	Ä‘iá»ƒm, giá»	\N	30
689	æ·¡å­£	dĂ njĂ¬	trĂ¡i mĂ¹a, mua áº¿ hĂ ng	\N	40
691	è¯ç”Ÿ	dĂ nshÄ“ng	ra Ä‘á»i, sinh ra	\N	40
692	ä½†æ˜¯	dĂ nshĂ¬	nhÆ°ng	\N	35
693	æ·¡æ°´	dĂ nshuÇ	nÆ°á»›c ngá»t	\N	34
696	æ‹…å¿ƒ	dÄnxÄ«n	lo láº¯ng	\N	34
697	å€’	dÇo	Ä‘á»•	\N	34
698	åˆ°	dĂ o	Ä‘áº¿n	\N	34
699	å²›	dÇo	Ä‘áº£o	\N	34
700	åˆ€	dÄo	Ä‘ao, dao	\N	34
701	å€’é—­	dÇobĂ¬	sáº­p tiá»‡m, Ä‘Ă³ng cá»­a	\N	34
702	åˆ°å¤„	dĂ ochĂ¹	kháº¯p nÆ¡i	\N	34
704	å¯¼å¼¹	dÇodĂ n	há»a tiá»…n, Ä‘áº¡n Ä‘áº¡o	\N	34
705	é“å¾·	dĂ odĂ©	Ä‘áº¡o Ä‘á»©c	\N	34
706	åˆ°åº•	dĂ odÇ	Ä‘áº¿n cĂ¹ng, rá»‘t cuá»™c, suy cho cĂ¹ng	\N	34
707	ç¨»è°·	dĂ ogÇ”	lĂºa	\N	40
708	å¯¼èˆª	dÇohĂ¡ng	dáº«n Ä‘Æ°á»ng, hÆ°á»›ng dáº«n	\N	34
709	é“ç†	dĂ olÇ	Ä‘áº¡o lĂ½	\N	34
710	æ£ä¹±	dÇoluĂ n	phĂ¡ Ä‘Ă¡m, quáº¥y rá»‘i	\N	34
711	å€’éœ‰	dÇomĂ©i	xui xáº»o	\N	34
713	ç›—çªƒ	dĂ oqiĂ¨	trá»™m	\N	34
714	å¯¼å‘	dÇoxiĂ ng	hÆ°á»›ng dáº«n	\N	34
715	å¯¼æ¼”	dÇoyÇn	Ä‘áº¡o diá»…n	\N	34
716	å¯¼æ¸¸	dÇoyĂ³u	hÆ°á»›ng dáº«n viĂªn du lá»‹ch	\N	34
717	å²›å±¿	dÇoyÇ”	quáº§n Ä‘áº£o	\N	27
718	å¯¼è‡´	dÇozhĂ¬	dáº«n Ä‘áº¿n	\N	34
719	æ‰“ç®—	dÇsuĂ n	nhá»‹n chung	\N	34
721	å¤§å¦	dĂ shĂ 	tĂ²a nhĂ 	\N	34
722	å¤§ä½¿é¦†	dĂ shÇguÇn	Ä‘áº¡i sá»© quĂ¡n	\N	40
724	å¤§ä½“	dĂ tÇ	thÄƒm dĂ², nghe ngĂ³ng	\N	34
725	å¤§å…´	dĂ xÄ«ng	quy mĂ´ lá»›n	\N	34
726	å¤§æ„	dĂ yĂ¬	khĂ´ng cáº©n tháº­n	\N	34
728	ç­”åº”	dÄying	Ä‘á»“ng Ă½, báº±ng lĂ²ng	\N	34
729	å¤§çº¦	dĂ yuÄ“	khoáº£ng, Æ°á»›c chá»«ng, cháº¯c lĂ 	\N	34
730	æ‰“ä»—	dÇzhĂ ng	Ä‘Ă¡nh nhau, Ä‘Ă¡nh tráº­n	\N	24
731	æ‰“æ‹›å‘¼	dÇzhÄohu	chĂ o há»i	\N	34
733	æ‰“é’ˆ	dÇzhÄ“n	tiĂªm	\N	40
734	å¤§è‡´	dĂ zhĂ¬	khoáº£ng	\N	34
735	åœ°	de	trá»£ tá»« káº¿t cáº¥u	\N	35
736	ç„	de	cá»§a	\N	35
737	å¾—	dĂ©	Ä‘Æ°á»£c, máº¯c (bá»‡nh)	\N	35
739	å¾—å›	dĂ©lĂ¬	Ä‘Æ°á»£c lá»£i	\N	35
740	çª	dĂ¨ng	nhĂ¬n cháº±m cháº±m	\N	34
742	ç­‰	dÄ›ng	chá», Ä‘á»£i	\N	34
743	ç™»	dÄ“ng	Ä‘áº¡p, giáº«m	\N	34
744	ç™»æœºç‰Œ	dÄ“ngjÄ«pĂ¡i	tháº» lĂªn mĂ¡y bay	\N	40
745	ç™»å½•	dÄ“nglĂ¹	Ä‘Äƒng nháº­p	\N	30
746	ç­‰å¾…	dÄ›ngdĂ i	Ä‘á»£i	\N	34
747	ç­‰å€™	dÄ›nghĂ²u	Ä‘á»£i	\N	34
748	ç­‰çº§	dÄ›ngjĂ­	cáº¥p báº­c, Ä‘áº³ng cáº¥p	\N	21
749	ç™»è®°	dÄ“ngjĂ¬	Ä‘Äƒng kĂ½	\N	31
750	ç¯ç¬¼	dÄ“nglĂ³ng	Ä‘Ă¨n lá»“ng	\N	34
751	ç™»é™†	dÄ“nglĂ¹	bá»™, lĂªn bá»	\N	40
752	ç­‰äº	dÄ›ngyĂº	báº±ng	\N	34
754	å¾—æ„	dĂ©yĂ¬	Ä‘áº¯c Ă½	\N	35
755	å¾—ç½ª	dĂ©zuĂ¬	Ä‘áº¯c tá»™i	\N	35
756	é€’	dĂ¬	truyá»n Ä‘áº¡t, chuyá»ƒn giao	\N	34
757	åº•	dÇ	Ä‘Ă¡y, Ä‘áº¿, cuá»‘i, ná»n	\N	34
758	ä½	dÄ«	tháº¥p	\N	34
759	æ»´	dÄ«	nhá» giá»t	\N	34
760	ç¬¬ä¸€	dĂ¬ yÄ«	thá»© nháº¥t	\N	21
761	å«	diĂ n	Ä‘á»‡m, cĂ¡i lĂ³t	\N	34
763	é¢ ç°¸	diÄnbÇ’	láº¯c lÆ°, trĂ²ng trĂ nh	\N	34
764	ç”µæ± 	diĂ nchĂ­	pin, áº¯c quy	\N	40
765	é¢ å€’	diÄndÇo	láº­t ngÆ°á»£c, Ä‘áº£o lá»™n	\N	34
767	æƒ¦è®°	diĂ njĂ¬	nghÄ© Ä‘áº¿n, nhá»› Ä‘áº¿n	\N	34
768	ç”µå›	diĂ nlĂ¬	nghá»‹ lá»±c	\N	40
769	ç”µè„‘	diĂ nnÇo	mĂ¡y vi tĂ­nh	\N	40
770	ç”µè§†	diĂ nshĂ¬	truyá»n hĂ¬nh, ti-vi	\N	40
771	ç”µå°	diĂ ntĂ¡i	tráº¡m phĂ¡t sĂ³ng	\N	34
772	ç”µæ¢¯	diĂ ntÄ«	thang mĂ¡y	\N	30
774	ç”µä¿¡	diĂ nxĂ¬n	trang miá»‡ng	\N	34
775	ç”µå½±	diĂ nyÇng	phim	\N	31
776	å…¸ç¤¼	diÇnlÇ	Ä‘iá»ƒn hĂ¬nh, nghi lá»…	\N	40
777	ç”µæº	diĂ nyuĂ¡n	nguá»“n Ä‘iá»‡n	\N	34
778	ç”µå­é‚®ä»¶	diĂ nzÇ yĂ³ujiĂ n	e-mail	\N	40
779	å	diĂ o	treo	\N	34
780	æ‰	diĂ o	rÆ¡i, máº¥t, giáº£m, háº¡	\N	34
781	é’“	diĂ o	cĂ¢u cĂ¡	\N	24
782	é›•	diÄo	ngáº¯m, tháº£	\N	34
784	è°ƒå¨	diĂ odĂ²ng	Ä‘iá»u Ä‘á»™ng, Ä‘á»•i, thay Ä‘á»•i	\N	34
785	é›•åˆ»	diÄokĂ¨	Ä‘iĂªu kháº¯c	\N	40
786	é›•å¡‘	diÄosĂ¹	Ä‘iĂªu kháº¯c	\N	40
787	è·Œå€’	diÄ“dÇo	ngĂ£, Ä‘á»•, tĂ©	\N	34
788	å 	diĂ©	gáº¥p, chá»“ng, xáº¿p	\N	34
789	åœ°æ­¥	dĂ¬bĂ¹	má»©c, bÆ°á»›c	\N	35
790	åœ°é“	dĂ¬dao	Ä‘á»‹a Ä‘áº¡o	\N	35
791	åœ°ç‚¹	dĂ¬diÇn	Ä‘á»‹a Ä‘iá»ƒm	\N	35
792	å¼Ÿå¼Ÿ	dĂ¬di	em trai	\N	40
793	è·Œ	diÄ“	ngĂ£, tĂ©, rÆ¡i	\N	34
1643	å¿Œè®³	jĂ¬huĂ¬	kiĂªng ká»µ	\N	40
814	å†¬	dÅng	mĂ¹a Ä‘Ă´ng, Ä‘Ă´ng	\N	30
877	é¡¿	dĂ¹n	tĂ¡n	\N	31
797	ç›¯	dÄ«ng	nhĂ¬n chÄƒm chÄƒm	\N	34
817	å¨ç”»ç‰‡	dĂ²nghuĂ  piĂ n	phim hoáº¡t hĂ¬nh	\N	31
825	å¨æ‰‹	dĂ²ngshÇ’u	báº¯t Ä‘áº§u lĂ m, báº¯t tay vĂ o lĂ m	\N	40
837	è¯»	dĂº	Ä‘á»c	\N	33
841	ç«¯åˆè‚	duÄnwÇ” jiĂ©	Táº¿t Äoan Ngá»	\N	36
855	å¯¹è¯	duĂ¬huĂ 	Ä‘á»‘i thoáº¡i	\N	33
874	å¯¹ç…§	duĂ¬zhĂ o	so sĂ¡nh, Ä‘á»‘i chiáº¿u	\N	22
876	ç‹¬ç«‹	dĂºlĂ¬	Ä‘á»™c láº­p	\N	33
882	èº²è—	duÇ’cĂ¡ng	trá»‘n trĂ¡nh, áº©n nĂ¡u	\N	24
798	å®æœŸ	dĂ¬ngqÄ«	theo ká»³ háº¡n, Ä‘á»‹nh ká»³	\N	34
799	å®ä¹‰	dĂ¬ngyĂ¬	Ä‘á»‹nh nghÄ©a	\N	40
800	å®å˜±	dÄ«ngzhÇ”	cÄƒn dáº·n, dáº·n dĂ²	\N	34
801	åœ°çƒ	dĂ¬qiĂº	trĂ¡i Ä‘áº¥t, Ä‘á»‹a cáº§u	\N	35
802	åœ°åŒº	dĂ¬qÅ«	vĂ¹ng	\N	35
804	æ•Œäºº	dĂ­rĂ©n	káº» thĂ¹	\N	30
805	æ•Œè§†	dĂ­shĂ¬	cÄƒm thĂ¹, coi nhÆ° káº» thĂ¹	\N	34
806	åœ°å¿	dĂ¬shĂ¬	Ä‘á»‹a tháº¿	\N	35
807	åœ°é“	dĂ¬tiÄ›	xe Ä‘iá»‡n ngáº§m	\N	35
808	åœ°å›¾	dĂ¬tĂº	báº£n Ä‘á»“	\N	35
809	åœ°ä½	dĂ¬wĂ¨i	Ä‘á»‹a vá»‹	\N	35
810	åœ°éœ‡	dĂ¬zhĂ¨n	Ä‘á»™ng Ä‘áº¥t	\N	35
811	åœ°è´¨	dĂ¬zhĂ¬	Ä‘á»‹a cháº¥t	\N	35
813	ä¸œ	dÅng	phĂ­a Ä‘Ă´ng	\N	34
815	å¨è¡	dĂ²ngdĂ ng	báº¥p bĂªnh, rá»‘i ren, há»—n loáº¡n	\N	34
816	ä¸œé“ä¸»	dÅngdĂ ozhÇ”	chá»§ nhĂ 	\N	30
818	å¨æœº	dĂ²ngjÄ«	Ä‘á»™ng cÆ¡	\N	34
819	å†»ç»“	dĂ²ngjiĂ©	Ä‘Ă³ng láº¡i	\N	34
820	å¨é™	dĂ²ngjĂ¬ng	Ä‘á»™ng tÄ©nh	\N	34
821	å¨å›	dĂ²nglĂ¬	Ä‘á»™ng lá»±c	\N	34
822	å¨è„‰	dĂ²ngmĂ i	Ä‘á»™ng máº¡ch	\N	34
823	å¨èº«	dĂ²ngshÄ“n	khá»Ÿi hĂ nh, lĂªn Ä‘Æ°á»ng	\N	34
826	å¨æ€	dĂ²ngtĂ i	Ä‘á»™ng thĂ¡i	\N	34
827	å¨ç‰©	dĂ²ngwĂ¹	Ä‘á»™ng váº­t	\N	34
828	ä¸œè¥¿	dÅngxi	Ä‘á»“	\N	34
829	æ´ç©´	dĂ²ngxuĂ©	hang Ä‘á»™ng	\N	34
830	å¨å‘˜	dĂ²ngyuĂ¡n	huy Ä‘á»™ng	\N	34
831	ä¸œå¼ è¥¿æœ›	dÅngzhÄngxÄ«wĂ ng	nhĂ¬n Ä‘Ă´ng nhĂ¬n tĂ¢y	\N	34
832	å¨ä½œ	dĂ²ngzuĂ²	Ä‘á»™ng tĂ¡c	\N	34
833	é€—	dĂ²u	chá»c tá»©c	\N	34
834	è±†è…	dĂ²ufu	Ä‘áº­u phá»¥	\N	24
835	é™¡å³­	dÇ’uqiĂ o	dá»‘c Ä‘á»©ng, dá»‘c ngÆ°á»£c	\N	34
836	æ–—äº‰	dĂ²uzhÄ“ng	Ä‘áº¥u tranh	\N	24
838	æ–­	duĂ n	Ä‘á»©t, Ä‘oáº¡n tuyá»‡t, cháº·t, cai	\N	40
839	æ®µ	duĂ n	Ä‘oáº¡n	\N	34
840	ç«¯	duÄn	Ä‘áº§u, Ä‘áº§u mĂºt	\N	24
842	æ–­å®	duĂ ndĂ¬ng	káº¿t luáº­n, nháº­n Ä‘á»‹nh	\N	40
844	çŸ­	duÇn	ngáº¯n	\N	34
845	çŸ­ä¿ƒ	duÇncĂ¹	ngáº¯n ngá»§i, vá»™i vĂ ng	\N	34
846	çŸ­æœŸ	duÇnqÄ«	ngáº¯n háº¡n	\N	34
847	çŸ­æ‚	duÇnzĂ n	ngáº¯n ngá»§i, thoĂ¡ng qua	\N	34
848	å †	duÄ«	tĂºi, tá»¥, chá»“ng cháº¥t, Ä‘Ă³ng	\N	34
849	å †ç§¯	duÄ«jÄ«	tĂ­ch tá»¥, cháº¥t Ä‘á»‘ng	\N	34
850	é˜Ÿ	duĂ¬	Ä‘á»™i	\N	34
851	å¯¹	duĂ¬	Ä‘Ăºng	\N	34
852	å¯¹æ¯”	duĂ¬bÇ	so sĂ¡nh	\N	34
853	å¯¹å¾…	duĂ¬dĂ i	Ä‘á»‘i xá»­, Ä‘á»‘i Ä‘Ă£i	\N	34
856	æ–­æ–­ç»­ç»­	duĂ nduĂ nxĂ¹xĂ¹	giĂ¡n Ä‘oáº¡n, khĂ´ng liĂªn tá»¥c	\N	34
857	é”»ç‚¼	duĂ nliĂ n	táº­p luyá»‡n, rĂ¨n luyá»‡n	\N	34
858	ç«¯ä¿¡	duÄnxĂ¬n	tin nháº¯n	\N	33
859	ç«¯æ­£	duÄnzhĂ¨ng	Ä‘oan chĂ­nh, Ä‘á»u Ä‘áº·n, ngay ngáº¯n	\N	34
860	èµŒå	dÇ”bĂ³	cá» báº¡c	\N	34
861	ç‹¬è£	dĂºcĂ¡i	Ä‘á»™c tĂ i	\N	34
862	ç£ä¿ƒ	dÅ«cĂ¹	thĂºc giá»¥c	\N	30
863	æ¸¡è¿‡	dĂ¹guĂ²	xuyĂªn qua, tráº£i qua	\N	40
865	å¯¹ä¸èµ·	duĂ¬buqÇ	xin lá»—i	\N	34
866	å¯¹ç­–	duĂ¬cĂ¨	biá»‡n phĂ¡p Ä‘á»‘i phĂ³	\N	34
867	å¯¹ç§°	duĂ¬chĂ¨n	tĂ­nh cĂ¢n xá»©ng	\N	34
868	å…‘æ¢	duĂ¬huĂ n	trao Ä‘á»•i	\N	40
870	å¯¹ç«‹	duĂ¬lĂ¬	Ä‘á»‘i láº­p	\N	34
871	å¯¹è”	duĂ¬liĂ¡n	Ä‘á»‘i liá»…n	\N	34
872	å¯¹åº”	duĂ¬yĂ¬ng	Ä‘á»‘i á»©ng	\N	34
873	å¯¹äº	duĂ¬yĂº	vá», Ä‘á»‘i vá»›i	\N	40
875	ç‹¬ç»	dĂºjuĂ©	tiĂªu Ä‘á»™c, ngÄƒn cháº·n	\N	34
878	ç›¹	dÇ”n	ngá»“i xá»“m	\N	40
880	æœµ	duÇ’	bĂ´ng	\N	34
881	å¤	duÅ	nhiá»u	\N	40
883	å¤äº	duÅkuÄ«	may máº¯n, may mĂ 	\N	21
884	å •è½	duĂ²luĂ²	sa ngĂ£, trá»¥y láº¡c	\N	21
885	å¤ä¹ˆ	duÅme	bao nhiĂªu, biáº¿t bao	\N	21
886	å“†å—¦	duÅsuo	láº¡nh cĂ³ng, run cáº§m cáº­p	\N	34
887	å¤ä½™	duÅyĂº	dÆ°, dÆ° thá»«a	\N	30
888	å¤å…ƒåŒ–	duÅyuĂ¡n huĂ 	Ä‘a dáº¡ng hĂ³a	\N	34
889	æ¯’å“	dĂºpÇn	thuá»‘c phiá»‡n	\N	34
890	é˜»å¡	dÅ«sĂ¨	táº¯c ngháº½n, ngÄƒn cháº·n	\N	34
891	éƒ½å¸‚	dÅ«shĂ¬	Ä‘Ă´ thá»‹	\N	34
893	è‚å­	dĂ¹zi	bá»¥ng	\N	34
894	é¥¿	Ă¨	Ä‘Ă³i	\N	34
895	è®¹	Ă©	chuyá»ƒn biáº¿n xáº¥u, thay Ä‘á»•i xáº¥u Ä‘i	\N	34
897	æ¶	Ă¨	á»«, há»«	\N	21
898	æ€¨æ¨	yuĂ nhĂ¨n	oĂ¡n háº­n	\N	34
899	è€Œ	Ă©r	vĂ , mĂ , nhÆ°ng	\N	35
901	å„¿ç«¥	Ă©rtĂ³ng	nhi Ä‘á»“ng	\N	34
3571	å²©çŸ³	yĂ¡nshĂ­	Ä‘Ă¡	\N	21
908	å‘è¡¨	fÄbiÇo	phĂ¡t biá»ƒu, tuyĂªn bá»‘	\N	40
912	å‘è¾¾	fÄdĂ¡	phĂ¡t triá»ƒn, phá»“n vinh	\N	34
925	åå¤	fÇnfĂ¹	láº·p Ä‘i láº·p láº¡i	\N	33
922	ç¿»	fÄn	xoay, láº­t, trá»Ÿ mĂ¬nh	\N	40
935	åé—®	fÇnwĂ¨n	há»i láº¡i	\N	33
910	å‘è´¢	fÄcĂ¡i	phĂ¡t tĂ i, lĂ m giĂ u	\N	40
927	åé¢	fÇnmiĂ n	pháº£n diá»‡n, máº·t trĂ¡i	\N	40
954	é¥­é¦†	fĂ nguÇn	quĂ¡n cÆ¡m	\N	26
956	è®¿é—®	fÇnwĂ¨n	há»i láº¡i, há»“i váº¥n láº¡i	\N	33
980	æ³•	fÇ	thá»ƒ	\N	37
902	äºŒæ°§åŒ–ç¢³	Ă¨ryÇnghuĂ tĂ n	COâ‚‚	\N	34
903	è€Œå·²	Ă©ryÇ	mĂ  thĂ´i, tháº¿ thĂ´i	\N	35
904	å„¿å­	Ă©rzi	con trai	\N	34
905	é¢å¤–	Ă©wĂ i	ngoĂ i Ä‘á»‹nh má»©c	\N	34
907	å‘	fÄ	phĂ¡t, gá»­i	\N	40
916	å‘æŒ¥	fÄhuÄ«	phĂ¡t huy	\N	30
909	å‘å¸ƒ	fÄbĂ¹	tuyĂªn bá»‘, phĂ¡t hĂ nh, thĂ´ng bĂ¡o	\N	34
911	å‘æ„	fÄchĂ³u	lo láº¯ng, buá»“n phiá»n	\N	34
913	å‘å‘†	fÄdÄi	ngáº©n ngÆ°á»i	\N	34
914	å‘å¨	fÄdĂ²ng	phĂ¡t Ä‘á»™ng, báº¯t Ä‘áº§u	\N	34
915	å‘æ–	fÄdÇ’u	run ráº©y	\N	40
918	å‘è§‰	fÄjuĂ©	phĂ¡t hiá»‡n, phĂ¡t giĂ¡c	\N	40
919	å‘æ¬¾	fÄkuÇn	phĂ¡t tiá»n	\N	40
920	æ³•å¾‹	fÇlÇœ	phĂ¡p luáº­t	\N	40
921	å‘æ˜	fÄmĂ­ng	phĂ¡t minh	\N	40
924	åå¸¸	fÇnchĂ¡ng	dá»‹ thÆ°á»ng	\N	34
926	åæ—	fÇnkĂ ng	pháº£n khĂ¡ng	\N	30
928	ååº”	fÇnyĂ¬ng	pháº£n á»©ng	\N	34
929	åæ˜ 	fÇnyĂ¬ng	pháº£n Ă¡nh	\N	30
930	åå¯¹	fÇnduĂ¬	pháº£n Ä‘á»‘i	\N	34
931	åè½¬	fÇnzhuÇn	trĂ¡i láº¡i, ngÆ°á»£c láº¡i	\N	34
932	åæ€	fÇnsÄ«	suy ngáº«m, pháº£n tá»‰nh	\N	34
933	åå°„	fÇnshĂ¨	pháº£n xáº¡	\N	30
934	åé¦ˆ	fÇnkuĂ¬	pháº£n há»“i	\N	34
936	æ”¾	fĂ ng	tha, tháº£	\N	30
938	æ”¾æ‘å‡	fĂ ng shÇ”jiĂ 	nghá»‰ hĂ¨	\N	40
939	å¦¨ç¢	fĂ¡ng'Ă i	gĂ¢y trá»Ÿ ngáº¡i	\N	34
940	åæ„Ÿ	fÇngÇn	Ă¡c cáº£m, báº¥t mĂ£n	\N	34
941	æ–¹æ¡ˆ	fÄngâ€™Ă n	káº¿ hoáº¡ch, phÆ°Æ¡ng Ă¡n	\N	34
943	æˆ¿ä¸œ	fĂ¡ngdÅng	chá»§ nhĂ 	\N	30
944	æ–¹æ³•	fÄngfÇ	phÆ°Æ¡ng phĂ¡p	\N	34
945	ä»¿ä½›	fÇngfĂº	hĂ¬nh nhÆ°, dÆ°á»ng nhÆ°	\N	34
946	æˆ¿é—´	fĂ¡ngjiÄn	phĂ²ng	\N	34
947	æ–¹é¢	fÄngmiĂ n	phÆ°Æ¡ng diá»‡n, máº·t, phĂ­a	\N	34
948	æ”¾å¼ƒ	fĂ ngqĂ¬	vá»©t bá», tá»« bá»	\N	34
949	æ”¾å°„	fĂ ngshĂ¨	phĂ³ng xáº¡	\N	34
950	æ–¹å¼	fÄngshĂ¬	phÆ°Æ¡ng thá»©c, cĂ¡ch thá»©c	\N	34
951	é˜²å®ˆ	fĂ¡ngshÇ’u	phĂ²ng thá»§	\N	34
952	æ”¾æ‰‹	fĂ ngshÇ’u	buĂ´ng tay	\N	34
953	æ”¾æ¾	fĂ ngsÅng	tháº£ lá»ng, thÆ° giĂ£n	\N	34
955	æ–¹å‘	fÄngxiĂ ng	phÆ°Æ¡ng hÆ°á»›ng	\N	34
958	æ–¹è¨€	fÄngyĂ¡n	tiáº¿ng Ä‘á»‹a phÆ°Æ¡ng	\N	34
959	é˜²ç–«	fĂ¡ngyĂ¬	phĂ²ng dá»‹ch	\N	34
960	æˆ¿å±‹	fĂ¡ngwÅ«	phĂ²ng á»Ÿ	\N	34
961	æ–¹é’ˆ	fÄngzhÄ“n	phÆ°Æ¡ng chĂ¢m	\N	34
962	é˜²æ²»	fĂ¡ngzhĂ¬	phĂ²ng chá»‘ng, phĂ²ng vĂ  chá»¯a trá»‹	\N	34
963	çººç»‡	fÇngzhÄ«	dá»‡t váº£i	\N	34
964	ç¹å	fĂ¡nhuĂ¡	phá»“n hoa, sáº§m uáº¥t	\N	34
965	æ³›æ»¥	fĂ nlĂ n	trĂ n lan	\N	21
966	è´©å–	fĂ nmĂ i	buĂ´n bĂ¡n	\N	34
967	ç¹å¿™	fĂ¡nmĂ¡ng	báº­n rá»™n	\N	34
969	ç¹è£	fĂ¡nrĂ³ng	phá»“n vinh	\N	34
970	å‡¡æ˜¯	fĂ¡nshĂ¬	phĂ m lĂ , há»… lĂ 	\N	34
971	ç¹ä½“å­—	fĂ¡ntÇzĂ¬	chá»¯ phá»“n thá»ƒ	\N	34
972	èŒƒå›´	fĂ nwĂ©i	pháº¡m vi	\N	34
973	ç¿»è¯‘	fÄnyĂ¬	phiĂªn dá»‹ch, dá»‹ch	\N	40
974	åæ­£	fÇnzhĂ¨ng	dĂ¹ sao cÅ©ng	\N	34
975	åä¹‹	fÇnzhÄ«	trĂ¡i láº¡i, ngÆ°á»£c láº¡i	\N	34
976	å‘ç¥¨	fÄpiĂ o	hĂ³a Ä‘Æ¡n	\N	34
977	æ³•äºº	fÇrĂ©n	phĂ¡p nhĂ¢n	\N	21
978	å‘çƒ§	fÄshÄo	phĂ¡t sá»‘t, sá»‘t	\N	34
979	å‘ç”Ÿ	fÄshÄ“ng	xáº£y ra	\N	40
982	å‘æ‰¬	fÄyĂ¡ng	nĂªu cao, phĂ¡t huy	\N	34
983	å‘è‚²	fÄyĂ¹	trÆ°á»Ÿng thĂ nh, dáº­y thĂ¬	\N	40
984	æ³•é™¢	fÇyuĂ n	tĂ²a Ă¡n	\N	34
985	å‘è¡Œ	fÄxĂ­ng	phĂ¡t hĂ nh	\N	31
986	å‘ç°	fÄxiĂ n	phĂ¡t hiá»‡n	\N	40
987	å‘ç–¯	fÄfÄ“ng	phĂ¡t Ä‘iĂªn	\N	40
988	å‘å±•	fÄzhÇn	phĂ¡t triá»ƒn	\N	40
989	è‚º	fĂ¨i	phá»•i	\N	34
990	é	fÄ“i	khĂ´ng, phi	\N	34
992	éå¸¸	fÄ“ichĂ¡ng	ráº¥t, Ä‘áº·c biá»‡t	\N	40
993	åºŸé™¤	fĂ¨ichĂº	bĂ£i bá», huá»· bá»	\N	40
994	éæ³•	fÄ“ifÇ	báº¥t há»£p phĂ¡p, phi phĂ¡p	\N	34
995	è´¹ç”¨	fĂ¨iyĂ²ng	chi phĂ­	\N	40
996	é£æœº	fÄ“ijÄ«	mĂ¡y bay	\N	21
998	æ²¸è…¾	fĂ¨itĂ©ng	sĂ´i sĂ¹ng sá»¥c	\N	34
999	åŒªå¾’	fÄ›itĂº	káº» cÆ°á»›p, Ä‘áº¡o táº·c	\N	34
1000	è‚¥æ²ƒ	fĂ©iwĂ²	phĂ¬ nhiĂªu, mĂ u má»¡	\N	40
1001	é£ç¿”	fÄ“ixiĂ¡ng	bay lÆ°á»£n	\N	40
1002	åºŸå¢Ÿ	fĂ¨ixÅ«	Ä‘á»‘ng hoang, Ä‘á»‘ng Ä‘á»• nĂ¡t	\N	34
1003	é£è·ƒ	fÄ“iyuĂ¨	nháº£y vá»t, vÆ°á»£t báº­c	\N	40
1004	è‚¥ç‚	fĂ©izĂ o	xĂ  bĂ´ng	\N	34
1007	åˆ†å¸ƒ	fÄ“nbĂ¹	phĂ¢n bá»‘, phĂ¢n phĂ¡t	\N	30
1018	é£æ´	fÄ“ngbĂ o	bĂ£o tá»‘	\N	30
1048	æ æ†	gĂ nggÇn	Ä‘Ă²n báº©y	\N	21
1083	é«˜è€ƒ	gÄokÇo	thĂ­ vĂ o trÆ°á»ng Ä‘áº¡i há»c	\N	40
1021	ä¸°æ”¶	fÄ“ngshÅu	Ä‘Æ°á»£c mĂ¹a	\N	30
1030	åˆ†é…	fÄ“npĂ¨i	phĂ¢n phá»‘i	\N	30
1032	ç²‰ç¢	fÄ›nsuĂ¬	vá»¡ nĂ¡t, vá»¡ tan tĂ nh	\N	22
1035	æ„¤æ…¨	fĂ¨nkÇi	báº¥t bĂ¬nh, pháº«n ná»™, ná»•i cĂ¡u	\N	24
1038	åˆ†æ˜	fÄ“nmĂ­ng	rĂµ rĂ ng, phĂ¢n minh	\N	30
1011	æ„¤æ€’	fĂ¨nnĂ¹	cÄƒm pháº«n, tá»©c giáº­n	\N	27
1046	å°´å°¬	gÄngĂ 	khĂ³ xá»­, lĂºng tĂºng	\N	34
1008	åˆ†å¯¸	fÄ“ncĂ¹n	chá»«ng má»±c, cĂ³ chá»«ng má»±c	\N	34
1009	åˆ†æ‹…	fÄ“ndÄn	phĂ¢n Ä‘áº§u	\N	30
1010	å¥‹æ–—	fĂ¨ndĂ²u	cá»‘ gáº¯ng, dá»“n dáº­p	\N	34
1090	ä¸ª	gĂ¨	cĂ¡i	\N	25
1013	ä¸°å¯Œ	fÄ“ngfĂ¹	phong phĂº	\N	34
1014	é£æ™¯	fÄ“ngjÇng	phong cáº£nh	\N	34
1015	é£åº¦	fÄ“ngdĂ¹	phong Ä‘á»™, phong cĂ¡ch	\N	34
1016	é£å…‰	fÄ“ngguÄng	phong cáº£nh	\N	34
1017	å°å»º	fÄ“ngjiĂ n	phong kiáº¿n	\N	34
1092	å‰²	gÄ“	cáº¯t, gáº·t	\N	28
1019	é£ä¿—	fÄ“ngsĂº	phong tá»¥c	\N	34
1020	ç–¯ç‹‚	fÄ“ngkuĂ¡ng	Ä‘iĂªn cuá»“ng	\N	34
1097	ç–™ç˜©	gÄ“da	má»¥n, má»¥n cĂ¡m	\N	27
1023	é£æ°”	fÄ“ngqĂ¬	báº§u khĂ´ng khĂ­, náº¿p sá»‘ng	\N	34
1024	é£è¶£	fÄ“ngqĂ¹	thĂº vá»‹, dĂ­ dá»m	\N	30
1025	å°é”	fÄ“ngsuÇ’	phong toáº£, bao vĂ¢y, cháº·n	\N	34
1026	é£åœŸäººæƒ…	fÄ“ngtÇ” rĂ©nqĂ­ng	phong thá»•	\N	34
1027	é£å‘³	fÄ“ngwĂ¨i	hÆ°Æ¡ng vá»‹	\N	34
1028	å¥‰çŒ®	fĂ¨ngxiĂ n	hiáº¿n dĂ¢ng	\N	40
1029	é£é™©	fÄ“ngxiÇn	rá»§i ro	\N	34
1099	æ­Œ	gÄ“	bĂ i hĂ¡t	\N	31
1031	åˆ†æ­§	fÄ“nqĂ­	khĂ¡c biá»‡t, mĂ¢u thuáº«n, báº¥t Ä‘á»“ng	\N	34
1100	é©å‘½	gĂ©mĂ¬ng	cĂ¡ch máº¡ng	\N	31
1033	ç²‰æœ«	fÄ›nmĂ²	bá»¥i, bá»™t	\N	40
1034	ç²‰ç¬”	fÄ›nbÇ	pháº¥n viáº¿t	\N	40
1101	æ ¹	gÄ“n	nguá»“n gá»‘c, rá»… cĂ¢y	\N	25
1036	åˆ†è£‚	fÄ“nliĂ¨	phĂ¢n tĂ¡ch	\N	30
1039	åˆ†æ‰‹	fÄ“nshÇ’u	chia tay, ly biá»‡t	\N	40
1040	çº·çº·	fÄ“nfÄ“n	táº¥p náº­p, dá»“n dáº­p	\N	34
1041	æ•¢	gÇn	dĂ¡m	\N	34
1042	å¹²æ´»å„¿	gĂ n huĂ³ er	lĂ m viá»‡c, lao Ä‘á»™ng	\N	34
1043	å¹²æ¯	gÄnbÄ“i	cáº¡n ly	\N	31
1044	å¹²è„†	gÄncuĂ¬	dá»©t khoĂ¡t, tháº³ng tháº¯n, thĂ nh tháº­t	\N	34
1045	æ„Ÿå¨	gÇndĂ²ng	cáº£m Ä‘á»™ng	\N	34
1047	åˆ	gÄng	vá»«a, vá»«a má»›i	\N	40
1049	åˆåˆ	gÄnggÄng	vá»«a má»›i	\N	40
1050	åˆå¼º	gÄngqiĂ¡ng	cÆ°Æ¡ng linh, chĂ­nh cÆ°Æ¡ng	\N	34
1051	æ¸¯å£	gÇngkÇ’u	háº£i cáº£ng	\N	21
1052	çº²é¢†	gÄnglÇng	cÆ°Æ¡ng lÄ©nh, chĂ­nh cÆ°Æ¡ng	\N	34
1053	é’¢é“	gÄngtiÄ›	sáº¯t thĂ©p	\N	34
1054	å²—	gÇng	cáº£ng, báº¿n cáº£ng	\N	34
1056	å¹²æ—±	gÄnhĂ n	khĂ´	\N	34
1057	æ„Ÿæ¿€	gÇnjÄ«	cáº£m kĂ­ch, biáº¿t Æ¡n	\N	34
1058	èµ¶ç´§	gÇnjÇn	vá»™i vĂ ng	\N	34
1059	å¹²å²	gĂ njĂ¬n	lĂ²ng hÄƒng hĂ¡i, tinh tháº§n hÄƒng hĂ¡i	\N	34
1060	å¹²å‡€	gÄnjĂ¬ng	sáº¡ch sáº½	\N	34
1061	æ„Ÿè§‰	gÇnjuĂ©	cáº£m tháº¥y, tháº¥y	\N	34
1062	æ„Ÿæ…¨	gÇnkÇi	xĂºc Ä‘á»™ng	\N	34
1063	èµ¶å¿«	gÇnkuĂ i	nhanh, mau lĂªn	\N	40
1064	æ„Ÿå†’	gÇnmĂ o	bá»‹ cáº£m	\N	34
1065	æ„Ÿæƒ…	gÇnqĂ­ng	tĂ¬nh cáº£m	\N	34
1066	æ„ŸæŸ“	gÇnrÇn	lĂ¢y, bá»‹ nhiá»…m	\N	40
1067	å¹²æ‰°	gÄnrÇo	can thiá»‡p	\N	34
1069	æ„Ÿå—	gÇnshĂ²u	cáº£m nháº­n	\N	40
1070	æ„Ÿæƒ³	gÇnxiÇng	cáº£m tÆ°á»Ÿng	\N	34
1071	æ„Ÿè°¢	gÇnxiĂ¨	cáº£m táº¡, bĂ y tá» lĂ²ng cáº£m Æ¡n	\N	34
1072	å¹²é¢„	gÄnyĂ¹	tham dá»±, tham gia, can dá»±	\N	40
1073	æ	gÇo	lĂ m	\N	40
1074	é«˜	gÄo	cao	\N	34
1075	å‘åˆ«	gĂ obiĂ©	tá»« biá»‡t	\N	40
1076	é«˜æ½®	gÄochĂ¡o	cao trĂ o, Ä‘á»‰nh Ä‘iá»ƒm	\N	34
1078	é«˜çº§	gÄojĂ­	cao cáº¥p	\N	34
1079	é«˜æ¡£	gÄodĂ ng	cao cáº¥p	\N	34
1080	é«˜å³°	gÄofÄ“ng	Ä‘á»‰nh cao	\N	34
1081	ç¨¿ä»¶	gÇojiĂ n	bĂ i viáº¿t, bĂ i vá»Ÿ	\N	34
1082	å‘è¯«	gĂ ojiĂ¨	khuyĂªn báº£o, khuyĂªn rÄƒn	\N	34
1084	é«˜æ˜	gÄomĂ­ng	thĂ´ng minh	\N	34
1085	é«˜å°	gÄoshĂ ng	cao cáº£, cao thÆ°á»£ng	\N	34
1086	å‘è¯‰	gĂ osĂ¹	bĂ¡o, ká»ƒ	\N	34
1088	é«˜å…´	gÄoxĂ¬ng	vui váº», vui má»«ng	\N	34
1089	é«˜æ¶¨	gÄozhÇng	dĂ¢ng cao, tÄƒng vá»t	\N	34
1091	å„	gĂ¨	cĂ¡c, má»—i, táº¥t cáº£	\N	40
1093	æ	gÄ“	Ä‘áº·t, Ä‘á»ƒ, kĂª	\N	40
1094	é”å£	gĂ©bĂ¬	nhĂ  bĂªn cáº¡nh	\N	34
1095	ä¸ªåˆ«	gĂ¨biĂ©	riĂªng biá»‡t, cĂ¡ biá»‡t	\N	40
1096	èƒ³è†	gÄ“bo	cĂ¡nh tay	\N	34
1103	è·Ÿ	gÄ“n	theo	\N	34
1104	æ ¹æœ¬	gÄ“nbÄ›n	cÄƒn báº£n	\N	34
1105	å·¥ç¨‹	gÅngchĂ©ng	cĂ´ng trĂ¬nh	\N	34
1106	å·¥ç¨‹å¸ˆ	gÅngchĂ©ngshÄ«	ká»¹ sÆ°	\N	23
1107	æ›´	gĂ¨ng	hÆ¡n ná»¯a, cĂ ng, thĂªm	\N	34
1108	è€•åœ°	gÄ“ngdĂ¬	cĂ y ruá»™ng, cĂ y bá»«a	\N	35
1181	ç®¡ç†	guÇnlÇ	quáº£n lĂ­	\N	38
1112	è·Ÿå‰	gÄ“nqiĂ¡n	cáº¡nh, gáº§n, bĂªn cáº¡nh	\N	28
1113	æ ¹æ·±è’‚å›º	gÄ“nshÄ“ndĂ¬gĂ¹	Äƒn sĂ¢u bĂ©n rá»…	\N	24
1122	ä¸ªæ€§	gĂ¨xĂ¬ng	tĂ­nh cĂ¡ch, cĂ¡ tĂ­nh	\N	25
1124	é¸½å­	gÄ“zi	chim bá»“ cĂ¢u	\N	24
1173	è§‚ç‚¹	guÄndiÇn	chĂ­nh thá»©c	\N	30
1193	å…‰å½©	guÄngcÇi	hĂ o quang, mĂ u sáº¯c Ă¡nh sĂ¡ng	\N	24
1111	æ ¹æ®ä¿¡	gÄ“njĂ¹	cÄƒn cá»©	\N	33
1202	å…‰è’	guÄngmĂ¡ng	tia sĂ¡ng, hĂ o quang	\N	27
1206	è§‚å…‰	guÄnguÄng	tham quan	\N	27
1114	æ ¹æº	gÄ“nyuĂ¡n	cÄƒn nguyĂªn, nguá»“n gá»‘c	\N	34
1115	è·Ÿè¸ª	gÄ“nzÅng	theo dĂµi, bĂ¡m theo	\N	34
1116	ä¸ªäºº	gĂ¨rĂ©n	cĂ¡ nhĂ¢n	\N	21
1117	æ ¼å¼	gĂ©shĂ¬	cĂ¡ch thá»©c, quy cĂ¡ch	\N	30
1119	æ­Œé¢‚	gÄ“sĂ²ng	khen ngá»£i	\N	34
1120	ä¸ªä½“	gĂ¨tÇ	cĂ¡ thá»ƒ, cĂ¡ nhĂ¢n, Ä‘Æ¡n láº»	\N	34
1121	æ ¼å¤–	gĂ©wĂ i	Ä‘áº·c biá»‡t	\N	34
1209	å…³å¿ƒ	guÄnxÄ«n	quan tĂ¢m	\N	27
1123	ä¸ªå­	gĂ¨zi	dĂ¡ng vĂ³c	\N	34
1183	å…³æ€€	guÄnhuĂ¡i	chÄƒm sĂ³c	\N	34
1125	ä¾›ä¸åº”æ±‚	gÅng bĂ¹ yĂ¬ng qiĂº	cung khĂ´ng Ä‘Ă¡p á»©ng Ä‘Æ°á»£c cáº§u	\N	34
1126	å…¬å®‰å±€	gÅng'Än jĂº	cá»¥c cĂ´ng an	\N	34
1127	å…¬å¸ƒ	gÅngbĂ¹	thĂ´ng bĂ¡o, cĂ´ng bá»‘	\N	34
1128	å·¥å‚	gÅngchÇng	nhĂ  mĂ¡y	\N	23
1129	å…¬é“	gÅngdĂ o	cĂ´ng lĂ½, láº½ pháº£i	\N	34
1130	ä¾›ç”µ	gÅngdiĂ n	cung Ä‘iá»‡n	\N	34
1131	åŸå¤«	gÅngfu	cĂ´ng sá»©c, báº£n lÄ©nh, thá»i gian	\N	34
1133	å…¬å‘	gÅnggĂ o	thĂ´ng bĂ¡o, thĂ´ng cĂ¡o	\N	34
1134	å…¬å…±æ±½è½¦	gÅnggĂ²ng qĂ¬chÄ“	xe buĂ½t	\N	28
1136	å…±å’Œå›½	gĂ²nghĂ©guĂ³	nÆ°á»›c cá»™ng hĂ²a	\N	35
1137	æ”»å‡»	gÅngjÄ«	táº¥n cĂ´ng, tiáº¿n Ä‘Ă¡nh	\N	34
1138	ä¾›ç»™	gÅngjÇ	cung cáº¥p	\N	34
1139	æ­æ•¬	gÅngjĂ¬ng	tĂ´n kĂ­nh	\N	34
1140	å·¥å…·	gÅngjĂ¹	cĂ´ng cá»¥	\N	34
1141	å…¬å¼€	gÅngkÄi	cĂ´ng khai	\N	34
1142	åŸè¯¾	gÅngkĂ¨	bĂ i táº­p vá» nhĂ 	\N	40
1143	æ”»å…‹	gÅngkĂ¨	táº¥n cĂ´ng, Ä‘Ă¡nh chiáº¿m	\N	34
1144	åŸå³	gÅnglĂ¡o	cĂ´ng lao, cĂ´ng tráº¡ng	\N	34
1145	å…¬é‡Œ	gÅnglÇ	km	\N	21
1146	å…¬æ°‘	gÅngmĂ­n	cĂ´ng dĂ¢n	\N	34
1148	å…¬å¹³	gÅngpĂ­ng	cĂ´ng báº±ng	\N	34
1149	å…¬å©†	gÅngpĂ³	cha máº¹ chá»“ng	\N	34
1150	å…¬ç„¶	gÅngrĂ¡n	ngang nhiĂªn, tháº³ng tháº¯n	\N	34
1151	å·¥äºº	gÅngrĂ©n	cĂ´ng nhĂ¢n	\N	34
1152	å…¬è®¤	gÅngrĂ¨n	cĂ´ng nháº­n	\N	34
1153	å…¬å¸	gÅngsÄ«	cĂ´ng ty	\N	34
1154	å…¬è¯‰	gÅngsĂ¹	cĂ´ng tá»‘	\N	34
1155	å…¬å¡	gÅngwĂ¹	cĂ´ng vá»¥, viá»‡c nÆ°á»›c, viá»‡c cĂ´ng	\N	34
1156	åŸæ•ˆ	gÅngxiĂ o	cĂ´ng hiá»‡u, cĂ´ng nÄƒng	\N	34
1157	åŸå‹‹	gÅngxÅ«n	cĂ´ng hiáº¿n	\N	34
1159	å·¥ä¸	gÅngyĂ¨	cĂ´ng nghiá»‡p	\N	34
1160	å·¥è‰ºå“	gÅngyĂ¬pÇn	Ä‘á»“ thá»§ cĂ´ng	\N	34
1161	å…¬å¯“	gÅngyĂ¹	chung cÆ°	\N	34
1162	å…¬å…ƒ	gÅngyuĂ¡n	cĂ´ng nguyĂªn	\N	34
1163	å…¬å›­	gÅngyuĂ¡n	cĂ´ng viĂªn	\N	34
1164	å…¬æ­£	gÅngzhĂ¨ng	cĂ´ng chĂ­nh, cĂ´ng báº±ng, chĂ­nh trá»±c	\N	34
1165	å…¬è¯	gÅngzhĂ¨ng	cĂ´ng chá»©ng	\N	34
1166	å…¬ä¸»	gÅngzhÇ”	cĂ´ng chĂºa	\N	34
1167	å·¥èµ„	gÅngzÄ«	lÆ°Æ¡ng	\N	34
1168	å·¥ä½œ	gÅngzuĂ²	lĂ m viá»‡c	\N	40
1169	å¤Ÿ	gĂ²u	Ä‘á»§	\N	21
1170	ç‹—	gÇ’u	chĂ³	\N	34
1171	æ„æˆ	gĂ²uchĂ©ng	hĂ¬nh thĂ nh, cáº¥u thĂ nh	\N	24
1174	æ²Ÿé€	gÅutÅng	khai thĂ´ng, ná»‘i liá»n	\N	34
1175	è´­ç‰©	gĂ²uwĂ¹	mua sáº¯m	\N	40
1176	å¤Ÿäº†	gĂ²ule	Ä‘á»§ rá»“i	\N	35
1177	æŒ‚	guĂ 	treo, mĂ³c	\N	34
1178	ä¹–	guÄi	ngoan	\N	34
1179	æŒ‚å·	guĂ hĂ o	Ä‘Äƒng kĂ½, láº¥y sá»‘	\N	34
1180	æ‹	guÇi	ráº½, ngoáº·t	\N	34
1182	è§‚å¯Ÿ	guÄnchĂ¡	quan sĂ¡t, xem xĂ©t	\N	40
1185	å† å†›	guĂ njÅ«n	quĂ¡n quĂ¢n, chá»©c vĂ´ Ä‘á»‹ch	\N	34
1186	ç½å¤´	guĂ ntĂ³u	Ä‘á»“ há»™p	\N	34
1187	ç®¡	guÇn	á»‘ng	\N	34
1188	è´¯å½»	guĂ nchĂ¨	quĂ¡n triá»‡t, thĂ´ng suá»‘t	\N	34
1189	é€›	guĂ ng	Ä‘i dáº¡o	\N	34
1190	å…‰	guÄng	Ă¡nh sĂ¡ng, nháºµn, sáº¡ch trÆ¡n, chá»‰	\N	34
1191	çŒæº‰	guĂ ngĂ i	tÆ°á»›i, dáº«n nÆ°á»›c tÆ°á»›i ruá»™ng	\N	34
1192	å¹¿æ’­	guÇngbĂ²	phĂ¡t thanh, truyá»n hĂ¬nh	\N	40
1194	å¹¿åœº	guÇngchÇng	quáº£ng trÆ°á»ng	\N	34
1195	å¹¿å¤§	guÇngdĂ 	rá»™ng lá»›n	\N	34
1196	å¹¿æ³›	guÇngfĂ n	rá»™ng rĂ£i	\N	34
1197	å¹¿å‘	guÇnggĂ o	quáº£ng cĂ¡o	\N	34
1201	å…‰ä¸´	guÄnglĂ­n	sá»± hiá»‡n diá»‡n, ghĂ© thÄƒm	\N	34
1203	å…‰æ˜	guÄngmĂ­ng	Ă¡nh sĂ¡ng	\N	31
1204	å…‰ç›˜	guÄngpĂ¡n	CD	\N	21
1205	å…‰è£	guÄngrĂ³ng	quang vinh	\N	40
1207	è§‚å¿µ	guÄnniĂ n	quan niá»‡m	\N	40
1208	å…³ç³»	guÄnxĂ¬	quan há»‡, liĂªn quan	\N	40
1210	å…³äº	guÄnyĂº	vá»	\N	40
1211	è§‚ä¼—	guÄnzhĂ²ng	khĂ¡n giáº£, quáº§n chĂºng	\N	40
1255	æœæ–­	guÇ’duĂ n	quáº£ quyáº¿t, quáº£ Ä‘oĂ¡n	\N	34
1231	è§„æ ¼	guÄ«gĂ©	quy cĂ¡ch, kiá»ƒu máº«u	\N	24
1232	å½’æ ¹åˆ°åº•	guÄ«gÄ“ndĂ odÇ	xĂ©t Ä‘áº¿n cĂ¹ng, suy nghÄ© cho cĂ¹ng	\N	40
1249	è¿‡è‚	guĂ²jiĂ©	qua, Ä‘Ă³n (táº¿t)	\N	36
1294	è¿˜æ˜¯	hĂ¡ishi	váº«n, cĂ²n, hoáº·c hay	\N	25
1300	å–	hÇn	kĂªu la	\N	25
1199	å…‰è¾‰	guÄnghuÄ«	chĂ³i lá»i, rá»±c rá»¡	\N	34
1213	å¤ä»£	gÇ”dĂ i	thá»i cá»• Ä‘áº¡i	\N	34
1215	å¤å…¸	gÇ”diÇn	cá»• Ä‘iá»ƒn	\N	34
1216	å›ºå®	gĂ¹dĂ¬ng	cá»‘ Ä‘á»‹nh	\N	34
1218	è‚¡ä¸œ	gÇ”dÅng	cá»• Ä‘Ă´ng	\N	34
1219	è‚¡ä»½	gÇ”fĂ¨n	cá»• pháº§n	\N	34
1220	é¼“å±	gÇ”lĂ¬	cá»• vÅ©, khuyáº¿n khĂ­ch	\N	34
1221	è‚¡å¸‚	gÇ”shĂ¬	thá»‹ trÆ°á»ng chá»©ng khoĂ¡n	\N	34
1222	éª¨å¹²	gÇ”gĂ n	cá»‘t cĂ¡n, nĂ²ng cá»‘t	\N	34
1223	å§‘å§‘	gÅ«gu	cĂ´	\N	34
1224	å¤æ€ª	gÇ”guĂ i	ká»³ quáº·c	\N	40
1225	è´µ	guĂ¬	Ä‘áº¯t, quĂ½	\N	40
1226	å½’	guÄ«	quy, trá»Ÿ vá»	\N	34
1227	è§„å¾‹	guÄ«lÇœ	quy luáº­t	\N	40
1228	è½¨é“	guÇdĂ o	Ä‘Æ°á»ng ray	\N	34
1229	è§„å®	guÄ«dĂ¬ng	quy Ä‘á»‹nh	\N	40
1233	è§„åˆ’	guÄ«huĂ 	káº¿ hoáº¡ch, quy hoáº¡ch	\N	34
1234	å½’è¿˜	guÄ«huĂ¡n	tráº£ vá», tráº£ láº¡i	\N	40
1235	è§„æ¨¡	guÄ«mĂ³	quy mĂ´	\N	34
1236	å½’çº³	guÄ«nĂ 	quy náº¡p, tĂ³m táº¯t	\N	34
1237	æŸœå°	guĂ¬tĂ¡i	quáº§y hĂ ng, tá»§ bĂ y hĂ ng	\N	40
1238	è§„åˆ™	guÄ«zĂ©	quy táº¯c	\N	24
1239	è´µæ—	guĂ¬zĂº	quĂ½ tá»™c	\N	34
1241	é¡¾å®¢	gĂ¹kĂ¨	khĂ¡ch hĂ ng	\N	38
1242	å¤è€	gÇ”lÇo	cá»• xÆ°a	\N	34
1243	å­¤ç«‹	gÅ«lĂ¬	cĂ´ láº­p	\N	34
1244	é¡¾è™‘	gĂ¹lÇœ	lo láº¯ng, bÄƒn khoÄƒn	\N	34
1245	æ»	gÇ”n	lÄƒn, lá»™n, cĂºt xĂ©o	\N	34
1246	æ£æ£’	gĂ¹nbĂ ng	cĂ´n, gáº­y, gáº­y gá»™c	\N	34
1247	å§‘å¨˜	gÅ«niang	cĂ´ gĂ¡i	\N	34
1248	è¿‡	guĂ²	qua	\N	40
1250	è¿‡æœŸ	guĂ²qĂ­	Ä‘Ă£ quĂ¡, trá»… háº¡n	\N	40
1251	æœæ±	guÇ’zhÄ«	nÆ°á»›c hoa quáº£	\N	34
1253	è¿‡åº¦	guĂ²dĂ¹	quĂ¡ Ä‘á»™, quĂ¡ má»©c	\N	34
1254	è¿‡æ¸¡	guĂ²dĂ¹	chuyá»ƒn tiáº¿p	\N	34
1256	å›½é˜²	guĂ³fĂ¡ng	quá»‘c phĂ²ng	\N	34
1257	å›½ç±	guĂ³jĂ­	quá»‘c tá»‹ch	\N	34
1258	å›½é™…	guĂ³jĂ¬	quá»‘c táº¿	\N	34
1259	å›½å®¶	guĂ³jiÄ	nhĂ  nÆ°á»›c, quá»‘c gia	\N	34
1260	å›½åº†	guĂ³qĂ¬ng	quá»‘c khĂ¡nh	\N	34
1261	è¿‡æ»¤	guĂ²lÇœ	lá»c (bá»¥i, nÆ°á»›c...)	\N	34
1262	è¿‡æ•	guĂ²mÇn	dá»‹ á»©ng	\N	34
1264	è¿‡åˆ†	guĂ²fĂ¨n	quĂ¡ Ä‘Ă¡ng, quĂ¡ má»©c	\N	30
1265	è¿‡å¥–	guĂ²jiÇng	quĂ¡ khen	\N	40
1266	è¿‡é”™	guĂ²cuĂ²	sai láº§m	\N	34
1267	æœç„¶	guÇ’rĂ¡n	quáº£ nhiĂªn, tháº­t váº­y	\N	40
1268	æœå®	guÇ’shĂ­	trĂ¡i cĂ¢y	\N	40
1269	å›½ç‹	guĂ³wĂ¡ng	hoĂ ng Ä‘áº¿, nhĂ  vua	\N	34
1270	å›½å¡é™¢	guĂ³wĂ¹yuĂ n	quá»‘c vá»¥ viá»‡n	\N	34
1272	è¿‡äº	guĂ²yĂº	quĂ¡ chá»«ng, quĂ¡ Ä‘Ă¡ng	\N	34
1273	è‚¡ç¥¨	gÇ”piĂ o	cá»• phiáº¿u	\N	34
1276	æ•…äº‹	gĂ¹shi	sá»± cá»‘, tai náº¡n	\N	34
1277	å›ºä½“	gĂ¹tÇ	thá»ƒ ráº¯n	\N	40
1278	éª¨å¤´	gÇ”tou	xÆ°Æ¡ng	\N	34
1279	é¡¾é—®	gĂ¹wĂ¨n	cá»‘ váº¥n	\N	34
1280	é¼“èˆ	gÇ”wÇ”	cá»• vÅ©	\N	34
1281	æ•…ä¹¡	gĂ¹xiÄng	quĂª nhĂ , quĂª hÆ°Æ¡ng	\N	34
1282	æ•…æ„	gĂ¹yĂ¬	cá»‘ Ă½	\N	34
1283	é›‡ä½£	gĂ¹yÅng	thuĂª	\N	30
1285	æ•…éœ	gĂ¹zhĂ ng	trá»¥c tráº·c, há»ng hĂ³c	\N	34
1287	å“ˆ	hÄ	ha	\N	30
1288	è¿˜	hĂ¡i	cĂ²n, váº«n	\N	34
1289	æµ·	hÇi	biá»ƒn	\N	40
1290	æµ·æ‹”	hÇibĂ¡	Ä‘á»™ cao so vá»›i máº·t nÆ°á»›c biá»ƒn	\N	34
1291	æµ·æ»¨	hÇibÄ«n	miá»n biá»ƒn, ven biá»ƒn	\N	40
1292	æµ·å…³	hÇiguÄn	háº£i quan	\N	40
1293	å®³æ€•	hĂ ipĂ 	sá»£	\N	34
1295	æµ·é²œ	hÇixiÄn	háº£i sáº£n	\N	21
1296	å®³ç¾	hĂ ixiÅ«	xáº¥u há»•, tháº¹n thĂ¹ng	\N	34
1298	å­©å­	hĂ¡izi	tráº» em, tráº» con, em bĂ©, con	\N	22
1299	æ±—	hĂ n	má»“ hĂ´i	\N	34
1301	èˆªç­	hĂ¡ngbÄn	chuyáº¿n bay	\N	40
1302	èˆªç©º	hĂ¡ngkÅng	hĂ ng khĂ´ng	\N	34
1303	èˆªå¤©	hĂ¡ngtiÄn	hĂ ng khĂ´ng vÅ© trá»¥	\N	34
1304	èˆªè¡Œ	hĂ¡ngxĂ­ng	Ä‘i, váº­n chuyá»ƒn	\N	40
1305	è¡Œä¸	hĂ¡ngyĂ¨	ngĂ nh	\N	34
1306	å«ç³	hĂ¡nhu	mÆ¡ há»“	\N	34
1307	å¯’å‡	hĂ¡njiĂ 	kĂ¬ nghá»‰ Ä‘Ă´ng	\N	34
1309	æå«	hĂ nwĂ¨i	báº£o vá»‡, giá»¯ gĂ¬n	\N	40
1310	æ±—æ°´	hĂ nxuĂ¨	hĂ£n huyáº¿t, hÆ¡i han	\N	34
1311	æ±‰è¯­	hĂ nyÇ”	tiáº¿ng HĂ¡n	\N	40
1312	å·	hĂ o	sá»‘, cá»	\N	34
1313	å¥½	hÇo	tá»‘t, hay	\N	34
1314	å¥½åƒ	hÇochÄ«	ngon	\N	34
1315	å·ç 	hĂ omÇ	sá»‘, dĂ£y sá»‘	\N	34
1316	å¥½å¤„	hÇochu	Ä‘iá»ƒm tá»‘t, Æ°u Ä‘iá»ƒm	\N	34
1317	è€—è´¹	hĂ ofĂ¨i	tiĂªu hao, hao phĂ­, hao mĂ²n	\N	40
1318	è±ªå	hĂ¡ohuĂ¡	sang trá»ng, hao hoa	\N	34
1319	å¥½å®¢	hĂ okĂ¨	hiáº¿u khĂ¡ch	\N	40
1320	è±ªè¿ˆ	hĂ¡omĂ i	khĂ­ phĂ¡ch hĂ o hĂ¹ng	\N	34
1336	é»‘	hÄ“i	mĂ u Ä‘en	\N	24
1348	ç‹ å¿ƒ	hÄ›nxÄ«n	nháº«n tĂ¢m	\N	21
1343	å¾ˆ	hÄ›n	vá»«a váº·n	\N	31
1355	åˆå½±	hĂ©yÇng	chá»¥p áº£nh chung	\N	31
1366	å¼	hÇ’u	gĂ o lĂªn, gĂ o to	\N	40
1367	åä»£	hĂ²udĂ i	con chĂ¡u	\N	24
1371	åæ¥	hĂ²ulĂ¡i	sau, sau rá»“i	\N	24
1378	ç”»	huĂ 	váº½, há»a, bá»©c tranh	\N	31
1383	è±ç²‰	huÄfÄ›n	pháº¥n hoa	\N	25
1390	é»„	huĂ¡ng	mĂ u vĂ ng	\N	24
1324	å·å¬	hĂ ozhĂ o	hiá»‡u triá»‡u, kĂªu gá»i	\N	34
1325	å’Œ	hĂ©	vĂ , vá»›i	\N	35
1326	æ²³	hĂ©	sĂ´ng	\N	34
1327	å–	hÄ“	uá»‘ng	\N	34
1328	åˆä¸æ¥	hĂ©bĂ¹lĂ¡i	hĂ²a táº¯t, cĂ£i, báº¥t há»£p	\N	40
1329	åˆå¹¶	hĂ©bĂ¬ng	há»£p láº¡i, há»£p nháº¥t	\N	34
1393	ç‡å	huĂ¡nghĂ²u	hoĂ ng háº­u	\N	24
1331	åˆæ³•	hĂ©fĂ£	há»£p phĂ¡p	\N	34
1333	åˆä¹	hĂ©hÅ«	phĂ¹ há»£p, há»£p vá»›i	\N	34
1334	åˆä¼™	hĂ©huÇ’	káº¿t há»™i, chung vá»‘n	\N	34
1335	å˜¿	hÄ“i	á»‘i, Æ°, Ă´ hay, Æ¡ hay	\N	34
1414	è¯é¢˜	huĂ tĂ­	chá»§ Ä‘á»	\N	32
1337	é»‘æ¿	hÄ“ibÇn	báº£ng Ä‘en	\N	34
1338	å’Œè§£	hĂ©jiÄ›	hĂ²a giáº£i	\N	35
1339	ä½•å†µ	hĂ©kuĂ ng	hÆ¡n ná»¯a	\N	34
1340	åˆç†	hĂ©lÇ	há»£p lĂ½	\N	34
1341	å’Œç¦	hĂ©mĂ¹	vui váº», hĂ²a thuáº­n	\N	35
1342	æ¨	hĂ¨n	háº­n, ghĂ©t	\N	30
1420	åŒ–å¦†	huĂ zhuÄng	trang Ä‘iá»ƒm	\N	40
1345	æ¨ª	hĂ©ng	ngang	\N	34
1346	å“¼	hÄ“ng	rĂªn rá»‰, ngĂ¢m nga	\N	34
1347	ç—•è¿¹	hĂ©njĂ¬	váº¿t tĂ­ch, dáº¥u váº¿t	\N	40
1425	æŒ¥	huÄ«	váº«y	\N	27
1349	å’Œå¹³	hĂ©pĂ­ng	hĂ²a bĂ¬nh	\N	35
1350	å’Œæ°”	hĂ©qĂ¬	Ă´n hĂ²a, Ä‘iá»m Ä‘áº¡m	\N	35
1351	åˆé€‚	hĂ©shĂ¬	phĂ¹ há»£p	\N	34
1352	åˆç®—	hĂ©suĂ n	cĂ³ lá»£i, hiá»‡u quáº£, tĂ­nh toĂ¡n	\N	40
1353	å’Œè°	hĂ©xiĂ©	hĂ i hĂ²a, dá»‹u dĂ ng	\N	35
1354	æ ¸å¿ƒ	hĂ©xÄ«n	trung tĂ¢m	\N	34
1426	ç°	huÄ«	mĂ u xĂ¡m	\N	24
1356	ç›’å­	hĂ©zi	cĂ¡i há»™p	\N	34
1357	åˆä½œ	hĂ©zuĂ²	há»£p tĂ¡c	\N	34
1358	å“„	hÇ’ng	dá»— dĂ nh	\N	34
1359	æ´ªæ°´	hĂ³ngshuÇ	lÅ©	\N	21
1360	çº¢	hĂ³ng	Ä‘á»	\N	34
1362	è½°å¨	hÅngdĂ²ng	xĂ´n xao, nĂ¡o Ä‘á»™ng, cháº¥n Ä‘á»™ng	\N	34
1363	å®è§‚	hĂ³ngguÄn	vÄ© mĂ´	\N	34
1364	å®ä¼Ÿ	hĂ³ngwÄ›i	to lá»›n hĂ o hĂ¹ng, hĂ¹ng vÄ©	\N	34
1365	å	hĂ²u	dĂ y	\N	40
1368	åæœ	hĂ²uguÇ’	háº­u quáº£	\N	24
1370	åæ‚”	hĂ²uhuÇ	há»‘i háº­n	\N	34
1372	å–‰å’™	hĂ³ulĂ³ng	cá»• há»ng	\N	34
1373	åé¢	hĂ²umiĂ n	phĂ­a sau, máº·t sau, Ä‘áº±ng sau	\N	24
1374	åå‹¤	hĂ²uqĂ­n	háº­u cáº§n	\N	24
1375	å€™é€‰	hĂ²uxuÇn	ngÆ°á»i Ä‘Æ°á»£c Ä‘á» cá»­, ngÆ°á»i á»©ng cá»­	\N	34
1376	çŒ´å­	hĂ³uzi	con khá»‰	\N	34
1377	å£¶	hĂº	bĂ¬nh, áº¥m	\N	34
1379	è±	huÄ	hoa, tiĂªu tiá»n	\N	34
1381	æ»‘å†°	huĂ¡bÄ«ng	trÆ°á»£t bÄƒng	\N	34
1382	åˆ’èˆ¹	huĂ¡chuĂ¡n	chĂ¨o thuyá»n	\N	34
1384	å	huĂ i	xáº¥u, há»ng	\N	34
1385	æ€€å¿µ	huĂ¡iniĂ n	hoĂ i niá»‡m, nhá»› nhung	\N	34
1386	æ€€ç–‘	huĂ¡iyĂ­	hoĂ i nghi, nghi ngá»	\N	34
1387	æ€€å­•	huĂ¡iyĂ¹n	cĂ³ thai	\N	34
1388	æ¬¢ä¹	huÄnlĂ¨	sá»± vui má»«ng	\N	34
1391	ç‡å¸	huĂ¡ngdĂ¬	hoĂ ng Ä‘áº¿	\N	34
1392	é»„ç“œ	huĂ¡ngguÄ	dÆ°a chuá»™t	\N	34
1394	é»„æ˜	huĂ¡nghÅ«n	buá»•i chiá»u, hoĂ ng hĂ´n	\N	34
1395	é»„é‡‘	huĂ¡ngjÄ«n	vĂ ng	\N	34
1396	è’å‡‰	huÄngliĂ¡ng	hoang vu, hoang váº¯ng	\N	34
1397	æ…Œå¿™	huÄngmĂ¡ng	vá»™i vĂ ng, láº­t Ä‘áº­t	\N	34
1398	è’è°¬	huÄngmiĂ¹	sai láº§m, vĂ´ lĂ½, hoang Ä‘Æ°á»ng	\N	34
1399	æç„¶å¤§æ‚Ÿ	huÇngrĂ¡ndĂ wĂ¹	bá»—ng nhiĂªn tá»‰nh ngá»™	\N	34
1400	è’å”	huÄngtĂ¡ng	hoang Ä‘Æ°á»ng, vĂ´ lĂ½	\N	34
1402	ç¼“å’Œ	huÇnhĂ©	xoa dá»‹u, hĂ²a hoĂ£n	\N	35
1403	ç¯è‚	huĂ¡njiĂ©	máº¯t xĂ­ch, phĂ¢n Ä‘oáº¡n, Ä‘á»‘t, máº¥u	\N	34
1404	ç¼“è§£	huÇnjiÄ›	xoa dá»‹u, lĂ m dá»‹u	\N	34
1405	ç¯å¢ƒ	huĂ¡njĂ¬ng	mĂ´i trÆ°á»ng, hoĂ n cáº£nh	\N	40
1406	å¹»æƒ³	huĂ nxiÇng	áº£o tÆ°á»Ÿng	\N	34
1407	æ¬¢è¿	huÄnyĂ­ng	Ä‘Ă³n chĂ o, hoan nghĂªnh	\N	34
1408	ç„•ç„¶ä¸€æ–°	huĂ nrĂ¡nyÄ«xÄ«n	trá»Ÿ vá» tráº¡ng thĂ¡i cÅ©	\N	34
1409	æ‚£è€…	huĂ nzhÄ›	ngÆ°á»i bá»‹ bá»‡nh	\N	34
1410	åä¾¨	huĂ¡qiĂ¡o	hoa kiá»u	\N	34
1411	è±ç”Ÿ	huÄshÄ“ng	cá»§ láº¡c	\N	25
1413	åŒ–çŸ³	huĂ shĂ­	hĂ³a tháº¡ch	\N	34
1415	è¯ç­’	huĂ tÇ’ng	microphone	\N	34
1416	åŒ–å­¦	huĂ xuĂ©	hĂ³a há»c	\N	34
1417	åè£”	huĂ¡yĂ¬	Hoa kiá»u	\N	34
1418	åè¯­	huĂ¡yÇ”	tiáº¿ng Hoa	\N	34
1419	è±å›­	huÄyuĂ¡n	hoa viĂªn	\N	34
1421	æ¹–æ³	hĂºpÅ	ao há»“	\N	34
1422	è´è¶	hĂºdiĂ©	bÆ°Æ¡m bÆ°á»›m, con bÆ°á»›m	\N	34
1423	å›	huĂ­	láº§n, vá», quay láº¡i	\N	40
1424	ä¼	huĂ¬	há»™i, há»p	\N	34
1427	å›æ¥	huĂ­bĂ o	tráº£ láº¡i	\N	40
1435	è¾‰ç…Œ	huÄ«huĂ¡ng	huy hoĂ ng, rá»±c rá»¡, xĂ¡n láº¡n	\N	25
1439	å›æ”¶	huĂ­shÅu	thu láº¡i, thu há»“i	\N	30
1449	å©å§»	hÅ«nyÄ«n	hĂ´n nhĂ¢n	\N	22
1467	æ´»è·ƒ	huĂ³yuĂ¨	sĂ´i ná»•i, hoáº¡t bĂ¡t	\N	21
1490	å®¶ä¼™	jiÄhuo	tháº±ng cha, lĂ£o	\N	30
1526	éƒæ¸¸	jiÄoyĂ³u	dĂ£ ngoáº¡i, du ngoáº¡n	\N	31
1529	æ•™å­¦	jiĂ oxuĂ©	giáº£ng dáº¡y	\N	32
1537	ç¼´çº³	jiÇonĂ 	ná»™p (thuáº¿, phĂ­)	\N	30
1546	æ•™å‘˜	jiĂ oyuĂ¡n	giĂ¡o viĂªn, giáº£ng viĂªn	\N	32
1548	æ¥	jiÄ“	tiáº¿p, nháº­n, ná»‘i	\N	40
1429	å›é¿	huĂ­bĂ¬	nĂ© trĂ¡nh, trá»‘n trĂ¡nh	\N	34
1430	ç°å°˜	huÄ«chĂ©n	bá»¥i	\N	40
1431	å›ç­”	huĂ­dĂ¡	tráº£ lá»i	\N	34
1432	æ¢å¤	huÄ«fĂ¹	khĂ´i phá»¥c, phá»¥c há»“i	\N	34
1434	æ‚”æ¨	huÇhĂ¨n	há»‘i háº­n, há»‘i lá»—i	\N	34
1436	æŒ¥éœ	huÄ«huĂ²	phung phĂ­	\N	34
1437	æ¯ç­	huÇmiĂ¨	tiĂªu diá»‡t, há»§y diá»‡t	\N	40
1438	æ±‡ç‡	huĂ¬lÇœ	tá»· giĂ¡	\N	21
1440	ä¼æ™¤	huĂ¬wĂ¹	gáº·p gá»¡, gáº·p máº·t	\N	34
1441	ç°å¿ƒ	huÄ«xÄ«n	náº£n lĂ²ng	\N	34
1442	å›å¿†	huĂ­yĂ¬	há»“i á»©c, nhá»› láº¡i	\N	34
1443	ä¼è®®	huĂ¬yĂ¬	há»™i nghá»‹	\N	34
1445	å–‡å­	hÇ”lÇba	loa, qua quĂ½t, tĂ¹y tiá»‡n	\N	34
1446	å¿½ç•¥	hÅ«lĂ¼Ă¨	bá» qua	\N	34
1447	å©ç¤¼	hÅ«nlÇ	hĂ´n lá»…	\N	34
1448	æ··ä¹±	hĂ¹nluĂ n	há»—n loáº¡n, láº«n lá»™n	\N	34
1450	æ··åˆ	hĂ¹nhĂ©	há»—n há»£p, trá»™n, nhĂ o	\N	34
1452	æ˜è¿·	hÅ«nmĂ­	hĂ´n mĂª, mĂª man	\N	34
1453	æ··æ·†	hÅ«nxiĂ¡o	lá»™n xá»™n, xĂ¡o trá»™n	\N	34
1454	æµ‘æµ	hÅ«nzhĂºo	váº©n Ä‘á»¥c	\N	31
1455	ä¼™ä¼´	huÇ’bĂ n	Ä‘á»‘i tĂ¡c	\N	34
1456	è´§å¸	huĂ²bĂ¬	tiá»n tá»‡	\N	40
1457	ç«æŸ´	huÇ’chĂ¡i	diĂªm	\N	40
1458	ç«è½¦ç«™	huÇ’chÄ“ zhĂ n	ga tĂ u	\N	28
1459	è·å¾—	huĂ²dĂ©	giĂ nh Ä‘Æ°á»£c, Ä‘áº¡t Ä‘Æ°á»£c	\N	35
1460	æ´»å¨	huĂ³dĂ²ng	hoáº¡t Ä‘á»™ng	\N	34
1461	æ´»è¯¥	huĂ³gÄi	Ä‘Ă¡ng Ä‘á»i	\N	34
1463	æ´»å›	huĂ³lĂ¬	sá»©c sá»‘ng	\N	34
1464	æ´»æ³¼	huĂ³pÅ	hoáº¡t bĂ¡t, nhanh nháº¹n	\N	34
1465	æˆ–	huĂ²	hoáº·c	\N	35
1466	ç«è¯	huÇ’yĂ o	thuá»‘c sĂºng	\N	34
1468	å¿½ç„¶	hÅ«rĂ¡n	Ä‘á»™t nhiĂªn, chá»£t	\N	34
1469	æ¤å£«	hĂ¹shi	y tĂ¡	\N	24
1470	èƒ¡è¯´	hĂºshuÅ	nĂ³i nháº£m, tĂ o lao	\N	34
1471	èƒ¡åŒ	hĂºtĂ²ng	ngĂµ, háº»m	\N	34
1472	å‘¼å¸	hÅ«xÄ«	hĂ´ háº¥p, hĂ­t thá»Ÿ	\N	34
1475	å‘¼å–	hÅ«hÇn	hĂ´ hĂ o, kĂªu gá»i	\N	34
1476	æ¤ç…§	hĂ¹zhĂ o	há»™ chiáº¿u	\N	34
1477	æ	jĂ­	ráº¥t, háº¿t, cá»±c	\N	40
1479	æœº	jÄ«	mĂ¡y, váº£i	\N	40
1480	å®¶	jiÄ	gia, láº¥y chá»“ng	\N	40
1481	å®¶åº­	jiÄtĂ­ng	gia Ä‘Ă¬nh, nhĂ 	\N	22
1482	å‡	jiÇ	giáº£, giáº£ Ä‘á»‹nh, giáº£ nhÆ°	\N	22
1483	ä»·	jiĂ 	giĂ¡, giĂ¡ cáº£	\N	37
1485	å ç­	jiÄbÄn	tÄƒng ca	\N	32
1486	å˜‰å®¾	jiÄbÄ«n	khĂ¡ch	\N	30
1488	ä»·æ ¼	jiĂ gĂ©	giĂ¡ cáº£	\N	37
1489	å å·¥	jiÄgÅng	gia cĂ´ng, cháº¿ biáº¿n	\N	34
1491	å å‰§	jiÄjĂ¹	tráº§m trá»ng thĂªm	\N	34
1492	å®¶å…·	jiÄjĂ¹	gia cá»¥, Ä‘á»“ dĂ¹ng trong nhĂ 	\N	34
1493	ä»¶	jiĂ n	chiáº¿c, cĂ¡i, kiá»‡n	\N	40
1494	ç®€å•	jiÇndÄn	Ä‘Æ¡n giáº£n	\N	34
1495	æ‹£	jiÇn	lá»±a chá»n, nháº·t láº¥y	\N	40
1496	ç…	jiÄn	rĂ¡n, chiĂªn	\N	40
1497	é—´	jiÄn	giá»¯a, trong	\N	34
1498	å»ºç«‹	jiĂ nlĂ¬	thiáº¿t láº­p	\N	40
1499	ç›‘ç£	jiÄndÅ«	giĂ¡m sĂ¡t, Ä‘Ă´n thĂºc	\N	34
1501	åå†³	jiÄnjuĂ©	kiĂªn quyáº¿t, dá»©t khoĂ¡t	\N	34
1502	å»ºè®¾	jiĂ nshĂ¨	xĂ¢y dá»±ng	\N	40
1503	åæŒ	jiÄnchĂ­	kiĂªn trĂ¬, vá»¯ng cháº¯c	\N	34
1504	å‰ªåˆ€	jiÇndÄo	kĂ©o, cĂ¡i kĂ©o	\N	40
1505	å‡å°‘	jiÇnshÇo	giáº£m bá»›t, giáº£m thiá»ƒu	\N	34
1506	æ£€æŸ¥	jiÇnchĂ¡	kiá»ƒm tra	\N	40
1507	ç®€å†	jiÇnlĂ¬	sÆ¡ yáº¿u lĂ½ lá»‹ch	\N	34
1508	æ£€è®¨	jiÇntÇo	tháº£o luáº­n, tá»± kiá»ƒm	\N	40
1509	ç®€ç›´	jiÇnzhĂ­	quáº£ thá»±c, tháº­t lĂ 	\N	30
1511	å‰ª	jiÇn	cáº¯t, xĂ©n	\N	40
1513	å°–é”	jiÄnruĂ¬	sáº¯c bĂ©n, gay gáº¯t	\N	40
1514	å¥åº·	jiĂ nkÄng	khá»e máº¡nh	\N	34
1515	è®²	jiÇng	nĂ³i, ká»ƒ, giáº£ng	\N	34
1516	é™ä½	jiĂ ngdÄ«	háº¡ tháº¥p, giáº£m bá»›t	\N	34
1517	å¥–é‡‘	jiÇngjÄ«n	tiá»n thÆ°á»Ÿng	\N	34
1518	å°†æ¥	jiÄnglĂ¡i	tÆ°Æ¡ng lai	\N	34
1519	å¥–å±	jiÇnglĂ¬	khen thÆ°á»Ÿng	\N	34
1520	å¥–	jiÇng	thÆ°á»Ÿng, giáº£i thÆ°á»Ÿng	\N	34
1521	é™	jiĂ ng	háº¡ xuá»‘ng, rÆ¡i xuá»‘ng	\N	40
1522	è®²åº§	jiÇngzuĂ²	tá»a Ä‘Ă m, bĂ¡o cĂ¡o	\N	34
1527	æ•™å¸ˆ	jiĂ oshÄ«	giĂ¡o viĂªn	\N	34
1528	æ•™å ‚	jiĂ otĂ¡ng	nhĂ  thá»	\N	34
1536	æ…æ‹Œ	jiÇobĂ n	khuáº¥y, trá»™n	\N	34
1540	é¥º	jiÇo	bĂ¡nh cháº»o	\N	34
1549	è¡—é“	jiÄ“dĂ o	Ä‘Æ°á»ng phá»‘	\N	34
1550	è‚	jiĂ©	tiáº¿t, Ä‘á»‘t, khĂºc, pháº§n	\N	34
1551	ç›‘è§†	jiÄnshĂ¬	giĂ¡m thá»‹, theo dĂµi	\N	34
1554	é—´æ­‡å­—	jiĂ nxÄ«zĂ¬	chá»¯ giĂ¡n thá»‡	\N	37
1535	éª„å‚²	jiÄoâ€™Ă o	kiĂªu ngáº¡o, tá»± hĂ o	\N	27
1524	äº¤	jiÄo	giao, ná»™p, káº¿t giao	\N	34
1633	è‚å¥	jiĂ©zĂ²u	nhá»‹p Ä‘iá»‡u, tiáº¿t táº¥u	\N	24
1541	æ•™	jiĂ o	dáº¡y	\N	32
1573	å¨‡æ°”	jiÄoqĂ¬	duyĂªn dĂ¡ng, thanh nhĂ£	\N	30
1562	ç›‘ç‹±	jiÄnyĂ¹	nhĂ  tĂ¹, nhĂ  giam	\N	27
1630	ä»‹è´¨	jiĂ¨zhĂ¬	cháº¥t trung gian	\N	40
1581	å æ²¹ç«™	jiÄyĂ³uzhĂ n	tráº¡m xÄƒng	\N	28
1604	ç•Œé™	jiĂ¨xiĂ n	ranh giá»›i	\N	30
1523	äº¤æµ	jiÄoliĂº	giao lÆ°u	\N	34
1615	å§å§	jiÄ›jie	chá»‹ gĂ¡i	\N	28
1525	éƒåŒº	jiÄoqÅ«	ngoáº¡i Ă´	\N	34
1530	æ•™è‚²	jiĂ oyĂ¹	giĂ¡o dá»¥c	\N	34
1531	äº¤æ¢	jiÄohuĂ n	trao Ä‘á»•i	\N	40
1620	ä»‹ç»	jiĂ¨shĂ o	giá»›i thiá»‡u	\N	30
1625	è§£é‡	jiÄ›shĂ¬	giáº£i thĂ­ch	\N	37
1538	è§’	jiÇo	sá»«ng, gĂ³c	\N	34
1539	è„	jiÇo	chĂ¢n	\N	30
1627	æˆªæ­¢	jiĂ©zhÇ	káº¿t thĂºc	\N	40
1634	æ¿€å‘	jÄ«fÄ	kĂ­ch thĂ­ch	\N	32
1543	æ•™ç»ƒ	jiĂ oliĂ n	huáº¥n luyá»‡n viĂªn	\N	40
1544	æ•™æˆ	jiĂ oshĂ²u	giĂ¡o sÆ°	\N	34
1545	æ•™å®¤	jiĂ oshĂ¬	lá»›p, phĂ²ng há»c	\N	34
1547	å«	jiĂ o	gá»i, kĂªu	\N	34
1553	èˆ°è‰‡	jiĂ ntÇng	chiáº¿n háº¡m	\N	34
1637	æœºæ„	jÄ«gĂ²u	cÆ¡ cáº¥u, Ä‘Æ¡n vá»‹, cÆ¡ quan	\N	24
1555	è§é—»	jiĂ nwĂ©n	hiá»ƒu biáº¿t, sá»± tá»«ng tráº£i	\N	40
1556	æ£€éªŒ	jiÇnyĂ n	kiá»ƒm nghiá»‡m, kiá»ƒm tra	\N	40
1557	å‡å¼±	jiÇnruĂ²	giáº£m dáº§n, kĂ©m yáº¿u	\N	34
1558	å»ºè®®	jiĂ nyĂ¬	Ä‘á» xuáº¥t, kiáº¿n nghá»‹	\N	40
1559	åç¡¬	jiÄnyĂ¬ng	cá»©ng, cháº¯c, ráº¯n	\N	34
1560	å…¼è€Œåˆä¸ºå‹‡ä¸º	jiÄnyÇ’ngwĂ©i	giĂ¡m lĂ m viá»‡c nghÄ©a	\N	35
1561	é‰´äº	jiĂ nyĂº	tháº¥y ráº±ng, xĂ©t tháº¥y	\N	40
1639	æœºå…³	jÄ«guÄn	cÆ¡ quan	\N	27
1564	åæ‰§	jiÄnzhĂ­	kiĂªn cháº¥p	\N	40
1565	æµ‡	jiÄo	tÆ°á»›i, Ä‘á»•, dá»™i	\N	34
1566	äº¤å‰	jiÄochÄ	Ä‘an xen, Ä‘an chĂ©o	\N	34
1567	äº¤é™…	jiÄojĂ¬	giao táº¿, giao tiáº¿p	\N	34
1568	æ•™ä¼	jiĂ ohuĂ¬	giĂ¡o há»™i	\N	34
1569	è§’åº¦	jiÇodĂ¹	gĂ³c, gĂ³c Ä‘á»™	\N	34
1570	ç„¦è™‘	jiÄolÇœ	lo láº¯ng, nĂ´n nĂ³ng	\N	34
1571	è§’è½	jiÇoluĂ²	gĂ³c xĂ³ xá»‰nh	\N	34
1572	äº¤çº³	jiÄonĂ 	ná»™p, giao ná»™p	\N	34
1641	å‡ ä¹	jÄ«hÅ«	háº§u nhÆ°, cÆ¡ há»“	\N	24
1575	èƒ¶æ°´	jiÄoshuÇ	keo nÆ°á»›c, há»“ dĂ¡n	\N	34
1576	äº¤é€	jiÄotÅng	giao thĂ´ng	\N	34
1577	å‡å¦‚	jiÇrĂº	náº¿u nhÆ°	\N	40
1578	å‡è®¾	jiÇshĂ¨	giáº£ thuyáº¿t	\N	30
1579	å®¶å±	jiÄshÇ”	ngÆ°á»i nhĂ 	\N	34
1580	å®¶å¡	jiÄwĂ¹	viá»‡c nhĂ 	\N	40
1542	æ•™æ	jiĂ ocĂ¡i	tĂ i liá»‡u giáº£ng dáº¡y	\N	40
1582	ä½³è‚´	jiÄyĂ¡o	mĂ³n Äƒn ngon	\N	34
1583	å®¶å–»æˆ·æ™“	jiÄyĂ¹hĂ¹xiÇo	nhĂ  nhĂ  Ä‘á»u biáº¿t	\N	40
1584	å‡è£…	jiÇzhuÄng	giáº£ vá»	\N	34
1585	ä»·å€¼	jiĂ zhĂ­	giĂ¡ trá»‹	\N	37
1586	æ¶å­	jiĂ zi	cĂ¡i ká»‡	\N	40
1587	å«‰å¦’	jĂ­dĂ¹	Ä‘á»‘ ká»µ, ganh ghĂ©t	\N	34
1588	çº§åˆ«	jĂ­biĂ©	trĂ¬nh Ä‘á»™	\N	34
1590	æœºåœº	jÄ«chÇng	sĂ¢n bay	\N	21
1591	ç»§æ‰¿	jĂ¬chĂ©ng	káº¿ thá»«a, káº¿ tá»¥c	\N	30
1592	åŸºç¡€	jÄ«chÇ”	cÆ¡ sá»Ÿ, ná»n táº£ng	\N	34
1593	é¸¡è›‹	jÄ«dĂ n	trá»©ng gĂ 	\N	34
1594	è®°å¾—	jĂ¬de	nhá»›, nhá»› Ä‘Æ°á»£c	\N	35
1595	åŸºåœ°	jÄ«dĂ¬	cÄƒn cá»©	\N	35
1597	å­£åº¦	jĂ¬dĂ¹	quĂ½, 3 thĂ¡ng	\N	30
1598	æç«¯	jĂ­duÄn	cá»±c Ä‘oan	\N	34
1599	å³	jĂ­	tá»©c, liá»n	\N	40
1600	æˆª	jiĂ©	Ä‘oáº¡n, khĂºc	\N	34
1601	ç†	jiÄ“	Ä‘á»u	\N	40
1602	ç»“	jiĂ©	káº¿t	\N	40
1605	è§£æ”¾	jiÄ›fĂ ng	giáº£i phĂ³ng	\N	34
1606	ç»“æ„	jiĂ©gĂ²u	káº¿t cáº¥u	\N	24
1607	ç»“æœ	jiĂ©guÇ’	káº¿t quáº£	\N	40
1608	ç»“åˆ	jiĂ©hĂ©	káº¿t há»£p	\N	34
1609	å€Ÿé‰´	jiĂ¨jiĂ n	rĂºt kinh nghiá»‡m	\N	40
1610	æ¥è¿‘	jiÄ“jĂ¬n	tiáº¿p cáº­n	\N	34
1612	ç»“æ™¶	jiĂ©jÄ«ng	káº¿t tinh	\N	40
1613	ç»“å±€	jiĂ©jĂº	káº¿t cá»¥c	\N	40
1614	è§£å†³	jiÄ›juĂ©	giáº£i quyáº¿t	\N	40
1616	æ¥è¿	jiÄ“liĂ¡n	liĂªn tiáº¿p	\N	34
1617	ç»“è®º	jiĂ©lĂ¹n	káº¿t luáº­n	\N	40
1618	è‚ç›®	jiĂ©mĂ¹	tiáº¿t má»¥c	\N	40
1619	ä»‹å…¥	jiĂ¨rĂ¹	xen vĂ o, tham dá»±	\N	34
1621	è‚çœ	jiĂ©shÄ›ng	tiáº¿t kiá»‡m	\N	40
1622	ç»“æŸ	jiĂ©shĂ¹	káº¿t thĂºc	\N	40
1624	ç»“ç®—	jiĂ©suĂ n	thanh toĂ¡n	\N	34
1626	æ¥è§¦	jiÄ“chĂ¹	tiáº¿p xĂºc	\N	34
1628	è‚çº¦	jiĂ©yuÄ“	tiáº¿t kiá»‡m	\N	40
1629	æ¥ç€	jiÄ“zhe	tiáº¿p theo	\N	34
1631	æˆ’æŒ‡	jiĂ¨zhÇ	nháº«n	\N	21
1635	åæ ¼	jĂ­gĂ©	há»£p cĂ¡ch, Ä‘áº¡t tiĂªu chuáº©n	\N	40
1636	æœºå…³å‰è¿›	jÄ«gÅngjĂ¬nlÇ	vi cĂ£i trÆ°á»›c máº·t	\N	34
1638	ç±è´¯	jĂ­guĂ n	quĂª quĂ¡n	\N	40
1640	é›†åˆ	jĂ­hĂ©	táº­p há»£p, táº­p trung	\N	34
1713	ä»å¤©	jÄ«ntiÄn	hĂ´m nay	\N	30
1649	çºªå¾‹	jĂ¬lÇœ	ká»· luáº­t	\N	40
1698	ç²¾ç»†	jÄ«ngxĂ¬	tá»‰ má»‰	\N	26
1664	è¿›æ­¥	jĂ¬nbĂ¹	tiáº¿n bá»™	\N	40
1685	ç²¾è‹±	jÄ«ngyÄ«ng	tinh anh	\N	31
1673	è­¦å¯Ÿ	jÇngchĂ¡	cáº£nh sĂ¡t	\N	26
1724	é›†ä½“	jĂ­tÇ	táº­p thá»ƒ	\N	37
1660	ç´§å¯†	jÇnmĂ¬	cháº·t cháº½	\N	40
1672	ç²¾å½©	jÄ«ngcÇi	tuyá»‡t vá»i	\N	34
1687	ç»å•†	jÄ«ngshÄng	kinh doanh	\N	38
1681	ç²¾ç¥	jÄ«ngshĂ©n	tinh tháº§n	\N	30
1677	ç²¾ç¡®	jÄ«ngquĂ¨	chĂ­nh xĂ¡c	\N	34
1645	å³å°†	jĂ­jiÄng	sáº¯p tá»›i	\N	34
1646	ç§¯æ	jÄ«jĂ­	tĂ­ch cá»±c, hÄƒng hĂ¡i	\N	21
1647	è®¡è¾ƒ	jĂ¬jiĂ o	so bĂ¬, tĂ­nh toĂ¡n	\N	34
1648	å­£è‚	jĂ¬jiĂ©	mĂ¹a, mĂ¹a khĂ­ háº­u	\N	30
1650	çºªå¿µ	jĂ¬niĂ n	ká»· niá»‡m	\N	40
1651	æ€¥å¿™	jĂ­mĂ¡ng	vá»™i vĂ£, háº¥p táº¥p	\N	34
1652	çºªå®	jĂ¬shĂ­	kĂ½ sá»±	\N	23
1653	åæ—¶	jĂ­shĂ­	ká»‹p thá»i	\N	34
1654	ç§¯è“„	jÄ«xĂ¹	tĂ­ch lÅ©y	\N	40
1656	æ¿€çƒˆ	jÄ«liĂ¨	mĂ£nh liá»‡t	\N	34
1657	æœºçµ	jÄ«lĂ­ng	thĂ´ng minh	\N	34
1658	è®°å½•	jĂ¬lĂ¹	ghi chĂ©p	\N	34
1659	æ¿€å¿™	jÄ«mĂ¡ng	vá»™i vĂ ng	\N	34
1735	ä¹…	jiÇ”	lĂ¢u, lĂ¢u Ä‘á»i	\N	24
1661	è¿›è¡Œ	jĂ¬nxĂ­ng	tiáº¿n hĂ nh	\N	40
1662	è¿›	jĂ¬n	tiáº¿n, vĂ o	\N	40
1663	ç´§	jÇn	cháº·t	\N	30
1738	çº çº·	jiÅ«fÄ“n	tranh cháº¥p, báº¥t hĂ²a	\N	22
1666	æ€èƒ½	jĂ¬nĂ©ng	ká»¹ nÄƒng	\N	34
1667	è¿›è€Œ	jĂ¬n'Ă©r	tiáº¿n tá»›i, triá»ƒn khai káº¿ tiáº¿p	\N	35
1668	äº•	jÇng	giáº¿ng, háº§m, lĂ²	\N	34
1669	é™	jĂ¬ng	tháº£n cĂ¢y	\N	25
1670	æ•¬ä¸ä¹ä¸	jĂ¬ng yĂ¨ yĂ¨	cáº©n trá»ng, cáº©n tháº­n, cáº§n cĂ¹	\N	34
1671	æ•¬çˆ±	jĂ¬ng'Ă i	kĂ­nh yĂªu	\N	34
1739	æ•‘æ¤è½¦	jiĂ¹hĂ¹chÄ“	xe cá»©u há»™	\N	28
1741	å°±è¿‘	jiĂ¹jĂ¬n	lĂ¢n cáº­n, vĂ¹ng phá»¥ cáº­n	\N	25
1675	ç²¾è¯	jÄ«ngchĂ©ng	thĂ nh tháº­t	\N	31
1676	ç²¾æ¹›	jÄ«ngzhĂ n	tinh táº¿	\N	40
1743	é…’ç²¾	jiÇ”jÄ«ng	cá»“n, rÆ°á»£u cá»“n	\N	26
1678	æ™¯è±¡	jÇngxiĂ ng	cáº£nh tÆ°á»£ng	\N	40
1679	è­¦å‘	jÇnggĂ o	cáº£nh cĂ¡o	\N	34
1680	ç»è¿‡	jÄ«ngguĂ²	quĂ¡ trĂ¬nh, qua, Ä‘i qua	\N	40
1750	è¿¹è±¡	jĂ¬xiĂ ng	dáº¥u hiá»‡u	\N	24
1682	ç²¾å›	jÄ«nglĂ¬	tinh lá»±c, sá»©c lá»±c	\N	40
1683	ç»æµ	jÄ«ngjĂ¬	kinh táº¿	\N	40
1684	ç»éªŒ	jÄ«ngyĂ n	kinh nghiá»‡m	\N	40
1723	è®°å¿†	jĂ¬yĂ¬	trĂ­ nhá»›	\N	34
1686	æ™¯è‰²	jÇngsĂ¨	phong cáº£nh	\N	34
1690	ç»æµå­¦	jÄ«ngjĂ¬xuĂ©	kinh táº¿ há»c	\N	34
1691	ç»ç†	jÄ«nglÇ	giĂ¡m Ä‘á»‘c	\N	34
1692	ç«Ÿç„¶	jĂ¬ngrĂ¡n	mĂ , láº¡i, váº­y mĂ 	\N	40
1693	ç²¾ç¾	jÄ«ngmÄ›i	tinh xáº£o, Ä‘áº¹p Ä‘áº½	\N	34
1694	è¿›æ”»	jĂ¬ngÅng	táº¥n cĂ´ng	\N	34
1695	æƒå¥‡	jÄ«ngqĂ­	kinh ngáº¡c, láº¥y lĂ m láº¡	\N	40
1696	ç«èµ›	jĂ¬ngsĂ i	cuá»™c thi	\N	34
1697	ç²¾é€	jÄ«ngtÅng	tinh thĂ´ng	\N	34
1699	ç»ç®¡	jÄ«ngguÇn	cai quáº£n	\N	40
1701	è¿›å£	jĂ¬nkÇ’u	nháº­p kháº©u	\N	24
1702	è¿›å–	jĂ¬nqÇ”	cáº§u tiáº¿n	\N	40
1703	è¿›å…¥	jĂ¬nrĂ¹	tiáº¿n vĂ o	\N	40
1704	è¿‘æ¥	jĂ¬nlĂ¡i	gáº§n Ä‘Ă¢y	\N	40
1705	å°½å›	jĂ¬nlĂ¬	háº¿t sá»©c	\N	40
1706	å°½é‡	jÇnliĂ ng	táº­n lá»±c	\N	31
1707	æµ¸æ³¡	jĂ¬npĂ o	ngĂ¢m, nhĂºng	\N	34
1708	ç´§è¿«	jÇnpĂ²	cáº¥p bĂ¡ch	\N	21
1710	è°¨æ…	jÇnshĂ¨n	cáº©n tháº­n	\N	30
1711	æ™‹å‡	jĂ¬nshÄ“ng	thÄƒng tiáº¿n	\N	40
1712	é‡‘å±	jÄ«nshÇ”	kim loáº¡i	\N	34
1714	å²å¤´	jĂ¬ntĂ³u	sá»©c máº¡nh	\N	34
1715	é”¦ç»£å‰ç¨‹	jÇnxiĂ¹ qiĂ¡nchĂ©ng	tÆ°Æ¡ng lai tÆ°Æ¡i sĂ¡ng	\N	34
1716	è¿›å±•	jĂ¬nzhÇn	tiáº¿n triá»ƒn	\N	40
1717	ç´§å¼ 	jÇnzhÄng	cÄƒng tháº³ng	\N	30
1718	ç¦æ­¢	jĂ¬nzhÇ	cáº¥m	\N	34
1719	æœºå™¨	jÄ«qĂ¬	mĂ¡y mĂ³c	\N	34
1720	æå…¶	jĂ­qĂ­	cá»±c ká»³	\N	21
1722	ç´§æ€¥	jÇnjĂ­	cáº¥p thiáº¿t	\N	40
1726	è®¡ç®—	jĂ¬suĂ n	tĂ­nh toĂ¡n	\N	34
1728	æ€æœ¯	jĂ¬shĂ¹	ká»¹ thuáº­t	\N	30
1729	ç»§ç»­	jĂ¬xĂ¹	tiáº¿p tá»¥c	\N	40
1730	å³ä½¿	jĂ­shÇ	cho dĂ¹	\N	40
1732	å¯‚å¯	jĂ¬mĂ²	cĂ´ Ä‘Æ¡n	\N	34
1733	æ•‘	jiĂ¹	cá»©u	\N	21
1734	æ—§	jiĂ¹	cÅ©	\N	21
1736	ä¹	jiÇ”	chĂ­n	\N	21
1737	é…’å§	jiÇ”bÄ	quĂ¡n bar	\N	35
1742	ç©¶ç«Ÿ	jiÅ«jĂ¬ng	rá»‘t cuá»™c, cuá»‘i cĂ¹ng	\N	34
1744	å°±ä¸	jiĂ¹yĂ¨	cĂ³ cĂ´ng Äƒn viá»‡c lĂ m, Ä‘i lĂ m	\N	34
1745	çº æ­£	jiÅ«zhĂ¨ng	uá»‘n náº¯n, sá»­a chá»¯a	\N	34
1746	å°±èŒ	jiĂ¹zhĂ­	nháº­n chá»©c, nháº­m chá»©c	\N	40
1748	æé™	jĂ­xiĂ n	cao nháº¥t, cá»±c Ä‘á»™	\N	34
1749	å‰ç¥¥	jĂ­xiĂ¡ng	may máº¯n, cĂ¡t tÆ°á»ng	\N	34
1751	è®¥ç¬‘	jÄ«xiĂ o	chĂ¢m biáº¿m, nháº¡o bĂ¡ng, cháº¿ giá»…u	\N	34
1752	æœºæ¢°	jÄ«xiĂ¨	mĂ¡y mĂ³c	\N	34
1753	çºªè¦	jĂ¬yĂ o	ká»· yáº¿u, tĂ³m táº¯t	\N	34
1854	è¯¾é¢˜	kĂ¨tĂ­	Ä‘á» tĂ i	\N	32
1727	è®°è€…	jĂ¬zhÄ›	nhĂ  bĂ¡o	\N	30
1837	åˆ»	kĂ¨	â€œkháº¯câ€ = 15 phĂºt	\N	30
1761	ä¸¾	jÇ”	nĂ¢ng, nháº¥c, giÆ¡	\N	30
1762	ä¿±ä¹éƒ¨	jĂ¹ lĂ¨ bĂ¹	cĂ¢u láº¡c bá»™	\N	24
1780	é èº¬	jÅ«gÅng	cĂºi chĂ o, cĂºi Ä‘áº§u	\N	24
1788	å†›äº‹	jÅ«nshĂ¬	quĂ¢n sá»±	\N	27
1789	å‡åŒ€	jÅ«nyĂºn	Ä‘á»u, dĂ n	\N	31
1794	æ®è¯´	jĂ¹shuÅ	nghe nĂ³i	\N	33
1800	å¡è½¦	kÇchÄ“	xe táº£i	\N	28
1803	å¼€é™¤	kÄichĂº	khai trá»«, Ä‘uá»•i	\N	21
1754	ç»™äºˆ	jÇyÇ”	dĂ nh cho, cho	\N	40
1755	åŸºäº	jÄ«yĂº	dá»±a trĂªn, cÄƒn cá»© vĂ o	\N	40
1757	è®°è½½	jĂ¬zÇi	ghi láº¡i, ghi chĂ©p	\N	34
1758	æ€¥èº	jĂ­zĂ o	nĂ³ng vá»™i, háº¥p táº¥p	\N	34
1759	åæ—©	jĂ­zÇo	sá»›m, ká»‹p thá»i	\N	34
1760	æœºæ™º	jÄ«zhĂ¬	lanh trĂ­, tinh nhanh	\N	34
1827	è€ƒå¯Ÿ	kÇochĂ¡	kháº£o sĂ¡t, quan sĂ¡t	\N	27
1828	è€ƒå¤å­¦	kÇogÇ”xuĂ©	kháº£o cá»• há»c	\N	32
1763	æ	juÄn	táº·ng, quyĂªn gĂ³p	\N	34
1764	ä¸¾å	jÇ”bĂ n	tá»• chá»©c	\N	40
1765	å…·å¤‡	jĂ¹bĂ¨i	cĂ³ Ä‘á»§, cĂ³ sáºµn	\N	34
1766	å‰§æœ¬	jĂ¹bÄ›n	ká»‹ch báº£n	\N	34
1767	å±€éƒ¨	jĂºbĂ¹	cá»¥c bá»™, bá»™ pháº­n	\N	34
1768	ä¸¾å¨	jÇ”dĂ²ng	hĂ nh Ä‘á»™ng, Ä‘á»™ng tĂ¡c	\N	34
1769	å†³å®	juĂ©dĂ¬ng	quyáº¿t Ä‘á»‹nh	\N	40
1770	ç»å¯¹	juĂ©duĂ¬	tuyá»‡t Ä‘á»‘i	\N	34
1771	å†³æ–­	juĂ©duĂ n	quyáº¿t Ä‘oĂ¡n	\N	34
1772	è§‰å¯Ÿ	juĂ©chĂ¡	phĂ¡t giĂ¡c	\N	40
1774	è§’è‰²	juĂ©sĂ¨	vai (vai trĂ²)	\N	34
1775	ç»æœ›	juĂ©wĂ ng	tuyá»‡t vá»ng	\N	34
1776	è§‰é†’	juĂ©xÇng	tá»‰nh ngá»™	\N	34
1777	å†³è®®	juĂ©yĂ¬	nghá»‹ quyáº¿t	\N	40
1778	ç»ç¼˜	juĂ©yuĂ¡n	cĂ¡ch ly, cĂ¡ch Ä‘iá»‡n	\N	40
1779	æ‹’ç»	jĂ¹juĂ©	tá»« chá»‘i, cá»± tuyá»‡t	\N	40
1841	å®¢æ°”	kĂ¨qi	khĂ¡ch sĂ¡o	\N	30
1781	å‰§æƒ…	jĂ¹qĂ­ng	tĂ¬nh tiáº¿t	\N	40
1782	èç²¾ä¼ç¥	jĂ¹jÄ«nghuĂ¬shĂ©n	táº­p trung tinh tháº§n	\N	34
1783	æ‹˜è°¨	jÅ«jÇn	nhĂºt nhĂ¡t, dĂ¨ dáº·t	\N	34
1784	æ‹˜ç•™	jÅ«liĂº	táº¡m giam, táº¡m giá»¯	\N	34
1785	è·ç¦»	jĂ¹lĂ­	khoáº£ng cĂ¡ch	\N	34
1786	å‰§çƒˆ	jĂ¹liĂ¨	mĂ£nh liá»‡t	\N	34
1857	æ ­	kÄ›	cĂ¢y, ngá»n	\N	25
1790	å±…ç„¶	jÅ«rĂ¡n	láº¡i, váº­y mĂ 	\N	40
1791	å±€å¿	jĂºshĂ¬	tháº¿ cá»¥c, tĂ¬nh hĂ¬nh	\N	40
1792	ä¸¾ä¸–é—»å	jÇ”shĂ¬ wĂ©nmĂ­ng	ná»•i tiáº¿ng tháº¿ giá»›i	\N	34
1848	é¢—	kÄ“	háº¡t, hĂ²n, viĂªn	\N	34
1795	æ®æ‚‰	jĂ¹xÄ«	Ä‘Æ°á»£c biáº¿t	\N	34
1796	å±€é™	jĂºxiĂ n	háº¡n cháº¿, giá»›i háº¡n	\N	30
1797	ä¸¾è¡Œ	jÇ”xĂ­ng	tá»• chá»©c, cá»­ hĂ nh	\N	40
1798	å±…ä½	jÅ«zhĂ¹	cÆ° trĂº, sinh sá»‘ng	\N	34
1799	ä¸¾è¶³è½»é‡	jÇ”zĂº qÄ«ngzhĂ²ng	cĂ³ áº£nh hÆ°á»Ÿng quyáº¿t Ä‘á»‹nh	\N	34
1801	å’–å•¡	kÄfÄ“i	cĂ  phĂª	\N	26
1802	å¼€	kÄi	má»Ÿ	\N	34
1804	å¼€å‘	kÄifÄ	khai phĂ¡, má»Ÿ mang	\N	40
1805	å¼€æ”¾	kÄifĂ ng	má»Ÿ cá»­a	\N	40
1806	å¼€æœ—	kÄilÇng	rá»™ng rĂ£i, thoĂ¡ng mĂ¡t, sĂ¡ng sá»§a	\N	34
1807	å¼€å¹•å¼	kÄimĂ¹ shĂ¬	lá»… khai máº¡c	\N	40
1808	å¼€è¾Ÿ	kÄipĂ¬	má»Ÿ, khai phĂ¡, khai thĂ¡c	\N	40
1809	å¼€å§‹	kÄishÇ	báº¯t Ä‘áº§u	\N	40
1810	å¼€ç©ç¬‘	kÄiwĂ¡nxiĂ o	Ä‘Ă¹a, giá»¡n	\N	40
1811	å¼€å¿ƒ	kÄixÄ«n	vui váº», háº¡nh phĂºc	\N	40
1812	å¼€å±•	kÄizhÇn	triá»ƒn khai, má»Ÿ rá»™ng	\N	34
1813	å¼€æ”¯	kÄizhÄ«	chi tiĂªu	\N	40
1814	çœ‹	kĂ n	nhĂ¬n, xem	\N	40
1816	çœ‹æ¥	kĂ nlĂ¡i	xem ra	\N	40
1817	çœ‹ä¸èµ·	kĂ nbuqÇ	coi thÆ°á»ng	\N	34
1818	åˆç™»	kÄndÄ“ng	Ä‘Äƒng, xuáº¥t báº£n	\N	40
1819	çœ‹æ³•	kĂ nfÇ	quan Ä‘iá»ƒm	\N	40
1820	æ‰›	kĂ¡ng	gĂ¡nh, vĂ¡c	\N	28
1822	æ…·æ…¨æ¿€æ˜‚	kÄngkÇi jÄ«â€™Ă¡ng	kháº£ng khĂ¡i, hĂ¹ng há»“n	\N	34
1823	çœ‹è§	kĂ njiĂ n	nhĂ¬n tháº¥y	\N	40
1824	å‹˜æ¢	kÄntĂ n	kháº£o sĂ¡t, trinh sĂ¡t	\N	34
1825	çœ‹æœ›	kĂ nwĂ ng	váº¥n an, thÄƒm há»i	\N	34
1826	åˆç‰©	kÄnwĂ¹	sĂ¡ch bĂ¡o, áº¥n pháº©m	\N	34
1829	è€ƒè™‘	kÇolÇœ	suy nghÄ©, cĂ¢n nháº¯c	\N	31
1830	è€ƒè¯•	kÇoshĂ¬	thi cá»­	\N	32
1831	çƒ¤é¸­	kÇoyÄ	vá»‹t nÆ°á»›ng	\N	34
1832	è€ƒéªŒ	kÇoyĂ n	kháº£o nghiá»‡m, thá»­ thĂ¡ch	\N	30
1833	å¡é€	kÇtÅng	hoáº¡t hĂ¬nh	\N	34
1834	å…‹	kĂ¨	gram	\N	34
1835	æ¸´	kÄ›	khĂ¡t	\N	30
1836	è¯¾	kĂ¨	mĂ´n, bĂ i	\N	34
1838	å®¢	kĂ¨	khĂ¡ch	\N	30
1849	åˆ»è‹¦	kĂ¨kÇ”	chá»‹u khĂ³, cáº§n cĂ¹	\N	34
1850	æ®¼ï¼ˆå£³ï¼‰	kĂ©	vá» (váº­t)	\N	34
1851	å’³å—½	kĂ©sou	ho	\N	34
1852	å·åƒ	kÄ›lÄ	Ä‘áº¥t vĂ³n cá»¥c (náº¿u cĂ³)	\N	34
1853	æªå®ˆ	kĂ¨shÇ’u	tuĂ¢n thá»§ nghiĂªm (náº¿u cĂ³)	\N	40
1858	ç£•	kÄ“	gĂµ, Ä‘áº­p	\N	34
1859	å¯çˆ±	kÄ›â€™Ă i	Ä‘Ă¡ng yĂªu, dá»… thÆ°Æ¡ng	\N	40
1860	åˆ»ä¸å®¹ç¼“	kĂ¨bĂ¹rĂ³nghuÇn	cáº¥p bĂ¡ch, vĂ´ cĂ¹ng kháº©n cáº¥p	\N	34
1843	å¯é 	kÄ›kĂ o	Ä‘Ă¡ng tin cáº­y	\N	25
1881	å£æ°”	kÇ’uqĂ¬	kháº©u khĂ­, giá»ng nĂ³i	\N	30
1902	æ‹¦	lĂ¡n	ngÄƒn cáº£n, cháº·n	\N	24
1909	è€	lÇo	giĂ 	\N	37
1937	æ ç›®	lĂ¡nmĂ¹	chuyĂªn má»¥c	\N	27
1951	ç´¯	lĂ¨i	má»‡t	\N	22
1960	ç¤¼æ‹œ	lÇbĂ i	lá»…, tuáº§n lá»…	\N	36
1844	å¯å£	kÄ›kÇ’u	ngon miá»‡ng, vá»«a miá»‡ng	\N	34
1845	å¯èƒ½	kÄ›nĂ©ng	cĂ³ thá»ƒ, cĂ³ láº½	\N	34
1846	å¯æ€•	kÄ›pĂ 	Ä‘Ă¡ng sá»£	\N	34
1847	å¯æ€œ	kÄ›liĂ¡n	Ä‘Ă¡ng thÆ°Æ¡ng	\N	34
1861	å…‹æœ	kĂ¨fĂº	vÆ°á»£t qua, kháº¯c phá»¥c	\N	34
1862	å®¢æˆ·	kĂ¨hĂ¹	khĂ¡ch hĂ ng	\N	38
1864	ç§‘ç›®	kÄ“mĂ¹	khoa, mĂ´n, mĂ´n há»c	\N	34
1865	è‚¯	kÄ›n	gáº·m, ria	\N	34
1866	è‚¯å®	kÄ›ndĂ¬ng	kháº³ng Ä‘á»‹nh	\N	30
1867	å‘	kÄ“ng	há»‘, lá»—	\N	34
1868	æ³åˆ‡	kÄ›nqiĂ¨	tha thiáº¿t, kháº©n thiáº¿t	\N	40
1869	å®¢äºº	kĂ¨rĂ©n	khĂ¡ch	\N	30
1870	å¯æƒœ	kÄ›xÄ«	Ä‘Ă¡ng tiáº¿c	\N	40
1872	ç§‘å­¦	kÄ“xuĂ©	khoa há»c	\N	34
1873	å¯ä»¥	kÄ›yÇ	cĂ³ thá»ƒ	\N	34
1874	å­”	kÇ’ng	lá»—	\N	34
1875	ææ€•	kÇ’ngpĂ 	e ráº±ng, sá»£ ráº±ng	\N	34
1876	ææ€–	kÇ’ngbĂ¹	khá»§ng bá»‘	\N	34
1877	æ§åˆ¶	kĂ²ngzhĂ¬	kiá»ƒm soĂ¡t, khá»‘ng cháº¿	\N	34
1878	ç©º	kÅng	rá»—ng, trá»‘ng	\N	34
1879	ç©ºæ°”	kÅngqĂ¬	khĂ´ng khĂ­	\N	34
1880	å£	kÇ’u	miá»‡ng, kháº©u	\N	24
1882	å£è¯­	kÇ’uyÇ”	kháº©u ngá»¯, tiáº¿ng nĂ³i	\N	34
1883	å“­	kÅ«	khĂ³c	\N	34
1884	è‹¦	kÇ”	khá»•, Ä‘áº¯ng	\N	34
1886	è·¨	kuĂ 	bÆ°á»›c dĂ i, xoĂ i bÆ°á»›c	\N	34
1887	å¿«	kuĂ i	nhanh	\N	34
1888	å¿«ä¹	kuĂ ilĂ¨	vui váº», sung sÆ°á»›ng	\N	34
1889	ç­·å­	kuĂ izi	Ä‘Å©a	\N	40
1890	å®½	kuÄn	rá»™ng, khoan dung	\N	34
1891	æ¬¾å¾…	kuÇndĂ i	khoáº£n Ä‘Ă£i, chiĂªu Ä‘Ă£i	\N	34
1892	æ¡†æ¶	kuĂ ngjiĂ 	khung, sÆ°á»n, dĂ n giĂ¡o	\N	34
1893	çŸ¿æ³‰æ°´	kuĂ ngquĂ¡nshuÇ	nÆ°á»›c khoĂ¡ng	\N	34
1894	å†µä¸”	kuĂ ngqiÄ›	váº£ láº¡i, hÆ¡n ná»¯a	\N	34
1896	å›°é¾	kĂ¹nnĂ¡n	khĂ³ khÄƒn, trá»Ÿ ngáº¡i	\N	34
1897	æ‰©å¤§	kuĂ²dĂ 	má»Ÿ rá»™ng, khuáº¿ch trÆ°Æ¡ng	\N	34
1898	æ‰©å……	kuĂ²chÅng	khuáº¿ch tĂ¡n, lan rá»™ng	\N	34
1899	æ‰©å±•	kuĂ²zhÇn	phĂ¡t triá»ƒn, má»Ÿ rá»™ng	\N	34
1900	æ‹‰	lÄ	kĂ©o	\N	34
1901	è¾£æ¤’	lĂ jiÄo	á»›t	\N	34
1903	è“	lĂ¡n	xanh lam	\N	34
1904	çƒ‚	lĂ n	nĂ¡t, thá»‘i rá»¯a	\N	40
1905	æ‡’	lÇn	lÆ°á»i biáº¿ng	\N	34
1906	ç‹¼	lĂ¡ng	chĂ³ sĂ³i	\N	34
1907	æµªè´¹	lĂ ngfĂ¨i	lĂ£ng phĂ­	\N	21
1908	æµªæ¼«	lĂ ngmĂ n	lĂ£ng máº¡n	\N	21
1911	è€ç™¾å§“	lÇobÇixĂ¬ng	dĂ¢n thÆ°á»ng	\N	34
1912	è€å¸ˆ	lÇoshÄ«	giĂ¡o viĂªn	\N	34
1913	è€é¼ 	lÇoshÇ”	chuá»™t	\N	34
1914	å®½æ•	kuÄnchÇng	rá»™ng lá»›n	\N	34
1915	å®½å¸¦	kuÄndĂ i	bÄƒng thĂ´ng rá»™ng	\N	34
1916	æ½°	kuĂ¬	há»§y hoáº¡i	\N	34
1917	è‹¦æ¼	kÇ”nÇo	Ä‘au khá»•, khá»• nĂ£o	\N	34
1918	è‹¦æ¶©	kÇ”sĂ¨	Ä‘áº¯ng chĂ¡t	\N	31
1920	åº“	kĂ¹	kho	\N	34
1921	è£¤å­	kĂ¹zi	quáº§n	\N	27
1922	å—	kuĂ i	miáº¿ng, viĂªn, bĂ¡nh	\N	34
1923	æ†	kÇ”n	bĂ³, buá»™c	\N	34
1924	æ†ç»‘	kÇ”nbÇng	trĂ³i, buá»™c, rĂ ng buá»™c	\N	34
1925	å›°è™«	kĂ¹nchĂ³ng	cĂ´n trĂ¹ng	\N	34
1926	æ‰©	kuĂ²	má»Ÿ rá»™ng	\N	34
1927	æ‰©å¼ 	kuĂ²zhÄng	má»Ÿ rá»™ng, bĂ nh trÆ°á»›ng	\N	40
1928	æ¥	lĂ¡i	Ä‘áº¿n, tá»›i	\N	34
1929	æ¥ä¸å	lĂ¡ibĂ¹jĂ­	khĂ´ng ká»‹p	\N	34
1930	æ¥å¾—å	lĂ¡idĂ©jĂ­	ká»‹p thá»i	\N	35
1931	æ¥å†	lĂ¡ilĂ¬	lai lá»‹ch, nguá»“n gá»‘c	\N	34
1932	æ¥æº	lĂ¡iyuĂ¡n	nguá»“n gá»‘c	\N	34
1933	æ¥è‡ª	lĂ¡izĂ¬	Ä‘áº¿n tá»«	\N	40
1935	ç‹¼ç‹ˆ	lĂ¡ngbĂ¨i	nháº¿ch nhĂ¡c, cháº³ng ra lĂ m sao cáº£	\N	34
1936	æœ—è¯»	lÇngdĂº	Ä‘á»c to, Ä‘á»c diá»…n cáº£m	\N	34
1938	å³å¨	lĂ¡odĂ²ng	lao Ä‘á»™ng	\N	34
1939	è€è™	lÇohÇ”	con há»•	\N	34
1940	è€å®	lÇoshĂ­	tháº­t thĂ 	\N	30
1941	è€å©†	lÇopĂ³	vá»£	\N	34
1943	è€å©†å¿ƒ	lÇopoxÄ«n	lĂ²ng nhĂ¢n tá»«	\N	34
1944	è€äºº	lÇorĂ©n	ngÆ°á»i giĂ 	\N	34
1945	èœ¡çƒ›	lĂ zhĂº	cĂ¢y náº¿n, náº¿n	\N	40
1946	å‹’	lÄ“i	buá»™c, trĂ³i	\N	34
1947	äº†	le	rá»“i	\N	35
1948	ä¹è§‚	lĂ¨guÄn	láº¡c quan	\N	31
1949	é›·	lĂ©i	sáº¥m	\N	34
1950	ç±»	lĂ¨i	loáº¡i, thá»ƒ loáº¡i	\N	34
1952	é›·è¾¾	lĂ©idĂ¡	radar	\N	40
1953	ç±»ä¼¼	lĂ¨isĂ¬	na nĂ¡, tÆ°Æ¡ng tá»±, giá»‘ng	\N	34
1954	å†·	lÄ›ng	láº¡nh	\N	34
1955	å†·æ·¡	lÄ›ngdĂ n	láº¡nh nháº¡t, lĂ£nh Ä‘áº¡m	\N	34
1956	å†·é™	lÄ›ngjĂ¬ng	váº¯ng váº», yĂªn tÄ©nh	\N	34
1958	é‡Œ	lÇ	trong	\N	34
1959	é‡Œè¾¹	lÇbiÄn	bĂªn trong	\N	34
1961	ç¤¼è‚	lÇjiĂ©	lá»… nghi, phĂ©p lá»‹ch sá»±	\N	36
1962	ç¤¼è²Œ	lÇmĂ o	lá»… phĂ©p	\N	34
1981	ä½“è°…	tÇliĂ n	rĂ¨n luyá»‡n	\N	34
2031	ç†æ™º	lÇzhĂ¬	lĂ½ trĂ­	\N	38
1979	è¿å¹´	liĂ¡nniĂ¡n	liĂªn tá»¥c nhiá»u nÄƒm	\N	40
2008	ç«‹ä½“	lĂ¬tÇ	láº­p thá»ƒ	\N	37
1963	ç¤¼ç‰©	lÇwĂ¹	quĂ , lá»… váº­t	\N	40
2052	è®ºæ–‡	lĂ¹nwĂ©n	luáº­n vÄƒn	\N	33
2055	è½å	luĂ²hĂ²u	láº¡c háº­u, rÆ¡i láº¡i phĂ­a sau	\N	24
2057	è½å®	luĂ²shĂ­	Ä‘áº§y Ä‘á»§ chu Ä‘Ă¡o, lĂ m cho cháº¯c cháº¯n	\N	40
1964	ç¤¼å ‚	lÇtĂ¡ng	lá»… Ä‘Æ°á»ng	\N	34
1965	ç«‹åœº	lĂ¬chÇng	láº­p trÆ°á»ng	\N	34
1966	ç«‹æ–¹	lĂ¬fÄng	hĂ¬nh láº­p phÆ°Æ¡ng	\N	34
1967	åˆ©å®³	lĂ¬hĂ i	lá»£i háº¡i, ghĂª gá»›m	\N	34
1968	ç«‹å³	lĂ¬jĂ­	ngay láº­p tá»©c	\N	30
1969	åˆ©ç›	lĂ¬yĂ¬	lá»£i Ă­ch	\N	34
1971	ç«‹åˆ»	lĂ¬kĂ¨	ngay láº­p tá»©c	\N	30
1972	ç²®é£Ÿ	liĂ¡ngshi	thá»©c Äƒn	\N	30
1973	è‰¯å¿ƒ	liĂ¡ngxÄ«n	lÆ°Æ¡ng tĂ¢m	\N	34
1974	è”åˆ	liĂ¡nhĂ©	liĂªn hiá»‡p	\N	34
1975	è”æ¬¢	liĂ¡nhuÄn	liĂªn hoan	\N	34
1976	å»‰æ´	liĂ¡njiĂ©	trong sáº¡ch, liĂªm khiáº¿t	\N	34
1977	è”ç³»	liĂ¡nluĂ²	liĂªn láº¡c, liĂªn há»‡	\N	40
1978	è”ç›Ÿ	liĂ¡nmĂ©ng	liĂªn minh	\N	40
1980	è¿é”	liĂ¡nsuÇ’	dĂ¢y chuyá»n, mĂ³c ná»‘i	\N	40
1982	é¢†ä¼	liÇngkuai	mĂ¡t máº»	\N	34
1984	è¿ç³»	liĂ¡nxĂ¬	liĂªn há»‡	\N	40
1985	ç»ƒä¹ 	liĂ nxĂ­	luyá»‡n táº­p	\N	34
1986	ç»ƒåŸ	liĂ ngtĂ³ng	luyá»‡n cĂ´ng, rĂ¨n luyá»‡n	\N	34
1987	è¿ç»­å‰§	liĂ¡nxĂ¹jĂ¹	phim nhiá»u táº­p	\N	40
1988	äº†è§£	liÇojiÄ›	hiá»ƒu rĂµ, biáº¿t rĂµ	\N	35
1989	äº†ä¸èµ·	liÇobuqÇ	tĂ i ba, giá»i láº¯m	\N	35
1991	æ–™	liĂ o	nguyĂªn liá»‡u	\N	40
1992	æ–™ç†	liĂ olÇ	náº¥u Äƒn, quáº£n lĂ½	\N	40
1993	åˆ—è½¦	liĂ¨chÄ“	xe lá»­a, tĂ u há»a	\N	28
1994	çƒˆå£«	liĂ¨shĂ¬	liá»‡t sÄ©	\N	40
1996	çƒˆç„°	liĂ¨yĂ n	ngá»n lá»­a dá»¯	\N	34
1997	å›æ°”	lĂ¬qi	sá»©c lá»±c	\N	30
1998	é¢†åŸŸ	lÇngyĂ¹	lÄ©nh vá»±c	\N	40
1999	é‚»å±…	lĂ­njÅ«	hĂ ng xĂ³m	\N	34
2000	æ·‹æµ´	lĂ­nyĂ¹	táº¯m vĂ²i	\N	34
2001	ä¸´æ—¶	lĂ­nshĂ­	táº¡m thá»i	\N	34
2003	ä¾‹å¦‚	lĂ¬rĂº	vĂ­ dá»¥	\N	40
2004	åˆ©æ¶¦	lĂ¬rĂ¹n	lá»£i nhuáº­n	\N	34
2005	å†å²	lĂ¬shÇ	lá»‹ch sá»­	\N	36
2006	ç†æ‰€å½“ç„¶	lÇsuÇ’dÄngrĂ¡n	táº¥t nhiĂªn	\N	35
2009	å›å›¾	lĂ¬tĂº	mÆ°u cáº§u, gáº¯ng Ä‘áº¡t Ä‘Æ°á»£c	\N	24
2010	ç•™	liĂº	á»Ÿ láº¡i, lÆ°u láº¡i, giá»¯ láº¡i	\N	34
2011	æµ	liĂº	cháº£y	\N	40
2012	æ»‘	huĂ¡	trÆ°á»£t	\N	34
2013	æµä¼ 	liĂºchuĂ¡n	lÆ°u truyá»n	\N	34
2014	æµè§ˆ	liĂºlÇn	xem lÆ°á»›t qua	\N	34
2015	æµæµª	liĂºlĂ ng	lang thang, lÆ°u láº¡c	\N	30
2016	æµæ³ª	liĂºlĂ¨i	cháº£y nÆ°á»›c máº¯t	\N	34
2017	æµé‡	liĂºliĂ ng	lÆ°u lÆ°á»£ng	\N	34
2018	ç•™æ‹	liĂºliĂ n	lÆ°u luyáº¿n, khĂ´ng muá»‘n rá»i xa	\N	34
2019	æµéœ²	liĂºlĂ¹	bá»™c lá»™, thá»• lá»™	\N	34
2020	æµæ°“	liĂºmĂ¡ng	lÆ°u manh	\N	34
2022	ç•™æ„	liĂºyĂ¬	lÆ°u Ă½, Ä‘á»ƒ Ă½ cáº©n tháº­n	\N	30
2023	æµé€	liĂºtÅng	lÆ°u thĂ´ng, thoĂ¡ng, khĂ´ng bĂ­	\N	34
2024	æµè¡Œ	liĂºxĂ­ng	thá»‹nh hĂ nh, lÆ°u hĂ nh	\N	30
2025	ç•™å­¦	liĂºxuĂ©	du há»c	\N	34
2026	ä¾‹å¤–	lĂ¬wĂ i	ngoáº¡i lá»‡	\N	34
2027	ç†æƒ³	lÇxiÇng	lĂ½ tÆ°á»Ÿng	\N	34
2028	åˆ©æ¯	lĂ¬xÄ«	lĂ£i, lá»£i tá»©c	\N	34
2029	åˆ©ç”¨	lĂ¬yĂ²ng	lá»£i dá»¥ng	\N	34
2030	ç†ç”±	lÇyĂ³u	lĂ½ do	\N	34
2033	ç«‹è¶³	lĂ¬zĂº	Ä‘á»©ng chĂ¢n, chá»— dá»±a, chá»— Ä‘á»©ng	\N	34
2034	é¾™	lĂ³ng	con rá»“ng	\N	34
2035	è‹å“‘	lĂ³ng yÇ	ngÆ°á»i cĂ¢m Ä‘iáº¿c	\N	34
2036	å„æ–­	lÇ’ngduĂ n	lÅ©ng Ä‘oáº¡n, Ä‘á»™c quyá»n	\N	34
2037	é†é‡	lĂ³ngzhĂ²ng	long trá»ng, linh Ä‘Ă¬nh	\N	34
2038	æ¼	lĂ²u	rĂ² rá»‰	\N	34
2039	æ‚	lÇ’u	Ă´m	\N	34
2040	æ¥¼	lĂ³u	láº§u, táº§ng	\N	24
2041	éœ²	lĂ¹	sÆ°Æ¡ng	\N	34
2042	ç»¿	lÇœ	xanh	\N	34
2043	é™†ç»­	lĂ¹xĂ¹	láº§n lÆ°á»£t	\N	34
2044	ä¹±	luĂ n	lá»™n xá»™n, bá»«a bĂ£i	\N	34
2045	å±¡æ¬¡	lÇcĂ¬	nhiá»u láº§n, liĂªn tiáº¿p	\N	34
2046	æ å¤º	lĂ¼Ă¨duĂ³	cÆ°á»›p Ä‘oáº¡t	\N	34
2047	ç•¥å¾®	lĂ¼Ă¨wÄ“i	hÆ¡i	\N	34
2049	è½®å»“	lĂºnkuĂ²	Ä‘Æ°á»ng viá»n	\N	34
2050	è½®æµ	lĂºnliĂº	thay phiĂªn nhau	\N	40
2051	è®ºå›	lĂ¹ntĂ¡n	diá»…n Ä‘Ă n	\N	40
2053	è®ºè¯	lĂ¹nzhĂ¨ng	luáº­n chá»©ng, chá»©ng minh	\N	40
2054	è½æˆ	luĂ²chĂ©ng	hoĂ n thĂ nh, khĂ¡nh thĂ nh	\N	40
2056	é€»è¾‘	luĂ³jĂ­	logic	\N	34
2058	èºä¸é’‰	luĂ³sÄ«dÄ«ng	Ä‘inh á»‘c	\N	34
2059	å•°å—¦	luÅsuo	láº¯m lá»i	\N	34
2061	å½•å–	lĂ¹qÇ”	tuyá»ƒn chá»n, nháº­n vĂ o	\N	40
2062	å¾‹å¸ˆ	lÇœshÄ«	luáº­t sÆ°	\N	40
2063	æ—…è¡Œ	lÇxĂ­ng	thá»±c hiá»‡n, thá»±c thi	\N	40
2064	å½•éŸ³	lĂ¹yÄ«n	ghi Ă¢m	\N	34
2065	æ—…æ¸¸	lÇyĂ³u	du lá»‹ch	\N	31
2066	ç‚‰ç¶	lĂºzĂ o	báº¿p lĂ²	\N	34
2067	å—	ma	Ă , Æ°	\N	35
2069	é©¬	mÇ	ngá»±a	\N	25
2081	å¦ˆå¦ˆ	mÄma	máº¹	\N	22
2082	éº»æœ¨	mĂ¡mĂ¹	tĂª	\N	36
2093	æ…¢æ€§	mĂ nxĂ¬ng	mĂ£n tĂ­nh	\N	31
2106	ç å¤´	mÇtĂ³u	báº¿n tĂ u	\N	28
2124	è°œè¯­	mĂ­yÇ”	cĂ¢u Ä‘á»‘	\N	33
2070	éº»	mĂ¡	gai, tĂª	\N	40
2072	éº»çƒ¦	mĂ¡fan	lĂ m phiá»n, phiá»n hĂ 	\N	40
2073	é©¬è™	mÇhu	qua loa, Ä‘áº¡i khĂ¡i, táº¡m táº¡m	\N	34
2074	å–	mĂ i	bĂ¡n	\N	40
2075	è¿ˆ	mĂ i	Ä‘i bÆ°á»›c dĂ i	\N	34
2076	ä¹°	mÇi	mua	\N	40
2077	è„‰æ	mĂ ibĂ³	máº¡ch	\N	21
2078	åŸ‹ä¼	mĂ¡ifĂº	mai phá»¥c	\N	40
2079	éº¦å…‹é£	mĂ ikĂ¨fÄ“ng	microphone	\N	34
2083	æ…¢	mĂ n	cháº­m, tá»« tá»«	\N	34
2084	æ»¡	mÇn	Ä‘áº§y, cháº¥t	\N	40
2085	æ¼«é•¿	mĂ nchĂ¡ng	dĂ i dáº±ng dáº·c, dĂ i Ä‘áº±ng Ä‘áºµng	\N	34
2086	å¿™	mĂ¡ng	báº­n	\N	34
2087	å¿™ç¢Œ	mĂ¡nglĂ¹	báº­n rá»™n	\N	34
2088	èŒ«èŒ«	mĂ¡ngmĂ¡ng	mĂªnh mĂ´ng, má»‹t mĂ¹	\N	34
2089	ç›²ç›®	mĂ¡ngmĂ¹	mĂ¹ quĂ¡ng	\N	27
2091	æ¼«ç”»	mĂ nhuĂ 	hoáº¡t há»a	\N	34
2092	é¦’å¤´	mĂ¡ntou	mĂ n tháº§u, bĂ¡nh bao khĂ´ng nhĂ¢n	\N	21
2094	è”“å»¶	mĂ nyĂ¡n	lan trĂ n, lan ra	\N	40
2095	æ»¡æ„	mÇnyĂ¬	hĂ i lĂ²ng	\N	34
2096	åŸ‹æ€¨	mĂ¡nyuĂ n	oĂ¡n trĂ¡ch, oĂ¡n háº­n	\N	34
2097	æ»¡è¶³	mÇnzĂº	thá»a mĂ£n, lĂ m thá»a mĂ£n	\N	34
2098	æ¯›	mĂ¡o	lĂ´ng	\N	34
2099	çŒ«	mÄo	mĂ¨o	\N	34
2101	çŸ›ç›¾	mĂ¡odĂ¹n	mĂ¢u thuáº«n	\N	30
2102	å†’é™©	mĂ oxiÇn	máº¡o hiá»ƒm, phiĂªu lÆ°u	\N	34
2103	è´¸æ˜“	mĂ oyĂ¬	buĂ´n bĂ¡n	\N	34
2104	å¸½å­	mĂ ozi	mÅ©	\N	27
2105	é©¬ä¸	mÇshĂ ng	ngay	\N	40
2107	éº»é†‰	mĂ¡zuĂ¬	gĂ¢y tĂª	\N	40
2108	æ	mĂ©i	cĂ¡i, táº¥m	\N	34
2109	æ²¡	mĂ©i	chÆ°a, khĂ´ng	\N	34
2110	æ¯	mÄ›i	má»—i	\N	34
2111	ç¾	mÄ›i	Ä‘áº¹p	\N	34
2113	ç¾æ»¡	mÄ›imÇn	cuá»™c sá»‘ng Ä‘áº§y Ä‘á»§, Ä‘áº§m áº¥m, má»¹ mĂ£n	\N	34
2114	çœ‰æ¯›	mĂ©imĂ¡o	lĂ´ng mĂ y	\N	34
2115	åª’ä½“	mĂ©itÇ	truyá»n thĂ´ng	\N	34
2116	ç¾å®¹	mÄ›irĂ³ng	lĂ m Ä‘áº¹p	\N	34
2117	ç¾æœ¯	mÄ›ishĂ¹	má»¹ thuáº­t	\N	30
2118	ç¾å‘³	mÄ›iwĂ¨i	ngon miá»‡ng	\N	34
2119	ç¾å…ƒ	mÄ›iyuĂ¡n	Ä‘Ă´ la Má»¹	\N	34
2120	å¦¹å¦¹	mĂ¨imei	em gĂ¡i	\N	40
2121	é­…å›	mĂ¨ilĂ¬	sá»©c quyáº¿n rÅ©	\N	34
2122	é—¨	mĂ©n	cá»­a	\N	40
2125	æ²¡è¾™	mĂ©izhĂ©	báº¿ táº¯c, chá»‹u	\N	40
2126	æ¢¦	mĂ¨ng	má»™ng, giáº¥c mÆ¡	\N	34
2127	çŒ›	mÄ›ng	dá»¯ dá»™i	\N	34
2128	çŒ›çƒˆ	mÄ›ngliĂ¨	dá»¯ dá»™i	\N	34
2129	æ¢¦æƒ³	mĂ¨ngxiÇng	giáº¥c mÆ¡	\N	34
2130	èŒè½	mĂ©ngyĂ¡	máº§m, chá»“i non	\N	34
2131	é—¨è¯	mĂ©nzhÄ›n	phĂ²ng khĂ¡m bá»‡nh	\N	34
2132	ç±³	mÇ	gáº¡o	\N	34
2133	çœ¯	mÄ«	chá»›p máº¯t	\N	34
2134	é¢å¯¹	miĂ n duĂ¬	Ä‘á»‘i máº·t	\N	34
2135	é¢åŒ…	miĂ nbÄo	bĂ¡nh mĂ¬	\N	26
2136	å…å¾—	miÇnde	Ä‘á»ƒ trĂ¡nh	\N	35
2138	æ£‰è±	miĂ¡nhuÄ	bĂ´ng	\N	34
2139	å‹‰å±	miÇnlĂ¬	khuyáº¿n khĂ­ch	\N	40
2140	é¢ä¸´	miĂ nlĂ­n	Ä‘á»‘i máº·t vá»›i	\N	34
2141	å‹‰å¼º	miÇnqiĂ¡ng	gÆ°á»£ng gáº¡o, miá»…n cÆ°á»¡ng	\N	34
2142	é¢æ¡	miĂ ntiĂ¡o	mĂ¬	\N	26
2143	é¢å­	miĂ nzi	máº·t	\N	34
2144	æå†™	miĂ¡oxiÄ›	miĂªu táº£	\N	40
2145	å¼¥è¡¥	mĂ­bÇ”	bĂ¹ Ä‘áº¯p, Ä‘á»n bĂ¹	\N	34
2146	å¯†åº¦	mĂ¬dĂ¹	Ä‘á»™ dĂ y, máº­t Ä‘á»™	\N	34
2147	è”‘è§†	miĂ¨shĂ¬	khinh miá»‡t	\N	40
2148	ç­äº¡	miĂ¨wĂ¡ng	cháº¿t	\N	40
2149	å¯†å°	mĂ¬fÄ“ng	niĂªm phong	\N	34
2151	è¿·æƒ‘	mĂ­huĂ²	mĂª hoáº·c	\N	34
2152	è¿·è·¯	mĂ­lĂ¹	láº¡c Ä‘Æ°á»ng	\N	34
2153	å¯†ç 	mĂ¬mÇ	máº­t mĂ£	\N	34
2154	è¿·èŒ«	mĂ­mĂ¡ng	mĂ¹ má»‹t, má» má»‹t	\N	34
2155	ç§˜å¯†	mĂ¬mĂ¬	bĂ­ máº­t	\N	34
2156	æ•æ„Ÿ	mÇngÇn	nháº¡y cáº£m	\N	40
2157	æ˜ç™½	mĂ­ngbai	rĂµ rĂ ng	\N	34
2158	åæ¬¡	mĂ­ngcĂ¬	thá»© tá»±	\N	30
2160	åå‰¯å…¶å®	mĂ­ngfĂ¹qĂ­shĂ­	Ä‘Ăºng sá»± tháº­t	\N	34
2161	å‘½ä»¤	mĂ¬nglĂ¬ng	má»‡nh lá»‡nh	\N	40
2162	æ˜æ˜	mĂ­ngmĂ­ng	rĂµ rĂ ng	\N	34
2163	å‘½å	mĂ¬ngmĂ­ng	Ä‘áº·t tĂªn	\N	40
2164	åç‰Œ	mĂ­ngpĂ¡i	thÆ°Æ¡ng hiá»‡u	\N	34
2165	æ˜æ˜¾	mĂ­ngxiÇn	rĂµ rĂ ng	\N	34
2166	æ˜ä¿¡ç‰‡	mĂ­ngxĂ¬npiĂ n	bÆ°u thiáº¿p	\N	34
2167	åèª‰	mĂ­ngyĂ¹	danh dá»±	\N	31
2168	åå­—	mĂ­ngzi	tĂªn	\N	34
2170	æ•æ·	mÇnjiĂ©	nhanh nháº¹n	\N	34
2171	æ•é”	mÇnruĂ¬	sáº¯c sáº£o	\N	34
2172	æ°‘ç”¨	mĂ­nyĂ²ng	dĂ¢n dá»¥ng	\N	40
2173	æ°‘ä¸»	mĂ­nzhÇ”	dĂ¢n chá»§	\N	31
2174	æ°‘æ—	mĂ­nzĂº	dĂ¢n tá»™c	\N	34
2175	å¯†åˆ‡	mĂ¬qiĂ¨	máº­t thiáº¿t	\N	40
2176	è¿·äºº	mĂ­rĂ©n	cuá»‘n hĂºt	\N	34
2178	ç§˜ä¹¦	mĂ¬shÅ«	thÆ° kĂ½	\N	30
2179	è¿·ä¿¡	mĂ­xĂ¬n	mĂª tĂ­n	\N	40
2233	æ	niÄ“	nhĂ³n, nháº·t, cáº§m	\N	34
2242	å¥³å£«	nÇshĂ¬	cĂ´, chá»‹, bĂ 	\N	34
2251	å“ªå„¿	nÇr	chá»— nĂ o, Ä‘Ă¢u	\N	24
2189	æ¨¡å¼	mĂ³shĂ¬	kiá»ƒu máº«u	\N	24
2236	ç‰›	niĂº	trĂ¢u, bĂ²	\N	26
2213	é¾çœ‹	nĂ¡nkĂ n	xáº¥u xĂ­	\N	24
2221	é¦	nÄ›i	náº£n chĂ­	\N	31
2225	èƒ½å¹²	nĂ©nggĂ n	tĂ i giá»i, giá»i giang	\N	30
2227	å¹´	niĂ¡n	nÄƒm	\N	30
2273	ç‰›ä»”è£¤	niĂºzÇikĂ¹	quáº§n jean	\N	27
2288	å‘•å	Ç’utĂ¹	nĂ´n má»­a	\N	30
2256	å«©	nĂ¨n	má»m, non	\N	22
2262	å¹´åº¦	niĂ¡ndĂ¹	nÄƒm	\N	30
2180	æ‘¸	mÅ	mĂ²	\N	34
2182	æ¨¡ä»¿	mĂ³fÇng	báº¯t chÆ°á»›c	\N	34
2183	é­”é¬¼	mĂ³guÇ	ma quá»·	\N	21
2184	ç£¨åˆ	mĂ³hĂ©	cháº¡y thá»­	\N	40
2185	æ¨¡ç³	mĂ³hu	má», mÆ¡ há»“	\N	34
2187	é»˜é»˜	mĂ²mĂ²	Ă¢m tháº§m	\N	34
2188	é™Œç”Ÿ	mĂ²shÄ“ng	láº¡	\N	32
2247	æ´¾	pĂ i	phĂ¡i, cá»­, Ä‘Ă¡t cá»­	\N	40
2190	ç‰§å¸ˆ	mĂ¹shÄ«	má»¥c sÆ°	\N	32
2192	æ¨¡å‹	mĂ³xĂ­ng	mĂ´ hĂ¬nh	\N	34
2193	ç›®æ ‡	mĂ¹biÄo	má»¥c tiĂªu	\N	40
2194	ç›®ç„	mĂ¹dĂ¬	má»¥c Ä‘Ă­ch	\N	35
2195	ç›®å…‰	mĂ¹guÄng	Ă¡nh máº¯t	\N	34
2196	ç›®å½•	mĂ¹lĂ¹	má»¥c lá»¥c	\N	27
2197	æ¯äº²	mÇ”qÄ«n	máº¹	\N	22
2199	æ¨¡æ ·	mĂºyĂ ng	dĂ¡ng dáº¥p	\N	33
2200	æ²æµ´	mĂ¹yĂ¹	táº¯m gá»™i	\N	34
2201	æ‹¿	nĂ¡	cáº§m, láº¥y	\N	40
2202	é‚£	nĂ 	kia, Ä‘Ă³	\N	34
2203	å¥¶å¥¶	nÇinai	bĂ 	\N	21
2205	è€ç”¨	nĂ iyĂ²ng	bá»n	\N	40
2206	çº³é—·å„¿	nĂ mĂ¨n er	bá»‘i rá»‘i	\N	40
2207	å—	nĂ¡n	phĂ­a nam	\N	40
2208	é¾	nĂ¡n	khĂ³	\N	34
2209	é¾é“	nĂ¡ndĂ o	láº½ nĂ o	\N	34
2210	é¾å¾—	nĂ¡ndĂ©	khĂ³ cĂ³ Ä‘Æ°á»£c	\N	35
2211	é¾æ€ª	nĂ¡nguĂ i	tháº£o nĂ o	\N	34
2283	å¥³äºº	nÇrĂ©n	con gĂ¡i, phá»¥ ná»¯	\N	22
2214	é¾å…	nĂ¡nmiÇn	khĂ´ng trĂ¡nh khá»i	\N	34
2215	é¾èƒ½å¯è´µ	nĂ¡nnĂ©ngkÄ›guĂ¬	Ä‘Ă¡ng khen ngá»£i	\N	34
2216	ç”·äºº	nĂ¡nrĂ©n	Ä‘Ă n Ă´ng	\N	34
2217	é¾å—	nĂ¡nshĂ²u	khĂ³ chá»‹u	\N	34
2218	è„‘è¢‹	nÇodai	Ä‘áº§u	\N	24
2220	å‘¢	ne	tháº¿, nhá»‰, váº­y, nhĂ©, cÆ¡	\N	35
2249	ç›˜å­	pĂ¡nzi	Ä‘Ä©a, mĂ¢m, khay	\N	34
2222	å†…	nĂ¨i	bĂªn trong, ná»™i	\N	34
2223	å†…å®¹	nĂ¨irĂ³ng	ná»™i dung	\N	34
2224	å†…ç§‘	nĂ¨ikÄ“	ná»™i khoa	\N	34
2226	èƒ½å›	nĂ©nglĂ¬	nÄƒng lá»±c	\N	34
2228	å¹´çº§	niĂ¡njĂ­	lá»›p	\N	34
2229	å¹´çºª	niĂ¡njĂ¬	tuá»•i tĂ¡c	\N	34
2231	å¿µ	niĂ n	nhá»›, suy nghÄ©, Ä‘á»c	\N	34
2232	é¸Ÿ	niÇo	chim	\N	25
2234	å®å¯	nĂ­ngkÄ›	thĂ  ráº±ng	\N	30
2235	å®æ„¿	nĂ­ngyuĂ n	thĂ , thĂ  ráº±ng	\N	30
2237	å†œæ°‘	nĂ³ngmĂ­n	nĂ´ng dĂ¢n	\N	34
2239	æµ“	nĂ³ng	Ä‘áº·c, Ä‘áº­m	\N	34
2240	æ–å’Œ	nuÇnhuo	áº¥m Ă¡p	\N	35
2241	å¥³å„¿	nÇâ€™Ă©r	con gĂ¡i	\N	34
2243	æ€•	pĂ 	sá»£	\N	34
2244	æ‹	pÄi	vá»—, Ä‘áº­p	\N	34
2245	æ’	pĂ¡i	hĂ ng, xáº¿p	\N	34
2246	ç‰Œ	pĂ¡i	tháº», báº£ng	\N	34
2250	åˆ¤æ–­	pĂ nduĂ n	phĂ¡n Ä‘oĂ¡n	\N	34
2252	æ‹¿æ‰‹	nĂ¡shÇ’u	sá»Ÿ trÆ°á»ng, tĂ i nÄƒng	\N	34
2253	å†…æ¶µ	nĂ¨ihĂ¡n	ná»™i hĂ m	\N	34
2254	å†…å¹•	nĂ¨imĂ¹	ná»™i tĂ¬nh, tĂ¬nh hĂ¬nh bĂªn trong	\N	34
2255	å†…åœ¨	nĂ¨izĂ i	bĂªn trong, ná»™i táº¡i	\N	34
2257	èƒ½	nĂ©ng	cĂ³ thá»ƒ	\N	34
2259	èƒ½æº	nĂ©ngyuĂ¡n	nguá»“n nÄƒng lÆ°á»£ng	\N	34
2260	ä½ 	nÇ	anh, chá»‹, Ă´ng, bĂ â€¦	\N	34
2261	å¹´ä»£	niĂ¡ndĂ i	niĂªn Ä‘áº¡i, thá»i Ä‘áº¡i	\N	34
2263	å¹´è½»	niĂ¡nqÄ«ng	tráº»	\N	30
2264	æ‹Ÿå®	nÇdĂ¬ng	Ä‘á»‹nh ra, váº¡ch ra	\N	40
2265	æ‚¨	nĂ­n	ngĂ i, Ă´ng	\N	34
2266	å®	nĂ­ng	yĂªn, tÄ©nh	\N	40
2268	å‡ç»“	nĂ­ngjiĂ©	ngÆ°ng tá»¥, Ä‘Ă´ng láº¡i	\N	34
2269	å‡è§†	nĂ­ngshĂ¬	nhĂ¬n chĂ²ng chá»c	\N	34
2270	å®é™	nĂ­ngjĂ¬ng	yĂªn tÄ©nh, bĂ¬nh láº·ng	\N	40
2271	çº½æ‰£å„¿	niÇ”kĂ²ur	cĂºc Ă¡o	\N	34
2272	ç‰›å¥¶	niĂºnÇi	sá»¯a bĂ²	\N	34
2274	æ‰­è½¬	niÇ”zhuÇn	xoay, quay	\N	34
2275	å¼„	nĂ²ng	lĂ m	\N	40
2276	å†œæ‘	nĂ³ngcÅ«n	nĂ´ng thĂ´n	\N	34
2277	å†œå¤«	nĂ³ngfÅ«	nĂ´ng dĂ¢n	\N	34
2278	å†œå†	nĂ³nglĂ¬	Ă¢m lá»‹ch	\N	34
2280	å¥´é¶	nĂºlĂ¬	nĂ´ lá»‡	\N	34
2281	åªå›	nÇ”lĂ¬	cá»‘ gáº¯ng, ná»— lá»±c	\N	34
2282	æŒª	nuĂ³	di chuyá»ƒn	\N	40
2284	å“¦	Ă³	há»«, háº£	\N	30
2285	æ¬§æ‰“	ÅudÇ	Ä‘Ă¡nh nhau	\N	24
2286	å¶å°”	Ç’uâ€™Ä›r	thá»‰nh thoáº£ng, ngáº«u nhiĂªn	\N	34
2287	å¶ç„¶	Ç’urĂ¡n	tĂ¬nh cá», ngáº«u nhiĂªn	\N	34
2290	æ´¾å¯¹	pĂ iduĂ¬	tiá»‡c	\N	40
2291	æ’æ”¾	pĂ¡ifĂ ng	tháº£i ra	\N	40
2292	æ’æ–¥	pĂ¡ichĂ¬	bĂ i xĂ­ch, bĂ i bĂ¡c	\N	21
2293	æ’é™¤	pĂ¡ichĂº	loáº¡i trá»«	\N	34
2304	ç›˜æ—‹	pĂ¡nxuĂ¡n	quanh quáº©n, luáº©n quáº©n	\N	27
2315	ç›†	pĂ©n	cháº­u, bá»“n	\N	24
2321	æœ‹å‹	pĂ©ngyÇ’u	báº¡n, báº¡n bĂ¨	\N	22
2322	åŒ¹	pÇ	con (ngá»±a, la...)	\N	25
2341	å¹³ç­‰	pĂ­ngdÄ›ng	bĂ¬nh Ä‘áº³ng	\N	31
2347	è¯„ä¼°	pĂ­nggÅ«	Ä‘Ă¡nh giĂ¡	\N	37
2361	å“è¡Œ	pÇnxĂ­ng	háº¡nh kiá»ƒm	\N	22
2366	ç®é‹	pĂ­xiĂ©	giĂ y da	\N	27
2398	é“…ç¬”	qiÄnbÇ	bĂºt chĂ¬	\N	22
2295	æ’åˆ—	pĂ¡iliĂ¨	sáº¯p xáº¿p, sáº¯p Ä‘áº·t	\N	40
2296	æ´¾é£	pĂ iqiÇn	cá»­, phĂ¡i, Ä‘iá»u Ä‘á»™ng	\N	34
2297	æ´¾çƒ	pĂ¡iqiĂº	bĂ³ng chuyá»n	\N	34
2298	ç›˜	pĂ¡n	Ä‘Ä©a, mĂ¢m, khay	\N	34
2299	èƒ–	pĂ ng	bĂ©o	\N	34
2300	ç›¼æœ›	pĂ nwĂ ng	mong má»i, trĂ´ng chá»	\N	34
2301	åˆ¤	pĂ n	phĂ¡n quyáº¿t, káº¿t Ă¡n	\N	30
2303	åºå¤§	pĂ¡ngdĂ 	to lá»›n	\N	34
2305	è·‘	pÇo	cháº¡y	\N	40
2306	è·‘æ­¥	pÇobĂ¹	cháº¡y bá»™	\N	40
2307	æ›å¼ƒ	pÄoqĂ¬	vá»©t bá», quÄƒng Ä‘i	\N	40
2308	çˆ¬å±±	pĂ¡shÄn	leo nĂºi	\N	40
2309	é™ª	pĂ©i	dáº«n dáº¯t, cĂ¹ng Ä‘Æ°a	\N	40
2310	é…å¤‡	pĂ¨ibĂ¨i	phĂ¢n phá»‘i	\N	34
2312	é…å¥—	pĂ¨itĂ o	Ä‘á»“ng bá»™	\N	34
2313	åŸ¹è®­	pĂ©ixĂ¹n	bá»“i dÆ°á»¡ng, Ä‘Ă o táº¡o	\N	34
2314	åŸ¹å…»	pĂ©iyÇng	rĂ¨n luyá»‡n, bá»“i dÆ°á»¡ng	\N	34
2316	ç›†åœ°	pĂ©ndĂ¬	thung lÅ©ng, lĂ²ng cháº£o	\N	35
2317	è†¨èƒ€	pĂ©ngzhĂ ng	bĂ nh trÆ°á»›ng, phĂ¬nh to	\N	34
2318	ç¢°	pĂ¨ng	Ä‘á»¥ng, va	\N	34
2319	ç¢°è§	pĂ¨ngjiĂ n	gáº·p	\N	28
2320	çƒ¹é¥ª	pÄ“ngrĂ¨n	náº¥u Äƒn	\N	24
2323	æ‰¹	pÄ«	bĂ³, cháº»	\N	34
2324	æ‰¹å‘	pÄ«fÄ	bĂ¡n sá»‰	\N	40
2326	æ‰¹å‡†	pÄ«zhÇ”n	phĂª chuáº©n	\N	40
2327	ç–²æƒ«	pĂ­bĂ¨i	kiá»‡t quá»‡	\N	40
2328	ç®	pĂ­	da	\N	21
2329	ç®è‚¤	pĂ­fÅ«	da	\N	21
2330	å±è‚¡	pĂ¬gu	mĂ´ng, Ä‘Ă­t	\N	34
2331	å•¤é…’	pĂ­jiÇ”	bia	\N	26
2332	ç–²å³	pĂ­lĂ¡o	má»‡t má»i	\N	40
2334	å“å°	pÇnchĂ¡ng	náº¿m, thá»­	\N	30
2335	é¢‘é“	pĂ­ndĂ o	kĂªnh	\N	34
2336	å“å¾·	pÇndĂ©	Ä‘áº¡o Ä‘á»©c	\N	34
2337	è´«ä¹	pĂ­nfĂ¡	nghĂ¨o	\N	34
2338	é¢‘ç¹	pĂ­nfĂ¡n	thÆ°á»ng xuyĂªn	\N	34
2339	å¹³	pĂ­ng	dá»±a vĂ o	\N	40
2340	å¹³å¸¸	pĂ­ngchĂ¡ng	thĂ´ng thÆ°á»ng	\N	34
2342	å¹³å‡¡	pĂ­ngfĂ¡n	bĂ¬nh thÆ°á»ng	\N	34
2344	è¯„ä»·	pĂ­ngjiĂ 	Ä‘Ă¡nh giĂ¡	\N	37
2345	è‹¹æœ	pĂ­ngguÇ’	quáº£ tĂ¡o	\N	34
2346	å¹³è¡¡	pĂ­nghĂ©ng	cĂ¢n báº±ng	\N	34
2348	å¹³é™	pĂ­ngjĂ¬ng	yĂªn láº·ng	\N	34
2349	è¯„è®º	pĂ­nglĂ¹n	bĂ¬nh luáº­n, nháº­n xĂ©t	\N	40
2350	å¹³é¢	pĂ­ngmiĂ n	máº·t báº±ng, máº·t pháº³ng	\N	34
2351	ä¹’ä¹“çƒ	pÄ«ngpÄngqiĂº	bĂ³ng bĂ n	\N	34
2353	å¹³å¦	pĂ­ngtÇn	báº±ng pháº³ng	\N	34
2354	å¹³è¡Œ	pĂ­ngxĂ­ng	song song	\N	34
2355	å¹³åŸ	pĂ­ngyuĂ¡n	Ä‘á»“ng báº±ng	\N	34
2356	å±éœ	pĂ­ngzhĂ ng	rĂ o cháº¯n	\N	34
2357	ç“¶å­	pĂ­ngzi	lá», bĂ¬nh	\N	34
2358	è´«ç©·	pĂ­nqiĂ³ng	nghĂ¨o nĂ n	\N	34
2359	é¢‘ç‡	pĂ­nlÇœ	táº§n sá»‘	\N	34
2360	å“å‘³	pÇnwĂ¨i	khiáº¿u tháº©m má»¹	\N	34
2362	å“è´¨	pÇnzhĂ¬	cháº¥t lÆ°á»£ng	\N	34
2363	å“ç§	pÇnzhÇ’ng	giá»‘ng, loáº¡i, chá»§ng loáº¡i	\N	34
2365	è­¬å¦‚	pĂ¬rĂº	vĂ­ dá»¥	\N	40
2367	æ³¼	pÅ	háº¯t, giá»™i, váº©y (nÆ°á»›c)	\N	30
2368	è¿«	pĂ²	vá»¡, thÅ©ng, phĂ¡ vá»¡	\N	34
2369	ç ´	pĂ²	sÆ°á»n dá»‘c, dá»‘c	\N	34
2370	é¢‡	pÅ	ráº¥t, tÆ°Æ¡ng Ä‘á»‘i, khĂ¡	\N	34
2371	è¿«ä¸åå¾…	pĂ²bĂ¹jĂ­dĂ i	khĂ´ng thá»ƒ chá» Ä‘á»£i	\N	34
2372	ç ´äº§	pĂ²chÇn	phĂ¡ sáº£n	\N	30
2373	ç ´å	pĂ²huĂ i	phĂ¡ hoáº¡i	\N	34
2374	ç ´è£‚	pĂ²liĂ¨	phĂ¡ vá»¡, ná»©t vá»¡	\N	34
2375	é­„å›	pĂ²lĂ¬	kiĂªn quyáº¿t, quyáº¿t Ä‘oĂ¡n	\N	34
2376	è¿«åˆ‡	pĂ²qiĂ¨	bá»©c thiáº¿t, cáº¥p bĂ¡ch	\N	40
2377	é“º	pÅ«	tráº£i, dá»n	\N	34
2378	æ™®é	pÇ”biĂ n	phá»• biáº¿n, rá»™ng rĂ£i	\N	34
2379	æ™®å	pÇ”jĂ­	thá»‹nh hĂ nh	\N	30
2381	ä»†äºº	pĂºrĂ©n	Ä‘áº§y tá»›	\N	34
2382	æœ´ç´ 	pÇ”sĂ¹	giáº£n dá»‹, má»™c máº¡c	\N	34
2383	æ™®é€è¯	pÇ”tÅnghuĂ 	tiáº¿ng phá»• thĂ´ng	\N	34
2384	ä¸ƒ	qÄ«	báº£y	\N	21
2385	å¡	qiÇ	káº¹t, vĂ©o	\N	34
2386	æ°å½“	qiĂ dĂ ng	thĂ­ch há»£p, thá»a Ä‘Ă¡ng	\N	34
2387	æ°åˆ°å¥½å¤„	qiĂ dĂ ohÇochĂ¹	Ä‘Ăºng dá»‹p, Ä‘Ăºng má»¥c Ä‘Ă­ch	\N	34
2388	é’±	qiĂ¡n	tiá»n	\N	40
2389	æµ…	qiÇn	nĂ´ng, nháº¡t	\N	34
2391	å‰æ	qiĂ¡ntĂ­	tiá»n Ä‘á»	\N	40
2392	æ½œå›	qiĂ¡nlĂ¬	tiá»m nÄƒng	\N	34
2393	æ½œæ°´	qiĂ¡nshuÇ	láº·n	\N	21
2394	ç­¾	qiÄn	kĂ½	\N	21
2395	ç­¾è®¢	qiÄndĂ¬ng	kĂ½ káº¿t	\N	40
2399	åƒæ–¹ç™¾è®¡	qiÄnfÄngbÇijĂ¬	táº¥t cáº£ má»i thá»§ Ä‘oáº¡n	\N	40
2400	å¢™	qiĂ¡ng	tÆ°á»ng, bá»©c tÆ°á»ng	\N	34
2401	æ¢	qiÇng	cÆ°á»›p láº¥y, vá»“ láº¥y	\N	40
2402	æ¢å¤º	qiÇngduĂ³	cÆ°á»›p láº¥y	\N	40
2405	å¼ºçƒˆ	qiĂ¡ngliĂ¨	máº¡nh máº½	\N	22
2437	èµ·åˆ	qÇchÇ	lĂºc Ä‘áº§u	\N	24
2420	ç‰µå¤´	qiÄntĂ³u	Ä‘á»©ng Ä‘áº§u	\N	24
2451	è¯·æ±‚	qÇngqiĂº	yĂªu cáº§u, xin	\N	24
2468	é’	qÄ«ng	mĂ u xanh, thanh	\N	24
2479	è¯·æ•™	qÇngjiÄo	thá»‰nh giĂ¡o, xin chá»‰ báº£o	\N	32
2495	åº†ç¥	qĂ¬ngzhĂ¹	chĂºc má»«ng	\N	36
2503	äº²èº«	qÄ«nshÄ“n	báº£n thĂ¢n, tá»± mĂ¬nh	\N	22
2403	æ¢å«	qiÇngjiĂ©	cÆ°á»›p tĂ i sáº£n	\N	34
2404	å¼ºè°ƒ	qiĂ¡ngdiĂ o	nháº¥n máº¡nh	\N	34
2406	å¼ºè¿«	qiÇngpĂ²	Ă©p buá»™c	\N	34
2407	å¼ºåˆ¶	qiĂ¡ngzhĂ¬	cÆ°á»¡ng cháº¿	\N	34
2408	æ¢æ•‘	qiÇngjiĂ¹	cá»©u giĂºp	\N	40
2410	è°¦è™	qiÄnxÅ«	khiĂªm tá»‘n	\N	34
2411	å‰é¢	qiĂ¡nmiĂ n	phĂ­a trÆ°á»›c	\N	34
2412	å‰é€”	qiĂ¡ntĂº	tÆ°Æ¡ng lai, triá»ƒn vá»ng	\N	34
2413	å‰è¿›	qiĂ¡njĂ¬n	tiáº¿n lĂªn	\N	40
2414	è°¦é€	qiÄnxĂ¹n	khiĂªm nhÆ°á»ng	\N	34
2415	è°´è´£	qiÇnzĂ©	lĂªn Ă¡n	\N	40
2416	æ¬ 	qiĂ n	ná»£	\N	34
2417	åµŒå…¥	qiĂ nrĂ¹	nhĂºng vĂ o	\N	34
2418	ç‰µæŒ‚	qiÄnguĂ 	lo láº¯ng	\N	34
2421	è¿å°±	qiÄnjiĂ¹	nhĂ¢n nhÆ°á»£ng, cáº£ ná»ƒ	\N	34
2422	è¿ç§»	qiÄnyĂ­	di chuyá»ƒn	\N	40
2423	è°¦è®©	qiÄnrĂ ng	nhÆ°á»ng nhá»‹n	\N	34
2424	æ½œç§»é»˜åŒ–	qiÄnyĂ­mĂ³huĂ 	thay Ä‘á»•i má»™t cĂ¡ch vĂ´ tri vĂ´ giĂ¡c	\N	40
2425	ç‰µåˆ¶	qiÄnzhĂ¬	kiá»m cháº¿, hĂ m chá»©a	\N	40
2426	ç­¾å­—	qiÄnzi	kĂ½ tĂªn	\N	34
2427	æ¡¥	qiĂ¡o	cĂ¢y cáº§u	\N	24
2428	ç§	qiĂ¡o	nhĂ¬n	\N	40
2429	ä¹”	qiĂ¡o	vĂªnh, vá»ƒnh, báº£nh	\N	34
2430	æ•²	qiÄo	gĂµ, khua, báº­t dáº­y	\N	40
2431	å·§å…‹å›	qiÇokĂ¨lĂ¬	sĂ´ cĂ´ la	\N	34
2432	å·§å¦™	qiÇomiĂ o	khĂ©o lĂ©o, tĂ i tĂ¬nh	\N	40
2433	æ‚„æ‚„	qiÄoqiÄo	láº·ng láº½	\N	21
2435	æ´½è°ˆ	qiĂ tĂ¡n	trĂ² chuyá»‡n, bĂ n luáº­n	\N	34
2436	å™¨æ	qĂ¬cĂ¡i	khĂ­ tĂ i, dá»¥ng cá»¥	\N	40
2438	å¯ç¨‹	qÇchĂ©ng	khá»Ÿi hĂ nh, lĂªn Ä‘Æ°á»ng	\N	34
2439	èµ·åº	qÇchuĂ¡ng	ngá»§ dáº­y	\N	39
2440	å…¶æ¬¡	qĂ­cĂ¬	thá»© hai, tiáº¿p Ä‘Ă³	\N	34
2441	æœŸå¾…	qĂ­dĂ i	ká»³ vá»ng, mong Ä‘á»£i	\N	34
2442	é”²è€Œä¸èˆ	qÇ'Ă©rbĂ¹shÄ›	kiĂªn nháº«n, miá»‡t mĂ i	\N	35
2444	å¯å‘	qÇfÄ	gá»£i Ă½	\N	34
2445	èµ·é£	qÇfÄ“i	cáº¥t cĂ¡nh	\N	40
2446	èµ·ä¼	qÇfĂº	khĂ´ng khĂ­	\N	34
2447	èµ·å¥	qÇjÇ”	nháº­p nho, lĂªn xuá»‘ng	\N	34
2449	èµ·æµ·	qÇhĂ i	khĂ­ khĂ¡i, khĂ­ phĂ¡ch	\N	21
2450	è¯·	qÇng	xin, má»i	\N	34
2452	æ°”åŸ	qĂ¬gÅng	khĂ­ cĂ´ng	\N	34
2453	å¥‡æ€ª	qĂ­guĂ i	ká»³ láº¡, quĂ¡i láº¡	\N	34
2454	å™¨å®˜	qĂ¬guÄn	cÆ¡ quan	\N	34
2455	èµ·å“„	qÇhĂ²ng	Ä‘Ă¹a bá»¡n, giá»¡n cá»£t	\N	40
2456	æ°”å€™	qĂ¬hĂ²u	khĂ­ háº­u	\N	30
2457	å¥‡è¿¹	qÇjĂ¬	ká»³ tĂ­ch, ká»³ cĂ´ng	\N	34
2459	è¿„ä»ä¸ºæ­¢	qĂ­jÄ«n wĂ¨izhÇ	cho Ä‘áº¿n nay	\N	40
2460	èµ·æ¥	qÇlĂ¡i	Ä‘á»©ng dáº­y, ngá»“i dáº­y	\N	40
2461	å‡„å‡‰	qÇliĂ¡ng	láº¡nh láº½o, tiĂªu Ä‘iá»u	\N	34
2462	å¥‡å¦™	qĂ­miĂ o	ká»³ diá»‡u, tinh xáº£o	\N	34
2463	äº²çˆ±	qÄ«n'Ă i	thĂ¢n Ă¡i, thÆ°Æ¡ng yĂªu	\N	34
2464	ä¾µç¯	qÄ«nfĂ n	xĂ¢m pháº¡m, can thiá»‡p	\N	34
2465	å‹¤å¥‹	qĂ­nfĂ¨n	siĂªng nÄƒng, cáº§n cĂ¹	\N	34
2466	æ™´	qĂ­ng	trá»i náº¯ng	\N	34
2467	è½»	qÄ«ng	nháº¹, nháº¹ nhĂ ng	\N	34
2469	æ¸…	qÄ«ng	trong, sáº¡ch	\N	34
2470	æƒ…æ¥	qĂ­ngbĂ o	tĂ¬nh bĂ¡o, thĂ´ng tin	\N	34
2471	æ¸…æ¾ˆ	qÄ«ngchĂ¨	trong veo, trong suá»‘t	\N	34
2472	æ¸…æ™¨	qÄ«ngchĂ©n	sĂ¡ng sá»›m	\N	34
2474	é’æ˜¥	qÄ«ngchÅ«n	tuá»•i tráº»	\N	34
2475	è½»æ·¡	qÄ«ngdĂ n	nháº¡t, loĂ£ng, nháº¹	\N	34
2476	è½»è€Œæ˜“ä¸¾	qÄ«ng'Ă©ryĂ¬jiÇo	dá»… dĂ ng	\N	35
2477	è¯·å‡	qÇngjiĂ 	xin nghá»‰	\N	40
2478	è¯·æŸ¬	qÇngjiÇn	thiá»‡p má»i	\N	34
2480	æƒ…è‚	qĂ­ngjiĂ©	tĂ¬nh tiáº¿t, trÆ°á»ng há»£p	\N	34
2481	æ¸…é™	qÄ«ngjĂ¬ng	yĂªn tÄ©nh	\N	40
2482	è¯·å®¢	qÇngkĂ¨	má»i khĂ¡ch, Ä‘Ă£i khĂ¡ch	\N	34
2483	æƒ…å†µ	qĂ­ngkuĂ ng	tĂ¬nh hĂ¬nh	\N	40
2484	æ™´æœ—	qĂ­nglÇng	náº¯ng, trong sĂ¡ng	\N	34
2485	æƒ…ç†	qĂ­nglÇ	lĂ½ láº½, Ä‘áº¡o lĂ½	\N	34
2486	é’å¹´	qÄ«ngniĂ¡n	thanh niĂªn	\N	40
2488	è½»è§†	qÄ«ngshĂ¬	khinh thÆ°á»ng	\N	34
2489	è½»æ¾	qÄ«ngsÅng	nháº¹ nhĂµm, thoáº£i mĂ¡i	\N	34
2490	å€¾å¬	qÄ«ngtÄ«ng	láº¯ng nghe, chĂº Ă½ nghe	\N	33
2491	æ¸…æ™°	qÄ«ngxÄ«	rĂµ rĂ ng, rĂµ rá»‡t	\N	34
2492	å€¾æ–œ	qÄ«ngxiĂ©	nghiĂªng, lá»‡ch, xiĂªu váº¹o	\N	34
2493	æ¸…é†’	qÄ«ngxÇng	tá»‰nh tĂ¡o	\N	34
2494	æƒ…ç»ª	qĂ­ngxĂ¹	tĂ¢m tráº¡ng, cáº£m xĂºc	\N	34
2496	å‹¤ä¿­	qĂ­njiÇn	tiáº¿t kiá»‡m	\N	40
2498	ä¾µç•¥	qÄ«nlĂ¼Ă¨	xĂ¢m lÆ°á»£c	\N	34
2499	é’¦ä½©	qÄ«npĂ¨i	khĂ¢m phá»¥c	\N	34
2500	äº²æˆ	qÄ«nqÄ«	thĂ¢n thĂ­ch, ngÆ°á»i thĂ¢n	\N	34
2501	äº²åˆ‡	qÄ«nqiĂ¨	thĂ¢n thiáº¿t	\N	40
2502	äº²çƒ­	qÄ«nre	thĂ¢n máº­t, ná»“ng nhiá»‡t	\N	34
2504	ç©·	qiĂ³ng	nghĂ¨o	\N	34
2520	ä¼ä¸	qÇyĂ¨	xĂ­ nghiá»‡p	\N	38
2545	çƒ­çˆ±	rĂ¨â€™Ă i	yĂªu nhiá»‡t thĂ nh	\N	22
2555	ä»»ä½•	rĂ¨nhĂ©	báº¥t kĂ¬	\N	40
2580	è£ç™»	rĂ³ngdÄ“ng	vinh danh	\N	31
2512	å…¶ä½™	qĂ­yĂº	ngoĂ i ra, cĂ²n láº¡i	\N	40
2550	çƒ­å¿ƒ	rĂ¨xÄ«n	nhiá»‡t tĂ¬nh, sá»‘t sáº¯ng	\N	24
2553	ä»ç„¶	rĂ©ngrĂ¡n	váº«n	\N	31
2564	ä»æ—§	rĂ©ngjiĂ¹	nhÆ° cÅ©, nhÆ° trÆ°á»›c	\N	34
2505	æ——è¢	qĂ­pĂ¡o	sÆ°á»n xĂ¡m	\N	34
2506	æ¬ºéª—	qÄ«piĂ n	lá»«a dá»‘i	\N	34
2508	é½å…¨	qĂ­quĂ¡n	Ä‘áº§y Ä‘á»§	\N	40
2509	æ°”è‰²	qĂ¬sĂ¨	tháº§n sáº¯c, khĂ­ sáº¯c	\N	30
2510	å…¶å®	qĂ­shĂ­	ká»³ thá»±c, thá»±c ra	\N	40
2511	æ°”å¿	qĂ¬shĂ¬	khĂ­ tháº¿	\N	40
2513	ä¼å›¾	qÇtĂº	mÆ°u Ä‘á»“, Ă½ Ä‘á»“	\N	34
2514	çƒè¿·	qiĂºmĂ­	ngÆ°á»i hĂ¢m má»™	\N	34
2515	æ°”å‘³	qĂ¬wĂ¨i	mĂ¹i vá»‹	\N	30
2517	æ°”è±¡	qĂ¬xiĂ ng	khĂ­ tÆ°á»£ng há»c	\N	34
2518	é½å¿ƒåå›	qĂ­xÄ«n xiĂ©lĂ¬	Ä‘á»“ng tĂ¢m hiá»‡p lá»±c	\N	34
2519	æ°”å‹	qĂ¬yÄ	Ă¡p suáº¥t khĂ­ quyá»ƒn	\N	40
2521	èµ·ä¹‰	qÇyĂ¬	khá»Ÿi nghÄ©a	\N	34
2522	æ±½æ²¹	qĂ¬yĂ³u	xÄƒng	\N	28
2523	å²‚æœ‰æ­¤ç†	qÇ yÇ’u cÇ lÇ	láº½ nĂ o láº¡i nhÆ° váº­y	\N	40
2524	èµ·æº	qÇyuĂ¡n	báº¯t nguá»“n	\N	34
2525	å…¶ä¸­	qĂ­zhÅng	trong sá»‘ Ä‘Ă³	\N	34
2526	å¦»å­	qÄ«zi	vá»£	\N	34
2527	å¨¶	qÇ”	láº¥y vá»£	\N	40
2528	å»ä¸–	qĂ¹shĂ¬	qua Ä‘á»i	\N	40
2530	å»å¹´	qĂ¹niĂ¡n	nÄƒm ngoĂ¡i	\N	34
2531	ç¾¤ä¼—	qĂºnzhĂ²ng	quáº§n chĂºng	\N	34
2532	è£™å­	qĂºnzi	vĂ¡y	\N	27
2533	è¶‹å¿	qÅ«shĂ¬	khuynh hÆ°á»›ng, xu tháº¿	\N	34
2534	æ›²æ˜	qÅ«zhĂ©	quanh co, khĂºc khuá»·u	\N	34
2535	é©±é€	qÅ«zhĂº	trá»¥c xuáº¥t	\N	40
2536	ç‡ƒ	rĂ¡n	nhuá»™m	\N	34
2538	è®©	rĂ ng	nhÆ°á»ng, má»i	\N	34
2539	å·	rÇng	kĂªu gĂ o	\N	34
2540	è®©æ­¥	rĂ ngbĂ¹	nhÆ°á»£ng bá»™	\N	34
2541	ç„¶å	rĂ¡nhĂ²u	sau Ä‘Ă³, tiáº¿p Ä‘Ă³	\N	34
2542	ç‡ƒçƒ§	rĂ¡nshÄo	Ä‘á»‘t chĂ¡y	\N	34
2543	æ‰°ä¹±	rÇoluĂ n	quáº¥y nhiá»…u, há»—n loáº¡n	\N	40
2544	çƒ­	rĂ¨	nhiá»‡t, nĂ³ng	\N	34
2546	çƒ­çƒˆ	rĂ¨liĂ¨	nhiá»‡t liá»‡t, sĂ´i ná»•i	\N	34
2547	çƒ­é—¹	rĂ¨nĂ o	nĂ¡o nhiá»‡t, sĂ´i ná»•i	\N	34
2548	å¿	rÄ›n	nháº«n, chá»‹u	\N	40
2551	è®¤è¯†	rĂ¨nshi	biáº¿t, nháº­n biáº¿t	\N	40
2552	ä»»å¡	rĂ¨nwu	nhiá»‡m vá»¥	\N	40
2554	æ‰”	rÄ“ng	nĂ©m, quÄƒng	\N	40
2556	äºº	rĂ©n	ngÆ°á»i	\N	34
2557	å¿è€	rÄ›nnĂ i	kiĂªn nháº«n, nháº«n láº¡i	\N	40
2558	å¿å—	rÄ›nshĂ²u	chá»‹u Ä‘á»±ng	\N	34
2559	çƒ­èº«	rĂ¨shÄ“n	khá»Ÿi Ä‘á»™ng	\N	34
2560	çƒ­æ°´å™¨	rĂ¨shuÇqĂ¬	bĂ¬nh nÆ°á»›c nĂ³ng	\N	34
2561	çƒ­æƒ…	rĂ¨qĂ­ng	nhiá»‡t tĂ¬nh	\N	40
2563	å¿å¿ƒ	rÄ›nxÄ«n	ná»¡ lĂ²ng	\N	34
2565	æ—¥ç¨‹	rĂ¬chĂ©ng	lá»‹ch trĂ¬nh	\N	30
2566	æ—¥æœŸ	rĂ¬qÄ«	ngĂ y thĂ¡ng	\N	30
2567	æ—¥è®°	rĂ¬jĂ¬	nháº­t kĂ½	\N	30
2568	æ—¥ç”¨å“	rĂ¬yĂ²ngpÇn	Ä‘á»“ dĂ¹ng háº±ng ngĂ y	\N	40
2569	è£èª‰	rĂ³ngyĂ¹	vinh dá»±	\N	40
2570	å®¹æ˜“	rĂ³ngyĂ¬	dá»… dĂ ng	\N	34
2571	å®¹å¿	rĂ³ngrÄ›n	khoan dung	\N	34
2572	å®¹è²Œ	rĂ³ngmĂ o	dung máº¡o	\N	34
2574	å®¹çº³	rĂ³ngnĂ 	chá»©a Ä‘á»±ng	\N	34
2575	èåŒ–	rĂ³nghuĂ 	tan cháº£y	\N	40
2576	å®¹å™¨	rĂ³ngqĂ¬	Ä‘á»“ chá»©a	\N	34
2577	è£å¹¸	rĂ³ngxĂ¬ng	vinh háº¡nh	\N	30
2579	è£åå¯Œè´µ	rĂ³nghuĂ¡ fĂ¹guĂ¬	vinh hoa phĂº quĂ½	\N	34
2581	è£è€€	rĂ³ngyĂ o	vinh quang	\N	40
2582	è£å†›	rĂ³ngjÅ«n	quĂ¢n nhĂ¢n xuáº¥t ngÅ©	\N	40
2583	è£è†º	rĂ³ngyÄ«ng	Ä‘Æ°á»£c vinh dá»± nháº­n	\N	40
2584	å®¹å…‰ç„•å‘	rĂ³ngguÄng huĂ nfÄ	tÆ°Æ¡i sĂ¡ng, ráº¡ng rá»¡	\N	34
2585	å®¹èº«	rĂ³ngshÄ“n	trĂº thĂ¢n	\N	21
2586	å®¹ä¸ä¸‹	rĂ³ng bĂ¹ xiĂ 	khĂ´ng thá»ƒ cháº¥p nháº­n	\N	34
2587	äººæ‰	rĂ©ncĂ¡i	ngÆ°á»i tĂ i nÄƒng	\N	34
2588	ä»æ…ˆ	rĂ©ncĂ­	nhĂ¢n tá»«	\N	21
2589	äººé“	rĂ©ndĂ o	nhĂ¢n Ä‘áº¡o	\N	34
2590	è®¤å®	rĂ¨ndĂ¬ng	cho ráº±ng, nháº­n Ä‘á»‹nh	\N	40
2591	äººæ ¼	rĂ©ngĂ©	nhĂ¢n cĂ¡ch	\N	21
2592	äººå·¥	rĂ©ngÅng	nhĂ¢n táº¡o	\N	34
2594	äººé—´	rĂ©njiÄn	nhĂ¢n gian, tháº¿ giá»›i	\N	30
2595	äººå¯	rĂ©nkÄ›	cho phĂ©p, Ä‘á»“ng Ă½	\N	34
2596	äººå£	rĂ©nkÇ’u	dĂ¢n sá»‘	\N	34
2597	äººç±»	rĂ©nlĂ¨i	nhĂ¢n loáº¡i	\N	34
2598	äººæ°‘å¸	rĂ©nmĂ­nbĂ¬	nhĂ¢n dĂ¢n tá»‡	\N	40
2599	ä»»å‘½	rĂ¨nmĂ¬ng	bá»• nhiá»‡m	\N	40
2600	äººç”Ÿ	rĂ©nshÄ“ng	Ä‘á»i sá»‘ng, cuá»™c Ä‘á»i	\N	34
2601	äººå£«	rĂ©nshĂ¬	nhĂ¢n sá»±	\N	21
2602	äººä¸º	rĂ©nwĂ©i	con ngÆ°á»i lĂ m ra	\N	40
2603	è®¤ä¸º	rĂ¨nwĂ©i	cho ráº±ng, cho lĂ 	\N	40
2604	äººç‰©	rĂ©nwĂ¹	nhĂ¢n váº­t	\N	40
2606	ä»»æ€§	rĂ¨nxĂ¬ng	tĂ¹y há»©ng	\N	34
2607	ä»»æ„	rĂ¨nyĂ¬	tĂ¹y Ă½	\N	27
2608	äººå‘˜	rĂ©nyuĂ¡n	nhĂ¢n viĂªn	\N	40
2609	è®¤çœŸ	rĂ¨nzhÄ“n	chÄƒm chá»‰, nghiĂªm tĂºc	\N	34
2613	é³ƒ	sÄi	mang cĂ¡	\N	31
2685	å‰©	shĂ¨ng	thá»«a, cĂ²n láº¡i	\N	30
2620	ä¸‰è§’	sÄnjiÇo	tam giĂ¡c	\N	21
2624	å•¥	shĂ¡	cĂ¡i gĂ¬	\N	25
2632	æ“…é•¿	shĂ nchĂ¡ng	giá»i	\N	30
2645	å•†å“	shÄngpÇn	hĂ ng hĂ³a	\N	38
2672	æ‘„å½±	shĂ¨yÇng	nhiáº¿p áº£nh	\N	31
2696	å£°è°ƒ	shÄ“ngdiĂ o	thanh Ä‘iá»‡u, giá»ng	\N	30
2702	ç”Ÿç†	shÄ“nglÇ	sinh lĂ½	\N	32
2718	ç»³å­	shĂ©ngzi	dĂ¢y thá»«ng	\N	30
2611	æ´’	sÇ	ráº¯c, tung, váº©y	\N	40
2612	æ’’è°	sÄhuÇng	nĂ³i dá»‘i	\N	34
2674	è®¾æƒ³	shĂ¨xiÇng	tÆ°á»Ÿng tÆ°á»£ng	\N	34
2614	ä¼	sÇn	Ă´	\N	34
2615	ä¸‰	sÄn	ba	\N	21
2617	æ•£å‘	sĂ nfÄ	toáº£ ra, phĂ¡t ra	\N	40
2618	ä¸§å¤±	sĂ ngshÄ«	máº¥t Ä‘i, máº¥t mĂ¡t	\N	34
2619	å—“å­	sÇngzi	cá»• há»ng, giá»ng	\N	34
2621	æ•£æ–‡	sÇnwĂ©n	vÄƒn xuĂ´i	\N	34
2623	æ£®æ—	sÄ“nlĂ­n	rá»«ng ráº­m, rá»«ng sĂ¢u	\N	34
2625	å‚»	shÇ	ngu ngá»‘c	\N	34
2626	æ€	shÄ	giáº¿t	\N	40
2627	åˆ¹è½¦	shÄchÄ“	phanh, tháº¯ng xe	\N	30
2628	æ²™å‘	shÄfÄ	gháº¿ xĂ´-pha	\N	34
2629	æ™’	shĂ i	phÆ¡i náº¯ng	\N	34
2631	æ²™æ¼ 	shÄmĂ²	sa máº¡c	\N	29
2633	åˆ é™¤	shÄnchĂº	xĂ³a bá»	\N	34
2634	é—ªç”µ	shÇndiĂ n	tia chá»›p, sĂ©t	\N	40
2635	ä¸	shĂ ng	trĂªn, phĂ­a trĂªn	\N	40
2636	ä¼¤è„‘ç­‹	shÄng nÇojÄ«n	háº¡i nĂ£o, tá»‘n tĂ¢m trĂ­	\N	34
2637	ä¸ç­	shĂ ngbÄn	Ä‘i lĂ m	\N	40
2638	å•†æ ‡	shÄngbiÄo	thÆ°Æ¡ng hiá»‡u	\N	34
2639	ä¸å½“	shĂ ngdĂ ng	bá»‹ lá»«a	\N	40
2640	å•†åº—	shÄngdiĂ n	cá»­a hĂ ng	\N	37
2642	ä¸è¯¾	shĂ ngkĂ¨	há»c, lĂªn lá»›p	\N	40
2643	ä¸è¿›å¿ƒ	shĂ ngjĂ¬nxÄ«n	chĂ­ tiáº¿n thá»§	\N	40
2644	å•†é‡	shÄngliĂ¡ng	thÆ°Æ¡ng lÆ°á»£ng, bĂ n tháº£o	\N	34
2646	ä¸ä»»	shĂ ngrĂ¨n	nháº­m chá»©c	\N	34
2647	ä¸ç½‘	shĂ ngwÇng	lĂªn máº¡ng	\N	40
2648	ä¸åˆ	shĂ ngwÇ”	buá»•i sĂ¡ng	\N	34
2649	ä¼¤å¿ƒ	shÄngxÄ«n	thÆ°Æ¡ng tĂ¢m, Ä‘au lĂ²ng	\N	34
2650	ä¸å­¦	shĂ ngxuĂ©	Ä‘i há»c	\N	34
2651	ä¸ç˜¾	shĂ ngyÇn	nghiá»‡n	\N	40
2652	ä¸æ¸¸	shĂ ngyĂ³u	thÆ°á»£ng du	\N	34
2654	å±±è„‰	shÄnmĂ i	ráº·ng nĂºi, dĂ£y nĂºi	\N	40
2655	é—ªçƒ	shÇnshuĂ²	nháº¥p nhĂ¡y	\N	40
2656	å–„äº	shĂ nyĂº	giá»i vá»	\N	40
2657	æ‰‡å­	shĂ nzi	cĂ¡i quáº¡t	\N	40
2658	ç¨	shÄo	hÆ¡i, má»™t chĂºt, sÆ¡ qua	\N	40
2659	å“¨	shĂ o	Ä‘á»“n, tráº¡m gĂ¡c	\N	34
2660	å°‘	shÇo	Ă­t, tráº»	\N	40
2661	æ	shÄo	mang há»™, mang giĂ¹m	\N	34
2662	çƒ§	shÄo	ngon	\N	34
2663	ç¨å¾®	shÄowÄ“i	hÆ¡i, má»™t chĂºt, sÆ¡ qua	\N	40
2664	å‹ºå­	shĂ¡ozi	cĂ¡i muá»—ng	\N	34
2665	æ²™æ»©	shÄtÄn	bĂ£i biá»ƒn	\N	40
2666	è›‡	shĂ©	con ráº¯n	\N	34
2668	èˆä¸å¾—	shÄ›bude	luyáº¿n tiáº¿c, khĂ´ng ná»¡	\N	35
2669	å°„å‡»	shĂ¨jÄ«	báº¯n, xáº¡ kĂ­ch	\N	34
2670	è®¾è®¡	shĂ¨jĂ¬	thiáº¿t káº¿	\N	40
2671	ç¤¾ä¼	shĂ¨huĂ¬	xĂ£ há»™i	\N	34
2675	ä¼¸	shÄ“n	cÄƒng ra, duá»—i ra	\N	40
2678	ç”³è¯·	shÄ“n qÇng	xin	\N	40
2679	æ·±å¥¥	shÄ“nâ€™Ă o	sĂ¢u	\N	24
2680	ç”³æ¥	shÄ“nbĂ o	trĂ¬nh bĂ¡o	\N	34
2681	èº«æ	shÄ“ncĂ¡i	vĂ³c dĂ¡ng, dĂ¡ng ngÆ°á»i	\N	34
2682	å®¡æŸ¥	shÄ›nchĂ¡	xem xĂ©t, tháº©m tra	\N	34
2683	æ·±æ²‰	shÄ“nchĂ©n	sĂ¢u láº¯ng	\N	21
2684	èº«ä»½	shÄ“nfĂ¨n	thĂ¢n pháº­n	\N	30
2686	ç››	shĂ¨ng	chá»©a, Ä‘á»±ng, dung náº¡p	\N	40
2687	çœ	shÄ›ng	tá»‰nh, tinh lÆ°á»£c, tiáº¿t kiá»‡m	\N	34
2688	å‡	shÄ“ng	lĂ­t	\N	40
2689	èƒœè´Ÿ	shĂ¨ng fĂ¹	tháº¯ng báº¡i, Ä‘Æ°á»£c thua	\N	30
2690	ç”Ÿé”ˆ	shÄ“ng xiĂ¹	rá»‰ sĂ©t	\N	40
2692	ç››äº§	shĂ¨ngchÇn	sáº£n xuáº¥t nhiá»u	\N	40
2693	ç”Ÿäº§	shÄ“ngchÇn	sáº£n xuáº¥t	\N	38
2694	ç‰²ç•œ	shÄ“ngchĂ¹	chÄƒn nuĂ´i	\N	34
2695	ç”Ÿå­˜	shÄ“ngcĂºn	sá»‘ng sĂ³t	\N	34
2697	ç”Ÿå¨	shÄ“ngdĂ²ng	sinh Ä‘á»™ng	\N	34
2698	çœä¼	shÄ›nghuĂ¬	thá»§ phá»§ cá»§a tá»‰nh	\N	30
2699	ç”Ÿæ´»	shÄ“nghuĂ³	cuá»™c sá»‘ng, sá»‘ng	\N	34
2700	ç”Ÿæœº	shÄ“ngjÄ«	sá»©c sá»‘ng	\N	34
2701	ç››å¼€	shĂ¨ngkÄi	ná»Ÿ hoa	\N	34
2703	çœç•¥	shÄ›nglĂ¼Ă¨	lÆ°á»£c bá»	\N	34
2705	ç”Ÿå‘½	shÄ“ngmĂ¬ng	tĂ­nh máº¡ng, sinh máº¡ng	\N	40
2706	ç”Ÿæ°”	shÄ“ngqĂ¬	giáº­n, tá»©c giáº­n	\N	30
2707	æ·±æƒ…	shÄ“nqĂ­ng	thĂ¢m tĂ¬nh	\N	34
2708	ç”Ÿæ—¥	shÄ“ngrĂ¬	sinh nháº­t	\N	30
2709	å£°å¿	shÄ“ngshĂ¬	thanh tháº¿	\N	30
2710	ç”Ÿç–	shÄ“ngshÅ«	má»›i láº¡	\N	34
2711	ç”Ÿæ€	shÄ“ngtĂ i	sinh thĂ¡i	\N	21
2712	ç”Ÿç‰©	shÄ“ngwĂ¹	sinh váº­t	\N	40
2713	ç”Ÿæ•ˆ	shÄ“ngxiĂ o	cĂ³ hiá»‡u lá»±c	\N	34
2714	ç››è¡Œ	shĂ¨ngxĂ­ng	thá»‹nh hĂ nh	\N	30
2716	å£°èª‰	shÄ“ngyĂ¹	danh tiáº¿ng	\N	40
2717	ç”Ÿè‚²	shÄ“ngyĂ¹	sinh Ä‘áº»	\N	40
2720	å®¡é—®	shÄ›nwĂ¨n	tháº©m váº¥n	\N	34
2725	å®¡åˆ¤	shÄ›npĂ n	xĂ©t xá»­	\N	28
2807	è¯•å›¾	shĂ¬tĂº	tĂ­nh toĂ¡n, thá»­, Ä‘á»‹nh	\N	30
2820	å®ç”¨	shĂ­yĂ²ng	sá»­ dá»¥ng	\N	40
2732	æ¸—é€	shĂ¨ntĂ²u	tháº¥m tháº¥u	\N	24
2737	æ‘„å–	shĂ¨qÇ”	háº¥p thu, (dinh dÆ°á»¡ng)	\N	30
2755	æ—¶å¸¸	shĂ­chĂ¡ng	thÆ°á»ng	\N	30
2758	ä¸–ä»£	shĂ¬dĂ i	tháº¿ há»‡	\N	37
2762	æ—¶å…‰	shĂ­guÄng	thá»i gian	\N	30
2769	å®æƒ 	shĂ­huĂ¬	lá»£i Ă­ch thá»±c táº¿	\N	30
2776	æ—¶é—´	shĂ­jiÄn	thá»i gian	\N	30
2715	å£°éŸ³	shÄ“ngyÄ«n	tiáº¿ng, Ă¢m thanh	\N	34
2721	æ·±åˆ»	shÄ“nkĂ¨	sĂ¢u sáº¯c	\N	24
2723	å®¡ç¾	shÄ›nmÄ›i	tháº©m má»¹	\N	34
2724	ç¥ç§˜	shĂ©nmĂ¬	tháº§n bĂ­, bĂ­ áº©n	\N	30
2778	ä¸–ç•Œ	shĂ¬jiĂ¨	tháº¿ giá»›i	\N	30
2726	ç¥æ°”	shĂ©nqĂ¬	tháº§n sáº¯c, tháº§n khĂ­	\N	30
2727	æ·±æƒ…åè°	shÄ“nqĂ­ng hĂ²uyĂ¬	tĂ¬nh báº¡n thĂ¢n thiáº¿t	\N	40
2728	ç¥è‰²	shĂ©nsĂ¨	tháº§n sáº¯c	\N	30
2729	ç¥åœ£	shĂ©nshĂ¨ng	thiĂªng liĂªng, tháº§n thĂ¡nh	\N	40
2730	ç»…å£«	shÄ“nshĂ¬	thĂ¢n sÄ©	\N	30
2784	è§†å›	shĂ¬lĂ¬	thá»‹ lá»±c	\N	32
2733	ç¥ä»™	shĂ©nxiÄn	tháº§n tiĂªn	\N	40
2734	å®¡è®¯	shÄ›nxĂ¹n	tháº©m váº¥n	\N	34
2735	ç”è‡³	shĂ¨nzhĂ¬	tháº­m chĂ­	\N	34
2736	æ…é‡	shĂ¨nzhĂ²ng	cáº©n tháº­n	\N	30
2793	æ—¶å°	shĂ­shĂ ng	thá»i thÆ°á»£ng, má»‘t	\N	30
2738	ç¤¾åŒº	shĂ¨qÅ«	cá»™ng Ä‘á»“ng	\N	34
2739	æ‘„æ°åº¦	shĂ¨shĂ¬dĂ¹	Ä‘á»™ C	\N	34
2740	èˆŒå¤´	shĂ©tou	lÆ°á»¡i	\N	34
2741	è®¾ç½®	shĂ¨zhĂ¬	thiáº¿t láº­p	\N	40
2742	æ‹¾	shĂ­	nháº·t, mĂ³t	\N	34
2743	å	shĂ­	mÆ°á»i	\N	21
2744	æ˜¯	shĂ¬	lĂ 	\N	25
2745	è¯•	shĂ¬	thi	\N	32
2746	ä½¿	shÇ	khiáº¿n, sai báº£o, dĂ¹ng	\N	34
2747	è¯—	shÄ«	thÆ¡	\N	34
2749	ååˆ†	shĂ­ fÄ“n	vĂ´ cĂ¹ng, ráº¥t	\N	34
2750	å¤±è´¥	shÄ«bĂ i	tháº¥t báº¡i	\N	40
2751	å¿å¿…	shĂ¬bĂ¬	táº¥t pháº£i, buá»™c pháº£i	\N	34
2752	è¯†åˆ«	shĂ­biĂ©	phĂ¢n biá»‡t	\N	40
2753	å£«å…µ	shĂ¬bÄ«ng	binh lĂ­nh	\N	40
2754	æ—¶å·®	shĂ­chÄ	sá»± chĂªnh lá»‡ch thá»i gian	\N	34
2757	æ—¶ä»£	shĂ­dĂ i	thá»i ká»³, thá»i Ä‘áº¡i	\N	34
2814	å®ä¹ 	shĂ­xĂ­	táº­p luyá»‡n, thá»±c táº­p	\N	30
2759	æ—¶è€Œ	shĂ­â€™Ă©r	Ä‘Ă´i khi	\N	35
2818	è¯•éªŒ	shĂ¬yĂ n	thĂ­ nghiá»‡m	\N	32
2761	é‡æ”¾	shĂ¬fĂ ng	phĂ³ng thĂ­ch	\N	34
2795	å®éªŒ	shĂ­yĂ n	thá»±c nghiá»‡m, thĂ­ nghiá»‡m	\N	30
2763	æ˜¯å¦	shĂ¬fÇ’u	pháº£i chÄƒng, hay khĂ´ng	\N	34
2764	å¸ˆå‚…	shÄ«fu	thá»£ cáº£, chĂº	\N	34
2765	äº‹æ•…	shĂ¬gĂ¹	sá»± cá»‘, tai náº¡n	\N	34
2766	é€‚åˆ	shĂ¬hĂ©	phĂ¹ há»£p	\N	34
2767	æ—¶å€™	shĂ­hou	lĂºc, khi	\N	30
2770	å®é™…	shĂ­jĂ¬	thá»±c táº¿	\N	30
2771	æ—¶æœº	shĂ­jÄ«	cÆ¡ há»™i, thá»i cÆ¡	\N	34
2772	ä¸–çºª	shĂ¬jĂ¬	tháº¿ ká»‰	\N	40
2773	äº‹è¿¹	shĂ¬jĂ¬	sá»± tĂ­ch, cĂ¢u truyá»‡n	\N	40
2774	æ–½å 	shÄ«jiÄ	gĂ¢y, lĂ m (Ă¡p lá»±c, áº£nh hÆ°á»Ÿng)	\N	34
2775	å®è·µ	shĂ­jiĂ n	thá»±c hiá»‡n, thá»±c hĂ nh	\N	40
2777	äº‹ä»¶	shĂ¬jiĂ n	sá»± kiá»‡n	\N	40
2780	ä½¿å²å„¿	shÇ jĂ¬n er	gáº¯ng sá»©c, ra sá»©c	\N	40
2781	è¯—å¥	shÄ«jĂ¹	bĂ i thÆ¡	\N	34
2782	æ—¶åˆ»	shĂ­kĂ¨	thá»i kháº¯c, thá»i gian	\N	30
2783	å®å›	shĂ­lĂ¬	sá»©c máº¡nh	\N	34
2785	æ—¶é«¦	shĂ­mĂ¡o	thá»i trang	\N	34
2786	å¤±çœ 	shÄ«miĂ¡n	máº¥t ngá»§	\N	34
2787	ä½¿å‘½	shÇmĂ¬ng	nhiá»‡m vá»¥, sá»© má»‡nh	\N	40
2788	é£Ÿå“	shĂ­pÇn	thá»±c pháº©m	\N	30
2789	æ—¶æœŸ	shĂ­qÄ«	thá»i kĂ¬	\N	34
2791	å¤±å»	shÄ«qĂ¹	máº¥t	\N	34
2792	æ¹¿æ¶¦	shÄ«rĂ¹n	Æ°á»›t, áº©m Æ°á»›t	\N	34
2794	å¤±ä¸	shÄ«yĂ¨	tháº¥t nghiá»‡p	\N	40
2796	äº‹ä¸	shĂ¬yĂ¨	sá»± nghiá»‡p, cĂ´ng cuá»™c	\N	34
2797	å®è¡Œ	shĂ­xĂ­ng	thá»±c hiá»‡n	\N	40
2798	ä½¿ç”¨	shÇyĂ²ng	sá»­ dá»¥ng, dĂ¹ng vĂ o thá»±c táº¿	\N	40
2799	æ—¶äº‹	shĂ­shĂ¬	thá»i sá»±	\N	34
2800	å®æ–½	shĂ­shÄ«	thá»±c hiá»‡n	\N	40
2801	äº‹å®	shĂ¬shĂ­	sá»± thá»±c	\N	30
2802	é€ä¸–	shĂ¬shĂ¬	cháº¿t	\N	40
2804	äº‹æ€	shĂ¬tĂ i	tĂ¬nh tháº¿, tĂ¬nh hĂ¬nh	\N	40
2805	å°¸ä½“	shÄ«tÇ	thá»ƒ thi, tá»­ thi	\N	40
2806	çŸ³å¤´	shĂ­tou	Ä‘Ă¡	\N	21
2808	å¤±æœ›	shÄ«wĂ ng	tháº¥t vá»ng	\N	34
2809	ç¤ºå¨	shĂ¬wÄ“i	thá»‹ uy, ra oai	\N	40
2810	é£Ÿç‰©	shĂ­wĂ¹	thá»©c Äƒn	\N	30
2811	äº‹å¡	shĂ¬wĂ¹	cĂ´ng viá»‡c	\N	34
2813	å¤±è¯¯	shÄ«wĂ¹	lá»—i láº§m, sai láº§m	\N	34
2815	è§†çº¿	shĂ¬xiĂ n	Ä‘Æ°á»ng nhĂ¬n, táº§m máº¯t	\N	40
2816	äº‹å…ˆ	shĂ¬xiÄn	trÆ°á»›c, trÆ°á»›c tiĂªn	\N	34
2817	äº‹é¡¹	shĂ¬xiĂ ng	háº¡ng má»¥c cĂ´ng viá»‡c	\N	34
2819	è§†é‡	shĂ¬yÄ›	pháº¡m vi nhĂ¬n, táº§m nhĂ¬n	\N	34
2821	é€‚åº”	shĂ¬yĂ¬ng	thĂ­ch á»©ng, há»£p vá»›i	\N	34
2822	å¤±æ‹	shÄ«liĂ n	tháº¥t tĂ¬nh	\N	40
3037	ä½“ç§¯	tÇjÄ«	thá»ƒ tĂ­ch	\N	40
2833	ç«–	shĂ¹	tháº³ng Ä‘á»©ng	\N	30
2834	ä¹¦	shÅ«	sĂ¡ch	\N	32
2843	æ¶®ç«é”…	shuĂ nhuÇ’guÅ	láº©u nhĂºng	\N	24
2845	åŒèƒèƒ	shuÄngbÄotÄi	anh em sinh Ä‘Ă´i	\N	22
2861	æ°´åˆ©	shuÇlĂ¬	thá»§y lá»£i	\N	30
2866	ä¹¦æ¶	shÅ«jiĂ 	giĂ¡ sĂ¡ch	\N	32
2871	æ•°ç 	shĂ¹mÇ	ká»¹ thuáº­t sá»‘	\N	30
2875	é¡ºåˆ©	shĂ¹nlĂ¬	thuáº­n lá»£i	\N	30
2884	å±äº	shÇ”yĂº	thuá»™c vá»	\N	30
2887	å››	sĂ¬	bá»‘n	\N	21
2824	æ‰‹è‰º	shÇ’uyĂ¬	tay nghá», ká»¹ thuáº­t	\N	40
2895	æ€è€ƒ	sÄ«kÇo	suy nghÄ©	\N	32
2826	æ”¶éŸ³æœº	shÅuyÄ«njÄ«	radio	\N	34
2827	æˆäºˆ	shĂ²uyÇ”	trao táº·ng	\N	34
2828	æ‰‹æŒ‡	shÇ’uzhÇ	ngĂ³n tay	\N	34
2829	å—ç½ª	shĂ²uzuĂ¬	mang váº¡, bá»‹ giĂ y vĂ²	\N	40
2830	æ•°	shĂ¹	sá»‘, Ä‘áº¿m	\N	21
2831	æŸ	shĂ¹	bĂ³	\N	34
2832	æ ‘	shĂ¹	cĂ¢y	\N	25
2900	æ€ç»´	sÄ«wĂ©i	tÆ° duy, suy nghÄ©	\N	27
2903	æ€ç»ª	sÄ«xĂ¹	tĂ¢m tÆ°, Ă½ nghÄ©	\N	27
2835	è¾“	shÅ«	thua	\N	30
2836	è€	shuÇ	chÆ¡i	\N	34
2837	å¸…	shuĂ i	Ä‘áº¹p trai	\N	40
2839	æ‘”	shuÄi	ngĂ£, rÆ¡i	\N	34
2840	è¡°è€	shuÄilÇo	giĂ  yáº¿u	\N	34
2841	ç‡é¢†	shuĂ ilÇng	dáº«n Ä‘áº§u, chá»‰ huy	\N	24
2842	ç”©æ‰	shuÇidiĂ o	vá»©t bá», trĂºt bá»	\N	34
2905	å››è‚¢	sĂ¬zhÄ«	tá»© chi, chĂ¢n tay	\N	24
2844	åŒ	shuÄng	Ä‘Ă´i, hai	\N	34
2922	éæ‰‹	suĂ­shÇ’u	tiá»‡n tay, thuáº­n tay	\N	40
2846	åŒæ–¹	shuÄngfÄng	cáº£ hai bĂªn	\N	40
2848	åˆ·ç‰™	shuÄyĂ¡	Ä‘Ă¡nh rÄƒng	\N	39
2849	é¼ æ ‡	shÇ”biÄo	chuá»™t mĂ¡y tĂ­nh	\N	34
2850	è”¬èœ	shÅ«cĂ i	rau	\N	26
2851	èˆ’ç•…	shÅ«chĂ ng	khoan khoĂ¡i, dá»… chá»‹u	\N	34
2852	ä¹¦æ³•	shÅ«fÇ	thÆ° phĂ¡p	\N	30
2853	æŸç¼	shĂ¹fĂ¹	rĂ ng buá»™c, gĂ² bĂ³	\N	34
2854	èˆ’æœ	shÅ«fu	thá»a mĂ¡i, dá»… chá»‹u	\N	34
2855	ç–å¿½	shÅ«hu	sÆ¡ suáº¥t	\N	34
2856	è°	shuĂ­	ai	\N	40
2857	ç¨	shuĂ¬	thuáº¿	\N	30
2858	æ°´	shuÇ	nÆ°á»›c	\N	34
2860	ç¡è§‰	shuĂ¬jiĂ o	ngá»§	\N	21
2928	å­™å­	sÅ«nzi	chĂ¡u trai	\N	24
2862	æ°´é¾™å¤´	shuÇlĂ³ngtĂ³u	vĂ²i nÆ°á»›c	\N	34
2863	æ°´å¹³	shuÇpĂ­ng	trĂ¬nh Ä‘á»™	\N	34
2864	ä¹¦ç±	shÅ«jĂ­	sĂ¡ch vá»Ÿ	\N	34
2865	ä¹¦è®°	shÅ«jĂ¬	bĂ­ thÆ°	\N	30
2867	æ•°æ®	shĂ¹jĂ¹	dá»¯ liá»‡u	\N	40
2869	ç†Ÿç»ƒ	shĂºliĂ n	thĂ nh tháº¡o, thuáº§n thá»¥c	\N	30
2870	æ•°é‡	shĂ¹liĂ ng	sá»‘ lÆ°á»£ng	\N	34
2872	ä¹¦é¢	shÅ«miĂ n	vÄƒn báº£n	\N	34
2873	æ•°ç›®	shĂ¹mĂ¹	con sá»‘	\N	34
2874	é¡ºä¾¿	shĂ¹nbiĂ n	nhĂ¢n tiá»‡n	\N	40
2876	é¡ºåº	shĂ¹nxĂ¹	tráº­t tá»±, thá»© tá»±	\N	30
2877	è¯´ä¸å®	shuÅ bu dĂ¬ng	cĂ³ thá»ƒ, chÆ°a biáº¿t chá»«ng	\N	34
2878	è¯´æ˜	shuÅmĂ­ng	thuyáº¿t minh, giáº£i thĂ­ch	\N	30
2879	è¯´æœ	shuÅfĂº	thuyáº¿t phá»¥c	\N	30
2880	æœ”	shuĂ²	Ä‘áº§u thĂ¡ng	\N	30
2881	è¾“å…¥	shÅ«rĂ¹	nháº­p vĂ o	\N	40
2883	ç†Ÿæ‚‰	shĂºxÄ«	quen thuá»™c	\N	34
2885	æ•°å­—	shĂ¹zĂ¬	con sá»‘, sá»‘	\N	34
2886	æ¢³å­	shÅ«zi	lÆ°á»£c, cĂ¡i lÆ°á»£c	\N	34
2888	æ­»	sÇ	cháº¿t	\N	40
2889	æ’•	sÄ«	xĂ© rĂ¡ch	\N	40
2890	æ­»äº¡	sÇwĂ¡ng	cháº¿t, tá»­ vong	\N	34
2891	å¸æ³•	sÄ«fÇ	tÆ° phĂ¡p	\N	30
2893	ä¼¼ä¹	sĂ¬hÅ«	cĂ³ váº» nhÆ°	\N	34
2894	å¸æœº	sÄ«jÄ«	lĂ¡i xe	\N	28
2896	æ€å¿µ	sÄ«niĂ n	nhá»›	\N	34
2897	ç§äºº	sÄ«rĂ©n	riĂªng tÆ°, cĂ¡ nhĂ¢n	\N	40
2898	æ€æƒ³	sÄ«xiÇng	tÆ° tÆ°á»Ÿng, tÆ° duy	\N	34
2899	æ€ç´¢	sÄ«suÇ’	suy nghÄ©	\N	40
2901	æ–¯æ–‡	sÄ«wĂ©n	nhĂ£ nháº·n, lá»‹ch sá»±	\N	30
2904	é¥²å…»	sĂ¬yÇng	chÄƒn nuĂ´i	\N	34
2906	ç§è‡ª	sÄ«zĂ¬	tá»± Ă½, má»™t mĂ¬nh	\N	34
2907	é€	sĂ²ng	táº·ng, Ä‘Æ°a, tiá»…n	\N	40
2908	è‰˜	sÅu	con (tĂ u, thuyá»n)	\N	34
2909	ç®—	suĂ n	tĂ­nh toĂ¡n, Ä‘áº¿m	\N	34
2910	é…¸	suÄn	chua	\N	40
2911	ç®—äº†	suĂ nle	thĂ´i Ä‘Æ°á»£c rá»“i	\N	35
2912	ç®—æ•°	suĂ nshĂ¹	tĂ­nh, Ä‘áº¿m	\N	40
2913	é€Ÿåº¦	sĂ¹dĂ¹	tá»‘c Ä‘á»™	\N	34
2914	ä¿—è¯	sĂºhuĂ 	tá»¥c ngá»¯	\N	33
2915	å²	suĂ¬	tuá»•i	\N	34
2916	ç¢	suĂ¬	vá»¡, nĂ¡t	\N	34
2917	éä¾¿	suĂ­biĂ n	tĂ¹y tiá»‡n, tĂ¹y Ă½	\N	40
2918	é§é“	suĂ¬dĂ o	Ä‘Æ°á»ng háº§m	\N	34
2919	éå³	suĂ­jĂ­	ngay láº­p tá»©c	\N	30
2920	è™½ç„¶	suÄ«rĂ¡n	tuy, máº·c dĂ¹	\N	27
2923	éæ„	suĂ­yĂ¬	tĂ¹y Ă½	\N	27
2924	éè‘—	suĂ­zhe	theo, cĂ¹ng vá»›i	\N	34
2925	å¡‘æ–™è¢‹	sĂ¹liĂ odĂ i	tĂºi ni-lĂ´ng	\N	34
2926	æŸå	sÇ”nhuĂ i	hÆ° há»ng	\N	34
2927	æŸå¤±	sÇ”nshÄ«	thua thiá»‡t, máº¥t mĂ¡t	\N	40
2929	æ‰€	suÇ’	chá»—, nÆ¡i	\N	35
2930	é”	suÇ’	khoĂ¡	\N	34
2931	ç¼©çŸ­	suÅduÇn	rĂºt ngáº¯n	\N	34
2952	å°é£	tĂ¡ifÄ“ng	bĂ£o	\N	30
2972	å¦ç‡	tÇnshuĂ i	tháº³ng tháº¯n, bá»™c trá»±c	\N	30
3007	å¤©ç©º	tiÄnkÅng	báº§u trá»i	\N	24
3008	å¤©ä¼¦ä¹‹ä¹	tiÄnlĂºn zhÄ« lĂ¨	niá»m vui gia Ä‘Ă¬nh	\N	22
2932	ç´¢èµ”	suÇ’pĂ©i	bá»“i thÆ°á»ng	\N	34
2933	æ‰€è°“	suÇ’wĂ¨i	cĂ¡i gá»i lĂ 	\N	35
2934	ç¼©å°	suÅxiÇo	thu nhá»	\N	34
2935	ç¼©å†™	suÅxiÄ›	viáº¿t táº¯t	\N	40
2936	æ‰€æœ‰	suÇ’yÇ’u	táº¥t cáº£, toĂ n bá»™	\N	35
2937	å®¿èˆ	sĂ¹shĂ¨	kĂ½ tĂºc xĂ¡	\N	27
2939	è¯‰è®¼	sĂ¹sĂ²ng	kiá»‡n tá»¥ng	\N	34
2940	ç´ è´¨	sĂ¹zhĂ¬	tá»‘ cháº¥t	\N	34
2941	å¡‘é€ 	sĂ¹zĂ o	náº·n, táº¡o hĂ¬nh	\N	34
2942	å¡”	tÇ	thĂ¡p	\N	34
2943	ä»–	tÄ	Ă´ng áº¥y, chĂº áº¥y, anh áº¥y	\N	34
2944	å¡Œ	tÄ	sáº­p	\N	33
2945	å¥¹	tÄ	bĂ  áº¥y, cĂ´ áº¥y, chá»‹ áº¥y	\N	34
2946	å®ƒ	tÄ	nĂ³	\N	34
2948	æ¬	tĂ¡i	nĂ¢ng lĂªn, khiĂªng, nháº¥c	\N	40
2949	å¤ª	tĂ i	cá»±c, nháº¥t, quĂ¡, láº¯m	\N	40
2950	æ³°æ–—	tĂ idÇ’u	ngĂ´i sao sĂ¡ng, nhĂ¢n váº­t vÄ© Ä‘áº¡i	\N	40
2951	æ€åº¦	tĂ idĂ¹	thĂ¡i Ä‘á»™	\N	34
2954	å°é˜¶	tĂ¡ijiÄ“	báº­c thá»m	\N	21
2955	å¤ªç©º	tĂ ikÅng	vÅ© trá»¥, báº§u trá»i cao	\N	34
2956	å¤ªå¤ª	tĂ itai	vá»£	\N	34
2957	å¤ªé˜³	tĂ iyĂ¡ng	máº·t trá»i	\N	34
2958	è°ˆ	tĂ¡n	nĂ³i chuyá»‡n, bĂ n luáº­n	\N	34
2959	æ‘å„¿	tÄnr	sáº¡p, quáº§y hĂ ng	\N	40
2960	å¼¹é’¢ç´	tĂ¡n gÄngqĂ­n	Ä‘Ă¡nh Ä‘Ă n piano	\N	34
2961	å¦ç™½	tÇnbĂ¡i	tháº³ng tháº¯n	\N	30
2962	æ¢æµ‹	tĂ ncĂ¨	thÄƒm dĂ²	\N	34
2963	ç³–	tĂ¡ng	Ä‘Æ°á»ng, káº¹o	\N	34
2964	èºº	tÇng	náº±m	\N	40
2965	çƒ«	tĂ ng	nĂ³ng, bá»ng	\N	34
2967	å ‚	tĂ¡ng	phĂ²ng lá»›n, nhĂ  chĂ­nh	\N	34
2968	å¡˜	tĂ¡ng	ao, Ä‘áº§m, há»“	\N	34
2969	å€˜è‹¥	tÇngruĂ²	náº¿u nhÆ°, giáº£ sá»­	\N	40
2970	å¹	tĂ n	thá»Ÿ dĂ i	\N	34
2971	ç˜«ç—ª	tÄnhuĂ n	báº¡i liá»‡t	\N	40
2973	è°ˆåˆ¤	tĂ¡npĂ n	cuá»™c Ä‘Ă m phĂ¡n	\N	34
2974	å¹æ°”	tĂ nqĂ¬	thá»Ÿ dĂ i	\N	34
2976	æ¢è®¨	tĂ ntÇo	tháº£o luáº­n, bĂ n báº¡c	\N	34
2977	æ¢æœ›	tĂ nwĂ ng	thÄƒm há»i, viáº¿ng thÄƒm	\N	34
2978	è´ªæ±¡	tÄnwÅ«	tham Ă´, tham nhÅ©ng	\N	34
2979	å¼¹æ€§	tĂ¡nxĂ¬ng	Ä‘Ă n há»“i, linh hoáº¡t	\N	34
2980	æ¡ƒ	tĂ¡o	quáº£ Ä‘Ă o	\N	34
2981	é€ƒ	tĂ¡o	trá»‘n thoĂ¡t	\N	34
2982	å¥—	tĂ o	bá»™, táº­p	\N	34
2984	è®¨ä»·è¿˜ä»·	tÇojiĂ  huĂ¡njiĂ 	máº·c cáº£, tráº£ giĂ¡	\N	37
2985	è®¨è®º	tÇolĂ¹n	tháº£o luáº­n	\N	34
2986	æ·˜æ°”	tĂ¡oqĂ¬	nghá»‹ch ngá»£m	\N	34
2987	é€ƒé¿	tĂ¡obĂ¬	trá»‘n trĂ¡nh	\N	34
2988	è®¨åŒ	tÇoyĂ n	ghĂ©t, chĂ¡n ghĂ©t	\N	30
2989	è¸å®	tÄshi	chĂ¢n tháº­t, thá»±c táº¿	\N	30
2990	ç‰¹åˆ«	tĂ¨biĂ©	Ä‘áº·c biá»‡t	\N	34
2991	ç‰¹é•¿	tĂ¨chĂ¡ng	sá»Ÿ trÆ°á»ng	\N	34
2992	ç‰¹ç‚¹	tĂ¨diÇn	Ä‘áº·c Ä‘iá»ƒm	\N	34
2994	ç–¼	tĂ©ng	Ä‘au	\N	24
2995	ç–¼çˆ±	tĂ©ngâ€™Ă i	thÆ°Æ¡ng yĂªu	\N	34
2996	ç‰¹è‰²	tĂ¨sĂ¨	Ä‘áº·c sáº¯c	\N	21
2997	ç‰¹æ„	tĂ¨yĂ¬	cá»‘ Ă½, Ä‘áº·c biá»‡t lĂ 	\N	34
2998	ç‰¹å¾	tĂ¨zhÄ“ng	Ä‘áº·c trÆ°ng	\N	34
2999	å‰”	ti	nháº·t ra, gá»¡ ra	\N	40
3000	é¢˜	tĂ­	Ä‘á» má»¥c, Ä‘á» tĂ i	\N	40
3001	è¸¢è¶³çƒ	tÄ« zĂºqiĂº	Ä‘Ă¡ bĂ³ng	\N	34
3002	ç”œ	tiĂ¡n	ngá»t	\N	34
3003	èˆ”	tiÇn	liáº¿m	\N	40
3005	ç”°å¾„	tiĂ¡njĂ¬ng	Ä‘iá»n kinh	\N	40
3006	å¡«ç©º	tiĂ¡nkĂ²ng	Ä‘iá»n vĂ o chá»— trá»‘ng	\N	40
3009	å¤©æ°”	tiÄnqĂ¬	thá»i tiáº¿t	\N	30
3010	å¤©ç„¶æ°”	tiÄnrĂ¡nqĂ¬	khĂ­ Ä‘á»‘t tá»± nhiĂªn	\N	34
3011	å¤©ç”Ÿ	tiÄnshÄ“ng	trá»i sinh	\N	34
3012	å¤©å ‚	tiÄntĂ¡ng	thiĂªn Ä‘Æ°á»ng	\N	34
3013	å¤©æ–‡	tiÄnwĂ©n	thiĂªn vÄƒn há»c	\N	34
3014	ç”°é‡	tiĂ¡nyÄ›	Ä‘á»“ng ruá»™ng	\N	34
3016	æ¡	tiĂ¡o	cĂ nh, máº£nh, sá»£i, con (ráº¯n, cĂ¡,â€¦)	\N	34
3017	æŒ‘æ‹¨	tiÇobÅ	gĂ¢y xĂ­ch mĂ­ch	\N	40
3018	è°ƒå’Œ	tiĂ¡ohĂ©	hĂ²a giáº£i	\N	35
3019	è°ƒè‚	tiĂ¡ojiĂ©	Ä‘iá»u chá»‰nh	\N	40
3020	æ¡ä»¶	tiĂ¡ojiĂ n	Ä‘iá»u kiá»‡n	\N	40
3021	è°ƒæ•´	tiĂ¡ozhÄ›ng	Ä‘iá»u chá»‰nh	\N	40
3022	è°ƒè§£	tiĂ¡ojiÄ›	hĂ²a giáº£i	\N	34
3023	æ¡æ¬¾	tiĂ¡okuÇn	Ä‘iá»u khoáº£n	\N	34
3025	è°ƒæ–™	tiĂ¡oliĂ o	Ä‘á»“ gia vá»‹	\N	34
3026	è°ƒç®	tiĂ¡opĂ­	nghá»‹ch ngá»£m	\N	34
3027	æŒ‘å‰”	tiÄotĂ¬	soi mĂ³i, báº¯t lá»—i	\N	40
3028	æŒ‘é€‰	tiÄoxuÇn	lá»±a chá»n	\N	34
3029	æŒ‘æˆ˜	tiÇozhĂ n	thĂ¡ch thá»©c	\N	30
3030	ææ‹”	tĂ­bĂ¡	Ä‘á» báº¡t, cáº¥t nháº¯c	\N	40
3031	é¢˜æ	tĂ­cĂ¡i	chá»§ Ä‘á», ná»™i dung	\N	34
3032	æå€¡	tĂ­chĂ ng	Ä‘á» xÆ°á»›ng, khá»Ÿi xÆ°á»›ng	\N	34
3033	æçº²	tĂ­gÄng	Ä‘á» cÆ°Æ¡ng, dĂ n Ă½	\N	34
3034	æé«˜	tĂ­gÄo	nĂ¢ng cao	\N	34
3035	æä¾›	tĂ­gÅng	cung cáº¥p	\N	34
3036	ä½“ä¼	tÇhuĂ¬	cáº£m nháº­n, nháº­n thá»©c	\N	40
3048	æå‰	tĂ­qiĂ¡n	sá»›m, trÆ°á»›c	\N	21
3112	é€ƒè„±	tuÅtuÅ	thoĂ¡t ra, thoĂ¡t khá»i	\N	40
3073	ç»Ÿç»Ÿ	tÇ’ngtÇ’ng	táº¥t cáº£	\N	25
3096	é€€	tuĂ¬	rĂºt lui, lĂ¹i láº¡i	\N	25
3099	æ¨è¿Ÿ	tuÄ«chĂ­	hoĂ£n láº¡i, trĂ¬ hoĂ£n	\N	25
3104	æ¨ç†	tuÄ«lÇ	suy luáº­n	\N	38
3105	æ¨è®º	tuÄ«lĂ¹n	suy luáº­n, lĂ½ luáº­n	\N	31
3123	å…”å­	tĂ¹zi	con thá»	\N	25
3111	åœŸå£¤	tÇ”rÇng	Ä‘áº¥t	\N	40
3137	ç©	wĂ¡n	chÆ¡i	\N	31
3038	ä½“é¢	tÇmiĂ n	váº» vang, danh giĂ¡	\N	40
3039	é¢˜ç›®	tĂ­mĂ¹	Ä‘á» má»¥c, tiĂªu Ä‘á»	\N	40
3040	ä½“è´´	tÇtiÄ“	chÄƒm sĂ³c, quan tĂ¢m	\N	34
3041	å¬	tÄ«ng	nghe	\N	33
3043	åœè½¦	tĂ­ngchÄ“	dá»«ng xe, Ä‘á»— xe	\N	34
3044	åœæ³	tĂ­ngbĂ³	cáº­p báº¿n, neo Ä‘áº­u	\N	34
3046	åœæ»	tĂ­ngzhĂ¬	Ä‘Ă¬nh trá»‡, dá»«ng láº¡i	\N	40
3047	äº­å­	tĂ­ngzi	Ä‘Ă¬nh, chĂ²i	\N	34
3049	æç¤º	tĂ­shĂ¬	nháº¯c nhá»Ÿ, gá»£i Ă½	\N	34
3050	æé—®	tĂ­wĂ¨n	Ä‘áº·t cĂ¢u há»i	\N	33
3051	ä½“ç³»	tÇxĂ¬	há»‡ thá»‘ng	\N	34
3052	ä½“å½¢	tÇxĂ­ng	hĂ¬nh thá»ƒ, vĂ³c dĂ¡ng	\N	34
3053	æé†’	tĂ­xÇng	nháº¯c nhá»Ÿ	\N	34
3054	ä½“éªŒ	tÇyĂ n	tráº£i nghiá»‡m, thá»­ nghiá»‡m	\N	40
3055	æè®®	tĂ­yĂ¬	Ä‘á» nghá»‹, Ä‘á» xuáº¥t	\N	40
3056	ä½“è‚²	tÇyĂ¹	thá»ƒ thao	\N	34
3057	é“œ	tĂ³ng	Ä‘á»“ng	\N	34
3058	æ¡¶	tÇ’ng	xĂ´, thĂ¹ng	\N	34
3060	é“œçŸ¿	tĂ³ng kuĂ ng	quáº·ng Ä‘á»“ng	\N	34
3061	åŒèƒ	tĂ³ngbÄo	Ä‘á»“ng bĂ o	\N	34
3062	é€å¸¸	tÅngchĂ¡ng	thĂ´ng thÆ°á»ng	\N	34
3063	ç»Ÿç­¹å…¼é¡¾	tÇ’ngchĂ³u jiÄngĂ¹	tĂ­nh toĂ¡n má»i bá»	\N	40
3064	é€è¿‡	tÅngguĂ²	vÆ°á»£t qua, thĂ´ng qua, Ä‘i qua	\N	34
3065	ç«¥è¯	tĂ³nghuĂ 	truyá»‡n cá»• tĂ­ch	\N	34
3066	ç»Ÿè®¡	tÇ’ngjĂ¬	thá»‘ng kĂª	\N	34
3067	ç—›è‹¦	tĂ²ngkÇ”	Ä‘au khá»•	\N	34
3068	ç—›å¿«	tĂ²ngkuĂ i	vui sÆ°á»›ng, dá»… chá»‹u	\N	34
3070	åŒæ—¶	tĂ³ngshĂ­	Ä‘á»“ng thá»i	\N	34
3071	åŒäº‹	tĂ³ngshĂ¬	Ä‘á»“ng nghiá»‡p	\N	34
3072	é€ä¿—	tÅngsĂº	phá»• biáº¿n, thĂ´ng tá»¥c	\N	34
3074	åŒå­¦	tĂ³ngxuĂ©	báº¡n há»c	\N	34
3075	é€è®¯	tÅngxĂ¹n	truyá»n thĂ´ng	\N	34
3076	ç»Ÿä¸€	tÇ’ngyÄ«	thá»‘ng nháº¥t	\N	34
3077	é€ç”¨	tÅngyĂ²ng	chung dĂ¹ng, thĂ´ng dá»¥ng	\N	34
3078	ç»Ÿæ²»	tÇ’ngzhĂ¬	thá»‘ng trá»‹	\N	34
3079	é€çŸ¥	tÅngzhÄ«	thĂ´ng bĂ¡o	\N	34
3080	å¤´å‘	tĂ³ufa	tĂ³c	\N	34
3081	å¤´	tĂ³u	Ä‘áº§u	\N	24
3082	é€æ˜	tĂ²umĂ­ng	trong suá»‘t, minh báº¡ch	\N	34
3083	æ•ç¥¨	tĂ³upiĂ o	bá» phiáº¿u	\N	40
3084	æ•æ·	tĂ³uzhĂ¬	nĂ©m, quÄƒng	\N	40
3085	æ•èµ„	tĂ³uzÄ«	Ä‘áº§u tÆ°	\N	38
3087	å›¢	tuĂ¡n	nhĂ³m, Ä‘oĂ n	\N	34
3088	å›¾æ¡ˆ	tĂºâ€™Ă n	hoa vÄƒn, hĂ¬nh váº½	\N	40
3089	å›¢ç»“	tuĂ¡njiĂ©	Ä‘oĂ n káº¿t	\N	34
3090	å›¢ä½“	tuĂ¡ntÇ	táº­p thá»ƒ, Ä‘oĂ n thá»ƒ	\N	34
3091	å›¢å‘˜	tuĂ¡nyuĂ¡n	Ä‘oĂ n viĂªn	\N	34
3092	çªå‡º	tÅ«chÅ«	ná»•i báº­t, xuáº¥t sáº¯c	\N	40
3093	å¾’å¼Ÿ	tĂºdĂ¬	Ä‘á»“ Ä‘á»‡	\N	34
3094	åœŸè±†	tÇ”dĂ²u	khoai tĂ¢y	\N	34
3097	é€€æ­¥	tuĂ¬bĂ¹	thá»¥t lĂ¹i, Ä‘i lĂ¹i	\N	30
3098	æ¨æµ‹	tuÄ«cĂ¨	suy Ä‘oĂ¡n, dá»± Ä‘oĂ¡n	\N	34
3100	æ¨è¾	tuÄ«cĂ­	tá»« chá»‘i	\N	34
3101	æ¨ç¿»	tuÄ«fÄn	láº­t Ä‘á»•, Ä‘áº£o ngÆ°á»£c	\N	34
3102	æ¨å¹¿	tuÄ«guÇng	má»Ÿ rá»™ng, phá»• biáº¿n	\N	34
3106	æ¨é”€	tuÄ«xiÄo	bĂ¡n hĂ ng	\N	40
3107	é€€ä¼‘	tuĂ¬xiÅ«	nghá»‰ hÆ°u	\N	40
3108	é€”å¾„	tĂºjĂ¬ng	con Ä‘Æ°á»ng, cĂ¡ch thá»©c	\N	34
3109	æ¶‚æ¹	tĂºmÇ’	bĂ´i, quĂ©t, tĂ´	\N	40
3110	å± æ€	tĂºshÄ	tĂ n sĂ¡t, Ä‘á»“ sĂ¡t	\N	34
3113	æ‹–	tuÅ	kĂ©o, lĂ´i	\N	40
3114	è„±	tuÅ	cá»Ÿi, thoĂ¡t, gá»¡ ra	\N	40
3116	æ‹–æ‹‰	tuÅlÄ	kĂ©o lĂª, lá» má»	\N	34
3117	æ‹“å±•	tuĂ²zhÇn	má»Ÿ rá»™ng, phĂ¡t triá»ƒn	\N	34
3118	æ¤­åœ†	tuÇ’yuĂ¡n	hĂ¬nh báº§u dá»¥c	\N	24
3119	æ‰˜è¿	tuÅyĂ¹n	á»§y thĂ¡c váº­n chuyá»ƒn	\N	34
3120	çªç ´	tÅ«pĂ²	Ä‘á»™t phĂ¡	\N	34
3121	çªç„¶	tÅ«rĂ¡n	Ä‘á»™t nhiĂªn	\N	34
3122	å›¾ä¹¦é¦†	tĂºshÅ« guÇn	thÆ° viá»‡n	\N	40
3124	å“‡	wa	oa, oĂ , oe, á»“	\N	34
3125	å¤–	wĂ i	ngoĂ i	\N	34
3127	å¤–è¡¨	wĂ ibiÇo	váº» ngoĂ i, bá» ngoĂ i	\N	40
3128	å¤–è¡Œ	wĂ ihĂ¡ng	ngÆ°á»i ngoáº¡i nghá»	\N	40
3129	å¤–äº¤	wĂ ijiÄo	ngoáº¡i giao	\N	34
3130	å¤–ç•Œ	wĂ ijiĂ¨	tháº¿ giá»›i bĂªn ngoĂ i	\N	34
3131	æ­ªæ›²	wÄiqÅ«	xuyĂªn táº¡c	\N	34
3132	å¤–å‘	wĂ ixiĂ ng	hÆ°á»›ng ngoáº¡i	\N	34
3134	æŒ–æ˜	wÄjuĂ©	khai quáº­t, Ä‘Ă o bá»›i	\N	40
3135	ä¸¸	wĂ¡n	viĂªn thuá»‘c	\N	34
3136	å®Œ	wĂ¡n	xong, káº¿t thĂºc	\N	34
3138	ä¸‡	wĂ n	váº¡n, mÆ°á»i nghĂ¬n	\N	21
3140	å¼¯	wÄn	cong, uá»‘n cong	\N	34
3141	ä¸‡ä¸€	wĂ nyÄ«	váº¡n nháº¥t, ngá»™ nhá»¡	\N	34
3142	å®Œå¤‡	wĂ¡nbĂ¨i	hoĂ n toĂ n, Ä‘áº§y Ä‘á»§	\N	34
3194	å›´ç»•	wĂ©irĂ o	bao quanh, xoay quanh	\N	27
3149	ç½‘ç»œ	wÇngluĂ²	máº¡ng	\N	31
3177	ä½äº	wĂ¨iyĂº	náº±m á»Ÿ, tá»a láº¡c táº¡i	\N	40
3221	æ–‡æ˜	wĂ©nmĂ­ng	vÄƒn minh	\N	26
3152	å¾€å¾€	wÇngwÇng	thÆ°á»ng hay, thÆ°á»ng thÆ°á»ng	\N	30
3157	æŒ½æ•‘	wÇnjiĂ¹	cá»©u vĂ£n, cá»©u giĂºp	\N	31
3161	ç©å…·	wĂ¡njĂ¹	Ä‘á»“ chÆ¡i	\N	31
3139	ç¢—	wÇn	bĂ¡t	\N	21
3188	ç•æƒ§	wĂ¨ijĂ¹	sá»£ hĂ£i, e ngáº¡i	\N	21
3189	èƒƒå£	wĂ¨ikÇ’u	kháº©u vá»‹, sá»± thĂ¨m Äƒn	\N	24
3176	å§”å±ˆ	wÄ›iqu	oan á»©c, tá»§i thĂ¢n	\N	27
3203	å¨ä¿¡	wÄ“ixĂ¬n	uy tĂ­n	\N	33
3143	å®Œæ¯•	wĂ¡nbĂ¬	hoĂ n táº¥t	\N	34
3144	å®Œæˆ	wĂ¡nchĂ©ng	hoĂ n thĂ nh	\N	40
3145	ä¸‡åˆ†	wĂ nfÄ“n	vĂ´ cĂ¹ng	\N	34
3146	å®Œå…¨	wĂ¡nquĂ¡n	hoĂ n toĂ n	\N	34
3147	é¡½å¼º	wĂ¡nqiĂ¡ng	ngoan cÆ°á»ng	\N	34
3148	å®Œæ•´	wĂ¡nzhÄ›ng	hoĂ n chá»‰nh	\N	34
3210	é—®	wĂ¨n	há»i	\N	33
3150	ç½‘çƒ	wÇngqiĂº	bĂ³ng bĂ n	\N	34
3217	æ–‡å‡­	wĂ©npĂ­ng	báº±ng cáº¥p	\N	33
3153	å¦„æƒ³	wĂ ngxiÇng	má»™ng tÆ°á»Ÿng, áº£o tÆ°á»Ÿng	\N	34
3154	ç½‘ç«™	wÇngzhĂ n	trang web, website	\N	40
3155	ç‹å­	wĂ¡ngzÇ	hoĂ ng tá»­	\N	34
3156	æŒ½å›	wÇnhuĂ­	xoay chuyá»ƒn, cá»©u vĂ£n	\N	34
3239	äº”	wÇ”	nÄƒm	\N	21
3158	å®Œç¾	wĂ¡nmÄ›i	hoĂ n háº£o	\N	34
3159	æ™ä¸	wÇnshang	buá»•i tá»‘i	\N	34
3224	æ–‡å­¦	wĂ©nxuĂ©	vÄƒn há»c	\N	33
3162	å¨ƒå¨ƒ	wĂ¡wa	bĂºp bĂª	\N	40
3163	æŒ–	wÄ	Ä‘Ă o, bá»›i	\N	40
3164	ä½	wĂ¨i	vá»‹ trĂ­, chá»—, nÆ¡i	\N	34
3165	ä¸º	wĂ¨i	vĂ¬, Ä‘á»ƒ	\N	40
3166	å–‚	wĂ¨i	alo, nĂ y	\N	34
3167	ç•	wĂ¨i	sá»£, e ngáº¡i	\N	34
3168	èƒƒ	wĂ¨i	dáº¡ dĂ y	\N	24
3169	æœªå¿…	wĂ¨ibĂ¬	chÆ°a háº³n, khĂ´ng nháº¥t thiáº¿t	\N	34
3170	å”¯ç‹¬	wĂ©idĂº	chá»‰ riĂªng, duy nháº¥t	\N	40
3171	ä¸ºäº†	wĂ¨ile	Ä‘á»ƒ, vĂ¬	\N	35
3172	å›´	wĂ©i	vĂ¢y quanh, bao quanh	\N	27
3174	ç»´æ¤	wĂ©ihĂ¹	duy trĂ¬, báº£o vá»‡	\N	40
3175	å°¾å·´	wÄ›iba	Ä‘uĂ´i	\N	34
3227	æ–‡ç« 	wĂ©nzhÄng	bĂ i vÄƒn, bĂ i viáº¿t	\N	33
3229	é—®é¢˜	wĂ¨ntĂ­	váº¥n Ä‘á»	\N	32
3179	ç»´æŒ	wĂ©ichĂ­	duy trĂ¬	\N	40
3180	ä¼Ÿå¤§	wÄ›idĂ 	vÄ© Ä‘áº¡i	\N	40
3181	å‘³é“	wĂ¨idĂ o	mĂ¹i vá»‹, hÆ°Æ¡ng vá»‹	\N	34
3182	è¿æ³•	wĂ©ifÇ	vi pháº¡m phĂ¡p luáº­t	\N	40
3183	å¾®é£	wÄ“ifÄ“ng	vi phong, giĂ³ nháº¹	\N	34
3184	å¾®è§‚	wÄ“iguÄn	vi mĂ´	\N	34
3185	å±å®³	wÄ“ihĂ i	nguy háº¡i	\N	21
3186	å±æœº	wÄ“ijÄ«	nguy cÆ¡, khá»§ng hoáº£ng	\N	34
3187	å›´å·¾	wĂ©ijÄ«n	khÄƒn choĂ ng cá»•	\N	40
3232	æ–‡å­¦å®¶	wĂ©nxuĂ©jiÄ	nhĂ  vÄƒn há»c	\N	33
3219	æ–‡ä»¶	wĂ©njiĂ n	tĂ i liá»‡u	\N	40
3190	æœªæ¥	wĂ¨ilĂ¡i	tÆ°Æ¡ng lai	\N	34
3192	æœªå…	wĂ¨imiÇn	cĂ³ hÆ¡i, khĂ³ trĂ¡nh	\N	34
3193	ä¸ºé¾	wĂ©inĂ¡n	lĂºng tĂºng, khĂ³ xá»­	\N	34
3245	æ— è€»	wĂºchÇ	vĂ´ liĂªm sá»‰	\N	22
3195	ä¸ºä»€ä¹ˆ	wĂ¨ishĂ©nme	táº¡i sao, vĂ¬ sao	\N	34
3196	å«ç”Ÿé—´	wĂ¨ishÄ“ngjiÄn	nhĂ  vá»‡ sinh	\N	40
3197	ç»´ç”Ÿç´ 	wĂ©ishÄ“ngsĂ¹	vitamin	\N	34
3198	ä¸ºé¦–	wĂ©ishÇ’u	Ä‘á»©ng Ä‘áº§u, cáº§m Ä‘áº§u	\N	34
3199	å§”æ‰˜	wÄ›ituÅ	á»§y thĂ¡c, nhá» váº£	\N	34
3200	æ…°é—®	wĂ¨iwĂ¨n	thÄƒm há»i, an á»§i	\N	34
3201	å±é™©	wÄ“ixiÇn	nguy hiá»ƒm	\N	40
3202	å¨èƒ	wÄ“ixiĂ©	Ä‘e dá»a, uy hiáº¿p	\N	34
3204	å«æ˜Ÿ	wĂ¨ixÄ«ng	vá»‡ tinh	\N	40
3206	å”¯ä¸€	wĂ©iyÄ«	duy nháº¥t	\N	21
3207	å§”å‘˜	wÄ›iyuĂ¡n	á»§y viĂªn	\N	40
3208	ä¼ªé€ 	wÄ›izĂ o	giáº£ máº¡o	\N	34
3209	ä½ç½®	wĂ¨izhĂ¬	vá»‹ trĂ­, chá»—	\N	34
3211	å»	wÄ›n	hĂ´n	\N	34
3212	æ¸©å¸¦	wÄ“ndĂ i	Ă´n Ä‘á»›i	\N	34
3213	ç¨³å®	wÄ›ndĂ¬ng	á»•n Ä‘á»‹nh	\N	34
3214	æ¸©åº¦	wÄ“ndĂ¹	nhiá»‡t Ä‘á»™	\N	34
3216	æ–‡çŒ®	wĂ©nxiĂ n	vÄƒn hiáº¿n, tĂ i liá»‡u	\N	40
3218	æ–‡åŒ–	wĂ©nhuĂ 	vÄƒn hĂ³a	\N	34
3220	æ–‡å…·	wĂ©njĂ¹	dá»¥ng cá»¥ há»c táº­p	\N	34
3222	æ–‡ç›²	wĂ©nmĂ¡ng	mĂ¹ chá»¯	\N	33
3223	æ¸©æ–	wÄ“nnuÇn	áº¥m Ă¡p	\N	34
3225	æ–‡é›…	wĂ©nyÇ	tao nhĂ£	\N	34
3228	é—®å€™	wĂ¨nhĂ²u	há»i thÄƒm	\N	34
3230	å»åˆ	wÄ›nhĂ©	phĂ¹ há»£p, Äƒn khá»›p	\N	34
3231	æ–‡ç‰©	wĂ©nwĂ¹	di váº­t, cá»• váº­t	\N	34
3233	æ–‡ä¹¦	wĂ©nshÅ«	vÄƒn thÆ°	\N	30
3234	æˆ‘ä»¬	wÇ’men	chĂºng ta	\N	34
3236	æ¡æ‰‹	wĂ²shÇ’u	báº¯t tay	\N	34
3237	æ— 	wĂº	khĂ´ng cĂ³	\N	34
3238	é›¾	wĂ¹	sÆ°Æ¡ng mĂ¹	\N	34
3241	æ— è®ºå¦‚ä½•	wĂºlĂ¹n rĂºhĂ©	dĂ¹ sao Ä‘i ná»¯a	\N	34
3242	å¡å¿…	wĂ¹bĂ¬	nháº¥t thiáº¿t pháº£i	\N	40
3243	æ— æ¯”	wĂºbÇ	khĂ´ng gĂ¬ sĂ¡nh báº±ng	\N	34
3244	æ— å¿	wĂºchĂ¡ng	khĂ´ng hoĂ n láº¡i, khĂ´ng cĂ³ Ä‘á»n bĂ¹	\N	34
3246	æ— ä»	wĂºcĂ³ng	khĂ´ng biáº¿t tá»« Ä‘Ă¢u	\N	34
3247	èˆè¹ˆ	wÇ”dÇo	nháº£y mĂºa	\N	40
3249	æ— é	wĂºfÄ“i	cháº³ng qua lĂ , chá»‰ lĂ 	\N	22
3319	ç›¸å…³	xiÄngguÄn	cĂ³ liĂªn quan	\N	40
3277	ä¸‹	xiĂ 	xuá»‘ng, dÆ°á»›i, káº¿ tiáº¿p	\N	40
3284	ä¸‹ä»¤	xiĂ lĂ¬ng	ban lá»‡nh	\N	40
3287	å¼¦	xiĂ¡n	dĂ¢y Ä‘Ă n	\N	31
3349	å°åƒ	xiÇochÄ«	Ä‘á»“ Äƒn váº·t, mĂ³n Äƒn nháº¹	\N	26
3293	æ˜¾ç¤º	xiÇnshĂ¬	thá»ƒ hiá»‡n, trĂ¬nh bĂ y	\N	40
3250	ä¹Œé»‘	wÅ«hÄ“i	Ä‘en sĂ¬	\N	40
3251	è¯¯ä¼	wĂ¹huĂ¬	hiá»ƒu nháº§m	\N	34
3252	æ— èµ–	wĂºlĂ i	lÆ°u manh, vĂ´ láº¡i	\N	34
3253	æ— ç²¾æ‰“é‡‡	wĂºjÄ«ng dÇcÇi	phá» pháº¡c, á»§ rÅ©	\N	34
3255	æ— ç¤¼	wĂºlÇ	vĂ´ lá»…, báº¥t lá»‹ch sá»±	\N	40
3256	æ— è	wĂºliĂ¡o	nháº¡t nháº½o, vĂ´ vá»‹	\N	34
3257	æ— èƒ½	wĂºnĂ©ng	báº¥t lá»±c, vĂ´ nÄƒng	\N	34
3258	æ— è®º	wĂºlĂ¹n	báº¥t luáº­n	\N	40
3259	æ— è¾œ	wĂºgÅ«	vĂ´ tá»™i	\N	34
3260	æ— å¾®ä¸è‡³	wĂºwÄ“i bĂº zhĂ¬	chu Ä‘Ă¡o, tá»‰ má»‰	\N	34
3261	æ­¦å™¨	wÇ”qĂ¬	vÅ© khĂ­	\N	40
3262	æ— ç©·æ— å°½	wĂºqiĂ³ng wĂºjĂ¬n	vĂ´ cĂ¹ng vĂ´ táº­n	\N	34
3263	æ±¡æŸ“	wÅ«rÇn	Ă´ nhiá»…m	\N	34
3264	ä¾®è¾±	wÇ”rÇ”	lÄƒng nhá»¥c, sá»‰ nhá»¥c	\N	21
3265	å¡å®	wĂ¹shĂ­	thá»±c táº¿, thiáº¿t thá»±c	\N	30
3266	æ— æ‰€è°“	wĂºsuÇ’wĂ¨i	khĂ´ng sao, khĂ´ng quan trá»ng	\N	35
3267	æ— çŸ¥	wĂºzhÄ«	ngu dá»‘t	\N	34
3268	ç‰©è´¨	wĂ¹zhĂ¬	váº­t cháº¥t	\N	30
3270	å±‹å­	wÅ«zi	ngĂ´i nhĂ 	\N	34
3271	ç³»	xĂ¬	buá»™c, cá»™t, há»‡	\N	34
3272	æ´—	xÇ	giáº·t, rá»­a	\N	40
3273	æºª	xÄ«	suá»‘i, khe	\N	34
3274	è¥¿	xÄ«	tĂ¢y	\N	34
3275	ç³»é¢†å¸¦	xĂ¬ lÇngdĂ i	tháº¯t cĂ  váº¡t	\N	30
3278	ç	xiÄ	mĂ¹, mĂ¹ quĂ¡ng	\N	27
3279	å¤	xiĂ 	mĂ¹a hĂ¨	\N	30
3280	å³¡	xiĂ¡	háº»m nĂºi, khe sĂ¢u	\N	21
3281	ä¸‹é›¨	xiĂ  yÇ”	trá»i mÆ°a	\N	40
3282	ç‹­é˜	xiĂ¡â€™Ă i	háº¹p hĂ²i, thiá»ƒn cáº­n	\N	34
3285	é²œ	xiÄn	tÆ°Æ¡i, má»›i	\N	34
3286	å«Œ	xiĂ¡n	ghĂ©t, chĂ¡n ghĂ©t	\N	30
3288	è´¤	xiĂ¡n	hiá»n lĂ nh, tĂ i giá»i	\N	34
3289	å¿	xiĂ n	huyá»‡n	\N	34
3291	é™	xiĂ n	háº¡n, giá»›i háº¡n	\N	30
3292	æ˜¾	xiÇn	rĂµ rĂ ng, hiá»‡n rĂµ	\N	34
3294	æ˜¾ç„¶	xiÇnrĂ¡n	hiá»ƒn nhiĂªn, rĂµ rĂ ng	\N	34
3295	æ˜¾è‘—	xiÇnzhĂ¹	rĂµ rá»‡t, ná»•i báº­t	\N	40
3296	ç°åœº	xiĂ nchÇng	hiá»‡n trÆ°á»ng	\N	34
3297	ç°ä»£	xiĂ ndĂ i	hiá»‡n Ä‘áº¡i	\N	40
3298	é™·å®³	xiĂ nhĂ i	hĂ£m háº¡i	\N	34
3300	é¦…å„¿	xiĂ n er	nhĂ¢n (bĂ¡nh)	\N	21
3301	ç°æˆ	xiĂ nchĂ©ng	cĂ³ sáºµn, vá»‘n cĂ³	\N	34
3302	æ˜¾å¾—	xiÇnde	lá»™ ra, hiá»‡n ra	\N	35
3303	åƒ	xiĂ ng	giá»‘ng	\N	34
3304	å‘	xiĂ ng	hÆ°á»›ng, vá» phĂ­a	\N	34
3305	å··	xiĂ ng	ngĂµ, háº»m	\N	34
3306	é¡¹	xiĂ ng	háº¡ng má»¥c	\N	30
3307	å“	xiÇng	tiáº¿ng vang, vang lĂªn	\N	40
3308	æƒ³	xiÇng	nghÄ©, muá»‘n	\N	34
3309	é¦™	xiÄng	thÆ¡m	\N	34
3311	ç›¸å¤„	xiÄngchÇ”	sá»‘ng chung, hĂ²a há»£p	\N	34
3312	ç›¸å½“	xiÄngdÄng	tÆ°Æ¡ng Ä‘Æ°Æ¡ng, tÆ°Æ¡ng xá»©ng	\N	34
3313	ç›¸å¯¹	xiÄngduĂ¬	tÆ°Æ¡ng Ä‘á»‘i	\N	34
3314	ç›¸ç­‰	xiÄngdÄ›ng	báº±ng, ngang nhau	\N	34
3316	ç›¸è¾…ç›¸æˆ	xiÄngfÇ”xiÄngchĂ©ng	bá»• trá»£ cho nhau	\N	40
3317	ç›¸äº’	xiÄnghĂ¹	láº«n nhau	\N	24
3318	ç›¸è¿	xiÄngliĂ¡n	liĂªn káº¿t, ná»‘i liá»n	\N	34
3320	ç›¸å£°	xiĂ ngsheng	táº¥u hĂ i	\N	24
3321	å“äº®	xiÇngliĂ ng	vang dá»™i	\N	34
3322	äº«å—	xiÇngshĂ²u	hÆ°á»Ÿng thá»¥	\N	34
3323	æ©¡ç®	xiĂ ngpĂ­	cá»¥c táº©y	\N	34
3324	è±¡æ£‹	xiĂ ngqĂ­	cá» tÆ°á»›ng	\N	34
3325	ç›¸äº²ç›¸çˆ±	xiÄngqÄ«nxiÄngâ€™Ă i	yĂªu thÆ°Æ¡ng nhau	\N	34
3326	æƒ³è±¡	xiÇngxiĂ ng	tÆ°á»Ÿng tÆ°á»£ng	\N	34
3327	ç›¸ä¿¡	xiÄngxĂ¬n	tin tÆ°á»Ÿng	\N	34
3328	å“åº”	xiÇngyĂ¬ng	Ä‘Ă¡p láº¡i, hÆ°á»Ÿng á»©ng	\N	34
3329	ç›¸åº”	xiÄngyĂ¬ng	tÆ°Æ¡ng á»©ng	\N	34
3330	è±¡å¾	xiĂ ngzhÄ“ng	tÆ°á»£ng trÆ°ng	\N	34
3331	è´¤æƒ 	xiĂ¡nhuĂ¬	hiá»n thá»¥c	\N	40
3333	å…ˆè¿›	xiÄnjĂ¬n	tiĂªn tiáº¿n	\N	40
3334	ç¾¡æ…•	xiĂ nmĂ¹	ngÆ°á»¡ng má»™	\N	34
3335	é²œæ˜	xiÄnmĂ­ng	tÆ°Æ¡i sĂ¡ng, rĂµ nĂ©t	\N	34
3336	é²œè‰³	xiÄnyĂ n	sĂ¡ng, tÆ°Æ¡i Ä‘áº¹p, rá»±c rá»¡	\N	34
3337	çº¤ç»´	xiÄnwĂ©i	sá»£i, cháº¥t xÆ¡	\N	34
3338	ç°å®	xiĂ nshĂ­	thá»±c táº¿	\N	30
3339	ç°è±¡	xiĂ nxiĂ ng	hiá»‡n tÆ°á»£ng	\N	34
3340	çŒ®èº«	xiĂ nshÄ“n	hiáº¿n thĂ¢n, cá»‘ng hiáº¿n	\N	34
3341	é™åˆ¶	xiĂ nzhĂ¬	háº¡n cháº¿	\N	30
3342	å«Œå¼ƒ	xiĂ¡nqĂ¬	chĂª, ghĂ©t bá»	\N	34
3344	å«Œç–‘	xiĂ¡nyĂ­	nghi ngá»	\N	34
3345	ç°åœ¨	xiĂ nzĂ i	bĂ¢y giá»	\N	40
3346	ç°ç¶	xiĂ nzhuĂ ng	hiá»‡n tráº¡ng	\N	34
3347	ç¬‘	xiĂ o	cÆ°á»i	\N	34
3348	å°	xiÇo	nhá»	\N	34
3350	æ¶ˆé™¤	xiÄochĂº	loáº¡i bá», loáº¡i trá»«	\N	40
3352	æ¶ˆé˜²	xiÄofĂ¡ng	chá»¯a chĂ¡y, cá»©u há»a	\N	40
3363	å°éº¦	xiÇomĂ i	lĂºa mĂ¬	\N	40
3380	é‹	xiĂ©	giĂ y	\N	27
3447	ä¿¡å¿ƒ	xĂ¬nxÄ«n	niá»m tin	\N	40
3385	è¡€å‹	xiÄ›yÄ	huyáº¿t Ă¡p	\N	33
3388	é‹å­	xiĂ©zi	Ä‘Ă´i giĂ y	\N	27
3389	å†™	xiÄ›	viáº¿t	\N	33
3400	æ€§åˆ«	xĂ¬ngbiĂ©	giá»›i tĂ­nh	\N	30
3401	æ€§æ ¼	xĂ¬nggĂ©	tĂ­nh cĂ¡ch	\N	25
3404	è¥¿çº¢æŸ¿	xÄ«hĂ³ngshĂ¬	cĂ  chua	\N	25
3405	å–œæ¬¢	xÇhuan	thĂ­ch	\N	32
3414	ä¿¡å°	xĂ¬nfÄ“ng	phong bĂ¬, bao thÆ°	\N	30
3354	æ•ˆæœ	xiĂ oguÇ’	hiá»‡u quáº£	\N	40
3355	æ¶ˆè€—	xiÄohĂ o	tiĂªu hao	\N	34
3356	ç¬‘è¯	xiĂ ohuĂ 	truyá»‡n cÆ°á»i	\N	34
3357	æ¶ˆåŒ–	xiÄohuĂ 	tiĂªu hĂ³a	\N	34
3358	é”€æ¯	xiÄohuÇ	tiĂªu há»§y, phĂ¡ há»§y	\N	40
3359	å°ä¼™å­	xiÇohuÇ’zi	thanh niĂªn	\N	40
3360	æ¶ˆæ¯	xiÄoxi	tin tá»©c, thĂ´ng tin	\N	34
3361	æ¶ˆæ	xiÄojĂ­	tiĂªu cá»±c	\N	40
3364	æ¶ˆç­	xiÄomiĂ¨	tiĂªu diá»‡t	\N	40
3365	å°æ°”	xiÇoqĂ¬	keo kiá»‡t, bá»§n xá»‰n	\N	40
3366	å°æ—¶	xiÇoshĂ­	tiáº¿ng, giá»	\N	34
3367	æ¶ˆå¤±	xiÄoshÄ«	biáº¿n máº¥t	\N	34
3368	é”€å”®	xiÄoshĂ²u	bĂ¡n hĂ ng, tiĂªu thá»¥	\N	40
3369	å°è¯´	xiÇoshuÅ	tiá»ƒu thuyáº¿t	\N	30
3370	å°å·	xiÇotÅu	káº» trá»™m, tĂªn trá»™m	\N	34
3371	è‚–åƒ	xiĂ oxiĂ ng	chĂ¢n dung	\N	34
3372	å°å¿ƒ	xiÇoxÄ«n	cáº©n tháº­n	\N	30
3373	å°å¿ƒç¿¼ç¿¼	xiÇoxÄ«nyĂ¬yĂ¬	tháº­n trá»ng, tá»‰ má»‰	\N	34
3374	æ•ˆç›	xiĂ oyĂ¬	lá»£i Ă­ch	\N	34
3375	æ ¡é•¿	xiĂ ozhÇng	hiá»‡u trÆ°á»Ÿng	\N	34
3376	ä¸‹å±	xiĂ shÇ”	cáº¥p dÆ°á»›i	\N	34
3378	ç»†èƒ	xĂ¬bÄo	táº¿ bĂ o	\N	34
3379	æ–œ	xiĂ©	nghiĂªng, xiĂªn	\N	40
3429	å…´è¶£	xĂ¬ngqĂ¹	há»©ng thĂº	\N	30
3381	æºå¸¦	xiĂ©dĂ i	mang theo	\N	34
3382	åä¼	xiĂ©huĂ¬	hiá»‡p há»™i	\N	34
3383	åè°ƒ	xiĂ©tiĂ¡o	phá»‘i há»£p, Ä‘iá»u hĂ²a	\N	34
3384	æ³„æ¼	xiĂ¨lĂ²u	rĂ² rá»‰	\N	34
3440	ä¿¡èµ–	xĂ¬nlĂ i	tin cáº­y	\N	25
3387	åå©	xiĂ©zhĂ¹	giĂºp Ä‘á»¡, há»— trá»£	\N	34
3445	æ–°å¨˜	xÄ«nniĂ¡ng	cĂ´ dĂ¢u	\N	24
3452	å¿ƒè¡€	xÄ«nxuĂ¨	tĂ¢m huyáº¿t, tĂ¢m sá»©c	\N	24
3390	è°¢è°¢	xiĂ¨xie	cáº£m Æ¡n	\N	34
3391	æ–œå¡	xiĂ©pÅ	dá»‘c nghiĂªng	\N	34
3392	å¸	xiĂ¨	thĂ¡o dá»¡, dá»¡ hĂ ng	\N	34
3393	è¾›è‹¦	xÄ«nkÇ”	váº¥t váº£, cá»±c khá»•	\N	34
3394	æ–°	xÄ«n	má»›i	\N	34
3395	å¿ƒ	xÄ«n	tim, lĂ²ng	\N	34
3396	ä¿¡	xĂ¬n	thÆ°, tin, tĂ­n hiá»‡u	\N	30
3397	è¡Œå¨	xĂ­ngdĂ²ng	hĂ nh Ä‘á»™ng	\N	34
3398	è¡Œ	xĂ­ng	Ä‘Æ°á»£c, Ä‘i, lĂ m, giá»i	\N	34
3457	ä¿¡èª‰	xĂ¬nyĂ¹	danh dá»±, uy tĂ­n	\N	33
3402	è¡Œä¸º	xĂ­ngwĂ©i	hĂ nh vi	\N	30
3406	è¢­å‡»	xĂ­jĂ­	táº­p kĂ­ch, táº¥n cĂ´ng	\N	34
3407	ç»†è‚	xĂ¬jiĂ©	chi tiáº¿t	\N	40
3408	æˆå‰§	xĂ¬jĂ¹	ká»‹ch, tuá»“ng	\N	34
3409	ç»†èŒ	xĂ¬jÅ«n	vi khuáº©n	\N	40
3410	ç³»åˆ—	xĂ¬liĂ¨	chuá»—i, loáº¡t, hĂ ng loáº¡t	\N	34
3411	ç†„ç­	xÄ«miĂ¨	dáº­p táº¯t, táº¯t ngáº¥m	\N	34
3413	å¿ƒå¾—	xÄ«ndĂ©	tĂ¢m Ä‘áº¯c, Ä‘iá»u tĂ¢m Ä‘áº¯c	\N	35
3415	å§“	xĂ¬ng	há»	\N	34
3416	é†’	xÇng	tá»‰nh, tá»‰nh tĂ¡o	\N	34
3417	è…¥	xÄ«ng	tanh	\N	31
3418	å½¢æˆ	xĂ­ngchĂ©ng	hĂ¬nh thĂ nh	\N	30
3419	å¹¸ç¦	xĂ¬ngfĂº	háº¡nh phĂºc	\N	30
3420	æ€§æ„Ÿ	xĂ¬nggÇn	gá»£i cáº£m, háº¥p dáº«n	\N	34
3421	å…´é«˜é‡‡çƒˆ	xĂ¬nggÄocÇiliĂ¨	vĂ´ cĂ¹ng pháº¥n khá»Ÿi	\N	34
3422	å¹¸è¿	xĂ¬ngyĂ¹n	may máº¯n	\N	21
3423	è¡Œæç®±	xĂ­nglÇ xiÄng	va-li, hĂ nh lĂ½	\N	30
3424	å…´é†	xÄ«nglĂ³ng	hÆ°ng thá»‹nh, thá»‹nh vÆ°á»£ng	\N	34
3425	æ€§å‘½	xĂ¬ngmĂ¬ng	tĂ­nh máº¡ng, sinh má»‡nh	\N	40
3426	å…´ç››	xÄ«ngshĂ¨ng	hÆ°ng thá»‹nh	\N	34
3427	æ˜ŸæœŸ	xÄ«ngqÄ«	ngĂ y thá»©	\N	30
3430	è¡Œäºº	xĂ­ngrĂ©n	ngÆ°á»i Ä‘i bá»™	\N	40
3431	å½¢å®¹	xĂ­ngrĂ³ng	hĂ¬nh dung, miĂªu táº£	\N	40
3432	åˆ‘äº‹	xĂ­ngshĂ¬	hĂ¬nh sá»±	\N	40
3433	å½¢å¼	xĂ­ngshĂ¬	hĂ¬nh thá»©c	\N	30
3434	å½¢æ€	xĂ­ngtĂ i	hĂ¬nh thĂ¡i	\N	21
3435	å…´æ—º	xÄ«ngwĂ ng	hÆ°ng thá»‹nh, phá»“n vinh	\N	34
3436	å½¢è±¡	xĂ­ngxiĂ ng	hĂ¬nh tÆ°á»£ng, hĂ¬nh áº£nh	\N	34
3437	è¡Œæ”¿	xĂ­ngzhĂ¨ng	hĂ nh chĂ­nh	\N	22
3438	æ€§è´¨	xĂ¬ngzhĂ¬	tĂ­nh cháº¥t	\N	40
3439	ä¿¡å·	xĂ¬nhĂ o	tĂ­n hiá»‡u	\N	40
3442	å¿ƒç†	xÄ«nlÇ	tĂ¢m lĂ½	\N	34
3443	å¿ƒçµ	xÄ«nlĂ­ng	tĂ¢m linh	\N	34
3444	ä¿¡å¿µ	xĂ¬nniĂ n	niá»m tin, lĂ²ng tin	\N	34
3446	æ–°é²œ	xÄ«nxiÄn	tÆ°Æ¡i	\N	34
3449	ä¿¡ä½¿	xĂ¬nshÇ	sá»© giáº£, ngÆ°á»i Ä‘Æ°a tin	\N	34
3450	å¿ƒç—›	xÄ«ntĂ²ng	Ä‘au lĂ²ng, thÆ°Æ¡ng xĂ³t	\N	34
3451	æ¬£æ¬£å‘è£	xÄ«nxÄ«nxiĂ ngrĂ³ng	phĂ¡t triá»ƒn tÆ°Æ¡i tá»‘t, thá»‹nh vÆ°á»£ng	\N	34
3453	å¿ƒçœ¼å„¿	xÄ«nyÇnr	ná»™i tĂ¢m, lĂ²ng dáº¡	\N	34
3454	ä¿¡ä»°	xĂ¬nyÇng	tĂ­n ngÆ°á»¡ng	\N	34
3455	æ–°é¢–	xÄ«nyÇng	má»›i máº», Ä‘á»™c Ä‘Ă¡o	\N	40
3456	ä¿¡ç”¨å¡	xĂ¬nyĂ²ngkÇ	tháº» tĂ­n dá»¥ng	\N	40
3462	é›„å	xiĂ³nghĂ²u	hĂ¹ng háº­u	\N	24
3473	ä¿®	xiÅ«	sá»­a chá»¯a, tu sá»­a	\N	26
3474	ç»£	xiĂ¹	thĂªu	\N	37
3475	ä¿®ç†	xiÅ«lÇ	sá»­a chá»¯a	\N	26
3486	æ´—æ¾¡	xÇzÇo	táº¯m, táº¯m rá»­a	\N	39
3490	å®£ä¼ 	xuÄnchuĂ¡n	tuyĂªn truyá»n	\N	27
3495	å®£èª“	xuÄnshĂ¬	tuyĂªn thá»‡	\N	27
3496	é€‰æ‰‹	xuÇnshÇ’u	tuyá»ƒn thá»§, Ä‘áº¥u thá»§	\N	30
3508	å­¦ç”Ÿ	xuĂ©shÄ“ng	sinh viĂªn, há»c sinh	\N	32
3459	èƒ¸	xiÅng	ngá»±c	\N	21
3461	å‡¶æ¶	xiÅngâ€™Ă¨	hung Ă¡c	\N	34
3509	å­¦æœ¯	xuĂ©shĂ¹	há»c thuáº­t	\N	30
3463	èƒ¸æ€€	xiÅnghuĂ¡i	lĂ²ng dáº¡, táº¥m lĂ²ng	\N	34
3464	ç†çŒ«	xiĂ³ngmÄo	gáº¥u trĂºc	\N	24
3465	å‡¶æ‰‹	xiÅngshÇ’u	káº» giáº¿t ngÆ°á»i	\N	34
3466	èƒ¸è†›	xiÅngtĂ¡ng	lá»“ng ngá»±c	\N	34
3468	æ˜”æ—¥	xÄ«rĂ¬	ngĂ y xÆ°a, trÆ°á»›c kia	\N	40
3469	ç‰ºç‰²	xÄ«shÄ“ng	hi sinh	\N	40
3470	å¸æ”¶	xÄ«shÅu	háº¥p thá»¥, háº¥p thu	\N	30
3471	æ´—æ‰‹é—´	xÇshÇ’ujiÄn	nhĂ  vá»‡ sinh	\N	40
3472	ä¹ ä¿—	xĂ­sĂº	táº­p tá»¥c, phong tá»¥c	\N	34
3513	å­¦ä¹ 	xuĂ©xĂ­	há»c táº­p	\N	32
3524	æ®‰é“	xĂ¹ndĂ o	tá»­ vĂ¬ Ä‘áº¡o	\N	27
3532	åºè¨€	xĂ¹yĂ¡n	lá»i nĂ³i Ä‘áº§u	\N	24
3476	ä¼‘æ¯	xiÅ«xi	nghá»‰ ngÆ¡i	\N	34
3477	ä¼‘é—²	xiÅ«xiĂ¡n	nghá»‰ ngÆ¡i, giáº£i trĂ­	\N	34
3478	ä¿®å…»	xiÅ«yÇng	tu dÆ°á»¡ng, Ä‘iá»u dÆ°á»¡ng	\N	34
3479	å¸Œæœ›	xÄ«wĂ ng	hy vá»ng	\N	34
3481	ç»­	xĂ¹	tiáº¿p tá»¥c	\N	40
3482	å¤•é˜³	xÄ«yĂ¡ng	máº·t trá»i láº·n	\N	34
3483	æ´—è¡£æœº	xÇyÄ«jÄ«	mĂ¡y giáº·t	\N	40
3484	å¸å¼•	xÄ«yÇn	thu hĂºt, háº¥p dáº«n	\N	30
3485	å–œæ‚¦	xÇyuĂ¨	vui má»«ng, sung sÆ°á»›ng	\N	34
3535	ç‰™è†	yĂ¡gÄo	kem Ä‘Ă¡nh rÄƒng	\N	22
3487	ç»†è‡´	xĂ¬zhĂ¬	tá»‰ má»‰, ká»¹ lÆ°á»¡ng	\N	34
3488	å™è¿°	xĂ¹shĂ¹	tÆ°á»ng thuáº­t	\N	34
3489	å®£å¸ƒ	xuÄnbĂ¹	tuyĂªn bá»‘, cĂ´ng bá»‘	\N	34
3537	äºå†›	yĂ jÅ«n	Ă¡ quĂ¢n	\N	27
3491	å®£æ‰¬	xuÄnyĂ¡ng	tuyĂªn dÆ°Æ¡ng, ca ngá»£i	\N	34
3492	é€‰ä¸¾	xuÇnjÇ”	báº§u cá»­	\N	24
3493	æ—‹å¾‹	xuĂ¡nlÇœ	giai Ä‘iá»‡u	\N	40
3539	ç›	yĂ¡n	muá»‘i	\N	21
3550	ç¾è‚‰	yĂ¡ngrĂ²u	thá»‹t dĂª	\N	26
3497	æ‚¬æ®	xuĂ¡nshÅ«	khĂ¡c xa, chĂªnh lá»‡ch	\N	34
3498	æ‚¬å´–å³­å£	xuĂ¡nyĂ¡qiĂ obĂ¬	vĂ¡ch nĂºi hiá»ƒm trá»Ÿ	\N	34
3499	é€‰	xuÇn	chá»n, tuyá»ƒn chá»n	\N	34
3500	æ—‹è½¬	xuĂ¡nzhuÇn	quay trĂ²n, xoay chuyá»ƒn	\N	34
3501	è®¸å¤	xÇ”duÅ	nhiá»u, ráº¥t nhiá»u	\N	40
3502	è¡€	xuĂ¨	mĂ¡u	\N	24
3503	é›ª	xuÄ›	tuyáº¿t	\N	30
3504	å­¦å†	xuĂ©lĂ¬	há»c váº¥n, trĂ¬nh Ä‘á»™ há»c váº¥n	\N	34
3505	å­¦æœŸ	xuĂ©qÄ«	há»c ká»³	\N	34
3506	è™å¼±	xÅ«ruĂ²	suy yáº¿u	\N	34
3510	å­¦è¯´	xuĂ©shuÅ	há»c thuyáº¿t	\N	33
3511	å­¦ä½	xuĂ©wĂ¨i	há»c vá»‹	\N	34
3512	å­¦é—®	xuĂ©wĂ¨n	há»c váº¥n, tri thá»©c	\N	33
3514	å­¦æ ¡	xuĂ©xiĂ o	trÆ°á»ng há»c	\N	34
3515	è™å‡	xÅ«jiÇ	giáº£ táº¡o, giáº£ dá»‘i	\N	34
3516	é…—é…’	xĂ¹jiÇ”	say rÆ°á»£u, nghiá»‡n rÆ°á»£u	\N	34
3517	è®¸å¯	xÇ”kÄ›	giáº¥y phĂ©p	\N	40
3518	æ¤	xĂ¹	thÆ°Æ¡ng xĂ³t	\N	34
3519	å¾ªç¯	xĂºnhuĂ¡n	tuáº§n hoĂ n	\N	34
3520	è®­ç»ƒ	xĂ¹nliĂ n	huáº¥n luyá»‡n	\N	40
3521	å·¡é€»	xĂºnluĂ³	Ä‘i tuáº§n	\N	40
3522	å¯»è§…	xĂºnmĂ¬	tĂ¬m kiáº¿m	\N	40
3523	è¿…é€Ÿ	xĂ¹nsĂ¹	nhanh chĂ³ng	\N	34
3525	è¯¢é—®	xĂºnwĂ¨n	há»i, há»i thÄƒm	\N	34
3527	å¯»æ‰¾	xĂºnzhÇo	tĂ¬m kiáº¿m	\N	40
3528	ç†	xÅ«n	hun, xĂ´ng	\N	34
3529	å‹‹ç« 	xÅ«nzhÄng	huĂ¢n chÆ°Æ¡ng	\N	34
3530	è™ä¼ª	xÅ«wÄ›i	giáº£ dá»‘i, Ä‘áº¡o Ä‘á»©c giáº£	\N	34
3531	åºå·	xĂ¹hĂ o	sá»‘ thá»© tá»±	\N	21
3533	éœ€è¦	xÅ«yĂ o	cáº§n, cáº§n thiáº¿t	\N	40
3534	å‘€	ya	a, Ă , nhĂ©â€¦	\N	35
3536	æ¼é‡‘	yÄjÄ«n	tiá»n Ä‘áº·t cá»c	\N	34
3538	å‹å›	yÄlĂ¬	Ă¡p lá»±c	\N	33
3541	å»¶é•¿	yĂ¡nchĂ¡ng	kĂ©o dĂ i	\N	34
3542	æ¼”å‡º	yÇnchÅ«	biá»ƒu diá»…n	\N	40
3543	å…»	yÇng	nuĂ´i dÆ°á»¡ng	\N	34
3545	å…»æˆ	yÇngchĂ©ng	nuĂ´i náº¥ng, hĂ¬nh thĂ nh	\N	34
3546	æ©ç›–	yÇngĂ i	che Ä‘áº­y, bao phá»§	\N	34
3547	é˜³å…‰	yĂ¡ngguÄng	Ă¡nh sĂ¡ng máº·t trá»i	\N	34
3548	æ ·å“	yĂ ngpÇn	hĂ ng máº«u	\N	24
3549	æ°§æ°”	yÇngqĂ¬	oxy	\N	34
3552	å®´ä¼	yĂ nhuĂ¬	bá»¯a tiá»‡c	\N	40
3553	çœ¼å…‰	yÇnguÄng	Ă¡nh máº¯t, táº§m nhĂ¬n	\N	40
3554	æ²¿æµ·	yĂ¡nhÇi	duyĂªn háº£i	\N	40
3555	ä¸¥å¯’	yĂ¡nhĂ¡n	rĂ©t Ä‘áº­m, rĂ©t háº¡i	\N	34
3556	æ©æ¤	yÇnhĂ¹	che chá»Ÿ, báº£o vá»‡	\N	40
3558	è¨€è¡Œ	yĂ¡nxĂ­ng	lá»i nĂ³i vĂ  hĂ nh Ä‘á»™ng	\N	40
3559	ç ”ç©¶ç”Ÿ	yĂ¡njiÅ«shÄ“ng	nghiĂªn cá»©u sinh	\N	40
3560	ä¸¥è°¨	yĂ¡njÇn	nghiĂªm tĂºc, cáº©n trá»ng	\N	34
3561	ä¸¥å‰	yĂ¡nlĂ¬	nghiĂªm kháº¯c	\N	40
3562	è¨€è®º	yĂ¡nlĂ¹n	ngĂ´n luáº­n, lá»i bĂ n	\N	34
3582	æ‘‡	yĂ¡o	rung, láº¯c, Ä‘ung Ä‘Æ°a	\N	25
3615	ä¸€	yÄ«	sá»‘ má»™t	\N	21
3661	è¥ä¸	yĂ­ngyĂ¨	kinh doanh	\N	38
3583	è¯	yĂ o	thuá»‘c	\N	24
3616	äº¿	yĂ¬	má»™t trÄƒm triá»‡u	\N	21
3620	ä¸€è¾ˆå­	yÄ«bĂ¨izi	cáº£ Ä‘á»i, má»™t Ä‘á»i	\N	21
3623	é—äº§	yĂ­chÇn	di sáº£n	\N	38
3624	ç§»æ°‘	yĂ­mĂ­n	di dĂ¢n	\N	31
3626	ä¾æ¬¡	yÄ«cĂ¬	láº§n lÆ°á»£t, theo thá»© tá»±	\N	30
3628	ä¸€å®	yĂ­dĂ¬ng	nháº¥t Ä‘á»‹nh, cháº¯c cháº¯n	\N	31
3563	ä¸¥å¯†	yĂ¡nmĂ¬	cháº·t cháº½, kĂ­n Ä‘Ă¡o	\N	40
3564	æ·¹æ²¡	yÄnmĂ²	chĂ¬m ngáº­p, nháº¥n chĂ¬m	\N	40
3566	ç‚çƒ­	yĂ¡nrĂ¨	nĂ³ng bá»©c, gay gáº¯t	\N	34
3567	é¢œè‰²	yĂ¡nsĂ¨	mĂ u sáº¯c	\N	24
3568	çœ¼è‰²	yÇnsĂ¨	Ă¡nh máº¯t, nÄƒng lá»±c quan sĂ¡t	\N	34
3569	å»¶ä¼¸	yĂ¡nshÄ“n	kĂ©o dĂ i, má»Ÿ rá»™ng	\N	34
3570	çœ¼ç¥	yÇnshĂ©n	Ă¡nh máº¯t, thá»‹ lá»±c	\N	34
3572	æ©é¥°	yÇnshĂ¬	che giáº¥u, che Ä‘áº­y	\N	40
3573	éªŒæ”¶	yĂ nshÅu	nghiá»‡m thu	\N	30
3574	ä¸¥è‚ƒ	yĂ¡nsĂ¹	nghiĂªm tĂºc	\N	40
3575	åŒæ¶	yĂ nwĂ¹	ghĂ©t, chĂ¡n ghĂ©t	\N	30
3576	æ¼”ä¹ 	yÇnxĂ­	diá»…n táº­p	\N	40
3577	å»¶ç»­	yĂ¡nxĂ¹	tiáº¿p tá»¥c	\N	40
3579	æ¼”å‘˜	yÇnyuĂ¡n	diá»…n viĂªn	\N	40
3580	éªŒè¯	yĂ nzhĂ¨ng	kiá»ƒm chá»©ng, xĂ¡c nháº­n	\N	40
3581	æ¼”å¥	yÇnzĂ²u	diá»…n táº¥u, biá»ƒu diá»…n nháº¡c	\N	40
3636	ä»¥å	yÇhĂ²u	sau nĂ y, sau khi	\N	24
3653	é¥®æ–™	yÇnliĂ o	nÆ°á»›c uá»‘ng, Ä‘á»“ uá»‘ng	\N	26
3584	è¦	yĂ o	cáº§n, pháº£i, muá»‘n	\N	40
3585	å’¬	yÇo	cáº¯n	\N	31
3586	è¦ä¸	yĂ obĂ¹	náº¿u khĂ´ng thĂ¬	\N	34
3587	è¦ä¸ç„¶	yĂ obĂ¹rĂ¡n	náº¿u khĂ´ng thĂ¬, báº±ng khĂ´ng	\N	34
3588	æ‘‡æ‘†	yĂ¡obÇi	Ä‘ung Ä‘Æ°a, láº¯c lÆ°	\N	34
3589	è…°	yÄo	eo, tháº¯t lÆ°ng	\N	34
3591	è€€çœ¼	yĂ oyÇn	chĂ³i máº¯t, lĂ³a máº¯t	\N	34
3592	é¥è¿œ	yĂ¡oyuÇn	xa xĂ´i	\N	34
3593	è¦ç´ 	yĂ osĂ¹	yáº¿u tá»‘	\N	34
3594	æ‘‡æ™ƒ	yĂ¡ohuĂ ng	Ä‘ung Ä‘Æ°a, láº¯c lÆ°	\N	34
3595	é¥æ§	yĂ¡okĂ²ng	Ä‘iá»u khiá»ƒn tá»« xa	\N	40
3596	è¦å‘½	yĂ omĂ¬ng	cháº¿t ngÆ°á»i, kinh khá»§ng	\N	34
3597	é‚€è¯·	yÄoqÇng	má»i	\N	34
3598	è¦æ±‚	yÄoqiĂº	yĂªu cáº§u, Ä‘Ă²i há»i	\N	34
3599	é’¥åŒ™	yĂ oshi	chĂ¬a khĂ³a	\N	34
3600	å‹æ‘	yÄyĂ¬	kiá»m cháº¿, nĂ©n láº¡i	\N	40
3601	å‹å²é’±	yÄsuĂ¬qiĂ¡n	tiá»n má»«ng tuá»•i	\N	34
3602	äºæ´²	yĂ zhÅu	chĂ¢u Ă	\N	24
3603	å‹è¿«	yÄpĂ²	Ă¡p bá»©c	\N	33
3605	å‹æ¦¨	yÄzhĂ 	Ă©p, bĂ³p, váº¯t	\N	34
3606	å‹åˆ¶	yÄzhĂ¬	Ă¡p cháº¿, kĂ¬m nĂ©n	\N	40
3607	å¤œ	yĂ¨	Ä‘Ăªm	\N	21
3608	é¡µ	yĂ¨	trang, tá»	\N	34
3609	ä¹Ÿ	yÄ›	cÅ©ng	\N	34
3610	ä¸ä½™	yĂ¨yĂº	nghiá»‡p dÆ°	\N	34
3611	ä¸å¡	yĂ¨wĂ¹	nghiá»‡p vá»¥	\N	34
3612	é‡è›®	yÄ›mĂ¡n	man rá»£	\N	34
3613	é‡å¿ƒ	yÄ›xÄ«n	dĂ£ tĂ¢m	\N	34
3654	éè”½	yÇnbĂ¬	áº©n nĂ¡u, giáº¥u kĂ­n	\N	24
3617	ä¹™	yÇ	thá»© hai, áº¤t, B	\N	30
3618	ä»¥	yÇ	láº¥y, bá»Ÿi vĂ¬, Ä‘á»ƒ, nháº±m	\N	40
3621	ä¸€è¾¹	yÄ«biÄn	má»™t bĂªn, má»™t máº·t, vá»«a... vá»«a...	\N	34
3622	ä»¥ä¾¿	yÇbiĂ n	Ä‘á»ƒ, nháº±m	\N	34
3625	é—ä¼ 	yĂ­chuĂ¡n	di truyá»n	\N	40
3627	ä¸€ä¼å„¿	yĂ­huĂ¬r	má»™t lĂ¡t, chá»‘c lĂ¡t	\N	40
3629	ç§»å¨	yĂ­dĂ²ng	di chuyá»ƒn	\N	40
3630	ä¸€åº¦	yĂ­dĂ¹	má»™t láº§n	\N	21
3633	ä¸€å…±	yÄ«gĂ²ng	tá»•ng cá»™ng	\N	34
3634	ä»¥å…	yÇmiÇn	trĂ¡nh, khá»i	\N	34
3637	ç–‘æƒ‘	yĂ­huĂ²	nghi ngá»	\N	34
3638	ä»¥å	yÇjĂ­	vĂ , cĂ¹ng vá»›i	\N	34
3639	æ„è§	yĂ¬jiĂ n	Ă½ kiáº¿n, quan Ä‘iá»ƒm	\N	40
3640	å·²ç»	yÇjÄ«ng	Ä‘Ă£, rá»“i	\N	34
3641	ä¾æ—§	yÄ«jiĂ¹	nhÆ° cÅ©, váº«n nhÆ° trÆ°á»›c	\N	34
3642	ä¾é 	yÄ«kĂ o	dá»±a vĂ o	\N	40
3643	ä¸€ä¸¾ä¸¤å¾—	yÄ«jÇ”liÇngdĂ©	má»™t cĂ´ng Ä‘Ă´i viá»‡c	\N	35
3644	ä»¥æ¥	yÇlĂ¡i	tá»« nay, trá»Ÿ láº¡i	\N	40
3645	åŒ»ç–—	yÄ«liĂ¡o	y táº¿, chá»¯a bá»‡nh	\N	24
3646	é—ç•™	yĂ­liĂº	Ä‘á»ƒ láº¡i, lÆ°u láº¡i	\N	40
3647	ä¸€æµ	yÄ«liĂº	háº¡ng nháº¥t, loáº¡i má»™t	\N	40
3648	ä¸€å¾‹	yÄ«lÇœ	Ä‘á»u, nhÆ° nhau	\N	24
3650	ä¸€ç›®äº†ç„¶	yÄ«mĂ¹ liÇorĂ¡n	nhĂ¬n má»™t cĂ¡i lĂ  hiá»ƒu ngay	\N	35
3651	é“¶	yĂ­n	báº¡c	\N	21
3652	é˜´	yÄ«n	Ă¢m, trá»i rĂ¢m	\N	34
3655	å› æ­¤	yÄ«ncÇ	vĂ¬ tháº¿, do Ä‘Ă³	\N	34
3656	å¼•å¯¼	yÇndÇo	hÆ°á»›ng dáº«n	\N	34
3657	å› è€Œ	yÄ«nâ€™Ă©r	vĂ¬ tháº¿, do Ä‘Ă³	\N	35
3658	ç¡¬	yĂ¬ng	cá»©ng, ráº¯n	\N	34
3659	ç¡¬å¸	yĂ¬ngbĂ¬	tiá»n xu	\N	40
3660	è¿æ¥	yĂ­ngjiÄ“	Ä‘Ă³n tiáº¿p, nghĂªnh Ä‘Ă³n	\N	34
3662	è‹±ä¿	yÄ«ngjĂ¹n	anh tuáº¥n, khĂ´i ngĂ´	\N	34
3663	ç›ˆåˆ©	yĂ­nglĂ¬	lá»£i nhuáº­n	\N	34
3664	è‹±æ˜	yÄ«ngmĂ­ng	sĂ¡ng suá»‘t, anh minh	\N	34
3666	å½±å“	yÇngxiÇng	áº£nh hÆ°á»Ÿng	\N	34
3668	åº”ä»˜	yĂ¬ngfu	á»©ng phĂ³, Ä‘á»‘i phĂ³	\N	34
3670	åº”è˜	yĂ¬ngpĂ¬n	á»©ng tuyá»ƒn	\N	34
3677	é“¶è¡Œ	yĂ­nhĂ¡ng	ngĂ¢n hĂ ng	\N	37
3688	éŸ³å“	yÄ«nxiÇng	nháº¡c cá»¥	\N	30
3679	éç’	yÇnmĂ¡n	che giáº¥u	\N	24
3680	é˜´è°‹	yÄ«nmĂ³u	Ă¢m mÆ°u	\N	27
3684	å°åˆ·	yĂ¬nshuÄ	in áº¥n	\N	31
3708	æ„å‘³ç€	yĂ¬wĂ¨izhĂ¨	nghÄ©a lĂ 	\N	25
3710	ä¹‰å¡	yĂ¬wĂ¹	nghÄ©a vá»¥	\N	23
3717	æ„å¿—	yĂ¬zhĂ¬	Ă½ chĂ­	\N	22
3763	å¹¼ç¨	yĂ²uzhĂ¬	áº¥u trÄ©, non ná»›t	\N	24
3734	ç”¨é€”	yĂ²ngtĂº	cĂ´ng dá»¥ng, pháº¡m vi sá»­ dá»¥ng	\N	34
3635	ä»¥å¾€	yÇwÇng	trÆ°á»›c kia, trong quĂ¡ khá»©	\N	34
3665	è‹±é›„	yÄ«ngxiĂ³ng	anh hĂ¹ng	\N	34
3669	åº”ç”¨	yĂ¬ngyĂ²ng	á»©ng dá»¥ng	\N	40
3671	åº”é…¬	yĂ¬ngchou	tiá»‡c tĂ¹ng, xĂ£ giao	\N	34
3672	åº”é‚€	yĂ¬ngyÄo	nháº­n lá»i má»i	\N	40
3673	åº”å½“	yĂ¬ngdÄng	nĂªn, pháº£i	\N	40
3675	å½±å­	yÇngzi	bĂ³ng, hĂ¬nh bĂ³ng	\N	34
3676	è¿åˆ	yĂ­nghĂ©	Ä‘Ă³n Ă½, chiá»u lĂ²ng	\N	34
3678	éæ‚£	yÇnhuĂ n	tai hoáº¡ ngáº§m	\N	34
3682	å¼•æ“	yÇnqĂ­ng	Ä‘á»™ng cÆ¡	\N	34
3683	é¥®é£Ÿ	yÇnshĂ­	Äƒn uá»‘ng	\N	34
3685	å› ç´ 	yÄ«nsĂ¹	nhĂ¢n tá»‘	\N	34
3686	å› ä¸º	yÄ«nwĂ¨i	bá»Ÿi vĂ¬	\N	40
3687	å°è±¡	yĂ¬nxiĂ ng	áº¥n tÆ°á»£ng	\N	34
3689	å¼•ç”¨	yÇnyĂ²ng	trĂ­ch dáº«n	\N	40
3690	éçº¦	yÇnyuÄ“	lá» má», tháº¥p thoĂ¡ng	\N	34
3691	éŸ³ä¹	yÄ«nyuĂ¨	Ă¢m nháº¡c	\N	31
3693	ä»¥å‰	yÇqiĂ¡n	trÆ°á»›c Ä‘Ă¢y, trÆ°á»›c kia	\N	34
3694	ä¸€åˆ‡	yÄ«qiĂ¨	táº¥t cáº£	\N	21
3695	æ¯…ç„¶	yĂ¬rĂ¡n	kiĂªn quyáº¿t, khĂ´ng do dá»±	\N	34
3696	ä¾ç„¶	yÄ«rĂ¡n	nhÆ° cÅ©, váº«n	\N	31
3697	ä¸€å¦‚æ—¢å¾€	yÄ«rĂºjĂ¬wÇng	trÆ°á»›c sau nhÆ° má»™t	\N	21
3698	åŒ»ç”Ÿ	yÄ«shÄ“ng	bĂ¡c sÄ©	\N	24
3699	ä»ªå¼	yĂ­shĂ¬	nghi lá»…, nghi thá»©c	\N	36
3700	æ„è¯†	yĂ¬shĂ­	Ă½ thá»©c	\N	30
3702	æ„æ€	yĂ¬si	Ă½ nghÄ©a	\N	40
3703	ä¸€ä¸ä¸è‹Ÿ	yÄ«sÄ«bĂ¹gÇ’u	cáº©n tháº­n, khĂ´ng sÆ¡ suáº¥t	\N	34
3704	æ„å›¾	yĂ¬tĂº	má»¥c Ä‘Ă­ch, Ă½ Ä‘á»“	\N	34
3705	ä¾æ‰˜	yÄ«tuÅ	dá»±a vĂ o, nhá» vĂ o	\N	34
3706	æ„å¤–	yĂ¬wĂ i	báº¥t ngá», ngoĂ i Ă½ muá»‘n	\N	34
3707	ä»¥ä¸º	yÇwĂ©i	tÆ°á»Ÿng ráº±ng, cho ráº±ng	\N	40
3709	ç–‘é—®	yĂ­wĂ¨n	nghi ngá»	\N	34
3712	ä¸€æ ·	yĂ­yĂ ng	giá»‘ng nhÆ°	\N	34
3713	æ„ä¹‰	yĂ¬yĂ¬	Ă½ nghÄ©a	\N	40
3714	åŒ»é™¢	yÄ«yuĂ n	bá»‡nh viá»‡n	\N	24
3715	ä¸€å†	yĂ­zĂ i	nhiá»u láº§n, háº¿t láº§n nĂ y Ä‘áº¿n láº§n khĂ¡c	\N	40
3716	ä¸€ç›´	yÄ«zhĂ­	liĂªn tá»¥c, suá»‘t, luĂ´n luĂ´n	\N	34
3718	æ‘åˆ¶	yĂ¬zhĂ¬	kiá»m cháº¿, kĂ¬m hĂ£m	\N	34
3719	ä¸€è‡´	yĂ­zhĂ¬	nháº¥t trĂ­, Ä‘á»“ng lĂ²ng	\N	34
3720	ä»¥è‡´	yÇzhĂ¬	do Ä‘Ă³, khiáº¿n cho	\N	40
3721	æ¤…å­	yÇzi	gháº¿	\N	27
3722	æ‹¥æ±	yÅngbĂ o	Ă´m, cĂ¡i Ă´m	\N	34
3724	ç”¨åŸ	yĂ²nggÅng	chÄƒm chá»‰, siĂªng nÄƒng	\N	34
3725	æ°¸æ’	yÇ’nghĂ©ng	vÄ©nh háº±ng, mĂ£i mĂ£i	\N	30
3726	ç”¨æˆ·	yĂ²nghĂ¹	ngÆ°á»i sá»­ dá»¥ng	\N	40
3727	æ‹¥æ¤	yÅnghĂ¹	á»§ng há»™, tĂ¡n thĂ nh	\N	34
3728	æ‹¥æŒ¤	yÅngjÇ	cháº­t chá»™i, Ä‘Ă´ng Ä‘Ăºc	\N	34
3729	å‹‡æ°”	yÇ’ngqĂ¬	dÅ©ng cáº£m, can Ä‘áº£m	\N	40
3730	ç”¨	yĂ²ng	dĂ¹ng	\N	40
3731	å‹‡äº	yÇ’ngyĂº	dĂ¡m, cĂ³ gan	\N	34
3733	ç”¨äºº	yĂ²ngrĂ©n	dĂ¹ng ngÆ°á»i	\N	40
3735	åº¸ä¿—	yÅngsĂº	táº§m thÆ°á»ng, dung tá»¥c	\N	40
3736	æ¶Œç°	yÇ’ngxiĂ n	tuĂ´n ra, xuáº¥t hiá»‡n nhiá»u	\N	40
3737	æ‹¥æœ‰	yÇ’ngyÇ’u	cĂ³, sá»Ÿ há»¯u	\N	34
3738	æ°¸è¿œ	yÇ’ngyuÇn	vÄ©nh viá»…n, mĂ£i mĂ£i	\N	40
3739	è¸è·ƒ	yÇ’ngyuĂ¨	nháº£y nhĂ³t, hÄƒng hĂ¡i	\N	34
3740	ç”±	yĂ³u	do, bá»Ÿi, tá»«	\N	40
3741	åˆ	yĂ²u	láº¡i, vá»«aâ€¦láº¡i	\N	40
3742	æœ‰	yÇ’u	cĂ³	\N	34
3744	æ²¹ç‚¸	yĂ³u zhĂ¡	rĂ¡n báº±ng dáº§u má»¡	\N	34
3745	å³è¾¹	yĂ²ubiÄn	bĂªn pháº£i	\N	40
3746	å¹¼å„¿å›­	yĂ²uâ€™Ă©ryuĂ¡n	trÆ°á»ng máº«u giĂ¡o	\N	34
3747	å‹å¥½	yÇ’uhÇo	báº¡n thĂ¢n, thĂ¢n thiá»‡n	\N	34
3748	ä¼˜æƒ 	yÅuhuĂ¬	Æ°u Ä‘Ă£i	\N	40
3749	æœ‰å®³	yÇ’uhĂ i	cĂ³ háº¡i	\N	34
3750	æœ‰è¶£	yÇ’uqĂ¹	thĂº vá»‹, lĂ½ thĂº	\N	30
3751	æœ‰å	yÇ’umĂ­ng	ná»•i tiáº¿ng	\N	34
3752	å¹½é»˜	yÅumĂ²	hĂ i hÆ°á»›c, vui tĂ­nh	\N	34
3753	æ¸¸æ³³	yĂ³uyÇ’ng	bÆ¡i	\N	40
3754	ä¼˜ç§€	yÅuxiĂ¹	Æ°u tĂº, xuáº¥t sáº¯c	\N	40
3755	æ¸¸æˆ	yĂ³uxĂ¬	trĂ² chÆ¡i	\N	31
3757	å‹è°	yÇ’uyĂ¬	tĂ¬nh há»¯u nghá»‹, báº¡n bĂ¨	\N	40
3758	ä¼˜å¼‚	yÅuyĂ¬	xuáº¥t sáº¯c, vÆ°á»£t trá»™i	\N	40
3759	ç”±äº	yĂ³uyĂº	bá»Ÿi vĂ¬, do	\N	40
3760	ç¹è±«	yĂ³uyĂ¹	do dá»±, ngáº­p ngá»«ng	\N	34
3761	å¿§éƒ	yÅuyĂ¹	buá»“n ráº§u, u sáº§u	\N	34
3762	ä¼˜è¶	yÅuyuĂ¨	Æ°u viá»‡t, vÆ°á»£t trá»™i	\N	34
3764	é±¼	yĂº	cĂ¡	\N	25
3765	æ„ˆ	yĂ¹	khoáº» bá»‡nh, háº¿t bá»‡nh	\N	34
3766	ä¸	yÇ”	vá»›i, cĂ¹ng	\N	35
3768	åœ†	yuĂ¡n	trĂ²n, viĂªn mĂ£n	\N	34
3769	è¿œ	yuÇn	xa, xa xĂ´i	\N	34
3770	å…ƒæ—¦	yuĂ¡ndĂ n	táº¿t DÆ°Æ¡ng lá»‹ch	\N	34
3792	é˜…è¯»	yuĂ¨dĂº	Ä‘á»c hiá»ƒu	\N	33
3806	è¿æ°”	yĂ¹nqĂ¬	váº­n khĂ­, may máº¯n	\N	40
3836	ç¾é¾	zÄinĂ n	tai náº¡n	\N	24
3872	æ‰	zhÄ	chĂ­ch, Ä‘Ă¢m, Ä‘Ă¢m vĂ o	\N	34
3793	å²³çˆ¶	yuĂ¨fĂ¹	bá»‘ vá»£	\N	22
3801	èˆ†è®º	yĂºlĂ¹n	dÆ° luáº­n	\N	31
3823	é¢„ä¹ 	yĂ¹xĂ­	há»c trÆ°á»›c bĂ i	\N	21
3844	æ‚å¿—	zĂ¡zhĂ¬	táº¡p chĂ­	\N	33
3858	é­å—	zÄoshĂ²u	gáº·p, bá»‹, chá»‹u	\N	28
3862	å’‹	zÇ	thĂ¬	\N	32
3772	åŸè°…	yuĂ¡nliĂ ng	thá»© lá»—i, tha thá»©	\N	30
3773	åŸæ–™	yuĂ¡nliĂ o	nguyĂªn liá»‡u	\N	40
3775	å›­æ—	yuĂ¡nlĂ­n	vÆ°á»n, cĂ´ng viĂªn	\N	34
3776	åŸå§‹	yuĂ¡nshÇ	nguyĂªn thuá»·, ban sÆ¡	\N	34
3777	åŸå…ˆ	yuĂ¡nxiÄn	trÆ°á»›c kia, ban Ä‘áº§u	\N	34
3778	å…ƒé¦–	yuĂ¡nshÇ’u	nguyĂªn thá»§, ngÆ°á»i Ä‘á»©ng Ä‘áº§u	\N	34
3779	è¿œå¤„	yuÇnchĂ¹	nÆ¡i xa, chá»— xa	\N	40
3780	å…ƒç´ 	yuĂ¡nsĂ¹	nguyĂªn tá»‘	\N	34
3781	æ„¿æœ›	yuĂ nwĂ ng	nguyá»‡n vá»ng, mong muá»‘n	\N	34
3782	å†¤æ‰	yuÄnwÇng	bá»‹ oan, oan uá»•ng	\N	34
3783	å…ƒå®µè‚	yuĂ¡nxiÄojiĂ©	Táº¿t NguyĂªn TiĂªu	\N	40
3784	æ„¿æ„	yuĂ nyĂ¬	báº±ng lĂ²ng, mong muá»‘n	\N	40
3785	åŸå› 	yuĂ¡nyÄ«n	nguyĂªn nhĂ¢n	\N	40
3786	åŸåˆ™	yuĂ¡nzĂ©	nguyĂªn táº¯c	\N	34
3788	æ„è ¢	yĂºchÇ”n	ngu xuáº©n, ngá»‘c ngháº¿ch	\N	40
3789	é¢„è®¢	yĂ¹dĂ¬ng	Ä‘áº·t trÆ°á»›c, dá»± Ä‘á»‹nh	\N	34
3790	æœˆ	yuĂ¨	thĂ¡ng	\N	30
3791	è¶	yuĂ¨	vÆ°á»£t qua, ngĂ y cĂ ng	\N	34
3794	çº¦ä¼	yuÄ“huĂ¬	háº¹n hĂ²	\N	34
3795	æœˆäº®	yuĂ¨liang	máº·t trÄƒng	\N	34
3797	çº¦æŸ	yuÄ“shĂ¹	háº¡n cháº¿, rĂ ng buá»™c	\N	34
3798	è¯­æ³•	yÇ”fÇ	ngá»¯ phĂ¡p	\N	33
3799	æ„‰å¿«	yĂºkuĂ i	vui váº», háº¡nh phĂºc	\N	40
3800	å¨±ä¹	yĂºlĂ¨	giáº£i trĂ­	\N	31
3802	ç¾½æ¯›çƒ	yÇ”mĂ¡oqiĂº	cáº§u lĂ´ng	\N	34
3803	ç‰ç±³	yĂ¹mÇ	ngĂ´	\N	34
3804	å…è®¸	yÇ”nxÇ”	cho phĂ©p	\N	34
3807	è¿å¨	yĂ¹ndĂ²ng	váº­n Ä‘á»™ng, thá»ƒ thao	\N	34
3808	äº‘	yĂºn	mĂ¢y	\N	21
3809	æ™•	yÅ«n	say (xe, tĂ u), chĂ³ng máº·t	\N	34
3810	å­•å¦‡	yĂ¹nfĂ¹	phá»¥ ná»¯ mang thai	\N	40
3811	è¿ç”¨	yĂ¹nyĂ²ng	váº­n dá»¥ng	\N	40
3813	è¿ç®—	yĂ¹nsuĂ n	tĂ­nh toĂ¡n, lĂ m toĂ¡n	\N	34
3814	è¿è¡Œ	yĂ¹nxĂ­ng	váº­n hĂ nh	\N	30
3815	é¢„æœŸ	yĂ¹qÄ«	dá»± tĂ­nh, mong Ä‘á»£i	\N	34
3816	ä¸å…¶	yÇ”qĂ­	thĂ ... cĂ²n hÆ¡n	\N	35
3817	è¯­æ°”	yÇ”qĂ¬	ngá»¯ khĂ­	\N	35
3818	ä¸æ—¥ä¿±å¢	yÇ”rĂ¬jĂ¹zÄ“ng	tÄƒng lĂªn tá»«ng ngĂ y	\N	35
3819	åˆ¶æœ	yĂ¹fĂº	Ä‘á»“ng phá»¥c	\N	34
3820	é¢„ç®—	yĂ¹suĂ n	dá»± toĂ¡n	\N	34
3821	äºæ˜¯	yĂºshĂ¬	tháº¿ lĂ , do Ä‘Ă³	\N	34
3822	æ¬²æœ›	yĂ¹wĂ ng	ham muá»‘n	\N	34
3824	é¢„å…ˆ	yĂ¹xiÄn	trÆ°á»›c tiĂªn, sáºµn	\N	34
3825	è¯­è¨€	yÇ”yĂ¡n	ngĂ´n ngá»¯	\N	33
3827	å¯“è¨€	yĂ¹yĂ¡n	truyá»‡n ngá»¥ ngĂ´n	\N	34
3828	é¢„è¨€	yĂ¹yĂ¡n	tiĂªn Ä‘oĂ¡n	\N	34
3830	å®‡å®™	yÇ”zhĂ²u	vÅ© trá»¥	\N	21
3831	æ‚	zĂ¡	táº¡p, pha táº¡p	\N	30
3832	å’±	zĂ¡n	chĂºng ta	\N	34
3833	å†	zĂ i	láº¡i, ná»¯a	\N	40
3835	ç¾å®³	zÄihĂ i	tai hoáº¡, thiĂªn tai	\N	34
3837	åœ¨	zĂ i	táº¡i, á»Ÿ	\N	34
3838	å†è§	zĂ ijiĂ n	táº¡m biá»‡t	\N	34
3839	åœ¨ä¹	zĂ ihÅ«	lÆ°u Ă½, Ä‘á»ƒ Ă½	\N	40
3840	å†æ¥å†å‰	zĂ ijiÄ“zĂ ilĂ¬	khĂ´ng ngá»«ng cá»‘ gáº¯ng, ná»— lá»±c	\N	34
3841	æ ½åŸ¹	zÄipĂ©i	vun xá»›i, vun trá»“ng	\N	34
3842	åœ¨æ„	zĂ iyĂ¬	lÆ°u Ă½, lÆ°u tĂ¢m	\N	34
3843	æ‚æ€	zĂ¡jĂ¬	táº¡p ká»¹, xiáº¿c	\N	40
3846	èµæˆ	zĂ nchĂ©ng	tĂ¡n thĂ nh, Ä‘á»“ng Ă½	\N	34
3847	è„	zÄng	báº©n	\N	34
3848	èµç¾	zĂ nmÄ›i	khen ngá»£i	\N	34
3849	å’±ä»¬	zĂ¡nmen	chĂºng ta	\N	34
3850	æ‚æ—¶	zĂ nshĂ­	táº¡m thá»i	\N	34
3851	èµå¹	zĂ ntĂ n	khen ngá»£i	\N	34
3852	èµåŒ	zĂ ntĂ³ng	tĂ¡n Ä‘á»“ng	\N	34
3854	èµå©	zĂ nzhĂ¹	tĂ i trá»£	\N	34
3855	é€ å	zĂ ofÇn	pháº£n loáº¡n	\N	34
3856	ç³Ÿç³•	zÄogÄo	há»ng bĂ©t, gay go	\N	34
3857	æ—©æ™¨	zÇochĂ©n	buá»•i sĂ¡ng	\N	34
3859	é€ æˆ	zĂ ochĂ©ng	táº¡o thĂ nh	\N	34
3860	é­é‡	zÄoyĂ¹	gáº·p gá»¡	\N	34
3861	å™ªéŸ³	zĂ oyÄ«n	tiáº¿ng á»“n	\N	34
3863	è´£å¤‡	zĂ©bĂ¨i	khiá»ƒn trĂ¡ch	\N	40
3864	è´£æ€ª	zĂ©guĂ i	khiá»ƒn trĂ¡ch	\N	40
3865	è´¼	zĂ©i	káº» trá»™m	\N	34
3866	å¢å 	zÄ“ngjiÄ	tÄƒng thĂªm, tÄƒng lĂªn	\N	40
3868	å¢é•¿	zÄ“ngzhÇng	tÄƒng lĂªn	\N	40
3869	æ€ä¹ˆ	zÄ›nme	tháº¿ nĂ o, sao, lĂ m sao	\N	34
3870	æ€ä¹ˆæ ·	zÄ›nme yĂ ng	tháº¿ nĂ o	\N	34
3871	è´£ä»»	zĂ©rĂ¨n	trĂ¡ch nhiá»‡m	\N	40
3873	çª„	zhÇi	háº¹p, cháº­t	\N	34
3874	æ‘˜	zhÄi	hĂ¡i, báº», ngáº¯t, láº¥y	\N	40
3875	å€ºåˆ¸	zhĂ iquĂ n	phiáº¿u cĂ´ng trĂ¡i	\N	34
3876	æ‘˜è¦	zhÄiyĂ o	trĂ­ch yáº¿u, tĂ³m táº¯t	\N	34
3919	æ˜	zhĂ©	gáº­p láº¡i	\N	28
3895	å æ®	zhĂ njĂ¹	chiáº¿m, giá»¯	\N	22
3953	çœŸå®	zhÄ“nshĂ­	chĂ¢n tháº­t, chĂ¢n thá»±c	\N	30
3900	å æœ‰	zhĂ nyÇ’u	chiáº¿m	\N	22
3902	æ‰¾	zhÇo	tĂ¬m	\N	24
3905	ç€æ€¥	zhĂ¡ojĂ­	sá»‘t ruá»™t, lo láº¯ng	\N	21
3894	ç…§ç‰‡	zhĂ opiĂ n	bá»©c áº£nh	\N	31
3927	çè´µ	zhÄ“nguĂ¬	quĂ½ giĂ¡	\N	37
3954	å¾æ”¶	zhÄ“ngshÅu	trÆ°ng thu	\N	30
3879	æˆ˜æ–—	zhĂ ndĂ²u	chiáº¿n Ä‘áº¥u, Ä‘Ă¡nh nhau	\N	40
3880	æ¶¨	zhÇng	lá»›n, cÄƒng, trÆ°á»›ng	\N	34
3881	éœç¢	zhĂ ngâ€™Ă i	chÆ°á»›ng ngáº¡i	\N	34
3882	é•¿è¾ˆ	zhÇngbĂ¨i	Ä‘Ă n anh, trÆ°á»Ÿng bá»‘i	\N	40
3883	ç« ç¨‹	zhÄngchĂ©ng	Ä‘iá»u lá»‡, quy táº¯c	\N	40
3884	ä¸ˆå¤«	zhĂ ngfu	chá»“ng	\N	34
3885	è´¦æˆ·	zhĂ nghĂ¹	tĂ i khoáº£n	\N	34
3886	å¸ç¯·	zhĂ ngpeng	lá»u	\N	40
3887	æŒæ¡	zhÇngwĂ²	náº¯m vá»¯ng	\N	34
3888	æŒå£°	zhÇngshÄ“ng	tiáº¿ng vá»— tay	\N	34
3889	ç…§å¸¸	zhĂ ochĂ¡ng	nhÆ° thÆ°á»ng lá»‡	\N	34
3890	ç…§é¡¾	zhĂ ogĂ¹	chÄƒm sĂ³c	\N	34
3891	å¬å¼€	zhĂ okÄi	triá»‡u táº­p, má»i dá»± há»p	\N	40
3892	ç…§äº®	zhĂ oliĂ ng	soi sĂ¡ng	\N	34
3965	çœŸç†	zhÄ“nlÇ	chĂ¢n lĂ­, sá»± tháº­t	\N	31
3973	éœ‡å‹	zhĂ¨nyÄ	Ä‘Ă n Ă¡p, tráº¥n Ă¡p	\N	26
3896	å±•ç°	zhÇnxiĂ n	bĂ y ra, hiá»‡n ra	\N	40
3897	å´­æ–°	zhÇnxÄ«n	má»›i tinh	\N	34
3898	ç»ä»°	zhÄnyÇng	chiĂªm ngÆ°á»¡ng, nhĂ¬n cung kĂ­nh	\N	34
3899	æˆ˜å½¹	zhĂ nyĂ¬	chiáº¿n dá»‹ch	\N	40
3977	åª	zhÄ«	chá»‰	\N	22
3901	æˆ˜äº‰	zhĂ nzhÄ“ng	chiáº¿n tranh	\N	40
3903	æ‹›æ•æ ‡	zhÄo tĂ³ubiÄo	Ä‘áº¥u tháº§u	\N	24
3904	æ‹›å¾…	zhÄodĂ i	chiĂªu Ä‘Ă£i	\N	40
3906	ç€å‡‰	zhĂ¡oliĂ¡ng	cáº£m láº¡nh, nhiá»…m láº¡nh	\N	34
3907	ç…§æ–™	zhĂ oliĂ o	chÄƒm sĂ³c	\N	34
3908	ç€è¿·	zhĂ¡omĂ­	say mĂª, say sÆ°a	\N	40
3910	æœæ°”è“¬å‹ƒ	zhÄoqĂ¬ pĂ©ngbĂ³	trĂ n Ä‘áº§y khĂ­ bá»“ng bá»™t nhÆ° khá»Ÿi ban mai	\N	34
3911	æ‹›æ”¶	zhÄoshÅu	chiĂªu má»™, tuyá»ƒn nháº­n	\N	40
3912	ç…§æ ·	zhĂ oyĂ ng	nhÆ° thÆ°á»ng lá»‡	\N	34
3913	ç…§è€€	zhĂ oyĂ o	chiáº¿u sĂ¡ng	\N	40
3914	ç…§åº”	zhĂ oyĂ¬ng	phá»‘i há»£p, Äƒn khá»›p	\N	34
3915	æ²¼æ³½	zhÇozĂ©	Ä‘áº§m láº§y	\N	34
3916	è¯ˆéª—	zhĂ piĂ n	lá»«a dá»‘i, lá»«a bá»‹p	\N	34
3917	æ‰å®	zhÄshi	vá»¯ng cháº¯c, cháº¯c cháº¯n	\N	34
3918	è€…	zhÄ›	ngÆ°á»i	\N	34
3921	æ˜ç£¨	zhĂ©mĂ³	dáº±n váº·t, giĂ y vĂ²	\N	40
3922	é˜µ	zhĂ¨n	tráº­n, cÆ¡n	\N	34
3923	éœ‡è¡	zhĂ¨ndĂ ng	tráº¥n Ä‘á»™ng, rung Ä‘á»™ng	\N	34
3924	é’ˆå¯¹	zhÄ“nduĂ¬	nháº±m vĂ o, chÄ©a vĂ o	\N	34
3925	æŒ¯å¥‹	zhĂ¨nfĂ¨n	pháº¥n cháº¥n, pháº¥n khá»Ÿi	\N	34
3926	çœŸ	zhÄ“n	tháº­t, chĂ­nh xĂ¡c	\N	34
3928	è¯æ–­	zhÄ›nduĂ n	cháº©n Ä‘oĂ¡n	\N	34
3929	æŒ¯å¨	zhĂ¨ndĂ²ng	rung Ä‘á»™ng	\N	34
3931	é•‡é™	zhĂ¨njĂ¬ng	tráº¥n tÄ©nh, Ä‘iá»m tÄ©nh	\N	40
3932	æ­£	zhĂ¨ng	chĂ­nh, ngay	\N	40
3933	æ”¿åºœ	zhĂ¨ngfÇ”	chĂ­nh phá»§	\N	21
3934	æ­£ç¡®	zhĂ¨ngquĂ¨	chĂ­nh xĂ¡c	\N	34
3935	æ”¿ç­–	zhĂ¨ngcĂ¨	chĂ­nh sĂ¡ch	\N	34
3936	æ­£å¸¸	zhĂ¨ngchĂ¡ng	bĂ¬nh thÆ°á»ng	\N	34
3937	æ­£å½“	zhĂ¨ngdĂ ng	giá»¯a lĂºc, trong lĂºc	\N	34
3938	äº‰ç«¯	zhÄ“ngduÄn	tranh cháº¥p	\N	22
3939	äº‰å¤º	zhÄ“ngduĂ³	tranh Ä‘oáº¡t, tranh giĂ nh	\N	40
3940	æ•´é¡¿	zhÄ›ngdĂ¹n	sáº¯p xáº¿p, chá»‰nh Ä‘á»‘n	\N	40
3941	æ­£æ´¾	zhĂ¨ngpĂ i	ngay tháº³ng, Ä‘oan chĂ­nh	\N	30
3942	æ•´é½	zhÄ›ngqĂ­	ngÄƒn náº¯p, tráº­t tá»±	\N	34
3943	æ­£è§„	zhĂ¨ngguÄ«	chĂ­nh quy, ná» náº¿p	\N	34
3944	æ­£å¥½	zhĂ¨nghÇo	vá»«a hay	\N	40
3946	æ­£ç»	zhĂ¨ngjÄ«ng	Ä‘oan trang, chĂ­nh phĂ¡i	\N	34
3947	è¯æ®	zhĂ¨ngjĂ¹	chá»©ng cá»©	\N	34
3948	æ•´ç†	zhÄ›nglÇ	chá»‰nh lĂ­, thu xáº¿p, thu dá»n	\N	34
3949	äº‰è®º	zhÄ“nglĂ¹n	tranh cĂ£i, tranh luáº­n	\N	40
3950	è¯æ˜	zhĂ¨ngmĂ­ng	chá»©ng minh	\N	34
3951	æ­£æ°”	zhĂ¨ngqĂ¬	báº§u khĂ´ng khĂ­ lĂ nh máº¡nh	\N	34
3952	äº‰å–	zhÄ“ngqÇ”	tranh thá»§	\N	30
3955	è¯ä¹¦	zhĂ¨ngshÅ«	giáº¥y chá»©ng nháº­n	\N	40
3957	äº‰å…ˆæå	zhÄ“ngxiÄnkÇ’nghĂ²u	chen láº¥n lĂªn trÆ°á»›c sá»£ rá»›t láº¡i sau	\N	40
3958	æ­£ä¹‰	zhĂ¨ngyĂ¬	chĂ­nh nghÄ©a	\N	21
3959	äº‰è®®	zhÄ“ngyĂ¬	tranh luáº­n	\N	40
3960	æ­£åœ¨	zhĂ¨ngzĂ i	Ä‘ang	\N	31
3961	æ”¿æ²»	zhĂ¨ngzhĂ¬	chĂ­nh trá»‹	\N	21
3962	éƒ‘é‡	zhĂ¨ngzhĂ²ng	nghiĂªm tĂºc, trá»‹nh trá»ng	\N	34
3963	ç—‡ç¶	zhĂ¨ngzhuĂ ng	bá»‡nh tráº¡ng, triá»‡u chá»©ng	\N	34
3964	éœ‡å¨	zhĂ¨ndĂ²ng	tráº¥n tÄ©nh	\N	40
3966	é˜µå®¹	zhĂ¨nrĂ³ng	Ä‘á»™i hĂ¬nh, Ä‘á»™i ngÅ©	\N	34
3967	ä¾¦æ¢	zhÄ“ntĂ n	trinh thĂ¡m	\N	34
3968	æ•å¤´	zhÄ›ntou	cĂ¡i gá»‘i	\N	34
3969	çæƒœ	zhÄ“nxÄ«	quĂ½, trĂ¢n trá»ng	\N	34
3970	çç 	zhÄ“nzhÅ«	ngá»c trai	\N	34
3971	çœŸç›¸	zhÄ“nxiĂ ng	sá»± tháº­t	\N	30
3974	æ˜è…¾	zhÄ“teng	Ä‘i qua Ä‘i láº¡i, lÄƒn láº¡i	\N	40
3975	å“²å­¦	zhĂ©xuĂ©	triáº¿t há»c	\N	34
3976	ç›´	zhĂ­	tháº³ng	\N	30
3980	æ”¯	zhÄ«	Ä‘á»™i, Ä‘Æ¡n vá»‹ (vÄƒn, bĂ i cĂ¢y, cĂ¡n)	\N	25
3992	æŒ‡å®	zhÇdĂ¬ng	chá»‰ Ä‘á»‹nh	\N	22
3998	æŒ‡æŒ¥	zhÇhuÄ«	chá»‰ huy	\N	22
4002	çŸ¥è§‰	zhÄ«juĂ©	tri giĂ¡c	\N	37
4018	æ™ºå•†	zhĂ¬shÄng	IQ	\N	37
4019	æŒ‡ä½¿	zhÇshÇ	khiáº¿n cho, lĂ m cho	\N	40
4020	æŒ‡ç¤º	zhÇshĂ¬	chá»‰ thá»‹	\N	32
4022	èŒä½	zhĂ­wĂ¨i	chá»©c vá»‹	\N	23
4027	èŒä¸	zhĂ­yĂ¨	nghá» nghiá»‡p	\N	23
4031	åˆ¶é€ 	zhĂ¬zĂ o	cháº¿ táº¡o, lĂ m ra	\N	40
3979	ä¹‹	zhÄ«	tá»›i, cĂ¡i Ä‘Ă³, ngĂ´n tá»«, cá»§a	\N	34
4046	ä¸­ç«‹	zhÅnglĂ¬	trung láº­p	\N	25
3981	æ	zhÄ«	cĂ nh, nhĂ¡nh	\N	34
3982	æ²»å®‰	zhĂ¬â€™Än	trá»‹ an, cáº£nh sĂ¡t	\N	40
3983	ç›´æ’­	zhĂ­bÅ	phĂ¡t sĂ³ng trá»±c tiáº¿p	\N	34
3984	æ”¯æŒ	zhÄ«chĂ­	chá»‘ng Ä‘á»¡	\N	34
3986	æŒ‡å‡º	zhÇchÅ«	chá»‰ ra	\N	40
3987	æŒ‡å¯¼	zhÇdÇo	chá»‰ Ä‘áº¡o, hÆ°á»›ng dáº«n	\N	34
3988	çŸ¥é“	zhÄ«dĂ o	biáº¿t	\N	40
3989	å€¼å¾—	zhĂ­de	xá»©ng Ä‘Ă¡ng, Ä‘Ă¡ng	\N	35
3990	åˆ¶å®	zhĂ¬dĂ¬ng	cháº¿ Ä‘á»‹nh, láº­p ra	\N	40
3991	åˆ¶è®¢	zhĂ¬dĂ¬ng	quy Ä‘á»‹nh, Ä‘á»‹nh ra	\N	40
4065	èˆŸ	zhÅu	thuyá»n	\N	30
3993	åˆ¶åº¦	zhĂ¬dĂ¹	cháº¿ Ä‘á»™	\N	34
3994	è„‚è‚ª	zhÄ«fĂ¡ng	má»¡, cháº¥t bĂ©o	\N	40
3996	åªå¥½	zhÇhÇo	Ä‘Ă nh pháº£i	\N	21
3997	æ™ºæ…§	zhĂ¬huĂ¬	trĂ­ tuá»‡	\N	40
3999	æŒ‡ç”²	zhÇjiÇ	mĂ³ng tay	\N	34
4000	ç›´æ¥	zhĂ­jiÄ“	trá»±c tiáº¿p	\N	34
4001	è‡³ä»	zhĂ¬jÄ«n	cho Ä‘áº¿n nay	\N	40
4003	æ™ºå›	zhĂ¬lĂ¬	trĂ­ lá»±c, trĂ­ khĂ´n	\N	34
4005	ç½®äº	zhĂ¬ yĂº	dá»‘c sá»©c cho	\N	40
4006	è´¨é‡	zhĂ¬liĂ ng	cháº¥t lÆ°á»£ng	\N	34
4007	æ²»ç–—	zhĂ¬liĂ¡o	Ä‘iá»u trá»‹	\N	40
4008	æŒ‡ä»¤	zhÇlĂ¬ng	má»‡nh lá»‡nh, chá»‰ thá»‹	\N	40
4009	æ»ç•™	zhĂ¬liĂº	ngÆ°ng láº¡i, dá»«ng láº¡i	\N	40
4010	æ”¯æµ	zhÄ«liĂº	nhĂ¡nh sĂ´ng, dĂ²ng cháº£y	\N	40
4011	æ¤ç‰©	zhĂ­wĂ¹	thá»±c váº­t	\N	30
4012	æŒ‡å—é’ˆ	zhÇnĂ¡nzhÄ“n	kim chá»‰ nam	\N	40
4014	æ™ºèƒ½	zhĂ¬nĂ©ng	trĂ­ tuá»‡, chĂ­ thá»‹	\N	40
4015	æ”¯é…	zhÄ«pĂ¨i	an bĂ i, sáº¯p xáº¿p	\N	40
4016	æ”¯ç¥¨	zhÄ«piĂ o	chi phiáº¿u	\N	40
4017	æ‰§å‹¤	zhĂ­qĂ­n	cháº¥p hĂ nh	\N	22
4021	æŒ‡æœ›	zhÇwĂ ng	trĂ´ng chá», mong Ä‘á»£i	\N	34
4023	æ¤æ ‘	zhĂ­shĂ¹	cĂ¢y cá»‘i	\N	25
4024	èŒå¡	zhĂ­wĂ¹	chá»©c vá»¥	\N	23
4025	ç§©åº	zhĂ¬xĂ¹	tráº­t tá»±	\N	40
4028	å¿—æ„¿	zhĂ¬yuĂ n	Æ°á»›c nguyá»‡n, chĂ­ nguyá»‡n, giĂºp Ä‘á»¡	\N	34
4029	å¿—æ„¿è€…	zhĂ¬yuĂ n zhÄ›	tĂ¬nh nguyá»‡n viĂªn	\N	40
4030	åˆ¶çº¦	zhĂ¬yuÄ“	cháº¿ Æ°á»›c, kiá»m hĂ£m	\N	34
4032	æ‰§ç…§	zhĂ­zhĂ o	giáº¥y phĂ©p	\N	40
4033	æ”¯æŸ±	zhÄ«zhĂ¹	cĂ¢y trá»¥, trá»¥ chá»‘ng	\N	34
4035	åˆ¶ä½œ	zhĂ¬zuĂ²	cháº¿ táº¡o, lĂ m ra, cháº¿ ra	\N	40
4036	é‡	zhĂ²ng	náº·ng	\N	34
4037	ç§	zhÇ’ng	loáº¡i, kiá»ƒu	\N	34
4038	é’Ÿ	zhÅng	chuĂ´ng	\N	34
4039	ç»ˆ	zhÅng	káº¿t thĂºc	\N	40
4040	é‡ç‚¹	zhĂ²ngdiÇn	trá»ng Ä‘iá»ƒm	\N	34
4041	ç»ˆç‚¹	zhÅngdiÇn	Ä‘iá»ƒm cuá»‘i, Ä‘iá»ƒm káº¿t thĂºc	\N	40
4042	ç»ˆäº	zhÅngyĂº	cuá»‘i cĂ¹ng	\N	34
4043	ä¸­å›½	zhÅngguĂ³	Trung Quá»‘c	\N	34
4044	ä¸­é—´	zhÅngjiÄn	á»Ÿ giá»¯a, bĂªn trong	\N	34
4045	ç»ˆç©¶	zhÅngjiÅ«	chung quy, cuá»‘i cĂ¹ng	\N	34
4047	é‡é‡	zhĂ²ngliĂ ng	trá»ng lÆ°á»£ng	\N	34
4048	è‚¿ç˜¤	zhÇ’ngliĂº	bÆ°á»›u	\N	34
4050	ç»ˆèº«	zhÅngshÄ“n	suá»‘t Ä‘á»i	\N	34
4051	é‡è§†	zhĂ²ngshĂ¬	coi trá»ng, xem trá»ng	\N	34
4052	å¿ å®	zhÅngshĂ­	trung thĂ nh	\N	34
4053	ä¼—æ‰€å‘¨çŸ¥	zhĂ²ngsuÇ’zhÅuzhÄ«	ai ai cÅ©ng biáº¿t	\N	35
4054	ä¸­æ–‡	zhÅngwĂ©n	tiáº¿ng Trung	\N	34
4055	ä¸­åˆ	zhÅngwÇ”	buá»•i trÆ°a	\N	34
4056	ä¸­å¿ƒ	zhÅngxÄ«n	trung tĂ¢m	\N	34
4057	é‡æ–°	chĂ³ngxÄ«n	chĂ¡n náº£n	\N	30
4059	ä¸­å¤®	zhÅngyÄng	trung tĂ¢m	\N	34
4060	é‡è¦	zhĂ²ngyĂ o	quan trá»ng	\N	34
4061	ç§å­	zhÇ’ngzi	háº¡t	\N	30
4062	ç§æ—	zhÇ’ngzĂº	chá»§ng tá»™c	\N	34
4063	å·	zhÅu	chĂ¢u (Ä‘Æ¡n vá»‹ hĂ nh chĂ­nh)	\N	22
4066	å‘¨è¾¹	zhÅubiÄn	chu vi, xung quanh	\N	40
4067	å‘¨åˆ°	zhÅudĂ o	chu Ä‘Ă¡o	\N	34
4068	å‘¨å¯†	zhÅumĂ¬	chu Ä‘Ă¡o cháº·t cháº½	\N	34
4069	å‘¨æœ«	zhÅumĂ²	cuá»‘i tuáº§n	\N	34
4070	å‘¨å¹´	zhÅuniĂ¡n	Ä‘áº§y nÄƒm	\N	40
4071	å‘¨å›´	zhÅuwĂ©i	xung quanh	\N	34
4072	ç±çº¹	zhĂ²uwĂ©n	náº¿p nhÄƒn	\N	34
4073	æ˜¼å¤œ	zhĂ²uyĂ¨	ngĂ y vĂ  Ä‘Ăªm	\N	40
4075	å‘¨è½¬	zhÅuzhuÇn	quay vĂ²ng (dĂ²ng vá»‘n)	\N	34
4076	ä½	zhĂ¹	á»Ÿ, cÆ° trĂº, dá»«ng	\N	34
4077	ç¥	zhĂ¹	chĂºc, chĂºc má»«ng	\N	34
4078	æŸ±	zhĂ¹	cá»™t, chá»‘ng (gáº­y)	\N	34
4079	ç…®	zhÇ”	náº¥u	\N	24
4080	æ ª	zhÅ«	cĂ¢y	\N	25
4081	çŒª	zhÅ«	con lá»£n	\N	34
4082	æ“	zhuÄ	náº¯m, báº¯t	\N	40
4083	æ“ç´§	zhuÄjÇn	náº¯m cháº¯c, náº¯m vá»¯ng	\N	34
4119	æŒ‡å¼•	zhÇyÇn	dáº«n dáº¯t	\N	31
4091	è£…å¤‡	zhuÄngbĂ¨i	trang thiáº¿t bá»‹	\N	40
4137	è‡ªå‘	zĂ¬bÄ“i	tá»± ti	\N	27
4095	å£®çƒˆ	zhuĂ ngliĂ¨	lá»«ng láº«y, oanh liá»‡t	\N	40
4098	åº„ä¸¥	zhuÄngyĂ¡n	trĂ¡ng nghiĂªm	\N	40
551	ä¼ è¯´	zhuĂ nshuÅ	truyá»n ká»³, tiá»ƒu thuyáº¿t	\N	40
4144	è‡ªè±ª	zĂ¬hĂ¡o	tá»± hĂ o	\N	27
4138	èµ„æœ¬	zÄ«bÄ›n	vá»‘n	\N	38
4126	èµ„æ ¼	zÄ«gĂ©	tÆ° cĂ¡ch	\N	27
4145	è‡ªå·±	zĂ¬jÇ	tá»± mĂ¬nh, báº£n thĂ¢n	\N	27
4147	å’¨è¯¢	zÄ«xĂºn	tÆ° váº¥n, trÆ°ng cáº§u	\N	24
4084	èµ	zhuĂ n	kiáº¿m tiá»n, lá»£i nhuáº­n	\N	34
4085	è½¬å¼¯	zhuÇnwÄn	ngá»“i	\N	40
4087	ä¸“é•¿	zhuÄnchĂ¡ng	chuyĂªn mĂ´n, Ä‘áº·c trÆ°ng	\N	34
4088	ä¸“ç¨‹	zhuÄnchĂ©ng	chuyáº¿n Ä‘i Ä‘áº·c biá»‡t	\N	34
4089	æ’	zhuĂ ng	Ä‘á»¥ng, va cháº¡m	\N	34
4090	è£…	zhuÄng	hĂ³a trang, trang phá»¥c	\N	34
4149	è‡ªå›æ›´ç”Ÿ	zĂ¬lĂ¬gÄ“ngshÄ“ng	tá»± lá»±c cĂ¡nh sinh	\N	26
4092	å£®è§‚	zhuĂ ngguÄn	Ä‘á»“ sá»™, trĂ¡ng lá»‡	\N	34
4093	ç¶å†µ	zhuĂ ngkuĂ ng	tĂ¬nh hĂ¬nh, tĂ¬nh tráº¡ng	\N	34
4094	å£®ä¸½	zhuĂ nglĂ¬	trĂ¡ng lá»‡	\N	34
4151	å­—å¹•	zĂ¬mĂ¹	phá»¥ Ä‘á»	\N	33
4096	è£…é¥°	zhuÄngshĂ¬	trang trĂ­, trang sá»©c	\N	34
4097	ç¶æ€	zhuĂ ngtĂ i	tráº¡ng thĂ¡i	\N	34
4152	å­—æ¯	zĂ¬mÇ”	chá»¯ cĂ¡i	\N	33
4099	ä¸“ä¸	zhuÄnyĂ¨	chuyĂªn ngĂ nh	\N	34
4100	ä¸“åˆ©	zhuÄnlĂ¬	báº±ng sĂ¡ng cháº¿	\N	34
4102	è½¬è®©	zhuÇnrĂ ng	chuyá»ƒn nhÆ°á»£ng	\N	34
4103	ä¸“é¢˜	zhuÄntĂ­	chá»§ Ä‘á» Ä‘áº·c biá»‡t, chuyĂªn Ä‘á»	\N	34
4104	ä¸“å¿ƒ	zhuÄnxÄ«n	chuyĂªn tĂ¢m	\N	34
4105	è½¬ç§»	zhuÇnyĂ­	thay Ä‘á»•i vá»‹ trĂ­	\N	34
4106	è½¬æ˜	zhuÇnzhĂ©	chuyá»ƒn ngoáº·t, chuyá»ƒn hÆ°á»›ng	\N	34
4107	ä¸»ç®¡	zhÇ”guÇn	ngÆ°á»i chá»§ trĂ¬ tá»• chá»©c	\N	40
4108	é€æ­¥	zhĂºbĂ¹	láº§n lÆ°á»£t, tá»«ng bÆ°á»›c	\N	34
4109	æ³¨å†Œ	zhĂ¹cĂ¨	Ä‘Äƒng kĂ½	\N	31
4110	ä¸»æŒ	zhÇ”chĂ­	chá»§ trĂ¬	\N	40
4111	ä¸»å¯¼	zhÇ”dÇo	chá»§ Ä‘áº¡o	\N	34
4112	ä¸»å¨	zhÇ”dĂ²ng	chá»§ Ä‘á»™ng	\N	34
4113	ç¥ç¦	zhĂ¹fĂº	chĂºc phĂºc	\N	36
4115	ç¥è´º	zhĂ¹hĂ¨	chĂºc má»«ng	\N	34
4116	è¿½æ±‚	zhuÄ«qiĂº	theo Ä‘uá»•i	\N	34
4117	è¿½æ‚¼	zhuÄ«dĂ o	tÆ°á»Ÿng niá»‡m	\N	34
4118	è¿½ç©¶	zhuÄ«jiÅ«	truy cá»©u, truy váº¥n	\N	21
4154	å§¿å¿	zÄ«shĂ¬	tÆ° tháº¿	\N	37
4121	è‘—å	zhĂ¹mĂ­ng	ná»•i tiáº¿ng	\N	34
4122	å‡†å¤‡	zhÇ”nbĂ¨i	chuáº©n bá»‹	\N	40
4123	å‡†ç¡®	zhÇ”nquĂ¨	chĂ­nh xĂ¡c, Ä‘Ăºng Ä‘áº¯n	\N	34
4124	å‡†æ—¶	zhÇ”nshĂ­	Ä‘Ăºng giá»	\N	34
4125	å‡†åˆ™	zhÇ”nzĂ©	nguyĂªn táº¯c	\N	34
4157	æ»‹å‘³	zÄ«wĂ¨i	mĂ¹i vá»‹	\N	24
4127	ç£¨ç»ƒ	mĂ³liĂ n	rĂ¨n luyá»‡n, táº­p luyá»‡n	\N	34
4128	æ¤æ‰‹	hĂ¹shÇ’u	báº£o vá»‡ tay, chÄƒm sĂ³c	\N	34
4129	ç€æƒ³	zhuĂ³xiÇng	suy nghÄ©, lo nghÄ©	\N	34
4130	å“è¶	zhuĂ³yuĂ¨	ná»•i báº­t, trĂ¡c viá»‡t, lá»—i láº¡c	\N	40
4131	ç€é‡	zhuĂ³zhĂ²ng	nháº¥n máº¡nh, chĂº trá»ng	\N	34
4132	ç«¹å­	zhĂºzi	cĂ¢y trĂºc	\N	25
4133	ä½œå“	zuĂ²pÇn	tĂ¡c pháº©m	\N	34
4134	å­—	zĂ¬	chá»¯	\N	33
4135	ç´«	zÇ	mĂ u tĂ­m	\N	24
4159	è‡ªä¿¡	zĂ¬xĂ¬n	tá»± tin	\N	33
4162	è‡ªæ„¿	zĂ¬yuĂ n	tá»± nguyá»‡n	\N	27
4139	èµ„äº§	zÄ«chÇn	tĂ i sáº£n	\N	38
4140	è‡ªå¨	zĂ¬dĂ²ng	tá»± Ä‘á»™ng	\N	34
4141	å­å¼¹	zÇdĂ n	Ä‘áº¡n	\N	31
4142	å­—å…¸	zĂ¬diÇn	tá»« Ä‘iá»ƒn	\N	40
4143	è‡ªå‘	zĂ¬fÄ	tá»± phĂ¡t	\N	30
4172	è¸ªè¿¹	zÅngjĂ¬	dáº¥u váº¿t	\N	24
4148	èµ„æ–™	zÄ«liĂ o	tÆ° liá»‡u, dá»¯ liá»‡u	\N	40
4150	è‡ªæ»¡	zĂ¬mÇn	tá»± mĂ£n	\N	27
4153	è‡ªç„¶	zĂ¬rĂ¡n	tá»± nhiĂªn, thiĂªn nhiĂªn	\N	40
4155	è‡ªç§	zĂ¬sÄ«	Ă­ch ká»·	\N	40
4158	ä»”ç»†	zÇxĂ¬	tá»‰ má»‰, cáº©n tháº­n	\N	30
4160	è‡ªè¡Œè½¦	zĂ¬xĂ­ngchÄ“	xe Ä‘áº¡p	\N	28
4161	è‡ªç”±	zĂ¬yĂ³u	tá»± do	\N	34
4163	èµ„æº	zÄ«yuĂ¡n	tĂ i nguyĂªn	\N	40
4164	æ»‹é•¿	zÄ«zhÇng	phĂ¡t sinh, náº£y sinh	\N	40
4165	èµ„å©	zÄ«zhĂ¹	trá»£ cáº¥p	\N	34
4166	æ€»æ˜¯	zÇ’ng shĂ¬	luĂ´n luĂ´n, lĂºc nĂ o cÅ©ng	\N	34
4168	æ€»å…±	zÇ’nggĂ²ng	tá»•ng cá»™ng, táº¥t cáº£	\N	34
4169	ç»¼åˆ	zÅnghĂ©	tá»•ng há»£p	\N	34
4170	æ€»å’Œ	zÇ’nghĂ©	tá»•ng há»£p, tá»•ng sá»‘	\N	35
4171	çºµæ¨ª	zĂ²nghĂ©ng	tung hoĂ nh, ngang dá»c	\N	34
4173	å®—æ•™	zÅngjiĂ o	tĂ´n giĂ¡o	\N	34
4174	æ€»ç»“	zÇ’ngjiĂ©	tá»•ng káº¿t	\N	34
4175	æ€»ç†	zÇ’nglÇ	thá»§ tÆ°á»›ng	\N	40
4176	æ£•è‰²	zÅngsĂ¨	mĂ u nĂ¢u	\N	24
4177	æ€»ç®—	zÇ’ngsuĂ n	cuá»‘i cĂ¹ng cÅ©ng, nhĂ¬n chung	\N	34
4178	æ€»ç»Ÿ	zÇ’ngtÇ’ng	tá»•ng thá»‘ng	\N	34
4180	å®—æ—¨	zÅngzhÇ	tĂ´n chá»‰, má»¥c Ä‘Ă­ch	\N	34
4181	æ	zĂ²u	Ä‘Ă¡nh Ä‘áº­p	\N	33
4182	èµ°	zÇ’u	Ä‘i, Ä‘i bá»™	\N	40
4183	èµ°å»	zÇ’ulĂ¡ng	hĂ nh lang	\N	21
4184	èµ°æ¼	zÇ’ulĂ²u	rĂ² rá»‰ ra ngoĂ i	\N	40
4185	èµ°ç§	zÇ’usÄ«	buĂ´n láº­u	\N	34
116	æ¥åˆ°	bĂ odĂ o	Ä‘iá»ƒm danh, bĂ¡o danh	\N	21
455	ç¨‹åº	chĂ©ngxĂ¹	chÆ°Æ¡ng trĂ¬nh, trĂ¬nh tá»±	\N	34
4219	ä½œè€…	zuĂ²zhÄ›	tĂ¡c giáº£	\N	37
336	è£å‘˜	cĂ¡iyuĂ¡n	giáº£m biĂªn cháº¿, cáº¯t giáº£m nhĂ¢n viĂªn	\N	40
365	ç­–åˆ’	cĂ¨huĂ 	lĂªn káº¿ hoáº¡ch	\N	40
48	ææ¡	bÇwĂ²	cáº§m, náº¯m, náº¯m báº¯t	\N	35
70	åå…¬å®¤	bĂ ngÅngshĂ¬	vÄƒn phĂ²ng	\N	34
77	åé€”è€ŒåºŸ	bĂ ntĂºâ€™Ă©rfĂ¨i	bá» cuá»™c giá»¯a chá»«ng	\N	35
89	ä¿ç•™	bÇoliĂº	giá»¯ nguyĂªn, báº£o tá»“n	\N	34
103	çˆ†å‘	bĂ ofÄ	bĂ¹ng ná»•, bá»™c phĂ¡t	\N	34
127	ææ‰‹	bÇshÇ’u	tay náº¯m cá»­a, chuĂ´i	\N	35
134	å‘é„™	bÄ“ibÇ	hĂ¨n háº¡, ti tiá»‡n	\N	40
142	èƒŒæ™¯	bĂ¨ijÇng	bá»‘i cáº£nh, ná»n	\N	40
152	å¥”é©°	bÄ“nchĂ­	cháº¡y nhanh, cháº¡y bÄƒng bÄƒng	\N	40
169	æ¯”	bÇ	so, so vá»›i, vĂ­	\N	34
176	å˜å¨	biĂ ndĂ²ng	biáº¿n Ä‘á»™ng, thay Ä‘á»•i	\N	34
192	è¾¹ç¼˜	biÄnyuĂ¡n	giĂ¡p danh, vĂ¹ng ven, biĂªn giá»›i	\N	34
202	æ ‡è¯†	biÄozhĂ¬	cá»™t má»‘c, kĂ½ hiá»‡u	\N	40
214	å¼ç—…	bĂ¬bĂ¬ng	tá»‡ náº¡n, tai háº¡i, sai láº§m	\N	34
227	ç¬”è®°æœ¬	bÇjĂ¬bÄ›n	vá»Ÿ ghi chĂ©p	\N	34
237	å¹¶åˆ—	bĂ¬ngliĂ¨	Ä‘áº·t cáº¡nh nhau, ngang hĂ ng	\N	24
250	å¿…é¡»	bĂ¬xÅ«	pháº£i, cáº§n pháº£i	\N	21
261	åè§ˆä¼	bĂ³lÇnhuĂ¬	há»™i chá»£	\N	34
271	è¡¥å¿	bÇ”chĂ¡ng	bá»“i thÆ°á»ng, Ä‘á»n bĂ¹	\N	34
272	ä¸å½“	bĂ¹dĂ ng	khĂ´ng Ä‘Ă¡ng	\N	34
274	ä¸è§å¾—	bĂ¹jiĂ nde	chÆ°a cháº¯c, khĂ´ng nháº¥t thiáº¿t	\N	35
283	ä¸è¨€è€Œå–»	bĂ¹ yĂ¡n Ă©r yĂ¹	khĂ´ng nĂ³i cÅ©ng rĂµ	\N	35
290	ä¸å¾—å·²	bĂ¹dĂ©yÇ	báº¥t Ä‘áº¯c dÄ©, báº¥t Ä‘áº¯c pháº£i	\N	35
302	ä¸å¯æ€è®®	bĂ¹kÄ›sÄ«yĂ¬	phi thÆ°á»ng, khĂ´ng thá»ƒ tÆ°á»Ÿng tÆ°á»£ng	\N	34
315	ä¸æ‹©æ‰‹æ®µ	bĂ¹zĂ©shÇ’uduĂ n	khĂ´ng tá»« thá»§ Ä‘oáº¡n	\N	34
330	ææ–™	cĂ¡iliĂ o	váº­t liá»‡u, tÆ° liá»‡u	\N	40
350	å‚è°‹	cÄnmĂ³u	tham mÆ°u, cá»‘ váº¥n	\N	34
370	å±‚å‡ºä¸ç©·	cĂ©ngchÅ«bĂ¹qiĂ³ng	liĂªn tiáº¿p xuáº¥t hiá»‡n, táº§ng táº§ng lá»›p lá»›p	\N	34
380	å·®è·	chÄjĂ¹	khoáº£ng cĂ¡ch	\N	34
386	äº§ç”Ÿ	chÇnshÄ“ng	xuáº¥t hiá»‡n, sáº£n sinh	\N	40
402	åœºåˆ	chÇnghĂ©	trÆ°á»ng há»£p	\N	34
414	å€¡è®®	chĂ ngyĂ¬	Ä‘á» xuáº¥t, sĂ¡ng kiáº¿n	\N	40
426	å˜²ç¬‘	chĂ¡oxiĂ o	nháº¡o bĂ¡ng	\N	34
439	æˆå¿ƒ	chĂ©ngxÄ«n	thĂ nh tĂ¢m, cá»‘ Ă½	\N	34
466	ä¹˜å¡å‘˜	chĂ©ngwĂ¹yuĂ¡n	nhĂ¢n viĂªn phá»¥c vá»¥ (trĂªn tĂ u, mĂ¡y bay)	\N	40
482	ç§°å¿ƒå¦‚æ„	chĂ¨nxÄ«n rĂºyĂ¬	vá»«a lĂ²ng Ä‘áº¹p Ă½	\N	34
497	å†²	chÅng	va Ä‘áº­p, Ä‘á»™t kĂ­ch	\N	34
507	é‡é˜³è‚	chĂ³ngyĂ¡ng jiĂ©	táº¿t TrĂ¹ng DÆ°Æ¡ng	\N	34
518	å‡ºå›½	chÅ«guĂ³	ra nÆ°á»›c ngoĂ i	\N	40
526	æ½ç©º	chÅukĂ²ng	dĂ nh thá»i gian, tranh thá»§	\N	30
535	ä¼ è¾¾	zhuÇndĂ¡	truyá»n táº£i	\N	40
541	åºå•	chuĂ¡ngdÄn	khÄƒn tráº£i giÆ°á»ng	\N	34
547	å·æµä¸æ¯	chuÄnliĂºbĂ¹xÄ«	dĂ²ng nÆ°á»›c cháº£y liĂªn tá»¥c, khĂ´ng ngá»«ng	\N	34
579	å‡ºæ¯	chÅ«xÄ«	triá»ƒn vá»ng, tiáº¿n bá»™	\N	34
586	åˆº	cĂ¬	Ä‘Ă¢m, chá»c, chĂ­ch	\N	34
588	æ¬¡å“	cĂ¬ pÇn	loáº¡i hai, thá»© pháº©m	\N	34
4187	ç§Ÿ	zÅ«	thuĂª, mÆ°á»›n, cho thuĂª, tiá»n thuĂª	\N	40
4188	é˜»ç¢	zÇ”â€™Ă i	cáº£n trá»Ÿ	\N	34
4189	é’»çŸ³	zuĂ nshĂ­	kim cÆ°Æ¡ng	\N	34
4190	é’»ç ”	zuÄnyĂ¡n	nghiĂªn cá»©u	\N	40
4214	åç”Ÿæ„	zuĂ² shÄ“ngyĂ¬	lĂ m kinh doanh	\N	40
4192	ç¥–çˆ¶	zÇ”fĂ¹	Ă´ng ná»™i	\N	34
4194	ç»„åˆ	zÇ”hĂ©	tá»• há»£p	\N	34
4195	æœ€	zuĂ¬	nháº¥t	\N	30
4197	å˜´	zuÇ	miá»‡ng, má»“m	\N	34
4198	æœ€å¥½	zuĂ¬ hÇo	tá»‘t nháº¥t	\N	34
4199	å˜´å”‡	zuÇchĂºn	mĂ´i	\N	34
4200	ç½ªç¯	zuĂ¬fĂ n	tá»™i pháº¡m	\N	34
4201	æœ€å	zuĂ¬hĂ²u	cuá»‘i cĂ¹ng	\N	34
4202	æœ€è¿‘	zuĂ¬jĂ¬n	gáº§n Ä‘Ă¢y, dáº¡o nĂ y	\N	34
4203	é˜»æ­¢	zÇ”zhÇ	ngÄƒn cáº£n, ngÄƒn trá»Ÿ	\N	34
4204	ç§Ÿèµ	zÅ«lĂ¬n	thuĂª, cho thuĂª	\N	40
4206	å°æ•¬	zÅ«njĂ¬ng	tĂ´n kĂ­nh	\N	34
4207	éµå®ˆ	zÅ«nshÇ’u	tuĂ¢n thá»§	\N	30
4208	éµå¾ª	zÅ«nxĂºn	theo, tuĂ¢n theo	\N	34
4209	å°ä¸¥	zÅ«nyĂ¡n	tĂ´n nghiĂªm	\N	34
4210	å°é‡	zÅ«nzhĂ²ng	tĂ´n trá»ng	\N	34
4211	å	zuĂ²	ngá»“i	\N	40
4212	åº§	zuĂ²	chá»— ngá»“i, Ä‘á»‡m, tĂ²a	\N	40
4213	ä½œä¸œ	zuĂ²dÅng	lĂ m chá»§	\N	40
4218	ä½œä¸º	zuĂ²wĂ©i	hĂ nh vi, viá»‡c lĂ m	\N	40
4216	ä½œæ–‡	zuĂ²wĂ©n	viáº¿t vÄƒn, lĂ m vÄƒn	\N	40
4217	ä½œç”¨	zuĂ²yĂ²ng	tĂ¡c dá»¥ng	\N	40
488	åƒæƒ	chÄ«jÄ«ng	giáº­t mĂ¬nh, sá»£ hĂ£i	\N	21
4220	æ˜¨å¤©	zuĂ³tiÄn	hĂ´m qua	\N	34
4221	å·¦è¾¹	zuÇ’biÄn	bĂªn trĂ¡i	\N	40
4222	ä½œåºŸ	zuĂ²fĂ¨i	xĂ³a bá», máº¥t hiá»‡u lá»±c	\N	34
4223	ä½œé£	zuĂ²fÄ“ng	phong cĂ¡ch	\N	34
4224	åº§ä½	zuĂ²wĂ¨i	chá»— ngá»“i	\N	40
4225	ä½œä¸	zuĂ²yĂ¨	bĂ i táº­p	\N	32
4227	è¶³å¤Ÿ	zĂºgĂ²u	Ä‘á»§	\N	21
4228	ç¥–å…ˆ	zÇ”xiÄn	tá»• tiĂªn	\N	34
4229	ç»„ç»‡	zÇ”zhÄ«	tá»• chá»©c	\N	40
567	å¤„å¢ƒ	chÇ”jĂ¬ng	cáº£nh ngá»™, hoĂ n cáº£nh	\N	25
4191	ç»„æˆ	zÇ”chĂ©ng	cáº¥u thĂ nh, táº¡o thĂ nh	\N	24
597	è¾èŒ	cĂ­zhĂ­	tá»« chá»©c	\N	27
605	ä»å‰	cĂ³ngqiĂ¡n	trÆ°á»›c Ä‘Ă¢y, ngĂ y trÆ°á»›c	\N	34
636	æ‰“æ±ä¸å¹³	dÇbĂ obĂ¹pĂ­ng	bĂªnh vá»±c, bĂªnh káº» yáº¿u	\N	34
650	ä»£è¡¨	dĂ ibiÇo	Ä‘áº¡i biá»ƒu, Ä‘áº¡i diá»‡n	\N	40
664	å•çº¯	dÄnchĂºn	Ä‘Æ¡n giáº£n, Ä‘Æ¡n thuáº§n	\N	34
674	å½“åœ°	dÄngdĂ¬	báº£n Ä‘á»‹a, báº£n xá»©	\N	35
684	å½“æ—¶	dÄngshĂ­	lĂºc Ä‘Ă³, khi Ä‘Ă³	\N	34
688	å…é€‰	dÇngxuÇn	trĂºng cá»­	\N	34
690	æ·¡å´	dĂ nquĂ¨	nháº¡t Ä‘i, phai nháº¡t	\N	40
703	åˆ°è¾¾	dĂ odĂ¡	Ä‘áº¿n nÆ¡i, Ä‘áº¡t Ä‘áº¿n	\N	34
723	å¤§ä½¿	dĂ shÇ	tráº¡ng trá»ng, khĂ´ng kiĂªng ná»ƒ	\N	34
738	å¾—ä¸å¿å¤±	dĂ©bĂ¹chĂ¡ngshÄ«	háº¡i nhiá»u hÆ¡n lá»£i, lá»£i Ă­t háº¡i nhiá»u	\N	35
753	å¾—å¤©ç‹¬å	dĂ©tiÄndĂºhĂ²u	gáº·p may máº¯n, Ä‘Æ°á»£c Æ°u Ă¡i	\N	35
773	ç”µå¤´	diĂ ntĂ³u	gáº­t Ä‘áº§u	\N	24
783	è°ƒæŸ¥	diĂ ochĂ¡	Ä‘iá»u tra	\N	40
794	åœ°æ–¹	dĂ¬fÄng	Ä‘á»‹a phÆ°Æ¡ng, chá»—, nÆ¡i, vĂ¹ng	\N	35
795	æµæ—	dÇkĂ ng	chá»‘ng láº¡i, Ä‘á» khĂ¡ng, chá»‘ng cá»±	\N	34
803	ç„ç¡®	dĂ­quĂ¨	tháº­t, Ä‘Ă­ch thá»±c	\N	35
824	è‘£äº‹é•¿	dÇ’ngshĂ¬ zhÇng	chá»§ tá»‹ch há»™i Ä‘á»“ng quáº£n trá»‹	\N	34
843	æ–­ç»	duĂ njuĂ©	cáº¯t Ä‘á»©t, Ä‘oáº¡n tuyá»‡t	\N	34
854	å¯¹æ–¹	duĂ¬fÄng	phĂ­a bĂªn kia, Ä‘á»‘i phÆ°Æ¡ng	\N	34
879	é¡¿æ—¶	dĂ¹nshĂ­	ngay, liá»n, tá»©c kháº¯c	\N	40
892	è¯»ä¹¦	dĂºshÅ«	Ä‘á»c sĂ¡ch	\N	34
896	æ¶å¿ƒ	Ä›xÄ«n	buá»“n nĂ´n	\N	34
900	è€Œä¸”	Ă©rqiÄ›	mĂ  cĂ²n, hÆ¡n ná»¯a	\N	35
917	å‘ç«	fÄhuÇ’	ná»•i giáº­n	\N	34
923	åé©³	fÇnbĂ³	bĂ¡c bá», pháº£n Ä‘á»‘i	\N	34
937	æ–¹	fÄng	vuĂ´ng	\N	34
942	æ–¹ä¾¿	fÄngbiĂ n	thuáº­n tiá»‡n, thuáº­n lá»£i	\N	34
957	æ”¾æ˜ 	fĂ ngyĂ¬ng	trĂ¬nh chiáº¿u, chiáº¿u phim	\N	40
968	çƒ¦æ¼	fĂ¡nnÇo	phiá»n nĂ£o, phiá»n muá»™n	\N	34
981	å‘è¨€	fÄyĂ¡n	phĂ¡t biá»ƒu	\N	40
991	è¯½è°¤	fÄ›ibĂ ng	nĂ³i xáº¥u, phá»‰ bĂ¡ng, giĂ¨m pha	\N	34
997	é£ç¦½èµ°å…½	fÄ“iqĂ­n zÇ’ushĂ²u	chim bay cĂ¡ nháº£y, chim trá»i cĂ¡ nÆ°á»›c	\N	40
1006	åˆ†åˆ«	fÄ“nbiĂ©	phĂ¢n biá»‡t	\N	30
1012	ä¸°ç››	fÄ“ngshĂ¨ng	phong phĂº, nhiá»u, giĂ u cĂ³	\N	34
1022	ä¸°æ»¡	fÄ“ngmÇn	sung tĂºc, Ä‘áº§y Ä‘á»§, Ä‘áº§y áº¯p	\N	34
1037	åˆ†é‡	fĂ¨nliĂ ng	trá»ng lÆ°á»£ng, sá»©c náº·ng	\N	34
1055	å²—ä½	gÇngwĂ¨i	cÆ°Æ¡ng vá»‹, vá»‹ trĂ­ cĂ´ng tĂ¡c	\N	34
1068	å¹²æ¶‰	gÄnshĂ¨	can thiá»‡p	\N	34
1077	é«˜è¶…	gÄochÄo	cao siĂªu, tuyá»‡t vá»i	\N	34
1087	é«˜é€Ÿå…¬è·¯	gÄosĂ¹ gÅnglĂ¹	Ä‘Æ°á»ng cao tá»‘c	\N	34
1102	æ ¹æ®	gÄ“njĂ¹	cÄƒn cá»©, dá»±a vĂ o	\N	40
1109	æ›´æ–°	gÄ“ngxÄ«n	thay má»›i, Ä‘á»•i má»›i, canh tĂ¢n	\N	40
1118	å„æ’å·±è§	gĂ¨shÅ«jÇjiĂ n	má»—i ngÆ°á»i Ä‘Æ°a ra Ă½ kiáº¿n cá»§a riĂªng mĂ¬nh	\N	40
1135	å…¬å…³	gÅngguÄn	giao tiáº¿p, Ä‘á»‘i ngoáº¡i, xĂ£ há»™i	\N	34
1147	åŸèƒ½	gÅngnĂ©ng	cĂ´ng nÄƒng, tĂ¡c dá»¥ng	\N	34
1158	åŸç”¨	gÅngyĂ²ng	cĂ´ng nÄƒng, cĂ´ng hiá»‡u	\N	34
1172	è´­ç»“	gĂ²ujiĂ©	cĂ¢u káº¿t, thĂ´ng Ä‘á»“ng	\N	34
1184	å…³é”®	guÄnjiĂ n	then chá»‘t, máº¥u chá»‘t	\N	34
1198	å…‰æ»‘	guÄnghuĂ¡	trÆ¡n tru, nháºµn bĂ³ng	\N	34
1200	å¹¿é˜”	guÇngkuĂ²	rá»™ng lá»›n, bĂ¡t ngĂ¡t	\N	34
1217	é¼“å¨	gÇ”dĂ²ng	cá»• Ä‘á»™ng, khuyáº¿n khĂ­ch, xĂºi giá»¥c	\N	34
1230	è§„èŒƒ	guÄ«fĂ n	quy táº¯c, tiĂªu chuáº©n	\N	40
1240	ä¼°è®¡	gÅ«jĂ¬	Ä‘Ă¡nh giĂ¡, Æ°á»›c Ä‘oĂ¡n	\N	34
1252	è¿‡ç¨‹	guĂ²chĂ©ng	quĂ¡ trĂ¬nh	\N	40
1271	è¿‡ç˜¾	guĂ²yÇn	thá»a nguyá»‡n, thá»a thĂ­ch	\N	34
1274	æ‚ä¸”	zĂ nqiÄ›	táº¡m thá»i	\N	34
1284	å›ºæœ‰	gĂ¹yÇ’u	vá»‘n cĂ³, sáºµn cĂ³, cá»‘ há»¯u	\N	34
1286	é¡½å›º	wĂ¡ngĂ¹	bÆ°á»›ng bá»‰nh	\N	34
1297	æµ·æ´‹	hÇiyĂ¡ng	biá»ƒn, Ä‘áº¡i dÆ°Æ¡ng	\N	34
1308	ç½•è§	hÇnjiĂ n	hiáº¿m tháº¥y, Ă­t tháº¥y	\N	40
1323	å¥½åƒ	hÇoxiĂ ng	hĂ¬nh nhÆ°, dÆ°á»ng nhÆ°	\N	34
1332	åˆæ ¼	hĂ©gĂ©	há»£p lá»‡, Ä‘áº¡t chuáº©n	\N	40
1344	æ¨ä¸å¾—	hÄ›nbĂ¹dĂ©	háº­n khĂ´ng thá»ƒ, muá»‘n	\N	35
1361	çº¢åŒ…	hĂ³ngbÄo	tiá»n thÆ°á»Ÿng, tiá»n lĂ¬ xĂ¬	\N	34
1369	åé¡¾ä¹‹å¿§	hĂ²ugĂ¹zhÄ«yÅu	ná»—i lo vá» sau	\N	40
1380	è±ç“£	huÄbĂ n	cĂ¡nh hoa	\N	25
1389	æ¢	huĂ n	Ä‘á»•i, thay Ä‘á»•i, trao Ä‘á»•i	\N	40
1401	æ…Œå¼ 	huÄngzhÄng	hoang mang, rá»‘i loáº¡n	\N	34
1412	ç”»è›‡æ·»è¶³	huĂ shĂ©tiÄnzĂº	váº½ ráº¯n thĂªm chĂ¢n, váº½ vá»i vĂ´ Ă­ch, lĂ m chuyá»‡n dÆ° thá»«a	\N	40
1433	å›é¡¾	huĂ­gĂ¹	nhĂ¬n láº¡i, há»“i tÆ°á»Ÿng	\N	34
1444	äº’è”ç½‘	hĂ¹liĂ¡nwÇng	internet	\N	40
1451	æµ‘èº«	hĂºnshÄ“n	toĂ n thĂ¢n, kháº¯p ngÆ°á»i	\N	34
1462	ç«ç®­	huÇ’jiĂ n	tĂªn lá»­a, há»a tiá»…n	\N	34
1474	å‘¼å•¸	hÅ«xiĂ o	gĂ o thĂ©t, rĂ­t, hĂ² hĂ©t	\N	34
1500	åå¼º	jiÄnqiĂ¡ng	máº¡nh máº½, kiĂªn cÆ°á»ng	\N	34
712	é“æ­‰	dĂ oqiĂ n	xin thá»© lá»—i, xin chá»‹u lá»—i	\N	30
869	å¯¹æ—	duĂ¬kĂ ng	Ä‘á»‘i khĂ¡ng, Ä‘á»‘i Ä‘áº§u	\N	24
1487	å®¶å¸¸	jiÄchĂ¡ng	viá»‡c thÆ°á»ng ngĂ y, chuyá»‡n nhĂ 	\N	30
812	æµåˆ¶	dÇzhĂ¬	ngÄƒn cháº·n, ngÄƒn láº¡i	\N	24
864	æ¨	tuÄ«	Ä‘áº©y, Ä‘Ă¹n, má»Ÿ rá»™ng	\N	34
906	åˆ¶æ­¢	zhĂ¬zhÇ	ngÄƒn cáº¥m, cháº·n Ä‘á»©ng	\N	34
1110	æ›´æ”¹	gÄ“nggÇi	cáº£i chĂ­nh, Ä‘Ă­nh chĂ­nh, sá»­a láº¡i	\N	25
1263	å›½åº†è‚	guĂ³qĂ¬ngjiĂ©	ngĂ y quá»‘c khĂ¡nh	\N	30
1484	é©¾é©¶	jiĂ shÇ	lĂ¡i xe	\N	28
1512	å‰ªå½±	jiÇnyÇng	bĂ³ng cáº¯t, hĂ¬nh bĂ³ng	\N	34
1532	äº¤å¾€	jiÄowÇng	qua láº¡i, lui tá»›i	\N	34
1534	é¥ºå­	jiÇozi	bĂ¡nh cháº»o, sá»§i cáº£o	\N	21
1552	è·µè¸	jiĂ ntĂ 	dáº«m, giáº«m, giĂ y xĂ©o	\N	34
1563	åè´	jiÄnzhÄ“n	quáº£ lĂ , tháº­t lĂ 	\N	40
1574	äº¤æ¶‰	jiÄoshĂ¨	can thiá»‡p, Ä‘Ă m phĂ¡n	\N	34
1589	ç–¾ç—…	jĂ­bĂ¬ng	bá»‡nh táº­t	\N	40
1596	æ¿€å¨	jÄ«dĂ²ng	kĂ­ch Ä‘á»™ng	\N	34
1603	è‚æ—¥	jiĂ©rĂ¬	ngĂ y táº¿t, ngĂ y lá»…	\N	30
1611	ç«­å°½å…¨å›	jiĂ©jĂ¬n quĂ¡nlĂ¬	dá»‘c toĂ n lá»±c	\N	34
1623	æ¥å—	jiÄ“shĂ²u	tiáº¿p nháº­n	\N	40
1632	å€Ÿå©	jiĂ¨zhĂ¹	nhá» vĂ o, cáº­y vĂ o	\N	34
1644	æœºä¼	jÄ«huĂ¬	cÆ¡ há»™i, dá»‹p	\N	34
1655	æ¿€å±	jÄ«lĂ¬	khĂ­ch lá»‡, khuyáº¿n khĂ­ch	\N	40
1674	ç»å¸¸	jÄ«ngchĂ¡ng	thÆ°á»ng, thÆ°á»ng xuyĂªn	\N	34
1688	ç²¾è‡´	jÄ«ngzhĂ¬	tinh táº¿	\N	40
1700	ç²¾å‡†	jÄ«ngzhÇ”n	chĂ­nh xĂ¡c	\N	34
1709	é‡‘è	jÄ«nrĂ³ng	tĂ i chĂ­nh	\N	38
1721	æ€å·§	jĂ¬qiÇo	ká»¹ xáº£o	\N	34
1725	é›†ä¸­	jĂ­zhÅng	táº­p trung	\N	34
1731	è®¡ç®—æœº	jĂ¬suĂ njÄ«	mĂ¡y tĂ­nh	\N	40
1747	ç»§å¾€å¼€æ¥	jĂ¬wÇng kÄilĂ¡i	tiáº¿p ná»‘i ngÆ°á»i trÆ°á»›c, má»Ÿ lá»‘i cho ngÆ°á»i sau	\N	40
1756	æ€¥äºæ±‚æˆ	jĂ­yĂº qiĂºchĂ©ng	vá»™i vĂ ng mong Ä‘áº¡t Ä‘Æ°á»£c thĂ nh cĂ´ng	\N	34
1773	å†³èµ›	juĂ©sĂ i	tráº­n chung káº¿t	\N	40
1787	å†›é˜Ÿ	jÅ«nduĂ¬	quĂ¢n Ä‘á»™i	\N	34
1815	ç 	kÇn	cháº·t	\N	30
1821	æ…·æ…¨	kÄngkÇi	hĂ o phĂ³ng, hĂ¹ng há»“n	\N	34
1839	å®¢æˆ¿	kĂ¨fĂ¡ng	phĂ²ng khĂ¡ch (khĂ¡ch sáº¡n)	\N	34
1840	å®¢è§‚	kĂ¨guÄn	khĂ¡ch quan	\N	30
1842	è¯¾ç¨‹	kĂ¨chĂ©ng	lá»‹ch dáº¡y há»c	\N	34
1855	è¯¾å ‚	kĂ¨tĂ¡ng	lá»›p há»c, giáº£ng Ä‘Æ°á»ng	\N	34
1856	å®¢æ ˆ	kĂ¨zhĂ n	quĂ¡n trá» (náº¿u trong áº£nh dá»«ng á»Ÿ 2163 khĂ¡c, báº¡n cho mĂ¬nh áº£nh rĂµ dĂ²ng cuá»‘i Ä‘á»ƒ mĂ¬nh sá»­a Ä‘Ăºng)	\N	40
1863	å¯è§	kÄ›jiĂ n	cĂ³ thá»ƒ tháº¥y	\N	34
1871	å¯ç¬‘	kÄ›xiĂ o	ná»±c cÆ°á»i, buá»“n cÆ°á»i	\N	34
1885	æŒ	kuĂ 	cáº¯p, xĂ¡ch, khoĂ¡c, Ä‘ai	\N	34
1895	å›°	kĂ¹n	khá»‘n khá»•, khĂ³ khÄƒn, má»‡t, buá»“n ngá»§	\N	34
1910	è€æ¿	lÇobÇn	Ă´ng chá»§	\N	34
1919	è‹¦ç¬‘	kÇ”xiĂ o	cÆ°á»i khá»•, cÆ°á»i gÆ°á»£ng	\N	34
1942	è€å©†å©†	lÇopopo	bĂ  ná»™i, bĂ  ngoáº¡i	\N	34
1957	å†·å´	lÄ›ngquĂ¨	lĂ m láº¡nh, Ä‘á»ƒ nguá»™i	\N	34
1970	å‰å®³	lĂ¬hĂ i	lá»£i háº¡i, dá»¯ dá»™i, gay gáº¯t	\N	40
1990	èå¤©	liĂ¡otiÄn	tĂ¡n gáº«u, trĂ² chuyá»‡n	\N	34
1995	çƒˆæ€§	liĂ¨xĂ¬ng	máº¡nh máº½, dá»¯ dá»™i, gay gáº¯t	\N	34
2007	å›æ‰€èƒ½å	lĂ¬suÇ’nĂ©ngjĂ­	kháº£ nÄƒng cho phĂ©p	\N	35
2021	ç•™å¿µ	liĂºniĂ n	lÆ°u niá»‡m, ká»· niá»‡m	\N	40
2032	ç†ç›´æ°”å£®	lÇzhĂ­qĂ¬zhuĂ ng	cĂ¢y ngay khĂ´ng sá»£ cháº¿t Ä‘á»©ng	\N	34
2048	è½®èˆ¹	lĂºnchuĂ¡n	thuyá»n cháº¡y báº±ng hÆ¡i nÆ°á»›c	\N	40
2060	ç»œç»ä¸ç»	luĂ²yĂ¬ bĂ¹ juĂ©	lÅ© lÆ°á»£t kĂ©o Ä‘áº¿n	\N	34
2068	å˜›	ma	mĂ , nhá»‰	\N	40
2071	éº»ç—¹	mĂ¡bĂ¬	bá»‡nh tĂª liá»‡t	\N	40
2080	åŸ‹è‘¬	mĂ¡izĂ ng	chĂ´n giáº¥u, chĂ´n cáº¥t	\N	34
2090	èŒ«ç„¶	mĂ¡ngrĂ¡n	mĂ¹ tá»‹t, cháº³ng biáº¿t gĂ¬	\N	40
2100	æ¯›ç—…	mĂ¡obĂ¬ng	lá»—i, táº­t xáº¥u	\N	34
2112	ç¾ä¸½	mÄ›ilĂ¬	Ä‘áº¹p, xinh Ä‘áº¹p	\N	34
2123	ç¾å¦™	mÄ›imiĂ o	tuyá»‡t vá»i, tÆ°Æ¡i Ä‘áº¹p	\N	34
2137	å…è´¹	miÇnfĂ¨i	miá»…n phĂ­	\N	40
2150	èœœèœ‚	mĂ¬fÄ“ng	ong	\N	34
2159	åé¢	mĂ­ng'Ă©	sá»‘ ngÆ°á»i	\N	34
2177	è¿·å¤±	mĂ­shÄ«	máº¥t phÆ°Æ¡ng hÆ°á»›ng	\N	34
2181	æ‘©æ“¦	mĂ³cÄ	ma sĂ¡t	\N	40
2186	è«åå…¶å¦™	mĂ²mĂ­ngqĂ­miĂ o	khĂ´ng hiá»ƒu ra sao	\N	34
2191	æœç´¢	sÅusuÇ’	tĂ¬m kiáº¿m	\N	40
2198	æœ¨å¤´	mĂ¹tou	gá»—	\N	34
2204	è€å¿ƒ	nĂ ixÄ«n	kiĂªn nháº«n	\N	40
2212	é¾å ª	nĂ¡nkÄn	khĂ³ chá»‹u	\N	34
2230	å¹´é¾„	niĂ¡nlĂ­ng	tuá»•i	\N	34
2238	å†œä¸	nĂ³ngyĂ¨	nĂ´ng nghiá»‡p	\N	34
2248	æ”€ç™»	pÄndÄ“ng	leo, trĂ¨o	\N	34
2258	èƒ½é‡	nĂ©ngliĂ ng	nÄƒng lÆ°á»£ng	\N	34
2267	å‡å›º	nĂ­nggĂ¹	cá»©ng láº¡i, Ä‘Ă´ng Ä‘áº·c	\N	34
2279	è™å¾…	nĂ¼Ă¨dĂ i	hĂ nh háº¡, ngÆ°á»£c Ä‘Ă£i	\N	34
2289	æ¬§æ´²	ÅuzhÅu	chĂ¢u Ă‚u	\N	24
2294	æ’é˜Ÿ	pĂ¡iduĂ¬	xáº¿p hĂ ng, sáº¯p xáº¿p	\N	40
2302	æ—è¾¹	pĂ¡ngbiÄn	bĂªn cáº¡nh	\N	34
2311	é…å¶	pĂ¨iâ€™Ç’u	vá»£, chá»“ng, phá»‘i ngáº«u	\N	34
2325	æ‰¹è¯„	pÄ«pĂ­ng	chá»‰ trĂ­ch, phĂª bĂ¬nh	\N	40
2333	æ‹¼æ	pÄ«nbĂ³	Ä‘áº¥u tranh	\N	24
2343	å¹³æ–¹	pĂ­ngfÄng	vuĂ´ng, bĂ¬nh phÆ°Æ¡ng	\N	34
2380	æ›å…‰	pĂ¹guÄng	phÆ¡i bĂ y, lá»™ ra	\N	40
2390	å‰	qiĂ¡n	trÆ°á»›c	\N	34
2396	ç­¾ç½²	qiÄnshÇ”	kĂ½ tĂªn, kĂ½	\N	34
1665	è¿‘ä»£	jĂ¬ndĂ i	cáº­n Ä‘áº¡i	\N	31
1740	æ•‘æµ	jiĂ¹jĂ¬	cá»©u táº¿	\N	36
2364	è„¾æ°”	pĂ­qi	tĂ­nh khĂ­, tĂ¢m tráº¡ng, tĂ­nh tĂ¬nh, tĂ­nh cĂ¡ch	\N	34
2397	ç­¾è¯	qiÄnzhĂ¨ng	visa	\N	40
2169	æ°‘é—´	mĂ­njiÄn	dĂ¢n gian	\N	37
1934	åƒåœ¾æ¡¶	lÄjÄ«tÇ’ng	thĂ¹ng rĂ¡c	\N	30
1983	è¿åŒ	liĂ¡ntĂ³ng	tĂ­nh cáº£, gĂ³p láº¡i, ká»ƒ cáº£	\N	25
1689	ç«äº‰	zhÄ“ngzhÄ“ng	ngo ngoe, vung váº«y, Ä‘áº¥u tranh	\N	34
2219	é—¹é’Ÿ	nĂ ozhÅng	Ä‘á»“ng há»“ bĂ¡o thá»©c	\N	30
2352	å¹³æ—¶	pĂ­ngshĂ­	bĂ¬nh thÆ°á»ng, ngĂ y thÆ°á»ng	\N	30
2409	å¼ºå¿	qiĂ¡ngrÄ›n	nháº«n nhá»‹n, nĂ­n nhá»‹n	\N	40
2419	ç‰µå¼ºé™„ä¼	qiÄnqiĂ¡ngfĂ¹huĂ¬	gÆ°á»£ng Ă©p, cÆ°á»¡ng giáº£i thĂ­ch	\N	34
2434	å·§å·§	qiĂ qiÇo	Ä‘Ăºng lĂºc, vá»«a khĂ©o	\N	34
2448	èµ·è´Ÿ	qÇfĂ¹	Ă¢n hiá»‡p, báº­t láº¡i	\N	40
2458	æœŸé—´	qĂ­jiÄn	dá»‹p, thá»i ká»³, thá»i gian	\N	34
2473	æ¸…æ¥	qÄ«ngchu	rĂµ rĂ ng, minh máº«n, hiá»ƒu rĂµ	\N	40
2487	æ¸…çˆ½	qÄ«ngshuÇng	dá»… chá»‹u, mĂ¡t máº»	\N	34
2497	å‹¤å³	qĂ­nlĂ¡o	siĂªng nÄƒng, cáº§n cĂ¹, cáº§n máº«n	\N	34
2507	æ°”é­„	qĂ¬pĂ²	khĂ­ tháº¿, quang cáº£nh	\N	40
2516	æœŸé™	qÄ«xiĂ n	ká»³ háº¡n, thá»i háº¡n	\N	34
2537	æŸ“	rÇn	nhuá»™m, mĂ , tháº¿ mĂ , song	\N	34
2549	å¿ä¸ä½	rÄ›n bĂ¹ zhĂ¹	khĂ´ng thá»ƒ cÆ°á»¡ng láº¡i	\N	34
2562	çƒ­å¿ƒè‚ 	rĂ¨xÄ«nchĂ¡ng	tá»‘t bá»¥ng, nhiá»‡t tĂ¢m	\N	34
2573	å®¹é‡	rĂ³ngliĂ ng	dung lÆ°á»£ng	\N	34
2578	è£èª‰è¯ä¹¦	rĂ³ngyĂ¹ zhĂ¨ngshÅ«	giáº¥y chá»©ng nháº­n danh dá»±	\N	40
2593	äººå®¶	rĂ©njiÄ	nhá»¯ng ngÆ°á»i khĂ¡c	\N	34
2605	äººæ€§	rĂ©nxĂ¬ng	nhĂ¢n tĂ­nh	\N	40
2610	äººè´¨	rĂ©nzhĂ¬	con tin	\N	34
2616	æ•£æ­¥	sĂ nbĂ¹	Ä‘i dáº¡o	\N	34
2622	è‰²å½©	sĂ¨cÇi	mĂ u sáº¯c	\N	24
2630	ç­›é€‰	shÄixuÇn	sĂ ng lá»c, chá»n lá»c	\N	34
2641	ä¸çº§	shĂ ngjĂ­	cáº¥p trĂªn, thÆ°á»£ng cáº¥p	\N	34
2653	å–„è‰¯	shĂ nliĂ¡ng	háº£o tĂ¢m, lÆ°Æ¡ng thiá»‡n	\N	34
2667	è®¾å¤‡	shĂ¨bĂ¨i	thiáº¿t bá»‹	\N	40
2673	è®¾æ–½	shĂ¨shÄ«	thiáº¿t bá»‹, cĂ´ng trĂ¬nh	\N	34
2677	ç¥å¥‡	shĂ©n qĂ­	tháº§n ká»³	\N	30
2691	ç”Ÿç—…	shÄ“ngbĂ¬ng	bá»‹ á»‘m, sinh bá»‡nh	\N	34
2704	å£°æ˜	shÄ“ngmĂ­ng	tuyĂªn bá»‘, thanh minh	\N	34
2748	ä¼¼ç„	shĂ¬ de	dÆ°á»ng nhÆ°, tá»±a nhÆ°	\N	35
2756	å¸‚åœº	shĂ¬chÇng	thá»‹ trÆ°á»ng, chá»£	\N	34
2768	å®è¯	shĂ­huĂ 	sá»± tháº­t, nĂ³i tháº­t	\N	34
2779	ä¸–ç•Œè§‚	shĂ¬jiĂ¨guÄn	tháº¿ giá»›i quan	\N	40
2790	äº‹æƒ…	shĂ¬qĂ­ng	sá»± tĂ¬nh, sá»± viá»‡c	\N	40
2812	äº‹ç‰©	shĂ¬wĂ¹	Ä‘iá»u, váº­t, thá»©	\N	40
2823	æ–½å±•	shÄ«zhÇn	phĂ¡t huy, thi thá»‘ (nÄƒng lá»±c)	\N	34
2838	ç”©	shuÇi	vung, quÄƒng, nĂ©m	\N	40
2847	çˆ½å¿«	shuÇngkuĂ i	sáº£ng khoĂ¡i, dá»… chá»‹u	\N	34
2859	æ°´æœ	shuÇguÇ’	hoa quáº£	\N	34
2868	æ ‘ç«‹	shĂ¹lĂ¬	thĂ nh láº­p, xĂ¢y dá»±ng	\N	40
2882	èˆ’é€‚	shÅ«shĂ¬	dá»… chá»‹u, thoáº£i mĂ¡i	\N	34
2892	ä¸æ¯«	sÄ«hĂ¡o	ti, tĂ­, máº£y may, chĂºt nĂ o	\N	34
2902	è‚†æ— å¿Œæƒ®	sĂ¬wĂºjĂ¬dĂ n	tráº¯ng trá»£n, khĂ´ng kiĂªng ná»ƒ gĂ¬ cáº£	\N	34
2921	éèº«	suĂ­shÄ“n	mang theo, tĂ¹y thĂ¢n	\N	34
2938	ç´ é£Ÿä¸»ä¹‰	sĂ¹shĂ­ zhÇ”yĂ¬	chá»§ nghÄ©a Äƒn chay	\N	40
2953	å¤ªææ‹³	tĂ ijĂ­quĂ¡n	thĂ¡i cá»±c quyá»n	\N	40
2966	è¶Ÿ	tĂ ng	chuyáº¿n Ä‘i, lÆ°á»£t	\N	34
2975	æ¢ç´¢	tĂ nsuÇ’	khĂ¡m phĂ¡	\N	34
2983	é™¶ç“·	tĂ¡ocĂ­	Ä‘á»“ gá»‘m	\N	34
2993	ç‰¹å®	tĂ¨dĂ¬ng	Ä‘áº·c biá»‡t, Ä‘áº·c sáº¯c	\N	34
3004	å¤©æ‰	tiÄncĂ¡i	thiĂªn tĂ i	\N	40
3015	å¤©çœŸ	tiÄnzhÄ“n	ngĂ¢y thÆ¡, há»“n nhiĂªn	\N	34
3024	æ¡ä¾‹	tiĂ¡olĂ¬	luáº­t lá»‡, Ä‘iá»u lá»‡	\N	40
3045	åœé¡¿	tĂ­ngdĂ¹n	táº¡m ngá»«ng, ngáº¯t quĂ£ng	\N	34
3059	é€è´§è†¨èƒ€	tÅng huĂ² pĂ©ngzhĂ ng	sá»± láº¡m phĂ¡t	\N	34
3069	åŒæƒ…	tĂ³ngqĂ­ng	Ä‘á»“ng cáº£m, thĂ´ng cáº£m	\N	34
3086	åœŸ	tÇ”	Ä‘áº¥t, thá»•	\N	34
3095	è…¿	tuÇ	chĂ¢n, Ä‘Ă¹i	\N	30
3115	æ‹–å»¶	tuÅyĂ¡n	trĂ¬ hoĂ£n, kĂ©o dĂ i	\N	34
3126	æ­ª	wÄi	nghiĂªng, lá»‡ch, xiĂªu váº¹o	\N	34
3133	ç“¦è§£	wÇjiÄ›	sá»¥p Ä‘á»•, tan rĂ£	\N	34
3151	å¾€äº‹	wÇngshĂ¬	chuyá»‡n cÅ©, quĂ¡ khá»©	\N	40
3160	æƒ‹æƒœ	wÇnxÄ«	thÆ°Æ¡ng tiáº¿c, xĂ³t thÆ°Æ¡ng	\N	34
3173	è¿å	wĂ©ifÇn	vi pháº¡m	\N	34
3178	å¾®ä¸è¶³é“	wÄ“ibĂ¹zĂºdĂ o	khĂ´ng cĂ³ Ă½ nghÄ©a	\N	34
3191	å¨å›	wÄ“ilĂ¬	sá»©c máº¡nh, uy lá»±c	\N	34
3215	æ¸©å’Œ	wÄ“nhĂ©	Ă´n hĂ²a, nháº¹ nhĂ ng	\N	35
3226	æ–‡è‰º	wĂ©nyĂ¬	vÄƒn nghá»‡	\N	33
3235	å§å®¤	wĂ²shĂ¬	phĂ²ng ngá»§	\N	34
3240	æ— å¯å¥‰å‘	wĂºkÄ› fĂ¨nggĂ o	khĂ´ng cĂ³ gĂ¬ Ä‘á»ƒ nĂ³i, miá»…n bĂ¬nh luáº­n	\N	34
3248	æ— å¨äºè¡·	wĂºdĂ²ngyĂºzhÅng	thá» Æ¡, lĂ£nh Ä‘áº¡m	\N	34
3269	æ­¦è£…	wÇ”zhuÄng	vÅ© trang	\N	34
3276	éœ	xiĂ¡	rĂ¡ng mĂ¢y (sĂ¡ng hoáº·c tá»‘i)	\N	40
3283	ç‹­çª„	xiĂ¡zhÇi	háº¹p, cháº­t háº¹p	\N	34
3299	é™·é˜±	xiĂ njÇng	cĂ¡i báº«y	\N	40
3315	ç›¸å	xiÄngfÇn	tÆ°Æ¡ng pháº£n, ngÆ°á»£c láº¡i	\N	40
3332	è¡”æ¥	xiĂ¡njiÄ“	liĂªn káº¿t, ná»‘i tiáº¿p	\N	34
3343	ç°ä»»	xiĂ nrĂ¨n	Ä‘ang giá»¯ chá»©c vá»¥	\N	23
3351	æ¶ˆæ¯’	xiÄodĂº	táº©y uáº¿, khá»­ trĂ¹ng	\N	34
3353	æ¶ˆè´¹	xiÄofĂ¨i	tiĂªu thá»¥, tiĂªu dĂ¹ng	\N	40
3362	æ•ˆç‡	xiĂ olÇœ	hiá»‡u suáº¥t, nÄƒng suáº¥t	\N	40
3377	ä¸‹åˆ	xiĂ wÇ”	buá»•i chiá»u	\N	40
2529	ç¾¤	qĂºn	báº§y, Ä‘Ă n, tá»‘p	\N	21
3290	çº¿	xiĂ n	sá»£i, Ä‘Æ°á»ng	\N	34
2719	ç¥è¯	shĂ©nhuĂ 	truyá»n thuyáº¿t	\N	30
2722	å®¡ç†	shÄ›nlÇ	tháº©m tra xá»­ lĂ½	\N	40
2731	èº«ä½“	shÄ“ntÇ	cÆ¡ thá»ƒ, thĂ¢n thá»ƒ	\N	24
3103	æ¨è	tuÄ«jiĂ n	giá»›i thiá»‡u, Ä‘á» cá»­	\N	30
3205	ç»´ä¿®	wĂ©ixiÅ«	sá»­a chá»¯a, duy tu	\N	26
3254	æ— å¯å¥ˆä½•	wĂºkÄ›nĂ ihĂ©	Ä‘Ă nh chá»‹u, báº¥t lá»±c	\N	22
3310	ç›¸ä¼¼	xiÄngsĂ¬	giá»‘ng, tÆ°Æ¡ng tá»±	\N	34
3386	åè®®	xiĂ©yĂ¬	hiá»‡p nghá»‹, thá»a thuáº­n	\N	34
3399	å…´å¥‹	xÄ«ngfĂ¨n	hÆ°ng pháº¥n, pháº¥n khĂ­ch	\N	34
3412	æ–°é™ˆä»£è°¢	xÄ«nchĂ©ndĂ ixiĂ¨	sá»± thay cÅ© Ä‘á»•i má»›i, trao Ä‘á»•i cháº¥t	\N	40
3428	æ€§æƒ…	xĂ¬ngqĂ­ng	tĂ­nh tĂ¬nh, tĂ­nh náº¿t	\N	40
3441	æ–°éƒ	xÄ«nlĂ¡ng	chĂº rá»ƒ	\N	40
3448	ä¿¡ä»»	xĂ¬nrĂ¨n	tin tÆ°á»Ÿng, tĂ­n nhiá»‡m	\N	34
3458	å¿ƒè„	xÄ«nzĂ ng	tim	\N	24
3460	å…„å¼Ÿ	xiÅngdĂ¬	anh em trai	\N	40
3467	é›„ä¼Ÿ	xiĂ³ngwÄ›i	hĂ¹ng vÄ©, trĂ¡ng lá»‡	\N	34
3480	å–œé—»ä¹è§	xÇwĂ©nlĂ¨jiĂ n	ráº¥t hoan nghĂªnh, vui tai vui máº¯t	\N	34
3494	æ‚¬å¿µ	xuĂ¡nniĂ n	há»“i há»™p, tháº¥p thá»m	\N	34
3507	é›ªä¸å éœœ	xuÄ›shĂ ngjiÄshuÄng	thĂªm khá»• nĂ y Ä‘áº¿n khá»• khĂ¡c, liĂªn tiáº¿p gáº·p náº¡n	\N	34
3526	å¾ªåºæ¸è¿›	xĂºnxĂ¹jiĂ njĂ¬n	tiáº¿n hĂ nh theo tráº­t tá»±	\N	40
3540	æ¼”å˜	yÇnbiĂ n	phĂ¡t triá»ƒn, biáº¿n Ä‘á»•i	\N	34
3544	ä¸¥é‡	yĂ¡nzhĂ²ng	nghiĂªm trá»ng	\N	34
3551	æ ·å¼	yĂ ngshĂ¬	hĂ¬nh thá»©c, kiá»ƒu dĂ¡ng	\N	30
3565	å»¶æœŸ	yĂ¡nqÄ«	dá»i ngĂ y, kĂ©o dĂ i thá»i háº¡n	\N	34
3578	æ¼”ç»	yÇnyĂ¬	diá»…n dá»‹ch, suy luáº­n	\N	40
3590	å’¬ç‰™åˆ‡é½¿	yÇoyĂ¡qiĂ¨chÇ	nghiáº¿n rÄƒng nghiáº¿n lá»£i	\N	34
3604	å‹ç¼©	yÄsuÅ	nĂ©n, Ă©p	\N	34
3614	æ¶²ä½“	yĂ¨tÇ	cháº¥t lá»ng	\N	34
3619	ä¸€èˆ¬	yÄ«bÄn	bĂ¬nh thÆ°á»ng, phá»• biáº¿n	\N	34
3631	ä¸€å¸†é£é¡º	yÄ«fÄn fÄ“ngshĂ¹n	thuáº­n buá»“m xuĂ´i giĂ³	\N	30
3632	è¡£æœ	yÄ«fu	quáº§n Ă¡o	\N	27
3649	ä¸€è·¯å¹³å®‰	yÄ«lĂ¹ pĂ­ngâ€™Än	thÆ°á»£ng lá»™ bĂ¬nh an	\N	34
3667	è¥å…»	yĂ­ngyÇng	dinh dÆ°á»¡ng	\N	34
3681	å¼•èµ·	yÇnqÇ	gĂ¢y nĂªn, dáº«n tá»›i	\N	34
3701	è‰ºæœ¯	yĂ¬shĂ¹	nghá»‡ thuáº­t	\N	40
3723	å‹‡æ•¢	yÇ’nggÇn	dÅ©ng cáº£m	\N	34
3732	ç”¨å¤„	yĂ²ngchu	cĂ´ng dá»¥ng, tĂ¡c dá»¥ng	\N	40
3743	æœ‰æ¡ä¸ç´	yÇ’utiĂ¡o bĂ¹ wÄ›n	gá»n gĂ ng, tráº­t tá»±	\N	34
3756	ä¼˜å…ˆ	yÅuxiÄn	quyá»n Æ°u tiĂªn	\N	40
3771	åŸå‘	yuĂ¡ngĂ o	nguyĂªn cĂ¡o	\N	34
3774	åŸæ¥	yuĂ¡nlĂ¡i	vá»‘n dÄ©, ban Ä‘áº§u	\N	34
3787	é¢„æ¥	yĂ¹bĂ o	dá»± bĂ¡o	\N	34
3796	ä¹è°±	yuĂ¨pÇ”	báº£n nháº¡c, nháº¡c phá»•	\N	34
3805	è¿è¾“	yĂ¹nshÅ«	váº­n chuyá»ƒn	\N	34
3826	è¯­éŸ³	yÇ”yÄ«n	Ă¢m thanh, tiáº¿ng nĂ³i	\N	34
3834	å†ä¸‰	zĂ isÄn	nhiá»u láº§n, láº·p láº¡i	\N	21
3845	æ”’	zÇn	tĂ­ch lÅ©y, trá»¯, gom láº¡i	\N	34
3853	èµæ‰¬	zĂ nyĂ¡ng	khen ngá»£i, tĂ¡n dÆ°Æ¡ng	\N	34
3867	èµ é€	zĂ¨ngsĂ²ng	biáº¿u, táº·ng	\N	40
3877	ç«™	zhĂ n	Ä‘á»©ng	\N	34
3878	æ–©é’‰æˆªé“	zhÇndÄ«ngjiĂ©tiÄ›	chĂ©m Ä‘inh cháº·t sáº¯t, dá»©t khoĂ¡t	\N	34
3893	ç…§ç›¸æœº	zhĂ oxiĂ ngjÄ«	mĂ¡y chá»¥p áº£nh	\N	21
3909	æ‹›è˜	zhÄopĂ¬n	tuyá»ƒn dá»¥ng	\N	34
3920	é®æŒ¡	zhÄ“dÇng	che, ngÄƒn che	\N	34
3930	é˜µåœ°	zhĂ¨ndĂ¬	tráº­n Ä‘á»‹a, máº·t tráº­n	\N	35
3945	è¯ä»¶	zhĂ¨ngjiĂ n	giáº¥y chá»©ng nháº­n	\N	40
3956	æ•´ä½“	zhÄ›ngtÇ	toĂ n thá»ƒ, tá»•ng thá»ƒ	\N	34
3972	éœ‡å…´	zhĂ¨nxÄ«ng	cháº¥n hÆ°ng, hÆ°ng thá»‹nh	\N	34
3995	æ”¯ä»˜	zhÄ«fĂ¹	Ä‘á»“ng phá»¥c	\N	34
4004	æ²»ç†	zhĂ¬lÇ	thá»‘ng trá»‹, quáº£n lĂ½	\N	34
4013	èŒèƒ½	zhĂ­nĂ©ng	chá»©c nÄƒng, cĂ´ng nÄƒng	\N	34
4034	çŸ¥è¶³å¸¸ä¹	zhÄ«zĂº chĂ¡ng lĂ¨	tri tĂºc thĂ¬ vui	\N	34
4049	ç»ˆå¹´	zhÅngniĂ¡n	suá»‘t cáº£ nÄƒm	\N	34
4058	ä¸­æ—¬	zhÅngxĂºn	trung tuáº§n, giá»¯a thĂ¡ng	\N	40
4074	æ‹™å£	zhuÅliĂ¨	trá»¥c tráº·c, tráº¯c trá»Ÿ	\N	34
4086	è½¬å˜	zhuÇnbiĂ n	chuyá»ƒn biáº¿n, thay Ä‘á»•i	\N	34
4101	ä¸“é—¨	zhuÄnmĂ©n	chuyĂªn mĂ´n, chuyĂªn	\N	34
4120	ä¸»æµ	zhÇ”liĂº	chá»§ yáº¿u, xu hÆ°á»›ng	\N	34
4136	èµ„æ·±	zÄ«shÄ“n	tá»«ng tráº£i, thĂ¢m niĂªn	\N	34
4146	èµ„é‡‘	zÄ«jÄ«n	tiá»n vá»‘n, quá»¹	\N	34
4167	æ€»è€Œè¨€ä¹‹	zÇ’ngâ€™Ă©ryĂ¡nzhÄ«	nĂ³i tĂ³m láº¡i	\N	35
4179	æ€»ä¹‹	zÇ’ngzhÄ«	nĂ³i chung, tĂ³m láº¡i	\N	34
4186	ç»„	zÇ”	nhĂ³m, tá»•	\N	34
4193	ç¥–å›½	zÇ”guĂ³	tá»• quá»‘c	\N	34
4205	é˜»æŒ 	zÇ”nĂ¡o	cáº£n trá»Ÿ, ngÄƒn cáº£n, phĂ¡ rá»‘i	\N	34
4215	ä½œæ¯	zuĂ²xÄ«	lĂ m viá»‡c vĂ  nghá»‰ ngÆ¡i	\N	40
4226	åº§å³é“­	zuĂ²yĂ²umĂ­ng	lá»i rÄƒn, lá»i cĂ¡ch ngĂ´n	\N	34
3692	ä¸€èµ·	yÄ«qÇ	cĂ¹ng nhau	\N	24
3711	æ„å‘	yĂ¬xiĂ ng	Ă½ Ä‘á»‹nh, má»¥c Ä‘Ă­ch	\N	27
3767	é‡åˆ°	yĂ¹ dĂ o	gáº·p pháº£i, gáº·p Ä‘Æ°á»£c	\N	33
3812	é…é…¿	yĂ¹nniĂ ng	á»§ rÆ°á»£u, chuáº©n bá»‹ (ká»¹ lÆ°á»¡ng)	\N	40
3978	æŒ‡	zhÇ	chá»‰ ra, ngĂ³n tay	\N	40
4156	å§¿æ€	zÄ«tĂ i	tÆ° tháº¿, dĂ¡ng dáº¥p	\N	37
4026	åªè¦	zhÇyĂ o	chá»‰ cáº§n	\N	31
4114	ä¸»è§‚	zhÇ”guÄn	chá»§ quan	\N	27
3985	çŸ¥è¯†	zhÄ«shi	tri thá»©c, kiáº¿n thá»©c	\N	40
3674	è‹±å‹‡	yÄ«ngyÇ’ng	anh dÅ©ng	\N	34
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
21	Sá»‘ Ä‘áº¿m & sá»‘ lÆ°á»£ng	\N
22	Con ngÆ°á»i & quan há»‡ xĂ£ há»™i	\N
23	Nghá» nghiá»‡p & cĂ´ng viá»‡c	\N
24	Sá»©c khá»e & cÆ¡ thá»ƒ	\N
25	Äá»™ng váº­t & thá»±c váº­t	\N
26	MĂ³n Äƒn & Ä‘á»“ uá»‘ng	\N
27	Äá»“ dĂ¹ng & quáº§n Ă¡o	\N
28	PhÆ°Æ¡ng tiá»‡n & giao thĂ´ng	\N
29	Äá»‹a Ä‘iá»ƒm & mĂ´i trÆ°á»ng	\N
30	Thá»i gian & thá»i tiáº¿t	\N
31	Giáº£i trĂ­ & sá»Ÿ thĂ­ch	\N
32	TrÆ°á»ng há»c & há»c táº­p	\N
33	NgĂ´n ngá»¯ & giao tiáº¿p	\N
34	TĂ­nh tá»« & Ä‘áº·c Ä‘iá»ƒm	\N
35	Tá»« loáº¡i Ä‘áº·c biá»‡t & trá»£ tá»«	\N
36	VÄƒn hĂ³a â€“ thĂ³i quen â€“ lá»… nghi	\N
37	Mua sáº¯m & giao dá»‹ch	\N
38	CĂ´ng viá»‡c, kinh doanh	\N
39	Hoáº¡t Ä‘á»™ng thÆ°á»ng ngĂ y	\N
40	Äá»™ng tá»«	\N
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


