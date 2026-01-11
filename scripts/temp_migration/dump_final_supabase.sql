--
-- PostgreSQL database dump
--


-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET client_encoding = 'UTF8';

--
-- Name: AccountStatus; Type: TYPE; Schema: public; Owner: -
--
--
-- Name: AccountType; Type: TYPE; Schema: public; Owner: -
--






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

INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('6645ae2f-5d81-4547-98fc-d78847a9695d', '125129ea4fd79415539262108be923c94f57e40961180da1a0b90a620062adba', '2026-01-03 18:59:15.918477+07', '20251010091705_init_or_update', NULL, NULL, '2026-01-03 18:59:15.910924+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('63531f7d-a6cd-4bf6-a9ce-6b0f8bfadb1d', 'de8a3a311f3d78142b22e32dec8ee53e2db021da3374b4af428d19cb18f01b5c', '2026-01-05 19:59:55.368314+07', '20250104000000_remove_weekly_contest_progress', NULL, NULL, '2026-01-05 19:59:55.295932+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('f6be6bc0-d03f-411e-82f1-082d8000909d', 'a32a477f573b1f49da0a98a51cea4de38e5befbaed152d18cab23ac995344254', '2026-01-03 18:59:16.042957+07', '20251202100000_add_user_xp_streak', NULL, NULL, '2026-01-03 18:59:16.039537+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('1954515d-4dd5-43a8-ae16-e06148a0c2a4', 'ffa1c154709073ab419c643b91b360ac1f77ec0c47001c39d8b8751395345eea', '2026-01-03 18:59:15.909713+07', '20251002093443_init_schema', NULL, NULL, '2026-01-03 18:59:15.765755+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('b1efeae0-d67d-4309-995d-7f861a7113ba', '852874f96bac40c026d8cd509be73793d7dc2eec323c8b1611856bd0c0485e21', '2026-01-03 18:59:16.004067+07', '20251117131500_add_user_image_and_files', NULL, NULL, '2026-01-03 18:59:15.988241+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('c0f5f11f-0396-4a3f-9716-8e2b89146d81', '122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec', '2026-01-03 18:59:15.923215+07', '20251010092952_init_or_update', NULL, NULL, '2026-01-03 18:59:15.919949+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('c6b59e9d-3edc-4860-bdf2-7ad0b2d8acec', '1b4534dfa4e0f1266ec559edfc2348c775566d0ec585b19b8104ee87da80161e', '2026-01-03 18:59:15.95971+07', '20251010164523_add_stages_vocabulary_categories_sentences', NULL, NULL, '2026-01-03 18:59:15.924352+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('cbc8fb1f-027f-4f74-8f8a-9612880a49ec', '67cb1f0cd85963243c55e0d7e82b3ad9238bcbdb67a63e28c4ce772e93ca7419', '2026-01-03 18:59:15.964794+07', '20251117091500_add_user_account_fields', NULL, NULL, '2026-01-03 18:59:15.960797+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('5157a77f-94be-469a-91ec-0d713b5aa32d', '695e34068e234d6197b4bfec1447d16b24acd138c33709647c305061add1b542', '2026-01-03 18:59:16.008249+07', '20251117133500_add_region_and_address', NULL, NULL, '2026-01-03 18:59:16.005175+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('c0bfef16-7426-4952-bcf5-ded53a835ac5', '7246e9c52d0c02ff7d527895e2d5697709b70d1dea5b31d919fb0c09974cf5ae', '2026-01-03 18:59:15.977661+07', '20251117095000_update_account_type_enum', NULL, NULL, '2026-01-03 18:59:15.965532+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('a7b2b008-79e7-4401-a0d4-19b7bcae4e34', 'edd0e588fc3ecb76871956c37433b9ff427452acfec9a07c26f4339ba31b69d0', '2026-01-03 18:59:15.982606+07', '20251117103000_add_must_set_password', NULL, NULL, '2026-01-03 18:59:15.978689+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('13fecfd3-7196-49b1-b289-f7a0dadf04be', 'd6aa5857df7cca68a3ef2a124258f64d10fd9b6f6b48f04902f6283c96a5dd7f', '2026-01-03 18:59:16.071379+07', '20251217091000_weekly_contest_daily_lock', NULL, NULL, '2026-01-03 18:59:16.063884+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('70c24a95-f2e7-45ae-9e6d-29c856faf901', 'e18712f748336fa40ee8a99dd49b3994c19f50851a4bde739f762254227eefda', '2026-01-03 18:59:15.987249+07', '20251117120500_add_reset_code', NULL, NULL, '2026-01-03 18:59:15.983719+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('d2594462-19a3-4e3b-af72-331eb0bf1795', 'e83bdff67e324d0ef1f3b95c88cf6cbe161e259cb733593ddca870008df0a432', '2026-01-03 18:59:16.03134+07', '20251129222713_add_vocabulary_box_tables', NULL, NULL, '2026-01-03 18:59:16.009208+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('4d891d5a-ba1f-42ff-a4ae-4b95f1e4d407', '2cefa6b62d102ef83e985a37946bc813a5dc55defb7d6fe4ed3687d2a1e4af68', '2026-01-03 18:59:16.052038+07', '20251213194326_add_flashcards_table', NULL, NULL, '2026-01-03 18:59:16.044028+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('d89e2eab-fe76-41a7-8ba4-1e418764f0af', '70a34ffb0642bfd0b5cef4ad3f1d896ee913b4afd30f0f34644f4dd5767d54e3', '2026-01-03 18:59:16.03864+07', '20251129222909_update_vocabulary_box_one_per_user', NULL, NULL, '2026-01-03 18:59:16.032186+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('5b8d1ba4-855b-406a-90b3-355a5fec4553', '78bfda6ca7f9abb549bd49c753201764b3614e4d580cbe268161f8126004d96d', '2026-01-03 18:59:16.102358+07', '20251223120000_add_user_daily_scores', NULL, NULL, '2026-01-03 18:59:16.089703+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('e4ff55fc-ff5a-42ae-b6f0-3f2cea5a27f5', '04d142ee37a0b4535f7fdc4096fe660ec52c529cced8079d78bf6a3ea4a84041', '2026-01-03 18:59:16.062907+07', '20251217090000_add_weekly_contest_progress', NULL, NULL, '2026-01-03 18:59:16.052944+07', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('f92ee254-293a-4069-8ab4-a3f5a21ad7ea', 'c8f7b4a53df491384ee1cbc548d5e3f5e7395eccf03acc3e9f1b4a1f6d52a0a0', '2026-01-03 19:06:14.356578+07', '20250103130000_change_daily_tasks_date_to_date', '', NULL, '2026-01-03 19:06:14.356578+07', 0);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('8308498e-f303-4f56-ac59-c6d1d0067179', 'c22167644d6151657062ba0f496b343882e46512f27d6c962394db9edcc0cf44', '2026-01-03 18:59:16.088477+07', '20251217094000_add_user_monthly_scores', NULL, NULL, '2026-01-03 18:59:16.072479+07', 1);


--
-- Data for Name: daily_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.daily_tasks (id, user_id, vocabulary_count, sentence_count, contest_completed, points_awarded, points_given, date, created_at, updated_at) VALUES (34, 4, 10, 5, true, 10, true, '2026-01-06', '2026-01-06 12:33:41.956', '2026-01-06 12:36:30.617');
INSERT INTO public.daily_tasks (id, user_id, vocabulary_count, sentence_count, contest_completed, points_awarded, points_given, date, created_at, updated_at) VALUES (1, 2, 10, 5, true, 10, true, '2026-01-04', '2026-01-05 11:57:25.474', '2026-01-05 12:16:23.682');
INSERT INTO public.daily_tasks (id, user_id, vocabulary_count, sentence_count, contest_completed, points_awarded, points_given, date, created_at, updated_at) VALUES (76, 4, 10, 5, true, 10, true, '2026-01-07', '2026-01-07 12:45:25.001', '2026-01-07 12:46:13.437');


--
-- Data for Name: flashcards; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (1, '/uploads/flashcards/2_1.png', '八', 'active', '2026-01-05 11:52:56.037', '2026-01-05 11:52:56.037');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (2, '/uploads/flashcards/3_1.png', '爸爸', 'active', '2026-01-05 11:53:25.542', '2026-01-05 11:53:25.542');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (3, '/uploads/flashcards/4_1.png', '鼻子', 'active', '2026-01-05 11:53:37.915', '2026-01-05 11:53:37.915');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (4, '/uploads/flashcards/5_1.png', '不', 'active', '2026-01-05 11:53:53.14', '2026-01-05 11:53:53.14');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (5, '/uploads/flashcards/6_1.png', '长', 'active', '2026-01-05 11:54:12.091', '2026-01-05 11:54:12.091');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (6, '/uploads/flashcards/7_1.png', '吃', 'active', '2026-01-05 11:54:26.02', '2026-01-05 11:54:26.02');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (7, '/uploads/flashcards/8_1.png', '大', 'active', '2026-01-05 11:54:39.634', '2026-01-05 11:54:39.634');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (8, '/uploads/flashcards/9_1.png', '多', 'active', '2026-01-05 11:54:52.378', '2026-01-05 11:54:52.378');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (9, '/uploads/flashcards/10_1.png', '点', 'active', '2026-01-05 11:55:40.018', '2026-01-05 11:55:59.943');
INSERT INTO public.flashcards (id, image_url, answer, status, created_at, updated_at) VALUES (10, '/uploads/flashcards/11_1.png', '耳朵', 'active', '2026-01-05 11:56:13.107', '2026-01-05 11:56:13.107');


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.news (id, title, content, start_date, end_date, created_at, updated_at) VALUES (1, 'ƯU ĐÃI TRẢI NGHIỆM VIP', 'Mỗi tháng chúng tôi sẽ xét lấy ra 10 người cao nhất theo toàn quốc, theo miền, theo tỉnh để tặng trải nghiệm VIP 1 tháng.
- Lưu ý: Khuyến mại không cộng dồn tháng', '2026-01-06', '2030-11-06', '2026-01-06 13:42:07.633', '2026-01-06 13:42:07.633');


--
-- Data for Name: sentence_categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (1, 'Chào hỏi', 'Greetings');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (2, 'Giới thiệu bản thân', 'Self Introduction');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (3, 'Gia đình', 'Family');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (4, 'Màu sắc', 'Colors');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (5, 'Số đếm', 'Numbers');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (6, 'Thời gian', 'Time');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (7, 'Thời tiết', 'Weather');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (8, 'Thực phẩm', 'Food');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (9, 'Mua sắm', 'Shopping');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (10, 'Giao thông', 'Transportation');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (11, 'Sức khỏe', 'Health');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (12, 'Học tập', 'Education');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (13, 'Công việc', 'Work');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (14, 'Du lịch', 'Travel');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (15, 'Thể thao', 'Sports');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (16, 'Sở thích', 'Hobbies');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (17, 'Cảm xúc', 'Emotions');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (18, 'Địa điểm', 'Places');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (19, 'Mua bán', 'Buying and Selling');
INSERT INTO public.sentence_categories (id, name_vi, name_en) VALUES (20, 'Điện thoại và Internet', 'Phone and Internet');


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (1, '你好', 'Nǐ hǎo', 'Xin chào', 1);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (2, '早上好', 'Zǎoshang hǎo', 'Chào buổi sáng', 1);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (3, '晚上好', 'Wǎnshang hǎo', 'Chào buổi tối', 1);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (4, '再见', 'Zàijiàn', 'Tạm biệt', 1);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (5, '谢谢', 'Xièxie', 'Cảm ơn', 1);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (6, '我叫小明', 'Wǒ jiào Xiǎomíng', 'Tôi tên là Tiểu Minh', 2);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (7, '我来自越南', 'Wǒ láizì Yuènán', 'Tôi đến từ Việt Nam', 2);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (8, '我今年二十五岁', 'Wǒ jīnnián èrshíwǔ suì', 'Năm nay tôi hai mươi lăm tuổi', 2);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (9, '我是学生', 'Wǒ shì xuésheng', 'Tôi là sinh viên', 2);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (10, '很高兴认识你', 'Hěn gāoxìng rènshi nǐ', 'Rất vui được làm quen với bạn', 2);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (11, '这是我的家人', 'Zhè shì wǒ de jiārén', 'Đây là gia đình tôi', 3);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (12, '我有两个兄弟', 'Wǒ yǒu liǎng gè xiōngdì', 'Tôi có hai người anh em', 3);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (13, '我父母很健康', 'Wǒ fùmǔ hěn jiànkāng', 'Bố mẹ tôi rất khỏe mạnh', 3);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (14, '我姐姐是老师', 'Wǒ jiějie shì lǎoshī', 'Chị gái tôi là giáo viên', 3);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (15, '我们一家人很幸福', 'Wǒmen yījiārén hěn xìngfú', 'Gia đình chúng tôi rất hạnh phúc', 3);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (16, '我喜欢红色', 'Wǒ xǐhuan hóngsè', 'Tôi thích màu đỏ', 4);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (17, '天空是蓝色的', 'Tiānkōng shì lánsè de', 'Bầu trời màu xanh', 4);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (18, '这朵花是黄色的', 'Zhè duǒ huā shì huángsè de', 'Bông hoa này màu vàng', 4);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (19, '黑色是我的最爱', 'Hēisè shì wǒ de zuì ài', 'Màu đen là màu yêu thích của tôi', 4);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (20, '白色代表纯洁', 'Báisè dàibiǎo chúnjié', 'Màu trắng tượng trưng cho sự trong trắng', 4);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (21, '一加一等于二', 'Yī jiā yī děngyú èr', 'Một cộng một bằng hai', 5);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (22, '我有三个苹果', 'Wǒ yǒu sān gè píngguǒ', 'Tôi có ba quả táo', 5);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (23, '今天是五月十五号', 'Jīntiān shì wǔyuè shíwǔ hào', 'Hôm nay là ngày mười lăm tháng năm', 5);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (24, '这本书有五百页', 'Zhè běn shū yǒu wǔbǎi yè', 'Cuốn sách này có năm trăm trang', 5);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (25, '我买了十支笔', 'Wǒ mǎile shí zhī bǐ', 'Tôi đã mua mười cây bút', 5);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (26, '现在几点了？', 'Xiànzài jǐ diǎn le?', 'Bây giờ mấy giờ rồi?', 6);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (27, '我每天早上七点起床', 'Wǒ měitiān zǎoshang qī diǎn qǐchuáng', 'Mỗi sáng tôi thức dậy lúc bảy giờ', 6);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (28, '今天是星期一', 'Jīntiān shì xīngqīyī', 'Hôm nay là thứ Hai', 6);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (29, '我们下个月去旅行', 'Wǒmen xià gè yuè qù lǚxíng', 'Tháng sau chúng tôi sẽ đi du lịch', 6);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (30, '会议在下午三点开始', 'Huìyì zài xiàwǔ sān diǎn kāishǐ', 'Cuộc họp bắt đầu lúc ba giờ chiều', 6);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (31, '今天天气很好', 'Jīntiān tiānqì hěn hǎo', 'Hôm nay thời tiết rất đẹp', 7);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (32, '外面在下雨', 'Wàimiàn zài xià yǔ', 'Bên ngoài đang mưa', 7);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (33, '今天很热', 'Jīntiān hěn rè', 'Hôm nay rất nóng', 7);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (34, '冬天很冷', 'Dōngtiān hěn lěng', 'Mùa đông rất lạnh', 7);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (35, '明天会晴天', 'Míngtiān huì qíngtiān', 'Ngày mai sẽ nắng', 7);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (36, '我想吃面条', 'Wǒ xiǎng chī miàntiáo', 'Tôi muốn ăn mì', 8);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (37, '这个菜很好吃', 'Zhè gè cài hěn hǎochī', 'Món ăn này rất ngon', 8);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (38, '我喜欢吃水果', 'Wǒ xǐhuan chī shuǐguǒ', 'Tôi thích ăn trái cây', 8);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (39, '请给我一杯水', 'Qǐng gěi wǒ yī bēi shuǐ', 'Xin cho tôi một cốc nước', 8);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (40, '我不喜欢吃辣的', 'Wǒ bù xǐhuan chī là de', 'Tôi không thích ăn cay', 8);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (41, '这件衣服多少钱？', 'Zhè jiàn yīfu duōshao qián?', 'Bộ quần áo này bao nhiêu tiền?', 9);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (42, '我可以试穿吗？', 'Wǒ kěyǐ shìchuān ma?', 'Tôi có thể thử được không?', 9);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (43, '太贵了，能便宜点吗？', 'Tài guì le, néng piányi diǎn ma?', 'Đắt quá, có thể rẻ hơn một chút không?', 9);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (44, '我要买这个', 'Wǒ yào mǎi zhè gè', 'Tôi muốn mua cái này', 9);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (45, '可以用信用卡吗？', 'Kěyǐ yòng xìnyòngkǎ ma?', 'Có thể dùng thẻ tín dụng không?', 9);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (46, '我要去机场', 'Wǒ yào qù jīchǎng', 'Tôi muốn đi đến sân bay', 10);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (47, '怎么去火车站？', 'Zěnme qù huǒchēzhàn?', 'Làm sao để đến ga tàu?', 10);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (48, '我坐公交车上班', 'Wǒ zuò gōngjiāochē shàngbān', 'Tôi đi xe buýt đi làm', 10);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (49, '请开慢一点', 'Qǐng kāi màn yīdiǎn', 'Xin lái chậm một chút', 10);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (50, '这里可以停车吗？', 'Zhèlǐ kěyǐ tíngchē ma?', 'Ở đây có thể đỗ xe không?', 10);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (51, '我头疼', 'Wǒ tóuténg', 'Tôi bị đau đầu', 11);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (52, '你需要去看医生', 'Nǐ xūyào qù kàn yīshēng', 'Bạn cần đi khám bác sĩ', 11);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (53, '我感冒了', 'Wǒ gǎnmào le', 'Tôi bị cảm', 11);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (54, '多喝水，多休息', 'Duō hē shuǐ, duō xiūxi', 'Uống nhiều nước, nghỉ ngơi nhiều', 11);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (55, '我感觉好多了', 'Wǒ gǎnjué hǎo duō le', 'Tôi cảm thấy khỏe hơn nhiều rồi', 11);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (56, '我在学中文', 'Wǒ zài xué Zhōngwén', 'Tôi đang học tiếng Trung', 12);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (57, '这个字怎么写？', 'Zhè gè zì zěnme xiě?', 'Chữ này viết như thế nào?', 12);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (58, '请再说一遍', 'Qǐng zài shuō yībiàn', 'Xin nói lại một lần nữa', 12);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (59, '我明天有考试', 'Wǒ míngtiān yǒu kǎoshì', 'Ngày mai tôi có bài thi', 12);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (60, '你作业做完了吗？', 'Nǐ zuòyè zuòwán le ma?', 'Bạn đã làm xong bài tập chưa?', 12);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (61, '我是工程师', 'Wǒ shì gōngchéngshī', 'Tôi là kỹ sư', 13);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (62, '我九点上班', 'Wǒ jiǔ diǎn shàngbān', 'Tôi đi làm lúc chín giờ', 13);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (63, '今天工作很忙', 'Jīntiān gōngzuò hěn máng', 'Hôm nay công việc rất bận', 13);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (64, '我下班了', 'Wǒ xiàbān le', 'Tôi đã tan làm', 13);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (65, '这个项目很重要', 'Zhè gè xiàngmù hěn zhòngyào', 'Dự án này rất quan trọng', 13);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (66, '我想去北京旅游', 'Wǒ xiǎng qù Běijīng lǚyóu', 'Tôi muốn đi du lịch Bắc Kinh', 14);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (67, '这里风景很美', 'Zhèlǐ fēngjǐng hěn měi', 'Cảnh đẹp ở đây rất đẹp', 14);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (68, '我要订一个房间', 'Wǒ yào dìng yī gè fángjiān', 'Tôi muốn đặt một phòng', 14);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (69, '请给我一张地图', 'Qǐng gěi wǒ yī zhāng dìtú', 'Xin cho tôi một tấm bản đồ', 14);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (70, '这个城市很有名', 'Zhè gè chéngshì hěn yǒumíng', 'Thành phố này rất nổi tiếng', 14);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (71, '我喜欢打篮球', 'Wǒ xǐhuan dǎ lánqiú', 'Tôi thích chơi bóng rổ', 15);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (72, '我每天跑步', 'Wǒ měitiān pǎobù', 'Tôi chạy bộ mỗi ngày', 15);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (73, '足球比赛很精彩', 'Zúqiú bǐsài hěn jīngcǎi', 'Trận đấu bóng đá rất hay', 15);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (74, '我要去健身房', 'Wǒ yào qù jiànshēnfáng', 'Tôi muốn đi phòng gym', 15);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (75, '运动对身体好', 'Yùndòng duì shēntǐ hǎo', 'Tập thể dục tốt cho sức khỏe', 15);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (76, '我喜欢听音乐', 'Wǒ xǐhuan tīng yīnyuè', 'Tôi thích nghe nhạc', 16);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (77, '我爱好读书', 'Wǒ àihào dúshū', 'Tôi thích đọc sách', 16);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (78, '周末我喜欢看电影', 'Zhōumò wǒ xǐhuan kàn diànyǐng', 'Cuối tuần tôi thích xem phim', 16);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (79, '我会弹钢琴', 'Wǒ huì tán gāngqín', 'Tôi biết chơi đàn piano', 16);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (80, '画画是我的爱好', 'Huàhuà shì wǒ de àihào', 'Vẽ tranh là sở thích của tôi', 16);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (81, '我很高兴', 'Wǒ hěn gāoxìng', 'Tôi rất vui', 17);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (82, '我有点累', 'Wǒ yǒudiǎn lèi', 'Tôi hơi mệt', 17);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (83, '我很担心', 'Wǒ hěn dānxīn', 'Tôi rất lo lắng', 17);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (84, '这让我很生气', 'Zhè ràng wǒ hěn shēngqì', 'Điều này làm tôi rất tức giận', 17);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (85, '我感到很放松', 'Wǒ gǎndào hěn fàngsōng', 'Tôi cảm thấy rất thư giãn', 17);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (86, '银行在哪里？', 'Yínháng zài nǎlǐ?', 'Ngân hàng ở đâu?', 18);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (87, '我要去图书馆', 'Wǒ yào qù túshūguǎn', 'Tôi muốn đi thư viện', 18);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (88, '医院在那边', 'Yīyuàn zài nàbiān', 'Bệnh viện ở đằng kia', 18);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (89, '学校离这里很远', 'Xuéxiào lí zhèlǐ hěn yuǎn', 'Trường học cách đây rất xa', 18);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (90, '超市在左边', 'Chāoshì zài zuǒbiān', 'Siêu thị ở bên trái', 18);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (91, '我想卖这辆车', 'Wǒ xiǎng mài zhè liàng chē', 'Tôi muốn bán chiếc xe này', 19);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (92, '这个价格合理吗？', 'Zhè gè jiàgé hélǐ ma?', 'Giá này có hợp lý không?', 19);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (93, '我要买新手机', 'Wǒ yào mǎi xīn shǒujī', 'Tôi muốn mua điện thoại mới', 19);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (94, '可以打折吗？', 'Kěyǐ dǎzhé ma?', 'Có thể giảm giá không?', 19);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (95, '我付现金', 'Wǒ fù xiànjīn', 'Tôi trả bằng tiền mặt', 19);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (96, '你的电话号码是多少？', 'Nǐ de diànhuà hàomǎ shì duōshao?', 'Số điện thoại của bạn là bao nhiêu?', 20);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (97, '请给我发微信', 'Qǐng gěi wǒ fā Wēixìn', 'Xin gửi cho tôi tin nhắn WeChat', 20);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (98, '网络连接不好', 'Wǎngluò liánjiē bù hǎo', 'Kết nối mạng không tốt', 20);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (99, '我要下载这个应用', 'Wǒ yào xiàzài zhè gè yìngyòng', 'Tôi muốn tải ứng dụng này', 20);
INSERT INTO public.sentences (id, chinese_simplified, pinyin, vietnamese, category_id) VALUES (100, '请加我微信', 'Qǐng jiā wǒ Wēixìn', 'Xin thêm tôi vào WeChat', 20);


--
-- Data for Name: user_daily_scores; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_daily_scores (id, user_id, score, score_date, created_at, updated_at) VALUES (1, 2, 11, '2026-01-04', '2026-01-05 11:45:14.87', '2026-01-05 11:57:24.391');
INSERT INTO public.user_daily_scores (id, user_id, score, score_date, created_at, updated_at) VALUES (20, 4, 13, '2026-01-06', '2026-01-06 12:34:35.036', '2026-01-06 12:36:26.434');
INSERT INTO public.user_daily_scores (id, user_id, score, score_date, created_at, updated_at) VALUES (33, 4, 4, '2026-01-07', '2026-01-07 12:44:39.652', '2026-01-07 12:45:23.958');


--
-- Data for Name: user_monthly_scores; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_monthly_scores (id, user_id, score, month_cycle, created_at, updated_at) VALUES (1, 2, 21, '2026-01', '2026-01-05 11:45:14.887', '2026-01-05 12:16:23.685');
INSERT INTO public.user_monthly_scores (id, user_id, score, month_cycle, created_at, updated_at) VALUES (13, 4, 54, '2026-01', '2026-01-06 12:21:27.311', '2026-01-07 12:46:13.495');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (user_id, username, email, password_hash, created_at, role, email_confirmed, verification_code, verification_code_expires_at, account_status, account_type, must_set_password, reset_code, reset_code_expires_at, image_url, address, province, region, xp, streak_days) VALUES (2, 'Nguyen Toan', 'toannguyentien10091998@gmail.com', '$2b$10$5Yc0roYITIdLfyI7zn2MH.EzCwEek/cSLh1R5DpyWE28WfeSvEKK6', '2026-01-05 11:38:49.944', 'admin', true, NULL, NULL, 'normal', 'google', false, NULL, NULL, NULL, '', 'Bắc Ninh', 'bac', 0, 0);
INSERT INTO public.users (user_id, username, email, password_hash, created_at, role, email_confirmed, verification_code, verification_code_expires_at, account_status, account_type, must_set_password, reset_code, reset_code_expires_at, image_url, address, province, region, xp, streak_days) VALUES (3, 'Dev Capybara', 'capybaradev2004@gmail.com', '$2b$10$/fJXe1MCfrmdYqM10Sl3.eUFN0RRulN0wKAvshBPUmaasWDKXnYbG', '2026-01-05 12:47:31.37', 'customer', true, NULL, NULL, 'vip', 'google', false, NULL, NULL, NULL, NULL, NULL, 'bac', 0, 0);
INSERT INTO public.users (user_id, username, email, password_hash, created_at, role, email_confirmed, verification_code, verification_code_expires_at, account_status, account_type, must_set_password, reset_code, reset_code_expires_at, image_url, address, province, region, xp, streak_days) VALUES (4, 'Toán Nguyễn', 'toannguyentien28022004@gmail.com', '$2b$10$M3diGKavYdpH6TljdwjbReZwuU0VTeDp.6EHeXBWcFgSywV1.zRQm', '2026-01-06 12:09:17.768', 'admin', true, NULL, NULL, 'normal', 'google', false, NULL, NULL, NULL, '', 'Hà Nội', 'bac', 0, 0);


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1275, '固然', 'gùrán', 'tất nhiên, cố nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (766, '坚定', 'jiāndìng', 'kiên định, vững vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1510, '建筑', 'jiànzhù', 'tòa nhà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1533, '教训', 'jiàoxùn', 'giáo huấn, dạy bảo', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2443, '启示', 'qǐshì', 'gợi ý, gợi cho biết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2760, '示范', 'shìfàn', 'gương sáng, gương tốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1, '…分之…', '…fēn zhī…', 'chi nhánh, phần (trăm)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (463, '成熟', 'chéngshú', 'thành thục, trưởng thành, chín chắn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (620, '磋商', 'cuōshāng', 'bàn bạc, hội ý, trao đổi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1793, '举世瞩目', 'jǔshì zhǔmù', 'thu hút sự chú ý trên toàn thế giới', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2803, '实事求是', 'shíshìqiúshì', 'thật thà cầu thị', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2825, '收益', 'shōuyì', 'lợi nhuận, thu lợi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2947, '台', 'tái', 'đài, bệ, sân khấu, chiếc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3042, '停留', 'tíngliú', 'dừng lại, ở lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3403, '形状', 'xíngzhuàng', 'hình dáng, hình dạng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3557, '烟花爆竹', 'yānhuā bàozhú', 'pháo hoa, pháo nổ', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3829, '预兆', 'yùzhào', 'điềm báo, dấu hiệu', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2, '啊', 'a', 'a, à, ừ, ờ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4196, '醉', 'zuì', 'say rượu, bia', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1132, '工夫', 'gōngfū', 'thời gian, người làm thuê, công sức, rảnh rỗi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1330, '合成', 'héchéng', 'hợp thành, câu thành', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3, '呵', 'ā', 'ơ, ới, ui, ui cha', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4, '爱', 'ài', 'yêu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (5, '矮', 'ǎi', 'thấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (6, '唉', 'āi', 'ôi, than ôi, trời ơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (7, '挨', 'ái', 'bị, chịu đựng, gặp phải', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (69, '绑架', 'bǎngjià', 'bắt cóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (8, '爱不释手', 'àibùshìshǒu', 'quyến luyến không rời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (796, '顶', 'dǐng', 'đỉnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (9, '爱戴', 'àidài', 'yêu quý, kính yêu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (10, '爱好', 'àihào', 'yêu thích, thích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (585, '出租车', 'chūzūchē', 'Taxi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (11, '爱护', 'àihù', 'yêu quý, bảo vệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1098, '哥', 'gē', 'anh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (12, '暧昧', 'àimèi', 'mập mờ, mờ ám', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (13, '爱情', 'àiqíng', 'tình yêu', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1005, '分', 'fēn', 'phần, suất', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (14, '爱惜', 'àixī', 'yêu quý, quý trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1478, '寄', 'jì', 'gửi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (15, '爱心', 'àixīn', 'lòng nhân ái, yêu thương', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (16, '哎哟', 'āiyō', 'ôi, ôi chao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (17, '癌症', 'áizhèng', 'ung thư', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (18, '岸', 'àn', 'bờ (sông, biển)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1212, '管子', 'guǎnzi', 'ống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (19, '暗', 'àn', 'tối, u ám, thầm, vụng trộm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (20, '按', 'àn', 'ấn, bấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2002, '另', 'lìng', 'khác', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (21, '案件', 'ànjiàn', 'án vụ, trường hợp, án kiện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (22, '安居乐业', 'ānjūlèyè', 'an cư lạc nghiệp', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (23, '案例', 'ànlì', 'án lệ', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (24, '按摩', 'ànmó', 'xoa bóp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (25, '按时', 'ànshí', 'đúng giờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (26, '按照', 'ànzhào', 'căn cứ theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1214, '孤单', 'gūdān', 'cô đơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (27, '安排', 'ānpái', 'sắp xếp, bố trí', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (28, '安全', 'ānquán', 'an toàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (29, '暗示', 'ànshì', 'ám thị, ra hiệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (30, '案', 'àn', 'vụ, án, hồ sơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (31, '安慰', 'ānwèi', 'an ủi', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (32, '安详', 'ānxiáng', 'êm đềm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1321, '毫米', 'háomǐ', 'milimet', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1322, '好奇', 'hàoqí', 'hiếu kỳ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1428, '汇报', 'huìbào', 'báo cáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (33, '按着', 'ànzhe', 'căn cứ, dựa theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4064, '粥', 'zhōu', 'cháo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (35, '安装', 'ānzhuāng', 'lắp đặt', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (52, '百', 'bǎi', 'trăm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (57, '拜年', 'bàinián', 'đi chúc tết', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (65, '颁发', 'bānfā', 'ban phát', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (66, '棒', 'bàng', 'gậy', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (34, '安置', 'ànzhì', 'bố trí ổn thỏa, ổn định', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (36, '熬', 'áo', 'sắc, hầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (37, '奥秘', 'àomì', 'huyền bí, bí ẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (38, '凹凸', 'āotū', 'lồi lõm, gồ ghề', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (39, '阿姨', 'Āyí', 'cô, dì', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (40, '吧', 'ba', 'nhé, nha', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (41, '把', 'bǎ', 'lấy, đem', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (42, '拔', 'bá', 'nhổ, rút ra', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (43, '疤', 'bā', 'vết sẹo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (44, '爸爸', 'bàba', 'bố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (45, '巴不得', 'bābùdé', 'ước gì, chỉ mong', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (46, '霸道', 'bàdào', 'bá đạo, độc tài, chuyên chế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (47, '罢工', 'bàgōng', 'đình công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (49, '白', 'bái', 'trắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (50, '摆', 'bǎi', 'xếp đặt, bày biện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (51, '柏', 'bǎi', 'trầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (53, '拜', 'bài', 'bái, lạy, thờ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (54, '拜访', 'bàifǎng', 'đến thăm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (55, '百分点', 'bǎifēndiǎn', 'điểm phần trăm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (56, '败坏', 'bàihuài', 'hư hỏng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (58, '拜托', 'bàituō', 'xin nhờ, kính nhờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (59, '摆脱', 'bǎituō', 'thoát khỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (60, '白日梦', 'báirìmèng', 'mộng ban ngày', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (61, '班', 'bān', 'lớp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (62, '版本', 'bǎnběn', 'phiên bản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (63, '颁布', 'bānbù', 'ban hành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (64, '办法', 'bànfǎ', 'biện pháp, cách', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (67, '帮', 'bāng', 'băng, nhóm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (68, '帮忙', 'bāngmáng', 'giúp, giúp đỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (121, '保管', 'bǎoguǎn', 'bảo quản', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (80, '膀胱', 'bǎngguāng', 'bàng quang', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (97, '报社', 'bàoshè', 'tòa soạn, tòa báo', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (84, '包庇', 'bāobì', 'bao che, che đậy', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (87, '宝贵', 'bǎoguì', 'quý giá', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (88, '包含', 'bāohán', 'chứa, bao gồm', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (91, '保险', 'bǎoxiǎn', 'bảo hiểm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (119, '保姆', 'bǎomǔ', 'bảo mẫu, người giúp việc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (151, '奔波', 'bēnbō', 'bôn ba', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (117, '报答', 'bàodá', 'đền đáp', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (71, '傍晚', 'bàngwǎn', 'xẩm tối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (72, '榜样', 'bǎngyàng', 'tấm gương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (73, '帮助', 'bāngzhù', 'giúp đỡ, hỗ trợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (74, '办理', 'bànlǐ', 'xử lý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (75, '办事', 'bànshì', 'làm việc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (76, '伴侣', 'bànlǚ', 'bạn đời, bạn đồng hành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (78, '班主任', 'bānzhǔrèn', 'giáo viên chủ nhiệm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (79, '板', 'bǎn', 'ván, tấm ván', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (81, '抱', 'bào', 'ôm, bế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (82, '包', 'bāo', 'bọc, túi, gói', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (83, '宝贝', 'bǎobèi', 'bảo bối, cưng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (96, '暴露', 'bàolù', 'bộc lộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (85, '保持', 'bǎochí', 'duy trì, giữ gìn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (86, '保护', 'bǎohù', 'bảo vệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (123, '暴风', 'bàofēng', 'bão tố', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (109, '包装', 'bāozhuāng', 'gói, bọc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (90, '暴力', 'bàolì', 'bạo lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (155, '崩发', 'bēngfā', 'bùng ra, phát nổ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (92, '保守', 'bǎoshǒu', 'bảo thủ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (93, '保卫', 'bǎowèi', 'bảo vệ, ủng hộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (94, '报名', 'bàomíng', 'báo danh, đăng ký', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (95, '报告', 'bàogào', 'báo cáo, thông báo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (163, '本身', 'běnshēn', 'tự bản thân', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (166, '本质', 'běnzhì', 'bản chất', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (98, '报酬', 'bàochou', 'thù lao, tiền công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (99, '报纸', 'bàozhǐ', 'báo chí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (100, '包裹', 'bāoguǒ', 'bưu kiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (101, '包容', 'bāoróng', 'khoan dung, bao dung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (102, '报仇', 'bàochóu', 'báo thù', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (104, '抱怨', 'bàoyuàn', 'oán hận, phàn nàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (105, '保证', 'bǎozhèng', 'đảm bảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (106, '保重', 'bǎozhòng', 'bảo trọng, cẩn thận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (107, '报复', 'bàofù', 'trả thù', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (108, '报负', 'bàofù', 'hoài bão, tham vọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (111, '报销', 'bàoxiāo', 'thanh toán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (110, '报关', 'bàoguān', 'khai hải quan', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (112, '保安', 'bǎo’ān', 'bảo vệ an ninh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (113, '保佑', 'bǎoyòu', 'phù hộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (114, '保障', 'bǎozhàng', 'đảm bảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (115, '保养', 'bǎoyǎng', 'bảo dưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (118, '爆炸', 'bàozhà', 'nổ, bùng nổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (120, '暴雨', 'bàoyǔ', 'mưa to', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (122, '宝石', 'bǎoshí', 'đá quý', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (124, '保证金', 'bǎozhèngjīn', 'tiền bảo chứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (125, '保存', 'bǎocún', 'bảo tồn, lưu giữ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (126, '包子', 'bāozi', 'bánh bao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (128, '把戏', 'bǎxì', 'xiếc, trò lừa bịp', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (129, '倍', 'bèi', 'lần, gấp bội', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (130, '被', 'bèi', 'bị, được', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (131, '背', 'bèi', 'lưng, học thuộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (132, '背诵', 'bèisòng', 'đọc thuộc lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (133, '悲哀', 'bēi’āi', 'bi ai, đau buồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (135, '悲惨', 'bēicǎn', 'bi thảm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (136, '被动', 'bèidòng', 'bị động', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (137, '北方', 'běifāng', 'miền Bắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (138, '备份', 'bèifèn', 'dành riêng, bản dự phòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (139, '被告', 'bèigào', 'bị cáo', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (140, '悲观', 'bēiguān', 'bi quan', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (141, '北极', 'běijí', 'bắc cực', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (143, '北京', 'běijīng', 'Bắc Kinh', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (144, '贝壳', 'bèiké', 'vỏ sò, vỏ ốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (145, '背叛', 'bèipàn', 'phản bội', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (146, '备忘录', 'bèiwànglù', 'bản ghi nhớ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (147, '被子', 'bèizi', 'chăn', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (148, '杯子', 'bēizi', 'cốc, chén, ly, tách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (149, '笨', 'bèn', 'đần, ngốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (150, '本', 'běn', 'quyển, gốc, vốn, thân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (153, '甭', 'béng', 'không cần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (154, '蹦', 'bèng', 'nhảy, bật, tung ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (156, '崩溃', 'bēngkuì', 'tan vỡ, sụp đổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (157, '本科', 'běnkē', 'khoa chính quy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (158, '本来', 'běnlái', 'vốn dĩ, lúc đầu, đáng lẽ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (159, '本领', 'běnlǐng', 'bản lĩnh, khả năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (160, '本能', 'běnnéng', 'bản năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (161, '本钱', 'běnqián', 'vốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (162, '本人', 'běnrén', 'bản thân, tôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (164, '本事', 'běnshi', 'khả năng, bản lĩnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (165, '本着', 'běnzhe', 'căn cứ, dựa vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (167, '笨拙', 'bènzhuō', 'vụng về', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (168, '臂', 'bì', 'cánh tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (170, '便', 'biàn', 'ngay cả, đủ cho, liền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (171, '遍', 'biàn', 'lần, khắp', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (172, '编', 'biān', 'dệt, biên soạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (173, '遍布', 'biànbù', 'phân bố, rải rác', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (174, '鞭策', 'biāncè', 'thúc giục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (175, '贬低', 'biǎndī', 'chê bai, hạ thấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (182, '边界', 'biānjiè', 'ranh giới', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (248, '闭塞', 'bìsè', 'tắc nghẽn, bế tắc', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (190, '贬义', 'biǎnyì', 'nghĩa xấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (203, '表决', 'biǎojué', 'biểu quyết, bầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (217, '必定', 'bìdìng', 'nhất định, chắc chắn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (224, '别致', 'biézhì', 'độc đáo, mới mẻ, khác thường', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (226, '比较', 'bǐjiào', 'so với, so sánh', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (230, '避免', 'bìmiǎn', 'tránh', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (234, '病毒', 'bìngdú', 'vi rút', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (255, '鼻子', 'bízi', 'mũi', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (245, '必要', 'bìyào', 'cần', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (177, '辩护', 'biànhù', 'biện hộ, bảo vệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (178, '变化', 'biànhuà', 'thay đổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (179, '编辑', 'biānjí', 'biên tập, chỉnh sửa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (180, '边疆', 'biānjiāng', 'biên giới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (181, '辩解', 'biànjiě', 'biện giải, giải thích', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (183, '边境', 'biānjìng', 'biên giới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (184, '便利', 'biànlì', 'tiện lợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (185, '辩论', 'biànlùn', 'tranh luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (186, '鞭炮', 'biānpào', 'pháo hoa, pháo nổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (187, '变迁', 'biànqiān', 'thay đổi, biến đổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (188, '辨认', 'biànrèn', 'nhận rõ, phân biệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (189, '便条', 'biàntiáo', 'giấy nhắn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (191, '便于', 'biànyú', 'tiện lợi, tiện cho', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (193, '辩证', 'biànzhèng', 'biện chứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (194, '变质', 'biànzhì', 'biến chất, hư hỏng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (195, '编织', 'biānzhī', 'bện, đan, tết', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (196, '辫子', 'biànzi', 'bím tóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (197, '标本', 'biāoběn', 'mẫu, tiêu bản', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (198, '表达', 'biǎodá', 'biểu đạt, diễn tả', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (199, '标点', 'biāodiǎn', 'chấm câu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (200, '表格', 'biǎogé', 'bảng, biểu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (201, '表哥', 'biǎogē', 'anh họ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (204, '表面', 'biǎomiàn', 'mặt ngoài, bề ngoài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (205, '表明', 'biǎomíng', 'tỏ rõ, chứng tỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (206, '表情', 'biǎoqíng', 'biểu cảm, nét mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (207, '表演', 'biǎoyǎn', 'biểu diễn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (208, '表彰', 'biǎozhāng', 'tuyên dương, khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (209, '表示', 'biǎoshì', 'biểu thị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (210, '表态', 'biǎotài', 'bày tỏ thái độ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (211, '表扬', 'biǎoyáng', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (212, '标志', 'biāozhì', 'cột mốc, ký hiệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (213, '标准', 'biāozhǔn', 'tiêu chuẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (215, '彼此', 'bǐcǐ', 'lẫn nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (216, '便签', 'biànqiān', 'giấy ghi nhớ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (218, '弊端', 'bìduān', 'tệ nạn, tai hại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (219, '别', 'bié', 'khác, chia lìa', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (220, '憋', 'biē', 'bịt, nín, kim nén', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (221, '别扭', 'bièniu', 'khó chịu, chướng, kỳ quặc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (222, '别人', 'biérén', 'người khác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (223, '别墅', 'biéshù', 'biệt thự', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (225, '比方', 'bǐfāng', 'ví, so sánh, so bì', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (228, '毕竟', 'bìjìng', 'rốt cuộc, cuối cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (229, '比例', 'bǐlì', 'tỷ lệ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (231, '丙', 'bǐng', 'thứ ba, Bính', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (232, '冰雹', 'bīngbáo', 'mưa đá', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (233, '并存', 'bìngcún', 'cùng tồn tại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (235, '并非', 'bìngfēi', 'không', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (236, '饼干', 'bǐnggān', 'bánh quy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (238, '并且', 'bìngqiě', 'đồng thời, và, hơn nữa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (239, '并行', 'bìngxíng', 'song hành, song song', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (240, '宾馆', 'bīnguǎn', 'nhà khách, khách sạn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (241, '冰箱', 'bīngxiāng', 'tủ lạnh, tủ đá', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (242, '冰激凌', 'bīngjīlíng', 'kem', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (243, '滨临', 'bīnlín', 'kề bên, kề cận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (244, '摈弃', 'bìnqì', 'từ bỏ, vứt bỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (246, '比如', 'bǐrú', 'ví dụ như, chẳng hạn như', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (247, '比赛', 'bǐsài', 'thi đấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (249, '泌', 'bì', 'tiết (chất lỏng)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (251, '毕业', 'bìyè', 'tốt nghiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (252, '碧玉', 'bìyù', 'ngọc bích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (253, '比喻', 'bǐyù', 'ví dụ, ví von', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (254, '比重', 'bǐzhòng', 'tỷ trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (256, '拨打', 'bōdǎ', 'gọi (điện thoại)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (257, '博大精深', 'bódàjīngshēn', 'uyên bác, uyên thâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (258, '搏斗', 'bódòu', 'vật lộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (259, '播放', 'bōfàng', 'truyền, phát, đưa tin', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (260, '波浪', 'bōlàng', 'sóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (262, '玻璃', 'bōli', 'thủy tinh', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (263, '伯母', 'bómǔ', 'bác gái', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (264, '博士', 'bóshì', 'tiến sĩ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (265, '波涛汹涌', 'bōtāoxiōngyǒng', 'sóng cuộn trào dâng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (266, '博物馆', 'bówùguǎn', 'viện bảo tàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (267, '剥削', 'bōxuē', 'bóc lột, lợi dụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (268, '播种', 'bōzhòng', 'gieo hạt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (269, '布', 'bù', 'vải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (270, '不', 'bù', 'không, chưa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (273, '不好意思', 'bùhǎoyìsi', 'cảm thấy xấu hổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (279, '不少', 'bùshǎo', 'không ít', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (280, '不耐烦', 'bù nàifán', 'nóng nảy, sốt ruột', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (281, '不相上下', 'bù xiāng shàngxià', 'ngang nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (282, '不像话', 'bù xiànghuà', 'chẳng ra làm sao cả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (284, '不安', 'bù’ān', 'bất an, lo lắng', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (294, '部分', 'bùfèn', 'bộ phận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (321, '擦', 'cā', 'lau chùi, chà, cọ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (323, '菜单', 'càidān', 'thực đơn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (335, '财务', 'cáiwù', 'tài vụ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (342, '参观', 'cānguān', 'tham quan', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (343, '残疾', 'cánjí', 'tàn tật', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (344, '参加', 'cānjiā', 'tham gia', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (349, '残留', 'cánliú', 'còn lại', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (357, '操劳', 'cāoláo', 'làm việc chăm chỉ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (275, '不仅', 'bùjǐn', 'không những, không chỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (276, '不免', 'bùmiǎn', 'không tránh được', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (277, '不然', 'bùrán', 'nếu không thì', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (278, '不如', 'bùrú', 'không bằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (377, '差不多', 'chàbuduō', 'xấp xỉ, gần giống nhau', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (285, '不必', 'bùbì', 'không cần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (286, '补充', 'bǔchōng', 'bổ sung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (287, '不但', 'bùdàn', 'không những', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (288, '不得不', 'bùdébù', 'không thể không', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (289, '不得了', 'bùdéliǎo', 'cực kỳ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (291, '不断', 'bùduàn', 'thường xuyên, không ngừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (292, '步伐', 'bùfá', 'tiến độ, nhịp bước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (293, '不妨', 'bùfáng', 'đừng ngại, không sao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (379, '柴油', 'cháiyóu', 'dầu diesel', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (295, '不顾', 'bùgù', 'không cần biết đến, bất cần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (296, '不管', 'bùguǎn', 'cho dù, bất luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (297, '不过', 'bùguò', 'nhưng, chẳng qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (298, '不禁', 'bùjīn', 'không nhịn được, không nén nổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (299, '不久', 'bùjiǔ', 'bổ cứu, cứu vãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (300, '布局', 'bùjú', 'bố cục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (301, '不堪', 'bùkān', 'không chịu nổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (303, '不愧', 'bùkuì', 'xứng đáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (304, '部落', 'bùluò', 'bộ lạc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (305, '部门', 'bùmén', 'bộ, ngành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (306, '哺乳', 'bǔrǔ', 'nuôi bằng sữa mẹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (307, '不时', 'bùshí', 'đôi khi, thỉnh thoảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (308, '部署', 'bùshǔ', 'sắp xếp, bố trí', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (309, '补贴', 'bǔtiē', 'tiền trợ cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (310, '部位', 'bùwèi', 'bộ vị, vị trí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (311, '不惜', 'bùxī', 'ngần ngại, không tiếc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (312, '不屑一顾', 'bùxiè yī gù', 'không đáng xem', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (313, '不药而愈', 'bùyào ér yù', 'không sao đâu', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (314, '不由得', 'bùyóude', 'không được, đành phải', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (316, '布置', 'bùzhì', 'sắp xếp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (317, '不止', 'bùzhǐ', 'không ngớt, không dứt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (318, '步骤', 'bùzhòu', 'bước đi, trình tự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (319, '捕捉', 'bǔzhuō', 'bắt, tóm, chụp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (320, '不足', 'bùzú', 'không đủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (322, '才', 'cái', 'mới (động tác diễn ra muộn)', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (324, '采访', 'cǎifǎng', 'phỏng vấn, săn tin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (325, '裁缝', 'cáiféng', 'thợ may', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (326, '财富', 'cáifù', 'sự giàu có', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (327, '才干', 'cáigàn', 'năng lực, tài cán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (328, '采购', 'cǎigòu', 'mua, thu mua', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (329, '才华', 'cáihuá', 'tài năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (331, '采纳', 'cǎinà', 'tiếp nhận, tiếp thu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (332, '裁判', 'cáipàn', 'trọng tài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (333, '彩票', 'cǎipiào', 'vé số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (334, '采取', 'cǎiqǔ', 'lấy, áp dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (337, '财政', 'cáizhèng', 'tài chính', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (338, '舱', 'cāng', 'khoang, buồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (339, '苍白', 'cāngbái', 'tái nhợt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (340, '仓促', 'cāngcù', 'vội vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (341, '仓库', 'cāngkù', 'kho', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (345, '参考', 'cānkǎo', 'tham khảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (346, '残酷', 'cánkù', 'tàn khốc, tàn bạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (347, '惭愧', 'cánkuì', 'xấu hổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (348, '灿烂', 'cànlàn', 'sáng lạng, rực rỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (351, '餐厅', 'cāntīng', 'phòng ăn, nhà ăn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (352, '参与', 'cānyù', 'tham dự', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (353, '参照', 'cānzhào', 'tham chiếu, bắt trước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (354, '草', 'cǎo', 'cỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (355, '草案', 'cǎo’àn', 'bản thảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (356, '操场', 'cāochǎng', 'sân vận động, bãi tập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (358, '操练', 'cāoliàn', 'luyện tập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (359, '草率', 'cǎoshuài', 'qua loa, đại khái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (360, '操心', 'cāoxīn', 'bận tâm, lo lắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (361, '嘈杂', 'cáozá', 'ồn ào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (362, '操纵', 'cāozòng', 'điều khiển, thao túng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (363, '操作', 'cāozuò', 'thao tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (364, '册', 'cè', 'sổ, quyển, tập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (366, '测量', 'cèliáng', 'đo lường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (367, '策略', 'cèlüè', 'sách lược', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (368, '侧面', 'cèmiàn', 'mặt bên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (369, '层', 'céng', 'tầng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (371, '曾经', 'céngjīng', 'từng, đã từng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (372, '厕所', 'cèsuǒ', 'nhà vệ sinh', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (373, '测验', 'cèyàn', 'kiểm tra, trắc nghiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (374, '茶', 'chá', 'trà', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (375, '叉', 'chā', 'que, ngạnh, rẽ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (376, '差别', 'chābié', 'khác nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (378, '插座', 'chāzuò', 'stổ cắm điện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1642, '计划', 'jìhuà', 'kế hoạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (385, '产品', 'chǎnpǐn', 'sản phẩm', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (415, '缠绕', 'chánrào', 'quấn, quấn quanh', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (401, '尝', 'cháng', 'thường thức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (430, '叉子', 'chāzi', 'cái nĩa', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (390, '长', 'zhǎng', 'tăng lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (437, '秤', 'chèng', 'cái cân', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (438, '城市', 'chéngshì', 'thành phố', NULL, 29);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (381, '拆', 'chāi', 'tháo, gỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (382, '拆迁', 'chāiqiān', 'di dời, giải tỏa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (383, '缠', 'chán', 'vướng, quấn, dây dưa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (384, '馋', 'chán', 'ham ăn, tham ăn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (452, '成交', 'chéngjiāo', 'giao dịch', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (464, '成天', 'chéngtiān', 'suốt ngày, cả ngày', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (388, '颤抖', 'chàndǒu', 'run rẩy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (389, '昌盛', 'chāngshèng', 'hưng thịnh, hưng vượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (472, '乘坐', 'chéngzuò', 'đi, cưỡi (tàu, xe, máy bay…)', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (391, '常', 'cháng', 'thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (392, '场', 'chǎng', 'nơi, bãi, cuộc, trận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (393, '厂', 'chǎng', 'xưởng, nhà máy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (394, '长城', 'chángchéng', 'Trường Thành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (395, '长处', 'chángchù', 'ưu điểm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (396, '长短', 'chángduǎn', 'dài ngắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (397, '长江', 'chángjiāng', 'Trường Giang', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (398, '常识', 'chángshí', 'kiến thức phổ thông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (399, '唱', 'chàng', 'hát', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (400, '唱歌', 'chànggē', 'hát', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (477, '沉思', 'chénsī', 'suy ngẫm, trầm tư', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (403, '偿还', 'chánghuán', 'trả nợ, bồi hoàn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (404, '敞开', 'chǎngkāi', 'mở rộng, thoải mái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (405, '猖狂', 'chāngkuáng', 'ngang ngược, điên cuồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (406, '场面', 'chǎngmiàn', 'tình cảnh', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (407, '常年', 'chángnián', 'quanh năm, lâu dài, hằng năm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (408, '尝试', 'chángshì', 'thử', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (409, '场所', 'chǎngsuǒ', 'nơi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (410, '畅通', 'chàngtōng', 'thông suốt, trôi chảy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (411, '长途', 'chángtú', 'dài, đường dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (412, '常务', 'chángwù', 'thường vụ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (413, '长袖', 'chángxiù', 'bánh chay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (387, '产业', 'chǎnyè', 'sản nghiệp, ngành nghề', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (416, '展示', 'zhǎnshì', 'trình bày, biểu hiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (417, '朝', 'cháo', 'ngoảnh mặt về, hướng về', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (418, '吵', 'chǎo', 'ồn ào, tranh cãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (419, '炒', 'chǎo', 'xào, rang', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (420, '抄', 'chāo', 'copy, sao chép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (421, '超越', 'chāoyuè', 'vượt qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (422, '朝代', 'cháodài', 'triều đại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (423, '超出', 'chāochū', 'vượt quá, vượt lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (424, '超级', 'chāojí', 'siêu, siêu cấp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (425, '潮流', 'cháoliú', 'trào lưu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (427, '潮湿', 'cháoshī', 'ẩm ướt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (428, '超市', 'chāoshì', 'siêu thị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (429, '诧异', 'chàyì', 'ngạc nhiên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (431, '彻底', 'chèdǐ', 'triệt để, hoàn toàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (432, '车库', 'chēkù', 'nhà để xe', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (433, '趁', 'chèn', 'nhân lúc, thừa dịp', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (434, '沉淀', 'chéndiàn', 'kết tủa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (435, '乘', 'chéng', 'đi, cưỡi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (436, '橙', 'chéng', 'trái cam', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (440, '承办', 'chéngbàn', 'đảm đương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (441, '城堡', 'chéngbǎo', 'lâu đài', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (442, '承包', 'chéngbāo', 'ký hợp đồng, nhận thầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (443, '成本', 'chéngběn', 'chi phí, giá thành', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (444, '承担', 'chéngdān', 'gánh vác, đảm đương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (445, '惩罚', 'chéngfá', 'trừng trị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (446, '成分', 'chéngfèn', 'thành phần', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (447, '成功', 'chénggōng', 'thành công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (448, '成果', 'chéngguǒ', 'thành quả', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (449, '称号', 'chénghào', 'tước vị, danh hiệu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (450, '诚恳', 'chéngkěn', 'chân thành', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (451, '成员', 'chéngyuán', 'thành viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (453, '成立', 'chénglì', 'thành lập', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (454, '承认', 'chéngrèn', 'thừa nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (456, '成就', 'chéngjiù', 'thành tựu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (457, '成语', 'chéngyǔ', 'thành ngữ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (458, '称呼', 'chénghu', 'xưng hô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (459, '成全', 'chéngquán', 'hoàn thành, giúp hoàn thiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (460, '成清', 'chéngqīng', 'làm rõ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (461, '诚实', 'chéngshí', 'thành thực, thật thà', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (462, '承受', 'chéngshòu', 'chịu đựng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (465, '成为', 'chéngwéi', 'trở thành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (467, '呈现', 'chéngxiàn', 'lộ ra, phơi bày', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (468, '成效', 'chéngxiào', 'hiệu quả, công hiệu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (469, '称赞', 'chēngzàn', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (470, '成长', 'chéngzhǎng', 'lớn lên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (471, '诚挚', 'chéngzhì', 'chân thành, thân ái', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (473, '陈旧', 'chénjiù', 'lỗi thời, cũ kỹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (474, '陈列', 'chénliè', 'trưng bày', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (475, '沉闷', 'chénmèn', 'ngột ngạt, nặng nề', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (476, '沉默', 'chénmò', 'im lặng', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (478, '沉痛', 'chéntòng', 'đau thương, bi thống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (479, '沉重', 'chénzhòng', 'trách nhiệm, nặng nề', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (480, '沉着', 'chénzhuó', 'bình tĩnh, vững vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (481, '趁机', 'chènjī', 'thừa cơ, nhân dịp', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (496, '尺子', 'chǐzi', 'thước đo', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (502, '重复', 'chóngfù', 'lặp lại, trùng lặp', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (512, '抽烟', 'chōuyān', 'hút thuốc', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (522, '丑', 'chǒu', 'xấu xí', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (533, '船舶', 'chuánbó', 'thuyền bè', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (544, '窗帘', 'chuānglián', 'rèm cửa sổ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (534, '传播', 'chuánbō', 'truyền bá', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (555, '初步', 'chūbù', 'sơ bộ, bước đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (483, '趁热打铁', 'chènrè dǎtiě', 'thừa thắng xông lên', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (484, '驰骋', 'chíchěng', 'phi nước đại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (485, '迟到', 'chídào', 'đến muộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (486, '赤道', 'chìdào', 'xích đạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (487, '迟缓', 'chíhuǎn', 'trì trệ, chậm chạp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (489, '持久', 'chíjiǔ', 'kéo dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (490, '吃苦', 'chīkǔ', 'chịu khổ, chịu thiệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (491, '吃亏', 'chīkuī', 'chịu thiệt, bị thiệt hại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (492, '吃力', 'chīlì', 'mệt nhọc, tốn sức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (493, '池塘', 'chítáng', 'hồ, ao, đầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (494, '持续', 'chíxù', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (495, '赤字', 'chìzì', 'thâm hụt, bội chi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (498, '冲动', 'chōngdòng', 'xung động, kích thích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (499, '充当', 'chōngdāng', 'đảm nhận, giữ chức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (500, '充电器', 'chōngdiànqì', 'bộ sạc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (501, '充足', 'chōngzú', 'đầy đủ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (503, '崇高', 'chónggāo', 'cao cả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (504, '崇敬', 'chóngjìng', 'tôn kính, kính trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (505, '崇拜', 'chóngbài', 'sùng bái, tôn thờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (506, '重叠', 'chóngdié', 'chồng chéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (508, '宠物', 'chǒngwù', 'thú cưng, vật nuôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (509, '宠爱', 'chǒng’ài', 'yêu thương, cưng chiều', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (510, '抽屉', 'chōuti', 'ngăn kéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (511, '抽象', 'chōuxiàng', 'trừu tượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (513, '抽奖', 'chōujiǎng', 'rút thăm trúng thưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (514, '臭', 'chòu', 'hôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (515, '出版', 'chūbǎn', 'xuất bản', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (516, '出差', 'chūchāi', 'công tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (517, '出发', 'chūfā', 'xuất phát', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (519, '出口', 'chūkǒu', 'lối ra / xuất khẩu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (520, '出类拔萃', 'chūlèi bácuì', 'xuất chúng, ưu tú', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (521, '出色', 'chūsè', 'xuất sắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (523, '筹备', 'chóubèi', 'chuẩn bị, trù bị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (524, '踌躇', 'chóuchú', 'do dự, trăn trừ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (525, '丑恶', 'chǒu’è', 'xấu xí, ác độc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (527, '稠密', 'chóumì', 'dày đặc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (528, '除', 'chú', 'trừ bỏ, phép chia', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (529, '出', 'chū', 'ra, xuất, đến', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (530, '船', 'chuán', 'thuyền, tàu', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (531, '串', 'chuàn', 'chuỗi, xâu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (532, '穿着', 'chuānzhuó', 'mặc, đội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (536, '传单', 'chuándān', 'tờ rơi, truyền đơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (537, '传递', 'chuándì', 'truyền, chuyển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (538, '船舱', 'chuáncāng', 'khoang tàu, boong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (539, '闯', 'chuǎng', 'xông, đâm bổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (540, '创作', 'chuàngzuò', 'sáng tác', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (542, '窗户', 'chuānghu', 'cửa sổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (543, '创立', 'chuànglì', 'thành lập, sáng lập', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (545, '创新', 'chuàngxīn', 'cải tiến, đổi mới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (546, '创业', 'chuàngyè', 'lập nghiệp, khởi nghiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (548, '穿越', 'chuānyuè', 'vượt qua, vượt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (549, '传染', 'chuánrǎn', 'truyền nhiễm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (550, '传授', 'chuánshòu', 'truyền dạy, truyền thụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (552, '传统', 'chuántǒng', 'truyền thống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (553, '传真', 'chuánzhēn', 'fax', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (554, '储备', 'chǔbèi', 'dự trữ, để dành', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (556, '储存', 'chǔcún', 'dự trữ, để dành', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (557, '触犯', 'chùfàn', 'xúc phạm, xâm phạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (558, '厨房', 'chúfáng', 'bếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (559, '除非', 'chúfēi', 'trừ phi', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (560, '处罚', 'chǔfá', 'trừng phạt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (561, '锤', 'chuí', 'cái búa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (562, '吹', 'chuī', 'thổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (563, '吹牛', 'chuīniú', 'khoác lác, thổi phồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (564, '吹捧', 'chuīpěng', 'tâng bốc, ca tụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (565, '垂直', 'chuízhí', 'vuông góc, thẳng đứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (566, '初级', 'chūjí', 'sơ cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (568, '除了', 'chúle', 'ngoài ra, trừ ra', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (569, '处理', 'chǔlǐ', 'xử lý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (570, '出路', 'chūlù', 'lối thoát, đường ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (571, '出卖', 'chūmài', 'bán', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (572, '春', 'chūn', 'mùa xuân', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (573, '纯粹', 'chúncuì', 'tinh khiết, thuần khiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (574, '纯洁', 'chúnjié', 'thuần khiết, trong sạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (575, '出神', 'chūshén', 'xuất thần, say sưa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (576, '出身', 'chūshēn', 'xuất thân', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (577, '出生', 'chūshēng', 'sinh ra, ra đời', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (578, '除夕', 'chúxī', 'đêm giao thừa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (580, '出席', 'chūxí', 'dự họp, có mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (581, '出现', 'chūxiàn', 'xuất hiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (582, '储蓄', 'chǔxù', 'dự trữ, dành dụm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (583, '出洋相', 'chūyángxiàng', 'xấu mặt, làm trò cười cho thiên hạ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (584, '处置', 'chǔzhì', 'xử lý, xử trí', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1473, '胡子', 'húzi', 'râu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (590, '磁带', 'cídài', 'băng từ', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (616, '促进', 'cùshǐ', 'thúc đẩy, giúp giã', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (593, '刺激', 'cìjī', 'kích thích', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (629, '打篮球', 'dǎ lánqiú', 'chơi bóng rổ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (633, '打扮', 'dǎbàn', 'trang điểm, ăn vận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (652, '代价', 'dàijià', 'giá phải trả, chi phí', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (654, '代理', 'dàilǐ', 'đại lý', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (655, '带领', 'dàilǐng', 'dẫn dắt', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (672, '挡', 'dǎng', 'ngăn chặn, ngăn cản', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (678, '当初', 'dāngchū', 'lúc đầu, hồi đó', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (587, '次', 'cì', 'lần', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (589, '次要', 'cì yào', 'thứ yếu, không quan trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2676, '深', 'shēn', 'sâu, đậm', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (591, '词典', 'cídiǎn', 'từ điển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (592, '词汇', 'cíhuì', 'từ vựng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (594, '此外', 'cǐwài', 'ngoài ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (595, '慈祥', 'cíxiáng', 'hiền từ, hiền hậu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (596, '次序', 'cìxù', 'trật tự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (598, '丛', 'cóng', 'bụi, lùm, khóm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (599, '从', 'cóng', 'theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (600, '从此', 'cóngcǐ', 'từ đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (601, '从而', 'cóng’ér', 'do đó, vì vậy', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (602, '从来', 'cónglái', 'từ trước tới nay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (603, '从容', 'cóngróng', 'điềm tĩnh, thong thả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (604, '聪明', 'cōngmíng', 'thông minh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (606, '从事', 'cóngshì', 'làm, tham gia', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (607, '从未', 'cóngwèi', 'chưa từng, chưa bao giờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (608, '从小', 'cóngxiǎo', 'từ nhỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (609, '从容不迫', 'cóngróngbùpò', 'chậm rãi, không vội vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (610, '凑合', 'còuhe', 'tập hợp, gom góp, quây quần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (611, '醋', 'cù', 'giấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (612, '窜', 'cuàn', 'lủi, chuồn, chạy toán loạn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (613, '催', 'cuī', 'thúc giục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (614, '摧残', 'cuīcán', 'phá hủy, tàn phá', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (615, '脆弱', 'cuìruò', 'mỏng manh, yếu đuối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (617, '存', 'cún', 'tồn tại, bảo tồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (618, '存在', 'cúnzài', 'tồn tại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (619, '撮', 'cuō', 'xoay, xoắn, vặn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (621, '措施', 'cuòshī', 'biện pháp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (622, '错误', 'cuòwù', 'sai, sai lầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (623, '挫折', 'cuòzhé', 'sự thất bại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (624, '粗心', 'cūxīn', 'sơ ý, cẩu thả, bất cẩn', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (625, '大', 'dà', 'to, lớn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (626, '打', 'dǎ', 'đánh, mát, đập, phác, khoác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (627, '打电话', 'dǎ diànhuà', 'gọi điện thoại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (628, '打官司', 'dǎ guānsi', 'kiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (630, '打喷嚏', 'dǎ pēntì', 'hắt xì hơi, nhảy mũi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (631, '大象', 'dà xiàng', 'voi, con voi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (632, '答案', 'dá’àn', 'đáp án', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (634, '打包', 'dǎbāo', 'đóng gói, gói lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (635, '打比方', 'dǎbǐfāng', 'lấy ví dụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (637, '打败', 'dǎbài', 'đánh bại', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (638, '大臣', 'dàchén', 'đại thần', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (639, '达成', 'dáchéng', 'đạt đến, đạt được', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (640, '搭档', 'dādàng', 'người hợp tác, cộng tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (641, '达到', 'dádào', 'đến, đạt được', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (642, '大方', 'dàfāng', 'hào phóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (643, '大夫', 'dàifu', 'bác sĩ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (644, '大概', 'dàgài', 'khoảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (645, '打工', 'dǎgōng', 'làm công, làm thuê', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (646, '大伙儿', 'dàhuǒr', 'mọi người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (647, '带', 'dài', 'đem, mang', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (648, '戴', 'dài', 'đeo, mang, đội', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (649, '呆', 'dāi', 'ngốc, ngẩn ngơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (651, '逮捕', 'dàibǔ', 'bắt giữ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (653, '贷款', 'dàikuǎn', 'cho vay, vay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (656, '待遇', 'dàiyù', 'đãi ngộ, đối xử, lạnh nhạt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (657, '代替', 'dàitì', 'thay thế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (658, '打击', 'dǎjí', 'gõ,đập,đánh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (659, '打交道', 'dǎjiāodào', 'giao tiếp, tiếp xúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (660, '打量', 'dǎliàng', 'quan sát, nhìn đánh giá', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (661, '打猎', 'dǎliè', 'săn bắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (662, '蛋白质', 'dànbáizhì', 'protein', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (663, '担保', 'dānbǎo', 'đảm bảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (665, '单调', 'dāndiào', 'đơn điệu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (666, '单独', 'dāndú', 'đơn độc, một mình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (667, '单位', 'dānwèi', 'bài mục, đơn vị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (668, '担任', 'dānrèn', 'đảm nhiệm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (669, '单元', 'dānyuán', 'bài học, đơn nguyên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (670, '诞辰', 'dànchén', 'ngày sinh nhật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (671, '党', 'dǎng', 'đảng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (673, '当', 'dāng', 'làm, đảm nhiệm, khi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (675, '档案', 'dàng’àn', 'hồ sơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (676, '蛋糕', 'dàngāo', 'bánh ga-tô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (677, '当场', 'dāngchǎng', 'tại chỗ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (679, '档次', 'dàngcì', 'đẳng cấp, cấp bậc', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (680, '当代', 'dāngdài', 'ngày nay, đương đại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (681, '当面', 'dāngmiàn', 'trước mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (682, '当前', 'dāngqián', 'hiện tại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (683, '当然', 'dāngrán', 'đương nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (685, '当事人', 'dāngshìrén', 'người có liên quan, đương sự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (686, '当务之急', 'dāngwùzhījí', 'việc khẩn cấp trước mắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (687, '当心', 'dāngxīn', 'cẩn thận, coi chừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (694, '淡忘', 'dànwàng', 'lãng quên', NULL, 29);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (695, '胆小鬼', 'dǎnxiǎoguǐ', 'kẻ nhát gan', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (720, '打扫', 'dǎsǎo', 'quét, quét dọn', NULL, 39);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (727, '打印', 'dǎyìn', 'in ấn', NULL, 39);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (732, '打折', 'dǎzhé', 'chiết khấu, giảm giá', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (741, '灯', 'dēng', 'đèn', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (762, '点', 'diǎn', 'điểm, giờ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (689, '淡季', 'dànjì', 'trái mùa, mua ế hàng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (691, '诞生', 'dànshēng', 'ra đời, sinh ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (692, '但是', 'dànshì', 'nhưng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (693, '淡水', 'dànshuǐ', 'nước ngọt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (696, '担心', 'dānxīn', 'lo lắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (697, '倒', 'dǎo', 'đổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (698, '到', 'dào', 'đến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (699, '岛', 'dǎo', 'đảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (700, '刀', 'dāo', 'đao, dao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (701, '倒闭', 'dǎobì', 'sập tiệm, đóng cửa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (702, '到处', 'dàochù', 'khắp nơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (704, '导弹', 'dǎodàn', 'hỏa tiễn, đạn đạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (705, '道德', 'dàodé', 'đạo đức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (706, '到底', 'dàodǐ', 'đến cùng, rốt cuộc, suy cho cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (707, '稻谷', 'dàogǔ', 'lúa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (708, '导航', 'dǎoháng', 'dẫn đường, hướng dẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (709, '道理', 'dàolǐ', 'đạo lý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (710, '捣乱', 'dǎoluàn', 'phá đám, quấy rối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (711, '倒霉', 'dǎoméi', 'xui xẻo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (713, '盗窃', 'dàoqiè', 'trộm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (714, '导向', 'dǎoxiàng', 'hướng dẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (715, '导演', 'dǎoyǎn', 'đạo diễn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (716, '导游', 'dǎoyóu', 'hướng dẫn viên du lịch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (717, '岛屿', 'dǎoyǔ', 'quần đảo', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (718, '导致', 'dǎozhì', 'dẫn đến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (719, '打算', 'dǎsuàn', 'nhịn chung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (721, '大厦', 'dàshà', 'tòa nhà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (722, '大使馆', 'dàshǐguǎn', 'đại sứ quán', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (724, '大体', 'dàtǐ', 'thăm dò, nghe ngóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (725, '大兴', 'dàxīng', 'quy mô lớn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (726, '大意', 'dàyì', 'không cẩn thận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (728, '答应', 'dāying', 'đồng ý, bằng lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (729, '大约', 'dàyuē', 'khoảng, ước chừng, chắc là', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (730, '打仗', 'dǎzhàng', 'đánh nhau, đánh trận', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (731, '打招呼', 'dǎzhāohu', 'chào hỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (733, '打针', 'dǎzhēn', 'tiêm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (734, '大致', 'dàzhì', 'khoảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (735, '地', 'de', 'trợ từ kết cấu', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (736, '的', 'de', 'của', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (737, '得', 'dé', 'được, mắc (bệnh)', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (739, '得力', 'délì', 'được lợi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (740, '瞪', 'dèng', 'nhìn chằm chằm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (742, '等', 'děng', 'chờ, đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (743, '登', 'dēng', 'đạp, giẫm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (744, '登机牌', 'dēngjīpái', 'thẻ lên máy bay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (745, '登录', 'dēnglù', 'đăng nhập', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (746, '等待', 'děngdài', 'đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (747, '等候', 'děnghòu', 'đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (748, '等级', 'děngjí', 'cấp bậc, đẳng cấp', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (749, '登记', 'dēngjì', 'đăng ký', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (750, '灯笼', 'dēnglóng', 'đèn lồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (751, '登陆', 'dēnglù', 'bộ, lên bờ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (752, '等于', 'děngyú', 'bằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (754, '得意', 'déyì', 'đắc ý', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (755, '得罪', 'dézuì', 'đắc tội', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (756, '递', 'dì', 'truyền đạt, chuyển giao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (757, '底', 'dǐ', 'đáy, đế, cuối, nền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (758, '低', 'dī', 'thấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (759, '滴', 'dī', 'nhỏ giọt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (760, '第一', 'dì yī', 'thứ nhất', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (761, '垫', 'diàn', 'đệm, cái lót', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (763, '颠簸', 'diānbǒ', 'lắc lư, tròng trành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (764, '电池', 'diànchí', 'pin, ắc quy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (765, '颠倒', 'diāndǎo', 'lật ngược, đảo lộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (767, '惦记', 'diànjì', 'nghĩ đến, nhớ đến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (768, '电力', 'diànlì', 'nghị lực', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (769, '电脑', 'diànnǎo', 'máy vi tính', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (770, '电视', 'diànshì', 'truyền hình, ti-vi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (771, '电台', 'diàntái', 'trạm phát sóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (772, '电梯', 'diàntī', 'thang máy', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (774, '电信', 'diànxìn', 'trang miệng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (775, '电影', 'diànyǐng', 'phim', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (776, '典礼', 'diǎnlǐ', 'điển hình, nghi lễ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (777, '电源', 'diànyuán', 'nguồn điện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (778, '电子邮件', 'diànzǐ yóujiàn', 'e-mail', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (779, '吊', 'diào', 'treo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (780, '掉', 'diào', 'rơi, mất, giảm, hạ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (781, '钓', 'diào', 'câu cá', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (782, '雕', 'diāo', 'ngắm, thả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (784, '调动', 'diàodòng', 'điều động, đổi, thay đổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (785, '雕刻', 'diāokè', 'điêu khắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (786, '雕塑', 'diāosù', 'điêu khắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (787, '跌倒', 'diēdǎo', 'ngã, đổ, té', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (788, '叠', 'dié', 'gấp, chồng, xếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (789, '地步', 'dìbù', 'mức, bước', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (790, '地道', 'dìdao', 'địa đạo', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (791, '地点', 'dìdiǎn', 'địa điểm', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (792, '弟弟', 'dìdi', 'em trai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (793, '跌', 'diē', 'ngã, té, rơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1643, '忌讳', 'jìhuì', 'kiêng kỵ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (814, '冬', 'dōng', 'mùa đông, đông', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (877, '顿', 'dùn', 'tán', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (797, '盯', 'dīng', 'nhìn chăm chăm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (817, '动画片', 'dònghuà piàn', 'phim hoạt hình', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (825, '动手', 'dòngshǒu', 'bắt đầu làm, bắt tay vào làm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (837, '读', 'dú', 'đọc', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (841, '端午节', 'duānwǔ jié', 'Tết Đoan Ngọ', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (855, '对话', 'duìhuà', 'đối thoại', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (874, '对照', 'duìzhào', 'so sánh, đối chiếu', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (876, '独立', 'dúlì', 'độc lập', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (882, '躲藏', 'duǒcáng', 'trốn tránh, ẩn náu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (798, '定期', 'dìngqī', 'theo kỳ hạn, định kỳ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (799, '定义', 'dìngyì', 'định nghĩa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (800, '叮嘱', 'dīngzhǔ', 'căn dặn, dặn dò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (801, '地球', 'dìqiú', 'trái đất, địa cầu', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (802, '地区', 'dìqū', 'vùng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (804, '敌人', 'dírén', 'kẻ thù', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (805, '敌视', 'díshì', 'căm thù, coi như kẻ thù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (806, '地势', 'dìshì', 'địa thế', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (807, '地铁', 'dìtiě', 'xe điện ngầm', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (808, '地图', 'dìtú', 'bản đồ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (809, '地位', 'dìwèi', 'địa vị', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (810, '地震', 'dìzhèn', 'động đất', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (811, '地质', 'dìzhì', 'địa chất', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (813, '东', 'dōng', 'phía đông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (815, '动荡', 'dòngdàng', 'bấp bênh, rối ren, hỗn loạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (816, '东道主', 'dōngdàozhǔ', 'chủ nhà', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (818, '动机', 'dòngjī', 'động cơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (819, '冻结', 'dòngjié', 'đóng lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (820, '动静', 'dòngjìng', 'động tĩnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (821, '动力', 'dònglì', 'động lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (822, '动脉', 'dòngmài', 'động mạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (823, '动身', 'dòngshēn', 'khởi hành, lên đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (826, '动态', 'dòngtài', 'động thái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (827, '动物', 'dòngwù', 'động vật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (828, '东西', 'dōngxi', 'đồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (829, '洞穴', 'dòngxué', 'hang động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (830, '动员', 'dòngyuán', 'huy động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (831, '东张西望', 'dōngzhāngxīwàng', 'nhìn đông nhìn tây', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (832, '动作', 'dòngzuò', 'động tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (833, '逗', 'dòu', 'chọc tức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (834, '豆腐', 'dòufu', 'đậu phụ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (835, '陡峭', 'dǒuqiào', 'dốc đứng, dốc ngược', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (836, '斗争', 'dòuzhēng', 'đấu tranh', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (838, '断', 'duàn', 'đứt, đoạn tuyệt, chặt, cai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (839, '段', 'duàn', 'đoạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (840, '端', 'duān', 'đầu, đầu mút', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (842, '断定', 'duàndìng', 'kết luận, nhận định', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (844, '短', 'duǎn', 'ngắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (845, '短促', 'duǎncù', 'ngắn ngủi, vội vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (846, '短期', 'duǎnqī', 'ngắn hạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (847, '短暂', 'duǎnzàn', 'ngắn ngủi, thoáng qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (848, '堆', 'duī', 'túi, tụ, chồng chất, đóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (849, '堆积', 'duījī', 'tích tụ, chất đống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (850, '队', 'duì', 'đội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (851, '对', 'duì', 'đúng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (852, '对比', 'duìbǐ', 'so sánh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (853, '对待', 'duìdài', 'đối xử, đối đãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (856, '断断续续', 'duànduànxùxù', 'gián đoạn, không liên tục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (857, '锻炼', 'duànliàn', 'tập luyện, rèn luyện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (858, '端信', 'duānxìn', 'tin nhắn', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (859, '端正', 'duānzhèng', 'đoan chính, đều đặn, ngay ngắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (860, '赌博', 'dǔbó', 'cờ bạc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (861, '独裁', 'dúcái', 'độc tài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (862, '督促', 'dūcù', 'thúc giục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (863, '渡过', 'dùguò', 'xuyên qua, trải qua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (865, '对不起', 'duìbuqǐ', 'xin lỗi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (866, '对策', 'duìcè', 'biện pháp đối phó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (867, '对称', 'duìchèn', 'tính cân xứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (868, '兑换', 'duìhuàn', 'trao đổi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (870, '对立', 'duìlì', 'đối lập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (871, '对联', 'duìlián', 'đối liễn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (872, '对应', 'duìyìng', 'đối ứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (873, '对于', 'duìyú', 'về, đối với', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (875, '独绝', 'dújué', 'tiêu độc, ngăn chặn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (878, '盹', 'dǔn', 'ngồi xồm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (880, '朵', 'duǒ', 'bông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (881, '多', 'duō', 'nhiều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (883, '多亏', 'duōkuī', 'may mắn, may mà', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (884, '堕落', 'duòluò', 'sa ngã, trụy lạc', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (885, '多么', 'duōme', 'bao nhiêu, biết bao', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (886, '哆嗦', 'duōsuo', 'lạnh cóng, run cầm cập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (887, '多余', 'duōyú', 'dư, dư thừa', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (888, '多元化', 'duōyuán huà', 'đa dạng hóa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (889, '毒品', 'dúpǐn', 'thuốc phiện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (890, '阻塞', 'dūsè', 'tắc nghẽn, ngăn chặn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (891, '都市', 'dūshì', 'đô thị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (893, '肚子', 'dùzi', 'bụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (894, '饿', 'è', 'đói', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (895, '讹', 'é', 'chuyển biến xấu, thay đổi xấu đi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (897, '恶', 'è', 'ừ, hừ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (898, '怨恨', 'yuànhèn', 'oán hận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (899, '而', 'ér', 'và, mà, nhưng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (901, '儿童', 'értóng', 'nhi đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3571, '岩石', 'yánshí', 'đá', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (908, '发表', 'fābiǎo', 'phát biểu, tuyên bố', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (912, '发达', 'fādá', 'phát triển, phồn vinh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (925, '反复', 'fǎnfù', 'lặp đi lặp lại', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (922, '翻', 'fān', 'xoay, lật, trở mình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (935, '反问', 'fǎnwèn', 'hỏi lại', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (910, '发财', 'fācái', 'phát tài, làm giàu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (927, '反面', 'fǎnmiàn', 'phản diện, mặt trái', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (954, '饭馆', 'fànguǎn', 'quán cơm', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (956, '访问', 'fǎnwèn', 'hỏi lại, hồi vấn lại', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (980, '法', 'fǎ', 'thể', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (902, '二氧化碳', 'èryǎnghuàtàn', 'CO₂', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (903, '而已', 'éryǐ', 'mà thôi, thế thôi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (904, '儿子', 'érzi', 'con trai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (905, '额外', 'éwài', 'ngoài định mức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (907, '发', 'fā', 'phát, gửi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (916, '发挥', 'fāhuī', 'phát huy', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (909, '发布', 'fābù', 'tuyên bố, phát hành, thông báo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (911, '发愁', 'fāchóu', 'lo lắng, buồn phiền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (913, '发呆', 'fādāi', 'ngẩn người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (914, '发动', 'fādòng', 'phát động, bắt đầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (915, '发抖', 'fādǒu', 'run rẩy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (918, '发觉', 'fājué', 'phát hiện, phát giác', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (919, '发款', 'fākuǎn', 'phát tiền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (920, '法律', 'fǎlǜ', 'pháp luật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (921, '发明', 'fāmíng', 'phát minh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (924, '反常', 'fǎncháng', 'dị thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (926, '反抗', 'fǎnkàng', 'phản kháng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (928, '反应', 'fǎnyìng', 'phản ứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (929, '反映', 'fǎnyìng', 'phản ánh', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (930, '反对', 'fǎnduì', 'phản đối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (931, '反转', 'fǎnzhuǎn', 'trái lại, ngược lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (932, '反思', 'fǎnsī', 'suy ngẫm, phản tỉnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (933, '反射', 'fǎnshè', 'phản xạ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (934, '反馈', 'fǎnkuì', 'phản hồi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (936, '放', 'fàng', 'tha, thả', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (938, '放暑假', 'fàng shǔjià', 'nghỉ hè', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (939, '妨碍', 'fáng''ài', 'gây trở ngại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (940, '反感', 'fǎngǎn', 'ác cảm, bất mãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (941, '方案', 'fāng’àn', 'kế hoạch, phương án', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (943, '房东', 'fángdōng', 'chủ nhà', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (944, '方法', 'fāngfǎ', 'phương pháp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (945, '仿佛', 'fǎngfú', 'hình như, dường như', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (946, '房间', 'fángjiān', 'phòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (947, '方面', 'fāngmiàn', 'phương diện, mặt, phía', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (948, '放弃', 'fàngqì', 'vứt bỏ, từ bỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (949, '放射', 'fàngshè', 'phóng xạ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (950, '方式', 'fāngshì', 'phương thức, cách thức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (951, '防守', 'fángshǒu', 'phòng thủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (952, '放手', 'fàngshǒu', 'buông tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (953, '放松', 'fàngsōng', 'thả lỏng, thư giãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (955, '方向', 'fāngxiàng', 'phương hướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (958, '方言', 'fāngyán', 'tiếng địa phương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (959, '防疫', 'fángyì', 'phòng dịch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (960, '房屋', 'fángwū', 'phòng ở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (961, '方针', 'fāngzhēn', 'phương châm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (962, '防治', 'fángzhì', 'phòng chống, phòng và chữa trị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (963, '纺织', 'fǎngzhī', 'dệt vải', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (964, '繁华', 'fánhuá', 'phồn hoa, sầm uất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (965, '泛滥', 'fànlàn', 'tràn lan', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (966, '贩卖', 'fànmài', 'buôn bán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (967, '繁忙', 'fánmáng', 'bận rộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (969, '繁荣', 'fánróng', 'phồn vinh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (970, '凡是', 'fánshì', 'phàm là, hễ là', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (971, '繁体字', 'fántǐzì', 'chữ phồn thể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (972, '范围', 'fànwéi', 'phạm vi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (973, '翻译', 'fānyì', 'phiên dịch, dịch', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (974, '反正', 'fǎnzhèng', 'dù sao cũng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (975, '反之', 'fǎnzhī', 'trái lại, ngược lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (976, '发票', 'fāpiào', 'hóa đơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (977, '法人', 'fǎrén', 'pháp nhân', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (978, '发烧', 'fāshāo', 'phát sốt, sốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (979, '发生', 'fāshēng', 'xảy ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (982, '发扬', 'fāyáng', 'nêu cao, phát huy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (983, '发育', 'fāyù', 'trưởng thành, dậy thì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (984, '法院', 'fǎyuàn', 'tòa án', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (985, '发行', 'fāxíng', 'phát hành', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (986, '发现', 'fāxiàn', 'phát hiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (987, '发疯', 'fāfēng', 'phát điên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (988, '发展', 'fāzhǎn', 'phát triển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (989, '肺', 'fèi', 'phổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (990, '非', 'fēi', 'không, phi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (992, '非常', 'fēicháng', 'rất, đặc biệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (993, '废除', 'fèichú', 'bãi bỏ, huỷ bỏ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (994, '非法', 'fēifǎ', 'bất hợp pháp, phi pháp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (995, '费用', 'fèiyòng', 'chi phí', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (996, '飞机', 'fēijī', 'máy bay', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (998, '沸腾', 'fèiténg', 'sôi sùng sục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (999, '匪徒', 'fěitú', 'kẻ cướp, đạo tặc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1000, '肥沃', 'féiwò', 'phì nhiêu, màu mỡ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1001, '飞翔', 'fēixiáng', 'bay lượn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1002, '废墟', 'fèixū', 'đống hoang, đống đổ nát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1003, '飞跃', 'fēiyuè', 'nhảy vọt, vượt bậc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1004, '肥皂', 'féizào', 'xà bông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1007, '分布', 'fēnbù', 'phân bố, phân phát', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1018, '风暴', 'fēngbào', 'bão tố', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1048, '杠杆', 'gànggǎn', 'đòn bẩy', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1083, '高考', 'gāokǎo', 'thí vào trường đại học', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1021, '丰收', 'fēngshōu', 'được mùa', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1030, '分配', 'fēnpèi', 'phân phối', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1032, '粉碎', 'fěnsuì', 'vỡ nát, vỡ tan tành', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1035, '愤慨', 'fènkǎi', 'bất bình, phẫn nộ, nổi cáu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1038, '分明', 'fēnmíng', 'rõ ràng, phân minh', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1011, '愤怒', 'fènnù', 'căm phẫn, tức giận', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1046, '尴尬', 'gāngà', 'khó xử, lúng túng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1008, '分寸', 'fēncùn', 'chừng mực, có chừng mực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1009, '分担', 'fēndān', 'phân đầu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1010, '奋斗', 'fèndòu', 'cố gắng, dồn dập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1090, '个', 'gè', 'cái', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1013, '丰富', 'fēngfù', 'phong phú', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1014, '风景', 'fēngjǐng', 'phong cảnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1015, '风度', 'fēngdù', 'phong độ, phong cách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1016, '风光', 'fēngguāng', 'phong cảnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1017, '封建', 'fēngjiàn', 'phong kiến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1092, '割', 'gē', 'cắt, gặt', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1019, '风俗', 'fēngsú', 'phong tục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1020, '疯狂', 'fēngkuáng', 'điên cuồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1097, '疙瘩', 'gēda', 'mụn, mụn cám', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1023, '风气', 'fēngqì', 'bầu không khí, nếp sống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1024, '风趣', 'fēngqù', 'thú vị, dí dỏm', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1025, '封锁', 'fēngsuǒ', 'phong toả, bao vây, chặn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1026, '风土人情', 'fēngtǔ rénqíng', 'phong thổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1027, '风味', 'fēngwèi', 'hương vị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1028, '奉献', 'fèngxiàn', 'hiến dâng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1029, '风险', 'fēngxiǎn', 'rủi ro', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1099, '歌', 'gē', 'bài hát', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1031, '分歧', 'fēnqí', 'khác biệt, mâu thuẫn, bất đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1100, '革命', 'gémìng', 'cách mạng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1033, '粉末', 'fěnmò', 'bụi, bột', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1034, '粉笔', 'fěnbǐ', 'phấn viết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1101, '根', 'gēn', 'nguồn gốc, rễ cây', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1036, '分裂', 'fēnliè', 'phân tách', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1039, '分手', 'fēnshǒu', 'chia tay, ly biệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1040, '纷纷', 'fēnfēn', 'tấp nập, dồn dập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1041, '敢', 'gǎn', 'dám', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1042, '干活儿', 'gàn huó er', 'làm việc, lao động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1043, '干杯', 'gānbēi', 'cạn ly', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1044, '干脆', 'gāncuì', 'dứt khoát, thẳng thắn, thành thật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1045, '感动', 'gǎndòng', 'cảm động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1047, '刚', 'gāng', 'vừa, vừa mới', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1049, '刚刚', 'gānggāng', 'vừa mới', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1050, '刚强', 'gāngqiáng', 'cương linh, chính cương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1051, '港口', 'gǎngkǒu', 'hải cảng', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1052, '纲领', 'gānglǐng', 'cương lĩnh, chính cương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1053, '钢铁', 'gāngtiě', 'sắt thép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1054, '岗', 'gǎng', 'cảng, bến cảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1056, '干旱', 'gānhàn', 'khô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1057, '感激', 'gǎnjī', 'cảm kích, biết ơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1058, '赶紧', 'gǎnjǐn', 'vội vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1059, '干劲', 'gànjìn', 'lòng hăng hái, tinh thần hăng hái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1060, '干净', 'gānjìng', 'sạch sẽ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1061, '感觉', 'gǎnjué', 'cảm thấy, thấy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1062, '感慨', 'gǎnkǎi', 'xúc động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1063, '赶快', 'gǎnkuài', 'nhanh, mau lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1064, '感冒', 'gǎnmào', 'bị cảm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1065, '感情', 'gǎnqíng', 'tình cảm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1066, '感染', 'gǎnrǎn', 'lây, bị nhiễm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1067, '干扰', 'gānrǎo', 'can thiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1069, '感受', 'gǎnshòu', 'cảm nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1070, '感想', 'gǎnxiǎng', 'cảm tưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1071, '感谢', 'gǎnxiè', 'cảm tạ, bày tỏ lòng cảm ơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1072, '干预', 'gānyù', 'tham dự, tham gia, can dự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1073, '搞', 'gǎo', 'làm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1074, '高', 'gāo', 'cao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1075, '告别', 'gàobié', 'từ biệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1076, '高潮', 'gāocháo', 'cao trào, đỉnh điểm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1078, '高级', 'gāojí', 'cao cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1079, '高档', 'gāodàng', 'cao cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1080, '高峰', 'gāofēng', 'đỉnh cao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1081, '稿件', 'gǎojiàn', 'bài viết, bài vở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1082, '告诫', 'gàojiè', 'khuyên bảo, khuyên răn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1084, '高明', 'gāomíng', 'thông minh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1085, '高尚', 'gāoshàng', 'cao cả, cao thượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1086, '告诉', 'gàosù', 'báo, kể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1088, '高兴', 'gāoxìng', 'vui vẻ, vui mừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1089, '高涨', 'gāozhǎng', 'dâng cao, tăng vọt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1091, '各', 'gè', 'các, mỗi, tất cả', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1093, '搁', 'gē', 'đặt, để, kê', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1094, '隔壁', 'gébì', 'nhà bên cạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1095, '个别', 'gèbié', 'riêng biệt, cá biệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1096, '胳膊', 'gēbo', 'cánh tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1103, '跟', 'gēn', 'theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1104, '根本', 'gēnběn', 'căn bản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1105, '工程', 'gōngchéng', 'công trình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1106, '工程师', 'gōngchéngshī', 'kỹ sư', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1107, '更', 'gèng', 'hơn nữa, càng, thêm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1108, '耕地', 'gēngdì', 'cày ruộng, cày bừa', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1181, '管理', 'guǎnlǐ', 'quản lí', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1112, '跟前', 'gēnqián', 'cạnh, gần, bên cạnh', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1113, '根深蒂固', 'gēnshēndìgù', 'ăn sâu bén rễ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1122, '个性', 'gèxìng', 'tính cách, cá tính', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1124, '鸽子', 'gēzi', 'chim bồ câu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1173, '观点', 'guāndiǎn', 'chính thức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1193, '光彩', 'guāngcǎi', 'hào quang, màu sắc ánh sáng', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1111, '根据信', 'gēnjù', 'căn cứ', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1202, '光芒', 'guāngmáng', 'tia sáng, hào quang', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1206, '观光', 'guānguāng', 'tham quan', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1114, '根源', 'gēnyuán', 'căn nguyên, nguồn gốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1115, '跟踪', 'gēnzōng', 'theo dõi, bám theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1116, '个人', 'gèrén', 'cá nhân', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1117, '格式', 'géshì', 'cách thức, quy cách', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1119, '歌颂', 'gēsòng', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1120, '个体', 'gètǐ', 'cá thể, cá nhân, đơn lẻ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1121, '格外', 'géwài', 'đặc biệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1209, '关心', 'guānxīn', 'quan tâm', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1123, '个子', 'gèzi', 'dáng vóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1183, '关怀', 'guānhuái', 'chăm sóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1125, '供不应求', 'gōng bù yìng qiú', 'cung không đáp ứng được cầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1126, '公安局', 'gōng''ān jú', 'cục công an', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1127, '公布', 'gōngbù', 'thông báo, công bố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1128, '工厂', 'gōngchǎng', 'nhà máy', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1129, '公道', 'gōngdào', 'công lý, lẽ phải', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1130, '供电', 'gōngdiàn', 'cung điện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1131, '功夫', 'gōngfu', 'công sức, bản lĩnh, thời gian', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1133, '公告', 'gōnggào', 'thông báo, thông cáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1134, '公共汽车', 'gōnggòng qìchē', 'xe buýt', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1136, '共和国', 'gònghéguó', 'nước cộng hòa', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1137, '攻击', 'gōngjī', 'tấn công, tiến đánh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1138, '供给', 'gōngjǐ', 'cung cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1139, '恭敬', 'gōngjìng', 'tôn kính', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1140, '工具', 'gōngjù', 'công cụ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1141, '公开', 'gōngkāi', 'công khai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1142, '功课', 'gōngkè', 'bài tập về nhà', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1143, '攻克', 'gōngkè', 'tấn công, đánh chiếm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1144, '功劳', 'gōngláo', 'công lao, công trạng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1145, '公里', 'gōnglǐ', 'km', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1146, '公民', 'gōngmín', 'công dân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1148, '公平', 'gōngpíng', 'công bằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1149, '公婆', 'gōngpó', 'cha mẹ chồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1150, '公然', 'gōngrán', 'ngang nhiên, thẳng thắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1151, '工人', 'gōngrén', 'công nhân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1152, '公认', 'gōngrèn', 'công nhận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1153, '公司', 'gōngsī', 'công ty', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1154, '公诉', 'gōngsù', 'công tố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1155, '公务', 'gōngwù', 'công vụ, việc nước, việc công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1156, '功效', 'gōngxiào', 'công hiệu, công năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1157, '功勋', 'gōngxūn', 'công hiến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1159, '工业', 'gōngyè', 'công nghiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1160, '工艺品', 'gōngyìpǐn', 'đồ thủ công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1161, '公寓', 'gōngyù', 'chung cư', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1162, '公元', 'gōngyuán', 'công nguyên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1163, '公园', 'gōngyuán', 'công viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1164, '公正', 'gōngzhèng', 'công chính, công bằng, chính trực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1165, '公证', 'gōngzhèng', 'công chứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1166, '公主', 'gōngzhǔ', 'công chúa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1167, '工资', 'gōngzī', 'lương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1168, '工作', 'gōngzuò', 'làm việc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1169, '够', 'gòu', 'đủ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1170, '狗', 'gǒu', 'chó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1171, '构成', 'gòuchéng', 'hình thành, cấu thành', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1174, '沟通', 'gōutōng', 'khai thông, nối liền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1175, '购物', 'gòuwù', 'mua sắm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1176, '够了', 'gòule', 'đủ rồi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1177, '挂', 'guà', 'treo, móc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1178, '乖', 'guāi', 'ngoan', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1179, '挂号', 'guàhào', 'đăng ký, lấy số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1180, '拐', 'guǎi', 'rẽ, ngoặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1182, '观察', 'guānchá', 'quan sát, xem xét', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1185, '冠军', 'guànjūn', 'quán quân, chức vô địch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1186, '罐头', 'guàntóu', 'đồ hộp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1187, '管', 'guǎn', 'ống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1188, '贯彻', 'guànchè', 'quán triệt, thông suốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1189, '逛', 'guàng', 'đi dạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1190, '光', 'guāng', 'ánh sáng, nhẵn, sạch trơn, chỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1191, '灌溉', 'guàngài', 'tưới, dẫn nước tưới ruộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1192, '广播', 'guǎngbò', 'phát thanh, truyền hình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1194, '广场', 'guǎngchǎng', 'quảng trường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1195, '广大', 'guǎngdà', 'rộng lớn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1196, '广泛', 'guǎngfàn', 'rộng rãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1197, '广告', 'guǎnggào', 'quảng cáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1201, '光临', 'guānglín', 'sự hiện diện, ghé thăm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1203, '光明', 'guāngmíng', 'ánh sáng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1204, '光盘', 'guāngpán', 'CD', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1205, '光荣', 'guāngróng', 'quang vinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1207, '观念', 'guānniàn', 'quan niệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1208, '关系', 'guānxì', 'quan hệ, liên quan', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1210, '关于', 'guānyú', 'về', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1211, '观众', 'guānzhòng', 'khán giả, quần chúng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1255, '果断', 'guǒduàn', 'quả quyết, quả đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1231, '规格', 'guīgé', 'quy cách, kiểu mẫu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1232, '归根到底', 'guīgēndàodǐ', 'xét đến cùng, suy nghĩ cho cùng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1249, '过节', 'guòjié', 'qua, đón (tết)', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1294, '还是', 'háishi', 'vẫn, còn, hoặc hay', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1300, '喊', 'hǎn', 'kêu la', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1199, '光辉', 'guānghuī', 'chói lọi, rực rỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1213, '古代', 'gǔdài', 'thời cổ đại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1215, '古典', 'gǔdiǎn', 'cổ điển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1216, '固定', 'gùdìng', 'cố định', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1218, '股东', 'gǔdōng', 'cổ đông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1219, '股份', 'gǔfèn', 'cổ phần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1220, '鼓励', 'gǔlì', 'cổ vũ, khuyến khích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1221, '股市', 'gǔshì', 'thị trường chứng khoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1222, '骨干', 'gǔgàn', 'cốt cán, nòng cốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1223, '姑姑', 'gūgu', 'cô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1224, '古怪', 'gǔguài', 'kỳ quặc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1225, '贵', 'guì', 'đắt, quý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1226, '归', 'guī', 'quy, trở về', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1227, '规律', 'guīlǜ', 'quy luật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1228, '轨道', 'guǐdào', 'đường ray', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1229, '规定', 'guīdìng', 'quy định', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1233, '规划', 'guīhuà', 'kế hoạch, quy hoạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1234, '归还', 'guīhuán', 'trả về, trả lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1235, '规模', 'guīmó', 'quy mô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1236, '归纳', 'guīnà', 'quy nạp, tóm tắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1237, '柜台', 'guìtái', 'quầy hàng, tủ bày hàng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1238, '规则', 'guīzé', 'quy tắc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1239, '贵族', 'guìzú', 'quý tộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1241, '顾客', 'gùkè', 'khách hàng', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1242, '古老', 'gǔlǎo', 'cổ xưa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1243, '孤立', 'gūlì', 'cô lập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1244, '顾虑', 'gùlǜ', 'lo lắng, băn khoăn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1245, '滚', 'gǔn', 'lăn, lộn, cút xéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1246, '棍棒', 'gùnbàng', 'côn, gậy, gậy gộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1247, '姑娘', 'gūniang', 'cô gái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1248, '过', 'guò', 'qua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1250, '过期', 'guòqí', 'đã quá, trễ hạn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1251, '果汁', 'guǒzhī', 'nước hoa quả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1253, '过度', 'guòdù', 'quá độ, quá mức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1254, '过渡', 'guòdù', 'chuyển tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1256, '国防', 'guófáng', 'quốc phòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1257, '国籍', 'guójí', 'quốc tịch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1258, '国际', 'guójì', 'quốc tế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1259, '国家', 'guójiā', 'nhà nước, quốc gia', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1260, '国庆', 'guóqìng', 'quốc khánh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1261, '过滤', 'guòlǜ', 'lọc (bụi, nước...)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1262, '过敏', 'guòmǐn', 'dị ứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1264, '过分', 'guòfèn', 'quá đáng, quá mức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1265, '过奖', 'guòjiǎng', 'quá khen', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1266, '过错', 'guòcuò', 'sai lầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1267, '果然', 'guǒrán', 'quả nhiên, thật vậy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1268, '果实', 'guǒshí', 'trái cây', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1269, '国王', 'guówáng', 'hoàng đế, nhà vua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1270, '国务院', 'guówùyuàn', 'quốc vụ viện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1272, '过于', 'guòyú', 'quá chừng, quá đáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1273, '股票', 'gǔpiào', 'cổ phiếu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1276, '故事', 'gùshi', 'sự cố, tai nạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1277, '固体', 'gùtǐ', 'thể rắn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1278, '骨头', 'gǔtou', 'xương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1279, '顾问', 'gùwèn', 'cố vấn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1280, '鼓舞', 'gǔwǔ', 'cổ vũ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1281, '故乡', 'gùxiāng', 'quê nhà, quê hương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1282, '故意', 'gùyì', 'cố ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1283, '雇佣', 'gùyōng', 'thuê', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1285, '故障', 'gùzhàng', 'trục trặc, hỏng hóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1287, '哈', 'hā', 'ha', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1288, '还', 'hái', 'còn, vẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1289, '海', 'hǎi', 'biển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1290, '海拔', 'hǎibá', 'độ cao so với mặt nước biển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1291, '海滨', 'hǎibīn', 'miền biển, ven biển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1292, '海关', 'hǎiguān', 'hải quan', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1293, '害怕', 'hàipà', 'sợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1295, '海鲜', 'hǎixiān', 'hải sản', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1296, '害羞', 'hàixiū', 'xấu hổ, thẹn thùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1298, '孩子', 'háizi', 'trẻ em, trẻ con, em bé, con', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1299, '汗', 'hàn', 'mồ hôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1301, '航班', 'hángbān', 'chuyến bay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1302, '航空', 'hángkōng', 'hàng không', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1303, '航天', 'hángtiān', 'hàng không vũ trụ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1304, '航行', 'hángxíng', 'đi, vận chuyển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1305, '行业', 'hángyè', 'ngành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1306, '含糊', 'hánhu', 'mơ hồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1307, '寒假', 'hánjià', 'kì nghỉ đông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1309, '捍卫', 'hànwèi', 'bảo vệ, giữ gìn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1310, '汗水', 'hànxuè', 'hãn huyết, hơi han', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1311, '汉语', 'hànyǔ', 'tiếng Hán', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1312, '号', 'hào', 'số, cờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1313, '好', 'hǎo', 'tốt, hay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1314, '好吃', 'hǎochī', 'ngon', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1315, '号码', 'hàomǎ', 'số, dãy số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1316, '好处', 'hǎochu', 'điểm tốt, ưu điểm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1317, '耗费', 'hàofèi', 'tiêu hao, hao phí, hao mòn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1318, '豪华', 'háohuá', 'sang trọng, hao hoa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1319, '好客', 'hàokè', 'hiếu khách', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1320, '豪迈', 'háomài', 'khí phách hào hùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1336, '黑', 'hēi', 'màu đen', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1348, '狠心', 'hěnxīn', 'nhẫn tâm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1343, '很', 'hěn', 'vừa vặn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1355, '合影', 'héyǐng', 'chụp ảnh chung', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1366, '吼', 'hǒu', 'gào lên, gào to', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1367, '后代', 'hòudài', 'con cháu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1371, '后来', 'hòulái', 'sau, sau rồi', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1378, '画', 'huà', 'vẽ, họa, bức tranh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1383, '花粉', 'huāfěn', 'phấn hoa', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1390, '黄', 'huáng', 'màu vàng', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1324, '号召', 'hàozhào', 'hiệu triệu, kêu gọi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1325, '和', 'hé', 'và, với', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1326, '河', 'hé', 'sông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1327, '喝', 'hē', 'uống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1328, '合不来', 'hébùlái', 'hòa tắt, cãi, bất hợp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1329, '合并', 'hébìng', 'hợp lại, hợp nhất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1393, '皇后', 'huánghòu', 'hoàng hậu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1331, '合法', 'héfã', 'hợp pháp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1333, '合乎', 'héhū', 'phù hợp, hợp với', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1334, '合伙', 'héhuǒ', 'kết hội, chung vốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1335, '嘿', 'hēi', 'ối, ư, ô hay, ơ hay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1414, '话题', 'huàtí', 'chủ đề', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1337, '黑板', 'hēibǎn', 'bảng đen', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1338, '和解', 'héjiě', 'hòa giải', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1339, '何况', 'hékuàng', 'hơn nữa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1340, '合理', 'hélǐ', 'hợp lý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1341, '和睦', 'hémù', 'vui vẻ, hòa thuận', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1342, '恨', 'hèn', 'hận, ghét', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1420, '化妆', 'huàzhuāng', 'trang điểm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1345, '横', 'héng', 'ngang', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1346, '哼', 'hēng', 'rên rỉ, ngâm nga', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1347, '痕迹', 'hénjì', 'vết tích, dấu vết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1425, '挥', 'huī', 'vẫy', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1349, '和平', 'hépíng', 'hòa bình', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1350, '和气', 'héqì', 'ôn hòa, điềm đạm', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1351, '合适', 'héshì', 'phù hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1352, '合算', 'hésuàn', 'có lợi, hiệu quả, tính toán', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1353, '和谐', 'héxié', 'hài hòa, dịu dàng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1354, '核心', 'héxīn', 'trung tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1426, '灰', 'huī', 'màu xám', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1356, '盒子', 'hézi', 'cái hộp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1357, '合作', 'hézuò', 'hợp tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1358, '哄', 'hǒng', 'dỗ dành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1359, '洪水', 'hóngshuǐ', 'lũ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1360, '红', 'hóng', 'đỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1362, '轰动', 'hōngdòng', 'xôn xao, náo động, chấn động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1363, '宏观', 'hóngguān', 'vĩ mô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1364, '宏伟', 'hóngwěi', 'to lớn hào hùng, hùng vĩ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1365, '厚', 'hòu', 'dày', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1368, '后果', 'hòuguǒ', 'hậu quả', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1370, '后悔', 'hòuhuǐ', 'hối hận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1372, '喉咙', 'hóulóng', 'cổ họng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1373, '后面', 'hòumiàn', 'phía sau, mặt sau, đằng sau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1374, '后勤', 'hòuqín', 'hậu cần', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1375, '候选', 'hòuxuǎn', 'người được đề cử, người ứng cử', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1376, '猴子', 'hóuzi', 'con khỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1377, '壶', 'hú', 'bình, ấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1379, '花', 'huā', 'hoa, tiêu tiền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1381, '滑冰', 'huábīng', 'trượt băng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1382, '划船', 'huáchuán', 'chèo thuyền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1384, '坏', 'huài', 'xấu, hỏng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1385, '怀念', 'huáiniàn', 'hoài niệm, nhớ nhung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1386, '怀疑', 'huáiyí', 'hoài nghi, nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1387, '怀孕', 'huáiyùn', 'có thai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1388, '欢乐', 'huānlè', 'sự vui mừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1391, '皇帝', 'huángdì', 'hoàng đế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1392, '黄瓜', 'huángguā', 'dưa chuột', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1394, '黄昏', 'huánghūn', 'buổi chiều, hoàng hôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1395, '黄金', 'huángjīn', 'vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1396, '荒凉', 'huāngliáng', 'hoang vu, hoang vắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1397, '慌忙', 'huāngmáng', 'vội vàng, lật đật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1398, '荒谬', 'huāngmiù', 'sai lầm, vô lý, hoang đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1399, '恍然大悟', 'huǎngrándàwù', 'bỗng nhiên tỉnh ngộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1400, '荒唐', 'huāngtáng', 'hoang đường, vô lý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1402, '缓和', 'huǎnhé', 'xoa dịu, hòa hoãn', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1403, '环节', 'huánjié', 'mắt xích, phân đoạn, đốt, mấu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1404, '缓解', 'huǎnjiě', 'xoa dịu, làm dịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1405, '环境', 'huánjìng', 'môi trường, hoàn cảnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1406, '幻想', 'huànxiǎng', 'ảo tưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1407, '欢迎', 'huānyíng', 'đón chào, hoan nghênh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1408, '焕然一新', 'huànrányīxīn', 'trở về trạng thái cũ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1409, '患者', 'huànzhě', 'người bị bệnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1410, '华侨', 'huáqiáo', 'hoa kiều', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1411, '花生', 'huāshēng', 'củ lạc', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1413, '化石', 'huàshí', 'hóa thạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1415, '话筒', 'huàtǒng', 'microphone', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1416, '化学', 'huàxué', 'hóa học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1417, '华裔', 'huáyì', 'Hoa kiều', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1418, '华语', 'huáyǔ', 'tiếng Hoa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1419, '花园', 'huāyuán', 'hoa viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1421, '湖泊', 'húpō', 'ao hồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1422, '蝴蝶', 'húdié', 'bươm bướm, con bướm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1423, '回', 'huí', 'lần, về, quay lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1424, '会', 'huì', 'hội, họp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1427, '回报', 'huíbào', 'trả lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1435, '辉煌', 'huīhuáng', 'huy hoàng, rực rỡ, xán lạn', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1439, '回收', 'huíshōu', 'thu lại, thu hồi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1449, '婚姻', 'hūnyīn', 'hôn nhân', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1467, '活跃', 'huóyuè', 'sôi nổi, hoạt bát', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1490, '家伙', 'jiāhuo', 'thằng cha, lão', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1526, '郊游', 'jiāoyóu', 'dã ngoại, du ngoạn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1529, '教学', 'jiàoxué', 'giảng dạy', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1537, '缴纳', 'jiǎonà', 'nộp (thuế, phí)', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1546, '教员', 'jiàoyuán', 'giáo viên, giảng viên', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1548, '接', 'jiē', 'tiếp, nhận, nối', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1429, '回避', 'huíbì', 'né tránh, trốn tránh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1430, '灰尘', 'huīchén', 'bụi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1431, '回答', 'huídá', 'trả lời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1432, '恢复', 'huīfù', 'khôi phục, phục hồi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1434, '悔恨', 'huǐhèn', 'hối hận, hối lỗi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1436, '挥霍', 'huīhuò', 'phung phí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1437, '毁灭', 'huǐmiè', 'tiêu diệt, hủy diệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1438, '汇率', 'huìlǜ', 'tỷ giá', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1440, '会晤', 'huìwù', 'gặp gỡ, gặp mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1441, '灰心', 'huīxīn', 'nản lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1442, '回忆', 'huíyì', 'hồi ức, nhớ lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1443, '会议', 'huìyì', 'hội nghị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1445, '喇叭', 'hǔlǎba', 'loa, qua quýt, tùy tiện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1446, '忽略', 'hūlüè', 'bỏ qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1447, '婚礼', 'hūnlǐ', 'hôn lễ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1448, '混乱', 'hùnluàn', 'hỗn loạn, lẫn lộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1450, '混合', 'hùnhé', 'hỗn hợp, trộn, nhào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1452, '昏迷', 'hūnmí', 'hôn mê, mê man', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1453, '混淆', 'hūnxiáo', 'lộn xộn, xáo trộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1454, '浑浊', 'hūnzhúo', 'vẩn đục', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1455, '伙伴', 'huǒbàn', 'đối tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1456, '货币', 'huòbì', 'tiền tệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1457, '火柴', 'huǒchái', 'diêm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1458, '火车站', 'huǒchē zhàn', 'ga tàu', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1459, '获得', 'huòdé', 'giành được, đạt được', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1460, '活动', 'huódòng', 'hoạt động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1461, '活该', 'huógāi', 'đáng đời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1463, '活力', 'huólì', 'sức sống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1464, '活泼', 'huópō', 'hoạt bát, nhanh nhẹn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1465, '或', 'huò', 'hoặc', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1466, '火药', 'huǒyào', 'thuốc súng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1468, '忽然', 'hūrán', 'đột nhiên, chợt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1469, '护士', 'hùshi', 'y tá', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1470, '胡说', 'húshuō', 'nói nhảm, tào lao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1471, '胡同', 'hútòng', 'ngõ, hẻm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1472, '呼吸', 'hūxī', 'hô hấp, hít thở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1475, '呼喊', 'hūhǎn', 'hô hào, kêu gọi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1476, '护照', 'hùzhào', 'hộ chiếu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1477, '极', 'jí', 'rất, hết, cực', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1479, '机', 'jī', 'máy, vải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1480, '家', 'jiā', 'gia, lấy chồng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1481, '家庭', 'jiātíng', 'gia đình, nhà', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1482, '假', 'jiǎ', 'giả, giả định, giả như', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1483, '价', 'jià', 'giá, giá cả', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1485, '加班', 'jiābān', 'tăng ca', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1486, '嘉宾', 'jiābīn', 'khách', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1488, '价格', 'jiàgé', 'giá cả', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1489, '加工', 'jiāgōng', 'gia công, chế biến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1491, '加剧', 'jiājù', 'trầm trọng thêm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1492, '家具', 'jiājù', 'gia cụ, đồ dùng trong nhà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1493, '件', 'jiàn', 'chiếc, cái, kiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1494, '简单', 'jiǎndān', 'đơn giản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1495, '拣', 'jiǎn', 'lựa chọn, nhặt lấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1496, '煎', 'jiān', 'rán, chiên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1497, '间', 'jiān', 'giữa, trong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1498, '建立', 'jiànlì', 'thiết lập', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1499, '监督', 'jiāndū', 'giám sát, đôn thúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1501, '坚决', 'jiānjué', 'kiên quyết, dứt khoát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1502, '建设', 'jiànshè', 'xây dựng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1503, '坚持', 'jiānchí', 'kiên trì, vững chắc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1504, '剪刀', 'jiǎndāo', 'kéo, cái kéo', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1505, '减少', 'jiǎnshǎo', 'giảm bớt, giảm thiểu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1506, '检查', 'jiǎnchá', 'kiểm tra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1507, '简历', 'jiǎnlì', 'sơ yếu lý lịch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1508, '检讨', 'jiǎntǎo', 'thảo luận, tự kiểm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1509, '简直', 'jiǎnzhí', 'quả thực, thật là', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1511, '剪', 'jiǎn', 'cắt, xén', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1513, '尖锐', 'jiānruì', 'sắc bén, gay gắt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1514, '健康', 'jiànkāng', 'khỏe mạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1515, '讲', 'jiǎng', 'nói, kể, giảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1516, '降低', 'jiàngdī', 'hạ thấp, giảm bớt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1517, '奖金', 'jiǎngjīn', 'tiền thưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1518, '将来', 'jiānglái', 'tương lai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1519, '奖励', 'jiǎnglì', 'khen thưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1520, '奖', 'jiǎng', 'thưởng, giải thưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1521, '降', 'jiàng', 'hạ xuống, rơi xuống', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1522, '讲座', 'jiǎngzuò', 'tọa đàm, báo cáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1527, '教师', 'jiàoshī', 'giáo viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1528, '教堂', 'jiàotáng', 'nhà thờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1536, '搅拌', 'jiǎobàn', 'khuấy, trộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1540, '饺', 'jiǎo', 'bánh chẻo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1549, '街道', 'jiēdào', 'đường phố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1550, '节', 'jié', 'tiết, đốt, khúc, phần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1551, '监视', 'jiānshì', 'giám thị, theo dõi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1554, '间歇字', 'jiànxīzì', 'chữ gián thệ', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1535, '骄傲', 'jiāo’ào', 'kiêu ngạo, tự hào', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1524, '交', 'jiāo', 'giao, nộp, kết giao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1633, '节奏', 'jiézòu', 'nhịp điệu, tiết tấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1541, '教', 'jiào', 'dạy', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1573, '娇气', 'jiāoqì', 'duyên dáng, thanh nhã', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1562, '监狱', 'jiānyù', 'nhà tù, nhà giam', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1630, '介质', 'jièzhì', 'chất trung gian', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1581, '加油站', 'jiāyóuzhàn', 'trạm xăng', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1604, '界限', 'jièxiàn', 'ranh giới', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1523, '交流', 'jiāoliú', 'giao lưu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1615, '姐姐', 'jiějie', 'chị gái', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1525, '郊区', 'jiāoqū', 'ngoại ô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1530, '教育', 'jiàoyù', 'giáo dục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1531, '交换', 'jiāohuàn', 'trao đổi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1620, '介绍', 'jièshào', 'giới thiệu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1625, '解释', 'jiěshì', 'giải thích', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1538, '角', 'jiǎo', 'sừng, góc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1539, '脚', 'jiǎo', 'chân', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1627, '截止', 'jiézhǐ', 'kết thúc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1634, '激发', 'jīfā', 'kích thích', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1543, '教练', 'jiàoliàn', 'huấn luyện viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1544, '教授', 'jiàoshòu', 'giáo sư', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1545, '教室', 'jiàoshì', 'lớp, phòng học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1547, '叫', 'jiào', 'gọi, kêu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1553, '舰艇', 'jiàntǐng', 'chiến hạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1637, '机构', 'jīgòu', 'cơ cấu, đơn vị, cơ quan', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1555, '见闻', 'jiànwén', 'hiểu biết, sự từng trải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1556, '检验', 'jiǎnyàn', 'kiểm nghiệm, kiểm tra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1557, '减弱', 'jiǎnruò', 'giảm dần, kém yếu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1558, '建议', 'jiànyì', 'đề xuất, kiến nghị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1559, '坚硬', 'jiānyìng', 'cứng, chắc, rắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1560, '兼而又为勇为', 'jiānyǒngwéi', 'giám làm việc nghĩa', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1561, '鉴于', 'jiànyú', 'thấy rằng, xét thấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1639, '机关', 'jīguān', 'cơ quan', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1564, '坚执', 'jiānzhí', 'kiên chấp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1565, '浇', 'jiāo', 'tưới, đổ, dội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1566, '交叉', 'jiāochā', 'đan xen, đan chéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1567, '交际', 'jiāojì', 'giao tế, giao tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1568, '教会', 'jiàohuì', 'giáo hội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1569, '角度', 'jiǎodù', 'góc, góc độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1570, '焦虑', 'jiāolǜ', 'lo lắng, nôn nóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1571, '角落', 'jiǎoluò', 'góc xó xỉnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1572, '交纳', 'jiāonà', 'nộp, giao nộp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1641, '几乎', 'jīhū', 'hầu như, cơ hồ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1575, '胶水', 'jiāoshuǐ', 'keo nước, hồ dán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1576, '交通', 'jiāotōng', 'giao thông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1577, '假如', 'jiǎrú', 'nếu như', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1578, '假设', 'jiǎshè', 'giả thuyết', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1579, '家属', 'jiāshǔ', 'người nhà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1580, '家务', 'jiāwù', 'việc nhà', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1542, '教材', 'jiàocái', 'tài liệu giảng dạy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1582, '佳肴', 'jiāyáo', 'món ăn ngon', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1583, '家喻户晓', 'jiāyùhùxiǎo', 'nhà nhà đều biết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1584, '假装', 'jiǎzhuāng', 'giả vờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1585, '价值', 'jiàzhí', 'giá trị', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1586, '架子', 'jiàzi', 'cái kệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1587, '嫉妒', 'jídù', 'đố kỵ, ganh ghét', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1588, '级别', 'jíbié', 'trình độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1590, '机场', 'jīchǎng', 'sân bay', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1591, '继承', 'jìchéng', 'kế thừa, kế tục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1592, '基础', 'jīchǔ', 'cơ sở, nền tảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1593, '鸡蛋', 'jīdàn', 'trứng gà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1594, '记得', 'jìde', 'nhớ, nhớ được', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1595, '基地', 'jīdì', 'căn cứ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1597, '季度', 'jìdù', 'quý, 3 tháng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1598, '极端', 'jíduān', 'cực đoan', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1599, '即', 'jí', 'tức, liền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1600, '截', 'jié', 'đoạn, khúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1601, '皆', 'jiē', 'đều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1602, '结', 'jié', 'kết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1605, '解放', 'jiěfàng', 'giải phóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1606, '结构', 'jiégòu', 'kết cấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1607, '结果', 'jiéguǒ', 'kết quả', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1608, '结合', 'jiéhé', 'kết hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1609, '借鉴', 'jièjiàn', 'rút kinh nghiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1610, '接近', 'jiējìn', 'tiếp cận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1612, '结晶', 'jiéjīng', 'kết tinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1613, '结局', 'jiéjú', 'kết cục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1614, '解决', 'jiějué', 'giải quyết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1616, '接连', 'jiēlián', 'liên tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1617, '结论', 'jiélùn', 'kết luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1618, '节目', 'jiémù', 'tiết mục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1619, '介入', 'jièrù', 'xen vào, tham dự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1621, '节省', 'jiéshěng', 'tiết kiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1622, '结束', 'jiéshù', 'kết thúc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1624, '结算', 'jiésuàn', 'thanh toán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1626, '接触', 'jiēchù', 'tiếp xúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1628, '节约', 'jiéyuē', 'tiết kiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1629, '接着', 'jiēzhe', 'tiếp theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1631, '戒指', 'jièzhǐ', 'nhẫn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1635, '及格', 'jígé', 'hợp cách, đạt tiêu chuẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1636, '机关前进', 'jīgōngjìnlǐ', 'vi cãi trước mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1638, '籍贯', 'jíguàn', 'quê quán', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1640, '集合', 'jíhé', 'tập hợp, tập trung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1713, '今天', 'jīntiān', 'hôm nay', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1649, '纪律', 'jìlǜ', 'kỷ luật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1698, '精细', 'jīngxì', 'tỉ mỉ', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1664, '进步', 'jìnbù', 'tiến bộ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1685, '精英', 'jīngyīng', 'tinh anh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1673, '警察', 'jǐngchá', 'cảnh sát', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1724, '集体', 'jítǐ', 'tập thể', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1660, '紧密', 'jǐnmì', 'chặt chẽ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1672, '精彩', 'jīngcǎi', 'tuyệt vời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1687, '经商', 'jīngshāng', 'kinh doanh', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1681, '精神', 'jīngshén', 'tinh thần', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1677, '精确', 'jīngquè', 'chính xác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1645, '即将', 'jíjiāng', 'sắp tới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1646, '积极', 'jījí', 'tích cực, hăng hái', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1647, '计较', 'jìjiào', 'so bì, tính toán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1648, '季节', 'jìjié', 'mùa, mùa khí hậu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1650, '纪念', 'jìniàn', 'kỷ niệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1651, '急忙', 'jímáng', 'vội vã, hấp tấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1652, '纪实', 'jìshí', 'ký sự', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1653, '及时', 'jíshí', 'kịp thời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1654, '积蓄', 'jīxù', 'tích lũy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1656, '激烈', 'jīliè', 'mãnh liệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1657, '机灵', 'jīlíng', 'thông minh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1658, '记录', 'jìlù', 'ghi chép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1659, '激忙', 'jīmáng', 'vội vàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1735, '久', 'jiǔ', 'lâu, lâu đời', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1661, '进行', 'jìnxíng', 'tiến hành', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1662, '进', 'jìn', 'tiến, vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1663, '紧', 'jǐn', 'chặt', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1738, '纠纷', 'jiūfēn', 'tranh chấp, bất hòa', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1666, '技能', 'jìnéng', 'kỹ năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1667, '进而', 'jìn''ér', 'tiến tới, triển khai kế tiếp', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1668, '井', 'jǐng', 'giếng, hầm, lò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1669, '静', 'jìng', 'thản cây', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1670, '敬业乐业', 'jìng yè yè', 'cẩn trọng, cẩn thận, cần cù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1671, '敬爱', 'jìng''ài', 'kính yêu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1739, '救护车', 'jiùhùchē', 'xe cứu hộ', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1741, '就近', 'jiùjìn', 'lân cận, vùng phụ cận', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1675, '精诚', 'jīngchéng', 'thành thật', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1676, '精湛', 'jīngzhàn', 'tinh tế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1743, '酒精', 'jiǔjīng', 'cồn, rượu cồn', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1678, '景象', 'jǐngxiàng', 'cảnh tượng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1679, '警告', 'jǐnggào', 'cảnh cáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1680, '经过', 'jīngguò', 'quá trình, qua, đi qua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1750, '迹象', 'jìxiàng', 'dấu hiệu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1682, '精力', 'jīnglì', 'tinh lực, sức lực', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1683, '经济', 'jīngjì', 'kinh tế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1684, '经验', 'jīngyàn', 'kinh nghiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1723, '记忆', 'jìyì', 'trí nhớ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1686, '景色', 'jǐngsè', 'phong cảnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1690, '经济学', 'jīngjìxué', 'kinh tế học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1691, '经理', 'jīnglǐ', 'giám đốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1692, '竟然', 'jìngrán', 'mà, lại, vậy mà', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1693, '精美', 'jīngměi', 'tinh xảo, đẹp đẽ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1694, '进攻', 'jìngōng', 'tấn công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1695, '惊奇', 'jīngqí', 'kinh ngạc, lấy làm lạ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1696, '竞赛', 'jìngsài', 'cuộc thi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1697, '精通', 'jīngtōng', 'tinh thông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1699, '经管', 'jīngguǎn', 'cai quản', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1701, '进口', 'jìnkǒu', 'nhập khẩu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1702, '进取', 'jìnqǔ', 'cầu tiến', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1703, '进入', 'jìnrù', 'tiến vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1704, '近来', 'jìnlái', 'gần đây', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1705, '尽力', 'jìnlì', 'hết sức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1706, '尽量', 'jǐnliàng', 'tận lực', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1707, '浸泡', 'jìnpào', 'ngâm, nhúng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1708, '紧迫', 'jǐnpò', 'cấp bách', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1710, '谨慎', 'jǐnshèn', 'cẩn thận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1711, '晋升', 'jìnshēng', 'thăng tiến', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1712, '金属', 'jīnshǔ', 'kim loại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1714, '劲头', 'jìntóu', 'sức mạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1715, '锦绣前程', 'jǐnxiù qiánchéng', 'tương lai tươi sáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1716, '进展', 'jìnzhǎn', 'tiến triển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1717, '紧张', 'jǐnzhāng', 'căng thẳng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1718, '禁止', 'jìnzhǐ', 'cấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1719, '机器', 'jīqì', 'máy móc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1720, '极其', 'jíqí', 'cực kỳ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1722, '紧急', 'jǐnjí', 'cấp thiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1726, '计算', 'jìsuàn', 'tính toán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1728, '技术', 'jìshù', 'kỹ thuật', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1729, '继续', 'jìxù', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1730, '即使', 'jíshǐ', 'cho dù', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1732, '寂寞', 'jìmò', 'cô đơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1733, '救', 'jiù', 'cứu', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1734, '旧', 'jiù', 'cũ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1736, '九', 'jiǔ', 'chín', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1737, '酒吧', 'jiǔbā', 'quán bar', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1742, '究竟', 'jiūjìng', 'rốt cuộc, cuối cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1744, '就业', 'jiùyè', 'có công ăn việc làm, đi làm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1745, '纠正', 'jiūzhèng', 'uốn nắn, sửa chữa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1746, '就职', 'jiùzhí', 'nhận chức, nhậm chức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1748, '极限', 'jíxiàn', 'cao nhất, cực độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1749, '吉祥', 'jíxiáng', 'may mắn, cát tường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1751, '讥笑', 'jīxiào', 'châm biếm, nhạo báng, chế giễu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1752, '机械', 'jīxiè', 'máy móc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1753, '纪要', 'jìyào', 'kỷ yếu, tóm tắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1854, '课题', 'kètí', 'đề tài', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1727, '记者', 'jìzhě', 'nhà báo', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1837, '刻', 'kè', '“khắc” = 15 phút', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1761, '举', 'jǔ', 'nâng, nhấc, giơ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1762, '俱乐部', 'jù lè bù', 'câu lạc bộ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1780, '鞠躬', 'jūgōng', 'cúi chào, cúi đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1788, '军事', 'jūnshì', 'quân sự', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1789, '均匀', 'jūnyún', 'đều, dàn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1794, '据说', 'jùshuō', 'nghe nói', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1800, '卡车', 'kǎchē', 'xe tải', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1803, '开除', 'kāichú', 'khai trừ, đuổi', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1754, '给予', 'jǐyǔ', 'dành cho, cho', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1755, '基于', 'jīyú', 'dựa trên, căn cứ vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1757, '记载', 'jìzǎi', 'ghi lại, ghi chép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1758, '急躁', 'jízào', 'nóng vội, hấp tấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1759, '及早', 'jízǎo', 'sớm, kịp thời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1760, '机智', 'jīzhì', 'lanh trí, tinh nhanh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1827, '考察', 'kǎochá', 'khảo sát, quan sát', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1828, '考古学', 'kǎogǔxué', 'khảo cổ học', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1763, '捐', 'juān', 'tặng, quyên góp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1764, '举办', 'jǔbàn', 'tổ chức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1765, '具备', 'jùbèi', 'có đủ, có sẵn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1766, '剧本', 'jùběn', 'kịch bản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1767, '局部', 'júbù', 'cục bộ, bộ phận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1768, '举动', 'jǔdòng', 'hành động, động tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1769, '决定', 'juédìng', 'quyết định', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1770, '绝对', 'juéduì', 'tuyệt đối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1771, '决断', 'juéduàn', 'quyết đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1772, '觉察', 'juéchá', 'phát giác', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1774, '角色', 'juésè', 'vai (vai trò)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1775, '绝望', 'juéwàng', 'tuyệt vọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1776, '觉醒', 'juéxǐng', 'tỉnh ngộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1777, '决议', 'juéyì', 'nghị quyết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1778, '绝缘', 'juéyuán', 'cách ly, cách điện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1779, '拒绝', 'jùjué', 'từ chối, cự tuyệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1841, '客气', 'kèqi', 'khách sáo', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1781, '剧情', 'jùqíng', 'tình tiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1782, '聚精会神', 'jùjīnghuìshén', 'tập trung tinh thần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1783, '拘谨', 'jūjǐn', 'nhút nhát, dè dặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1784, '拘留', 'jūliú', 'tạm giam, tạm giữ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1785, '距离', 'jùlí', 'khoảng cách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1786, '剧烈', 'jùliè', 'mãnh liệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1857, '栭', 'kě', 'cây, ngọn', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1790, '居然', 'jūrán', 'lại, vậy mà', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1791, '局势', 'júshì', 'thế cục, tình hình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1792, '举世闻名', 'jǔshì wénmíng', 'nổi tiếng thế giới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1848, '颗', 'kē', 'hạt, hòn, viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1795, '据悉', 'jùxī', 'được biết', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1796, '局限', 'júxiàn', 'hạn chế, giới hạn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1797, '举行', 'jǔxíng', 'tổ chức, cử hành', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1798, '居住', 'jūzhù', 'cư trú, sinh sống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1799, '举足轻重', 'jǔzú qīngzhòng', 'có ảnh hưởng quyết định', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1801, '咖啡', 'kāfēi', 'cà phê', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1802, '开', 'kāi', 'mở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1804, '开发', 'kāifā', 'khai phá, mở mang', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1805, '开放', 'kāifàng', 'mở cửa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1806, '开朗', 'kāilǎng', 'rộng rãi, thoáng mát, sáng sủa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1807, '开幕式', 'kāimù shì', 'lễ khai mạc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1808, '开辟', 'kāipì', 'mở, khai phá, khai thác', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1809, '开始', 'kāishǐ', 'bắt đầu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1810, '开玩笑', 'kāiwánxiào', 'đùa, giỡn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1811, '开心', 'kāixīn', 'vui vẻ, hạnh phúc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1812, '开展', 'kāizhǎn', 'triển khai, mở rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1813, '开支', 'kāizhī', 'chi tiêu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1814, '看', 'kàn', 'nhìn, xem', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1816, '看来', 'kànlái', 'xem ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1817, '看不起', 'kànbuqǐ', 'coi thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1818, '刊登', 'kāndēng', 'đăng, xuất bản', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1819, '看法', 'kànfǎ', 'quan điểm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1820, '扛', 'káng', 'gánh, vác', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1822, '慷慨激昂', 'kāngkǎi jī’áng', 'khảng khái, hùng hồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1823, '看见', 'kànjiàn', 'nhìn thấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1824, '勘探', 'kāntàn', 'khảo sát, trinh sát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1825, '看望', 'kànwàng', 'vấn an, thăm hỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1826, '刊物', 'kānwù', 'sách báo, ấn phẩm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1829, '考虑', 'kǎolǜ', 'suy nghĩ, cân nhắc', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1830, '考试', 'kǎoshì', 'thi cử', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1831, '烤鸭', 'kǎoyā', 'vịt nướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1832, '考验', 'kǎoyàn', 'khảo nghiệm, thử thách', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1833, '卡通', 'kǎtōng', 'hoạt hình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1834, '克', 'kè', 'gram', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1835, '渴', 'kě', 'khát', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1836, '课', 'kè', 'môn, bài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1838, '客', 'kè', 'khách', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1849, '刻苦', 'kèkǔ', 'chịu khó, cần cù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1850, '殼（壳）', 'ké', 'vỏ (vật)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1851, '咳嗽', 'késou', 'ho', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1852, '坷垃', 'kělā', 'đất vón cục (nếu có)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1853, '恪守', 'kèshǒu', 'tuân thủ nghiêm (nếu có)', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1858, '磕', 'kē', 'gõ, đập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1859, '可爱', 'kě’ài', 'đáng yêu, dễ thương', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1860, '刻不容缓', 'kèbùrónghuǎn', 'cấp bách, vô cùng khẩn cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1843, '可靠', 'kěkào', 'đáng tin cậy', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1881, '口气', 'kǒuqì', 'khẩu khí, giọng nói', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1902, '拦', 'lán', 'ngăn cản, chặn', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1909, '老', 'lǎo', 'già', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1937, '栏目', 'lánmù', 'chuyên mục', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1951, '累', 'lèi', 'mệt', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1960, '礼拜', 'lǐbài', 'lễ, tuần lễ', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1844, '可口', 'kěkǒu', 'ngon miệng, vừa miệng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1845, '可能', 'kěnéng', 'có thể, có lẽ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1846, '可怕', 'kěpà', 'đáng sợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1847, '可怜', 'kělián', 'đáng thương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1861, '克服', 'kèfú', 'vượt qua, khắc phục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1862, '客户', 'kèhù', 'khách hàng', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1864, '科目', 'kēmù', 'khoa, môn, môn học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1865, '肯', 'kěn', 'gặm, ria', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1866, '肯定', 'kěndìng', 'khẳng định', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1867, '坑', 'kēng', 'hố, lỗ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1868, '恳切', 'kěnqiè', 'tha thiết, khẩn thiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1869, '客人', 'kèrén', 'khách', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1870, '可惜', 'kěxī', 'đáng tiếc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1872, '科学', 'kēxué', 'khoa học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1873, '可以', 'kěyǐ', 'có thể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1874, '孔', 'kǒng', 'lỗ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1875, '恐怕', 'kǒngpà', 'e rằng, sợ rằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1876, '恐怖', 'kǒngbù', 'khủng bố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1877, '控制', 'kòngzhì', 'kiểm soát, khống chế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1878, '空', 'kōng', 'rỗng, trống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1879, '空气', 'kōngqì', 'không khí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1880, '口', 'kǒu', 'miệng, khẩu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1882, '口语', 'kǒuyǔ', 'khẩu ngữ, tiếng nói', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1883, '哭', 'kū', 'khóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1884, '苦', 'kǔ', 'khổ, đắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1886, '跨', 'kuà', 'bước dài, xoài bước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1887, '快', 'kuài', 'nhanh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1888, '快乐', 'kuàilè', 'vui vẻ, sung sướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1889, '筷子', 'kuàizi', 'đũa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1890, '宽', 'kuān', 'rộng, khoan dung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1891, '款待', 'kuǎndài', 'khoản đãi, chiêu đãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1892, '框架', 'kuàngjià', 'khung, sườn, dàn giáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1893, '矿泉水', 'kuàngquánshuǐ', 'nước khoáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1894, '况且', 'kuàngqiě', 'vả lại, hơn nữa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1896, '困难', 'kùnnán', 'khó khăn, trở ngại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1897, '扩大', 'kuòdà', 'mở rộng, khuếch trương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1898, '扩充', 'kuòchōng', 'khuếch tán, lan rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1899, '扩展', 'kuòzhǎn', 'phát triển, mở rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1900, '拉', 'lā', 'kéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1901, '辣椒', 'làjiāo', 'ớt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1903, '蓝', 'lán', 'xanh lam', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1904, '烂', 'làn', 'nát, thối rữa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1905, '懒', 'lǎn', 'lười biếng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1906, '狼', 'láng', 'chó sói', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1907, '浪费', 'làngfèi', 'lãng phí', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1908, '浪漫', 'làngmàn', 'lãng mạn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1911, '老百姓', 'lǎobǎixìng', 'dân thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1912, '老师', 'lǎoshī', 'giáo viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1913, '老鼠', 'lǎoshǔ', 'chuột', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1914, '宽敞', 'kuānchǎng', 'rộng lớn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1915, '宽带', 'kuāndài', 'băng thông rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1916, '潰', 'kuì', 'hủy hoại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1917, '苦恼', 'kǔnǎo', 'đau khổ, khổ não', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1918, '苦涩', 'kǔsè', 'đắng chát', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1920, '库', 'kù', 'kho', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1921, '裤子', 'kùzi', 'quần', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1922, '块', 'kuài', 'miếng, viên, bánh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1923, '捆', 'kǔn', 'bó, buộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1924, '捆绑', 'kǔnbǎng', 'trói, buộc, ràng buộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1925, '困虫', 'kùnchóng', 'côn trùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1926, '扩', 'kuò', 'mở rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1927, '扩张', 'kuòzhāng', 'mở rộng, bành trướng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1928, '来', 'lái', 'đến, tới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1929, '来不及', 'láibùjí', 'không kịp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1930, '来得及', 'láidéjí', 'kịp thời', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1931, '来历', 'láilì', 'lai lịch, nguồn gốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1932, '来源', 'láiyuán', 'nguồn gốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1933, '来自', 'láizì', 'đến từ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1935, '狼狈', 'lángbèi', 'nhếch nhác, chẳng ra làm sao cả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1936, '朗读', 'lǎngdú', 'đọc to, đọc diễn cảm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1938, '劳动', 'láodòng', 'lao động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1939, '老虎', 'lǎohǔ', 'con hổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1940, '老实', 'lǎoshí', 'thật thà', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1941, '老婆', 'lǎopó', 'vợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1943, '老婆心', 'lǎopoxīn', 'lòng nhân từ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1944, '老人', 'lǎorén', 'người già', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1945, '蜡烛', 'làzhú', 'cây nến, nến', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1946, '勒', 'lēi', 'buộc, trói', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1947, '了', 'le', 'rồi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1948, '乐观', 'lèguān', 'lạc quan', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1949, '雷', 'léi', 'sấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1950, '类', 'lèi', 'loại, thể loại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1952, '雷达', 'léidá', 'radar', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1953, '类似', 'lèisì', 'na ná, tương tự, giống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1954, '冷', 'lěng', 'lạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1955, '冷淡', 'lěngdàn', 'lạnh nhạt, lãnh đạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1956, '冷静', 'lěngjìng', 'vắng vẻ, yên tĩnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1958, '里', 'lǐ', 'trong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1959, '里边', 'lǐbiān', 'bên trong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1961, '礼节', 'lǐjié', 'lễ nghi, phép lịch sự', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1962, '礼貌', 'lǐmào', 'lễ phép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1981, '体谅', 'tǐliàn', 'rèn luyện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2031, '理智', 'lǐzhì', 'lý trí', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1979, '连年', 'liánnián', 'liên tục nhiều năm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2008, '立体', 'lìtǐ', 'lập thể', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1963, '礼物', 'lǐwù', 'quà, lễ vật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2052, '论文', 'lùnwén', 'luận văn', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2055, '落后', 'luòhòu', 'lạc hậu, rơi lại phía sau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2057, '落实', 'luòshí', 'đầy đủ chu đáo, làm cho chắc chắn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1964, '礼堂', 'lǐtáng', 'lễ đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1965, '立场', 'lìchǎng', 'lập trường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1966, '立方', 'lìfāng', 'hình lập phương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1967, '利害', 'lìhài', 'lợi hại, ghê gớm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1968, '立即', 'lìjí', 'ngay lập tức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1969, '利益', 'lìyì', 'lợi ích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1971, '立刻', 'lìkè', 'ngay lập tức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1972, '粮食', 'liángshi', 'thức ăn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1973, '良心', 'liángxīn', 'lương tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1974, '联合', 'liánhé', 'liên hiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1975, '联欢', 'liánhuān', 'liên hoan', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1976, '廉洁', 'liánjié', 'trong sạch, liêm khiết', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1977, '联系', 'liánluò', 'liên lạc, liên hệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1978, '联盟', 'liánméng', 'liên minh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1980, '连锁', 'liánsuǒ', 'dây chuyền, móc nối', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1982, '领会', 'liǎngkuai', 'mát mẻ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1984, '连系', 'liánxì', 'liên hệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1985, '练习', 'liànxí', 'luyện tập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1986, '练功', 'liàngtóng', 'luyện công, rèn luyện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1987, '连续剧', 'liánxùjù', 'phim nhiều tập', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1988, '了解', 'liǎojiě', 'hiểu rõ, biết rõ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1989, '了不起', 'liǎobuqǐ', 'tài ba, giỏi lắm', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1991, '料', 'liào', 'nguyên liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1992, '料理', 'liàolǐ', 'nấu ăn, quản lý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1993, '列车', 'lièchē', 'xe lửa, tàu hỏa', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1994, '烈士', 'lièshì', 'liệt sĩ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1996, '烈焰', 'lièyàn', 'ngọn lửa dữ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1997, '力气', 'lìqi', 'sức lực', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1998, '领域', 'lǐngyù', 'lĩnh vực', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1999, '邻居', 'línjū', 'hàng xóm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2000, '淋浴', 'línyù', 'tắm vòi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2001, '临时', 'línshí', 'tạm thời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2003, '例如', 'lìrú', 'ví dụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2004, '利润', 'lìrùn', 'lợi nhuận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2005, '历史', 'lìshǐ', 'lịch sử', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2006, '理所当然', 'lǐsuǒdāngrán', 'tất nhiên', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2009, '力图', 'lìtú', 'mưu cầu, gắng đạt được', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2010, '留', 'liú', 'ở lại, lưu lại, giữ lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2011, '流', 'liú', 'chảy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2012, '滑', 'huá', 'trượt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2013, '流传', 'liúchuán', 'lưu truyền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2014, '浏览', 'liúlǎn', 'xem lướt qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2015, '流浪', 'liúlàng', 'lang thang, lưu lạc', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2016, '流泪', 'liúlèi', 'chảy nước mắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2017, '流量', 'liúliàng', 'lưu lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2018, '留恋', 'liúliàn', 'lưu luyến, không muốn rời xa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2019, '流露', 'liúlù', 'bộc lộ, thổ lộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2020, '流氓', 'liúmáng', 'lưu manh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2022, '留意', 'liúyì', 'lưu ý, để ý cẩn thận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2023, '流通', 'liútōng', 'lưu thông, thoáng, không bí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2024, '流行', 'liúxíng', 'thịnh hành, lưu hành', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2025, '留学', 'liúxué', 'du học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2026, '例外', 'lìwài', 'ngoại lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2027, '理想', 'lǐxiǎng', 'lý tưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2028, '利息', 'lìxī', 'lãi, lợi tức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2029, '利用', 'lìyòng', 'lợi dụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2030, '理由', 'lǐyóu', 'lý do', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2033, '立足', 'lìzú', 'đứng chân, chỗ dựa, chỗ đứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2034, '龙', 'lóng', 'con rồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2035, '聋哑', 'lóng yǎ', 'người câm điếc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2036, '垄断', 'lǒngduàn', 'lũng đoạn, độc quyền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2037, '隆重', 'lóngzhòng', 'long trọng, linh đình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2038, '漏', 'lòu', 'rò rỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2039, '搂', 'lǒu', 'ôm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2040, '楼', 'lóu', 'lầu, tầng', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2041, '露', 'lù', 'sương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2042, '绿', 'lǜ', 'xanh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2043, '陆续', 'lùxù', 'lần lượt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2044, '乱', 'luàn', 'lộn xộn, bừa bãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2045, '屡次', 'lǚcì', 'nhiều lần, liên tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2046, '掠夺', 'lüèduó', 'cướp đoạt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2047, '略微', 'lüèwēi', 'hơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2049, '轮廓', 'lúnkuò', 'đường viền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2050, '轮流', 'lúnliú', 'thay phiên nhau', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2051, '论坛', 'lùntán', 'diễn đàn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2053, '论证', 'lùnzhèng', 'luận chứng, chứng minh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2054, '落成', 'luòchéng', 'hoàn thành, khánh thành', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2056, '逻辑', 'luójí', 'logic', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2058, '螺丝钉', 'luósīdīng', 'đinh ốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2059, '啰嗦', 'luōsuo', 'lắm lời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2061, '录取', 'lùqǔ', 'tuyển chọn, nhận vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2062, '律师', 'lǜshī', 'luật sư', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2063, '旅行', 'lǚxíng', 'thực hiện, thực thi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2064, '录音', 'lùyīn', 'ghi âm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2065, '旅游', 'lǚyóu', 'du lịch', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2066, '炉灶', 'lúzào', 'bếp lò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2067, '吗', 'ma', 'à, ư', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2069, '马', 'mǎ', 'ngựa', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2081, '妈妈', 'māma', 'mẹ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2082, '麻木', 'mámù', 'tê', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2093, '慢性', 'mànxìng', 'mãn tính', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2106, '码头', 'mǎtóu', 'bến tàu', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2124, '谜语', 'míyǔ', 'câu đố', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2070, '麻', 'má', 'gai, tê', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2072, '麻烦', 'máfan', 'làm phiền, phiền hà', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2073, '马虎', 'mǎhu', 'qua loa, đại khái, tạm tạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2074, '卖', 'mài', 'bán', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2075, '迈', 'mài', 'đi bước dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2076, '买', 'mǎi', 'mua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2077, '脉搏', 'màibó', 'mạch', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2078, '埋伏', 'máifú', 'mai phục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2079, '麦克风', 'màikèfēng', 'microphone', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2083, '慢', 'màn', 'chậm, từ từ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2084, '满', 'mǎn', 'đầy, chất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2085, '漫长', 'màncháng', 'dài dằng dặc, dài đằng đẵng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2086, '忙', 'máng', 'bận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2087, '忙碌', 'mánglù', 'bận rộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2088, '茫茫', 'mángmáng', 'mênh mông, mịt mù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2089, '盲目', 'mángmù', 'mù quáng', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2091, '漫画', 'mànhuà', 'hoạt họa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2092, '馒头', 'mántou', 'màn thầu, bánh bao không nhân', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2094, '蔓延', 'mànyán', 'lan tràn, lan ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2095, '满意', 'mǎnyì', 'hài lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2096, '埋怨', 'mányuàn', 'oán trách, oán hận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2097, '满足', 'mǎnzú', 'thỏa mãn, làm thỏa mãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2098, '毛', 'máo', 'lông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2099, '猫', 'māo', 'mèo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2101, '矛盾', 'máodùn', 'mâu thuẫn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2102, '冒险', 'màoxiǎn', 'mạo hiểm, phiêu lưu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2103, '贸易', 'màoyì', 'buôn bán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2104, '帽子', 'màozi', 'mũ', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2105, '马上', 'mǎshàng', 'ngay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2107, '麻醉', 'mázuì', 'gây tê', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2108, '枚', 'méi', 'cái, tấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2109, '没', 'méi', 'chưa, không', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2110, '每', 'měi', 'mỗi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2111, '美', 'měi', 'đẹp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2113, '美满', 'měimǎn', 'cuộc sống đầy đủ, đầm ấm, mỹ mãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2114, '眉毛', 'méimáo', 'lông mày', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2115, '媒体', 'méitǐ', 'truyền thông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2116, '美容', 'měiróng', 'làm đẹp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2117, '美术', 'měishù', 'mỹ thuật', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2118, '美味', 'měiwèi', 'ngon miệng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2119, '美元', 'měiyuán', 'đô la Mỹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2120, '妹妹', 'mèimei', 'em gái', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2121, '魅力', 'mèilì', 'sức quyến rũ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2122, '门', 'mén', 'cửa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2125, '没辙', 'méizhé', 'bế tắc, chịu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2126, '梦', 'mèng', 'mộng, giấc mơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2127, '猛', 'měng', 'dữ dội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2128, '猛烈', 'měngliè', 'dữ dội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2129, '梦想', 'mèngxiǎng', 'giấc mơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2130, '萌芽', 'méngyá', 'mầm, chồi non', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2131, '门诊', 'ménzhěn', 'phòng khám bệnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2132, '米', 'mǐ', 'gạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2133, '眯', 'mī', 'chớp mắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2134, '面对', 'miàn duì', 'đối mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2135, '面包', 'miànbāo', 'bánh mì', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2136, '免得', 'miǎnde', 'để tránh', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2138, '棉花', 'miánhuā', 'bông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2139, '勉励', 'miǎnlì', 'khuyến khích', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2140, '面临', 'miànlín', 'đối mặt với', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2141, '勉强', 'miǎnqiáng', 'gượng gạo, miễn cưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2142, '面条', 'miàntiáo', 'mì', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2143, '面子', 'miànzi', 'mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2144, '描写', 'miáoxiě', 'miêu tả', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2145, '弥补', 'míbǔ', 'bù đắp, đền bù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2146, '密度', 'mìdù', 'độ dày, mật độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2147, '蔑视', 'mièshì', 'khinh miệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2148, '灭亡', 'mièwáng', 'chết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2149, '密封', 'mìfēng', 'niêm phong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2151, '迷惑', 'míhuò', 'mê hoặc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2152, '迷路', 'mílù', 'lạc đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2153, '密码', 'mìmǎ', 'mật mã', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2154, '迷茫', 'mímáng', 'mù mịt, mờ mịt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2155, '秘密', 'mìmì', 'bí mật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2156, '敏感', 'mǐngǎn', 'nhạy cảm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2157, '明白', 'míngbai', 'rõ ràng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2158, '名次', 'míngcì', 'thứ tự', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2160, '名副其实', 'míngfùqíshí', 'đúng sự thật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2161, '命令', 'mìnglìng', 'mệnh lệnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2162, '明明', 'míngmíng', 'rõ ràng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2163, '命名', 'mìngmíng', 'đặt tên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2164, '名牌', 'míngpái', 'thương hiệu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2165, '明显', 'míngxiǎn', 'rõ ràng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2166, '明信片', 'míngxìnpiàn', 'bưu thiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2167, '名誉', 'míngyù', 'danh dự', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2168, '名字', 'míngzi', 'tên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2170, '敏捷', 'mǐnjié', 'nhanh nhẹn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2171, '敏锐', 'mǐnruì', 'sắc sảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2172, '民用', 'mínyòng', 'dân dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2173, '民主', 'mínzhǔ', 'dân chủ', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2174, '民族', 'mínzú', 'dân tộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2175, '密切', 'mìqiè', 'mật thiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2176, '迷人', 'mírén', 'cuốn hút', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2178, '秘书', 'mìshū', 'thư ký', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2179, '迷信', 'míxìn', 'mê tín', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2233, '捏', 'niē', 'nhón, nhặt, cầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2242, '女士', 'nǚshì', 'cô, chị, bà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2251, '哪儿', 'nǎr', 'chỗ nào, đâu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2189, '模式', 'móshì', 'kiểu mẫu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2236, '牛', 'niú', 'trâu, bò', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2213, '难看', 'nánkàn', 'xấu xí', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2221, '馁', 'něi', 'nản chí', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2225, '能干', 'nénggàn', 'tài giỏi, giỏi giang', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2227, '年', 'nián', 'năm', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2273, '牛仔裤', 'niúzǎikù', 'quần jean', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2288, '呕吐', 'ǒutù', 'nôn mửa', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2256, '嫩', 'nèn', 'mềm, non', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2262, '年度', 'niándù', 'năm', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2180, '摸', 'mō', 'mò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2182, '模仿', 'mófǎng', 'bắt chước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2183, '魔鬼', 'móguǐ', 'ma quỷ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2184, '磨合', 'móhé', 'chạy thử', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2185, '模糊', 'móhu', 'mờ, mơ hồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2187, '默默', 'mòmò', 'âm thầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2188, '陌生', 'mòshēng', 'lạ', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2247, '派', 'pài', 'phái, cử, đát cử', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2190, '牧师', 'mùshī', 'mục sư', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2192, '模型', 'móxíng', 'mô hình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2193, '目标', 'mùbiāo', 'mục tiêu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2194, '目的', 'mùdì', 'mục đích', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2195, '目光', 'mùguāng', 'ánh mắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2196, '目录', 'mùlù', 'mục lục', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2197, '母亲', 'mǔqīn', 'mẹ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2199, '模样', 'múyàng', 'dáng dấp', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2200, '沐浴', 'mùyù', 'tắm gội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2201, '拿', 'ná', 'cầm, lấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2202, '那', 'nà', 'kia, đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2203, '奶奶', 'nǎinai', 'bà', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2205, '耐用', 'nàiyòng', 'bền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2206, '纳闷儿', 'nàmèn er', 'bối rối', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2207, '南', 'nán', 'phía nam', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2208, '难', 'nán', 'khó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2209, '难道', 'nándào', 'lẽ nào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2210, '难得', 'nándé', 'khó có được', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2211, '难怪', 'nánguài', 'thảo nào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2283, '女人', 'nǚrén', 'con gái, phụ nữ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2214, '难免', 'nánmiǎn', 'không tránh khỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2215, '难能可贵', 'nánnéngkěguì', 'đáng khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2216, '男人', 'nánrén', 'đàn ông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2217, '难受', 'nánshòu', 'khó chịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2218, '脑袋', 'nǎodai', 'đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2220, '呢', 'ne', 'thế, nhỉ, vậy, nhé, cơ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2249, '盘子', 'pánzi', 'đĩa, mâm, khay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2222, '内', 'nèi', 'bên trong, nội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2223, '内容', 'nèiróng', 'nội dung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2224, '内科', 'nèikē', 'nội khoa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2226, '能力', 'nénglì', 'năng lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2228, '年级', 'niánjí', 'lớp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2229, '年纪', 'niánjì', 'tuổi tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2231, '念', 'niàn', 'nhớ, suy nghĩ, đọc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2232, '鸟', 'niǎo', 'chim', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2234, '宁可', 'níngkě', 'thà rằng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2235, '宁愿', 'níngyuàn', 'thà, thà rằng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2237, '农民', 'nóngmín', 'nông dân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2239, '浓', 'nóng', 'đặc, đậm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2240, '暖和', 'nuǎnhuo', 'ấm áp', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2241, '女儿', 'nǚ’ér', 'con gái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2243, '怕', 'pà', 'sợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2244, '拍', 'pāi', 'vỗ, đập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2245, '排', 'pái', 'hàng, xếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2246, '牌', 'pái', 'thẻ, bảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2250, '判断', 'pànduàn', 'phán đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2252, '拿手', 'náshǒu', 'sở trường, tài năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2253, '内涵', 'nèihán', 'nội hàm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2254, '内幕', 'nèimù', 'nội tình, tình hình bên trong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2255, '内在', 'nèizài', 'bên trong, nội tại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2257, '能', 'néng', 'có thể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2259, '能源', 'néngyuán', 'nguồn năng lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2260, '你', 'nǐ', 'anh, chị, ông, bà…', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2261, '年代', 'niándài', 'niên đại, thời đại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2263, '年轻', 'niánqīng', 'trẻ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2264, '拟定', 'nǐdìng', 'định ra, vạch ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2265, '您', 'nín', 'ngài, ông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2266, '宁', 'níng', 'yên, tĩnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2268, '凝结', 'níngjié', 'ngưng tụ, đông lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2269, '凝视', 'níngshì', 'nhìn chòng chọc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2270, '宁静', 'níngjìng', 'yên tĩnh, bình lặng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2271, '纽扣儿', 'niǔkòur', 'cúc áo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2272, '牛奶', 'niúnǎi', 'sữa bò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2274, '扭转', 'niǔzhuǎn', 'xoay, quay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2275, '弄', 'nòng', 'làm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2276, '农村', 'nóngcūn', 'nông thôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2277, '农夫', 'nóngfū', 'nông dân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2278, '农历', 'nónglì', 'âm lịch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2280, '奴隶', 'núlì', 'nô lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2281, '努力', 'nǔlì', 'cố gắng, nỗ lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2282, '挪', 'nuó', 'di chuyển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2284, '哦', 'ó', 'hừ, hả', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2285, '欧打', 'ōudǎ', 'đánh nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2286, '偶尔', 'ǒu’ěr', 'thỉnh thoảng, ngẫu nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2287, '偶然', 'ǒurán', 'tình cờ, ngẫu nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2290, '派对', 'pàiduì', 'tiệc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2291, '排放', 'páifàng', 'thải ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2292, '排斥', 'páichì', 'bài xích, bài bác', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2293, '排除', 'páichú', 'loại trừ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2304, '盘旋', 'pánxuán', 'quanh quẩn, luẩn quẩn', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2315, '盆', 'pén', 'chậu, bồn', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2321, '朋友', 'péngyǒu', 'bạn, bạn bè', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2322, '匹', 'pǐ', 'con (ngựa, la...)', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2341, '平等', 'píngděng', 'bình đẳng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2347, '评估', 'pínggū', 'đánh giá', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2361, '品行', 'pǐnxíng', 'hạnh kiểm', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2366, '皮鞋', 'píxié', 'giày da', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2398, '铅笔', 'qiānbǐ', 'bút chì', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2295, '排列', 'páiliè', 'sắp xếp, sắp đặt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2296, '派遣', 'pàiqiǎn', 'cử, phái, điều động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2297, '派球', 'páiqiú', 'bóng chuyền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2298, '盘', 'pán', 'đĩa, mâm, khay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2299, '胖', 'pàng', 'béo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2300, '盼望', 'pànwàng', 'mong mỏi, trông chờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2301, '判', 'pàn', 'phán quyết, kết án', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2303, '庞大', 'pángdà', 'to lớn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2305, '跑', 'pǎo', 'chạy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2306, '跑步', 'pǎobù', 'chạy bộ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2307, '抛弃', 'pāoqì', 'vứt bỏ, quăng đi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2308, '爬山', 'páshān', 'leo núi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2309, '陪', 'péi', 'dẫn dắt, cùng đưa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2310, '配备', 'pèibèi', 'phân phối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2312, '配套', 'pèitào', 'đồng bộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2313, '培训', 'péixùn', 'bồi dưỡng, đào tạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2314, '培养', 'péiyǎng', 'rèn luyện, bồi dưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2316, '盆地', 'péndì', 'thung lũng, lòng chảo', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2317, '膨胀', 'péngzhàng', 'bành trướng, phình to', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2318, '碰', 'pèng', 'đụng, va', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2319, '碰见', 'pèngjiàn', 'gặp', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2320, '烹饪', 'pēngrèn', 'nấu ăn', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2323, '批', 'pī', 'bó, chẻ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2324, '批发', 'pīfā', 'bán sỉ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2326, '批准', 'pīzhǔn', 'phê chuẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2327, '疲惫', 'píbèi', 'kiệt quệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2328, '皮', 'pí', 'da', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2329, '皮肤', 'pífū', 'da', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2330, '屁股', 'pìgu', 'mông, đít', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2331, '啤酒', 'píjiǔ', 'bia', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2332, '疲劳', 'píláo', 'mệt mỏi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2334, '品尝', 'pǐncháng', 'nếm, thử', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2335, '频道', 'píndào', 'kênh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2336, '品德', 'pǐndé', 'đạo đức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2337, '贫乏', 'pínfá', 'nghèo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2338, '频繁', 'pínfán', 'thường xuyên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2339, '平', 'píng', 'dựa vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2340, '平常', 'píngcháng', 'thông thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2342, '平凡', 'píngfán', 'bình thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2344, '评价', 'píngjià', 'đánh giá', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2345, '苹果', 'píngguǒ', 'quả táo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2346, '平衡', 'pínghéng', 'cân bằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2348, '平静', 'píngjìng', 'yên lặng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2349, '评论', 'pínglùn', 'bình luận, nhận xét', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2350, '平面', 'píngmiàn', 'mặt bằng, mặt phẳng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2351, '乒乓球', 'pīngpāngqiú', 'bóng bàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2353, '平坦', 'píngtǎn', 'bằng phẳng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2354, '平行', 'píngxíng', 'song song', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2355, '平原', 'píngyuán', 'đồng bằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2356, '屏障', 'píngzhàng', 'rào chắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2357, '瓶子', 'píngzi', 'lọ, bình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2358, '贫穷', 'pínqióng', 'nghèo nàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2359, '频率', 'pínlǜ', 'tần số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2360, '品味', 'pǐnwèi', 'khiếu thẩm mỹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2362, '品质', 'pǐnzhì', 'chất lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2363, '品种', 'pǐnzhǒng', 'giống, loại, chủng loại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2365, '譬如', 'pìrú', 'ví dụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2367, '泼', 'pō', 'hắt, giội, vẩy (nước)', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2368, '迫', 'pò', 'vỡ, thũng, phá vỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2369, '破', 'pò', 'sườn dốc, dốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2370, '颇', 'pō', 'rất, tương đối, khá', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2371, '迫不及待', 'pòbùjídài', 'không thể chờ đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2372, '破产', 'pòchǎn', 'phá sản', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2373, '破坏', 'pòhuài', 'phá hoại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2374, '破裂', 'pòliè', 'phá vỡ, nứt vỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2375, '魄力', 'pòlì', 'kiên quyết, quyết đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2376, '迫切', 'pòqiè', 'bức thiết, cấp bách', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2377, '铺', 'pū', 'trải, dọn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2378, '普遍', 'pǔbiàn', 'phổ biến, rộng rãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2379, '普及', 'pǔjí', 'thịnh hành', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2381, '仆人', 'púrén', 'đầy tớ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2382, '朴素', 'pǔsù', 'giản dị, mộc mạc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2383, '普通话', 'pǔtōnghuà', 'tiếng phổ thông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2384, '七', 'qī', 'bảy', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2385, '卡', 'qiǎ', 'kẹt, véo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2386, '恰当', 'qiàdàng', 'thích hợp, thỏa đáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2387, '恰到好处', 'qiàdàohǎochù', 'đúng dịp, đúng mục đích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2388, '钱', 'qián', 'tiền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2389, '浅', 'qiǎn', 'nông, nhạt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2391, '前提', 'qiántí', 'tiền đề', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2392, '潜力', 'qiánlì', 'tiềm năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2393, '潜水', 'qiánshuǐ', 'lặn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2394, '签', 'qiān', 'ký', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2395, '签订', 'qiāndìng', 'ký kết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2399, '千方百计', 'qiānfāngbǎijì', 'tất cả mọi thủ đoạn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2400, '墙', 'qiáng', 'tường, bức tường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2401, '抢', 'qiǎng', 'cướp lấy, vồ lấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2402, '抢夺', 'qiǎngduó', 'cướp lấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2405, '强烈', 'qiángliè', 'mạnh mẽ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2437, '起初', 'qǐchǐ', 'lúc đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2420, '牵头', 'qiāntóu', 'đứng đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2451, '请求', 'qǐngqiú', 'yêu cầu, xin', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2468, '青', 'qīng', 'màu xanh, thanh', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2479, '请教', 'qǐngjiāo', 'thỉnh giáo, xin chỉ bảo', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2495, '庆祝', 'qìngzhù', 'chúc mừng', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2503, '亲身', 'qīnshēn', 'bản thân, tự mình', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2403, '抢劫', 'qiǎngjié', 'cướp tài sản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2404, '强调', 'qiángdiào', 'nhấn mạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2406, '强迫', 'qiǎngpò', 'ép buộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2407, '强制', 'qiángzhì', 'cưỡng chế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2408, '抢救', 'qiǎngjiù', 'cứu giúp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2410, '谦虚', 'qiānxū', 'khiêm tốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2411, '前面', 'qiánmiàn', 'phía trước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2412, '前途', 'qiántú', 'tương lai, triển vọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2413, '前进', 'qiánjìn', 'tiến lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2414, '谦逊', 'qiānxùn', 'khiêm nhường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2415, '谴责', 'qiǎnzé', 'lên án', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2416, '欠', 'qiàn', 'nợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2417, '嵌入', 'qiànrù', 'nhúng vào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2418, '牵挂', 'qiānguà', 'lo lắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2421, '迁就', 'qiānjiù', 'nhân nhượng, cả nể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2422, '迁移', 'qiānyí', 'di chuyển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2423, '谦让', 'qiānràng', 'nhường nhịn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2424, '潜移默化', 'qiānyímóhuà', 'thay đổi một cách vô tri vô giác', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2425, '牵制', 'qiānzhì', 'kiềm chế, hàm chứa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2426, '签字', 'qiānzi', 'ký tên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2427, '桥', 'qiáo', 'cây cầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2428, '瞧', 'qiáo', 'nhìn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2429, '乔', 'qiáo', 'vênh, vểnh, bảnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2430, '敲', 'qiāo', 'gõ, khua, bật dậy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2431, '巧克力', 'qiǎokèlì', 'sô cô la', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2432, '巧妙', 'qiǎomiào', 'khéo léo, tài tình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2433, '悄悄', 'qiāoqiāo', 'lặng lẽ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2435, '洽谈', 'qiàtán', 'trò chuyện, bàn luận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2436, '器材', 'qìcái', 'khí tài, dụng cụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2438, '启程', 'qǐchéng', 'khởi hành, lên đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2439, '起床', 'qǐchuáng', 'ngủ dậy', NULL, 39);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2440, '其次', 'qícì', 'thứ hai, tiếp đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2441, '期待', 'qídài', 'kỳ vọng, mong đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2442, '锲而不舍', 'qǐ''érbùshě', 'kiên nhẫn, miệt mài', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2444, '启发', 'qǐfā', 'gợi ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2445, '起飞', 'qǐfēi', 'cất cánh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2446, '起伏', 'qǐfú', 'không khí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2447, '起句', 'qǐjǔ', 'nhập nho, lên xuống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2449, '起海', 'qǐhài', 'khí khái, khí phách', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2450, '请', 'qǐng', 'xin, mời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2452, '气功', 'qìgōng', 'khí công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2453, '奇怪', 'qíguài', 'kỳ lạ, quái lạ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2454, '器官', 'qìguān', 'cơ quan', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2455, '起哄', 'qǐhòng', 'đùa bỡn, giỡn cợt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2456, '气候', 'qìhòu', 'khí hậu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2457, '奇迹', 'qǐjì', 'kỳ tích, kỳ công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2459, '迄今为止', 'qíjīn wèizhǐ', 'cho đến nay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2460, '起来', 'qǐlái', 'đứng dậy, ngồi dậy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2461, '凄凉', 'qǐliáng', 'lạnh lẽo, tiêu điều', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2462, '奇妙', 'qímiào', 'kỳ diệu, tinh xảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2463, '亲爱', 'qīn''ài', 'thân ái, thương yêu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2464, '侵犯', 'qīnfàn', 'xâm phạm, can thiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2465, '勤奋', 'qínfèn', 'siêng năng, cần cù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2466, '晴', 'qíng', 'trời nắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2467, '轻', 'qīng', 'nhẹ, nhẹ nhàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2469, '清', 'qīng', 'trong, sạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2470, '情报', 'qíngbào', 'tình báo, thông tin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2471, '清澈', 'qīngchè', 'trong veo, trong suốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2472, '清晨', 'qīngchén', 'sáng sớm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2474, '青春', 'qīngchūn', 'tuổi trẻ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2475, '轻淡', 'qīngdàn', 'nhạt, loãng, nhẹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2476, '轻而易举', 'qīng''éryìjiǎo', 'dễ dàng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2477, '请假', 'qǐngjià', 'xin nghỉ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2478, '请柬', 'qǐngjiǎn', 'thiệp mời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2480, '情节', 'qíngjié', 'tình tiết, trường hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2481, '清静', 'qīngjìng', 'yên tĩnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2482, '请客', 'qǐngkè', 'mời khách, đãi khách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2483, '情况', 'qíngkuàng', 'tình hình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2484, '晴朗', 'qínglǎng', 'nắng, trong sáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2485, '情理', 'qínglǐ', 'lý lẽ, đạo lý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2486, '青年', 'qīngnián', 'thanh niên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2488, '轻视', 'qīngshì', 'khinh thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2489, '轻松', 'qīngsōng', 'nhẹ nhõm, thoải mái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2490, '倾听', 'qīngtīng', 'lắng nghe, chú ý nghe', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2491, '清晰', 'qīngxī', 'rõ ràng, rõ rệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2492, '倾斜', 'qīngxié', 'nghiêng, lệch, xiêu vẹo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2493, '清醒', 'qīngxǐng', 'tỉnh táo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2494, '情绪', 'qíngxù', 'tâm trạng, cảm xúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2496, '勤俭', 'qínjiǎn', 'tiết kiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2498, '侵略', 'qīnlüè', 'xâm lược', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2499, '钦佩', 'qīnpèi', 'khâm phục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2500, '亲戚', 'qīnqī', 'thân thích, người thân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2501, '亲切', 'qīnqiè', 'thân thiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2502, '亲热', 'qīnre', 'thân mật, nồng nhiệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2504, '穷', 'qióng', 'nghèo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2520, '企业', 'qǐyè', 'xí nghiệp', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2545, '热爱', 'rè’ài', 'yêu nhiệt thành', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2555, '任何', 'rènhé', 'bất kì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2580, '荣登', 'róngdēng', 'vinh danh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2512, '其余', 'qíyú', 'ngoài ra, còn lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2550, '热心', 'rèxīn', 'nhiệt tình, sốt sắng', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2553, '仍然', 'réngrán', 'vẫn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2564, '仍旧', 'réngjiù', 'như cũ, như trước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2505, '旗袍', 'qípáo', 'sườn xám', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2506, '欺骗', 'qīpiàn', 'lừa dối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2508, '齐全', 'qíquán', 'đầy đủ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2509, '气色', 'qìsè', 'thần sắc, khí sắc', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2510, '其实', 'qíshí', 'kỳ thực, thực ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2511, '气势', 'qìshì', 'khí thế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2513, '企图', 'qǐtú', 'mưu đồ, ý đồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2514, '球迷', 'qiúmí', 'người hâm mộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2515, '气味', 'qìwèi', 'mùi vị', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2517, '气象', 'qìxiàng', 'khí tượng học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2518, '齐心协力', 'qíxīn xiélì', 'đồng tâm hiệp lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2519, '气压', 'qìyā', 'áp suất khí quyển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2521, '起义', 'qǐyì', 'khởi nghĩa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2522, '汽油', 'qìyóu', 'xăng', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2523, '岂有此理', 'qǐ yǒu cǐ lǐ', 'lẽ nào lại như vậy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2524, '起源', 'qǐyuán', 'bắt nguồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2525, '其中', 'qízhōng', 'trong số đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2526, '妻子', 'qīzi', 'vợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2527, '娶', 'qǔ', 'lấy vợ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2528, '去世', 'qùshì', 'qua đời', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2530, '去年', 'qùnián', 'năm ngoái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2531, '群众', 'qúnzhòng', 'quần chúng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2532, '裙子', 'qúnzi', 'váy', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2533, '趋势', 'qūshì', 'khuynh hướng, xu thế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2534, '曲折', 'qūzhé', 'quanh co, khúc khuỷu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2535, '驱逐', 'qūzhú', 'trục xuất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2536, '燃', 'rán', 'nhuộm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2538, '让', 'ràng', 'nhường, mời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2539, '嚷', 'rǎng', 'kêu gào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2540, '让步', 'ràngbù', 'nhượng bộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2541, '然后', 'ránhòu', 'sau đó, tiếp đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2542, '燃烧', 'ránshāo', 'đốt cháy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2543, '扰乱', 'rǎoluàn', 'quấy nhiễu, hỗn loạn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2544, '热', 'rè', 'nhiệt, nóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2546, '热烈', 'rèliè', 'nhiệt liệt, sôi nổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2547, '热闹', 'rènào', 'náo nhiệt, sôi nổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2548, '忍', 'rěn', 'nhẫn, chịu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2551, '认识', 'rènshi', 'biết, nhận biết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2552, '任务', 'rènwu', 'nhiệm vụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2554, '扔', 'rēng', 'ném, quăng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2556, '人', 'rén', 'người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2557, '忍耐', 'rěnnài', 'kiên nhẫn, nhẫn lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2558, '忍受', 'rěnshòu', 'chịu đựng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2559, '热身', 'rèshēn', 'khởi động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2560, '热水器', 'rèshuǐqì', 'bình nước nóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2561, '热情', 'rèqíng', 'nhiệt tình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2563, '忍心', 'rěnxīn', 'nỡ lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2565, '日程', 'rìchéng', 'lịch trình', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2566, '日期', 'rìqī', 'ngày tháng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2567, '日记', 'rìjì', 'nhật ký', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2568, '日用品', 'rìyòngpǐn', 'đồ dùng hằng ngày', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2569, '荣誉', 'róngyù', 'vinh dự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2570, '容易', 'róngyì', 'dễ dàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2571, '容忍', 'róngrěn', 'khoan dung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2572, '容貌', 'róngmào', 'dung mạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2574, '容纳', 'róngnà', 'chứa đựng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2575, '融化', 'rónghuà', 'tan chảy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2576, '容器', 'róngqì', 'đồ chứa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2577, '荣幸', 'róngxìng', 'vinh hạnh', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2579, '荣华富贵', 'rónghuá fùguì', 'vinh hoa phú quý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2581, '荣耀', 'róngyào', 'vinh quang', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2582, '荣军', 'róngjūn', 'quân nhân xuất ngũ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2583, '荣膺', 'róngyīng', 'được vinh dự nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2584, '容光焕发', 'róngguāng huànfā', 'tươi sáng, rạng rỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2585, '容身', 'róngshēn', 'trú thân', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2586, '容不下', 'róng bù xià', 'không thể chấp nhận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2587, '人才', 'réncái', 'người tài năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2588, '仁慈', 'réncí', 'nhân từ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2589, '人道', 'réndào', 'nhân đạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2590, '认定', 'rèndìng', 'cho rằng, nhận định', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2591, '人格', 'réngé', 'nhân cách', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2592, '人工', 'réngōng', 'nhân tạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2594, '人间', 'rénjiān', 'nhân gian, thế giới', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2595, '人可', 'rénkě', 'cho phép, đồng ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2596, '人口', 'rénkǒu', 'dân số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2597, '人类', 'rénlèi', 'nhân loại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2598, '人民币', 'rénmínbì', 'nhân dân tệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2599, '任命', 'rènmìng', 'bổ nhiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2600, '人生', 'rénshēng', 'đời sống, cuộc đời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2601, '人士', 'rénshì', 'nhân sự', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2602, '人为', 'rénwéi', 'con người làm ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2603, '认为', 'rènwéi', 'cho rằng, cho là', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2604, '人物', 'rénwù', 'nhân vật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2606, '任性', 'rènxìng', 'tùy hứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2607, '任意', 'rènyì', 'tùy ý', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2608, '人员', 'rényuán', 'nhân viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2609, '认真', 'rènzhēn', 'chăm chỉ, nghiêm túc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2613, '鳃', 'sāi', 'mang cá', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2685, '剩', 'shèng', 'thừa, còn lại', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2620, '三角', 'sānjiǎo', 'tam giác', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2624, '啥', 'shá', 'cái gì', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2632, '擅长', 'shàncháng', 'giỏi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2645, '商品', 'shāngpǐn', 'hàng hóa', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2672, '摄影', 'shèyǐng', 'nhiếp ảnh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2696, '声调', 'shēngdiào', 'thanh điệu, giọng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2702, '生理', 'shēnglǐ', 'sinh lý', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2718, '绳子', 'shéngzi', 'dây thừng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2611, '洒', 'sǎ', 'rắc, tung, vẩy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2612, '撒谎', 'sāhuǎng', 'nói dối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2674, '设想', 'shèxiǎng', 'tưởng tượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2614, '伞', 'sǎn', 'ô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2615, '三', 'sān', 'ba', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2617, '散发', 'sànfā', 'toả ra, phát ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2618, '丧失', 'sàngshī', 'mất đi, mất mát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2619, '嗓子', 'sǎngzi', 'cổ họng, giọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2621, '散文', 'sǎnwén', 'văn xuôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2623, '森林', 'sēnlín', 'rừng rậm, rừng sâu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2625, '傻', 'shǎ', 'ngu ngốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2626, '杀', 'shā', 'giết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2627, '刹车', 'shāchē', 'phanh, thắng xe', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2628, '沙发', 'shāfā', 'ghế xô-pha', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2629, '晒', 'shài', 'phơi nắng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2631, '沙漠', 'shāmò', 'sa mạc', NULL, 29);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2633, '删除', 'shānchú', 'xóa bỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2634, '闪电', 'shǎndiàn', 'tia chớp, sét', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2635, '上', 'shàng', 'trên, phía trên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2636, '伤脑筋', 'shāng nǎojīn', 'hại não, tốn tâm trí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2637, '上班', 'shàngbān', 'đi làm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2638, '商标', 'shāngbiāo', 'thương hiệu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2639, '上当', 'shàngdàng', 'bị lừa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2640, '商店', 'shāngdiàn', 'cửa hàng', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2642, '上课', 'shàngkè', 'học, lên lớp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2643, '上进心', 'shàngjìnxīn', 'chí tiến thủ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2644, '商量', 'shāngliáng', 'thương lượng, bàn thảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2646, '上任', 'shàngrèn', 'nhậm chức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2647, '上网', 'shàngwǎng', 'lên mạng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2648, '上午', 'shàngwǔ', 'buổi sáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2649, '伤心', 'shāngxīn', 'thương tâm, đau lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2650, '上学', 'shàngxué', 'đi học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2651, '上瘾', 'shàngyǐn', 'nghiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2652, '上游', 'shàngyóu', 'thượng du', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2654, '山脉', 'shānmài', 'rặng núi, dãy núi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2655, '闪烁', 'shǎnshuò', 'nhấp nháy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2656, '善于', 'shànyú', 'giỏi về', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2657, '扇子', 'shànzi', 'cái quạt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2658, '稍', 'shāo', 'hơi, một chút, sơ qua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2659, '哨', 'shào', 'đồn, trạm gác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2660, '少', 'shǎo', 'ít, trẻ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2661, '捎', 'shāo', 'mang hộ, mang giùm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2662, '烧', 'shāo', 'ngon', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2663, '稍微', 'shāowēi', 'hơi, một chút, sơ qua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2664, '勺子', 'sháozi', 'cái muỗng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2665, '沙滩', 'shātān', 'bãi biển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2666, '蛇', 'shé', 'con rắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2668, '舍不得', 'shěbude', 'luyến tiếc, không nỡ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2669, '射击', 'shèjī', 'bắn, xạ kích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2670, '设计', 'shèjì', 'thiết kế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2671, '社会', 'shèhuì', 'xã hội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2675, '伸', 'shēn', 'căng ra, duỗi ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2678, '申请', 'shēn qǐng', 'xin', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2679, '深奥', 'shēn’ào', 'sâu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2680, '申报', 'shēnbào', 'trình báo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2681, '身材', 'shēncái', 'vóc dáng, dáng người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2682, '审查', 'shěnchá', 'xem xét, thẩm tra', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2683, '深沉', 'shēnchén', 'sâu lắng', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2684, '身份', 'shēnfèn', 'thân phận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2686, '盛', 'shèng', 'chứa, đựng, dung nạp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2687, '省', 'shěng', 'tỉnh, tinh lược, tiết kiệm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2688, '升', 'shēng', 'lít', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2689, '胜负', 'shèng fù', 'thắng bại, được thua', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2690, '生锈', 'shēng xiù', 'rỉ sét', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2692, '盛产', 'shèngchǎn', 'sản xuất nhiều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2693, '生产', 'shēngchǎn', 'sản xuất', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2694, '牲畜', 'shēngchù', 'chăn nuôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2695, '生存', 'shēngcún', 'sống sót', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2697, '生动', 'shēngdòng', 'sinh động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2698, '省会', 'shěnghuì', 'thủ phủ của tỉnh', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2699, '生活', 'shēnghuó', 'cuộc sống, sống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2700, '生机', 'shēngjī', 'sức sống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2701, '盛开', 'shèngkāi', 'nở hoa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2703, '省略', 'shěnglüè', 'lược bỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2705, '生命', 'shēngmìng', 'tính mạng, sinh mạng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2706, '生气', 'shēngqì', 'giận, tức giận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2707, '深情', 'shēnqíng', 'thâm tình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2708, '生日', 'shēngrì', 'sinh nhật', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2709, '声势', 'shēngshì', 'thanh thế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2710, '生疏', 'shēngshū', 'mới lạ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2711, '生态', 'shēngtài', 'sinh thái', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2712, '生物', 'shēngwù', 'sinh vật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2713, '生效', 'shēngxiào', 'có hiệu lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2714, '盛行', 'shèngxíng', 'thịnh hành', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2716, '声誉', 'shēngyù', 'danh tiếng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2717, '生育', 'shēngyù', 'sinh đẻ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2720, '审问', 'shěnwèn', 'thẩm vấn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2725, '审判', 'shěnpàn', 'xét xử', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2807, '试图', 'shìtú', 'tính toán, thử, định', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2820, '实用', 'shíyòng', 'sử dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2732, '渗透', 'shèntòu', 'thấm thấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2737, '摄取', 'shèqǔ', 'hấp thu, (dinh dưỡng)', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2755, '时常', 'shícháng', 'thường', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2758, '世代', 'shìdài', 'thế hệ', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2762, '时光', 'shíguāng', 'thời gian', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2769, '实惠', 'shíhuì', 'lợi ích thực tế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2776, '时间', 'shíjiān', 'thời gian', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2715, '声音', 'shēngyīn', 'tiếng, âm thanh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2721, '深刻', 'shēnkè', 'sâu sắc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2723, '审美', 'shěnměi', 'thẩm mỹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2724, '神秘', 'shénmì', 'thần bí, bí ẩn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2778, '世界', 'shìjiè', 'thế giới', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2726, '神气', 'shénqì', 'thần sắc, thần khí', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2727, '深情厚谊', 'shēnqíng hòuyì', 'tình bạn thân thiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2728, '神色', 'shénsè', 'thần sắc', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2729, '神圣', 'shénshèng', 'thiêng liêng, thần thánh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2730, '绅士', 'shēnshì', 'thân sĩ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2784, '视力', 'shìlì', 'thị lực', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2733, '神仙', 'shénxiān', 'thần tiên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2734, '审讯', 'shěnxùn', 'thẩm vấn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2735, '甚至', 'shènzhì', 'thậm chí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2736, '慎重', 'shènzhòng', 'cẩn thận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2793, '时尚', 'shíshàng', 'thời thượng, mốt', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2738, '社区', 'shèqū', 'cộng đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2739, '摄氏度', 'shèshìdù', 'độ C', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2740, '舌头', 'shétou', 'lưỡi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2741, '设置', 'shèzhì', 'thiết lập', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2742, '拾', 'shí', 'nhặt, mót', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2743, '十', 'shí', 'mười', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2744, '是', 'shì', 'là', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2745, '试', 'shì', 'thi', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2746, '使', 'shǐ', 'khiến, sai bảo, dùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2747, '诗', 'shī', 'thơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2749, '十分', 'shí fēn', 'vô cùng, rất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2750, '失败', 'shībài', 'thất bại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2751, '势必', 'shìbì', 'tất phải, buộc phải', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2752, '识别', 'shíbié', 'phân biệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2753, '士兵', 'shìbīng', 'binh lính', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2754, '时差', 'shíchā', 'sự chênh lệch thời gian', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2757, '时代', 'shídài', 'thời kỳ, thời đại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2814, '实习', 'shíxí', 'tập luyện, thực tập', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2759, '时而', 'shí’ér', 'đôi khi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2818, '试验', 'shìyàn', 'thí nghiệm', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2761, '释放', 'shìfàng', 'phóng thích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2795, '实验', 'shíyàn', 'thực nghiệm, thí nghiệm', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2763, '是否', 'shìfǒu', 'phải chăng, hay không', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2764, '师傅', 'shīfu', 'thợ cả, chú', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2765, '事故', 'shìgù', 'sự cố, tai nạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2766, '适合', 'shìhé', 'phù hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2767, '时候', 'shíhou', 'lúc, khi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2770, '实际', 'shíjì', 'thực tế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2771, '时机', 'shíjī', 'cơ hội, thời cơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2772, '世纪', 'shìjì', 'thế kỉ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2773, '事迹', 'shìjì', 'sự tích, câu truyện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2774, '施加', 'shījiā', 'gây, làm (áp lực, ảnh hưởng)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2775, '实践', 'shíjiàn', 'thực hiện, thực hành', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2777, '事件', 'shìjiàn', 'sự kiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2780, '使劲儿', 'shǐ jìn er', 'gắng sức, ra sức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2781, '诗句', 'shījù', 'bài thơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2782, '时刻', 'shíkè', 'thời khắc, thời gian', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2783, '实力', 'shílì', 'sức mạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2785, '时髦', 'shímáo', 'thời trang', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2786, '失眠', 'shīmián', 'mất ngủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2787, '使命', 'shǐmìng', 'nhiệm vụ, sứ mệnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2788, '食品', 'shípǐn', 'thực phẩm', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2789, '时期', 'shíqī', 'thời kì', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2791, '失去', 'shīqù', 'mất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2792, '湿润', 'shīrùn', 'ướt, ẩm ướt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2794, '失业', 'shīyè', 'thất nghiệp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2796, '事业', 'shìyè', 'sự nghiệp, công cuộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2797, '实行', 'shíxíng', 'thực hiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2798, '使用', 'shǐyòng', 'sử dụng, dùng vào thực tế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2799, '时事', 'shíshì', 'thời sự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2800, '实施', 'shíshī', 'thực hiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2801, '事实', 'shìshí', 'sự thực', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2802, '逝世', 'shìshì', 'chết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2804, '事态', 'shìtài', 'tình thế, tình hình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2805, '尸体', 'shītǐ', 'thể thi, tử thi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2806, '石头', 'shítou', 'đá', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2808, '失望', 'shīwàng', 'thất vọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2809, '示威', 'shìwēi', 'thị uy, ra oai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2810, '食物', 'shíwù', 'thức ăn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2811, '事务', 'shìwù', 'công việc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2813, '失误', 'shīwù', 'lỗi lầm, sai lầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2815, '视线', 'shìxiàn', 'đường nhìn, tầm mắt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2816, '事先', 'shìxiān', 'trước, trước tiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2817, '事项', 'shìxiàng', 'hạng mục công việc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2819, '视野', 'shìyě', 'phạm vi nhìn, tầm nhìn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2821, '适应', 'shìyìng', 'thích ứng, hợp với', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2822, '失恋', 'shīliàn', 'thất tình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3037, '体积', 'tǐjī', 'thể tích', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2833, '竖', 'shù', 'thẳng đứng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2834, '书', 'shū', 'sách', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2843, '涮火锅', 'shuànhuǒguō', 'lẩu nhúng', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2845, '双胞胎', 'shuāngbāotāi', 'anh em sinh đôi', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2861, '水利', 'shuǐlì', 'thủy lợi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2866, '书架', 'shūjià', 'giá sách', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2871, '数码', 'shùmǎ', 'kỹ thuật số', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2875, '顺利', 'shùnlì', 'thuận lợi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2884, '属于', 'shǔyú', 'thuộc về', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2887, '四', 'sì', 'bốn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2824, '手艺', 'shǒuyì', 'tay nghề, kỹ thuật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2895, '思考', 'sīkǎo', 'suy nghĩ', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2826, '收音机', 'shōuyīnjī', 'radio', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2827, '授予', 'shòuyǔ', 'trao tặng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2828, '手指', 'shǒuzhǐ', 'ngón tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2829, '受罪', 'shòuzuì', 'mang vạ, bị giày vò', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2830, '数', 'shù', 'số, đếm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2831, '束', 'shù', 'bó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2832, '树', 'shù', 'cây', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2900, '思维', 'sīwéi', 'tư duy, suy nghĩ', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2903, '思绪', 'sīxù', 'tâm tư, ý nghĩ', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2835, '输', 'shū', 'thua', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2836, '耍', 'shuǎ', 'chơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2837, '帅', 'shuài', 'đẹp trai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2839, '摔', 'shuāi', 'ngã, rơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2840, '衰老', 'shuāilǎo', 'già yếu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2841, '率领', 'shuàilǐng', 'dẫn đầu, chỉ huy', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2842, '甩掉', 'shuǎidiào', 'vứt bỏ, trút bỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2905, '四肢', 'sìzhī', 'tứ chi, chân tay', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2844, '双', 'shuāng', 'đôi, hai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2922, '随手', 'suíshǒu', 'tiện tay, thuận tay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2846, '双方', 'shuāngfāng', 'cả hai bên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2848, '刷牙', 'shuāyá', 'đánh răng', NULL, 39);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2849, '鼠标', 'shǔbiāo', 'chuột máy tính', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2850, '蔬菜', 'shūcài', 'rau', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2851, '舒畅', 'shūchàng', 'khoan khoái, dễ chịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2852, '书法', 'shūfǎ', 'thư pháp', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2853, '束缚', 'shùfù', 'ràng buộc, gò bó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2854, '舒服', 'shūfu', 'thỏa mái, dễ chịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2855, '疏忽', 'shūhu', 'sơ suất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2856, '谁', 'shuí', 'ai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2857, '税', 'shuì', 'thuế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2858, '水', 'shuǐ', 'nước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2860, '睡觉', 'shuìjiào', 'ngủ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2928, '孙子', 'sūnzi', 'cháu trai', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2862, '水龙头', 'shuǐlóngtóu', 'vòi nước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2863, '水平', 'shuǐpíng', 'trình độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2864, '书籍', 'shūjí', 'sách vở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2865, '书记', 'shūjì', 'bí thư', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2867, '数据', 'shùjù', 'dữ liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2869, '熟练', 'shúliàn', 'thành thạo, thuần thục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2870, '数量', 'shùliàng', 'số lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2872, '书面', 'shūmiàn', 'văn bản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2873, '数目', 'shùmù', 'con số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2874, '顺便', 'shùnbiàn', 'nhân tiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2876, '顺序', 'shùnxù', 'trật tự, thứ tự', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2877, '说不定', 'shuō bu dìng', 'có thể, chưa biết chừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2878, '说明', 'shuōmíng', 'thuyết minh, giải thích', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2879, '说服', 'shuōfú', 'thuyết phục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2880, '朔', 'shuò', 'đầu tháng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2881, '输入', 'shūrù', 'nhập vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2883, '熟悉', 'shúxī', 'quen thuộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2885, '数字', 'shùzì', 'con số, số', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2886, '梳子', 'shūzi', 'lược, cái lược', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2888, '死', 'sǐ', 'chết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2889, '撕', 'sī', 'xé rách', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2890, '死亡', 'sǐwáng', 'chết, tử vong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2891, '司法', 'sīfǎ', 'tư pháp', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2893, '似乎', 'sìhū', 'có vẻ như', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2894, '司机', 'sījī', 'lái xe', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2896, '思念', 'sīniàn', 'nhớ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2897, '私人', 'sīrén', 'riêng tư, cá nhân', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2898, '思想', 'sīxiǎng', 'tư tưởng, tư duy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2899, '思索', 'sīsuǒ', 'suy nghĩ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2901, '斯文', 'sīwén', 'nhã nhặn, lịch sự', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2904, '饲养', 'sìyǎng', 'chăn nuôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2906, '私自', 'sīzì', 'tự ý, một mình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2907, '送', 'sòng', 'tặng, đưa, tiễn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2908, '艘', 'sōu', 'con (tàu, thuyền)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2909, '算', 'suàn', 'tính toán, đếm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2910, '酸', 'suān', 'chua', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2911, '算了', 'suànle', 'thôi được rồi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2912, '算数', 'suànshù', 'tính, đếm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2913, '速度', 'sùdù', 'tốc độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2914, '俗话', 'súhuà', 'tục ngữ', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2915, '岁', 'suì', 'tuổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2916, '碎', 'suì', 'vỡ, nát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2917, '随便', 'suíbiàn', 'tùy tiện, tùy ý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2918, '隧道', 'suìdào', 'đường hầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2919, '随即', 'suíjí', 'ngay lập tức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2920, '虽然', 'suīrán', 'tuy, mặc dù', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2923, '随意', 'suíyì', 'tùy ý', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2924, '随著', 'suízhe', 'theo, cùng với', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2925, '塑料袋', 'sùliàodài', 'túi ni-lông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2926, '损坏', 'sǔnhuài', 'hư hỏng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2927, '损失', 'sǔnshī', 'thua thiệt, mất mát', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2929, '所', 'suǒ', 'chỗ, nơi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2930, '锁', 'suǒ', 'khoá', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2931, '缩短', 'suōduǎn', 'rút ngắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2952, '台风', 'táifēng', 'bão', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2972, '坦率', 'tǎnshuài', 'thẳng thắn, bộc trực', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3007, '天空', 'tiānkōng', 'bầu trời', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3008, '天伦之乐', 'tiānlún zhī lè', 'niềm vui gia đình', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2932, '索赔', 'suǒpéi', 'bồi thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2933, '所谓', 'suǒwèi', 'cái gọi là', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2934, '缩小', 'suōxiǎo', 'thu nhỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2935, '缩写', 'suōxiě', 'viết tắt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2936, '所有', 'suǒyǒu', 'tất cả, toàn bộ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2937, '宿舍', 'sùshè', 'ký túc xá', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2939, '诉讼', 'sùsòng', 'kiện tụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2940, '素质', 'sùzhì', 'tố chất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2941, '塑造', 'sùzào', 'nặn, tạo hình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2942, '塔', 'tǎ', 'tháp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2943, '他', 'tā', 'ông ấy, chú ấy, anh ấy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2944, '塌', 'tā', 'sập', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2945, '她', 'tā', 'bà ấy, cô ấy, chị ấy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2946, '它', 'tā', 'nó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2948, '抬', 'tái', 'nâng lên, khiêng, nhấc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2949, '太', 'tài', 'cực, nhất, quá, lắm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2950, '泰斗', 'tàidǒu', 'ngôi sao sáng, nhân vật vĩ đại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2951, '态度', 'tàidù', 'thái độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2954, '台阶', 'táijiē', 'bậc thềm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2955, '太空', 'tàikōng', 'vũ trụ, bầu trời cao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2956, '太太', 'tàitai', 'vợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2957, '太阳', 'tàiyáng', 'mặt trời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2958, '谈', 'tán', 'nói chuyện, bàn luận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2959, '摊儿', 'tānr', 'sạp, quầy hàng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2960, '弹钢琴', 'tán gāngqín', 'đánh đàn piano', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2961, '坦白', 'tǎnbái', 'thẳng thắn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2962, '探测', 'tàncè', 'thăm dò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2963, '糖', 'táng', 'đường, kẹo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2964, '躺', 'tǎng', 'nằm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2965, '烫', 'tàng', 'nóng, bỏng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2967, '堂', 'táng', 'phòng lớn, nhà chính', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2968, '塘', 'táng', 'ao, đầm, hồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2969, '倘若', 'tǎngruò', 'nếu như, giả sử', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2970, '叹', 'tàn', 'thở dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2971, '瘫痪', 'tānhuàn', 'bại liệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2973, '谈判', 'tánpàn', 'cuộc đàm phán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2974, '叹气', 'tànqì', 'thở dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2976, '探讨', 'tàntǎo', 'thảo luận, bàn bạc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2977, '探望', 'tànwàng', 'thăm hỏi, viếng thăm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2978, '贪污', 'tānwū', 'tham ô, tham nhũng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2979, '弹性', 'tánxìng', 'đàn hồi, linh hoạt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2980, '桃', 'táo', 'quả đào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2981, '逃', 'táo', 'trốn thoát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2982, '套', 'tào', 'bộ, tập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2984, '讨价还价', 'tǎojià huánjià', 'mặc cả, trả giá', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2985, '讨论', 'tǎolùn', 'thảo luận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2986, '淘气', 'táoqì', 'nghịch ngợm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2987, '逃避', 'táobì', 'trốn tránh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2988, '讨厌', 'tǎoyàn', 'ghét, chán ghét', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2989, '踏实', 'tāshi', 'chân thật, thực tế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2990, '特别', 'tèbié', 'đặc biệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2991, '特长', 'tècháng', 'sở trường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2992, '特点', 'tèdiǎn', 'đặc điểm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2994, '疼', 'téng', 'đau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2995, '疼爱', 'téng’ài', 'thương yêu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2996, '特色', 'tèsè', 'đặc sắc', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2997, '特意', 'tèyì', 'cố ý, đặc biệt là', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2998, '特征', 'tèzhēng', 'đặc trưng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2999, '剔', 'ti', 'nhặt ra, gỡ ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3000, '题', 'tí', 'đề mục, đề tài', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3001, '踢足球', 'tī zúqiú', 'đá bóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3002, '甜', 'tián', 'ngọt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3003, '舔', 'tiǎn', 'liếm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3005, '田径', 'tiánjìng', 'điền kinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3006, '填空', 'tiánkòng', 'điền vào chỗ trống', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3009, '天气', 'tiānqì', 'thời tiết', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3010, '天然气', 'tiānránqì', 'khí đốt tự nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3011, '天生', 'tiānshēng', 'trời sinh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3012, '天堂', 'tiāntáng', 'thiên đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3013, '天文', 'tiānwén', 'thiên văn học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3014, '田野', 'tiányě', 'đồng ruộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3016, '条', 'tiáo', 'cành, mảnh, sợi, con (rắn, cá,…)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3017, '挑拨', 'tiǎobō', 'gây xích mích', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3018, '调和', 'tiáohé', 'hòa giải', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3019, '调节', 'tiáojié', 'điều chỉnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3020, '条件', 'tiáojiàn', 'điều kiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3021, '调整', 'tiáozhěng', 'điều chỉnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3022, '调解', 'tiáojiě', 'hòa giải', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3023, '条款', 'tiáokuǎn', 'điều khoản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3025, '调料', 'tiáoliào', 'đồ gia vị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3026, '调皮', 'tiáopí', 'nghịch ngợm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3027, '挑剔', 'tiāotì', 'soi mói, bắt lỗi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3028, '挑选', 'tiāoxuǎn', 'lựa chọn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3029, '挑战', 'tiǎozhàn', 'thách thức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3030, '提拔', 'tíbá', 'đề bạt, cất nhắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3031, '题材', 'tícái', 'chủ đề, nội dung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3032, '提倡', 'tíchàng', 'đề xướng, khởi xướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3033, '提纲', 'tígāng', 'đề cương, dàn ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3034, '提高', 'tígāo', 'nâng cao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3035, '提供', 'tígōng', 'cung cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3036, '体会', 'tǐhuì', 'cảm nhận, nhận thức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3048, '提前', 'tíqián', 'sớm, trước', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3112, '逃脱', 'tuōtuō', 'thoát ra, thoát khỏi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3073, '统统', 'tǒngtǒng', 'tất cả', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3096, '退', 'tuì', 'rút lui, lùi lại', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3099, '推迟', 'tuīchí', 'hoãn lại, trì hoãn', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3104, '推理', 'tuīlǐ', 'suy luận', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3105, '推论', 'tuīlùn', 'suy luận, lý luận', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3123, '兔子', 'tùzi', 'con thỏ', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3111, '土壤', 'tǔrǎng', 'đất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3137, '玩', 'wán', 'chơi', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3038, '体面', 'tǐmiàn', 'vẻ vang, danh giá', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3039, '题目', 'tímù', 'đề mục, tiêu đề', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3040, '体贴', 'tǐtiē', 'chăm sóc, quan tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3041, '听', 'tīng', 'nghe', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3043, '停车', 'tíngchē', 'dừng xe, đỗ xe', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3044, '停泊', 'tíngbó', 'cập bến, neo đậu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3046, '停滞', 'tíngzhì', 'đình trệ, dừng lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3047, '亭子', 'tíngzi', 'đình, chòi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3049, '提示', 'tíshì', 'nhắc nhở, gợi ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3050, '提问', 'tíwèn', 'đặt câu hỏi', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3051, '体系', 'tǐxì', 'hệ thống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3052, '体形', 'tǐxíng', 'hình thể, vóc dáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3053, '提醒', 'tíxǐng', 'nhắc nhở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3054, '体验', 'tǐyàn', 'trải nghiệm, thử nghiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3055, '提议', 'tíyì', 'đề nghị, đề xuất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3056, '体育', 'tǐyù', 'thể thao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3057, '铜', 'tóng', 'đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3058, '桶', 'tǒng', 'xô, thùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3060, '铜矿', 'tóng kuàng', 'quặng đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3061, '同胞', 'tóngbāo', 'đồng bào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3062, '通常', 'tōngcháng', 'thông thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3063, '统筹兼顾', 'tǒngchóu jiāngù', 'tính toán mọi bề', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3064, '通过', 'tōngguò', 'vượt qua, thông qua, đi qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3065, '童话', 'tónghuà', 'truyện cổ tích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3066, '统计', 'tǒngjì', 'thống kê', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3067, '痛苦', 'tòngkǔ', 'đau khổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3068, '痛快', 'tòngkuài', 'vui sướng, dễ chịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3070, '同时', 'tóngshí', 'đồng thời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3071, '同事', 'tóngshì', 'đồng nghiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3072, '通俗', 'tōngsú', 'phổ biến, thông tục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3074, '同学', 'tóngxué', 'bạn học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3075, '通讯', 'tōngxùn', 'truyền thông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3076, '统一', 'tǒngyī', 'thống nhất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3077, '通用', 'tōngyòng', 'chung dùng, thông dụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3078, '统治', 'tǒngzhì', 'thống trị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3079, '通知', 'tōngzhī', 'thông báo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3080, '头发', 'tóufa', 'tóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3081, '头', 'tóu', 'đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3082, '透明', 'tòumíng', 'trong suốt, minh bạch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3083, '投票', 'tóupiào', 'bỏ phiếu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3084, '投掷', 'tóuzhì', 'ném, quăng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3085, '投资', 'tóuzī', 'đầu tư', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3087, '团', 'tuán', 'nhóm, đoàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3088, '图案', 'tú’àn', 'hoa văn, hình vẽ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3089, '团结', 'tuánjié', 'đoàn kết', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3090, '团体', 'tuántǐ', 'tập thể, đoàn thể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3091, '团员', 'tuányuán', 'đoàn viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3092, '突出', 'tūchū', 'nổi bật, xuất sắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3093, '徒弟', 'túdì', 'đồ đệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3094, '土豆', 'tǔdòu', 'khoai tây', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3097, '退步', 'tuìbù', 'thụt lùi, đi lùi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3098, '推测', 'tuīcè', 'suy đoán, dự đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3100, '推辞', 'tuīcí', 'từ chối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3101, '推翻', 'tuīfān', 'lật đổ, đảo ngược', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3102, '推广', 'tuīguǎng', 'mở rộng, phổ biến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3106, '推销', 'tuīxiāo', 'bán hàng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3107, '退休', 'tuìxiū', 'nghỉ hưu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3108, '途径', 'tújìng', 'con đường, cách thức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3109, '涂抹', 'túmǒ', 'bôi, quét, tô', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3110, '屠杀', 'túshā', 'tàn sát, đồ sát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3113, '拖', 'tuō', 'kéo, lôi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3114, '脱', 'tuō', 'cởi, thoát, gỡ ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3116, '拖拉', 'tuōlā', 'kéo lê, lề mề', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3117, '拓展', 'tuòzhǎn', 'mở rộng, phát triển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3118, '椭圆', 'tuǒyuán', 'hình bầu dục', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3119, '托运', 'tuōyùn', 'ủy thác vận chuyển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3120, '突破', 'tūpò', 'đột phá', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3121, '突然', 'tūrán', 'đột nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3122, '图书馆', 'túshū guǎn', 'thư viện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3124, '哇', 'wa', 'oa, oà, oe, ồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3125, '外', 'wài', 'ngoài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3127, '外表', 'wàibiǎo', 'vẻ ngoài, bề ngoài', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3128, '外行', 'wàiháng', 'người ngoại nghề', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3129, '外交', 'wàijiāo', 'ngoại giao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3130, '外界', 'wàijiè', 'thế giới bên ngoài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3131, '歪曲', 'wāiqū', 'xuyên tạc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3132, '外向', 'wàixiàng', 'hướng ngoại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3134, '挖掘', 'wājué', 'khai quật, đào bới', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3135, '丸', 'wán', 'viên thuốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3136, '完', 'wán', 'xong, kết thúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3138, '万', 'wàn', 'vạn, mười nghìn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3140, '弯', 'wān', 'cong, uốn cong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3141, '万一', 'wànyī', 'vạn nhất, ngộ nhỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3142, '完备', 'wánbèi', 'hoàn toàn, đầy đủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3194, '围绕', 'wéirào', 'bao quanh, xoay quanh', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3149, '网络', 'wǎngluò', 'mạng', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3177, '位于', 'wèiyú', 'nằm ở, tọa lạc tại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3221, '文明', 'wénmíng', 'văn minh', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3152, '往往', 'wǎngwǎng', 'thường hay, thường thường', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3157, '挽救', 'wǎnjiù', 'cứu vãn, cứu giúp', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3161, '玩具', 'wánjù', 'đồ chơi', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3139, '碗', 'wǎn', 'bát', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3188, '畏惧', 'wèijù', 'sợ hãi, e ngại', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3189, '胃口', 'wèikǒu', 'khẩu vị, sự thèm ăn', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3176, '委屈', 'wěiqu', 'oan ức, tủi thân', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3203, '威信', 'wēixìn', 'uy tín', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3143, '完毕', 'wánbì', 'hoàn tất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3144, '完成', 'wánchéng', 'hoàn thành', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3145, '万分', 'wànfēn', 'vô cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3146, '完全', 'wánquán', 'hoàn toàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3147, '顽强', 'wánqiáng', 'ngoan cường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3148, '完整', 'wánzhěng', 'hoàn chỉnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3210, '问', 'wèn', 'hỏi', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3150, '网球', 'wǎngqiú', 'bóng bàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3217, '文凭', 'wénpíng', 'bằng cấp', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3153, '妄想', 'wàngxiǎng', 'mộng tưởng, ảo tưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3154, '网站', 'wǎngzhàn', 'trang web, website', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3155, '王子', 'wángzǐ', 'hoàng tử', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3156, '挽回', 'wǎnhuí', 'xoay chuyển, cứu vãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3239, '五', 'wǔ', 'năm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3158, '完美', 'wánměi', 'hoàn hảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3159, '晚上', 'wǎnshang', 'buổi tối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3224, '文学', 'wénxué', 'văn học', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3162, '娃娃', 'wáwa', 'búp bê', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3163, '挖', 'wā', 'đào, bới', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3164, '位', 'wèi', 'vị trí, chỗ, nơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3165, '为', 'wèi', 'vì, để', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3166, '喂', 'wèi', 'alo, này', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3167, '畏', 'wèi', 'sợ, e ngại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3168, '胃', 'wèi', 'dạ dày', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3169, '未必', 'wèibì', 'chưa hẳn, không nhất thiết', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3170, '唯独', 'wéidú', 'chỉ riêng, duy nhất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3171, '为了', 'wèile', 'để, vì', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3172, '围', 'wéi', 'vây quanh, bao quanh', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3174, '维护', 'wéihù', 'duy trì, bảo vệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3175, '尾巴', 'wěiba', 'đuôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3227, '文章', 'wénzhāng', 'bài văn, bài viết', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3229, '问题', 'wèntí', 'vấn đề', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3179, '维持', 'wéichí', 'duy trì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3180, '伟大', 'wěidà', 'vĩ đại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3181, '味道', 'wèidào', 'mùi vị, hương vị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3182, '违法', 'wéifǎ', 'vi phạm pháp luật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3183, '微风', 'wēifēng', 'vi phong, gió nhẹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3184, '微观', 'wēiguān', 'vi mô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3185, '危害', 'wēihài', 'nguy hại', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3186, '危机', 'wēijī', 'nguy cơ, khủng hoảng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3187, '围巾', 'wéijīn', 'khăn choàng cổ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3232, '文学家', 'wénxuéjiā', 'nhà văn học', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3219, '文件', 'wénjiàn', 'tài liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3190, '未来', 'wèilái', 'tương lai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3192, '未免', 'wèimiǎn', 'có hơi, khó tránh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3193, '为难', 'wéinán', 'lúng túng, khó xử', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3245, '无耻', 'wúchǐ', 'vô liêm sỉ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3195, '为什么', 'wèishénme', 'tại sao, vì sao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3196, '卫生间', 'wèishēngjiān', 'nhà vệ sinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3197, '维生素', 'wéishēngsù', 'vitamin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3198, '为首', 'wéishǒu', 'đứng đầu, cầm đầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3199, '委托', 'wěituō', 'ủy thác, nhờ vả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3200, '慰问', 'wèiwèn', 'thăm hỏi, an ủi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3201, '危险', 'wēixiǎn', 'nguy hiểm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3202, '威胁', 'wēixié', 'đe dọa, uy hiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3204, '卫星', 'wèixīng', 'vệ tinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3206, '唯一', 'wéiyī', 'duy nhất', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3207, '委员', 'wěiyuán', 'ủy viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3208, '伪造', 'wěizào', 'giả mạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3209, '位置', 'wèizhì', 'vị trí, chỗ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3211, '吻', 'wěn', 'hôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3212, '温带', 'wēndài', 'ôn đới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3213, '稳定', 'wěndìng', 'ổn định', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3214, '温度', 'wēndù', 'nhiệt độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3216, '文献', 'wénxiàn', 'văn hiến, tài liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3218, '文化', 'wénhuà', 'văn hóa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3220, '文具', 'wénjù', 'dụng cụ học tập', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3222, '文盲', 'wénmáng', 'mù chữ', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3223, '温暖', 'wēnnuǎn', 'ấm áp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3225, '文雅', 'wényǎ', 'tao nhã', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3228, '问候', 'wènhòu', 'hỏi thăm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3230, '吻合', 'wěnhé', 'phù hợp, ăn khớp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3231, '文物', 'wénwù', 'di vật, cổ vật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3233, '文书', 'wénshū', 'văn thư', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3234, '我们', 'wǒmen', 'chúng ta', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3236, '握手', 'wòshǒu', 'bắt tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3237, '无', 'wú', 'không có', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3238, '雾', 'wù', 'sương mù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3241, '无论如何', 'wúlùn rúhé', 'dù sao đi nữa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3242, '务必', 'wùbì', 'nhất thiết phải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3243, '无比', 'wúbǐ', 'không gì sánh bằng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3244, '无偿', 'wúcháng', 'không hoàn lại, không có đền bù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3246, '无从', 'wúcóng', 'không biết từ đâu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3247, '舞蹈', 'wǔdǎo', 'nhảy múa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3249, '无非', 'wúfēi', 'chẳng qua là, chỉ là', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3319, '相关', 'xiāngguān', 'có liên quan', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3277, '下', 'xià', 'xuống, dưới, kế tiếp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3284, '下令', 'xiàlìng', 'ban lệnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3287, '弦', 'xián', 'dây đàn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3349, '小吃', 'xiǎochī', 'đồ ăn vặt, món ăn nhẹ', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3293, '显示', 'xiǎnshì', 'thể hiện, trình bày', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3250, '乌黑', 'wūhēi', 'đen sì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3251, '误会', 'wùhuì', 'hiểu nhầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3252, '无赖', 'wúlài', 'lưu manh, vô lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3253, '无精打采', 'wújīng dǎcǎi', 'phờ phạc, ủ rũ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3255, '无礼', 'wúlǐ', 'vô lễ, bất lịch sự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3256, '无聊', 'wúliáo', 'nhạt nhẽo, vô vị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3257, '无能', 'wúnéng', 'bất lực, vô năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3258, '无论', 'wúlùn', 'bất luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3259, '无辜', 'wúgū', 'vô tội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3260, '无微不至', 'wúwēi bú zhì', 'chu đáo, tỉ mỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3261, '武器', 'wǔqì', 'vũ khí', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3262, '无穷无尽', 'wúqióng wújìn', 'vô cùng vô tận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3263, '污染', 'wūrǎn', 'ô nhiễm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3264, '侮辱', 'wǔrǔ', 'lăng nhục, sỉ nhục', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3265, '务实', 'wùshí', 'thực tế, thiết thực', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3266, '无所谓', 'wúsuǒwèi', 'không sao, không quan trọng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3267, '无知', 'wúzhī', 'ngu dốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3268, '物质', 'wùzhì', 'vật chất', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3270, '屋子', 'wūzi', 'ngôi nhà', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3271, '系', 'xì', 'buộc, cột, hệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3272, '洗', 'xǐ', 'giặt, rửa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3273, '溪', 'xī', 'suối, khe', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3274, '西', 'xī', 'tây', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3275, '系领带', 'xì lǐngdài', 'thắt cà vạt', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3278, '瞎', 'xiā', 'mù, mù quáng', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3279, '夏', 'xià', 'mùa hè', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3280, '峡', 'xiá', 'hẻm núi, khe sâu', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3281, '下雨', 'xià yǔ', 'trời mưa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3282, '狭隘', 'xiá’ài', 'hẹp hòi, thiển cận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3285, '鲜', 'xiān', 'tươi, mới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3286, '嫌', 'xián', 'ghét, chán ghét', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3288, '贤', 'xián', 'hiền lành, tài giỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3289, '县', 'xiàn', 'huyện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3291, '限', 'xiàn', 'hạn, giới hạn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3292, '显', 'xiǎn', 'rõ ràng, hiện rõ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3294, '显然', 'xiǎnrán', 'hiển nhiên, rõ ràng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3295, '显著', 'xiǎnzhù', 'rõ rệt, nổi bật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3296, '现场', 'xiànchǎng', 'hiện trường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3297, '现代', 'xiàndài', 'hiện đại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3298, '陷害', 'xiànhài', 'hãm hại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3300, '馅儿', 'xiàn er', 'nhân (bánh)', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3301, '现成', 'xiànchéng', 'có sẵn, vốn có', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3302, '显得', 'xiǎnde', 'lộ ra, hiện ra', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3303, '像', 'xiàng', 'giống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3304, '向', 'xiàng', 'hướng, về phía', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3305, '巷', 'xiàng', 'ngõ, hẻm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3306, '项', 'xiàng', 'hạng mục', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3307, '响', 'xiǎng', 'tiếng vang, vang lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3308, '想', 'xiǎng', 'nghĩ, muốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3309, '香', 'xiāng', 'thơm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3311, '相处', 'xiāngchǔ', 'sống chung, hòa hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3312, '相当', 'xiāngdāng', 'tương đương, tương xứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3313, '相对', 'xiāngduì', 'tương đối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3314, '相等', 'xiāngděng', 'bằng, ngang nhau', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3316, '相辅相成', 'xiāngfǔxiāngchéng', 'bổ trợ cho nhau', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3317, '相互', 'xiānghù', 'lẫn nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3318, '相连', 'xiānglián', 'liên kết, nối liền', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3320, '相声', 'xiàngsheng', 'tấu hài', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3321, '响亮', 'xiǎngliàng', 'vang dội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3322, '享受', 'xiǎngshòu', 'hưởng thụ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3323, '橡皮', 'xiàngpí', 'cục tẩy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3324, '象棋', 'xiàngqí', 'cờ tướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3325, '相亲相爱', 'xiāngqīnxiāng’ài', 'yêu thương nhau', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3326, '想象', 'xiǎngxiàng', 'tưởng tượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3327, '相信', 'xiāngxìn', 'tin tưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3328, '响应', 'xiǎngyìng', 'đáp lại, hưởng ứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3329, '相应', 'xiāngyìng', 'tương ứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3330, '象征', 'xiàngzhēng', 'tượng trưng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3331, '贤惠', 'xiánhuì', 'hiền thục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3333, '先进', 'xiānjìn', 'tiên tiến', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3334, '羡慕', 'xiànmù', 'ngưỡng mộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3335, '鲜明', 'xiānmíng', 'tươi sáng, rõ nét', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3336, '鲜艳', 'xiānyàn', 'sáng, tươi đẹp, rực rỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3337, '纤维', 'xiānwéi', 'sợi, chất xơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3338, '现实', 'xiànshí', 'thực tế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3339, '现象', 'xiànxiàng', 'hiện tượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3340, '献身', 'xiànshēn', 'hiến thân, cống hiến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3341, '限制', 'xiànzhì', 'hạn chế', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3342, '嫌弃', 'xiánqì', 'chê, ghét bỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3344, '嫌疑', 'xiányí', 'nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3345, '现在', 'xiànzài', 'bây giờ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3346, '现状', 'xiànzhuàng', 'hiện trạng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3347, '笑', 'xiào', 'cười', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3348, '小', 'xiǎo', 'nhỏ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3350, '消除', 'xiāochú', 'loại bỏ, loại trừ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3352, '消防', 'xiāofáng', 'chữa cháy, cứu hỏa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3363, '小麦', 'xiǎomài', 'lúa mì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3380, '鞋', 'xié', 'giày', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3447, '信心', 'xìnxīn', 'niềm tin', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3385, '血压', 'xiěyā', 'huyết áp', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3388, '鞋子', 'xiézi', 'đôi giày', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3389, '写', 'xiě', 'viết', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3400, '性别', 'xìngbié', 'giới tính', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3401, '性格', 'xìnggé', 'tính cách', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3404, '西红柿', 'xīhóngshì', 'cà chua', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3405, '喜欢', 'xǐhuan', 'thích', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3414, '信封', 'xìnfēng', 'phong bì, bao thư', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3354, '效果', 'xiàoguǒ', 'hiệu quả', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3355, '消耗', 'xiāohào', 'tiêu hao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3356, '笑话', 'xiàohuà', 'truyện cười', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3357, '消化', 'xiāohuà', 'tiêu hóa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3358, '销毁', 'xiāohuǐ', 'tiêu hủy, phá hủy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3359, '小伙子', 'xiǎohuǒzi', 'thanh niên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3360, '消息', 'xiāoxi', 'tin tức, thông tin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3361, '消极', 'xiāojí', 'tiêu cực', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3364, '消灭', 'xiāomiè', 'tiêu diệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3365, '小气', 'xiǎoqì', 'keo kiệt, bủn xỉn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3366, '小时', 'xiǎoshí', 'tiếng, giờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3367, '消失', 'xiāoshī', 'biến mất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3368, '销售', 'xiāoshòu', 'bán hàng, tiêu thụ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3369, '小说', 'xiǎoshuō', 'tiểu thuyết', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3370, '小偷', 'xiǎotōu', 'kẻ trộm, tên trộm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3371, '肖像', 'xiàoxiàng', 'chân dung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3372, '小心', 'xiǎoxīn', 'cẩn thận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3373, '小心翼翼', 'xiǎoxīnyìyì', 'thận trọng, tỉ mỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3374, '效益', 'xiàoyì', 'lợi ích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3375, '校长', 'xiàozhǎng', 'hiệu trưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3376, '下属', 'xiàshǔ', 'cấp dưới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3378, '细胞', 'xìbāo', 'tế bào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3379, '斜', 'xié', 'nghiêng, xiên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3429, '兴趣', 'xìngqù', 'hứng thú', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3381, '携带', 'xiédài', 'mang theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3382, '协会', 'xiéhuì', 'hiệp hội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3383, '协调', 'xiétiáo', 'phối hợp, điều hòa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3384, '泄漏', 'xièlòu', 'rò rỉ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3440, '信赖', 'xìnlài', 'tin cậy', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3387, '协助', 'xiézhù', 'giúp đỡ, hỗ trợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3445, '新娘', 'xīnniáng', 'cô dâu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3452, '心血', 'xīnxuè', 'tâm huyết, tâm sức', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3390, '谢谢', 'xièxie', 'cảm ơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3391, '斜坡', 'xiépō', 'dốc nghiêng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3392, '卸', 'xiè', 'tháo dỡ, dỡ hàng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3393, '辛苦', 'xīnkǔ', 'vất vả, cực khổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3394, '新', 'xīn', 'mới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3395, '心', 'xīn', 'tim, lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3396, '信', 'xìn', 'thư, tin, tín hiệu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3397, '行动', 'xíngdòng', 'hành động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3398, '行', 'xíng', 'được, đi, làm, giỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3457, '信誉', 'xìnyù', 'danh dự, uy tín', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3402, '行为', 'xíngwéi', 'hành vi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3406, '袭击', 'xíjí', 'tập kích, tấn công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3407, '细节', 'xìjié', 'chi tiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3408, '戏剧', 'xìjù', 'kịch, tuồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3409, '细菌', 'xìjūn', 'vi khuẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3410, '系列', 'xìliè', 'chuỗi, loạt, hàng loạt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3411, '熄灭', 'xīmiè', 'dập tắt, tắt ngấm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3413, '心得', 'xīndé', 'tâm đắc, điều tâm đắc', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3415, '姓', 'xìng', 'họ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3416, '醒', 'xǐng', 'tỉnh, tỉnh táo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3417, '腥', 'xīng', 'tanh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3418, '形成', 'xíngchéng', 'hình thành', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3419, '幸福', 'xìngfú', 'hạnh phúc', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3420, '性感', 'xìnggǎn', 'gợi cảm, hấp dẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3421, '兴高采烈', 'xìnggāocǎiliè', 'vô cùng phấn khởi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3422, '幸运', 'xìngyùn', 'may mắn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3423, '行李箱', 'xínglǐ xiāng', 'va-li, hành lý', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3424, '兴隆', 'xīnglóng', 'hưng thịnh, thịnh vượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3425, '性命', 'xìngmìng', 'tính mạng, sinh mệnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3426, '兴盛', 'xīngshèng', 'hưng thịnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3427, '星期', 'xīngqī', 'ngày thứ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3430, '行人', 'xíngrén', 'người đi bộ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3431, '形容', 'xíngróng', 'hình dung, miêu tả', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3432, '刑事', 'xíngshì', 'hình sự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3433, '形式', 'xíngshì', 'hình thức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3434, '形态', 'xíngtài', 'hình thái', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3435, '兴旺', 'xīngwàng', 'hưng thịnh, phồn vinh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3436, '形象', 'xíngxiàng', 'hình tượng, hình ảnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3437, '行政', 'xíngzhèng', 'hành chính', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3438, '性质', 'xìngzhì', 'tính chất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3439, '信号', 'xìnhào', 'tín hiệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3442, '心理', 'xīnlǐ', 'tâm lý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3443, '心灵', 'xīnlíng', 'tâm linh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3444, '信念', 'xìnniàn', 'niềm tin, lòng tin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3446, '新鲜', 'xīnxiān', 'tươi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3449, '信使', 'xìnshǐ', 'sứ giả, người đưa tin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3450, '心痛', 'xīntòng', 'đau lòng, thương xót', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3451, '欣欣向荣', 'xīnxīnxiàngróng', 'phát triển tươi tốt, thịnh vượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3453, '心眼儿', 'xīnyǎnr', 'nội tâm, lòng dạ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3454, '信仰', 'xìnyǎng', 'tín ngưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3455, '新颖', 'xīnyǐng', 'mới mẻ, độc đáo', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3456, '信用卡', 'xìnyòngkǎ', 'thẻ tín dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3462, '雄厚', 'xiónghòu', 'hùng hậu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3473, '修', 'xiū', 'sửa chữa, tu sửa', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3474, '绣', 'xiù', 'thêu', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3475, '修理', 'xiūlǐ', 'sửa chữa', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3486, '洗澡', 'xǐzǎo', 'tắm, tắm rửa', NULL, 39);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3490, '宣传', 'xuānchuán', 'tuyên truyền', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3495, '宣誓', 'xuānshì', 'tuyên thệ', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3496, '选手', 'xuǎnshǒu', 'tuyển thủ, đấu thủ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3508, '学生', 'xuéshēng', 'sinh viên, học sinh', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3459, '胸', 'xiōng', 'ngực', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3461, '凶恶', 'xiōng’è', 'hung ác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3509, '学术', 'xuéshù', 'học thuật', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3463, '胸怀', 'xiōnghuái', 'lòng dạ, tấm lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3464, '熊猫', 'xióngmāo', 'gấu trúc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3465, '凶手', 'xiōngshǒu', 'kẻ giết người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3466, '胸膛', 'xiōngtáng', 'lồng ngực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3468, '昔日', 'xīrì', 'ngày xưa, trước kia', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3469, '牺牲', 'xīshēng', 'hi sinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3470, '吸收', 'xīshōu', 'hấp thụ, hấp thu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3471, '洗手间', 'xǐshǒujiān', 'nhà vệ sinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3472, '习俗', 'xísú', 'tập tục, phong tục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3513, '学习', 'xuéxí', 'học tập', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3524, '殉道', 'xùndào', 'tử vì đạo', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3532, '序言', 'xùyán', 'lời nói đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3476, '休息', 'xiūxi', 'nghỉ ngơi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3477, '休闲', 'xiūxián', 'nghỉ ngơi, giải trí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3478, '修养', 'xiūyǎng', 'tu dưỡng, điều dưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3479, '希望', 'xīwàng', 'hy vọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3481, '续', 'xù', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3482, '夕阳', 'xīyáng', 'mặt trời lặn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3483, '洗衣机', 'xǐyījī', 'máy giặt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3484, '吸引', 'xīyǐn', 'thu hút, hấp dẫn', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3485, '喜悦', 'xǐyuè', 'vui mừng, sung sướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3535, '牙膏', 'yágāo', 'kem đánh răng', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3487, '细致', 'xìzhì', 'tỉ mỉ, kỹ lưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3488, '叙述', 'xùshù', 'tường thuật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3489, '宣布', 'xuānbù', 'tuyên bố, công bố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3537, '亚军', 'yàjūn', 'á quân', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3491, '宣扬', 'xuānyáng', 'tuyên dương, ca ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3492, '选举', 'xuǎnjǔ', 'bầu cử', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3493, '旋律', 'xuánlǜ', 'giai điệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3539, '盐', 'yán', 'muối', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3550, '羊肉', 'yángròu', 'thịt dê', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3497, '悬殊', 'xuánshū', 'khác xa, chênh lệch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3498, '悬崖峭壁', 'xuányáqiàobì', 'vách núi hiểm trở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3499, '选', 'xuǎn', 'chọn, tuyển chọn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3500, '旋转', 'xuánzhuǎn', 'quay tròn, xoay chuyển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3501, '许多', 'xǔduō', 'nhiều, rất nhiều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3502, '血', 'xuè', 'máu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3503, '雪', 'xuě', 'tuyết', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3504, '学历', 'xuélì', 'học vấn, trình độ học vấn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3505, '学期', 'xuéqī', 'học kỳ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3506, '虚弱', 'xūruò', 'suy yếu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3510, '学说', 'xuéshuō', 'học thuyết', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3511, '学位', 'xuéwèi', 'học vị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3512, '学问', 'xuéwèn', 'học vấn, tri thức', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3514, '学校', 'xuéxiào', 'trường học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3515, '虚假', 'xūjiǎ', 'giả tạo, giả dối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3516, '酗酒', 'xùjiǔ', 'say rượu, nghiện rượu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3517, '许可', 'xǔkě', 'giấy phép', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3518, '恤', 'xù', 'thương xót', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3519, '循环', 'xúnhuán', 'tuần hoàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3520, '训练', 'xùnliàn', 'huấn luyện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3521, '巡逻', 'xúnluó', 'đi tuần', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3522, '寻觅', 'xúnmì', 'tìm kiếm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3523, '迅速', 'xùnsù', 'nhanh chóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3525, '询问', 'xúnwèn', 'hỏi, hỏi thăm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3527, '寻找', 'xúnzhǎo', 'tìm kiếm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3528, '熏', 'xūn', 'hun, xông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3529, '勋章', 'xūnzhāng', 'huân chương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3530, '虚伪', 'xūwěi', 'giả dối, đạo đức giả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3531, '序号', 'xùhào', 'số thứ tự', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3533, '需要', 'xūyào', 'cần, cần thiết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3534, '呀', 'ya', 'a, à, nhé…', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3536, '押金', 'yājīn', 'tiền đặt cọc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3538, '压力', 'yālì', 'áp lực', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3541, '延长', 'yáncháng', 'kéo dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3542, '演出', 'yǎnchū', 'biểu diễn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3543, '养', 'yǎng', 'nuôi dưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3545, '养成', 'yǎngchéng', 'nuôi nấng, hình thành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3546, '掩盖', 'yǎngài', 'che đậy, bao phủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3547, '阳光', 'yángguāng', 'ánh sáng mặt trời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3548, '样品', 'yàngpǐn', 'hàng mẫu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3549, '氧气', 'yǎngqì', 'oxy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3552, '宴会', 'yànhuì', 'bữa tiệc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3553, '眼光', 'yǎnguāng', 'ánh mắt, tầm nhìn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3554, '沿海', 'yánhǎi', 'duyên hải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3555, '严寒', 'yánhán', 'rét đậm, rét hại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3556, '掩护', 'yǎnhù', 'che chở, bảo vệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3558, '言行', 'yánxíng', 'lời nói và hành động', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3559, '研究生', 'yánjiūshēng', 'nghiên cứu sinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3560, '严谨', 'yánjǐn', 'nghiêm túc, cẩn trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3561, '严厉', 'yánlì', 'nghiêm khắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3562, '言论', 'yánlùn', 'ngôn luận, lời bàn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3582, '摇', 'yáo', 'rung, lắc, đung đưa', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3615, '一', 'yī', 'số một', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3661, '营业', 'yíngyè', 'kinh doanh', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3583, '药', 'yào', 'thuốc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3616, '亿', 'yì', 'một trăm triệu', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3620, '一辈子', 'yībèizi', 'cả đời, một đời', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3623, '遗产', 'yíchǎn', 'di sản', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3624, '移民', 'yímín', 'di dân', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3626, '依次', 'yīcì', 'lần lượt, theo thứ tự', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3628, '一定', 'yídìng', 'nhất định, chắc chắn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3563, '严密', 'yánmì', 'chặt chẽ, kín đáo', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3564, '淹没', 'yānmò', 'chìm ngập, nhấn chìm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3566, '炎热', 'yánrè', 'nóng bức, gay gắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3567, '颜色', 'yánsè', 'màu sắc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3568, '眼色', 'yǎnsè', 'ánh mắt, năng lực quan sát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3569, '延伸', 'yánshēn', 'kéo dài, mở rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3570, '眼神', 'yǎnshén', 'ánh mắt, thị lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3572, '掩饰', 'yǎnshì', 'che giấu, che đậy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3573, '验收', 'yànshōu', 'nghiệm thu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3574, '严肃', 'yánsù', 'nghiêm túc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3575, '厌恶', 'yànwù', 'ghét, chán ghét', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3576, '演习', 'yǎnxí', 'diễn tập', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3577, '延续', 'yánxù', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3579, '演员', 'yǎnyuán', 'diễn viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3580, '验证', 'yànzhèng', 'kiểm chứng, xác nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3581, '演奏', 'yǎnzòu', 'diễn tấu, biểu diễn nhạc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3636, '以后', 'yǐhòu', 'sau này, sau khi', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3653, '饮料', 'yǐnliào', 'nước uống, đồ uống', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3584, '要', 'yào', 'cần, phải, muốn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3585, '咬', 'yǎo', 'cắn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3586, '要不', 'yàobù', 'nếu không thì', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3587, '要不然', 'yàobùrán', 'nếu không thì, bằng không', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3588, '摇摆', 'yáobǎi', 'đung đưa, lắc lư', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3589, '腰', 'yāo', 'eo, thắt lưng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3591, '耀眼', 'yàoyǎn', 'chói mắt, lóa mắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3592, '遥远', 'yáoyuǎn', 'xa xôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3593, '要素', 'yàosù', 'yếu tố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3594, '摇晃', 'yáohuàng', 'đung đưa, lắc lư', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3595, '遥控', 'yáokòng', 'điều khiển từ xa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3596, '要命', 'yàomìng', 'chết người, kinh khủng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3597, '邀请', 'yāoqǐng', 'mời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3598, '要求', 'yāoqiú', 'yêu cầu, đòi hỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3599, '钥匙', 'yàoshi', 'chìa khóa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3600, '压抑', 'yāyì', 'kiềm chế, nén lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3601, '压岁钱', 'yāsuìqián', 'tiền mừng tuổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3602, '亚洲', 'yàzhōu', 'châu Á', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3603, '压迫', 'yāpò', 'áp bức', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3605, '压榨', 'yāzhà', 'ép, bóp, vắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3606, '压制', 'yāzhì', 'áp chế, kìm nén', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3607, '夜', 'yè', 'đêm', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3608, '页', 'yè', 'trang, tờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3609, '也', 'yě', 'cũng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3610, '业余', 'yèyú', 'nghiệp dư', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3611, '业务', 'yèwù', 'nghiệp vụ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3612, '野蛮', 'yěmán', 'man rợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3613, '野心', 'yěxīn', 'dã tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3654, '隐蔽', 'yǐnbì', 'ẩn náu, giấu kín', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3617, '乙', 'yǐ', 'thứ hai, Ất, B', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3618, '以', 'yǐ', 'lấy, bởi vì, để, nhằm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3621, '一边', 'yībiān', 'một bên, một mặt, vừa... vừa...', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3622, '以便', 'yǐbiàn', 'để, nhằm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3625, '遗传', 'yíchuán', 'di truyền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3627, '一会儿', 'yíhuìr', 'một lát, chốc lát', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3629, '移动', 'yídòng', 'di chuyển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3630, '一度', 'yídù', 'một lần', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3633, '一共', 'yīgòng', 'tổng cộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3634, '以免', 'yǐmiǎn', 'tránh, khỏi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3637, '疑惑', 'yíhuò', 'nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3638, '以及', 'yǐjí', 'và, cùng với', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3639, '意见', 'yìjiàn', 'ý kiến, quan điểm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3640, '已经', 'yǐjīng', 'đã, rồi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3641, '依旧', 'yījiù', 'như cũ, vẫn như trước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3642, '依靠', 'yīkào', 'dựa vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3643, '一举两得', 'yījǔliǎngdé', 'một công đôi việc', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3644, '以来', 'yǐlái', 'từ nay, trở lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3645, '医疗', 'yīliáo', 'y tế, chữa bệnh', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3646, '遗留', 'yíliú', 'để lại, lưu lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3647, '一流', 'yīliú', 'hạng nhất, loại một', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3648, '一律', 'yīlǜ', 'đều, như nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3650, '一目了然', 'yīmù liǎorán', 'nhìn một cái là hiểu ngay', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3651, '银', 'yín', 'bạc', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3652, '阴', 'yīn', 'âm, trời râm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3655, '因此', 'yīncǐ', 'vì thế, do đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3656, '引导', 'yǐndǎo', 'hướng dẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3657, '因而', 'yīn’ér', 'vì thế, do đó', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3658, '硬', 'yìng', 'cứng, rắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3659, '硬币', 'yìngbì', 'tiền xu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3660, '迎接', 'yíngjiē', 'đón tiếp, nghênh đón', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3662, '英俊', 'yīngjùn', 'anh tuấn, khôi ngô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3663, '盈利', 'yínglì', 'lợi nhuận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3664, '英明', 'yīngmíng', 'sáng suốt, anh minh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3666, '影响', 'yǐngxiǎng', 'ảnh hưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3668, '应付', 'yìngfu', 'ứng phó, đối phó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3670, '应聘', 'yìngpìn', 'ứng tuyển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3677, '银行', 'yínháng', 'ngân hàng', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3688, '音响', 'yīnxiǎng', 'nhạc cụ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3679, '隐瞒', 'yǐnmán', 'che giấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3680, '阴谋', 'yīnmóu', 'âm mưu', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3684, '印刷', 'yìnshuā', 'in ấn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3708, '意味着', 'yìwèizhè', 'nghĩa là', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3710, '义务', 'yìwù', 'nghĩa vụ', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3717, '意志', 'yìzhì', 'ý chí', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3763, '幼稚', 'yòuzhì', 'ấu trĩ, non nớt', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3734, '用途', 'yòngtú', 'công dụng, phạm vi sử dụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3635, '以往', 'yǐwǎng', 'trước kia, trong quá khứ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3665, '英雄', 'yīngxióng', 'anh hùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3669, '应用', 'yìngyòng', 'ứng dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3671, '应酬', 'yìngchou', 'tiệc tùng, xã giao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3672, '应邀', 'yìngyāo', 'nhận lời mời', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3673, '应当', 'yìngdāng', 'nên, phải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3675, '影子', 'yǐngzi', 'bóng, hình bóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3676, '迎合', 'yínghé', 'đón ý, chiều lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3678, '隐患', 'yǐnhuàn', 'tai hoạ ngầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3682, '引擎', 'yǐnqíng', 'động cơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3683, '饮食', 'yǐnshí', 'ăn uống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3685, '因素', 'yīnsù', 'nhân tố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3686, '因为', 'yīnwèi', 'bởi vì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3687, '印象', 'yìnxiàng', 'ấn tượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3689, '引用', 'yǐnyòng', 'trích dẫn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3690, '隐约', 'yǐnyuē', 'lờ mờ, thấp thoáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3691, '音乐', 'yīnyuè', 'âm nhạc', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3693, '以前', 'yǐqián', 'trước đây, trước kia', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3694, '一切', 'yīqiè', 'tất cả', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3695, '毅然', 'yìrán', 'kiên quyết, không do dự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3696, '依然', 'yīrán', 'như cũ, vẫn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3697, '一如既往', 'yīrújìwǎng', 'trước sau như một', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3698, '医生', 'yīshēng', 'bác sĩ', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3699, '仪式', 'yíshì', 'nghi lễ, nghi thức', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3700, '意识', 'yìshí', 'ý thức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3702, '意思', 'yìsi', 'ý nghĩa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3703, '一丝不苟', 'yīsībùgǒu', 'cẩn thận, không sơ suất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3704, '意图', 'yìtú', 'mục đích, ý đồ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3705, '依托', 'yītuō', 'dựa vào, nhờ vào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3706, '意外', 'yìwài', 'bất ngờ, ngoài ý muốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3707, '以为', 'yǐwéi', 'tưởng rằng, cho rằng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3709, '疑问', 'yíwèn', 'nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3712, '一样', 'yíyàng', 'giống như', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3713, '意义', 'yìyì', 'ý nghĩa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3714, '医院', 'yīyuàn', 'bệnh viện', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3715, '一再', 'yízài', 'nhiều lần, hết lần này đến lần khác', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3716, '一直', 'yīzhí', 'liên tục, suốt, luôn luôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3718, '抑制', 'yìzhì', 'kiềm chế, kìm hãm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3719, '一致', 'yízhì', 'nhất trí, đồng lòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3720, '以致', 'yǐzhì', 'do đó, khiến cho', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3721, '椅子', 'yǐzi', 'ghế', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3722, '拥抱', 'yōngbào', 'ôm, cái ôm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3724, '用功', 'yònggōng', 'chăm chỉ, siêng năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3725, '永恒', 'yǒnghéng', 'vĩnh hằng, mãi mãi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3726, '用户', 'yònghù', 'người sử dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3727, '拥护', 'yōnghù', 'ủng hộ, tán thành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3728, '拥挤', 'yōngjǐ', 'chật chội, đông đúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3729, '勇气', 'yǒngqì', 'dũng cảm, can đảm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3730, '用', 'yòng', 'dùng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3731, '勇于', 'yǒngyú', 'dám, có gan', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3733, '用人', 'yòngrén', 'dùng người', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3735, '庸俗', 'yōngsú', 'tầm thường, dung tục', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3736, '涌现', 'yǒngxiàn', 'tuôn ra, xuất hiện nhiều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3737, '拥有', 'yǒngyǒu', 'có, sở hữu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3738, '永远', 'yǒngyuǎn', 'vĩnh viễn, mãi mãi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3739, '踊跃', 'yǒngyuè', 'nhảy nhót, hăng hái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3740, '由', 'yóu', 'do, bởi, từ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3741, '又', 'yòu', 'lại, vừa…lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3742, '有', 'yǒu', 'có', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3744, '油炸', 'yóu zhá', 'rán bằng dầu mỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3745, '右边', 'yòubiān', 'bên phải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3746, '幼儿园', 'yòu’éryuán', 'trường mẫu giáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3747, '友好', 'yǒuhǎo', 'bạn thân, thân thiện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3748, '优惠', 'yōuhuì', 'ưu đãi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3749, '有害', 'yǒuhài', 'có hại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3750, '有趣', 'yǒuqù', 'thú vị, lý thú', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3751, '有名', 'yǒumíng', 'nổi tiếng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3752, '幽默', 'yōumò', 'hài hước, vui tính', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3753, '游泳', 'yóuyǒng', 'bơi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3754, '优秀', 'yōuxiù', 'ưu tú, xuất sắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3755, '游戏', 'yóuxì', 'trò chơi', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3757, '友谊', 'yǒuyì', 'tình hữu nghị, bạn bè', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3758, '优异', 'yōuyì', 'xuất sắc, vượt trội', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3759, '由于', 'yóuyú', 'bởi vì, do', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3760, '犹豫', 'yóuyù', 'do dự, ngập ngừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3761, '忧郁', 'yōuyù', 'buồn rầu, u sầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3762, '优越', 'yōuyuè', 'ưu việt, vượt trội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3764, '鱼', 'yú', 'cá', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3765, '愈', 'yù', 'khoẻ bệnh, hết bệnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3766, '与', 'yǔ', 'với, cùng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3768, '圆', 'yuán', 'tròn, viên mãn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3769, '远', 'yuǎn', 'xa, xa xôi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3770, '元旦', 'yuándàn', 'tết Dương lịch', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3792, '阅读', 'yuèdú', 'đọc hiểu', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3806, '运气', 'yùnqì', 'vận khí, may mắn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3836, '灾难', 'zāinàn', 'tai nạn', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3872, '扎', 'zhā', 'chích, đâm, đâm vào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3793, '岳父', 'yuèfù', 'bố vợ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3801, '舆论', 'yúlùn', 'dư luận', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3823, '预习', 'yùxí', 'học trước bài', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3844, '杂志', 'zázhì', 'tạp chí', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3858, '遭受', 'zāoshòu', 'gặp, bị, chịu', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3862, '咋', 'zǎ', 'thì', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3772, '原谅', 'yuánliàng', 'thứ lỗi, tha thứ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3773, '原料', 'yuánliào', 'nguyên liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3775, '园林', 'yuánlín', 'vườn, công viên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3776, '原始', 'yuánshǐ', 'nguyên thuỷ, ban sơ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3777, '原先', 'yuánxiān', 'trước kia, ban đầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3778, '元首', 'yuánshǒu', 'nguyên thủ, người đứng đầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3779, '远处', 'yuǎnchù', 'nơi xa, chỗ xa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3780, '元素', 'yuánsù', 'nguyên tố', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3781, '愿望', 'yuànwàng', 'nguyện vọng, mong muốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3782, '冤枉', 'yuānwǎng', 'bị oan, oan uổng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3783, '元宵节', 'yuánxiāojié', 'Tết Nguyên Tiêu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3784, '愿意', 'yuànyì', 'bằng lòng, mong muốn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3785, '原因', 'yuányīn', 'nguyên nhân', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3786, '原则', 'yuánzé', 'nguyên tắc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3788, '愚蠢', 'yúchǔn', 'ngu xuẩn, ngốc nghếch', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3789, '预订', 'yùdìng', 'đặt trước, dự định', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3790, '月', 'yuè', 'tháng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3791, '越', 'yuè', 'vượt qua, ngày càng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3794, '约会', 'yuēhuì', 'hẹn hò', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3795, '月亮', 'yuèliang', 'mặt trăng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3797, '约束', 'yuēshù', 'hạn chế, ràng buộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3798, '语法', 'yǔfǎ', 'ngữ pháp', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3799, '愉快', 'yúkuài', 'vui vẻ, hạnh phúc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3800, '娱乐', 'yúlè', 'giải trí', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3802, '羽毛球', 'yǔmáoqiú', 'cầu lông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3803, '玉米', 'yùmǐ', 'ngô', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3804, '允许', 'yǔnxǔ', 'cho phép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3807, '运动', 'yùndòng', 'vận động, thể thao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3808, '云', 'yún', 'mây', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3809, '晕', 'yūn', 'say (xe, tàu), chóng mặt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3810, '孕妇', 'yùnfù', 'phụ nữ mang thai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3811, '运用', 'yùnyòng', 'vận dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3813, '运算', 'yùnsuàn', 'tính toán, làm toán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3814, '运行', 'yùnxíng', 'vận hành', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3815, '预期', 'yùqī', 'dự tính, mong đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3816, '与其', 'yǔqí', 'thà... còn hơn', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3817, '语气', 'yǔqì', 'ngữ khí', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3818, '与日俱增', 'yǔrìjùzēng', 'tăng lên từng ngày', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3819, '制服', 'yùfú', 'đồng phục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3820, '预算', 'yùsuàn', 'dự toán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3821, '于是', 'yúshì', 'thế là, do đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3822, '欲望', 'yùwàng', 'ham muốn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3824, '预先', 'yùxiān', 'trước tiên, sẵn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3825, '语言', 'yǔyán', 'ngôn ngữ', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3827, '寓言', 'yùyán', 'truyện ngụ ngôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3828, '预言', 'yùyán', 'tiên đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3830, '宇宙', 'yǔzhòu', 'vũ trụ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3831, '杂', 'zá', 'tạp, pha tạp', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3832, '咱', 'zán', 'chúng ta', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3833, '再', 'zài', 'lại, nữa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3835, '灾害', 'zāihài', 'tai hoạ, thiên tai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3837, '在', 'zài', 'tại, ở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3838, '再见', 'zàijiàn', 'tạm biệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3839, '在乎', 'zàihū', 'lưu ý, để ý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3840, '再接再厉', 'zàijiēzàilì', 'không ngừng cố gắng, nỗ lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3841, '栽培', 'zāipéi', 'vun xới, vun trồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3842, '在意', 'zàiyì', 'lưu ý, lưu tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3843, '杂技', 'zájì', 'tạp kỹ, xiếc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3846, '赞成', 'zànchéng', 'tán thành, đồng ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3847, '脏', 'zāng', 'bẩn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3848, '赞美', 'zànměi', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3849, '咱们', 'zánmen', 'chúng ta', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3850, '暂时', 'zànshí', 'tạm thời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3851, '赞叹', 'zàntàn', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3852, '赞同', 'zàntóng', 'tán đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3854, '赞助', 'zànzhù', 'tài trợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3855, '造反', 'zàofǎn', 'phản loạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3856, '糟糕', 'zāogāo', 'hỏng bét, gay go', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3857, '早晨', 'zǎochén', 'buổi sáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3859, '造成', 'zàochéng', 'tạo thành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3860, '遭遇', 'zāoyù', 'gặp gỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3861, '噪音', 'zàoyīn', 'tiếng ồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3863, '责备', 'zébèi', 'khiển trách', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3864, '责怪', 'zéguài', 'khiển trách', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3865, '贼', 'zéi', 'kẻ trộm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3866, '增加', 'zēngjiā', 'tăng thêm, tăng lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3868, '增长', 'zēngzhǎng', 'tăng lên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3869, '怎么', 'zěnme', 'thế nào, sao, làm sao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3870, '怎么样', 'zěnme yàng', 'thế nào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3871, '责任', 'zérèn', 'trách nhiệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3873, '窄', 'zhǎi', 'hẹp, chật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3874, '摘', 'zhāi', 'hái, bẻ, ngắt, lấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3875, '债券', 'zhàiquàn', 'phiếu công trái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3876, '摘要', 'zhāiyào', 'trích yếu, tóm tắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3919, '折', 'zhé', 'gập lại', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3895, '占据', 'zhànjù', 'chiếm, giữ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3953, '真实', 'zhēnshí', 'chân thật, chân thực', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3900, '占有', 'zhànyǒu', 'chiếm', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3902, '找', 'zhǎo', 'tìm', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3905, '着急', 'zháojí', 'sốt ruột, lo lắng', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3894, '照片', 'zhàopiàn', 'bức ảnh', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3927, '珍贵', 'zhēnguì', 'quý giá', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3954, '征收', 'zhēngshōu', 'trưng thu', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3879, '战斗', 'zhàndòu', 'chiến đấu, đánh nhau', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3880, '涨', 'zhǎng', 'lớn, căng, trướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3881, '障碍', 'zhàng’ài', 'chướng ngại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3882, '长辈', 'zhǎngbèi', 'đàn anh, trưởng bối', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3883, '章程', 'zhāngchéng', 'điều lệ, quy tắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3884, '丈夫', 'zhàngfu', 'chồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3885, '账户', 'zhànghù', 'tài khoản', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3886, '帐篷', 'zhàngpeng', 'lều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3887, '掌握', 'zhǎngwò', 'nắm vững', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3888, '掌声', 'zhǎngshēng', 'tiếng vỗ tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3889, '照常', 'zhàocháng', 'như thường lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3890, '照顾', 'zhàogù', 'chăm sóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3891, '召开', 'zhàokāi', 'triệu tập, mời dự họp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3892, '照亮', 'zhàoliàng', 'soi sáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3965, '真理', 'zhēnlǐ', 'chân lí, sự thật', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3973, '震压', 'zhènyā', 'đàn áp, trấn áp', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3896, '展现', 'zhǎnxiàn', 'bày ra, hiện ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3897, '崭新', 'zhǎnxīn', 'mới tinh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3898, '瞻仰', 'zhānyǎng', 'chiêm ngưỡng, nhìn cung kính', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3899, '战役', 'zhànyì', 'chiến dịch', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3977, '只', 'zhī', 'chỉ', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3901, '战争', 'zhànzhēng', 'chiến tranh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3903, '招投标', 'zhāo tóubiāo', 'đấu thầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3904, '招待', 'zhāodài', 'chiêu đãi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3906, '着凉', 'zháoliáng', 'cảm lạnh, nhiễm lạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3907, '照料', 'zhàoliào', 'chăm sóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3908, '着迷', 'zháomí', 'say mê, say sưa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3910, '朝气蓬勃', 'zhāoqì péngbó', 'tràn đầy khí bồng bột như khởi ban mai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3911, '招收', 'zhāoshōu', 'chiêu mộ, tuyển nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3912, '照样', 'zhàoyàng', 'như thường lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3913, '照耀', 'zhàoyào', 'chiếu sáng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3914, '照应', 'zhàoyìng', 'phối hợp, ăn khớp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3915, '沼泽', 'zhǎozé', 'đầm lầy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3916, '诈骗', 'zhàpiàn', 'lừa dối, lừa bịp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3917, '扎实', 'zhāshi', 'vững chắc, chắc chắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3918, '者', 'zhě', 'người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3921, '折磨', 'zhémó', 'dằn vặt, giày vò', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3922, '阵', 'zhèn', 'trận, cơn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3923, '震荡', 'zhèndàng', 'trấn động, rung động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3924, '针对', 'zhēnduì', 'nhằm vào, chĩa vào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3925, '振奋', 'zhènfèn', 'phấn chấn, phấn khởi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3926, '真', 'zhēn', 'thật, chính xác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3928, '诊断', 'zhěnduàn', 'chẩn đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3929, '振动', 'zhèndòng', 'rung động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3931, '镇静', 'zhènjìng', 'trấn tĩnh, điềm tĩnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3932, '正', 'zhèng', 'chính, ngay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3933, '政府', 'zhèngfǔ', 'chính phủ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3934, '正确', 'zhèngquè', 'chính xác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3935, '政策', 'zhèngcè', 'chính sách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3936, '正常', 'zhèngcháng', 'bình thường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3937, '正当', 'zhèngdàng', 'giữa lúc, trong lúc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3938, '争端', 'zhēngduān', 'tranh chấp', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3939, '争夺', 'zhēngduó', 'tranh đoạt, tranh giành', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3940, '整顿', 'zhěngdùn', 'sắp xếp, chỉnh đốn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3941, '正派', 'zhèngpài', 'ngay thẳng, đoan chính', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3942, '整齐', 'zhěngqí', 'ngăn nắp, trật tự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3943, '正规', 'zhèngguī', 'chính quy, nề nếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3944, '正好', 'zhènghǎo', 'vừa hay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3946, '正经', 'zhèngjīng', 'đoan trang, chính phái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3947, '证据', 'zhèngjù', 'chứng cứ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3948, '整理', 'zhěnglǐ', 'chỉnh lí, thu xếp, thu dọn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3949, '争论', 'zhēnglùn', 'tranh cãi, tranh luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3950, '证明', 'zhèngmíng', 'chứng minh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3951, '正气', 'zhèngqì', 'bầu không khí lành mạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3952, '争取', 'zhēngqǔ', 'tranh thủ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3955, '证书', 'zhèngshū', 'giấy chứng nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3957, '争先恐后', 'zhēngxiānkǒnghòu', 'chen lấn lên trước sợ rớt lại sau', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3958, '正义', 'zhèngyì', 'chính nghĩa', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3959, '争议', 'zhēngyì', 'tranh luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3960, '正在', 'zhèngzài', 'đang', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3961, '政治', 'zhèngzhì', 'chính trị', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3962, '郑重', 'zhèngzhòng', 'nghiêm túc, trịnh trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3963, '症状', 'zhèngzhuàng', 'bệnh trạng, triệu chứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3964, '震动', 'zhèndòng', 'trấn tĩnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3966, '阵容', 'zhènróng', 'đội hình, đội ngũ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3967, '侦探', 'zhēntàn', 'trinh thám', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3968, '枕头', 'zhěntou', 'cái gối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3969, '珍惜', 'zhēnxī', 'quý, trân trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3970, '珍珠', 'zhēnzhū', 'ngọc trai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3971, '真相', 'zhēnxiàng', 'sự thật', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3974, '折腾', 'zhēteng', 'đi qua đi lại, lăn lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3975, '哲学', 'zhéxué', 'triết học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3976, '直', 'zhí', 'thẳng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3980, '支', 'zhī', 'đội, đơn vị (văn, bài cây, cán)', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3992, '指定', 'zhǐdìng', 'chỉ định', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3998, '指挥', 'zhǐhuī', 'chỉ huy', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4002, '知觉', 'zhījué', 'tri giác', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4018, '智商', 'zhìshāng', 'IQ', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4019, '指使', 'zhǐshǐ', 'khiến cho, làm cho', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4020, '指示', 'zhǐshì', 'chỉ thị', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4022, '职位', 'zhíwèi', 'chức vị', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4027, '职业', 'zhíyè', 'nghề nghiệp', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4031, '制造', 'zhìzào', 'chế tạo, làm ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3979, '之', 'zhī', 'tới, cái đó, ngôn từ, của', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4046, '中立', 'zhōnglì', 'trung lập', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3981, '枝', 'zhī', 'cành, nhánh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3982, '治安', 'zhì’ān', 'trị an, cảnh sát', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3983, '直播', 'zhíbō', 'phát sóng trực tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3984, '支持', 'zhīchí', 'chống đỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3986, '指出', 'zhǐchū', 'chỉ ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3987, '指导', 'zhǐdǎo', 'chỉ đạo, hướng dẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3988, '知道', 'zhīdào', 'biết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3989, '值得', 'zhíde', 'xứng đáng, đáng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3990, '制定', 'zhìdìng', 'chế định, lập ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3991, '制订', 'zhìdìng', 'quy định, định ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4065, '舟', 'zhōu', 'thuyền', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3993, '制度', 'zhìdù', 'chế độ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3994, '脂肪', 'zhīfáng', 'mỡ, chất béo', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3996, '只好', 'zhǐhǎo', 'đành phải', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3997, '智慧', 'zhìhuì', 'trí tuệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3999, '指甲', 'zhǐjiǎ', 'móng tay', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4000, '直接', 'zhíjiē', 'trực tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4001, '至今', 'zhìjīn', 'cho đến nay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4003, '智力', 'zhìlì', 'trí lực, trí khôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4005, '置于', 'zhì yú', 'dốc sức cho', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4006, '质量', 'zhìliàng', 'chất lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4007, '治疗', 'zhìliáo', 'điều trị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4008, '指令', 'zhǐlìng', 'mệnh lệnh, chỉ thị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4009, '滞留', 'zhìliú', 'ngưng lại, dừng lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4010, '支流', 'zhīliú', 'nhánh sông, dòng chảy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4011, '植物', 'zhíwù', 'thực vật', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4012, '指南针', 'zhǐnánzhēn', 'kim chỉ nam', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4014, '智能', 'zhìnéng', 'trí tuệ, chí thị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4015, '支配', 'zhīpèi', 'an bài, sắp xếp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4016, '支票', 'zhīpiào', 'chi phiếu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4017, '执勤', 'zhíqín', 'chấp hành', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4021, '指望', 'zhǐwàng', 'trông chờ, mong đợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4023, '植树', 'zhíshù', 'cây cối', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4024, '职务', 'zhíwù', 'chức vụ', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4025, '秩序', 'zhìxù', 'trật tự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4028, '志愿', 'zhìyuàn', 'ước nguyện, chí nguyện, giúp đỡ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4029, '志愿者', 'zhìyuàn zhě', 'tình nguyện viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4030, '制约', 'zhìyuē', 'chế ước, kiềm hãm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4032, '执照', 'zhízhào', 'giấy phép', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4033, '支柱', 'zhīzhù', 'cây trụ, trụ chống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4035, '制作', 'zhìzuò', 'chế tạo, làm ra, chế ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4036, '重', 'zhòng', 'nặng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4037, '种', 'zhǒng', 'loại, kiểu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4038, '钟', 'zhōng', 'chuông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4039, '终', 'zhōng', 'kết thúc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4040, '重点', 'zhòngdiǎn', 'trọng điểm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4041, '终点', 'zhōngdiǎn', 'điểm cuối, điểm kết thúc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4042, '终于', 'zhōngyú', 'cuối cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4043, '中国', 'zhōngguó', 'Trung Quốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4044, '中间', 'zhōngjiān', 'ở giữa, bên trong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4045, '终究', 'zhōngjiū', 'chung quy, cuối cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4047, '重量', 'zhòngliàng', 'trọng lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4048, '肿瘤', 'zhǒngliú', 'bướu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4050, '终身', 'zhōngshēn', 'suốt đời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4051, '重视', 'zhòngshì', 'coi trọng, xem trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4052, '忠实', 'zhōngshí', 'trung thành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4053, '众所周知', 'zhòngsuǒzhōuzhī', 'ai ai cũng biết', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4054, '中文', 'zhōngwén', 'tiếng Trung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4055, '中午', 'zhōngwǔ', 'buổi trưa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4056, '中心', 'zhōngxīn', 'trung tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4057, '重新', 'chóngxīn', 'chán nản', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4059, '中央', 'zhōngyāng', 'trung tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4060, '重要', 'zhòngyào', 'quan trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4061, '种子', 'zhǒngzi', 'hạt', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4062, '种族', 'zhǒngzú', 'chủng tộc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4063, '州', 'zhōu', 'châu (đơn vị hành chính)', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4066, '周边', 'zhōubiān', 'chu vi, xung quanh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4067, '周到', 'zhōudào', 'chu đáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4068, '周密', 'zhōumì', 'chu đáo chặt chẽ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4069, '周末', 'zhōumò', 'cuối tuần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4070, '周年', 'zhōunián', 'đầy năm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4071, '周围', 'zhōuwéi', 'xung quanh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4072, '皱纹', 'zhòuwén', 'nếp nhăn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4073, '昼夜', 'zhòuyè', 'ngày và đêm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4075, '周转', 'zhōuzhuǎn', 'quay vòng (dòng vốn)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4076, '住', 'zhù', 'ở, cư trú, dừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4077, '祝', 'zhù', 'chúc, chúc mừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4078, '柱', 'zhù', 'cột, chống (gậy)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4079, '煮', 'zhǔ', 'nấu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4080, '株', 'zhū', 'cây', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4081, '猪', 'zhū', 'con lợn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4082, '抓', 'zhuā', 'nắm, bắt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4083, '抓紧', 'zhuājǐn', 'nắm chắc, nắm vững', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4119, '指引', 'zhǐyǐn', 'dẫn dắt', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4091, '装备', 'zhuāngbèi', 'trang thiết bị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4137, '自卑', 'zìbēi', 'tự ti', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4095, '壮烈', 'zhuàngliè', 'lừng lẫy, oanh liệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4098, '庄严', 'zhuāngyán', 'tráng nghiêm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (551, '传说', 'zhuànshuō', 'truyền kỳ, tiểu thuyết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4144, '自豪', 'zìháo', 'tự hào', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4138, '资本', 'zīběn', 'vốn', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4126, '资格', 'zīgé', 'tư cách', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4145, '自己', 'zìjǐ', 'tự mình, bản thân', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4147, '咨询', 'zīxún', 'tư vấn, trưng cầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4084, '赚', 'zhuàn', 'kiếm tiền, lợi nhuận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4085, '转弯', 'zhuǎnwān', 'ngồi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4087, '专长', 'zhuāncháng', 'chuyên môn, đặc trưng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4088, '专程', 'zhuānchéng', 'chuyến đi đặc biệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4089, '撞', 'zhuàng', 'đụng, va chạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4090, '装', 'zhuāng', 'hóa trang, trang phục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4149, '自力更生', 'zìlìgēngshēng', 'tự lực cánh sinh', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4092, '壮观', 'zhuàngguān', 'đồ sộ, tráng lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4093, '状况', 'zhuàngkuàng', 'tình hình, tình trạng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4094, '壮丽', 'zhuànglì', 'tráng lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4151, '字幕', 'zìmù', 'phụ đề', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4096, '装饰', 'zhuāngshì', 'trang trí, trang sức', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4097, '状态', 'zhuàngtài', 'trạng thái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4152, '字母', 'zìmǔ', 'chữ cái', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4099, '专业', 'zhuānyè', 'chuyên ngành', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4100, '专利', 'zhuānlì', 'bằng sáng chế', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4102, '转让', 'zhuǎnràng', 'chuyển nhượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4103, '专题', 'zhuāntí', 'chủ đề đặc biệt, chuyên đề', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4104, '专心', 'zhuānxīn', 'chuyên tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4105, '转移', 'zhuǎnyí', 'thay đổi vị trí', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4106, '转折', 'zhuǎnzhé', 'chuyển ngoặt, chuyển hướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4107, '主管', 'zhǔguǎn', 'người chủ trì tổ chức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4108, '逐步', 'zhúbù', 'lần lượt, từng bước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4109, '注册', 'zhùcè', 'đăng ký', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4110, '主持', 'zhǔchí', 'chủ trì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4111, '主导', 'zhǔdǎo', 'chủ đạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4112, '主动', 'zhǔdòng', 'chủ động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4113, '祝福', 'zhùfú', 'chúc phúc', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4115, '祝贺', 'zhùhè', 'chúc mừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4116, '追求', 'zhuīqiú', 'theo đuổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4117, '追悼', 'zhuīdào', 'tưởng niệm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4118, '追究', 'zhuījiū', 'truy cứu, truy vấn', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4154, '姿势', 'zīshì', 'tư thế', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4121, '著名', 'zhùmíng', 'nổi tiếng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4122, '准备', 'zhǔnbèi', 'chuẩn bị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4123, '准确', 'zhǔnquè', 'chính xác, đúng đắn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4124, '准时', 'zhǔnshí', 'đúng giờ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4125, '准则', 'zhǔnzé', 'nguyên tắc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4157, '滋味', 'zīwèi', 'mùi vị', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4127, '磨练', 'móliàn', 'rèn luyện, tập luyện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4128, '护手', 'hùshǒu', 'bảo vệ tay, chăm sóc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4129, '着想', 'zhuóxiǎng', 'suy nghĩ, lo nghĩ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4130, '卓越', 'zhuóyuè', 'nổi bật, trác việt, lỗi lạc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4131, '着重', 'zhuózhòng', 'nhấn mạnh, chú trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4132, '竹子', 'zhúzi', 'cây trúc', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4133, '作品', 'zuòpǐn', 'tác phẩm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4134, '字', 'zì', 'chữ', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4135, '紫', 'zǐ', 'màu tím', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4159, '自信', 'zìxìn', 'tự tin', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4162, '自愿', 'zìyuàn', 'tự nguyện', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4139, '资产', 'zīchǎn', 'tài sản', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4140, '自动', 'zìdòng', 'tự động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4141, '子弹', 'zǐdàn', 'đạn', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4142, '字典', 'zìdiǎn', 'từ điển', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4143, '自发', 'zìfā', 'tự phát', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4172, '踪迹', 'zōngjì', 'dấu vết', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4148, '资料', 'zīliào', 'tư liệu, dữ liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4150, '自满', 'zìmǎn', 'tự mãn', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4153, '自然', 'zìrán', 'tự nhiên, thiên nhiên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4155, '自私', 'zìsī', 'ích kỷ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4158, '仔细', 'zǐxì', 'tỉ mỉ, cẩn thận', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4160, '自行车', 'zìxíngchē', 'xe đạp', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4161, '自由', 'zìyóu', 'tự do', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4163, '资源', 'zīyuán', 'tài nguyên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4164, '滋长', 'zīzhǎng', 'phát sinh, nảy sinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4165, '资助', 'zīzhù', 'trợ cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4166, '总是', 'zǒng shì', 'luôn luôn, lúc nào cũng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4168, '总共', 'zǒnggòng', 'tổng cộng, tất cả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4169, '综合', 'zōnghé', 'tổng hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4170, '总和', 'zǒnghé', 'tổng hợp, tổng số', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4171, '纵横', 'zònghéng', 'tung hoành, ngang dọc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4173, '宗教', 'zōngjiào', 'tôn giáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4174, '总结', 'zǒngjié', 'tổng kết', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4175, '总理', 'zǒnglǐ', 'thủ tướng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4176, '棕色', 'zōngsè', 'màu nâu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4177, '总算', 'zǒngsuàn', 'cuối cùng cũng, nhìn chung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4178, '总统', 'zǒngtǒng', 'tổng thống', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4180, '宗旨', 'zōngzhǐ', 'tôn chỉ, mục đích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4181, '揍', 'zòu', 'đánh đập', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4182, '走', 'zǒu', 'đi, đi bộ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4183, '走廊', 'zǒuláng', 'hành lang', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4184, '走漏', 'zǒulòu', 'rò rỉ ra ngoài', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4185, '走私', 'zǒusī', 'buôn lậu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (116, '报到', 'bàodào', 'điểm danh, báo danh', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (455, '程序', 'chéngxù', 'chương trình, trình tự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4219, '作者', 'zuòzhě', 'tác giả', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (336, '裁员', 'cáiyuán', 'giảm biên chế, cắt giảm nhân viên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (365, '策划', 'cèhuà', 'lên kế hoạch', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (48, '把握', 'bǎwò', 'cầm, nắm, nắm bắt', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (70, '办公室', 'bàngōngshì', 'văn phòng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (77, '半途而废', 'bàntú’érfèi', 'bỏ cuộc giữa chừng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (89, '保留', 'bǎoliú', 'giữ nguyên, bảo tồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (103, '爆发', 'bàofā', 'bùng nổ, bộc phát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (127, '把手', 'bǎshǒu', 'tay nắm cửa, chuôi', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (134, '卑鄙', 'bēibǐ', 'hèn hạ, ti tiện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (142, '背景', 'bèijǐng', 'bối cảnh, nền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (152, '奔驰', 'bēnchí', 'chạy nhanh, chạy băng băng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (169, '比', 'bǐ', 'so, so với, ví', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (176, '变动', 'biàndòng', 'biến động, thay đổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (192, '边缘', 'biānyuán', 'giáp danh, vùng ven, biên giới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (202, '标识', 'biāozhì', 'cột mốc, ký hiệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (214, '弊病', 'bìbìng', 'tệ nạn, tai hại, sai lầm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (227, '笔记本', 'bǐjìběn', 'vở ghi chép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (237, '并列', 'bìngliè', 'đặt cạnh nhau, ngang hàng', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (250, '必须', 'bìxū', 'phải, cần phải', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (261, '博览会', 'bólǎnhuì', 'hội chợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (271, '补偿', 'bǔcháng', 'bồi thường, đền bù', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (272, '不当', 'bùdàng', 'không đáng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (274, '不见得', 'bùjiànde', 'chưa chắc, không nhất thiết', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (283, '不言而喻', 'bù yán ér yù', 'không nói cũng rõ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (290, '不得已', 'bùdéyǐ', 'bất đắc dĩ, bất đắc phải', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (302, '不可思议', 'bùkěsīyì', 'phi thường, không thể tưởng tượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (315, '不择手段', 'bùzéshǒuduàn', 'không từ thủ đoạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (330, '材料', 'cáiliào', 'vật liệu, tư liệu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (350, '参谋', 'cānmóu', 'tham mưu, cố vấn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (370, '层出不穷', 'céngchūbùqióng', 'liên tiếp xuất hiện, tầng tầng lớp lớp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (380, '差距', 'chājù', 'khoảng cách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (386, '产生', 'chǎnshēng', 'xuất hiện, sản sinh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (402, '场合', 'chǎnghé', 'trường hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (414, '倡议', 'chàngyì', 'đề xuất, sáng kiến', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (426, '嘲笑', 'cháoxiào', 'nhạo báng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (439, '成心', 'chéngxīn', 'thành tâm, cố ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (466, '乘务员', 'chéngwùyuán', 'nhân viên phục vụ (trên tàu, máy bay)', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (482, '称心如意', 'chènxīn rúyì', 'vừa lòng đẹp ý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (497, '冲', 'chōng', 'va đập, đột kích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (507, '重阳节', 'chóngyáng jié', 'tết Trùng Dương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (518, '出国', 'chūguó', 'ra nước ngoài', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (526, '抽空', 'chōukòng', 'dành thời gian, tranh thủ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (535, '传达', 'zhuǎndá', 'truyền tải', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (541, '床单', 'chuángdān', 'khăn trải giường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (547, '川流不息', 'chuānliúbùxī', 'dòng nước chảy liên tục, không ngừng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (579, '出息', 'chūxī', 'triển vọng, tiến bộ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (586, '刺', 'cì', 'đâm, chọc, chích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (588, '次品', 'cì pǐn', 'loại hai, thứ phẩm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4187, '租', 'zū', 'thuê, mướn, cho thuê, tiền thuê', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4188, '阻碍', 'zǔ’ài', 'cản trở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4189, '钻石', 'zuànshí', 'kim cương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4190, '钻研', 'zuānyán', 'nghiên cứu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4214, '做生意', 'zuò shēngyì', 'làm kinh doanh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4192, '祖父', 'zǔfù', 'ông nội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4194, '组合', 'zǔhé', 'tổ hợp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4195, '最', 'zuì', 'nhất', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4197, '嘴', 'zuǐ', 'miệng, mồm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4198, '最好', 'zuì hǎo', 'tốt nhất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4199, '嘴唇', 'zuǐchún', 'môi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4200, '罪犯', 'zuìfàn', 'tội phạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4201, '最后', 'zuìhòu', 'cuối cùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4202, '最近', 'zuìjìn', 'gần đây, dạo này', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4203, '阻止', 'zǔzhǐ', 'ngăn cản, ngăn trở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4204, '租赁', 'zūlìn', 'thuê, cho thuê', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4206, '尊敬', 'zūnjìng', 'tôn kính', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4207, '遵守', 'zūnshǒu', 'tuân thủ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4208, '遵循', 'zūnxún', 'theo, tuân theo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4209, '尊严', 'zūnyán', 'tôn nghiêm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4210, '尊重', 'zūnzhòng', 'tôn trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4211, '坐', 'zuò', 'ngồi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4212, '座', 'zuò', 'chỗ ngồi, đệm, tòa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4213, '作东', 'zuòdōng', 'làm chủ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4218, '作为', 'zuòwéi', 'hành vi, việc làm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4216, '作文', 'zuòwén', 'viết văn, làm văn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4217, '作用', 'zuòyòng', 'tác dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (488, '吃惊', 'chījīng', 'giật mình, sợ hãi', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4220, '昨天', 'zuótiān', 'hôm qua', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4221, '左边', 'zuǒbiān', 'bên trái', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4222, '作废', 'zuòfèi', 'xóa bỏ, mất hiệu lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4223, '作风', 'zuòfēng', 'phong cách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4224, '座位', 'zuòwèi', 'chỗ ngồi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4225, '作业', 'zuòyè', 'bài tập', NULL, 32);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4227, '足够', 'zúgòu', 'đủ', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4228, '祖先', 'zǔxiān', 'tổ tiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4229, '组织', 'zǔzhī', 'tổ chức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (567, '处境', 'chǔjìng', 'cảnh ngộ, hoàn cảnh', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4191, '组成', 'zǔchéng', 'cấu thành, tạo thành', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (597, '辞职', 'cízhí', 'từ chức', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (605, '从前', 'cóngqián', 'trước đây, ngày trước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (636, '打抱不平', 'dǎbàobùpíng', 'bênh vực, bênh kẻ yếu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (650, '代表', 'dàibiǎo', 'đại biểu, đại diện', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (664, '单纯', 'dānchún', 'đơn giản, đơn thuần', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (674, '当地', 'dāngdì', 'bản địa, bản xứ', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (684, '当时', 'dāngshí', 'lúc đó, khi đó', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (688, '党选', 'dǎngxuǎn', 'trúng cử', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (690, '淡却', 'dànquè', 'nhạt đi, phai nhạt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (703, '到达', 'dàodá', 'đến nơi, đạt đến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (723, '大使', 'dàshǐ', 'trạng trọng, không kiêng nể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (738, '得不偿失', 'débùchángshī', 'hại nhiều hơn lợi, lợi ít hại nhiều', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (753, '得天独厚', 'détiāndúhòu', 'gặp may mắn, được ưu ái', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (773, '电头', 'diàntóu', 'gật đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (783, '调查', 'diàochá', 'điều tra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (794, '地方', 'dìfāng', 'địa phương, chỗ, nơi, vùng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (795, '抵抗', 'dǐkàng', 'chống lại, đề kháng, chống cự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (803, '的确', 'díquè', 'thật, đích thực', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (824, '董事长', 'dǒngshì zhǎng', 'chủ tịch hội đồng quản trị', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (843, '断绝', 'duànjué', 'cắt đứt, đoạn tuyệt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (854, '对方', 'duìfāng', 'phía bên kia, đối phương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (879, '顿时', 'dùnshí', 'ngay, liền, tức khắc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (892, '读书', 'dúshū', 'đọc sách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (896, '恶心', 'ěxīn', 'buồn nôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (900, '而且', 'érqiě', 'mà còn, hơn nữa', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (917, '发火', 'fāhuǒ', 'nổi giận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (923, '反驳', 'fǎnbó', 'bác bỏ, phản đối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (937, '方', 'fāng', 'vuông', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (942, '方便', 'fāngbiàn', 'thuận tiện, thuận lợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (957, '放映', 'fàngyìng', 'trình chiếu, chiếu phim', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (968, '烦恼', 'fánnǎo', 'phiền não, phiền muộn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (981, '发言', 'fāyán', 'phát biểu', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (991, '诽谤', 'fěibàng', 'nói xấu, phỉ báng, gièm pha', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (997, '飞禽走兽', 'fēiqín zǒushòu', 'chim bay cá nhảy, chim trời cá nước', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1006, '分别', 'fēnbié', 'phân biệt', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1012, '丰盛', 'fēngshèng', 'phong phú, nhiều, giàu có', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1022, '丰满', 'fēngmǎn', 'sung túc, đầy đủ, đầy ắp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1037, '分量', 'fènliàng', 'trọng lượng, sức nặng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1055, '岗位', 'gǎngwèi', 'cương vị, vị trí công tác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1068, '干涉', 'gānshè', 'can thiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1077, '高超', 'gāochāo', 'cao siêu, tuyệt vời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1087, '高速公路', 'gāosù gōnglù', 'đường cao tốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1102, '根据', 'gēnjù', 'căn cứ, dựa vào', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1109, '更新', 'gēngxīn', 'thay mới, đổi mới, canh tân', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1118, '各抒己见', 'gèshūjǐjiàn', 'mỗi người đưa ra ý kiến của riêng mình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1135, '公关', 'gōngguān', 'giao tiếp, đối ngoại, xã hội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1147, '功能', 'gōngnéng', 'công năng, tác dụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1158, '功用', 'gōngyòng', 'công năng, công hiệu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1172, '购结', 'gòujié', 'câu kết, thông đồng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1184, '关键', 'guānjiàn', 'then chốt, mấu chốt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1198, '光滑', 'guānghuá', 'trơn tru, nhẵn bóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1200, '广阔', 'guǎngkuò', 'rộng lớn, bát ngát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1217, '鼓动', 'gǔdòng', 'cổ động, khuyến khích, xúi giục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1230, '规范', 'guīfàn', 'quy tắc, tiêu chuẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1240, '估计', 'gūjì', 'đánh giá, ước đoán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1252, '过程', 'guòchéng', 'quá trình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1271, '过瘾', 'guòyǐn', 'thỏa nguyện, thỏa thích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1274, '暂且', 'zànqiě', 'tạm thời', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1284, '固有', 'gùyǒu', 'vốn có, sẵn có, cố hữu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1286, '顽固', 'wángù', 'bướng bỉnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1297, '海洋', 'hǎiyáng', 'biển, đại dương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1308, '罕见', 'hǎnjiàn', 'hiếm thấy, ít thấy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1323, '好像', 'hǎoxiàng', 'hình như, dường như', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1332, '合格', 'hégé', 'hợp lệ, đạt chuẩn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1344, '恨不得', 'hěnbùdé', 'hận không thể, muốn', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1361, '红包', 'hóngbāo', 'tiền thưởng, tiền lì xì', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1369, '后顾之忧', 'hòugùzhīyōu', 'nỗi lo về sau', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1380, '花瓣', 'huābàn', 'cánh hoa', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1389, '换', 'huàn', 'đổi, thay đổi, trao đổi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1401, '慌张', 'huāngzhāng', 'hoang mang, rối loạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1412, '画蛇添足', 'huàshétiānzú', 'vẽ rắn thêm chân, vẽ vời vô ích, làm chuyện dư thừa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1433, '回顾', 'huígù', 'nhìn lại, hồi tưởng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1444, '互联网', 'hùliánwǎng', 'internet', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1451, '浑身', 'húnshēn', 'toàn thân, khắp người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1462, '火箭', 'huǒjiàn', 'tên lửa, hỏa tiễn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1474, '呼啸', 'hūxiào', 'gào thét, rít, hò hét', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1500, '坚强', 'jiānqiáng', 'mạnh mẽ, kiên cường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (712, '道歉', 'dàoqiàn', 'xin thứ lỗi, xin chịu lỗi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (869, '对抗', 'duìkàng', 'đối kháng, đối đầu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1487, '家常', 'jiācháng', 'việc thường ngày, chuyện nhà', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (812, '抵制', 'dǐzhì', 'ngăn chặn, ngăn lại', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (864, '推', 'tuī', 'đẩy, đùn, mở rộng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (906, '制止', 'zhìzhǐ', 'ngăn cấm, chặn đứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1110, '更改', 'gēnggǎi', 'cải chính, đính chính, sửa lại', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1263, '国庆节', 'guóqìngjié', 'ngày quốc khánh', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1484, '驾驶', 'jiàshǐ', 'lái xe', NULL, 28);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1512, '剪影', 'jiǎnyǐng', 'bóng cắt, hình bóng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1532, '交往', 'jiāowǎng', 'qua lại, lui tới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1534, '饺子', 'jiǎozi', 'bánh chẻo, sủi cảo', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1552, '践踏', 'jiàntà', 'dẫm, giẫm, giày xéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1563, '坚贞', 'jiānzhēn', 'quả là, thật là', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1574, '交涉', 'jiāoshè', 'can thiệp, đàm phán', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1589, '疾病', 'jíbìng', 'bệnh tật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1596, '激动', 'jīdòng', 'kích động', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1603, '节日', 'jiérì', 'ngày tết, ngày lễ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1611, '竭尽全力', 'jiéjìn quánlì', 'dốc toàn lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1623, '接受', 'jiēshòu', 'tiếp nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1632, '借助', 'jièzhù', 'nhờ vào, cậy vào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1644, '机会', 'jīhuì', 'cơ hội, dịp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1655, '激励', 'jīlì', 'khích lệ, khuyến khích', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1674, '经常', 'jīngcháng', 'thường, thường xuyên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1688, '精致', 'jīngzhì', 'tinh tế', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1700, '精准', 'jīngzhǔn', 'chính xác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1709, '金融', 'jīnróng', 'tài chính', NULL, 38);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1721, '技巧', 'jìqiǎo', 'kỹ xảo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1725, '集中', 'jízhōng', 'tập trung', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1731, '计算机', 'jìsuànjī', 'máy tính', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1747, '继往开来', 'jìwǎng kāilái', 'tiếp nối người trước, mở lối cho người sau', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1756, '急于求成', 'jíyú qiúchéng', 'vội vàng mong đạt được thành công', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1773, '决赛', 'juésài', 'trận chung kết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1787, '军队', 'jūnduì', 'quân đội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1815, '砍', 'kǎn', 'chặt', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1821, '慷慨', 'kāngkǎi', 'hào phóng, hùng hồn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1839, '客房', 'kèfáng', 'phòng khách (khách sạn)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1840, '客观', 'kèguān', 'khách quan', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1842, '课程', 'kèchéng', 'lịch dạy học', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1855, '课堂', 'kètáng', 'lớp học, giảng đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1856, '客栈', 'kèzhàn', 'quán trọ (nếu trong ảnh dừng ở 2163 khác, bạn cho mình ảnh rõ dòng cuối để mình sửa đúng)', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1863, '可见', 'kějiàn', 'có thể thấy', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1871, '可笑', 'kěxiào', 'nực cười, buồn cười', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1885, '挎', 'kuà', 'cắp, xách, khoác, đai', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1895, '困', 'kùn', 'khốn khổ, khó khăn, mệt, buồn ngủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1910, '老板', 'lǎobǎn', 'ông chủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1919, '苦笑', 'kǔxiào', 'cười khổ, cười gượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1942, '老婆婆', 'lǎopopo', 'bà nội, bà ngoại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1957, '冷却', 'lěngquè', 'làm lạnh, để nguội', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1970, '厉害', 'lìhài', 'lợi hại, dữ dội, gay gắt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1990, '聊天', 'liáotiān', 'tán gẫu, trò chuyện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1995, '烈性', 'lièxìng', 'mạnh mẽ, dữ dội, gay gắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2007, '力所能及', 'lìsuǒnéngjí', 'khả năng cho phép', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2021, '留念', 'liúniàn', 'lưu niệm, kỷ niệm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2032, '理直气壮', 'lǐzhíqìzhuàng', 'cây ngay không sợ chết đứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2048, '轮船', 'lúnchuán', 'thuyền chạy bằng hơi nước', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2060, '络绎不绝', 'luòyì bù jué', 'lũ lượt kéo đến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2068, '嘛', 'ma', 'mà, nhỉ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2071, '麻痹', 'mábì', 'bệnh tê liệt', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2080, '埋葬', 'máizàng', 'chôn giấu, chôn cất', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2090, '茫然', 'mángrán', 'mù tịt, chẳng biết gì', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2100, '毛病', 'máobìng', 'lỗi, tật xấu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2112, '美丽', 'měilì', 'đẹp, xinh đẹp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2123, '美妙', 'měimiào', 'tuyệt vời, tươi đẹp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2137, '免费', 'miǎnfèi', 'miễn phí', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2150, '蜜蜂', 'mìfēng', 'ong', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2159, '名额', 'míng''é', 'số người', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2177, '迷失', 'míshī', 'mất phương hướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2181, '摩擦', 'mócā', 'ma sát', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2186, '莫名其妙', 'mòmíngqímiào', 'không hiểu ra sao', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2191, '搜索', 'sōusuǒ', 'tìm kiếm', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2198, '木头', 'mùtou', 'gỗ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2204, '耐心', 'nàixīn', 'kiên nhẫn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2212, '难堪', 'nánkān', 'khó chịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2230, '年龄', 'niánlíng', 'tuổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2238, '农业', 'nóngyè', 'nông nghiệp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2248, '攀登', 'pāndēng', 'leo, trèo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2258, '能量', 'néngliàng', 'năng lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2267, '凝固', 'nínggù', 'cứng lại, đông đặc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2279, '虐待', 'nüèdài', 'hành hạ, ngược đãi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2289, '欧洲', 'ōuzhōu', 'châu Âu', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2294, '排队', 'páiduì', 'xếp hàng, sắp xếp', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2302, '旁边', 'pángbiān', 'bên cạnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2311, '配偶', 'pèi’ǒu', 'vợ, chồng, phối ngẫu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2325, '批评', 'pīpíng', 'chỉ trích, phê bình', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2333, '拼搏', 'pīnbó', 'đấu tranh', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2343, '平方', 'píngfāng', 'vuông, bình phương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2380, '曝光', 'pùguāng', 'phơi bày, lộ ra', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2390, '前', 'qián', 'trước', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2396, '签署', 'qiānshǔ', 'ký tên, ký', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1665, '近代', 'jìndài', 'cận đại', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1740, '救济', 'jiùjì', 'cứu tế', NULL, 36);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2364, '脾气', 'píqi', 'tính khí, tâm trạng, tính tình, tính cách', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2397, '签证', 'qiānzhèng', 'visa', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2169, '民间', 'mínjiān', 'dân gian', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1934, '垃圾桶', 'lājītǒng', 'thùng rác', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1983, '连同', 'liántóng', 'tính cả, góp lại, kể cả', NULL, 25);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (1689, '竞争', 'zhēngzhēng', 'ngo ngoe, vung vẫy, đấu tranh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2219, '闹钟', 'nàozhōng', 'đồng hồ báo thức', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2352, '平时', 'píngshí', 'bình thường, ngày thường', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2409, '强忍', 'qiángrěn', 'nhẫn nhịn, nín nhịn', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2419, '牵强附会', 'qiānqiángfùhuì', 'gượng ép, cưỡng giải thích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2434, '巧巧', 'qiàqiǎo', 'đúng lúc, vừa khéo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2448, '起负', 'qǐfù', 'ân hiệp, bật lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2458, '期间', 'qíjiān', 'dịp, thời kỳ, thời gian', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2473, '清楚', 'qīngchu', 'rõ ràng, minh mẫn, hiểu rõ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2487, '清爽', 'qīngshuǎng', 'dễ chịu, mát mẻ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2497, '勤劳', 'qínláo', 'siêng năng, cần cù, cần mẫn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2507, '气魄', 'qìpò', 'khí thế, quang cảnh', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2516, '期限', 'qīxiàn', 'kỳ hạn, thời hạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2537, '染', 'rǎn', 'nhuộm, mà, thế mà, song', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2549, '忍不住', 'rěn bù zhù', 'không thể cưỡng lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2562, '热心肠', 'rèxīncháng', 'tốt bụng, nhiệt tâm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2573, '容量', 'róngliàng', 'dung lượng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2578, '荣誉证书', 'róngyù zhèngshū', 'giấy chứng nhận danh dự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2593, '人家', 'rénjiā', 'những người khác', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2605, '人性', 'rénxìng', 'nhân tính', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2610, '人质', 'rénzhì', 'con tin', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2616, '散步', 'sànbù', 'đi dạo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2622, '色彩', 'sècǎi', 'màu sắc', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2630, '筛选', 'shāixuǎn', 'sàng lọc, chọn lọc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2641, '上级', 'shàngjí', 'cấp trên, thượng cấp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2653, '善良', 'shànliáng', 'hảo tâm, lương thiện', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2667, '设备', 'shèbèi', 'thiết bị', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2673, '设施', 'shèshī', 'thiết bị, công trình', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2677, '神奇', 'shén qí', 'thần kỳ', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2691, '生病', 'shēngbìng', 'bị ốm, sinh bệnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2704, '声明', 'shēngmíng', 'tuyên bố, thanh minh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2748, '似的', 'shì de', 'dường như, tựa như', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2756, '市场', 'shìchǎng', 'thị trường, chợ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2768, '实话', 'shíhuà', 'sự thật, nói thật', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2779, '世界观', 'shìjièguān', 'thế giới quan', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2790, '事情', 'shìqíng', 'sự tình, sự việc', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2812, '事物', 'shìwù', 'điều, vật, thứ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2823, '施展', 'shīzhǎn', 'phát huy, thi thố (năng lực)', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2838, '甩', 'shuǎi', 'vung, quăng, ném', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2847, '爽快', 'shuǎngkuài', 'sảng khoái, dễ chịu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2859, '水果', 'shuǐguǒ', 'hoa quả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2868, '树立', 'shùlì', 'thành lập, xây dựng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2882, '舒适', 'shūshì', 'dễ chịu, thoải mái', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2892, '丝毫', 'sīháo', 'ti, tí, mảy may, chút nào', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2902, '肆无忌惮', 'sìwújìdàn', 'trắng trợn, không kiêng nể gì cả', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2921, '随身', 'suíshēn', 'mang theo, tùy thân', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2938, '素食主义', 'sùshí zhǔyì', 'chủ nghĩa ăn chay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2953, '太极拳', 'tàijíquán', 'thái cực quyền', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2966, '趟', 'tàng', 'chuyến đi, lượt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2975, '探索', 'tànsuǒ', 'khám phá', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2983, '陶瓷', 'táocí', 'đồ gốm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2993, '特定', 'tèdìng', 'đặc biệt, đặc sắc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3004, '天才', 'tiāncái', 'thiên tài', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3015, '天真', 'tiānzhēn', 'ngây thơ, hồn nhiên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3024, '条例', 'tiáolì', 'luật lệ, điều lệ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3045, '停顿', 'tíngdùn', 'tạm ngừng, ngắt quãng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3059, '通货膨胀', 'tōng huò péngzhàng', 'sự lạm phát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3069, '同情', 'tóngqíng', 'đồng cảm, thông cảm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3086, '土', 'tǔ', 'đất, thổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3095, '腿', 'tuǐ', 'chân, đùi', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3115, '拖延', 'tuōyán', 'trì hoãn, kéo dài', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3126, '歪', 'wāi', 'nghiêng, lệch, xiêu vẹo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3133, '瓦解', 'wǎjiě', 'sụp đổ, tan rã', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3151, '往事', 'wǎngshì', 'chuyện cũ, quá khứ', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3160, '惋惜', 'wǎnxī', 'thương tiếc, xót thương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3173, '违反', 'wéifǎn', 'vi phạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3178, '微不足道', 'wēibùzúdào', 'không có ý nghĩa', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3191, '威力', 'wēilì', 'sức mạnh, uy lực', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3215, '温和', 'wēnhé', 'ôn hòa, nhẹ nhàng', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3226, '文艺', 'wényì', 'văn nghệ', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3235, '卧室', 'wòshì', 'phòng ngủ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3240, '无可奉告', 'wúkě fènggào', 'không có gì để nói, miễn bình luận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3248, '无动于衷', 'wúdòngyúzhōng', 'thờ ơ, lãnh đạm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3269, '武装', 'wǔzhuāng', 'vũ trang', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3276, '霞', 'xiá', 'ráng mây (sáng hoặc tối)', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3283, '狭窄', 'xiázhǎi', 'hẹp, chật hẹp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3299, '陷阱', 'xiànjǐng', 'cái bẫy', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3315, '相反', 'xiāngfǎn', 'tương phản, ngược lại', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3332, '衔接', 'xiánjiē', 'liên kết, nối tiếp', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3343, '现任', 'xiànrèn', 'đang giữ chức vụ', NULL, 23);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3351, '消毒', 'xiāodú', 'tẩy uế, khử trùng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3353, '消费', 'xiāofèi', 'tiêu thụ, tiêu dùng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3362, '效率', 'xiàolǜ', 'hiệu suất, năng suất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3377, '下午', 'xiàwǔ', 'buổi chiều', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2529, '群', 'qún', 'bầy, đàn, tốp', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3290, '线', 'xiàn', 'sợi, đường', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2719, '神话', 'shénhuà', 'truyền thuyết', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2722, '审理', 'shěnlǐ', 'thẩm tra xử lý', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (2731, '身体', 'shēntǐ', 'cơ thể, thân thể', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3103, '推荐', 'tuījiàn', 'giới thiệu, đề cử', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3205, '维修', 'wéixiū', 'sửa chữa, duy tu', NULL, 26);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3254, '无可奈何', 'wúkěnàihé', 'đành chịu, bất lực', NULL, 22);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3310, '相似', 'xiāngsì', 'giống, tương tự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3386, '协议', 'xiéyì', 'hiệp nghị, thỏa thuận', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3399, '兴奋', 'xīngfèn', 'hưng phấn, phấn khích', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3412, '新陈代谢', 'xīnchéndàixiè', 'sự thay cũ đổi mới, trao đổi chất', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3428, '性情', 'xìngqíng', 'tính tình, tính nết', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3441, '新郎', 'xīnláng', 'chú rể', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3448, '信任', 'xìnrèn', 'tin tưởng, tín nhiệm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3458, '心脏', 'xīnzàng', 'tim', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3460, '兄弟', 'xiōngdì', 'anh em trai', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3467, '雄伟', 'xióngwěi', 'hùng vĩ, tráng lệ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3480, '喜闻乐见', 'xǐwénlèjiàn', 'rất hoan nghênh, vui tai vui mắt', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3494, '悬念', 'xuánniàn', 'hồi hộp, thấp thỏm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3507, '雪上加霜', 'xuěshàngjiāshuāng', 'thêm khổ này đến khổ khác, liên tiếp gặp nạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3526, '循序渐进', 'xúnxùjiànjìn', 'tiến hành theo trật tự', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3540, '演变', 'yǎnbiàn', 'phát triển, biến đổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3544, '严重', 'yánzhòng', 'nghiêm trọng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3551, '样式', 'yàngshì', 'hình thức, kiểu dáng', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3565, '延期', 'yánqī', 'dời ngày, kéo dài thời hạn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3578, '演绎', 'yǎnyì', 'diễn dịch, suy luận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3590, '咬牙切齿', 'yǎoyáqièchǐ', 'nghiến răng nghiến lợi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3604, '压缩', 'yāsuō', 'nén, ép', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3614, '液体', 'yètǐ', 'chất lỏng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3619, '一般', 'yībān', 'bình thường, phổ biến', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3631, '一帆风顺', 'yīfān fēngshùn', 'thuận buồm xuôi gió', NULL, 30);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3632, '衣服', 'yīfu', 'quần áo', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3649, '一路平安', 'yīlù píng’ān', 'thượng lộ bình an', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3667, '营养', 'yíngyǎng', 'dinh dưỡng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3681, '引起', 'yǐnqǐ', 'gây nên, dẫn tới', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3701, '艺术', 'yìshù', 'nghệ thuật', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3723, '勇敢', 'yǒnggǎn', 'dũng cảm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3732, '用处', 'yòngchu', 'công dụng, tác dụng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3743, '有条不紊', 'yǒutiáo bù wěn', 'gọn gàng, trật tự', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3756, '优先', 'yōuxiān', 'quyền ưu tiên', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3771, '原告', 'yuángào', 'nguyên cáo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3774, '原来', 'yuánlái', 'vốn dĩ, ban đầu', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3787, '预报', 'yùbào', 'dự báo', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3796, '乐谱', 'yuèpǔ', 'bản nhạc, nhạc phổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3805, '运输', 'yùnshū', 'vận chuyển', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3826, '语音', 'yǔyīn', 'âm thanh, tiếng nói', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3834, '再三', 'zàisān', 'nhiều lần, lặp lại', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3845, '攒', 'zǎn', 'tích lũy, trữ, gom lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3853, '赞扬', 'zànyáng', 'khen ngợi, tán dương', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3867, '赠送', 'zèngsòng', 'biếu, tặng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3877, '站', 'zhàn', 'đứng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3878, '斩钉截铁', 'zhǎndīngjiétiě', 'chém đinh chặt sắt, dứt khoát', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3893, '照相机', 'zhàoxiàngjī', 'máy chụp ảnh', NULL, 21);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3909, '招聘', 'zhāopìn', 'tuyển dụng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3920, '遮挡', 'zhēdǎng', 'che, ngăn che', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3930, '阵地', 'zhèndì', 'trận địa, mặt trận', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3945, '证件', 'zhèngjiàn', 'giấy chứng nhận', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3956, '整体', 'zhěngtǐ', 'toàn thể, tổng thể', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3972, '震兴', 'zhènxīng', 'chấn hưng, hưng thịnh', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3995, '支付', 'zhīfù', 'đồng phục', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4004, '治理', 'zhìlǐ', 'thống trị, quản lý', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4013, '职能', 'zhínéng', 'chức năng, công năng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4034, '知足常乐', 'zhīzú cháng lè', 'tri túc thì vui', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4049, '终年', 'zhōngnián', 'suốt cả năm', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4058, '中旬', 'zhōngxún', 'trung tuần, giữa tháng', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4074, '拙劣', 'zhuōliè', 'trục trặc, trắc trở', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4086, '转变', 'zhuǎnbiàn', 'chuyển biến, thay đổi', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4101, '专门', 'zhuānmén', 'chuyên môn, chuyên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4120, '主流', 'zhǔliú', 'chủ yếu, xu hướng', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4136, '资深', 'zīshēn', 'từng trải, thâm niên', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4146, '资金', 'zījīn', 'tiền vốn, quỹ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4167, '总而言之', 'zǒng’éryánzhī', 'nói tóm lại', NULL, 35);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4179, '总之', 'zǒngzhī', 'nói chung, tóm lại', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4186, '组', 'zǔ', 'nhóm, tổ', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4193, '祖国', 'zǔguó', 'tổ quốc', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4205, '阻挠', 'zǔnáo', 'cản trở, ngăn cản, phá rối', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4215, '作息', 'zuòxī', 'làm việc và nghỉ ngơi', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4226, '座右铭', 'zuòyòumíng', 'lời răn, lời cách ngôn', NULL, 34);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3692, '一起', 'yīqǐ', 'cùng nhau', NULL, 24);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3711, '意向', 'yìxiàng', 'ý định, mục đích', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3767, '遇到', 'yù dào', 'gặp phải, gặp được', NULL, 33);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3812, '酝酿', 'yùnniàng', 'ủ rượu, chuẩn bị (kỹ lưỡng)', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3978, '指', 'zhǐ', 'chỉ ra, ngón tay', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4156, '姿态', 'zītài', 'tư thế, dáng dấp', NULL, 37);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4026, '只要', 'zhǐyào', 'chỉ cần', NULL, 31);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (4114, '主观', 'zhǔguān', 'chủ quan', NULL, 27);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3985, '知识', 'zhīshi', 'tri thức, kiến thức', NULL, 40);
INSERT INTO public.vocabulary (vocab_id, chinese_word, pinyin, meaning_vn, audio_url, category_id) VALUES (3674, '英勇', 'yīngyǒng', 'anh dũng', NULL, 34);


--
-- Data for Name: vocabulary_box; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary_box (box_id, user_id, created_at, updated_at) VALUES (1, 2, '2026-01-05 11:57:47.748', '2026-01-05 11:57:47.748');
INSERT INTO public.vocabulary_box (box_id, user_id, created_at, updated_at) VALUES (2, 4, '2026-01-06 12:20:46.343', '2026-01-06 12:20:46.343');


--
-- Data for Name: vocabulary_box_item; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (1, 1, 32, true, false, 0, 0, 1, '2026-01-05 11:57:47.755', '2026-01-05 11:57:47.755');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (2, 1, 52, true, false, 0, 0, 1, '2026-01-05 11:57:48.774', '2026-01-05 11:57:48.774');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (3, 1, 55, true, false, 0, 0, 1, '2026-01-05 11:57:49.225', '2026-01-05 11:57:49.225');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (4, 1, 141, true, false, 0, 0, 1, '2026-01-05 11:57:49.67', '2026-01-05 11:57:49.67');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (5, 1, 122, true, false, 0, 0, 1, '2026-01-05 11:57:50.19', '2026-01-05 11:57:50.19');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (6, 1, 210, true, false, 0, 0, 1, '2026-01-05 11:57:50.624', '2026-01-05 11:57:50.624');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (7, 1, 219, true, false, 0, 0, 1, '2026-01-05 11:57:50.789', '2026-01-05 11:57:50.789');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (8, 1, 229, true, false, 0, 0, 1, '2026-01-05 11:57:51.159', '2026-01-05 11:57:51.159');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (9, 1, 143, true, false, 0, 0, 1, '2026-01-05 11:57:51.53', '2026-01-05 11:57:51.53');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (10, 1, 151, true, false, 0, 0, 1, '2026-01-05 11:57:51.883', '2026-01-05 11:57:51.883');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (14, 2, 97, true, false, 0, 0, 1, '2026-01-06 12:20:48.466', '2026-01-06 12:20:48.466');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (15, 2, 91, true, false, 0, 0, 1, '2026-01-06 12:20:48.849', '2026-01-06 12:20:48.849');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (16, 2, 151, true, false, 0, 0, 1, '2026-01-06 12:20:49.554', '2026-01-06 12:20:49.554');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (17, 2, 143, true, false, 0, 0, 1, '2026-01-06 12:20:49.891', '2026-01-06 12:20:49.891');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (11, 2, 32, true, true, 0, 0, 2, '2026-01-06 12:20:46.358', '2026-01-06 12:33:41.841');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (12, 2, 52, true, false, 0, 0, 3, '2026-01-06 12:20:47.618', '2026-01-06 12:33:42.85');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (13, 2, 55, true, false, 0, 0, 2, '2026-01-06 12:20:48.128', '2026-01-06 12:33:43.335');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (18, 2, 141, true, false, 0, 0, 2, '2026-01-06 12:20:50.232', '2026-01-06 12:33:43.656');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (19, 2, 122, true, false, 0, 0, 2, '2026-01-06 12:20:50.619', '2026-01-06 12:33:44.033');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (20, 2, 116, true, false, 0, 0, 2, '2026-01-06 12:20:51.822', '2026-01-06 12:33:44.376');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (31, 2, 171, true, false, 0, 0, 1, '2026-01-06 12:33:44.772', '2026-01-06 12:33:44.772');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (32, 2, 210, true, false, 0, 0, 1, '2026-01-06 12:33:45.088', '2026-01-06 12:33:45.088');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (33, 2, 219, true, false, 0, 0, 1, '2026-01-06 12:33:45.469', '2026-01-06 12:33:45.469');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (34, 2, 229, true, false, 0, 0, 1, '2026-01-06 12:33:45.866', '2026-01-06 12:33:45.866');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (35, 2, 284, true, false, 0, 0, 1, '2026-01-06 12:33:46.208', '2026-01-06 12:33:46.208');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (36, 2, 1652, true, false, 0, 0, 1, '2026-01-07 12:45:47.488', '2026-01-07 12:45:47.488');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (39, 2, 4027, true, false, 0, 0, 1, '2026-01-07 12:45:50.205', '2026-01-07 12:45:50.205');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (40, 2, 3343, true, false, 0, 0, 1, '2026-01-07 12:45:50.764', '2026-01-07 12:45:50.764');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (41, 2, 3710, true, false, 0, 0, 1, '2026-01-07 12:45:51.348', '2026-01-07 12:45:51.348');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (42, 2, 4022, true, false, 0, 0, 1, '2026-01-07 12:45:52.544', '2026-01-07 12:45:52.544');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (43, 2, 1106, true, false, 0, 0, 1, '2026-01-07 12:45:52.956', '2026-01-07 12:45:52.956');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (37, 2, 1128, true, false, 0, 0, 2, '2026-01-07 12:45:48.967', '2026-01-07 12:45:53.343');
INSERT INTO public.vocabulary_box_item (item_id, box_id, vocab_id, is_read, is_memorized, correct_count, incorrect_count, listen_count, created_at, updated_at) VALUES (38, 2, 4024, true, false, 0, 0, 2, '2026-01-07 12:45:49.85', '2026-01-07 12:45:54.184');


--
-- Data for Name: vocabulary_categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (21, 'Số đếm & số lượng', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (22, 'Con người & quan hệ xã hội', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (23, 'Nghề nghiệp & công việc', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (24, 'Sức khỏe & cơ thể', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (25, 'Động vật & thực vật', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (26, 'Món ăn & đồ uống', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (27, 'Đồ dùng & quần áo', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (28, 'Phương tiện & giao thông', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (29, 'Địa điểm & môi trường', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (30, 'Thời gian & thời tiết', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (31, 'Giải trí & sở thích', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (32, 'Trường học & học tập', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (33, 'Ngôn ngữ & giao tiếp', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (34, 'Tính từ & đặc điểm', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (35, 'Từ loại đặc biệt & trợ từ', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (36, 'Văn hóa – thói quen – lễ nghi', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (37, 'Mua sắm & giao dịch', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (38, 'Công việc, kinh doanh', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (39, 'Hoạt động thường ngày', NULL);
INSERT INTO public.vocabulary_categories (id, name_vi, name_en) VALUES (40, 'Động từ', NULL);


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
