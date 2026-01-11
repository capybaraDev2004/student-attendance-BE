�--
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

INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('6645ae2f-5d81-4547-98fc-d78847a9695d', '125129ea4fd79415539262108be923c94f57e40961180da1a0b90a620062adba', '2026-01-03 18:59:15.918477+07', '20251010091705_init_or_update', NULL, NULL, '2026-01-03 18:59:15.910924+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('63531f7d-a6cd-4bf6-a9ce-6b0f8bfadb1d', 'de8a3a311f3d78142b22e32dec8ee53e2db021da3374b4af428d19cb18f01b5c', '2026-01-05 19:59:55.368314+07', '20250104000000_remove_weekly_contest_progress', NULL, NULL, '2026-01-05 19:59:55.295932+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('f6be6bc0-d03f-411e-82f1-082d8000909d', 'a32a477f573b1f49da0a98a51cea4de38e5befbaed152d18cab23ac995344254', '2026-01-03 18:59:16.042957+07', '20251202100000_add_user_xp_streak', NULL, NULL, '2026-01-03 18:59:16.039537+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('1954515d-4dd5-43a8-ae16-e06148a0c2a4', 'ffa1c154709073ab419c643b91b360ac1f77ec0c47001c39d8b8751395345eea', '2026-01-03 18:59:15.909713+07', '20251002093443_init_schema', NULL, NULL, '2026-01-03 18:59:15.765755+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('b1efeae0-d67d-4309-995d-7f861a7113ba', '852874f96bac40c026d8cd509be73793d7dc2eec323c8b1611856bd0c0485e21', '2026-01-03 18:59:16.004067+07', '20251117131500_add_user_image_and_files', NULL, NULL, '2026-01-03 18:59:15.988241+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('c0f5f11f-0396-4a3f-9716-8e2b89146d81', '122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec', '2026-01-03 18:59:15.923215+07', '20251010092952_init_or_update', NULL, NULL, '2026-01-03 18:59:15.919949+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('c6b59e9d-3edc-4860-bdf2-7ad0b2d8acec', '1b4534dfa4e0f1266ec559edfc2348c775566d0ec585b19b8104ee87da80161e', '2026-01-03 18:59:15.95971+07', '20251010164523_add_stages_vocabulary_categories_sentences', NULL, NULL, '2026-01-03 18:59:15.924352+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('cbc8fb1f-027f-4f74-8f8a-9612880a49ec', '67cb1f0cd85963243c55e0d7e82b3ad9238bcbdb67a63e28c4ce772e93ca7419', '2026-01-03 18:59:15.964794+07', '20251117091500_add_user_account_fields', NULL, NULL, '2026-01-03 18:59:15.960797+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('5157a77f-94be-469a-91ec-0d713b5aa32d', '695e34068e234d6197b4bfec1447d16b24acd138c33709647c305061add1b542', '2026-01-03 18:59:16.008249+07', '20251117133500_add_region_and_address', NULL, NULL, '2026-01-03 18:59:16.005175+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('c0bfef16-7426-4952-bcf5-ded53a835ac5', '7246e9c52d0c02ff7d527895e2d5697709b70d1dea5b31d919fb0c09974cf5ae', '2026-01-03 18:59:15.977661+07', '20251117095000_update_account_type_enum', NULL, NULL, '2026-01-03 18:59:15.965532+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('a7b2b008-79e7-4401-a0d4-19b7bcae4e34', 'edd0e588fc3ecb76871956c37433b9ff427452acfec9a07c26f4339ba31b69d0', '2026-01-03 18:59:15.982606+07', '20251117103000_add_must_set_password', NULL, NULL, '2026-01-03 18:59:15.978689+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('13fecfd3-7196-49b1-b289-f7a0dadf04be', 'd6aa5857df7cca68a3ef2a124258f64d10fd9b6f6b48f04902f6283c96a5dd7f', '2026-01-03 18:59:16.071379+07', '20251217091000_weekly_contest_daily_lock', NULL, NULL, '2026-01-03 18:59:16.063884+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('70c24a95-f2e7-45ae-9e6d-29c856faf901', 'e18712f748336fa40ee8a99dd49b3994c19f50851a4bde739f762254227eefda', '2026-01-03 18:59:15.987249+07', '20251117120500_add_reset_code', NULL, NULL, '2026-01-03 18:59:15.983719+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('d2594462-19a3-4e3b-af72-331eb0bf1795', 'e83bdff67e324d0ef1f3b95c88cf6cbe161e259cb733593ddca870008df0a432', '2026-01-03 18:59:16.03134+07', '20251129222713_add_vocabulary_box_tables', NULL, NULL, '2026-01-03 18:59:16.009208+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('4d891d5a-ba1f-42ff-a4ae-4b95f1e4d407', '2cefa6b62d102ef83e985a37946bc813a5dc55defb7d6fe4ed3687d2a1e4af68', '2026-01-03 18:59:16.052038+07', '20251213194326_add_flashcards_table', NULL, NULL, '2026-01-03 18:59:16.044028+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('d89e2eab-fe76-41a7-8ba4-1e418764f0af', '70a34ffb0642bfd0b5cef4ad3f1d896ee913b4afd30f0f34644f4dd5767d54e3', '2026-01-03 18:59:16.03864+07', '20251129222909_update_vocabulary_box_one_per_user', NULL, NULL, '2026-01-03 18:59:16.032186+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('5b8d1ba4-855b-406a-90b3-355a5fec4553', '78bfda6ca7f9abb549bd49c753201764b3614e4d580cbe268161f8126004d96d', '2026-01-03 18:59:16.102358+07', '20251223120000_add_user_daily_scores', NULL, NULL, '2026-01-03 18:59:16.089703+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('e4ff55fc-ff5a-42ae-b6f0-3f2cea5a27f5', '04d142ee37a0b4535f7fdc4096fe660ec52c529cced8079d78bf6a3ea4a84041', '2026-01-03 18:59:16.062907+07', '20251217090000_add_weekly_contest_progress', NULL, NULL, '2026-01-03 18:59:16.052944+07', 1);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('f92ee254-293a-4069-8ab4-a3f5a21ad7ea', 'c8f7b4a53df491384ee1cbc548d5e3f5e7395eccf03acc3e9f1b4a1f6d52a0a0', '2026-01-03 19:06:14.356578+07', '20250103130000_change_daily_tasks_date_to_date', NULL, NULL, '2026-01-03 19:06:14.356578+07', 0);
INSERT INTO public._prisma_migrations ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES ('8308498e-f303-4f56-ac59-c6d1d0067179', 'c22167644d6151657062ba0f496b343882e46512f27d6c962394db9edcc0cf44', '2026-01-03 18:59:16.088477+07', '20251217094000_add_user_monthly_scores', NULL, NULL, '2026-01-03 18:59:16.072479+07', 1);


--
-- Data for Name: daily_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.daily_tasks ("id", "user_id", "vocabulary_count", "sentence_count", "contest_completed", "points_awarded", "points_given", "date", "created_at", "updated_at") VALUES (34, 4, 10, 5, true, 10, true, '2026-01-06', '2026-01-06 12:33:41.956', '2026-01-06 12:36:30.617');
INSERT INTO public.daily_tasks ("id", "user_id", "vocabulary_count", "sentence_count", "contest_completed", "points_awarded", "points_given", "date", "created_at", "updated_at") VALUES (1, 2, 10, 5, true, 10, true, '2026-01-04', '2026-01-05 11:57:25.474', '2026-01-05 12:16:23.682');
INSERT INTO public.daily_tasks ("id", "user_id", "vocabulary_count", "sentence_count", "contest_completed", "points_awarded", "points_given", "date", "created_at", "updated_at") VALUES (76, 4, 10, 5, true, 10, true, '2026-01-07', '2026-01-07 12:45:25.001', '2026-01-07 12:46:13.437');


--
-- Data for Name: flashcards; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (1, '/uploads/flashcards/2_1.png', '�&�', 'active', '2026-01-05 11:52:56.037', '2026-01-05 11:52:56.037');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (2, '/uploads/flashcards/3_1.png', '�Ƹ�Ƹ', 'active', '2026-01-05 11:53:25.542', '2026-01-05 11:53:25.542');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (3, '/uploads/flashcards/4_1.png', '鼻子', 'active', '2026-01-05 11:53:37.915', '2026-01-05 11:53:37.915');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (4, '/uploads/flashcards/5_1.png', '不', 'active', '2026-01-05 11:53:53.14', '2026-01-05 11:53:53.14');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (5, '/uploads/flashcards/6_1.png', '�"�', 'active', '2026-01-05 11:54:12.091', '2026-01-05 11:54:12.091');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (6, '/uploads/flashcards/7_1.png', '吒', 'active', '2026-01-05 11:54:26.02', '2026-01-05 11:54:26.02');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (7, '/uploads/flashcards/8_1.png', '大', 'active', '2026-01-05 11:54:39.634', '2026-01-05 11:54:39.634');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (8, '/uploads/flashcards/9_1.png', '多', 'active', '2026-01-05 11:54:52.378', '2026-01-05 11:54:52.378');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (9, '/uploads/flashcards/10_1.png', '��', 'active', '2026-01-05 11:55:40.018', '2026-01-05 11:55:59.943');
INSERT INTO public.flashcards ("id", "image_url", "answer", "status", "created_at", "updated_at") VALUES (10, '/uploads/flashcards/11_1.png', '謳�S�', 'active', '2026-01-05 11:56:13.107', '2026-01-05 11:56:13.107');


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.news ("id", "title", "content", "start_date", "end_date", "created_at", "updated_at") VALUES (1, 'ƯU Đ�I TRẢI NGHI� M VIP', 'M�i th�ng ch�ng t�i sẽ x�t lấy ra 10 người cao nhất theo to�n qu�c, theo miền, theo t�0nh �Ồ tặng trải nghi�!m VIP 1 th�ng.\\\\n- Lưu �: Khuyến mại kh�ng c�"ng d�n th�ng', '2026-01-06', '2030-11-06', '2026-01-06 13:42:07.633', '2026-01-06 13:42:07.633');


--
-- Data for Name: sentence_categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (1, 'Ch�o hỏi', 'Greetings');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (2, 'Gi�:i thi�!u bản th�n', 'Self Introduction');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (3, 'Gia ��nh', 'Family');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (4, 'M�u sắc', 'Colors');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (5, 'S� �ếm', 'Numbers');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (6, 'Thời gian', 'Time');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (7, 'Thời tiết', 'Weather');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (8, 'Thực phẩm', 'Food');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (9, 'Mua sắm', 'Shopping');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (10, 'Giao th�ng', 'Transportation');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (11, 'Sức khỏe', 'Health');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (12, 'Học tập', 'Education');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (13, 'C�ng vi�!c', 'Work');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (14, 'Du l�9ch', 'Travel');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (15, 'ThỒ thao', 'Sports');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (16, 'S�x th�ch', 'Hobbies');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (17, 'Cảm x�c', 'Emotions');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (18, 'Đ�9a �iỒm', 'Places');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (19, 'Mua b�n', 'Buying and Selling');
INSERT INTO public.sentence_categories ("id", "name_vi", "name_en") VALUES (20, 'Đi�!n thoại v� Internet', 'Phone and Internet');


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (1, '你好', 'Nǐ hǎo', 'Xin ch�o', 1);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (2, '��上好', 'Zǎoshang hǎo', 'Ch�o bu�"i s�ng', 1);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (3, '�"�上好', 'Wǎnshang hǎo', 'Ch�o bu�"i t�i', 1);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (4, '� �见', 'Z�iji�n', 'Tạm bi�!t', 1);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (5, '谢谢', 'Xi�xie', 'Cảm ơn', 1);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (6, '��叫小�܎', 'W� ji�o Xiǎom�ng', 'T�i t�n l� TiỒu Minh', 2);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (7, '��来�!�越�', 'W� l�iz� Yu�n�n', 'T�i �ến từ Vi�!t Nam', 2);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (8, '��今年�R十�岁', 'W� jīnni�n �rsh�w� su�', 'NĒm nay t�i hai mươi lĒm tu�"i', 2);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (9, '���ܯ学�x', 'W� sh� xu�sheng', 'T�i l� sinh vi�n', 2);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (10, '�����&�认� 你', 'H�:n gāox�ng r�nshi nǐ', 'Rất vui �ược l�m quen v�:i bạn', 2);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (11, '�"�ܯ���家人', 'Zh� sh� w� de jiār�n', 'Đ�y l� gia ��nh t�i', 3);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (12, '���S0两个�&�x', 'W� y�u liǎng g� xiōngd�', 'T�i c� hai người anh em', 3);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (13, '���ƶ母��健康', 'W� f�m� h�:n ji�nkāng', 'B� mẹ t�i rất khỏe mạnh', 3);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (14, '��姐姐�ܯ謁��', 'W� ji�:jie sh� lǎoshī', 'Ch�9 g�i t�i l� gi�o vi�n', 3);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (15, '��们丬家人��幸福', 'W�men yījiār�n h�:n x�ngf�', 'Gia ��nh ch�ng t�i rất hạnh ph�c', 3);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (16, '���S欢红�0�', 'W� xǐhuan h�ngs�', 'T�i th�ch m�u �ỏ', 4);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (17, '天空�ܯ���0��', 'Tiānkōng sh� l�ns� de', 'Bầu trời m�u xanh', 4);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (18, '�"�S�花�ܯ��0��', 'Zh� du� huā sh� hu�ngs� de', 'B�ng hoa n�y m�u v�ng', 4);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (19, '��0��ܯ����S��Ʊ', 'H�is� sh� w� de zu� �i', 'M�u �en l� m�u y�u th�ch của t�i', 4);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (20, '�"��0�代表纯洁', 'B�is� d�ibiǎo ch�nji�', 'M�u trắng tượng trưng cho sự trong trắng', 4);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (21, '丬加丬�0于�R', 'Yī jiā yī d�:ngy� �r', 'M�"t c�"ng m�"t bằng hai', 5);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (22, '���S0�0个�9��S', 'W� y�u sān g� p�nggu�', 'T�i c� ba quả t�o', 5);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (23, '今天�ܯ��S�十�号', 'Jīntiān sh� w�yu� sh�w� h�o', 'H�m nay l� ng�y mười lĒm th�ng nĒm', 5);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (24, '�"�S�书�S0��"�页', 'Zh� b�:n shū y�u w�bǎi y�', 'Cu�n s�ch n�y c� nĒm trĒm trang', 5);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (25, '��买� 十���', 'W� mǎile sh� zhī bǐ', 'T�i �� mua mười c�y b�t', 5);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (26, '现�S��!���� �x', 'Xi�nz�i jǐ diǎn le?', 'B�y giờ mấy giờ r�i?', 6);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (27, '��每天��上丒��起床', 'W� m�:itiān zǎoshang qī diǎn qǐchu�ng', 'M�i s�ng t�i thức dậy l�c bảy giờ', 6);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (28, '今天�ܯ��x�Sx丬', 'Jīntiān sh� xīngqīyī', 'H�m nay l� thứ Hai', 6);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (29, '��们�9个�S�去�&�R', 'W�men xi� g� yu� q� lǚx�ng', 'Th�ng sau ch�ng t�i sẽ �i du l�9ch', 6);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (30, '会议�S��9���0��弬�9', 'Hu�y� z�i xi�w� sān diǎn kāishǐ', 'Cu�"c họp bắt �ầu l�c ba giờ chiều', 6);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (31, '今天天���好', 'Jīntiān tiānq� h�:n hǎo', 'H�m nay thời tiết rất �ẹp', 7);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (32, '�面�S��9�:�', 'W�imi�n z�i xi� y�', 'B�n ngo�i �ang mưa', 7);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (33, '今天��璭', 'Jīntiān h�:n r�', 'H�m nay rất n�ng', 7);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (34, '� �天��� �', 'Dōngtiān h�:n l�:ng', 'M�a ��ng rất lạnh', 7);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (35, '�܎天会�"�天', 'M�ngtiān hu� q�ngtiān', 'Ng�y mai sẽ nắng', 7);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (36, '��撳吒面条', 'W� xiǎng chī mi�nti�o', 'T�i mu�n Ēn m�', 8);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (37, '�"个�S��好吒', 'Zh� g� c�i h�:n hǎochī', 'M�n Ēn n�y rất ngon', 8);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (38, '���S欢吒水�S', 'W� xǐhuan chī shuǐgu�', 'T�i th�ch Ēn tr�i c�y', 8);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (39, '请�"��丬杯水', 'Qǐng g�:i w� yī b�i shuǐ', 'Xin cho t�i m�"t c�c nư�:c', 8);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (40, '��不�S欢吒辣�', 'W� b� xǐhuan chī l� de', 'T�i kh�ng th�ch Ēn cay', 8);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (41, '�"件衣�S�多����x', 'Zh� ji�n yīfu duōshao qi�n?', 'B�" quần �o n�y bao nhi�u tiền?', 9);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (42, '��可以�"穿��x', 'W� k�:yǐ sh�chuān ma?', 'T�i c� thỒ thử �ược kh�ng?', 9);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (43, '太贵� �R蒽便�S����x', 'T�i gu� le, n�ng pi�nyi diǎn ma?', 'Đắt qu�, c� thỒ rẻ hơn m�"t ch�t kh�ng?', 9);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (44, '��要买�"个', 'W� y�o mǎi zh� g�', 'T�i mu�n mua c�i n�y', 9);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (45, '可以��信��卡��x', 'K�:yǐ y�ng x�ny�ngkǎ ma?', 'C� thỒ d�ng thẻ t�n dụng kh�ng?', 9);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (46, '��要去�S��S�', 'W� y�o q� jīchǎng', 'T�i mu�n �i �ến s�n bay', 10);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (47, '欎��去火车�"�x', 'Z�:nme q� hu�ch�zh�n?', 'L�m sao �Ồ �ến ga t�u?', 10);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (48, '��坐�&�交车上班', 'W� zu� gōngjiāoch� sh�ngbān', 'T�i �i xe bu�t �i l�m', 10);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (49, '请弬�&�丬��', 'Qǐng kāi m�n yīdiǎn', 'Xin l�i chậm m�"t ch�t', 10);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (50, '�"�!R可以�S车��x', 'Zh�lǐ k�:yǐ t�ngch� ma?', 'Ở ��y c� thỒ �� xe kh�ng?', 10);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (51, '��头��', 'W� t�ut�ng', 'T�i b�9 �au �ầu', 11);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (52, '你�S�要去�S9�R��x', 'Nǐ xūy�o q� k�n yīsh�ng', 'Bạn cần �i kh�m b�c sĩ', 11);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (53, '���x� � ', 'W� gǎnm�o le', 'T�i b�9 cảm', 11);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (54, '多��水�R多�息', 'Duō h� shuǐ, duō xiūxi', 'U�ng nhiều nư�:c, ngh�0 ngơi nhiều', 11);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (55, '���x�0好多� ', 'W� gǎnju� hǎo duō le', 'T�i cảm thấy khỏe hơn nhiều r�i', 11);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (56, '���S�学中�!', 'W� z�i xu� Zhōngw�n', 'T�i �ang học tiếng Trung', 12);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (57, '�"个�欎��� "�x', 'Zh� g� z� z�:nme xi�:?', 'Chữ n�y viết như thế n�o?', 12);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (58, '请� �说丬遍', 'Qǐng z�i shuō yībi�n', 'Xin n�i lại m�"t lần nữa', 12);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (59, '���܎天�S0謒�"', 'W� m�ngtiān y�u kǎosh�', 'Ng�y mai t�i c� b�i thi', 12);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (60, '你�S业做�R� ��x', 'Nǐ zu�y� zu�w�n le ma?', 'Bạn �� l�m xong b�i tập chưa?', 12);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (61, '���ܯ工�9��', 'W� sh� gōngch�ngshī', 'T�i l� kỹ sư', 13);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (62, '��九��上班', 'W� ji� diǎn sh�ngbān', 'T�i �i l�m l�c ch�n giờ', 13);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (63, '今天工�S���"', 'Jīntiān gōngzu� h�:n m�ng', 'H�m nay c�ng vi�!c rất bận', 13);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (64, '���9班� ', 'W� xi�bān le', 'T�i �� tan l�m', 13);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (65, '�"个项�:����!�要', 'Zh� g� xi�ngm� h�:n zh�ngy�o', 'Dự �n n�y rất quan trọng', 13);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (66, '��撳去�R京�&游', 'W� xiǎng q� B�:ijīng lǚy�u', 'T�i mu�n �i du l�9ch Bắc Kinh', 14);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (67, '�"�!R风�"���美', 'Zh�lǐ f�ngjǐng h�:n m�:i', 'Cảnh �ẹp �x ��y rất �ẹp', 14);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (68, '��要订丬个�ƿ��', 'W� y�o d�ng yī g� f�ngjiān', 'T�i mu�n �ặt m�"t ph�ng', 14);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (69, '请�"��丬张�S��:�', 'Qǐng g�:i w� yī zhāng d�t�', 'Xin cho t�i m�"t tấm bản ��', 14);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (70, '�"个�x�����S0名', 'Zh� g� ch�ngsh� h�:n y�um�ng', 'Th�nh ph� n�y rất n�"i tiếng', 14);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (71, '���S欢�0篮琒', 'W� xǐhuan dǎ l�nqi�', 'T�i th�ch chơi b�ng r�"', 15);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (72, '��每天�步', 'W� m�:itiān pǎob�', 'T�i chạy b�" m�i ng�y', 15);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (73, '足琒��:��精彩', 'Z�qi� bǐs�i h�:n jīngcǎi', 'Trận �ấu b�ng �� rất hay', 15);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (74, '��要去健身�ƿ', 'W� y�o q� ji�nsh�nf�ng', 'T�i mu�n �i ph�ng gym', 15);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (75, '运动对身�好', 'Y�nd�ng du� sh�ntǐ hǎo', 'Tập thỒ dục t�t cho sức khỏe', 15);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (76, '���S欢听�x�乐', 'W� xǐhuan tīng yīnyu�', 'T�i th�ch nghe nhạc', 16);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (77, '���Ʊ好读书', 'W� �ih�o d�shū', 'T�i th�ch �ọc s�ch', 16);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (78, '���S����S欢�S9��影', 'Zhōum� w� xǐhuan k�n di�nyǐng', 'Cu�i tuần t�i th�ch xem phim', 16);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (79, '��会弹��琴', 'W� hu� t�n gāngq�n', 'T�i biết chơi ��n piano', 16);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (80, '�����ܯ����Ʊ好', 'Hu�hu� sh� w� de �ih�o', 'Vẽ tranh l� s�x th�ch của t�i', 16);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (81, '�������&�', 'W� h�:n gāox�ng', 'T�i rất vui', 17);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (82, '���S0��累', 'W� y�udiǎn l�i', 'T�i hơi m�!t', 17);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (83, '�����9&忒', 'W� h�:n dānxīn', 'T�i rất lo lắng', 17);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (84, '�"让�����x�', 'Zh� r�ng w� h�:n sh�ngq�', 'Điều n�y l�m t�i rất tức giận', 17);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (85, '���x�ư����松', 'W� gǎnd�o h�:n f�ngsōng', 'T�i cảm thấy rất thư gi�n', 17);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (86, '���R�S����!R�x', 'Y�nh�ng z�i nǎlǐ?', 'Ng�n h�ng �x ��u?', 18);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (87, '��要去�:�书� ', 'W� y�o q� t�shūguǎn', 'T�i mu�n �i thư vi�!n', 18);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (88, '�R��"��S���边', 'Yīyu�n z�i n�biān', 'B�!nh vi�!n �x �ằng kia', 18);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (89, '学校离�"�!R���S', 'Xu�xi�o l� zh�lǐ h�:n yuǎn', 'Trường học c�ch ��y rất xa', 18);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (90, '�&��S�左边', 'Chāosh� z�i zu�biān', 'Si�u th�9 �x b�n tr�i', 18);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (91, '��撳��"� 车', 'W� xiǎng m�i zh� li�ng ch�', 'T�i mu�n b�n chiếc xe n�y', 19);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (92, '�"个价格��� ��x', 'Zh� g� ji�g� h�lǐ ma?', 'Gi� n�y c� hợp l� kh�ng?', 19);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (93, '��要买���09�S�', 'W� y�o mǎi xīn sh�ujī', 'T�i mu�n mua �i�!n thoại m�:i', 19);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (94, '可以�0����x', 'K�:yǐ dǎzh� ma?', 'C� thỒ giảm gi� kh�ng?', 19);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (95, '����现�!', 'W� f� xi�njīn', 'T�i trả bằng tiền mặt', 19);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (96, '你���话号码�ܯ多��x', 'Nǐ de di�nhu� h�omǎ sh� duōshao?', 'S� �i�!n thoại của bạn l� bao nhi�u?', 20);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (97, '请�"���微信', 'Qǐng g�:i w� fā W�ix�n', 'Xin gửi cho t�i tin nhắn WeChat', 20);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (98, '��S连接不好', 'Wǎnglu� li�nji� b� hǎo', 'Kết n�i mạng kh�ng t�t', 20);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (99, '��要�9载�"个���', 'W� y�o xi�z�i zh� g� y�ngy�ng', 'T�i mu�n tải ứng dụng n�y', 20);
INSERT INTO public.sentences ("id", "chinese_simplified", "pinyin", "vietnamese", "category_id") VALUES (100, '请加��微信', 'Qǐng jiā w� W�ix�n', 'Xin th�m t�i v�o WeChat', 20);


--
-- Data for Name: user_daily_scores; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_daily_scores ("id", "user_id", "score", "score_date", "created_at", "updated_at") VALUES (1, 2, 11, '2026-01-04', '2026-01-05 11:45:14.87', '2026-01-05 11:57:24.391');
INSERT INTO public.user_daily_scores ("id", "user_id", "score", "score_date", "created_at", "updated_at") VALUES (20, 4, 13, '2026-01-06', '2026-01-06 12:34:35.036', '2026-01-06 12:36:26.434');
INSERT INTO public.user_daily_scores ("id", "user_id", "score", "score_date", "created_at", "updated_at") VALUES (33, 4, 4, '2026-01-07', '2026-01-07 12:44:39.652', '2026-01-07 12:45:23.958');


--
-- Data for Name: user_monthly_scores; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_monthly_scores ("id", "user_id", "score", "month_cycle", "created_at", "updated_at") VALUES (1, 2, 21, '2026-01', '2026-01-05 11:45:14.887', '2026-01-05 12:16:23.685');
INSERT INTO public.user_monthly_scores ("id", "user_id", "score", "month_cycle", "created_at", "updated_at") VALUES (13, 4, 54, '2026-01', '2026-01-06 12:21:27.311', '2026-01-07 12:46:13.495');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users ("user_id", "username", "email", "password_hash", "created_at", "role", "email_confirmed", "verification_code", "verification_code_expires_at", "account_status", "account_type", "must_set_password", "reset_code", "reset_code_expires_at", "image_url", "address", "province", "region", "xp", "streak_days") VALUES (2, 'Nguyen Toan', 'toannguyentien10091998@gmail.com', '$2b$10$5Yc0roYITIdLfyI7zn2MH.EzCwEek/cSLh1R5DpyWE28WfeSvEKK6', '2026-01-05 11:38:49.944', 'admin', true, NULL, NULL, 'normal', 'google', false, NULL, NULL, NULL, NULL, 'Bắc Ninh', 'bac', 0, 0);
INSERT INTO public.users ("user_id", "username", "email", "password_hash", "created_at", "role", "email_confirmed", "verification_code", "verification_code_expires_at", "account_status", "account_type", "must_set_password", "reset_code", "reset_code_expires_at", "image_url", "address", "province", "region", "xp", "streak_days") VALUES (3, 'Dev Capybara', 'capybaradev2004@gmail.com', '$2b$10$/fJXe1MCfrmdYqM10Sl3.eUFN0RRulN0wKAvshBPUmaasWDKXnYbG', '2026-01-05 12:47:31.37', 'customer', true, NULL, NULL, 'vip', 'google', false, NULL, NULL, NULL, NULL, NULL, 'bac', 0, 0);
INSERT INTO public.users ("user_id", "username", "email", "password_hash", "created_at", "role", "email_confirmed", "verification_code", "verification_code_expires_at", "account_status", "account_type", "must_set_password", "reset_code", "reset_code_expires_at", "image_url", "address", "province", "region", "xp", "streak_days") VALUES (4, 'To�n Nguy�&n', 'toannguyentien28022004@gmail.com', '$2b$10$M3diGKavYdpH6TljdwjbReZwuU0VTeDp.6EHeXBWcFgSywV1.zRQm', '2026-01-06 12:09:17.768', 'admin', true, NULL, NULL, 'normal', 'google', false, NULL, NULL, NULL, NULL, 'H� N�"i', 'bac', 0, 0);


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1275, '�:���', 'g�r�n', 'tất nhi�n, c� nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (766, '坚定', 'jiānd�ng', 'ki�n ��9nh, vững v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1510, '建�', 'ji�nzh�', 't�a nh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1533, '�""训', 'ji�ox�n', 'gi�o huấn, dạy bảo', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2443, '启示', 'qǐsh�', 'gợi �, gợi cho biết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2760, '示�R�', 'sh�f�n', 'gương s�ng, gương t�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1, '⬦�� �9⬦', '⬦f�n zhī⬦', 'chi nh�nh, phần (trĒm)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (463, '�Ɛ� x', 'ch�ngsh�', 'th�nh thục, trư�xng th�nh, ch�n chắn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (620, '�9�" ', 'cuōshāng', 'b�n bạc, h�"i �, trao ��"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1793, '举�瞩�:�', 'j�sh� zh�m�', 'thu h�t sự ch� � tr�n to�n thế gi�:i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2803, '实�9��ܯ', 'sh�sh�qi�sh�', 'thật th� cầu th�9', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2825, '���:�', 'shōuy�', 'lợi nhuận, thu lợi', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2947, '台', 't�i', '��i, b�!, s�n khấu, chiếc', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3042, '�S�""', 't�ngli�', 'dừng lại, �x lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3403, '形状', 'x�ngzhu�ng', 'h�nh d�ng, h�nh dạng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3557, '�x花�� 竹', 'yānhuā b�ozh�', 'ph�o hoa, ph�o n�"', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3829, '��& ', 'y�zh�o', '�iềm b�o, dấu hi�!u', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2, '�"�', 'a', 'a, �, ừ, ờ', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4196, '� 0', 'zu�', 'say rượu, bia', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1132, '工夫', 'gōngfū', 'thời gian, người l�m thu�, c�ng sức, rảnh r�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1330, '���Ɛ', 'h�ch�ng', 'hợp th�nh, c�u th�nh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3, '��', 'ā', 'ơ, �:i, ui, ui cha', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4, '�Ʊ', '�i', 'y�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (5, '�x�', 'ǎi', 'thấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (6, '�0', 'āi', '�i, than �i, trời ơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (7, '�R�', '�i', 'b�9, ch�9u �ựng, gặp phải', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (69, '�架', 'bǎngji�', 'bắt c�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (8, '�Ʊ不�!��09', '�ib�sh�sh�u', 'quyến luyến kh�ng rời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (796, '顶', 'dǐng', '��0nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (9, '�Ʊ�ƴ', '�id�i', 'y�u qu�, k�nh y�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (10, '�Ʊ好', '�ih�o', 'y�u th�ch, th�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (585, '�!��x车', 'chūzūch�', 'Taxi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (11, '�Ʊ护', '�ih�', 'y�u qu�, bảo v�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1098, '��', 'g�', 'anh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (12, '暧�ܧ', '�im�i', 'mập mờ, mờ �m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (13, '�Ʊ�&', '�iq�ng', 't�nh y�u', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1005, '�� ', 'f�n', 'phần, suất', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (14, '�Ʊ�S', '�ixī', 'y�u qu�, qu� trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1478, '�', 'j�', 'gửi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (15, '�Ʊ忒', '�ixīn', 'l�ng nh�n �i, y�u thương', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (16, '���x', 'āiyō', '�i, �i chao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (17, '�"R�!', '�izh�ng', 'ung thư', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (18, '岸', '�n', 'bờ (s�ng, biỒn)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1212, '管子', 'guǎnzi', '�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (19, '�', '�n', 't�i, u �m, thầm, vụng tr�"m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (20, '�R0', '�n', 'ấn, bấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2002, '另', 'l�ng', 'kh�c', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (21, '��件', '�nji�n', '�n vụ, trường hợp, �n ki�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (22, '�0�&乐业', 'ānjūl�y�', 'an cư lạc nghi�!p', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (23, '���9', '�nl�', '�n l�!', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (24, '�R0��', '�nm�', 'xoa b�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (25, '�R0��', '�nsh�', '��ng giờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (26, '�R0�&�', '�nzh�o', 'cĒn cứ theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1214, '孤�"', 'gūdān', 'c� �ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (27, '�0�', 'ānp�i', 'sắp xếp, b� tr�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (28, '�0�&�', 'ānqu�n', 'an to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (29, '�示', '�nsh�', '�m th�9, ra hi�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (30, '��', '�n', 'vụ, �n, h� sơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (31, '�0�&�', 'ānw�i', 'an ủi', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (32, '�0详', 'ānxi�ng', '�m �ềm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1321, '毫米', 'h�omǐ', 'milimet', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1322, '好�!', 'h�oq�', 'hiếu kỳ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1428, '�!报', 'hu�b�o', 'b�o c�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (33, '�R0睬', '�nzhe', 'cĒn cứ, dựa theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4064, '粥', 'zhōu', 'ch�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (35, '�0�&', 'ānzhuāng', 'lắp �ặt', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (52, '�"�', 'bǎi', 'trĒm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (57, '�9S年', 'b�ini�n', '�i ch�c tết', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (65, '颁�', 'bānfā', 'ban ph�t', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (66, '�', 'b�ng', 'gậy', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (34, '�0置', '�nzh�', 'b� tr� �"n thỏa, �"n ��9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (36, '� �', '�o', 'sắc, hầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (37, '奥��', '�om�', 'huyền b�, b� ẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (38, '�!��!�', 'āotū', 'l�i l�m, g� ghề', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (39, '�ܿ姨', 'Ĭy�', 'c�, d�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (40, '吧', 'ba', 'nh�, nha', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (41, '把', 'bǎ', 'lấy, �em', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (42, '�9', 'b�', 'nh�", r�t ra', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (43, '��', 'bā', 'vết sẹo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (44, '�Ƹ�Ƹ', 'b�ba', 'b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (45, '巴不�', 'bāb�d�', 'ư�:c g�, ch�0 mong', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (46, '�S��', 'b�d�o', 'b� �ạo, ��"c t�i, chuy�n chế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (47, '罢工', 'b�gōng', '��nh c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (49, '�"�', 'b�i', 'trắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (50, '� ', 'bǎi', 'xếp �ặt, b�y bi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (51, '�x�', 'bǎi', 'trầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (53, '�9S', 'b�i', 'b�i, lạy, thờ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (54, '�9S访', 'b�ifǎng', '�ến thĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (55, '�"��� ��', 'bǎif�ndiǎn', '�iỒm phần trĒm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (56, '败坏', 'b�ihu�i', 'hư hỏng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (58, '�9S�0�', 'b�ituō', 'xin nhờ, k�nh nhờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (59, '� ��', 'bǎituō', 'tho�t khỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (60, '�"���梦', 'b�ir�m�ng', 'm�"ng ban ng�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (61, '班', 'bān', 'l�:p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (62, '�0��S�', 'bǎnb�:n', 'phi�n bản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (63, '颁帒', 'bānb�', 'ban h�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (64, '办�"', 'b�nfǎ', 'bi�!n ph�p, c�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (67, '帮', 'bāng', 'bĒng, nh�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (68, '帮�"', 'bāngm�ng', 'gi�p, gi�p �ỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (121, '保管', 'bǎoguǎn', 'bảo quản', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (80, '� �蒱', 'bǎngguāng', 'b�ng quang', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (97, '报社', 'b�osh�', 't�a soạn, t�a b�o', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (84, '�R&�!', 'bāob�', 'bao che, che �ậy', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (87, '宝贵', 'bǎogu�', 'qu� gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (88, '�R&含', 'bāoh�n', 'chứa, bao g�m', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (91, '保�"�', 'bǎoxiǎn', 'bảo hiỒm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (119, '保� ', 'bǎom�', 'bảo mẫu, người gi�p vi�!c', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (151, '�波', 'b�nbō', 'b�n ba', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (117, '报�', 'b�od�', '�ền ��p', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (71, '���"�', 'b�ngwǎn', 'xẩm t�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (72, '�S样', 'bǎngy�ng', 'tấm gương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (73, '帮助', 'bāngzh�', 'gi�p �ỡ, h� trợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (74, '办� ', 'b�nlǐ', 'xử l�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (75, '办�9', 'b�nsh�', 'l�m vi�!c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (76, '伴侣', 'b�nlǚ', 'bạn �ời, bạn ��ng h�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (78, '班主任', 'bānzh�r�n', 'gi�o vi�n chủ nhi�!m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (79, '板', 'bǎn', 'v�n, tấm v�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (81, '抱', 'b�o', '�m, bế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (82, '�R&', 'bāo', 'bọc, t�i, g�i', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (83, '宝贝', 'bǎob�i', 'bảo b�i, cưng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (96, '暴�S�', 'b�ol�', 'b�"c l�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (85, '保�R�', 'bǎoch�', 'duy tr�, giữ g�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (86, '保护', 'bǎoh�', 'bảo v�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (123, '暴风', 'b�of�ng', 'b�o t�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (109, '�R&�&', 'bāozhuāng', 'g�i, bọc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (90, '暴�:', 'b�ol�', 'bạo lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (155, '崩�', 'b�ngfā', 'b�ng ra, ph�t n�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (92, '保��', 'bǎosh�u', 'bảo thủ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (93, '保卫', 'bǎow�i', 'bảo v�!, ủng h�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (94, '报名', 'b�om�ng', 'b�o danh, �Ēng k�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (95, '报��', 'b�og�o', 'b�o c�o, th�ng b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (163, '�S�身', 'b�:nsh�n', 'tự bản th�n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (166, '�S�质', 'b�:nzh�', 'bản chất', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (98, '报�&�', 'b�ochou', 'th� lao, tiền c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (99, '报纸', 'b�ozhǐ', 'b�o ch�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (100, '�R&裹', 'bāogu�', 'bưu ki�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (101, '�R&容', 'bāor�ng', 'khoan dung, bao dung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (102, '报�!', 'b�och�u', 'b�o th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (104, '抱欨', 'b�oyu�n', 'o�n hận, ph�n n�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (105, '保证', 'bǎozh�ng', '�ảm bảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (106, '保�!�', 'bǎozh�ng', 'bảo trọng, cẩn thận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (107, '报复', 'b�of�', 'trả th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (108, '报�x', 'b�of�', 'ho�i b�o, tham vọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (111, '报��', 'b�oxiāo', 'thanh to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (110, '报�&�', 'b�oguān', 'khai hải quan', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (112, '保�0', 'bǎo�"ān', 'bảo v�! an ninh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (113, '保�', 'bǎoy�u', 'ph� h�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (114, '保�S', 'bǎozh�ng', '�ảm bảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (115, '保�&�', 'bǎoyǎng', 'bảo dưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (118, '�� ��', 'b�ozh�', 'n�", b�ng n�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (120, '暴�:�', 'b�oy�', 'mưa to', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (122, '宝�x�', 'bǎosh�', '�� qu�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (124, '保证�!', 'bǎozh�ngjīn', 'tiền bảo chứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (125, '保��', 'bǎoc�n', 'bảo t�n, lưu giữ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (126, '�R&子', 'bāozi', 'b�nh bao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (128, '把�Ə', 'bǎx�', 'xiếc, tr� lừa b�9p', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (129, '嬍', 'b�i', 'lần, gấp b�"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (130, '被', 'b�i', 'b�9, �ược', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (131, '�R', 'b�i', 'lưng, học thu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (132, '�R诵', 'b�is�ng', '�ọc thu�"c l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (133, '����', 'b�i�"āi', 'bi ai, �au bu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (135, '��撨', 'b�icǎn', 'bi thảm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (136, '被动', 'b�id�ng', 'b�9 ��"ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (137, '�R��', 'b�:ifāng', 'miền Bắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (138, '�!份', 'b�if�n', 'd�nh ri�ng, bản dự ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (139, '被��', 'b�ig�o', 'b�9 c�o', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (140, '���', 'b�iguān', 'bi quan', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (141, '�R极', 'b�:ij�', 'bắc cực', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (143, '�R京', 'b�:ijīng', 'Bắc Kinh', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (144, '贝壳', 'b�ik�', 'vỏ s�, vỏ �c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (145, '�R�:', 'b�ip�n', 'phản b�"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (146, '�!���"', 'b�iw�ngl�', 'bản ghi nh�:', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (147, '被子', 'b�izi', 'chĒn', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (148, '杯子', 'b�izi', 'c�c, ch�n, ly, t�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (149, '笨', 'b�n', '�ần, ng�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (150, '�S�', 'b�:n', 'quyỒn, g�c, v�n, th�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (153, '��', 'b�ng', 'kh�ng cần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (154, '蹦', 'b�ng', 'nhảy, bật, tung ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (156, '崩溒', 'b�ngku�', 'tan vỡ, sụp ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (157, '�S��', 'b�:nk�', 'khoa ch�nh quy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (158, '�S�来', 'b�:nl�i', 'v�n dĩ, l�c �ầu, ��ng lẽ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (159, '�S�� ', 'b�:nlǐng', 'bản lĩnh, khả nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (160, '�S�蒽', 'b�:nn�ng', 'bản nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (161, '�S���', 'b�:nqi�n', 'v�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (162, '�S�人', 'b�:nr�n', 'bản th�n, t�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (164, '�S��9', 'b�:nshi', 'khả nĒng, bản lĩnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (165, '�S�睬', 'b�:nzhe', 'cĒn cứ, dựa v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (167, '笨�9"', 'b�nzhuō', 'vụng về', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (168, '�!', 'b�', 'c�nh tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (170, '便', 'bi�n', 'ngay cả, �ủ cho, liền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (171, '遍', 'bi�n', 'lần, khắp', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (172, '�', 'biān', 'd�!t, bi�n soạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (173, '遍帒', 'bi�nb�', 'ph�n b�, rải r�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (174, '鞭�', 'biānc�', 'th�c giục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (175, '贬低', 'biǎndī', 'ch� bai, hạ thấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (182, '边�"R', 'biānji�', 'ranh gi�:i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (248, '��塞', 'b�s�', 'tắc nghẽn, bế tắc', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (190, '贬�0', 'biǎny�', 'nghĩa xấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (203, '表� �', 'biǎoju�', 'biỒu quyết, bầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (217, '�&定', 'b�d�ng', 'nhất ��9nh, chắc chắn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (224, '�ƫ�!�', 'bi�zh�', '��"c ��o, m�:i mẻ, kh�c thường', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (226, '�辒', 'bǐji�o', 'so v�:i, so s�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (230, '避�&�', 'b�miǎn', 'tr�nh', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (234, '�&�', 'b�ngd�', 'vi r�t', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (255, '鼻子', 'b�zi', 'mũi', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (245, '�&要', 'b�y�o', 'cần', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (177, '辩护', 'bi�nh�', 'bi�!n h�", bảo v�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (178, '���R', 'bi�nhu�', 'thay ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (179, '��', 'biānj�', 'bi�n tập, ch�0nh sửa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (180, '边� ', 'biānjiāng', 'bi�n gi�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (181, '辩解', 'bi�nji�:', 'bi�!n giải, giải th�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (183, '边墒', 'biānj�ng', 'bi�n gi�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (184, '便�Ʃ', 'bi�nl�', 'ti�!n lợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (185, '辩论', 'bi�nl�n', 'tranh luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (186, '鞭��', 'biānp�o', 'ph�o hoa, ph�o n�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (187, '��迁', 'bi�nqiān', 'thay ��"i, biến ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (188, '辨认', 'bi�nr�n', 'nhận r�, ph�n bi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (189, '便条', 'bi�nti�o', 'giấy nhắn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (191, '便于', 'bi�ny�', 'ti�!n lợi, ti�!n cho', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (193, '辩证', 'bi�nzh�ng', 'bi�!n chứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (194, '��质', 'bi�nzh�', 'biến chất, hư hỏng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (195, '��!', 'biānzhī', 'b�!n, �an, tết', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (196, '辫子', 'bi�nzi', 'b�m t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (197, '�!�S�', 'biāob�:n', 'mẫu, ti�u bản', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (198, '表达', 'biǎod�', 'biỒu �ạt, di�&n tả', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (199, '�!��', 'biāodiǎn', 'chấm c�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (200, '表格', 'biǎog�', 'bảng, biỒu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (201, '表��', 'biǎog�', 'anh họ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (204, '表面', 'biǎomi�n', 'mặt ngo�i, bề ngo�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (205, '表�܎', 'biǎom�ng', 'tỏ r�, chứng tỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (206, '表�&', 'biǎoq�ng', 'biỒu cảm, n�t mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (207, '表�', 'biǎoyǎn', 'biỒu di�&n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (208, '表彰', 'biǎozhāng', 'tuy�n dương, khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (209, '表示', 'biǎosh�', 'biỒu th�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (210, '表欁', 'biǎot�i', 'b�y tỏ th�i ��"', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (211, '表�0�', 'biǎoy�ng', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (212, '�!�', 'biāozh�', 'c�"t m�c, k� hi�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (213, '�!�! ', 'biāozh�n', 'ti�u chuẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (215, '彼此', 'bǐcǐ', 'lẫn nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (216, '便签', 'bi�nqiān', 'giấy ghi nh�:', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (218, '弊端', 'b�duān', 't�! nạn, tai hại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (219, '�ƫ', 'bi�', 'kh�c, chia l�a', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (220, '� 9', 'bi�', 'b�9t, n�n, kim n�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (221, '�ƫ�0�', 'bi�niu', 'kh� ch�9u, chư�:ng, kỳ quặc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (222, '�ƫ人', 'bi�r�n', 'người kh�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (223, '�ƫ�&', 'bi�sh�', 'bi�!t thự', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (225, '���', 'bǐfāng', 'v�, so s�nh, so b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (228, '�"�x', 'b�j�ng', 'r�t cu�"c, cu�i c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (229, '��9', 'bǐl�', 'tỷ l�!', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (231, '�"', 'bǐng', 'thứ ba, B�nh', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (232, '� ��:�', 'bīngb�o', 'mưa ��', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (233, '并��', 'b�ngc�n', 'c�ng t�n tại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (235, '并非', 'b�ngf�i', 'kh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (236, '饼干', 'bǐnggān', 'b�nh quy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (238, '并�', 'b�ngqi�:', '��ng thời, v�, hơn nữa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (239, '并�R', 'b�ngx�ng', 'song h�nh, song song', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (240, '宾� ', 'bīnguǎn', 'nh� kh�ch, kh�ch sạn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (241, '� �箱', 'bīngxiāng', 'tủ lạnh, tủ ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (242, '� �濬�!R', 'bīngjīl�ng', 'kem', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (243, '滨临', 'bīnl�n', 'kề b�n, kề cận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (244, '��弒', 'b�nq�', 'từ bỏ, vứt bỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (246, '��', 'bǐr�', 'v� dụ như, chẳng hạn như', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (247, '��:', 'bǐs�i', 'thi �ấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (249, '�R', 'b�', 'tiết (chất lỏng)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (251, '�"业', 'b�y�', 't�t nghi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (252, '碧�0', 'b�y�', 'ngọc b�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (253, '���', 'bǐy�', 'v� dụ, v� von', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (254, '��!�', 'bǐzh�ng', 'tỷ trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (256, '�9��0', 'bōdǎ', 'gọi (�i�!n thoại)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (257, '博大精深', 'b�d�jīngsh�n', 'uy�n b�c, uy�n th�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (258, '搏�', 'b�d�u', 'vật l�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (259, '����', 'bōf�ng', 'truyền, ph�t, �ưa tin', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (260, '波浪', 'bōl�ng', 's�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (262, '玻��', 'bōli', 'thủy tinh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (263, '伯母', 'b�m�', 'b�c g�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (264, '博士', 'b�sh�', 'tiến sĩ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (265, '波�:汹�R', 'bōtāoxiōngy�ng', 's�ng cu�"n tr�o d�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (266, '博�0�� ', 'b�w�guǎn', 'vi�!n bảo t�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (267, '�0��0�', 'bōxu�', 'b�c l�"t, lợi dụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (268, '��种', 'bōzh�ng', 'gieo hạt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (269, '帒', 'b�', 'vải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (270, '不', 'b�', 'kh�ng, chưa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (273, '不好��欝', 'b�hǎoy�si', 'cảm thấy xấu h�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (279, '不�', 'b�shǎo', 'kh�ng �t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (280, '不謐璦', 'b� n�if�n', 'n�ng nảy, s�t ru�"t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (281, '不�:�上�9', 'b� xiāng sh�ngxi�', 'ngang nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (282, '不咏话', 'b� xi�nghu�', 'chẳng ra l�m sao cả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (284, '不�0', 'b��"ān', 'bất an, lo lắng', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (294, '钨�� ', 'b�f�n', 'b�" phận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (321, '��', 'cā', 'lau ch�i, ch�, cọ', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (323, '�S�"', 'c�idān', 'thực �ơn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (335, '财务', 'c�iw�', 't�i vụ', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (342, '��', 'cānguān', 'tham quan', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (343, '�9��', 'c�nj�', 't�n tật', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (344, '�加', 'cānjiā', 'tham gia', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (349, '�9�""', 'c�nli�', 'c�n lại', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (357, '��劳', 'cāol�o', 'l�m vi�!c chĒm ch�0', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (275, '不�&', 'b�jǐn', 'kh�ng những, kh�ng ch�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (276, '不�&�', 'b�miǎn', 'kh�ng tr�nh �ược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (277, '不��', 'b�r�n', 'nếu kh�ng th�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (278, '不�', 'b�r�', 'kh�ng bằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (377, '差不多', 'ch�buduō', 'xấp x�0, gần gi�ng nhau', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (285, '不�&', 'b�b�', 'kh�ng cần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (286, '补�&&', 'b�chōng', 'b�" sung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (287, '不� ', 'b�d�n', 'kh�ng những', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (288, '不�不', 'b�d�b�', 'kh�ng thỒ kh�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (289, '不�� ', 'b�d�liǎo', 'cực kỳ', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (291, '不��', 'b�du�n', 'thường xuy�n, kh�ng ngừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (292, '步伐', 'b�f�', 'tiến ��", nh�9p bư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (293, '不妨', 'b�f�ng', '�ừng ngại, kh�ng sao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (379, '�x�油', 'ch�iy�u', 'dầu diesel', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (295, '不顾', 'b�g�', 'kh�ng cần biết �ến, bất cần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (296, '不管', 'b�guǎn', 'cho d�, bất luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (297, '不�!', 'b�gu�', 'nhưng, chẳng qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (298, '不禁', 'b�jīn', 'kh�ng nh�9n �ược, kh�ng n�n n�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (299, '不�&', 'b�ji�', 'b�" cứu, cứu v�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (300, '帒屬', 'b�j�', 'b� cục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (301, '不堪', 'b�kān', 'kh�ng ch�9u n�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (303, '不��', 'b�ku�', 'xứng ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (304, '钨落', 'b�lu�', 'b�" lạc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (305, '钨��', 'b�m�n', 'b�", ng�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (306, '��乳', 'b�r�', 'nu�i bằng sữa mẹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (307, '不��', 'b�sh�', '��i khi, th�0nh thoảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (308, '钨署', 'b�sh�', 'sắp xếp, b� tr�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (309, '补贴', 'b�ti�', 'tiền trợ cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (310, '钨位', 'b�w�i', 'b�" v�9, v�9 tr�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (311, '不�S', 'b�xī', 'ngần ngại, kh�ng tiếc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (312, '不�丬顾', 'b�xi� yī g�', 'kh�ng ��ng xem', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (313, '不药�R��', 'b�y�o �r y�', 'kh�ng sao ��u', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (314, '不���', 'b�y�ude', 'kh�ng �ược, ��nh phải', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (316, '帒置', 'b�zh�', 'sắp xếp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (317, '不止', 'b�zhǐ', 'kh�ng ng�:t, kh�ng dứt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (318, '步骤', 'b�zh�u', 'bư�:c �i, tr�nh tự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (319, '�"�0', 'b�zhuō', 'bắt, t�m, chụp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (320, '不足', 'b�z�', 'kh�ng �ủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (322, '�0�', 'c�i', 'm�:i (��"ng t�c di�&n ra mu�"n)', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (324, '�!!访', 'cǎifǎng', 'phỏng vấn, sĒn tin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (325, '裁缝', 'c�if�ng', 'thợ may', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (326, '财�R', 'c�if�', 'sự gi�u c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (327, '�0�干', 'c�ig�n', 'nĒng lực, t�i c�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (328, '�!!购', 'cǎig�u', 'mua, thu mua', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (329, '�0�华', 'c�ihu�', 't�i nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (331, '�!!纳', 'cǎin�', 'tiếp nhận, tiếp thu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (332, '裁�Ƥ', 'c�ip�n', 'trọng t�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (333, '彩票', 'cǎipi�o', 'v� s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (334, '�!!�', 'cǎiq�', 'lấy, �p dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (337, '财��', 'c�izh�ng', 't�i ch�nh', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (338, '�Ʊ', 'cāng', 'khoang, bu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (339, '�9��"�', 'cāngb�i', 't�i nhợt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (340, '�俒', 'cāngc�', 'v�"i v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (341, '��', 'cāngk�', 'kho', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (345, '�謒', 'cānkǎo', 'tham khảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (346, '�9�&�', 'c�nk�', 't�n kh�c, t�n bạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (347, '播��', 'c�nku�', 'xấu h�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (348, '灿�', 'c�nl�n', 's�ng lạng, rực rỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (351, '餐�&', 'cāntīng', 'ph�ng Ēn, nh� Ēn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (352, '�与', 'cāny�', 'tham dự', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (353, '��&�', 'cānzh�o', 'tham chiếu, bắt trư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (354, '�0', 'cǎo', 'cỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (355, '�0��', 'cǎo�"�n', 'bản thảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (356, '���S�', 'cāochǎng', 's�n vận ��"ng, b�i tập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (358, '��绒', 'cāoli�n', 'luy�!n tập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (359, '�0�!', 'cǎoshu�i', 'qua loa, �ại kh�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (360, '��忒', 'cāoxīn', 'bận t�m, lo lắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (361, '����', 'c�oz�', '�n �o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (362, '��纵', 'cāoz�ng', '�iều khiỒn, thao t�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (363, '���S', 'cāozu�', 'thao t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (364, '� R', 'c�', 's�", quyỒn, tập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (366, '�9�!�', 'c�li�ng', '�o lường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (367, '��"�', 'c�l��', 's�ch lược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (368, '侧面', 'c�mi�n', 'mặt b�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (369, '�', 'c�ng', 'tầng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (371, '�:�经', 'c�ngjīng', 'từng, �� từng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (372, '�"�0�', 'c�su�', 'nh� v�! sinh', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (373, '�9�R', 'c�y�n', 'kiỒm tra, trắc nghi�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (374, '�R�', 'ch�', 'tr�', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (375, '�0', 'chā', 'que, ngạnh, rẽ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (376, '差�ƫ', 'chābi�', 'kh�c nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (378, '�座', 'chāzu�', 'st�" cắm �i�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1642, '计��', 'j�hu�', 'kế hoạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (385, '产��', 'chǎnpǐn', 'sản phẩm', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (415, '缠�"', 'ch�nr�o', 'quấn, quấn quanh', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (401, '尝', 'ch�ng', 'thường thức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (430, '�0子', 'chāzi', 'c�i nĩa', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (390, '�"�', 'zhǎng', 'tĒng l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (437, '秤', 'ch�ng', 'c�i c�n', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (438, '�x��', 'ch�ngsh�', 'th�nh ph�', NULL, 29);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (381, '�9 ', 'chāi', 'th�o, gỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (382, '�9 迁', 'chāiqiān', 'di dời, giải tỏa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (383, '缠', 'ch�n', 'vư�:ng, quấn, d�y dưa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (384, '�9', 'ch�n', 'ham Ēn, tham Ēn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (452, '�Ɛ交', 'ch�ngjiāo', 'giao d�9ch', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (464, '�Ɛ天', 'ch�ngtiān', 'su�t ng�y, cả ng�y', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (388, '颤�', 'ch�nd�u', 'run rẩy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (389, '��R�::', 'chāngsh�ng', 'hưng th�9nh, hưng vượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (472, '��坐', 'ch�ngzu�', '�i, cưỡi (t�u, xe, m�y bay⬦)', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (391, '常', 'ch�ng', 'thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (392, '�S�', 'chǎng', 'nơi, b�i, cu�"c, trận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (393, '�', 'chǎng', 'xư�xng, nh� m�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (394, '�"��x�', 'ch�ngch�ng', 'Trường Th�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (395, '�"��', 'ch�ngch�', 'ưu �iỒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (396, '�"��x�', 'ch�ngduǎn', 'd�i ngắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (397, '�"��x', 'ch�ngjiāng', 'Trường Giang', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (398, '常� ', 'ch�ngsh�', 'kiến thức ph�" th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (399, '��', 'ch�ng', 'h�t', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (400, '���R', 'ch�ngg�', 'h�t', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (477, '�0欝', 'ch�nsī', 'suy ngẫm, trầm tư', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (403, '偿��', 'ch�nghu�n', 'trả nợ, b�i ho�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (404, '�"�弬', 'chǎngkāi', 'm�x r�"ng, thoải m�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (405, '�R�9', 'chāngku�ng', 'ngang ngược, �i�n cu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (406, '�S�面', 'chǎngmi�n', 't�nh cảnh', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (407, '常年', 'ch�ngni�n', 'quanh nĒm, l�u d�i, hằng nĒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (408, '尝�"', 'ch�ngsh�', 'thử', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (409, '�S��0�', 'chǎngsu�', 'nơi', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (410, '�"&鬚', 'ch�ngtōng', 'th�ng su�t, tr�i chảy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (411, '�"��', 'ch�ngt�', 'd�i, �ường d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (412, '常务', 'ch�ngw�', 'thường vụ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (413, '�"��', 'ch�ngxi�', 'b�nh chay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (387, '产业', 'chǎny�', 'sản nghi�!p, ng�nh nghề', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (416, '�"示', 'zhǎnsh�', 'tr�nh b�y, biỒu hi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (417, '�S�', 'ch�o', 'ngoảnh mặt về, hư�:ng về', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (418, '吵', 'chǎo', '�n �o, tranh c�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (419, '�', 'chǎo', 'x�o, rang', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (420, '�', 'chāo', 'copy, sao ch�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (421, '�&越', 'chāoyu�', 'vượt qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (422, '�S�代', 'ch�od�i', 'triều �ại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (423, '�&�!�', 'chāochū', 'vượt qu�, vượt l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (424, '�&级', 'chāoj�', 'si�u, si�u cấp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (425, '潮流', 'ch�oli�', 'tr�o lưu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (427, '潮湿', 'ch�oshī', 'ẩm ư�:t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (428, '�&�', 'chāosh�', 'si�u th�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (429, '诧�', 'ch�y�', 'ngạc nhi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (431, '彻�"', 'ch�dǐ', 'tri�!t �Ồ, ho�n to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (432, '车�', 'ch�k�', 'nh� �Ồ xe', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (433, '趁', 'ch�n', 'nh�n l�c, thừa d�9p', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (434, '�0淬', 'ch�ndi�n', 'kết tủa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (435, '��', 'ch�ng', '�i, cưỡi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (436, '�"', 'ch�ng', 'tr�i cam', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (440, '�0�办', 'ch�ngb�n', '�ảm �ương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (441, '�x�堡', 'ch�ngbǎo', 'l�u ��i', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (442, '�0��R&', 'ch�ngbāo', 'k� hợp ��ng, nhận thầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (443, '�Ɛ�S�', 'ch�ngb�:n', 'chi ph�, gi� th�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (444, '�0��9&', 'ch�ngdān', 'g�nh v�c, �ảm �ương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (445, '撩罚', 'ch�ngf�', 'trừng tr�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (446, '�Ɛ�� ', 'ch�ngf�n', 'th�nh phần', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (447, '�Ɛ�x', 'ch�nggōng', 'th�nh c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (448, '�Ɛ�S', 'ch�nggu�', 'th�nh quả', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (449, '称号', 'ch�ngh�o', 'tư�:c v�9, danh hi�!u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (450, '诚恳', 'ch�ngk�:n', 'ch�n th�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (451, '�Ɛ��', 'ch�ngyu�n', 'th�nh vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (453, '�Ɛ�9', 'ch�ngl�', 'th�nh lập', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (454, '�0�认', 'ch�ngr�n', 'thừa nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (456, '�Ɛ就', 'ch�ngji�', 'th�nh tựu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (457, '�Ɛ语', 'ch�ngy�', 'th�nh ngữ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (458, '称��', 'ch�nghu', 'xưng h�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (459, '�Ɛ�&�', 'ch�ngqu�n', 'ho�n th�nh, gi�p ho�n thi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (460, '�Ɛ�&', 'ch�ngqīng', 'l�m r�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (461, '诚实', 'ch�ngsh�', 'th�nh thực, thật th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (462, '�0��', 'ch�ngsh�u', 'ch�9u �ựng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (465, '�Ɛ为', 'ch�ngw�i', 'tr�x th�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (467, '��现', 'ch�ngxi�n', 'l�" ra, phơi b�y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (468, '�Ɛ�"�', 'ch�ngxi�o', 'hi�!u quả, c�ng hi�!u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (469, '称赞', 'ch�ngz�n', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (470, '�Ɛ�"�', 'ch�ngzhǎng', 'l�:n l�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (471, '诚�R�', 'ch�ngzh�', 'ch�n th�nh, th�n �i', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (473, '�"���', 'ch�nji�', 'l�i thời, cũ kỹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (474, '�"���', 'ch�nli�', 'trưng b�y', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (475, '�0��', 'ch�nm�n', 'ng�"t ngạt, nặng nề', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (476, '�0��', 'ch�nm�', 'im lặng', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (478, '�0�:', 'ch�nt�ng', '�au thương, bi th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (479, '�0�!�', 'ch�nzh�ng', 'tr�ch nhi�!m, nặng nề', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (480, '�0睬', 'ch�nzhu�', 'b�nh tĩnh, vững v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (481, '趁�S�', 'ch�njī', 'thừa cơ, nh�n d�9p', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (496, '尺子', 'chǐzi', 'thư�:c �o', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (502, '�!�复', 'ch�ngf�', 'lặp lại, tr�ng lặp', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (512, '抽�x', 'chōuyān', 'h�t thu�c', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (522, '�', 'ch�u', 'xấu x�', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (533, '�ƹ�ƶ', 'chu�nb�', 'thuyền b�', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (544, '���', 'chuāngli�n', 'r�m cửa s�"', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (534, '传��', 'chu�nbō', 'truyền b�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (555, '�Ɲ步', 'chūb�', 'sơ b�", bư�:c �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (483, '趁璭�0��', 'ch�nr� dǎti�:', 'thừa thắng x�ng l�n', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (484, '驰�9', 'ch�ch�:ng', 'phi nư�:c �ại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (485, '�x�ư', 'ch�d�o', '�ến mu�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (486, '赤�', 'ch�d�o', 'x�ch �ạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (487, '�x�', 'ch�huǎn', 'tr� tr�!, chậm chạp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (489, '�R��&', 'ch�ji�', 'k�o d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (490, '吒�9�', 'chīk�', 'ch�9u kh�", ch�9u thi�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (491, '吒亏', 'chīkuī', 'ch�9u thi�!t, b�9 thi�!t hại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (492, '吒�:', 'chīl�', 'm�!t nhọc, t�n sức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (493, '池��', 'ch�t�ng', 'h�, ao, �ầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (494, '�R�续', 'ch�x�', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (495, '赤�', 'ch�z�', 'th�m hụt, b�"i chi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (498, '� �动', 'chōngd�ng', 'xung ��"ng, k�ch th�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (499, '�&&�', 'chōngdāng', '�ảm nhận, giữ chức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (500, '�&&���"�', 'chōngdi�nq�', 'b�" sạc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (501, '�&&足', 'chōngz�', '�ầy �ủ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (503, '�!��', 'ch�nggāo', 'cao cả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (504, '�!�"�', 'ch�ngj�ng', 't�n k�nh, k�nh trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (505, '�!�9S', 'ch�ngb�i', 's�ng b�i, t�n thờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (506, '�!�叠', 'ch�ngdi�', 'ch�ng ch�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (508, '宠�0�', 'ch�ngw�', 'th� cưng, vật nu�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (509, '宠�Ʊ', 'ch�ng�"�i', 'y�u thương, cưng chiều', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (510, '抽�0', 'chōuti', 'ngĒn k�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (511, '抽象', 'chōuxi�ng', 'trừu tượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (513, '抽�', 'chōujiǎng', 'r�t thĒm tr�ng thư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (514, '�!�', 'ch�u', 'h�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (515, '�!��0�', 'chūbǎn', 'xuất bản', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (516, '�!�差', 'chūchāi', 'c�ng t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (517, '�!��', 'chūfā', 'xuất ph�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (519, '�!�口', 'chūk�u', 'l�i ra / xuất khẩu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (520, '�!�类�9萒', 'chūl�i b�cu�', 'xuất ch�ng, ưu t�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (521, '�!��0�', 'chūs�', 'xuất sắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (523, '筹�!', 'ch�ub�i', 'chuẩn b�9, tr� b�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (524, '�R�!', 'ch�uch�', 'do dự, trĒn trừ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (525, '�恶', 'ch�u�"�', 'xấu x�, �c ��"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (527, '稠� ', 'ch�um�', 'd�y �ặc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (528, '�"�', 'ch�', 'trừ bỏ, ph�p chia', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (529, '�!�', 'chū', 'ra, xuất, �ến', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (530, '�ƹ', 'chu�n', 'thuyền, t�u', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (531, '串', 'chu�n', 'chu�i, x�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (532, '穿睬', 'chuānzhu�', 'mặc, ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (536, '传�"', 'chu�ndān', 'tờ rơi, truyền �ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (537, '传�', 'chu�nd�', 'truyền, chuyỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (538, '�ƹ�Ʊ', 'chu�ncāng', 'khoang t�u, boong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (539, '��', 'chuǎng', 'x�ng, ��m b�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (540, '��:�S', 'chu�ngzu�', 's�ng t�c', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (542, '��Ʒ', 'chuānghu', 'cửa s�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (543, '��:�9', 'chu�ngl�', 'th�nh lập, s�ng lập', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (545, '��:��', 'chu�ngxīn', 'cải tiến, ��"i m�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (546, '��:业', 'chu�ngy�', 'lập nghi�!p, kh�xi nghi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (548, '穿越', 'chuānyu�', 'vượt qua, vượt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (549, '传�x', 'chu�nrǎn', 'truyền nhi�&m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (550, '传��', 'chu�nsh�u', 'truyền dạy, truyền thụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (552, '传�x', 'chu�nt�ng', 'truyền th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (553, '传�Sx', 'chu�nzh�n', 'fax', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (554, '���!', 'ch�b�i', 'dự trữ, �Ồ d�nh', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (556, '����', 'ch�c�n', 'dự trữ, �Ồ d�nh', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (557, '触犯', 'ch�f�n', 'x�c phạm, x�m phạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (558, '厨�ƿ', 'ch�f�ng', 'bếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (559, '�"�非', 'ch�f�i', 'trừ phi', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (560, '�罚', 'ch�f�', 'trừng phạt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (561, '��', 'chu�', 'c�i b�a', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (562, '吹', 'chuī', 'th�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (563, '吹�0:', 'chuīni�', 'kho�c l�c, th�"i ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (564, '吹捧', 'chuīp�:ng', 't�ng b�c, ca tụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (565, '��:�', 'chu�zh�', 'vu�ng g�c, thẳng �ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (566, '�Ɲ级', 'chūj�', 'sơ cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (568, '�"�� ', 'ch�le', 'ngo�i ra, trừ ra', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (569, '�� ', 'ch�lǐ', 'xử l�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (570, '�!�路', 'chūl�', 'l�i tho�t, �ường ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (571, '�!��', 'chūm�i', 'b�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (572, '�ܥ', 'chūn', 'm�a xu�n', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (573, '纯粹', 'ch�ncu�', 'tinh khiết, thuần khiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (574, '纯洁', 'ch�nji�', 'thuần khiết, trong sạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (575, '�!�神', 'chūsh�n', 'xuất thần, say sưa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (576, '�!�身', 'chūsh�n', 'xuất th�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (577, '�!��x', 'chūsh�ng', 'sinh ra, ra �ời', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (578, '�"��"', 'ch�xī', '��m giao thừa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (580, '�!�席', 'chūx�', 'dự họp, c� mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (581, '�!�现', 'chūxi�n', 'xuất hi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (582, '���', 'ch�x�', 'dự trữ, d�nh dụm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (583, '�!��9�:�', 'chūy�ngxi�ng', 'xấu mặt, l�m tr� cười cho thi�n hạ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (584, '�置', 'ch�zh�', 'xử l�, xử tr�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1473, '蒡子', 'h�zi', 'r�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (590, '磁带', 'c�d�i', 'bĒng từ', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (616, '俒�:', 'c�shǐ', 'th�c �ẩy, gi�p gi�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (593, '�ƺ濬', 'c�jī', 'k�ch th�ch', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (629, '�0篮琒', 'dǎ l�nqi�', 'chơi b�ng r�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (633, '�0�0�', 'dǎb�n', 'trang �iỒm, Ēn vận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (652, '代价', 'd�iji�', 'gi� phải trả, chi ph�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (654, '代� ', 'd�ilǐ', '�ại l�', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (655, '带� ', 'd�ilǐng', 'dẫn dắt', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (672, '�R�', 'dǎng', 'ngĒn chặn, ngĒn cản', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (678, '��Ɲ', 'dāngchū', 'l�c �ầu, h�i ��', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (587, '次', 'c�', 'lần', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (589, '次要', 'c� y�o', 'thứ yếu, kh�ng quan trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2676, '深', 'sh�n', 's�u, �ậm', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (591, '词�&�', 'c�diǎn', 'từ �iỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (592, '词�!', 'c�hu�', 'từ vựng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (594, '此�', 'cǐw�i', 'ngo�i ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (595, '�&�祥', 'c�xi�ng', 'hiền từ, hiền hậu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (596, '次序', 'c�x�', 'trật tự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (598, '�:', 'c�ng', 'bụi, l�m, kh�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (599, '从', 'c�ng', 'theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (600, '从此', 'c�ngcǐ', 'từ ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (601, '从�R', 'c�ng�"�r', 'do ��, v� vậy', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (602, '从来', 'c�ngl�i', 'từ trư�:c t�:i nay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (603, '从容', 'c�ngr�ng', '�iềm tĩnh, thong thả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (604, '聪�܎', 'cōngm�ng', 'th�ng minh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (606, '从�9', 'c�ngsh�', 'l�m, tham gia', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (607, '从�S�', 'c�ngw�i', 'chưa từng, chưa bao giờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (608, '从小', 'c�ngxiǎo', 'từ nhỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (609, '从容不迫', 'c�ngr�ngb�p�', 'chậm r�i, kh�ng v�"i v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (610, '�!��', 'c�uhe', 'tập hợp, gom g�p, qu�y quần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (611, '� 9', 'c�', 'giấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (612, '�S', 'cu�n', 'lủi, chu�n, chạy to�n loạn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (613, '��', 'cuī', 'th�c giục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (614, '���9', 'cuīc�n', 'ph� hủy, t�n ph�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (615, '� 弱', 'cu�ru�', 'mỏng manh, yếu �u�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (617, '��', 'c�n', 't�n tại, bảo t�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (618, '���S�', 'c�nz�i', 't�n tại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (619, '��', 'cuō', 'xoay, xoắn, vặn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (621, '措��', 'cu�shī', 'bi�!n ph�p', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (622, '�"误', 'cu�w�', 'sai, sai lầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (623, '�R���', 'cu�zh�', 'sự thất bại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (624, '�忒', 'cūxīn', 'sơ �, cẩu thả, bất cẩn', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (625, '大', 'd�', 'to, l�:n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (626, '�0', 'dǎ', '��nh, m�t, �ập, ph�c, kho�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (627, '�0��话', 'dǎ di�nhu�', 'gọi �i�!n thoại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (628, '�0��司', 'dǎ guānsi', 'ki�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (630, '�0��嚏', 'dǎ p�nt�', 'hắt x� hơi, nhảy mũi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (631, '大象', 'd� xi�ng', 'voi, con voi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (632, '���', 'd��"�n', '��p �n', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (634, '�0�R&', 'dǎbāo', '��ng g�i, g�i lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (635, '�0���', 'dǎbǐfāng', 'lấy v� dụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (637, '�0败', 'dǎb�i', '��nh bại', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (638, '大�!�', 'd�ch�n', '�ại thần', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (639, '达�Ɛ', 'd�ch�ng', '�ạt �ến, �ạt �ược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (640, '搭档', 'dād�ng', 'người hợp t�c, c�"ng t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (641, '达�ư', 'd�d�o', '�ến, �ạt �ược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (642, '大��', 'd�fāng', 'h�o ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (643, '大夫', 'd�ifu', 'b�c sĩ', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (644, '大�', 'd�g�i', 'khoảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (645, '�0工', 'dǎgōng', 'l�m c�ng, l�m thu�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (646, '大�"��', 'd�hu�r', 'mọi người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (647, '带', 'd�i', '�em, mang', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (648, '�ƴ', 'd�i', '�eo, mang, ��"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (649, '� ', 'dāi', 'ng�c, ngẩn ngơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (651, '鬮�"', 'd�ib�', 'bắt giữ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (653, '贷款', 'd�ikuǎn', 'cho vay, vay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (656, '�&�!', 'd�iy�', '��i ng�", ��i xử, lạnh nhạt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (657, '代�:�', 'd�it�', 'thay thế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (658, '�0�!�', 'dǎj�', 'g�,�ập,��nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (659, '�0交�', 'dǎjiāod�o', 'giao tiếp, tiếp x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (660, '�0�!�', 'dǎli�ng', 'quan s�t, nh�n ��nh gi�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (661, '�0�R�', 'dǎli�', 'sĒn bắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (662, '�:9�"�质', 'd�nb�izh�', 'protein', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (663, '�9&保', 'dānbǎo', '�ảm bảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (665, '�"谒', 'dāndi�o', '�ơn �i�!u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (666, '�"�9�', 'dānd�', '�ơn ��"c, m�"t m�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (667, '�"位', 'dānw�i', 'b�i mục, �ơn v�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (668, '�9&任', 'dānr�n', '�ảm nhi�!m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (669, '�"�&�', 'dānyu�n', 'b�i học, �ơn nguy�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (670, '诞辰', 'd�nch�n', 'ng�y sinh nhật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (671, '�&�', 'dǎng', '�ảng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (673, '�', 'dāng', 'l�m, �ảm nhi�!m, khi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (675, '档��', 'd�ng�"�n', 'h� sơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (676, '�:9�"', 'd�ngāo', 'b�nh ga-t�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (677, '��S�', 'dāngchǎng', 'tại ch�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (679, '档次', 'd�ngc�', '�ẳng cấp, cấp bậc', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (680, '�代', 'dāngd�i', 'ng�y nay, �ương �ại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (681, '�面', 'dāngmi�n', 'trư�:c mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (682, '��0�', 'dāngqi�n', 'hi�!n tại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (683, '���', 'dāngr�n', '�ương nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (685, '��9人', 'dāngsh�r�n', 'người c� li�n quan, �ương sự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (686, '�务�9欥', 'dāngw�zhīj�', 'vi�!c khẩn cấp trư�:c mắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (687, '�忒', 'dāngxīn', 'cẩn thận, coi chừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (694, '淡��', 'd�nw�ng', 'l�ng qu�n', NULL, 29);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (695, '� 小鬼', 'dǎnxiǎoguǐ', 'kẻ nh�t gan', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (720, '�0�0�', 'dǎsǎo', 'qu�t, qu�t dọn', NULL, 39);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (727, '�0印', 'dǎy�n', 'in ấn', NULL, 39);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (732, '�0��', 'dǎzh�', 'chiết khấu, giảm gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (741, '灯', 'd�ng', '��n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (762, '��', 'diǎn', '�iỒm, giờ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (689, '淡季', 'd�nj�', 'tr�i m�a, mua ế h�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (691, '诞�x', 'd�nsh�ng', 'ra �ời, sinh ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (692, '� �ܯ', 'd�nsh�', 'nhưng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (693, '淡水', 'd�nshuǐ', 'nư�:c ngọt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (696, '�9&忒', 'dānxīn', 'lo lắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (697, '�', 'dǎo', '��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (698, '�ư', 'd�o', '�ến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (699, '�:', 'dǎo', '�ảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (700, '�Ƭ', 'dāo', '�ao, dao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (701, '���', 'dǎob�', 'sập ti�!m, ��ng cửa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (702, '�ư�', 'd�och�', 'khắp nơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (704, '导弹', 'dǎod�n', 'hỏa ti�&n, �ạn �ạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (705, '�德', 'd�od�', '�ạo �ức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (706, '�ư�"', 'd�odǐ', '�ến c�ng, r�t cu�"c, suy cho c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (707, '稻谷', 'd�og�', 'l�a', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (708, '导�ƪ', 'dǎoh�ng', 'dẫn �ường, hư�:ng dẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (709, '�� ', 'd�olǐ', '�ạo l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (710, '捣乱', 'dǎolu�n', 'ph� ��m, quấy r�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (711, '��S0', 'dǎom�i', 'xui xẻo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (713, '�:窒', 'd�oqi�', 'tr�"m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (714, '导�', 'dǎoxi�ng', 'hư�:ng dẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (715, '导�', 'dǎoyǎn', '�ạo di�&n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (716, '导游', 'dǎoy�u', 'hư�:ng dẫn vi�n du l�9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (717, '�:屿', 'dǎoy�', 'quần �ảo', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (718, '导�!�', 'dǎozh�', 'dẫn �ến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (719, '�0�', 'dǎsu�n', 'nh�9n chung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (721, '大厦', 'd�sh�', 't�a nh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (722, '大使� ', 'd�shǐguǎn', '�ại sứ qu�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (724, '大�', 'd�tǐ', 'thĒm d�, nghe ng�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (725, '大�&�', 'd�xīng', 'quy m� l�:n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (726, '大��', 'd�y�', 'kh�ng cẩn thận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (728, '��', 'dāying', '��ng �, bằng l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (729, '大约', 'd�yu�', 'khoảng, ư�:c chừng, chắc l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (730, '�0�', 'dǎzh�ng', '��nh nhau, ��nh trận', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (731, '�0�9:��', 'dǎzhāohu', 'ch�o hỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (733, '�0��', 'dǎzh�n', 'ti�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (734, '大�!�', 'd�zh�', 'khoảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (735, '�S�', 'de', 'trợ từ kết cấu', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (736, '�', 'de', 'của', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (737, '�', 'd�', '�ược, mắc (b�!nh)', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (739, '��:', 'd�l�', '�ược lợi', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (740, '瞪', 'd�ng', 'nh�n chằm chằm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (742, '�0', 'd�:ng', 'chờ, �ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (743, '�"�', 'd�ng', '�ạp, giẫm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (744, '�"��S��0R', 'd�ngjīp�i', 'thẻ l�n m�y bay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (745, '�"��"', 'd�ngl�', '�Ēng nhập', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (746, '�0�&', 'd�:ngd�i', '�ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (747, '�0�"', 'd�:ngh�u', '�ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (748, '�0级', 'd�:ngj�', 'cấp bậc, �ẳng cấp', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (749, '�"�记', 'd�ngj�', '�Ēng k�', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (750, '灯笼', 'd�ngl�ng', '��n l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (751, '�"��" ', 'd�ngl�', 'b�", l�n bờ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (752, '�0于', 'd�:ngy�', 'bằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (754, '���', 'd�y�', '�ắc �', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (755, '�罪', 'd�zu�', '�ắc t�"i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (756, '�', 'd�', 'truyền �ạt, chuyỒn giao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (757, '�"', 'dǐ', '��y, �ế, cu�i, nền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (758, '低', 'dī', 'thấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (759, '滴', 'dī', 'nhỏ giọt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (760, '第丬', 'd� yī', 'thứ nhất', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (761, '垫', 'di�n', '��!m, c�i l�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (763, '颠簸', 'diānb�', 'lắc lư, tr�ng tr�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (764, '��池', 'di�nch�', 'pin, ắc quy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (765, '颠�', 'diāndǎo', 'lật ngược, �ảo l�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (767, '撦记', 'di�nj�', 'nghĩ �ến, nh�: �ến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (768, '���:', 'di�nl�', 'ngh�9 lực', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (769, '���', 'di�nnǎo', 'm�y vi t�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (770, '��� ', 'di�nsh�', 'truyền h�nh, ti-vi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (771, '��台', 'di�nt�i', 'trạm ph�t s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (772, '��梯', 'di�ntī', 'thang m�y', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (774, '��信', 'di�nx�n', 'trang mi�!ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (775, '��影', 'di�nyǐng', 'phim', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (776, '�&�礼', 'diǎnlǐ', '�iỒn h�nh, nghi l�&', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (777, '��源', 'di�nyu�n', 'ngu�n �i�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (778, '��子��件', 'di�nzǐ y�uji�n', 'e-mail', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (779, '吊', 'di�o', 'treo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (780, '�0', 'di�o', 'rơi, mất, giảm, hạ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (781, '�', 'di�o', 'c�u c�', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (782, '�:"', 'diāo', 'ngắm, thả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (784, '谒动', 'di�od�ng', '�iều ��"ng, ��"i, thay ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (785, '�:"�ƻ', 'diāok�', '�i�u khắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (786, '�:"�', 'diāos�', '�i�u khắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (787, '�R�', 'di�dǎo', 'ng�, ��", t�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (788, '叠', 'di�', 'gấp, ch�ng, xếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (789, '�S�步', 'd�b�', 'mức, bư�:c', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (790, '�S��', 'd�dao', '��9a �ạo', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (791, '�S���', 'd�diǎn', '��9a �iỒm', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (792, '�x�x', 'd�di', 'em trai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (793, '�R', 'di�', 'ng�, t�, rơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1643, '�R讳', 'j�hu�', 'ki�ng kỵ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (814, '� �', 'dōng', 'm�a ��ng, ��ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (877, '顿', 'd�n', 't�n', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (797, '�:�', 'dīng', 'nh�n chĒm chĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (817, '动���0!', 'd�nghu� pi�n', 'phim hoạt h�nh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (825, '动�09', 'd�ngsh�u', 'bắt �ầu l�m, bắt tay v�o l�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (837, '读', 'd�', '�ọc', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (841, '端���', 'duānw� ji�', 'Tết Đoan Ngọ', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (855, '对话', 'du�hu�', '��i thoại', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (874, '对�&�', 'du�zh�o', 'so s�nh, ��i chiếu', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (876, '�9��9', 'd�l�', '��"c lập', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (882, '躲��', 'du�c�ng', 'tr�n tr�nh, ẩn n�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (798, '定�Sx', 'd�ngqī', 'theo kỳ hạn, ��9nh kỳ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (799, '定�0', 'd�ngy�', '��9nh nghĩa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (800, '叮�ܱ', 'dīngzh�', 'cĒn dặn, dặn d�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (801, '�S�琒', 'd�qi�', 'tr�i �ất, ��9a cầu', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (802, '�S��R�', 'd�qū', 'v�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (804, '�"R人', 'd�r�n', 'kẻ th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (805, '�"R� ', 'd�sh�', 'cĒm th�, coi như kẻ th�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (806, '�S�势', 'd�sh�', '��9a thế', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (807, '�S���', 'd�ti�:', 'xe �i�!n ngầm', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (808, '�S��:�', 'd�t�', 'bản ��', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (809, '�S�位', 'd�w�i', '��9a v�9', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (810, '�S��S!', 'd�zh�n', '��"ng �ất', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (811, '�S�质', 'd�zh�', '��9a chất', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (813, '�S', 'dōng', 'ph�a ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (815, '动荡', 'd�ngd�ng', 'bấp b�nh, r�i ren, h�n loạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (816, '�S�主', 'dōngd�ozh�', 'chủ nh�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (818, '动�S�', 'd�ngjī', '��"ng cơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (819, '� ��', 'd�ngji�', '��ng lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (820, '动�"', 'd�ngj�ng', '��"ng tĩnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (821, '动�:', 'd�ngl�', '��"ng lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (822, '动�0', 'd�ngm�i', '��"ng mạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (823, '动身', 'd�ngsh�n', 'kh�xi h�nh, l�n �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (826, '动欁', 'd�ngt�i', '��"ng th�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (827, '动�0�', 'd�ngw�', '��"ng vật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (828, '�S西', 'dōngxi', '��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (829, '洞穴', 'd�ngxu�', 'hang ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (830, '动��', 'd�ngyu�n', 'huy ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (831, '�S张西�S:', 'dōngzhāngxīw�ng', 'nh�n ��ng nh�n t�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (832, '动�S', 'd�ngzu�', '��"ng t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (833, '�', 'd�u', 'chọc tức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (834, '� �&�', 'd�ufu', '�ậu phụ', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (835, '�"�峭', 'd�uqi�o', 'd�c �ứng, d�c ngược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (836, '��0', 'd�uzh�ng', '�ấu tranh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (838, '��', 'du�n', '�ứt, �oạn tuy�!t, chặt, cai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (839, '段', 'du�n', '�oạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (840, '端', 'duān', '�ầu, �ầu m�t', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (842, '��定', 'du�nd�ng', 'kết luận, nhận ��9nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (844, '�x�', 'duǎn', 'ngắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (845, '�x�俒', 'duǎnc�', 'ngắn ngủi, v�"i v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (846, '�x��Sx', 'duǎnqī', 'ngắn hạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (847, '�x��', 'duǎnz�n', 'ngắn ngủi, tho�ng qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (848, '� ', 'duī', 't�i, tụ, ch�ng chất, ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (849, '� 积', 'duījī', 't�ch tụ, chất ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (850, '��x', 'du�', '��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (851, '对', 'du�', '��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (852, '对�', 'du�bǐ', 'so s�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (853, '对�&', 'du�d�i', '��i xử, ��i ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (856, '����续续', 'du�ndu�nx�x�', 'gi�n �oạn, kh�ng li�n tục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (857, '����', 'du�nli�n', 'tập luy�!n, r�n luy�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (858, '端信', 'duānx�n', 'tin nhắn', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (859, '端正', 'duānzh�ng', '�oan ch�nh, �ều �ặn, ngay ngắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (860, '�R博', 'd�b�', 'cờ bạc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (861, '�9�裁', 'd�c�i', '��"c t�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (862, '督俒', 'dūc�', 'th�c giục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (863, '渡�!', 'd�gu�', 'xuy�n qua, trải qua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (865, '对不起', 'du�buqǐ', 'xin l�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (866, '对�', 'du�c�', 'bi�!n ph�p ��i ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (867, '对称', 'du�ch�n', 't�nh c�n xứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (868, '�&换', 'du�hu�n', 'trao ��"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (870, '对�9', 'du�l�', '��i lập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (871, '对�', 'du�li�n', '��i li�&n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (872, '对�', 'du�y�ng', '��i ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (873, '对于', 'du�y�', 'về, ��i v�:i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (875, '�9�绝', 'd�ju�', 'ti�u ��"c, ngĒn chặn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (878, '�:�', 'd�n', 'ng�i x�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (880, '�S�', 'du�', 'b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (881, '多', 'duō', 'nhiều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (883, '多亏', 'duōkuī', 'may mắn, may m�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (884, '�"落', 'du�lu�', 'sa ng�, trụy lạc', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (885, '多��', 'duōme', 'bao nhi�u, biết bao', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (886, '� ��', 'duōsuo', 'lạnh c�ng, run cầm cập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (887, '多�"', 'duōy�', 'dư, dư thừa', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (888, '多�&��R', 'duōyu�n hu�', '�a dạng h�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (889, '���', 'd�pǐn', 'thu�c phi�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (890, '�ܻ塞', 'dūs�', 'tắc nghẽn, ngĒn chặn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (891, '钽�', 'dūsh�', '�� th�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (893, '��子', 'd�zi', 'bụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (894, '饿', '�', '��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (895, '讹', '�', 'chuyỒn biến xấu, thay ��"i xấu �i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (897, '恶', '�', 'ừ, hừ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (898, '欨恨', 'yu�nh�n', 'o�n hận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (899, '�R', '�r', 'v�, m�, nhưng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (901, '��童', '�rt�ng', 'nhi ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3571, '岩�x�', 'y�nsh�', '��', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (908, '�表', 'fābiǎo', 'ph�t biỒu, tuy�n b�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (912, '�达', 'fād�', 'ph�t triỒn, ph�n vinh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (925, '反复', 'fǎnf�', 'lặp �i lặp lại', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (922, '翻', 'fān', 'xoay, lật, tr�x m�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (935, '反��', 'fǎnw�n', 'hỏi lại', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (910, '�财', 'fāc�i', 'ph�t t�i, l�m gi�u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (927, '反面', 'fǎnmi�n', 'phản di�!n, mặt tr�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (954, '饭� ', 'f�nguǎn', 'qu�n cơm', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (956, '访��', 'fǎnw�n', 'hỏi lại, h�i vấn lại', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (980, '�"', 'fǎ', 'thỒ', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (902, '�R氧�R碳', '�ryǎnghu�t�n', 'CO�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (903, '�R已', '�ryǐ', 'm� th�i, thế th�i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (904, '��子', '�rzi', 'con trai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (905, '额�', '�w�i', 'ngo�i ��9nh mức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (907, '�', 'fā', 'ph�t, gửi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (916, '��R�', 'fāhuī', 'ph�t huy', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (909, '�帒', 'fāb�', 'tuy�n b�, ph�t h�nh, th�ng b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (911, '���', 'fāch�u', 'lo lắng, bu�n phiền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (913, '�� ', 'fādāi', 'ngẩn người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (914, '�动', 'fād�ng', 'ph�t ��"ng, bắt �ầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (915, '��', 'fād�u', 'run rẩy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (918, '��0', 'fāju�', 'ph�t hi�!n, ph�t gi�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (919, '�款', 'fākuǎn', 'ph�t tiền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (920, '�"�9', 'fǎl�S', 'ph�p luật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (921, '��܎', 'fām�ng', 'ph�t minh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (924, '反常', 'fǎnch�ng', 'd�9 thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (926, '反�', 'fǎnk�ng', 'phản kh�ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (928, '反�', 'fǎny�ng', 'phản ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (929, '反�ܠ', 'fǎny�ng', 'phản �nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (930, '反对', 'fǎndu�', 'phản ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (931, '反转', 'fǎnzhuǎn', 'tr�i lại, ngược lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (932, '反欝', 'fǎnsī', 'suy ngẫm, phản t�0nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (933, '反�', 'fǎnsh�', 'phản xạ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (934, '反��', 'fǎnku�', 'phản h�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (936, '��', 'f�ng', 'tha, thả', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (938, '����!', 'f�ng sh�ji�', 'ngh�0 h�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (939, '妨碍', 'f�ng''�i', 'g�y tr�x ngại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (940, '反�x', 'fǎngǎn', '�c cảm, bất m�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (941, '����', 'fāng�"�n', 'kế hoạch, phương �n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (943, '�ƿ�S', 'f�ngdōng', 'chủ nh�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (944, '���"', 'fāngfǎ', 'phương ph�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (945, '仿�:', 'fǎngf�', 'h�nh như, dường như', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (946, '�ƿ��', 'f�ngjiān', 'ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (947, '��面', 'fāngmi�n', 'phương di�!n, mặt, ph�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (948, '��弒', 'f�ngq�', 'vứt bỏ, từ bỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (949, '���', 'f�ngsh�', 'ph�ng xạ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (950, '��式', 'fāngsh�', 'phương thức, c�ch thức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (951, '�ܲ��', 'f�ngsh�u', 'ph�ng thủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (952, '���09', 'f�ngsh�u', 'bu�ng tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (953, '��松', 'f�ngsōng', 'thả lỏng, thư gi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (955, '���', 'fāngxi�ng', 'phương hư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (958, '��訬', 'fāngy�n', 'tiếng ��9a phương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (959, '�ܲ��', 'f�ngy�', 'ph�ng d�9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (960, '�ƿ�9', 'f�ngwū', 'ph�ng �x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (961, '����', 'fāngzh�n', 'phương ch�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (962, '�ܲ治', 'f�ngzh�', 'ph�ng ch�ng, ph�ng v� chữa tr�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (963, '纺�!', 'fǎngzhī', 'd�!t vải', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (964, '繁华', 'f�nhu�', 'ph�n hoa, sầm uất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (965, '�:滥', 'f�nl�n', 'tr�n lan', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (966, '贩�', 'f�nm�i', 'bu�n b�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (967, '繁�"', 'f�nm�ng', 'bận r�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (969, '繁荣', 'f�nr�ng', 'ph�n vinh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (970, '�!��ܯ', 'f�nsh�', 'ph�m l�, h�& l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (971, '繁��', 'f�ntǐz�', 'chữ ph�n thỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (972, '�R��:�', 'f�nw�i', 'phạm vi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (973, '翻�', 'fāny�', 'phi�n d�9ch, d�9ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (974, '反正', 'fǎnzh�ng', 'd� sao cũng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (975, '反�9', 'fǎnzhī', 'tr�i lại, ngược lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (976, '�票', 'fāpi�o', 'h�a �ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (977, '�"人', 'fǎr�n', 'ph�p nh�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (978, '�璧', 'fāshāo', 'ph�t s�t, s�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (979, '��x', 'fāsh�ng', 'xảy ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (982, '��0�', 'fāy�ng', 'n�u cao, ph�t huy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (983, '���', 'fāy�', 'trư�xng th�nh, dậy th�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (984, '�"�"�', 'fǎyu�n', 't�a �n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (985, '��R', 'fāx�ng', 'ph�t h�nh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (986, '�现', 'fāxi�n', 'ph�t hi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (987, '���', 'fāf�ng', 'ph�t �i�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (988, '��"', 'fāzhǎn', 'ph�t triỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (989, '��', 'f�i', 'ph�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (990, '非', 'f�i', 'kh�ng, phi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (992, '非常', 'f�ich�ng', 'rất, �ặc bi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (993, '�x�"�', 'f�ich�', 'b�i bỏ, huỷ bỏ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (994, '非�"', 'f�ifǎ', 'bất hợp ph�p, phi ph�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (995, '费��', 'f�iy�ng', 'chi ph�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (996, '飞�S�', 'f�ijī', 'm�y bay', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (998, '沸�&�', 'f�it�ng', 's�i s�ng sục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (999, '�R��', 'f�:it�', 'kẻ cư�:p, �ạo tặc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1000, '��沒', 'f�iw�', 'ph� nhi�u, m�u mỡ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1001, '飞�', 'f�ixi�ng', 'bay lượn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1002, '�x�x', 'f�ixū', '��ng hoang, ��ng ��" n�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1003, '飞跒', 'f�iyu�', 'nhảy vọt, vượt bậc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1004, '���', 'f�iz�o', 'x� b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1007, '�� 帒', 'f�nb�', 'ph�n b�, ph�n ph�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1018, '风暴', 'f�ngb�o', 'b�o t�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1048, '杠� ', 'g�nggǎn', '��n bẩy', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1083, '��謒', 'gāokǎo', 'th� v�o trường �ại học', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1021, '丰��', 'f�ngshōu', '�ược m�a', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1030, '�� �&�', 'f�np�i', 'ph�n ph�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1032, '�0碎', 'f�:nsu�', 'vỡ n�t, vỡ tan t�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1035, '���&�', 'f�nkǎi', 'bất b�nh, phẫn n�", n�"i c�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1038, '�� �܎', 'f�nm�ng', 'r� r�ng, ph�n minh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1011, '���', 'f�nn�', 'cĒm phẫn, tức giận', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1046, '尴尬', 'gāng�', 'kh� xử, l�ng t�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1008, '�� 寸', 'f�nc�n', 'chừng mực, c� chừng mực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1009, '�� �9&', 'f�ndān', 'ph�n �ầu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1010, '�9�', 'f�nd�u', 'c� gắng, d�n dập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1090, '个', 'g�', 'c�i', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1013, '丰�R', 'f�ngf�', 'phong ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1014, '风�"�', 'f�ngjǐng', 'phong cảnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1015, '风度', 'f�ngd�', 'phong ��", phong c�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1016, '风�&0', 'f�ngguāng', 'phong cảnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1017, '封建', 'f�ngji�n', 'phong kiến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1092, '�0�', 'g�', 'cắt, gặt', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1019, '风�', 'f�ngs�', 'phong tục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1020, '���9', 'f�ngku�ng', '�i�n cu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1097, '�"�ܩ', 'g�da', 'mụn, mụn c�m', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1023, '风�', 'f�ngq�', 'bầu kh�ng kh�, nếp s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1024, '风趣', 'f�ngq�', 'th� v�9, d� dỏm', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1025, '封��', 'f�ngsu�', 'phong toả, bao v�y, chặn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1026, '风�Sx人�&', 'f�ngt� r�nq�ng', 'phong th�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1027, '风��', 'f�ngw�i', 'hương v�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1028, '�0�R�', 'f�ngxi�n', 'hiến d�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1029, '风�"�', 'f�ngxiǎn', 'rủi ro', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1099, '�R', 'g�', 'b�i h�t', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1031, '�� 歧', 'f�nq�', 'kh�c bi�!t, m�u thuẫn, bất ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1100, '革��', 'g�m�ng', 'c�ch mạng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1033, '�0�S�', 'f�:nm�', 'bụi, b�"t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1034, '�0�', 'f�:nbǐ', 'phấn viết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1101, '根', 'g�n', 'ngu�n g�c, r�& c�y', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1036, '�� �', 'f�nli�', 'ph�n t�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1039, '�� �09', 'f�nsh�u', 'chia tay, ly bi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1040, '纷纷', 'f�nf�n', 'tấp nập, d�n dập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1041, '�"�', 'gǎn', 'd�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1042, '干活��', 'g�n hu� er', 'l�m vi�!c, lao ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1043, '干杯', 'gānb�i', 'cạn ly', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1044, '干� ', 'gāncu�', 'dứt kho�t, thẳng thắn, th�nh thật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1045, '�x动', 'gǎnd�ng', 'cảm ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1047, '�ƚ', 'gāng', 'vừa, vừa m�:i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1049, '�ƚ�ƚ', 'gānggāng', 'vừa m�:i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1050, '�ƚ强', 'gāngqi�ng', 'cương linh, ch�nh cương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1051, '港口', 'gǎngk�u', 'hải cảng', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1052, '纲� ', 'gānglǐng', 'cương lĩnh, ch�nh cương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1053, '����', 'gāngti�:', 'sắt th�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1054, '�', 'gǎng', 'cảng, bến cảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1056, '干��', 'gānh�n', 'kh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1057, '�x濬', 'gǎnjī', 'cảm k�ch, biết ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1058, '赶紧', 'gǎnjǐn', 'v�"i v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1059, '干劲', 'g�nj�n', 'l�ng hĒng h�i, tinh thần hĒng h�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1060, '干�!�', 'gānj�ng', 'sạch sẽ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1061, '�x�0', 'gǎnju�', 'cảm thấy, thấy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1062, '�x�&�', 'gǎnkǎi', 'x�c ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1063, '赶快', 'gǎnku�i', 'nhanh, mau l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1064, '�x� ', 'gǎnm�o', 'b�9 cảm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1065, '�x�&', 'gǎnq�ng', 't�nh cảm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1066, '�x�x', 'gǎnrǎn', 'l�y, b�9 nhi�&m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1067, '干�0�', 'gānrǎo', 'can thi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1069, '�x�', 'gǎnsh�u', 'cảm nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1070, '�x撳', 'gǎnxiǎng', 'cảm tư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1071, '�x谢', 'gǎnxi�', 'cảm tạ, b�y tỏ l�ng cảm ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1072, '干�', 'gāny�', 'tham dự, tham gia, can dự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1073, '搞', 'gǎo', 'l�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1074, '��', 'gāo', 'cao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1075, '���ƫ', 'g�obi�', 'từ bi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1076, '��潮', 'gāoch�o', 'cao tr�o, ��0nh �iỒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1078, '��级', 'gāoj�', 'cao cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1079, '��档', 'gāod�ng', 'cao cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1080, '��峰', 'gāof�ng', '��0nh cao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1081, '稿件', 'gǎoji�n', 'b�i viết, b�i v�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1082, '��诫', 'g�oji�', 'khuy�n bảo, khuy�n rĒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1084, '���܎', 'gāom�ng', 'th�ng minh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1085, '��尚', 'gāosh�ng', 'cao cả, cao thượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1086, '���0', 'g�os�', 'b�o, kỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1088, '���&�', 'gāox�ng', 'vui vẻ, vui mừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1089, '��涨', 'gāozhǎng', 'd�ng cao, tĒng vọt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1091, '�', 'g�', 'c�c, m�i, tất cả', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1093, '搁', 'g�', '�ặt, �Ồ, k�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1094, '�壁', 'g�b�', 'nh� b�n cạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1095, '个�ƫ', 'g�bi�', 'ri�ng bi�!t, c� bi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1096, '蒳� �', 'g�bo', 'c�nh tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1103, '�x', 'g�n', 'theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1104, '根�S�', 'g�nb�:n', 'cĒn bản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1105, '工�9', 'gōngch�ng', 'c�ng tr�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1106, '工�9��', 'gōngch�ngshī', 'kỹ sư', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1107, '�:�', 'g�ng', 'hơn nữa, c�ng, th�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1108, '�"�S�', 'g�ngd�', 'c�y ru�"ng, c�y bừa', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1181, '管� ', 'guǎnlǐ', 'quản l�', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1112, '�x�0�', 'g�nqi�n', 'cạnh, gần, b�n cạnh', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1113, '根深��:�', 'g�nsh�nd�g�', 'Ēn s�u b�n r�&', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1122, '个欧', 'g�x�ng', 't�nh c�ch, c� t�nh', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1124, '鸽子', 'g�zi', 'chim b� c�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1173, '���', 'guāndiǎn', 'ch�nh thức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1193, '�&0彩', 'guāngcǎi', 'h�o quang, m�u sắc �nh s�ng', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1111, '根据信', 'g�nj�', 'cĒn cứ', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1202, '�&0�', 'guāngm�ng', 'tia s�ng, h�o quang', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1206, '��&0', 'guānguāng', 'tham quan', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1114, '根源', 'g�nyu�n', 'cĒn nguy�n, ngu�n g�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1115, '�x踪', 'g�nzōng', 'theo d�i, b�m theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1116, '个人', 'g�r�n', 'c� nh�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1117, '格式', 'g�sh�', 'c�ch thức, quy c�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1119, '�R�', 'g�s�ng', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1120, '个�', 'g�tǐ', 'c� thỒ, c� nh�n, �ơn lẻ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1121, '格�', 'g�w�i', '�ặc bi�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1209, '�&�忒', 'guānxīn', 'quan t�m', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1123, '个子', 'g�zi', 'd�ng v�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1183, '�&�欬', 'guānhu�i', 'chĒm s�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1125, '�:不��', 'gōng b� y�ng qi�', 'cung kh�ng ��p ứng �ược cầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1126, '�&��0屬', 'gōng''ān j�', 'cục c�ng an', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1127, '�&�帒', 'gōngb�', 'th�ng b�o, c�ng b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1128, '工�', 'gōngchǎng', 'nh� m�y', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1129, '�&��', 'gōngd�o', 'c�ng l�, lẽ phải', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1130, '�:��', 'gōngdi�n', 'cung �i�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1131, '�x夫', 'gōngfu', 'c�ng sức, bản lĩnh, thời gian', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1133, '�&���', 'gōngg�o', 'th�ng b�o, th�ng c�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1134, '�&��&�汽车', 'gōngg�ng q�ch�', 'xe bu�t', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1136, '�&��R�:�', 'g�ngh�gu�', 'nư�:c c�"ng h�a', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1137, '���!�', 'gōngjī', 'tấn c�ng, tiến ��nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1138, '�:�"', 'gōngjǐ', 'cung cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1139, '恭�"�', 'gōngj�ng', 't�n k�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1140, '工�&�', 'gōngj�', 'c�ng cụ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1141, '�&�弬', 'gōngkāi', 'c�ng khai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1142, '�x课', 'gōngk�', 'b�i tập về nh�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1143, '���&9', 'gōngk�', 'tấn c�ng, ��nh chiếm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1144, '�x劳', 'gōngl�o', 'c�ng lao, c�ng trạng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1145, '�&��!R', 'gōnglǐ', 'km', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1146, '�&��', 'gōngm�n', 'c�ng d�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1148, '�&�平', 'gōngp�ng', 'c�ng bằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1149, '�&�� ', 'gōngp�', 'cha mẹ ch�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1150, '�&���', 'gōngr�n', 'ngang nhi�n, thẳng thắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1151, '工人', 'gōngr�n', 'c�ng nh�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1152, '�&�认', 'gōngr�n', 'c�ng nhận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1153, '�&�司', 'gōngsī', 'c�ng ty', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1154, '�&��0', 'gōngs�', 'c�ng t�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1155, '�&�务', 'gōngw�', 'c�ng vụ, vi�!c nư�:c, vi�!c c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1156, '�x�"�', 'gōngxi�o', 'c�ng hi�!u, c�ng nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1157, '�x�99', 'gōngxūn', 'c�ng hiến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1159, '工业', 'gōngy�', 'c�ng nghi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1160, '工�0���', 'gōngy�pǐn', '�� thủ c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1161, '�&��', 'gōngy�', 'chung cư', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1162, '�&��&�', 'gōngyu�n', 'c�ng nguy�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1163, '�&��:�', 'gōngyu�n', 'c�ng vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1164, '�&�正', 'gōngzh�ng', 'c�ng ch�nh, c�ng bằng, ch�nh trực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1165, '�&�证', 'gōngzh�ng', 'c�ng chứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1166, '�&�主', 'gōngzh�', 'c�ng ch�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1167, '工�', 'gōngzī', 'lương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1168, '工�S', 'gōngzu�', 'l�m vi�!c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1169, '�x', 'g�u', '�ủ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1170, '�9', 'g�u', 'ch�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1171, '��Ɛ', 'g�uch�ng', 'h�nh th�nh, cấu th�nh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1174, '�x鬚', 'gōutōng', 'khai th�ng, n�i liền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1175, '购�0�', 'g�uw�', 'mua sắm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1176, '�x� ', 'g�ule', '�ủ r�i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1177, '�R', 'gu�', 'treo, m�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1178, '�', 'guāi', 'ngoan', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1179, '�R号', 'gu�h�o', '�Ēng k�, lấy s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1180, '�9�', 'guǎi', 'rẽ, ngoặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1182, '��x', 'guānch�', 'quan s�t, xem x�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1185, '� �� :', 'gu�njūn', 'qu�n qu�n, chức v� ��9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1186, '罐头', 'gu�nt�u', '�� h�"p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1187, '管', 'guǎn', '�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1188, '贯彻', 'gu�nch�', 'qu�n tri�!t, th�ng su�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1189, '�:', 'gu�ng', '�i dạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1190, '�&0', 'guāng', '�nh s�ng, nhẵn, sạch trơn, ch�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1191, '�R�0', 'gu�ng�i', 'tư�:i, dẫn nư�:c tư�:i ru�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1192, '广��', 'guǎngb�', 'ph�t thanh, truyền h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1194, '广�S�', 'guǎngchǎng', 'quảng trường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1195, '广大', 'guǎngd�', 'r�"ng l�:n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1196, '广�:', 'guǎngf�n', 'r�"ng r�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1197, '广��', 'guǎngg�o', 'quảng c�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1201, '�&0临', 'guāngl�n', 'sự hi�!n di�!n, gh� thĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1203, '�&0�܎', 'guāngm�ng', '�nh s�ng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1204, '�&0�:�', 'guāngp�n', 'CD', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1205, '�&0荣', 'guāngr�ng', 'quang vinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1207, '�念', 'guānni�n', 'quan ni�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1208, '�&�系', 'guānx�', 'quan h�!, li�n quan', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1210, '�&�于', 'guāny�', 'về', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1211, '��', 'guānzh�ng', 'kh�n giả, quần ch�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1255, '�S��', 'gu�du�n', 'quả quyết, quả �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1231, '�格', 'guīg�', 'quy c�ch, kiỒu mẫu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1232, '�根�ư�"', 'guīg�nd�odǐ', 'x�t �ến c�ng, suy nghĩ cho c�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1249, '�!�', 'gu�ji�', 'qua, ��n (tết)', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1294, '���ܯ', 'h�ishi', 'vẫn, c�n, hoặc hay', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1300, '��', 'hǎn', 'k�u la', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1199, '�&0�0', 'guānghuī', 'ch�i lọi, rực rỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1213, '古代', 'g�d�i', 'thời c�" �ại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1215, '古�&�', 'g�diǎn', 'c�" �iỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1216, '�:�定', 'g�d�ng', 'c� ��9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1218, '���S', 'g�dōng', 'c�" ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1219, '��份', 'g�f�n', 'c�" phần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1220, '�励', 'g�l�', 'c�" vũ, khuyến kh�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1221, '���', 'g�sh�', 'th�9 trường chứng kho�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1222, '骨干', 'g�g�n', 'c�t c�n, n�ng c�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1223, '��', 'gūgu', 'c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1224, '古欪', 'g�gu�i', 'kỳ quặc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1225, '贵', 'gu�', '�ắt, qu�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1226, '�', 'guī', 'quy, tr�x về', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1227, '��9', 'guīl�S', 'quy luật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1228, '轨�', 'guǐd�o', '�ường ray', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1229, '�定', 'guīd�ng', 'quy ��9nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1233, '���', 'guīhu�', 'kế hoạch, quy hoạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1234, '���', 'guīhu�n', 'trả về, trả lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1235, '�模', 'guīm�', 'quy m�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1236, '�纳', 'guīn�', 'quy nạp, t�m tắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1237, '�xS台', 'gu�t�i', 'quầy h�ng, tủ b�y h�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1238, '���"', 'guīz�', 'quy tắc', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1239, '贵��', 'gu�z�', 'qu� t�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1241, '顾客', 'g�k�', 'kh�ch h�ng', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1242, '古謁', 'g�lǎo', 'c�" xưa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1243, '孤�9', 'gūl�', 'c� lập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1244, '顾�"', 'g�l�S', 'lo lắng, bĒn khoĒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1245, '滚', 'g�n', 'lĒn, l�"n, c�t x�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1246, '棍�', 'g�nb�ng', 'c�n, gậy, gậy g�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1247, '���', 'gūniang', 'c� g�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1248, '�!', 'gu�', 'qua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1250, '�!�Sx', 'gu�q�', '�� qu�, tr�& hạn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1251, '�S汁', 'gu�zhī', 'nư�:c hoa quả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1253, '�!度', 'gu�d�', 'qu� ��", qu� mức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1254, '�!渡', 'gu�d�', 'chuyỒn tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1256, '�:��ܲ', 'gu�f�ng', 'qu�c ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1257, '�:�籍', 'gu�j�', 'qu�c t�9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1258, '�:��"&', 'gu�j�', 'qu�c tế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1259, '�:�家', 'gu�jiā', 'nh� nư�:c, qu�c gia', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1260, '�:�� ', 'gu�q�ng', 'qu�c kh�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1261, '�!滤', 'gu�l�S', 'lọc (bụi, nư�:c...)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1262, '�!�"�', 'gu�mǐn', 'd�9 ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1264, '�!�� ', 'gu�f�n', 'qu� ��ng, qu� mức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1265, '�!�', 'gu�jiǎng', 'qu� khen', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1266, '�!�"', 'gu�cu�', 'sai lầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1267, '�S��', 'gu�r�n', 'quả nhi�n, thật vậy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1268, '�S实', 'gu�sh�', 'tr�i c�y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1269, '�:��9', 'gu�w�ng', 'ho�ng �ế, nh� vua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1270, '�:�务�"�', 'gu�w�yu�n', 'qu�c vụ vi�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1272, '�!于', 'gu�y�', 'qu� chừng, qu� ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1273, '��票', 'g�pi�o', 'c�" phiếu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1276, '�"&�9', 'g�shi', 'sự c�, tai nạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1277, '�:��', 'g�tǐ', 'thỒ rắn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1278, '骨头', 'g�tou', 'xương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1279, '顾��', 'g�w�n', 'c� vấn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1280, '��ƞ', 'g�w�', 'c�" vũ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1281, '�"&乡', 'g�xiāng', 'qu� nh�, qu� hương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1282, '�"&��', 'g�y�', 'c� �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1283, '�:!佣', 'g�yōng', 'thu�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1285, '�"&�S', 'g�zh�ng', 'trục trặc, hỏng h�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1287, '��', 'hā', 'ha', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1288, '��', 'h�i', 'c�n, vẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1289, '海', 'hǎi', 'biỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1290, '海�9', 'hǎib�', '��" cao so v�:i mặt nư�:c biỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1291, '海滨', 'hǎibīn', 'miền biỒn, ven biỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1292, '海�&�', 'hǎiguān', 'hải quan', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1293, '害�"', 'h�ip�', 'sợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1295, '海�S', 'hǎixiān', 'hải sản', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1296, '害羞', 'h�ixiū', 'xấu h�", thẹn th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1298, '孩子', 'h�izi', 'trẻ em, trẻ con, em b�, con', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1299, '�', 'h�n', 'm� h�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1301, '�ƪ班', 'h�ngbān', 'chuyến bay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1302, '�ƪ空', 'h�ngkōng', 'h�ng kh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1303, '�ƪ天', 'h�ngtiān', 'h�ng kh�ng vũ trụ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1304, '�ƪ�R', 'h�ngx�ng', '�i, vận chuyỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1305, '�R业', 'h�ngy�', 'ng�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1306, '含糊', 'h�nhu', 'mơ h�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1307, '��!', 'h�nji�', 'k� ngh�0 ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1309, '捍卫', 'h�nw�i', 'bảo v�!, giữ g�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1310, '�水', 'h�nxu�', 'h�n huyết, hơi han', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1311, '�0语', 'h�ny�', 'tiếng H�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1312, '号', 'h�o', 's�, cờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1313, '好', 'hǎo', 't�t, hay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1314, '好吒', 'hǎochī', 'ngon', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1315, '号码', 'h�omǎ', 's�, d�y s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1316, '好�', 'hǎochu', '�iỒm t�t, ưu �iỒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1317, '�费', 'h�of�i', 'ti�u hao, hao ph�, hao m�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1318, '豪华', 'h�ohu�', 'sang trọng, hao hoa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1319, '好客', 'h�ok�', 'hiếu kh�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1320, '豪��', 'h�om�i', 'kh� ph�ch h�o h�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1336, '�', 'h�i', 'm�u �en', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1348, '�9�忒', 'h�:nxīn', 'nhẫn t�m', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1343, '��', 'h�:n', 'vừa vặn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1355, '��影', 'h�yǐng', 'chụp ảnh chung', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1366, '吼', 'h�u', 'g�o l�n, g�o to', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1367, '后代', 'h�ud�i', 'con ch�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1371, '后来', 'h�ul�i', 'sau, sau r�i', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1378, '��', 'hu�', 'vẽ, họa, bức tranh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1383, '花�0', 'huāf�:n', 'phấn hoa', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1390, '�', 'hu�ng', 'm�u v�ng', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1324, '号召', 'h�ozh�o', 'hi�!u tri�!u, k�u gọi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1325, '�R', 'h�', 'v�, v�:i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1326, '河', 'h�', 's�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1327, '��', 'h�', 'u�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1328, '��不来', 'h�b�l�i', 'h�a tắt, c�i, bất hợp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1329, '��并', 'h�b�ng', 'hợp lại, hợp nhất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1393, '�!后', 'hu�ngh�u', 'ho�ng hậu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1331, '���"', 'h�f�', 'hợp ph�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1333, '��乎', 'h�hū', 'ph� hợp, hợp v�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1334, '���"', 'h�hu�', 'kết h�"i, chung v�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1335, '�ܿ', 'h�i', '�i, ư, � hay, ơ hay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1414, '话��', 'hu�t�', 'chủ �ề', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1337, '�板', 'h�ibǎn', 'bảng �en', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1338, '�R解', 'h�ji�:', 'h�a giải', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1339, '�"� �', 'h�ku�ng', 'hơn nữa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1340, '��� ', 'h�lǐ', 'hợp l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1341, '�R睦', 'h�m�', 'vui vẻ, h�a thuận', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1342, '恨', 'h�n', 'hận, gh�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1420, '�R� ', 'hu�zhuāng', 'trang �iỒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1345, '横', 'h�ng', 'ngang', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1346, '��', 'h�ng', 'r�n r�0, ng�m nga', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1347, '�"迹', 'h�nj�', 'vết t�ch, dấu vết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1425, '�R�', 'huī', 'vẫy', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1349, '�R平', 'h�p�ng', 'h�a b�nh', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1350, '�R�', 'h�q�', '�n h�a, �iềm �ạm', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1351, '���', 'h�sh�', 'ph� hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1352, '���', 'h�su�n', 'c� lợi, hi�!u quả, t�nh to�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1353, '�R谐', 'h�xi�', 'h�i h�a, d�9u d�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1354, '核忒', 'h�xīn', 'trung t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1426, '灰', 'huī', 'm�u x�m', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1356, '�:子', 'h�zi', 'c�i h�"p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1357, '���S', 'h�zu�', 'hợp t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1358, '�', 'h�ng', 'd� d�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1359, '洪水', 'h�ngshuǐ', 'lũ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1360, '红', 'h�ng', '�ỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1362, '轰动', 'hōngd�ng', 'x�n xao, n�o ��"ng, chấn ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1363, '宏�', 'h�ngguān', 'vĩ m�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1364, '宏�x', 'h�ngw�:i', 'to l�:n h�o h�ng, h�ng vĩ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1365, '厚', 'h�u', 'd�y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1368, '后�S', 'h�ugu�', 'hậu quả', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1370, '后�', 'h�uhuǐ', 'h�i hận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1372, '�0�"', 'h�ul�ng', 'c�" họng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1373, '后面', 'h�umi�n', 'ph�a sau, mặt sau, �ằng sau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1374, '后�9�', 'h�uq�n', 'hậu cần', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1375, '�"�0', 'h�uxuǎn', 'người �ược �ề cử, người ứng cử', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1376, '�R�子', 'h�uzi', 'con kh�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1377, '壶', 'h�', 'b�nh, ấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1379, '花', 'huā', 'hoa, ti�u tiền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1381, '�� �', 'hu�bīng', 'trượt bĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1382, '���ƹ', 'hu�chu�n', 'ch�o thuyền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1384, '坏', 'hu�i', 'xấu, hỏng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1385, '欬念', 'hu�ini�n', 'ho�i ni�!m, nh�: nhung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1386, '欬�', 'hu�iy�', 'ho�i nghi, nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1387, '欬�"', 'hu�iy�n', 'c� thai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1388, '欢乐', 'huānl�', 'sự vui mừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1391, '�!帝', 'hu�ngd�', 'ho�ng �ế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1392, '��S', 'hu�ngguā', 'dưa chu�"t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1394, '��܏', 'hu�nghūn', 'bu�"i chiều, ho�ng h�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1395, '��!', 'hu�ngjīn', 'v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1396, '��!0', 'huāngli�ng', 'hoang vu, hoang vắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1397, '�&R�"', 'huāngm�ng', 'v�"i v�ng, lật �ật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1398, '�谬', 'huāngmi�', 'sai lầm, v� l�, hoang �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1399, '恍��大�x', 'huǎngr�nd�w�', 'b�ng nhi�n t�0nh ng�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1400, '���', 'huāngt�ng', 'hoang �ường, v� l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1402, '��R', 'huǎnh�', 'xoa d�9u, h�a ho�n', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1403, '环�', 'hu�nji�', 'mắt x�ch, ph�n �oạn, ��t, mấu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1404, '�解', 'huǎnji�:', 'xoa d�9u, l�m d�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1405, '环墒', 'hu�nj�ng', 'm�i trường, ho�n cảnh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1406, '幻撳', 'hu�nxiǎng', 'ảo tư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1407, '欢迎', 'huāny�ng', '��n ch�o, hoan ngh�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1408, '�"��丬��', 'hu�nr�nyīxīn', 'tr�x về trạng th�i cũ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1409, '���&', 'hu�nzh�:', 'người b�9 b�!nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1410, '华侨', 'hu�qi�o', 'hoa kiều', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1411, '花�x', 'huāsh�ng', 'củ lạc', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1413, '�R�x�', 'hu�sh�', 'h�a thạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1415, '话�', 'hu�t�ng', 'microphone', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1416, '�R学', 'hu�xu�', 'h�a học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1417, '华�', 'hu�y�', 'Hoa kiều', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1418, '华语', 'hu�y�', 'tiếng Hoa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1419, '花�:�', 'huāyu�n', 'hoa vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1421, '�泊', 'h�pō', 'ao h�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1422, '蝴蝶', 'h�di�', 'bươm bư�:m, con bư�:m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1423, '�:�', 'hu�', 'lần, về, quay lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1424, '会', 'hu�', 'h�"i, họp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1427, '�:�报', 'hu�b�o', 'trả lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1435, '�0�&R', 'huīhu�ng', 'huy ho�ng, rực rỡ, x�n lạn', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1439, '�:���', 'hu�shōu', 'thu lại, thu h�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1449, '婚姻', 'hūnyīn', 'h�n nh�n', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1467, '活跒', 'hu�yu�', 's�i n�"i, hoạt b�t', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1490, '家�"', 'jiāhuo', 'thằng cha, l�o', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1526, '钊游', 'jiāoy�u', 'd� ngoại, du ngoạn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1529, '�""学', 'ji�oxu�', 'giảng dạy', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1537, '缴纳', 'jiǎon�', 'n�"p (thuế, ph�)', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1546, '�""��', 'ji�oyu�n', 'gi�o vi�n, giảng vi�n', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1548, '接', 'ji�', 'tiếp, nhận, n�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1429, '�:�避', 'hu�b�', 'n� tr�nh, tr�n tr�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1430, '灰��', 'huīch�n', 'bụi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1431, '�:��', 'hu�d�', 'trả lời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1432, '恢复', 'huīf�', 'kh�i phục, phục h�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1434, '�恨', 'huǐh�n', 'h�i hận, h�i l�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1436, '�R��S�', 'huīhu�', 'phung ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1437, '毁灭', 'huǐmi�', 'ti�u di�!t, hủy di�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1438, '�!�!', 'hu�l�S', 'tỷ gi�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1440, '会�"�', 'hu�w�', 'gặp gỡ, gặp mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1441, '灰忒', 'huīxīn', 'nản l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1442, '�:�� ', 'hu�y�', 'h�i ức, nh�: lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1443, '会议', 'hu�y�', 'h�"i ngh�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1445, '�!叭', 'h�lǎba', 'loa, qua qu�t, t�y ti�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1446, '忽�"�', 'hūl��', 'bỏ qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1447, '婚礼', 'hūnlǐ', 'h�n l�&', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1448, '混乱', 'h�nlu�n', 'h�n loạn, lẫn l�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1450, '混��', 'h�nh�', 'h�n hợp, tr�"n, nh�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1452, '�܏迷', 'hūnm�', 'h�n m�, m� man', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1453, '混� ', 'hūnxi�o', 'l�"n x�"n, x�o tr�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1454, '�浊', 'hūnzh�o', 'vẩn �ục', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1455, '�"伴', 'hu�b�n', '��i t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1456, '货币', 'hu�b�', 'tiền t�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1457, '火�x�', 'hu�ch�i', 'di�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1458, '火车�"', 'hu�ch� zh�n', 'ga t�u', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1459, '获�', 'hu�d�', 'gi�nh �ược, �ạt �ược', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1460, '活动', 'hu�d�ng', 'hoạt ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1461, '活该', 'hu�gāi', '��ng �ời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1463, '活�:', 'hu�l�', 'sức s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1464, '活泼', 'hu�pō', 'hoạt b�t, nhanh nhẹn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1465, '��', 'hu�', 'hoặc', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1466, '火药', 'hu�y�o', 'thu�c s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1468, '忽��', 'hūr�n', '��"t nhi�n, chợt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1469, '护士', 'h�shi', 'y t�', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1470, '蒡说', 'h�shuō', 'n�i nhảm, t�o lao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1471, '蒡�R', 'h�t�ng', 'ng�, hẻm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1472, '��吸', 'hūxī', 'h� hấp, h�t th�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1475, '����', 'hūhǎn', 'h� h�o, k�u gọi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1476, '护�&�', 'h�zh�o', 'h�" chiếu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1477, '极', 'j�', 'rất, hết, cực', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1479, '�S�', 'jī', 'm�y, vải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1480, '家', 'jiā', 'gia, lấy ch�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1481, '家庭', 'jiāt�ng', 'gia ��nh, nh�', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1482, '�!', 'jiǎ', 'giả, giả ��9nh, giả như', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1483, '价', 'ji�', 'gi�, gi� cả', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1485, '加班', 'jiābān', 'tĒng ca', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1486, '��0宾', 'jiābīn', 'kh�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1488, '价格', 'ji�g�', 'gi� cả', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1489, '加工', 'jiāgōng', 'gia c�ng, chế biến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1491, '加�0�', 'jiāj�', 'trầm trọng th�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1492, '家�&�', 'jiāj�', 'gia cụ, �� d�ng trong nh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1493, '件', 'ji�n', 'chiếc, c�i, ki�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1494, '箬�"', 'jiǎndān', '�ơn giản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1495, '�9�', 'jiǎn', 'lựa chọn, nhặt lấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1496, '�&�', 'jiān', 'r�n, chi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1497, '��', 'jiān', 'giữa, trong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1498, '建�9', 'ji�nl�', 'thiết lập', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1499, '�:督', 'jiāndū', 'gi�m s�t, ��n th�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1501, '坚� �', 'jiānju�', 'ki�n quyết, dứt kho�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1502, '建设', 'ji�nsh�', 'x�y dựng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1503, '坚�R�', 'jiānch�', 'ki�n tr�, vững chắc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1504, '�0��Ƭ', 'jiǎndāo', 'k�o, c�i k�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1505, '�!��', 'jiǎnshǎo', 'giảm b�:t, giảm thiỒu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1506, '棬�x�', 'jiǎnch�', 'kiỒm tra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1507, '箬� ', 'jiǎnl�', 'sơ yếu l� l�9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1508, '棬讨', 'jiǎntǎo', 'thảo luận, tự kiỒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1509, '箬�:�', 'jiǎnzh�', 'quả thực, thật l�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1511, '�0�', 'jiǎn', 'cắt, x�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1513, '���', 'jiānru�', 'sắc b�n, gay gắt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1514, '健康', 'ji�nkāng', 'khỏe mạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1515, '讲', 'jiǎng', 'n�i, kỒ, giảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1516, '�"�低', 'ji�ngdī', 'hạ thấp, giảm b�:t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1517, '��!', 'jiǎngjīn', 'tiền thư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1518, '� 来', 'jiāngl�i', 'tương lai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1519, '�励', 'jiǎngl�', 'khen thư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1520, '�', 'jiǎng', 'thư�xng, giải thư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1521, '�"�', 'ji�ng', 'hạ xu�ng, rơi xu�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1522, '讲座', 'jiǎngzu�', 'tọa ��m, b�o c�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1527, '�""��', 'ji�oshī', 'gi�o vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1528, '�""�', 'ji�ot�ng', 'nh� thờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1536, '�&�9R', 'jiǎob�n', 'khuấy, tr�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1540, '饺', 'jiǎo', 'b�nh chẻo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1549, '��', 'ji�d�o', '�ường ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1550, '�', 'ji�', 'tiết, ��t, kh�c, phần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1551, '�:� ', 'jiānsh�', 'gi�m th�9, theo d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1554, '���!�', 'ji�nxīz�', 'chữ gi�n th�!', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1535, '���', 'jiāo�"�o', 'ki�u ngạo, tự h�o', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1524, '交', 'jiāo', 'giao, n�"p, kết giao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1633, '�奏', 'ji�z�u', 'nh�9p �i�!u, tiết tấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1541, '�""', 'ji�o', 'dạy', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1573, '�!�', 'jiāoq�', 'duy�n d�ng, thanh nh�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1562, '�:�9�', 'jiāny�', 'nh� t�, nh� giam', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1630, '�9质', 'ji�zh�', 'chất trung gian', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1581, '加油�"', 'jiāy�uzh�n', 'trạm xĒng', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1604, '�"R�"�', 'ji�xi�n', 'ranh gi�:i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1523, '交流', 'jiāoli�', 'giao lưu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1615, '姐姐', 'ji�:jie', 'ch�9 g�i', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1525, '钊�R�', 'jiāoqū', 'ngoại �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1530, '�""��', 'ji�oy�', 'gi�o dục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1531, '交换', 'jiāohu�n', 'trao ��"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1620, '�9绍', 'ji�sh�o', 'gi�:i thi�!u', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1625, '解�!�', 'ji�:sh�', 'giải th�ch', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1538, '�', 'jiǎo', 'sừng, g�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1539, '��', 'jiǎo', 'ch�n', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1627, '�ƪ止', 'ji�zhǐ', 'kết th�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1634, '濬�', 'jīfā', 'k�ch th�ch', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1543, '�""绒', 'ji�oli�n', 'huấn luy�!n vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1544, '�""��', 'ji�osh�u', 'gi�o sư', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1545, '�""室', 'ji�osh�', 'l�:p, ph�ng học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1547, '叫', 'ji�o', 'gọi, k�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1553, '�ư�0!', 'ji�ntǐng', 'chiến hạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1637, '�S��', 'jīg�u', 'cơ cấu, �ơn v�9, cơ quan', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1555, '见��', 'ji�nw�n', 'hiỒu biết, sự từng trải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1556, '棬�R', 'jiǎny�n', 'kiỒm nghi�!m, kiỒm tra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1557, '�!�弱', 'jiǎnru�', 'giảm dần, k�m yếu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1558, '建议', 'ji�ny�', '�ề xuất, kiến ngh�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1559, '坚硬', 'jiāny�ng', 'cứng, chắc, rắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1560, '�&��R��为�9!为', 'jiāny�ngw�i', 'gi�m l�m vi�!c nghĩa', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1561, '�0�于', 'ji�ny�', 'thấy rằng, x�t thấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1639, '�S��&�', 'jīguān', 'cơ quan', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1564, '坚�0�', 'jiānzh�', 'ki�n chấp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1565, '�!', 'jiāo', 'tư�:i, ��", d�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1566, '交�0', 'jiāochā', '�an xen, �an ch�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1567, '交�"&', 'jiāoj�', 'giao tế, giao tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1568, '�""会', 'ji�ohu�', 'gi�o h�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1569, '�度', 'jiǎod�', 'g�c, g�c ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1570, '���"', 'jiāol�S', 'lo lắng, n�n n�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1571, '�落', 'jiǎolu�', 'g�c x� x�0nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1572, '交纳', 'jiāon�', 'n�"p, giao n�"p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1641, '�!�乎', 'jīhū', 'hầu như, cơ h�', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1575, '蒶水', 'jiāoshuǐ', 'keo nư�:c, h� d�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1576, '交鬚', 'jiāotōng', 'giao th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1577, '�!�', 'jiǎr�', 'nếu như', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1578, '�!设', 'jiǎsh�', 'giả thuyết', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1579, '家属', 'jiāsh�', 'người nh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1580, '家务', 'jiāw�', 'vi�!c nh�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1542, '�""材', 'ji�oc�i', 't�i li�!u giảng dạy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1582, '佳��', 'jiāy�o', 'm�n Ēn ngon', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1583, '家���Ʒ�"', 'jiāy�h�xiǎo', 'nh� nh� �ều biết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1584, '�!�&', 'jiǎzhuāng', 'giả vờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1585, '价嬼', 'ji�zh�', 'gi� tr�9', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1586, '架子', 'ji�zi', 'c�i k�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1587, '�0�', 'j�d�', '�� kỵ, ganh gh�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1588, '级�ƫ', 'j�bi�', 'tr�nh ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1590, '�S��S�', 'jīchǎng', 's�n bay', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1591, '继�0�', 'j�ch�ng', 'kế thừa, kế tục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1592, '�x�硬', 'jīch�', 'cơ s�x, nền tảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1593, '鸡�:9', 'jīd�n', 'trứng g�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1594, '记�', 'j�de', 'nh�:, nh�: �ược', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1595, '�x��S�', 'jīd�', 'cĒn cứ', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1597, '季度', 'j�d�', 'qu�, 3 th�ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1598, '极端', 'j�duān', 'cực �oan', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1599, '即', 'j�', 'tức, liền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1600, '�ƪ', 'ji�', '�oạn, kh�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1601, '� ', 'ji�', '�ều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1602, '�', 'ji�', 'kết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1605, '解��', 'ji�:f�ng', 'giải ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1606, '��', 'ji�g�u', 'kết cấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1607, '��S', 'ji�gu�', 'kết quả', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1608, '���', 'ji�h�', 'kết hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1609, '�x�0�', 'ji�ji�n', 'r�t kinh nghi�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1610, '接�', 'ji�j�n', 'tiếp cận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1612, '��"�', 'ji�jīng', 'kết tinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1613, '�屬', 'ji�j�', 'kết cục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1614, '解� �', 'ji�:ju�', 'giải quyết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1616, '接连', 'ji�li�n', 'li�n tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1617, '�论', 'ji�l�n', 'kết luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1618, '��:�', 'ji�m�', 'tiết mục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1619, '�9�&�', 'ji�r�', 'xen v�o, tham dự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1621, '��S�', 'ji�sh�:ng', 'tiết ki�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1622, '��x', 'ji�sh�', 'kết th�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1624, '��', 'ji�su�n', 'thanh to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1626, '接触', 'ji�ch�', 'tiếp x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1628, '�约', 'ji�yu�', 'tiết ki�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1629, '接睬', 'ji�zhe', 'tiếp theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1631, '���R!', 'ji�zhǐ', 'nhẫn', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1635, '及格', 'j�g�', 'hợp c�ch, �ạt ti�u chuẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1636, '�S��&��0��:', 'jīgōngj�nlǐ', 'vi c�i trư�:c mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1638, '籍贯', 'j�gu�n', 'qu� qu�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1640, '�: ��', 'j�h�', 'tập hợp, tập trung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1713, '今天', 'jīntiān', 'h�m nay', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1649, '纪�9', 'j�l�S', 'kỷ luật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1698, '精� ', 'jīngx�', 't�0 m�0', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1664, '�:步', 'j�nb�', 'tiến b�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1685, '精�9�', 'jīngyīng', 'tinh anh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1673, '警�x', 'jǐngch�', 'cảnh s�t', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1724, '�: �', 'j�tǐ', 'tập thỒ', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1660, '紧� ', 'jǐnm�', 'chặt chẽ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1672, '精彩', 'jīngcǎi', 'tuy�!t vời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1687, '经�" ', 'jīngshāng', 'kinh doanh', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1681, '精神', 'jīngsh�n', 'tinh thần', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1677, '精确', 'jīngqu�', 'ch�nh x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1645, '即� ', 'j�jiāng', 'sắp t�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1646, '积极', 'jīj�', 't�ch cực, hĒng h�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1647, '计辒', 'j�ji�o', 'so b�, t�nh to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1648, '季�', 'j�ji�', 'm�a, m�a kh� hậu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1650, '纪念', 'j�ni�n', 'kỷ ni�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1651, '欥�"', 'j�m�ng', 'v�"i v�, hấp tấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1652, '纪实', 'j�sh�', 'k� sự', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1653, '及��', 'j�sh�', 'k�9p thời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1654, '积�', 'jīx�', 't�ch lũy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1656, '濬��', 'jīli�', 'm�nh li�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1657, '�S�灵', 'jīl�ng', 'th�ng minh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1658, '记�"', 'j�l�', 'ghi ch�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1659, '濬�"', 'jīm�ng', 'v�"i v�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1735, '�&', 'ji�', 'l�u, l�u �ời', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1661, '�:�R', 'j�nx�ng', 'tiến h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1662, '�:', 'j�n', 'tiến, v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1663, '紧', 'jǐn', 'chặt', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1738, '纠纷', 'jiūf�n', 'tranh chấp, bất h�a', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1666, '抬蒽', 'j�n�ng', 'kỹ nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1667, '�:�R', 'j�n''�r', 'tiến t�:i, triỒn khai kế tiếp', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1668, '�"', 'jǐng', 'giếng, hầm, l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1669, '�"', 'j�ng', 'thản c�y', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1670, '�"�业乐业', 'j�ng y� y�', 'cẩn trọng, cẩn thận, cần c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1671, '�"��Ʊ', 'j�ng''�i', 'k�nh y�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1739, '�"护车', 'ji�h�ch�', 'xe cứu h�"', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1741, '就�', 'ji�j�n', 'l�n cận, v�ng phụ cận', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1675, '精诚', 'jīngch�ng', 'th�nh thật', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1676, '精�:', 'jīngzh�n', 'tinh tế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1743, '�&精', 'ji�jīng', 'c�n, rượu c�n', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1678, '�"�象', 'jǐngxi�ng', 'cảnh tượng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1679, '警��', 'jǐngg�o', 'cảnh c�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1680, '经�!', 'jīnggu�', 'qu� tr�nh, qua, �i qua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1750, '迹象', 'j�xi�ng', 'dấu hi�!u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1682, '精�:', 'jīngl�', 'tinh lực, sức lực', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1683, '经济', 'jīngj�', 'kinh tế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1684, '经�R', 'jīngy�n', 'kinh nghi�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1723, '记� ', 'j�y�', 'tr� nh�:', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1686, '�"��0�', 'jǐngs�', 'phong cảnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1690, '经济学', 'jīngj�xu�', 'kinh tế học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1691, '经� ', 'jīnglǐ', 'gi�m ��c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1692, '�x��', 'j�ngr�n', 'm�, lại, vậy m�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1693, '精美', 'jīngm�:i', 'tinh xảo, �ẹp �ẽ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1694, '�:��', 'j�ngōng', 'tấn c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1695, '撊�!', 'jīngq�', 'kinh ngạc, lấy l�m lạ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1696, '竞�:', 'j�ngs�i', 'cu�"c thi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1697, '精鬚', 'jīngtōng', 'tinh th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1699, '经管', 'jīngguǎn', 'cai quản', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1701, '�:口', 'j�nk�u', 'nhập khẩu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1702, '�:�', 'j�nq�', 'cầu tiến', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1703, '�:�&�', 'j�nr�', 'tiến v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1704, '�来', 'j�nl�i', 'gần ��y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1705, '尽�:', 'j�nl�', 'hết sức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1706, '尽�!�', 'jǐnli�ng', 'tận lực', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1707, '浸泡', 'j�np�o', 'ng�m, nh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1708, '紧迫', 'jǐnp�', 'cấp b�ch', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1710, '谨�&�', 'jǐnsh�n', 'cẩn thận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1711, '�"9�!', 'j�nsh�ng', 'thĒng tiến', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1712, '�!属', 'jīnsh�', 'kim loại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1714, '劲头', 'j�nt�u', 'sức mạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1715, '��绣�0��9', 'jǐnxi� qi�nch�ng', 'tương lai tươi s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1716, '�:�"', 'j�nzhǎn', 'tiến triỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1717, '紧张', 'jǐnzhāng', 'cĒng thẳng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1718, '禁止', 'j�nzhǐ', 'cấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1719, '�S��"�', 'jīq�', 'm�y m�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1720, '极�&�', 'j�q�', 'cực kỳ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1722, '紧欥', 'jǐnj�', 'cấp thiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1726, '计�', 'j�su�n', 't�nh to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1728, '抬�S�', 'j�sh�', 'kỹ thuật', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1729, '继续', 'j�x�', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1730, '即使', 'j�shǐ', 'cho d�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1732, '�寞', 'j�m�', 'c� �ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1733, '�"', 'ji�', 'cứu', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1734, '��', 'ji�', 'cũ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1736, '九', 'ji�', 'ch�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1737, '�&吧', 'ji�bā', 'qu�n bar', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1742, '究�x', 'jiūj�ng', 'r�t cu�"c, cu�i c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1744, '就业', 'ji�y�', 'c� c�ng Ēn vi�!c l�m, �i l�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1745, '纠正', 'jiūzh�ng', 'u�n nắn, sửa chữa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1746, '就�R', 'ji�zh�', 'nhận chức, nhậm chức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1748, '极�"�', 'j�xi�n', 'cao nhất, cực ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1749, '�0祥', 'j�xi�ng', 'may mắn, c�t tường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1751, '讥�', 'jīxi�o', 'ch�m biếm, nhạo b�ng, chế gi�&u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1752, '�S�械', 'jīxi�', 'm�y m�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1753, '纪要', 'j�y�o', 'kỷ yếu, t�m tắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1854, '课��', 'k�t�', '�ề t�i', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1727, '记�&', 'j�zh�:', 'nh� b�o', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1837, '�ƻ', 'k�', '�Skhắc⬝ = 15 ph�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1761, '举', 'j�', 'n�ng, nhấc, giơ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1762, '俱乐钨', 'j� l� b�', 'c�u lạc b�"', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1780, '鞠躬', 'jūgōng', 'c�i ch�o, c�i �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1788, '� :�9', 'jūnsh�', 'qu�n sự', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1789, '�!�R�', 'jūny�n', '�ều, d�n', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1794, '据说', 'j�shuō', 'nghe n�i', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1800, '卡车', 'kǎch�', 'xe tải', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1803, '弬�"�', 'kāich�', 'khai trừ, �u�"i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1754, '�"��', 'jǐy�', 'd�nh cho, cho', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1755, '�x�于', 'jīy�', 'dựa tr�n, cĒn cứ v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1757, '记载', 'j�zǎi', 'ghi lại, ghi ch�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1758, '欥躁', 'j�z�o', 'n�ng v�"i, hấp tấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1759, '及��', 'j�zǎo', 's�:m, k�9p thời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1760, '�S��"�', 'jīzh�', 'lanh tr�, tinh nhanh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1827, '謒�x', 'kǎoch�', 'khảo s�t, quan s�t', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1828, '謒古学', 'kǎog�xu�', 'khảo c�" học', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1763, '捐', 'juān', 'tặng, quy�n g�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1764, '举办', 'j�b�n', 't�" chức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1765, '�&��!', 'j�b�i', 'c� �ủ, c� sẵn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1766, '�0��S�', 'j�b�:n', 'k�9ch bản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1767, '屬钨', 'j�b�', 'cục b�", b�" phận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1768, '举动', 'j�d�ng', 'h�nh ��"ng, ��"ng t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1769, '� �定', 'ju�d�ng', 'quyết ��9nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1770, '绝对', 'ju�du�', 'tuy�!t ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1771, '� ���', 'ju�du�n', 'quyết �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1772, '�0�x', 'ju�ch�', 'ph�t gi�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1774, '��0�', 'ju�s�', 'vai (vai tr�)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1775, '绝�S:', 'ju�w�ng', 'tuy�!t vọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1776, '�0� ', 'ju�xǐng', 't�0nh ng�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1777, '� �议', 'ju�y�', 'ngh�9 quyết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1778, '绝��', 'ju�yu�n', 'c�ch ly, c�ch �i�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1779, '�9绝', 'j�ju�', 'từ ch�i, cự tuy�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1841, '客�', 'k�qi', 'kh�ch s�o', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1781, '�0��&', 'j�q�ng', 't�nh tiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1782, '聚精会神', 'j�jīnghu�sh�n', 'tập trung tinh thần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1783, '�9�谨', 'jūjǐn', 'nh�t nh�t, d� dặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1784, '�9��""', 'jūli�', 'tạm giam, tạm giữ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1785, '距离', 'j�l�', 'khoảng c�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1786, '�0���', 'j�li�', 'm�nh li�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1857, '栭', 'k�:', 'c�y, ngọn', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1790, '�&��', 'jūr�n', 'lại, vậy m�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1791, '屬势', 'j�sh�', 'thế cục, t�nh h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1792, '举���名', 'j�sh� w�nm�ng', 'n�"i tiếng thế gi�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1848, '�', 'k�', 'hạt, h�n, vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1795, '据�0', 'j�xī', '�ược biết', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1796, '屬�"�', 'j�xi�n', 'hạn chế, gi�:i hạn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1797, '举�R', 'j�x�ng', 't�" chức, cử h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1798, '�&住', 'jūzh�', 'cư tr�, sinh s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1799, '举足轻�!�', 'j�z� qīngzh�ng', 'c� ảnh hư�xng quyết ��9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1801, '��"�', 'kāf�i', 'c� ph�', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1802, '弬', 'kāi', 'm�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1804, '弬�', 'kāifā', 'khai ph�, m�x mang', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1805, '弬��', 'kāif�ng', 'm�x cửa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1806, '弬�S', 'kāilǎng', 'r�"ng r�i, tho�ng m�t, s�ng sủa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1807, '弬�"式', 'kāim� sh�', 'l�& khai mạc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1808, '弬�x', 'kāip�', 'm�x, khai ph�, khai th�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1809, '弬�9', 'kāishǐ', 'bắt �ầu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1810, '弬玩�', 'kāiw�nxi�o', '��a, giỡn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1811, '弬忒', 'kāixīn', 'vui vẻ, hạnh ph�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1812, '弬�"', 'kāizhǎn', 'triỒn khai, m�x r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1813, '弬��', 'kāizhī', 'chi ti�u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1814, '�S9', 'k�n', 'nh�n, xem', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1816, '�S9来', 'k�nl�i', 'xem ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1817, '�S9不起', 'k�nbuqǐ', 'coi thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1818, '�Ɗ�"�', 'kānd�ng', '�Ēng, xuất bản', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1819, '�S9�"', 'k�nfǎ', 'quan �iỒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1820, '�0:', 'k�ng', 'g�nh, v�c', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1822, '�&��&�濬��', 'kāngkǎi jī�"�ng', 'khảng kh�i, h�ng h�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1823, '�S9见', 'k�nji�n', 'nh�n thấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1824, '�9�探', 'kānt�n', 'khảo s�t, trinh s�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1825, '�S9�S:', 'k�nw�ng', 'vấn an, thĒm hỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1826, '�Ɗ�0�', 'kānw�', 's�ch b�o, ấn phẩm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1829, '謒�"', 'kǎol�S', 'suy nghĩ, c�n nhắc', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1830, '謒�"', 'kǎosh�', 'thi cử', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1831, '璤鸭', 'kǎoyā', 'v�9t nư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1832, '謒�R', 'kǎoy�n', 'khảo nghi�!m, thử th�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1833, '卡鬚', 'kǎtōng', 'hoạt h�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1834, '�&9', 'k�', 'gram', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1835, '渴', 'k�:', 'kh�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1836, '课', 'k�', 'm�n, b�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1838, '客', 'k�', 'kh�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1849, '�ƻ�9�', 'k�k�', 'ch�9u kh�, cần c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1850, '殼��壳�0', 'k�', 'vỏ (vật)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1851, '����', 'k�sou', 'ho', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1852, '坷垒', 'k�:lā', '�ất v�n cục (nếu c�)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1853, '恪��', 'k�sh�u', 'tu�n thủ nghi�m (nếu c�)', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1858, '�"', 'k�', 'g�, �ập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1859, '可�Ʊ', 'k�:�"�i', '��ng y�u, d�& thương', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1860, '�ƻ不容�', 'k�b�r�nghuǎn', 'cấp b�ch, v� c�ng khẩn cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1843, '可靠', 'k�:k�o', '��ng tin cậy', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1881, '口�', 'k�uq�', 'khẩu kh�, giọng n�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1902, '�9�', 'l�n', 'ngĒn cản, chặn', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1909, '謁', 'lǎo', 'gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1937, '栏�:�', 'l�nm�', 'chuy�n mục', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1951, '累', 'l�i', 'm�!t', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1960, '礼�9S', 'lǐb�i', 'l�&, tuần l�&', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1844, '可口', 'k�:k�u', 'ngon mi�!ng, vừa mi�!ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1845, '可蒽', 'k�:n�ng', 'c� thỒ, c� lẽ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1846, '可�"', 'k�:p�', '��ng sợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1847, '可�S', 'k�:li�n', '��ng thương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1861, '�&9�S�', 'k�f�', 'vượt qua, khắc phục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1862, '客�Ʒ', 'k�h�', 'kh�ch h�ng', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1864, '��:�', 'k�m�', 'khoa, m�n, m�n học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1865, '��', 'k�:n', 'gặm, ria', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1866, '��定', 'k�:nd�ng', 'khẳng ��9nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1867, '�', 'k�ng', 'h�, l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1868, '恳��!', 'k�:nqi�', 'tha thiết, khẩn thiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1869, '客人', 'k�r�n', 'kh�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1870, '可�S', 'k�:xī', '��ng tiếc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1872, '�学', 'k�xu�', 'khoa học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1873, '可以', 'k�:yǐ', 'c� thỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1874, '�', 'k�ng', 'l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1875, '恐�"', 'k�ngp�', 'e rằng, sợ rằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1876, '恐�', 'k�ngb�', 'khủng b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1877, '控�ƶ', 'k�ngzh�', 'kiỒm so�t, kh�ng chế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1878, '空', 'kōng', 'r�ng, tr�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1879, '空�', 'kōngq�', 'kh�ng kh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1880, '口', 'k�u', 'mi�!ng, khẩu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1882, '口语', 'k�uy�', 'khẩu ngữ, tiếng n�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1883, '��', 'kū', 'kh�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1884, '�9�', 'k�', 'kh�", �ắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1886, '跨', 'ku�', 'bư�:c d�i, xo�i bư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1887, '快', 'ku�i', 'nhanh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1888, '快乐', 'ku�il�', 'vui vẻ, sung sư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1889, '筷子', 'ku�izi', '�ũa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1890, '宽', 'kuān', 'r�"ng, khoan dung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1891, '款�&', 'kuǎnd�i', 'khoản ��i, chi�u ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1892, '� 架', 'ku�ngji�', 'khung, sườn, d�n gi�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1893, '�x��0水', 'ku�ngqu�nshuǐ', 'nư�:c kho�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1894, '� ��', 'ku�ngqi�:', 'vả lại, hơn nữa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1896, '�:�难', 'k�nn�n', 'kh� khĒn, tr�x ngại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1897, '�0�大', 'ku�d�', 'm�x r�"ng, khuếch trương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1898, '�0��&&', 'ku�chōng', 'khuếch t�n, lan r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1899, '�0��"', 'ku�zhǎn', 'ph�t triỒn, m�x r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1900, '�90', 'lā', 'k�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1901, '辣�', 'l�jiāo', '�:t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1903, '��', 'l�n', 'xanh lam', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1904, '�', 'l�n', 'n�t, th�i rữa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1905, '�!', 'lǎn', 'lười biếng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1906, '�9�', 'l�ng', 'ch� s�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1907, '浪费', 'l�ngf�i', 'l�ng ph�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1908, '浪漫', 'l�ngm�n', 'l�ng mạn', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1911, '謁�"��', 'lǎobǎix�ng', 'd�n thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1912, '謁��', 'lǎoshī', 'gi�o vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1913, '謁鼠', 'lǎosh�', 'chu�"t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1914, '宽�"�', 'kuānchǎng', 'r�"ng l�:n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1915, '宽带', 'kuānd�i', 'bĒng th�ng r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1916, '潰', 'ku�', 'hủy hoại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1917, '�9�恼', 'k�nǎo', '�au kh�", kh�" n�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1918, '�9�涩', 'k�s�', '�ắng ch�t', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1920, '�', 'k�', 'kho', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1921, '裤子', 'k�zi', 'quần', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1922, '�', 'ku�i', 'miếng, vi�n, b�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1923, '� ', 'k�n', 'b�, bu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1924, '� �', 'k�nbǎng', 'tr�i, bu�"c, r�ng bu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1925, '�:��"�', 'k�nch�ng', 'c�n tr�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1926, '�0�', 'ku�', 'm�x r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1927, '�0�张', 'ku�zhāng', 'm�x r�"ng, b�nh trư�:ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1928, '来', 'l�i', '�ến, t�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1929, '来不及', 'l�ib�j�', 'kh�ng k�9p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1930, '来�及', 'l�id�j�', 'k�9p thời', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1931, '来� ', 'l�il�', 'lai l�9ch, ngu�n g�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1932, '来源', 'l�iyu�n', 'ngu�n g�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1933, '来�!�', 'l�iz�', '�ến từ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1935, '�9��9�', 'l�ngb�i', 'nhếch nh�c, chẳng ra l�m sao cả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1936, '�S读', 'lǎngd�', '�ọc to, �ọc di�&n cảm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1938, '劳动', 'l�od�ng', 'lao ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1939, '謁�"�', 'lǎoh�', 'con h�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1940, '謁实', 'lǎosh�', 'thật th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1941, '謁� ', 'lǎop�', 'vợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1943, '謁� 忒', 'lǎopoxīn', 'l�ng nh�n từ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1944, '謁人', 'lǎor�n', 'người gi�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1945, '�S��:', 'l�zh�', 'c�y nến, nến', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1946, '�9', 'l�i', 'bu�"c, tr�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1947, '� ', 'le', 'r�i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1948, '乐�', 'l�guān', 'lạc quan', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1949, '�:�', 'l�i', 'sấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1950, '类', 'l�i', 'loại, thỒ loại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1952, '�:�达', 'l�id�', 'radar', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1953, '类似', 'l�is�', 'na n�, tương tự, gi�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1954, '� �', 'l�:ng', 'lạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1955, '� �淡', 'l�:ngd�n', 'lạnh nhạt, l�nh �ạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1956, '� ��"', 'l�:ngj�ng', 'vắng vẻ, y�n tĩnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1958, '�!R', 'lǐ', 'trong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1959, '�!R边', 'lǐbiān', 'b�n trong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1961, '礼�', 'lǐji�', 'l�& nghi, ph�p l�9ch sự', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1962, '礼�R', 'lǐm�o', 'l�& ph�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1981, '��&', 'tǐli�n', 'r�n luy�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2031, '� �"�', 'lǐzh�', 'l� tr�', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1979, '连年', 'li�nni�n', 'li�n tục nhiều nĒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2008, '�9�', 'l�tǐ', 'lập thỒ', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1963, '礼�0�', 'lǐw�', 'qu�, l�& vật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2052, '论�!', 'l�nw�n', 'luận vĒn', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2055, '落后', 'lu�h�u', 'lạc hậu, rơi lại ph�a sau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2057, '落实', 'lu�sh�', '�ầy �ủ chu ��o, l�m cho chắc chắn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1964, '礼�', 'lǐt�ng', 'l�& �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1965, '�9�S�', 'l�chǎng', 'lập trường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1966, '�9��', 'l�fāng', 'h�nh lập phương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1967, '�Ʃ害', 'l�h�i', 'lợi hại, gh� g�:m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1968, '�9即', 'l�j�', 'ngay lập tức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1969, '�Ʃ�:�', 'l�y�', 'lợi �ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1971, '�9�ƻ', 'l�k�', 'ngay lập tức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1972, '粮�x', 'li�ngshi', 'thức Ēn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1973, '�0�忒', 'li�ngxīn', 'lương t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1974, '���', 'li�nh�', 'li�n hi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1975, '�欢', 'li�nhuān', 'li�n hoan', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1976, '�0洁', 'li�nji�', 'trong sạch, li�m khiết', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1977, '�系', 'li�nlu�', 'li�n lạc, li�n h�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1978, '��:x', 'li�nm�ng', 'li�n minh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1980, '连��', 'li�nsu�', 'd�y chuyền, m�c n�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1982, '� 会', 'liǎngkuai', 'm�t mẻ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1984, '连系', 'li�nx�', 'li�n h�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1985, '绒习', 'li�nx�', 'luy�!n tập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1986, '绒�x', 'li�ngt�ng', 'luy�!n c�ng, r�n luy�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1987, '连续�0�', 'li�nx�j�', 'phim nhiều tập', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1988, '� 解', 'liǎoji�:', 'hiỒu r�, biết r�', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1989, '� 不起', 'liǎobuqǐ', 't�i ba, giỏi lắm', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1991, '�"', 'li�o', 'nguy�n li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1992, '�"� ', 'li�olǐ', 'nấu Ēn, quản l�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1993, '��车', 'li�ch�', 'xe lửa, t�u hỏa', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1994, '��士', 'li�sh�', 'li�!t sĩ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1996, '����', 'li�y�n', 'ngọn lửa dữ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1997, '�:�', 'l�qi', 'sức lực', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1998, '� �xx', 'lǐngy�', 'lĩnh vực', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1999, '���&', 'l�njū', 'h�ng x�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2000, '�9浴', 'l�ny�', 'tắm v�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2001, '临��', 'l�nsh�', 'tạm thời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2003, '�9�', 'l�r�', 'v� dụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2004, '�Ʃ润', 'l�r�n', 'lợi nhuận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2005, '� 史', 'l�shǐ', 'l�9ch sử', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2006, '� �0����', 'lǐsu�dāngr�n', 'tất nhi�n', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2009, '�:�:�', 'l�t�', 'mưu cầu, gắng �ạt �ược', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2010, '�""', 'li�', '�x lại, lưu lại, giữ lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2011, '流', 'li�', 'chảy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2012, '�', 'hu�', 'trượt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2013, '流传', 'li�chu�n', 'lưu truyền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2014, '浏��', 'li�lǎn', 'xem lư�:t qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2015, '流浪', 'li�l�ng', 'lang thang, lưu lạc', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2016, '流泪', 'li�l�i', 'chảy nư�:c mắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2017, '流�!�', 'li�li�ng', 'lưu lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2018, '�""�9', 'li�li�n', 'lưu luyến, kh�ng mu�n rời xa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2019, '流�S�', 'li�l�', 'b�"c l�", th�" l�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2020, '流�', 'li�m�ng', 'lưu manh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2022, '�""��', 'li�y�', 'lưu �, �Ồ � cẩn thận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2023, '流鬚', 'li�tōng', 'lưu th�ng, tho�ng, kh�ng b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2024, '流�R', 'li�x�ng', 'th�9nh h�nh, lưu h�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2025, '�""学', 'li�xu�', 'du học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2026, '�9�', 'l�w�i', 'ngoại l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2027, '� 撳', 'lǐxiǎng', 'l� tư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2028, '�Ʃ息', 'l�xī', 'l�i, lợi tức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2029, '�Ʃ��', 'l�y�ng', 'lợi dụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2030, '� ��', 'lǐy�u', 'l� do', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2033, '�9足', 'l�z�', '�ứng ch�n, ch� dựa, ch� �ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2034, '�"', 'l�ng', 'con r�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2035, '�9�', 'l�ng yǎ', 'người c�m �iếc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2036, '���', 'l�ngdu�n', 'lũng �oạn, ��"c quyền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2037, '� �!�', 'l�ngzh�ng', 'long trọng, linh ��nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2038, '漏', 'l�u', 'r� r�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2039, '�', 'l�u', '�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2040, '楼', 'l�u', 'lầu, tầng', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2041, '�S�', 'l�', 'sương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2042, '绿', 'l�S', 'xanh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2043, '�" 续', 'l�x�', 'lần lượt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2044, '乱', 'lu�n', 'l�"n x�"n, bừa b�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2045, '屡次', 'lǚc�', 'nhiều lần, li�n tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2046, '掠夺', 'l��du�', 'cư�:p �oạt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2047, '�"�微', 'l��w�i', 'hơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2049, '轮�', 'l�nku�', '�ường viền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2050, '轮流', 'l�nli�', 'thay phi�n nhau', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2051, '论�:', 'l�nt�n', 'di�&n ��n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2053, '论证', 'l�nzh�ng', 'luận chứng, chứng minh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2054, '落�Ɛ', 'lu�ch�ng', 'ho�n th�nh, kh�nh th�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2056, '鬻�', 'lu�j�', 'logic', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2058, '螺丝�0', 'lu�sīdīng', '�inh �c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2059, '�"���', 'luōsuo', 'lắm lời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2061, '�"�', 'l�q�', 'tuyỒn chọn, nhận v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2062, '�9��', 'l�Sshī', 'luật sư', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2063, '�&�R', 'lǚx�ng', 'thực hi�!n, thực thi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2064, '�"�x�', 'l�yīn', 'ghi �m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2065, '�&游', 'lǚy�u', 'du l�9ch', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2066, '�0灶', 'l�z�o', 'bếp l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2067, '�', 'ma', '�, ư', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2069, '马', 'mǎ', 'ngựa', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2081, '����', 'māma', 'mẹ', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2082, '麻�S�', 'm�m�', 't�', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2093, '�&�欧', 'm�nx�ng', 'm�n t�nh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2106, '码头', 'mǎt�u', 'bến t�u', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2124, '�S语', 'm�y�', 'c�u ��', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2070, '麻', 'm�', 'gai, t�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2072, '麻璦', 'm�fan', 'l�m phiền, phiền h�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2073, '马�"�', 'mǎhu', 'qua loa, �ại kh�i, tạm tạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2074, '�', 'm�i', 'b�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2075, '��', 'm�i', '�i bư�:c d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2076, '买', 'mǎi', 'mua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2077, '�0搏', 'm�ib�', 'mạch', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2078, '�x9伏', 'm�if�', 'mai phục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2079, '麦�&9风', 'm�ik�f�ng', 'microphone', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2083, '�&�', 'm�n', 'chậm, từ từ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2084, '满', 'mǎn', '�ầy, chất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2085, '漫�"�', 'm�nch�ng', 'd�i dằng dặc, d�i �ằng �ẵng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2086, '�"', 'm�ng', 'bận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2087, '�"�R', 'm�ngl�', 'bận r�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2088, '�R��R�', 'm�ngm�ng', 'm�nh m�ng, m�9t m�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2089, '�:��:�', 'm�ngm�', 'm� qu�ng', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2091, '漫��', 'm�nhu�', 'hoạt họa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2092, '�头', 'm�ntou', 'm�n thầu, b�nh bao kh�ng nh�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2094, '�延', 'm�ny�n', 'lan tr�n, lan ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2095, '满��', 'mǎny�', 'h�i l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2096, '�x9欨', 'm�nyu�n', 'o�n tr�ch, o�n hận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2097, '满足', 'mǎnz�', 'thỏa m�n, l�m thỏa m�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2098, '�:', 'm�o', 'l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2099, '�R�', 'māo', 'm�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2101, '�x:�:�', 'm�od�n', 'm�u thuẫn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2102, '� �"�', 'm�oxiǎn', 'mạo hiỒm, phi�u lưu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2103, '贸��', 'm�oy�', 'bu�n b�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2104, '帽子', 'm�ozi', 'mũ', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2105, '马上', 'mǎsh�ng', 'ngay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2107, '麻� 0', 'm�zu�', 'g�y t�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2108, '枚', 'm�i', 'c�i, tấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2109, '没', 'm�i', 'chưa, kh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2110, '每', 'm�:i', 'm�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2111, '美', 'm�:i', '�ẹp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2113, '美满', 'm�:imǎn', 'cu�"c s�ng �ầy �ủ, �ầm ấm, mỹ m�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2114, '�S0�:', 'm�im�o', 'l�ng m�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2115, '��', 'm�itǐ', 'truyền th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2116, '美容', 'm�:ir�ng', 'l�m �ẹp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2117, '美�S�', 'm�:ish�', 'mỹ thuật', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2118, '美��', 'm�:iw�i', 'ngon mi�!ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2119, '美�&�', 'm�:iyu�n', '�� la Mỹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2120, '妹妹', 'm�imei', 'em g�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2121, '�&�:', 'm�il�', 'sức quyến rũ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2122, '��', 'm�n', 'cửa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2125, '没�"', 'm�izh�', 'bế tắc, ch�9u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2126, '梦', 'm�ng', 'm�"ng, giấc mơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2127, '�R:', 'm�:ng', 'dữ d�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2128, '�R:��', 'm�:ngli�', 'dữ d�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2129, '梦撳', 'm�ngxiǎng', 'giấc mơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2130, '�R芽', 'm�ngy�', 'mầm, ch�i non', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2131, '��诊', 'm�nzh�:n', 'ph�ng kh�m b�!nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2132, '米', 'mǐ', 'gạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2133, '�S�', 'mī', 'ch�:p mắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2134, '面对', 'mi�n du�', '��i mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2135, '面�R&', 'mi�nbāo', 'b�nh m�', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2136, '�&��', 'miǎnde', '�Ồ tr�nh', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2138, '�0花', 'mi�nhuā', 'b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2139, '�90励', 'miǎnl�', 'khuyến kh�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2140, '面临', 'mi�nl�n', '��i mặt v�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2141, '�90强', 'miǎnqi�ng', 'gượng gạo, mi�&n cưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2142, '面条', 'mi�nti�o', 'm�', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2143, '面子', 'mi�nzi', 'mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2144, '描� "', 'mi�oxi�:', 'mi�u tả', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2145, '弥补', 'm�b�', 'b� �ắp, �ền b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2146, '� 度', 'm�d�', '��" d�y, mật ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2147, '�� ', 'mi�sh�', 'khinh mi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2148, '灭亡', 'mi�w�ng', 'chết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2149, '� 封', 'm�f�ng', 'ni�m phong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2151, '迷�', 'm�hu�', 'm� hoặc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2152, '迷路', 'm�l�', 'lạc �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2153, '� 码', 'm�mǎ', 'mật m�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2154, '迷�R�', 'm�m�ng', 'm� m�9t, mờ m�9t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2155, '��� ', 'm�m�', 'b� mật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2156, '�"��x', 'mǐngǎn', 'nhạy cảm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2157, '�܎�"�', 'm�ngbai', 'r� r�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2158, '名次', 'm�ngc�', 'thứ tự', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2160, '名�0��&�实', 'm�ngf�q�sh�', '��ng sự thật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2161, '��令', 'm�ngl�ng', 'm�!nh l�!nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2162, '�܎�܎', 'm�ngm�ng', 'r� r�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2163, '��名', 'm�ngm�ng', '�ặt t�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2164, '名�0R', 'm�ngp�i', 'thương hi�!u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2165, '�܎�ܾ', 'm�ngxiǎn', 'r� r�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2166, '�܎信�0!', 'm�ngx�npi�n', 'bưu thiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2167, '名�0', 'm�ngy�', 'danh dự', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2168, '名�', 'm�ngzi', 't�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2170, '�"�捷', 'mǐnji�', 'nhanh nhẹn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2171, '�"���', 'mǐnru�', 'sắc sảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2172, '���', 'm�ny�ng', 'd�n dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2173, '�主', 'm�nzh�', 'd�n chủ', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2174, '���', 'm�nz�', 'd�n t�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2175, '� ��!', 'm�qi�', 'mật thiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2176, '迷人', 'm�r�n', 'cu�n h�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2178, '��书', 'm�shū', 'thư k�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2179, '迷信', 'm�x�n', 'm� t�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2233, '捏', 'ni�', 'nh�n, nhặt, cầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2242, '女士', 'nǚsh�', 'c�, ch�9, b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2251, '����', 'nǎr', 'ch� n�o, ��u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2189, '模式', 'm�sh�', 'kiỒu mẫu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2236, '�0:', 'ni�', 'tr�u, b�', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2213, '难�S9', 'n�nk�n', 'xấu x�', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2221, '馁', 'n�:i', 'nản ch�', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2225, '蒽干', 'n�ngg�n', 't�i giỏi, giỏi giang', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2227, '年', 'ni�n', 'nĒm', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2273, '�0:�裤', 'ni�zǎik�', 'quần jean', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2288, '�"吐', '�ut�', 'n�n mửa', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2256, '嫩', 'n�n', 'mềm, non', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2262, '年度', 'ni�nd�', 'nĒm', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2180, '��', 'mō', 'm�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2182, '模仿', 'm�fǎng', 'bắt chư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2183, '�鬼', 'm�guǐ', 'ma quỷ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2184, '磨��', 'm�h�', 'chạy thử', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2185, '模糊', 'm�hu', 'mờ, mơ h�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2187, '����', 'm�m�', '�m thầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2188, '�"R�x', 'm�sh�ng', 'lạ', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2247, '派', 'p�i', 'ph�i, cử, ��t cử', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2190, '�0���', 'm�shī', 'mục sư', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2192, '模�9', 'm�x�ng', 'm� h�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2193, '�:��!', 'm�biāo', 'mục ti�u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2194, '�:��', 'm�d�', 'mục ��ch', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2195, '�:��&0', 'm�guāng', '�nh mắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2196, '�:��"', 'm�l�', 'mục lục', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2197, '母亲', 'm�qīn', 'mẹ', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2199, '模样', 'm�y�ng', 'd�ng dấp', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2200, '沐浴', 'm�y�', 'tắm g�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2201, '�9�', 'n�', 'cầm, lấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2202, '��', 'n�', 'kia, ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2203, '奶奶', 'nǎinai', 'b�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2205, '謐��', 'n�iy�ng', 'bền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2206, '纳����', 'n�m�n er', 'b�i r�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2207, '�', 'n�n', 'ph�a nam', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2208, '难', 'n�n', 'kh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2209, '难�', 'n�nd�o', 'lẽ n�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2210, '难�', 'n�nd�', 'kh� c� �ược', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2211, '难欪', 'n�ngu�i', 'thảo n�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2283, '女人', 'nǚr�n', 'con g�i, phụ nữ', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2214, '难�&�', 'n�nmiǎn', 'kh�ng tr�nh khỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2215, '难蒽可贵', 'n�nn�ngk�:gu�', '��ng khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2216, '��人', 'n�nr�n', '��n �ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2217, '难�', 'n�nsh�u', 'kh� ch�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2218, '��9', 'nǎodai', '�ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2220, '��', 'ne', 'thế, nh�0, vậy, nh�, cơ', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2249, '�:�子', 'p�nzi', '�ĩa, m�m, khay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2222, '� &', 'n�i', 'b�n trong, n�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2223, '� &容', 'n�ir�ng', 'n�"i dung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2224, '� &�', 'n�ik�', 'n�"i khoa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2226, '蒽�:', 'n�ngl�', 'nĒng lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2228, '年级', 'ni�nj�', 'l�:p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2229, '年纪', 'ni�nj�', 'tu�"i t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2231, '念', 'ni�n', 'nh�:, suy nghĩ, �ọc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2232, '�x', 'niǎo', 'chim', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2234, '宁可', 'n�ngk�:', 'th� rằng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2235, '宁��', 'n�ngyu�n', 'th�, th� rằng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2237, '� S�', 'n�ngm�n', 'n�ng d�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2239, '�', 'n�ng', '�ặc, �ậm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2240, '��R', 'nuǎnhuo', 'ấm �p', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2241, '女��', 'nǚ�"�r', 'con g�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2243, '�"', 'p�', 'sợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2244, '�9�', 'pāi', 'v�, �ập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2245, '�', 'p�i', 'h�ng, xếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2246, '�0R', 'p�i', 'thẻ, bảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2250, '�Ƥ��', 'p�ndu�n', 'ph�n �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2252, '�9��09', 'n�sh�u', 's�x trường, t�i nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2253, '� &涵', 'n�ih�n', 'n�"i h�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2254, '� &�"', 'n�im�', 'n�"i t�nh, t�nh h�nh b�n trong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2255, '� &�S�', 'n�iz�i', 'b�n trong, n�"i tại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2257, '蒽', 'n�ng', 'c� thỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2259, '蒽源', 'n�ngyu�n', 'ngu�n nĒng lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2260, '你', 'nǐ', 'anh, ch�9, �ng, b�⬦', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2261, '年代', 'ni�nd�i', 'ni�n �ại, thời �ại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2263, '年轻', 'ni�nqīng', 'trẻ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2264, '�9x定', 'nǐd�ng', '��9nh ra, vạch ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2265, '��', 'n�n', 'ng�i, �ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2266, '宁', 'n�ng', 'y�n, tĩnh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2268, '�!��', 'n�ngji�', 'ngưng tụ, ��ng lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2269, '�!�� ', 'n�ngsh�', 'nh�n ch�ng chọc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2270, '宁�"', 'n�ngj�ng', 'y�n tĩnh, b�nh lặng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2271, '纽�0���', 'ni�k�ur', 'c�c �o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2272, '�0:奶', 'ni�nǎi', 'sữa b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2274, '�0�转', 'ni�zhuǎn', 'xoay, quay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2275, '�', 'n�ng', 'l�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2276, '� S�', 'n�ngcūn', 'n�ng th�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2277, '� S夫', 'n�ngfū', 'n�ng d�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2278, '� S� ', 'n�ngl�', '�m l�9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2280, '奴隶', 'n�l�', 'n� l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2281, '努�:', 'n�l�', 'c� gắng, n� lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2282, '�R�', 'nu�', 'di chuyỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2284, '��', '�', 'hừ, hả', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2285, '欧�0', 'ōudǎ', '��nh nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2286, '偶�', '�u�"�:r', 'th�0nh thoảng, ngẫu nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2287, '偶��', '�ur�n', 't�nh cờ, ngẫu nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2290, '派对', 'p�idu�', 'ti�!c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2291, '���', 'p�if�ng', 'thải ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2292, '���', 'p�ich�', 'b�i x�ch, b�i b�c', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2293, '��"�', 'p�ich�', 'loại trừ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2304, '�:��9', 'p�nxu�n', 'quanh quẩn, luẩn quẩn', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2315, '�: ', 'p�n', 'chậu, b�n', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2321, '�S9�9', 'p�ngy�u', 'bạn, bạn b�', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2322, '�R�', 'pǐ', 'con (ngựa, la...)', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2341, '平�0', 'p�ngd�:ng', 'b�nh �ẳng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2347, '�估', 'p�nggū', '��nh gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2361, '���R', 'pǐnx�ng', 'hạnh kiỒm', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2366, '皮�9', 'p�xi�', 'gi�y da', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2398, '�&�', 'qiānbǐ', 'b�t ch�', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2295, '���', 'p�ili�', 'sắp xếp, sắp �ặt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2296, '派遣', 'p�iqiǎn', 'cử, ph�i, �iều ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2297, '派琒', 'p�iqi�', 'b�ng chuyền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2298, '�:�', 'p�n', '�ĩa, m�m, khay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2299, '�', 'p�ng', 'b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2300, '�:��S:', 'p�nw�ng', 'mong mỏi, tr�ng chờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2301, '�Ƥ', 'p�n', 'ph�n quyết, kết �n', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2303, '庞大', 'p�ngd�', 'to l�:n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2305, '�', 'pǎo', 'chạy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2306, '�步', 'pǎob�', 'chạy b�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2307, '�:弒', 'pāoq�', 'vứt bỏ, quĒng �i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2308, '�Ƭ山', 'p�shān', 'leo n�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2309, '�"�', 'p�i', 'dẫn dắt, c�ng �ưa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2310, '�&��!', 'p�ib�i', 'ph�n ph�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2312, '�&��', 'p�it�o', '��ng b�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2313, '�x�训', 'p�ix�n', 'b�i dưỡng, ��o tạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2314, '�x��&�', 'p�iyǎng', 'r�n luy�!n, b�i dưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2316, '�: �S�', 'p�nd�', 'thung lũng, l�ng chảo', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2317, '� �蒬', 'p�ngzh�ng', 'b�nh trư�:ng, ph�nh to', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2318, '碰', 'p�ng', '�ụng, va', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2319, '碰见', 'p�ngji�n', 'gặp', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2320, '璹饪', 'p�ngr�n', 'nấu Ēn', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2323, '�0�', 'pī', 'b�, chẻ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2324, '�0��', 'pīfā', 'b�n s�0', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2326, '�0��! ', 'pīzh�n', 'ph� chuẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2327, '��撫', 'p�b�i', 'ki�!t qu�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2328, '皮', 'p�', 'da', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2329, '皮��', 'p�fū', 'da', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2330, '屁��', 'p�gu', 'm�ng, ��t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2331, '�"��&', 'p�ji�', 'bia', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2332, '��劳', 'p�l�o', 'm�!t mỏi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2334, '��尝', 'pǐnch�ng', 'nếm, thử', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2335, '��', 'p�nd�o', 'k�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2336, '��德', 'pǐnd�', '�ạo �ức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2337, '贫乏', 'p�nf�', 'ngh�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2338, '�繁', 'p�nf�n', 'thường xuy�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2339, '平', 'p�ng', 'dựa v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2340, '平常', 'p�ngch�ng', 'th�ng thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2342, '平�!�', 'p�ngf�n', 'b�nh thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2344, '�价', 'p�ngji�', '��nh gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2345, '�9��S', 'p�nggu�', 'quả t�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2346, '平衡', 'p�ngh�ng', 'c�n bằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2348, '平�"', 'p�ngj�ng', 'y�n lặng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2349, '�论', 'p�ngl�n', 'b�nh luận, nhận x�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2350, '平面', 'p�ngmi�n', 'mặt bằng, mặt phẳng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2351, '��琒', 'pīngpāngqi�', 'b�ng b�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2353, '平坦', 'p�ngtǎn', 'bằng phẳng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2354, '平�R', 'p�ngx�ng', 'song song', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2355, '平�x', 'p�ngyu�n', '��ng bằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2356, '屏�S', 'p�ngzh�ng', 'r�o chắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2357, '��子', 'p�ngzi', 'lọ, b�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2358, '贫穷', 'p�nqi�ng', 'ngh�o n�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2359, '��!', 'p�nl�S', 'tần s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2360, '����', 'pǐnw�i', 'khiếu thẩm mỹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2362, '��质', 'pǐnzh�', 'chất lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2363, '��种', 'pǐnzh�ng', 'gi�ng, loại, chủng loại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2365, '譬�', 'p�r�', 'v� dụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2367, '泼', 'pō', 'hắt, gi�"i, vẩy (nư�:c)', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2368, '迫', 'p�', 'vỡ, thũng, ph� vỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2369, '破', 'p�', 'sườn d�c, d�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2370, '�!', 'pō', 'rất, tương ��i, kh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2371, '迫不及�&', 'p�b�j�d�i', 'kh�ng thỒ chờ �ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2372, '破产', 'p�chǎn', 'ph� sản', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2373, '破坏', 'p�hu�i', 'ph� hoại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2374, '破�', 'p�li�', 'ph� vỡ, nứt vỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2375, '��:', 'p�l�', 'ki�n quyết, quyết �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2376, '迫��!', 'p�qi�', 'bức thiết, cấp b�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2377, '��', 'pū', 'trải, dọn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2378, '�"�遍', 'p�bi�n', 'ph�" biến, r�"ng r�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2379, '�"�及', 'p�j�', 'th�9nh h�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2381, '� 人', 'p�r�n', '�ầy t�:', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2382, '�S�素', 'p�s�', 'giản d�9, m�"c mạc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2383, '�"�鬚话', 'p�tōnghu�', 'tiếng ph�" th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2384, '丒', 'qī', 'bảy', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2385, '卡', 'qiǎ', 'kẹt, v�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2386, '恰�', 'qi�d�ng', 'th�ch hợp, thỏa ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2387, '恰�ư好�', 'qi�d�ohǎoch�', '��ng d�9p, ��ng mục ��ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2388, '��', 'qi�n', 'tiền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2389, '�&', 'qiǎn', 'n�ng, nhạt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2391, '�0�提', 'qi�nt�', 'tiền �ề', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2392, '�S�:', 'qi�nl�', 'tiềm nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2393, '�S水', 'qi�nshuǐ', 'lặn', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2394, '签', 'qiān', 'k�', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2395, '签订', 'qiānd�ng', 'k� kết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2399, '卒���"�计', 'qiānfāngbǎij�', 'tất cả mọi thủ �oạn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2400, '�"', 'qi�ng', 'tường, bức tường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2401, '抢', 'qiǎng', 'cư�:p lấy, v� lấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2402, '抢夺', 'qiǎngdu�', 'cư�:p lấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2405, '强��', 'qi�ngli�', 'mạnh mẽ', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2437, '起�Ɲ', 'qǐchǐ', 'l�c �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2420, '�0�头', 'qiānt�u', '�ứng �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2451, '请�', 'qǐngqi�', 'y�u cầu, xin', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2468, '�', 'qīng', 'm�u xanh, thanh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2479, '请�""', 'qǐngjiāo', 'th�0nh gi�o, xin ch�0 bảo', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2495, '� 祝', 'q�ngzh�', 'ch�c mừng', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2503, '亲身', 'qīnsh�n', 'bản th�n, tự m�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2403, '抢劫', 'qiǎngji�', 'cư�:p t�i sản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2404, '强谒', 'qi�ngdi�o', 'nhấn mạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2406, '强迫', 'qiǎngp�', '�p bu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2407, '强�ƶ', 'qi�ngzh�', 'cưỡng chế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2408, '抢�"', 'qiǎngji�', 'cứu gi�p', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2410, '谦�"�', 'qiānxū', 'khi�m t�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2411, '�0�面', 'qi�nmi�n', 'ph�a trư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2412, '�0��', 'qi�nt�', 'tương lai, triỒn vọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2413, '�0��:', 'qi�nj�n', 'tiến l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2414, '谦鬊', 'qiānx�n', 'khi�m nhường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2415, '谴责', 'qiǎnz�', 'l�n �n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2416, '欠', 'qi�n', 'nợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2417, '�R�&�', 'qi�nr�', 'nh�ng v�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2418, '�0��R', 'qiāngu�', 'lo lắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2421, '迁就', 'qiānji�', 'nh�n nhượng, cả nỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2422, '迁移', 'qiāny�', 'di chuyỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2423, '谦让', 'qiānr�ng', 'nhường nh�9n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2424, '�S移���R', 'qiāny�m�hu�', 'thay ��"i m�"t c�ch v� tri v� gi�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2425, '�0��ƶ', 'qiānzh�', 'kiềm chế, h�m chứa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2426, '签�', 'qiānzi', 'k� t�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2427, '桥', 'qi�o', 'c�y cầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2428, '瞧', 'qi�o', 'nh�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2429, '�', 'qi�o', 'v�nh, vỒnh, bảnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2430, '�"�', 'qiāo', 'g�, khua, bật dậy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2431, '巧�&9�:', 'qiǎok�l�', 's� c� la', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2432, '巧�"', 'qiǎomi�o', 'kh�o l�o, t�i t�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2433, '��', 'qiāoqiāo', 'lặng lẽ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2435, '洽��', 'qi�t�n', 'tr� chuy�!n, b�n luận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2436, '�"�材', 'q�c�i', 'kh� t�i, dụng cụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2438, '启�9', 'qǐch�ng', 'kh�xi h�nh, l�n �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2439, '起床', 'qǐchu�ng', 'ngủ dậy', NULL, 39);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2440, '�&�次', 'q�c�', 'thứ hai, tiếp ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2441, '�Sx�&', 'q�d�i', 'kỳ vọng, mong �ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2442, '���R不�ƍ', 'qǐ''�rb�sh�:', 'ki�n nhẫn, mi�!t m�i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2444, '启�', 'qǐfā', 'gợi �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2445, '起飞', 'qǐf�i', 'cất c�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2446, '起伏', 'qǐf�', 'kh�ng kh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2447, '起句', 'qǐj�', 'nhập nho, l�n xu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2449, '起海', 'qǐh�i', 'kh� kh�i, kh� ph�ch', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2450, '请', 'qǐng', 'xin, mời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2452, '��x', 'q�gōng', 'kh� c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2453, '�!欪', 'q�gu�i', 'kỳ lạ, qu�i lạ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2454, '�"���', 'q�guān', 'cơ quan', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2455, '起�', 'qǐh�ng', '��a bỡn, giỡn cợt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2456, '��"', 'q�h�u', 'kh� hậu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2457, '�!迹', 'qǐj�', 'kỳ t�ch, kỳ c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2459, '�今为止', 'q�jīn w�izhǐ', 'cho �ến nay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2460, '起来', 'qǐl�i', '�ứng dậy, ng�i dậy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2461, '�!�!0', 'qǐli�ng', 'lạnh lẽo, ti�u �iều', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2462, '�!�"', 'q�mi�o', 'kỳ di�!u, tinh xảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2463, '亲�Ʊ', 'qīn''�i', 'th�n �i, thương y�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2464, '侵犯', 'qīnf�n', 'x�m phạm, can thi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2465, '�9��9', 'q�nf�n', 'si�ng nĒng, cần c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2466, '�"�', 'q�ng', 'trời nắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2467, '轻', 'qīng', 'nhẹ, nhẹ nh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2469, '�&', 'qīng', 'trong, sạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2470, '�&报', 'q�ngb�o', 't�nh b�o, th�ng tin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2471, '�&��', 'qīngch�', 'trong veo, trong su�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2472, '�&�"�', 'qīngch�n', 's�ng s�:m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2474, '��ܥ', 'qīngchūn', 'tu�"i trẻ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2475, '轻淡', 'qīngd�n', 'nhạt, lo�ng, nhẹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2476, '轻�R��举', 'qīng''�ry�jiǎo', 'd�& d�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2477, '请�!', 'qǐngji�', 'xin ngh�0', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2478, '请�x�', 'qǐngjiǎn', 'thi�!p mời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2480, '�&�', 'q�ngji�', 't�nh tiết, trường hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2481, '�&�"', 'qīngj�ng', 'y�n tĩnh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2482, '请客', 'qǐngk�', 'mời kh�ch, ��i kh�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2483, '�&� �', 'q�ngku�ng', 't�nh h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2484, '�"��S', 'q�nglǎng', 'nắng, trong s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2485, '�&� ', 'q�nglǐ', 'l� lẽ, �ạo l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2486, '�年', 'qīngni�n', 'thanh ni�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2488, '轻� ', 'qīngsh�', 'khinh thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2489, '轻松', 'qīngsōng', 'nhẹ nh�m, thoải m�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2490, '嬾听', 'qīngtīng', 'lắng nghe, ch� � nghe', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2491, '�&�"�', 'qīngxī', 'r� r�ng, r� r�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2492, '嬾�S', 'qīngxi�', 'nghi�ng, l�!ch, xi�u vẹo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2493, '�&� ', 'qīngxǐng', 't�0nh t�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2494, '�&绪', 'q�ngx�', 't�m trạng, cảm x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2496, '�9�俭', 'q�njiǎn', 'tiết ki�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2498, '侵�"�', 'qīnl��', 'x�m lược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2499, '��佩', 'qīnp�i', 'kh�m phục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2500, '亲�ƚ', 'qīnqī', 'th�n th�ch, người th�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2501, '亲��!', 'qīnqi�', 'th�n thiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2502, '亲璭', 'qīnre', 'th�n mật, n�ng nhi�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2504, '穷', 'qi�ng', 'ngh�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2520, '企业', 'qǐy�', 'x� nghi�!p', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2545, '璭�Ʊ', 'r��"�i', 'y�u nhi�!t th�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2555, '任�"', 'r�nh�', 'bất k�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2580, '荣�"�', 'r�ngd�ng', 'vinh danh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2512, '�&��"', 'q�y�', 'ngo�i ra, c�n lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2550, '璭忒', 'r�xīn', 'nhi�!t t�nh, s�t sắng', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2553, '仍��', 'r�ngr�n', 'vẫn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2564, '仍��', 'r�ngji�', 'như cũ, như trư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2505, '�袍', 'q�p�o', 'sườn x�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2506, '欺�', 'qīpi�n', 'lừa d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2508, '齐�&�', 'q�qu�n', '�ầy �ủ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2509, '��0�', 'q�s�', 'thần sắc, kh� sắc', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2510, '�&�实', 'q�sh�', 'kỳ thực, thực ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2511, '�势', 'q�sh�', 'kh� thế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2513, '企�:�', 'qǐt�', 'mưu ��, � ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2514, '琒迷', 'qi�m�', 'người h�m m�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2515, '���', 'q�w�i', 'm�i v�9', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2517, '�象', 'q�xi�ng', 'kh� tượng học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2518, '齐忒协�:', 'q�xīn xi�l�', '��ng t�m hi�!p lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2519, '��9', 'q�yā', '�p suất kh� quyỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2521, '起�0', 'qǐy�', 'kh�xi nghĩa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2522, '汽油', 'q�y�u', 'xĒng', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2523, '��S0此� ', 'qǐ y�u cǐ lǐ', 'lẽ n�o lại như vậy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2524, '起源', 'qǐyu�n', 'bắt ngu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2525, '�&�中', 'q�zhōng', 'trong s� ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2526, '妻子', 'qīzi', 'vợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2527, '娶', 'q�', 'lấy vợ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2528, '去�', 'q�sh�', 'qua �ời', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2530, '去年', 'q�ni�n', 'nĒm ngo�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2531, '群�', 'q�nzh�ng', 'quần ch�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2532, '�"子', 'q�nzi', 'v�y', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2533, '�9势', 'qūsh�', 'khuynh hư�:ng, xu thế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2534, '�:���', 'qūzh�', 'quanh co, kh�c khuỷu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2535, '驱鬐', 'qūzh�', 'trục xuất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2536, '�!�', 'r�n', 'nhu�"m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2538, '让', 'r�ng', 'nhường, mời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2539, '嚷', 'rǎng', 'k�u g�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2540, '让步', 'r�ngb�', 'nhượng b�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2541, '��后', 'r�nh�u', 'sau ��, tiếp ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2542, '�!�璧', 'r�nshāo', '��t ch�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2543, '�0�乱', 'rǎolu�n', 'quấy nhi�&u, h�n loạn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2544, '璭', 'r�', 'nhi�!t, n�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2546, '璭��', 'r�li�', 'nhi�!t li�!t, s�i n�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2547, '璭��', 'r�n�o', 'n�o nhi�!t, s�i n�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2548, '忍', 'r�:n', 'nhẫn, ch�9u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2551, '认� ', 'r�nshi', 'biết, nhận biết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2552, '任务', 'r�nwu', 'nhi�!m vụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2554, '�0', 'r�ng', 'n�m, quĒng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2556, '人', 'r�n', 'người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2557, '忍謐', 'r�:nn�i', 'ki�n nhẫn, nhẫn lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2558, '忍�', 'r�:nsh�u', 'ch�9u �ựng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2559, '璭身', 'r�sh�n', 'kh�xi ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2560, '璭水�"�', 'r�shuǐq�', 'b�nh nư�:c n�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2561, '璭�&', 'r�q�ng', 'nhi�!t t�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2563, '忍忒', 'r�:nxīn', 'nỡ l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2565, '���9', 'r�ch�ng', 'l�9ch tr�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2566, '���Sx', 'r�qī', 'ng�y th�ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2567, '��记', 'r�j�', 'nhật k�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2568, '������', 'r�y�ngpǐn', '�� d�ng hằng ng�y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2569, '荣�0', 'r�ngy�', 'vinh dự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2570, '容��', 'r�ngy�', 'd�& d�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2571, '容忍', 'r�ngr�:n', 'khoan dung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2572, '容�R', 'r�ngm�o', 'dung mạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2574, '容纳', 'r�ngn�', 'chứa �ựng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2575, '融�R', 'r�nghu�', 'tan chảy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2576, '容�"�', 'r�ngq�', '�� chứa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2577, '荣幸', 'r�ngx�ng', 'vinh hạnh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2579, '荣华�R贵', 'r�nghu� f�gu�', 'vinh hoa ph� qu�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2581, '荣謬', 'r�ngy�o', 'vinh quang', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2582, '荣� :', 'r�ngjūn', 'qu�n nh�n xuất ngũ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2583, '荣� �', 'r�ngyīng', '�ược vinh dự nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2584, '容�&0�"�', 'r�ngguāng hu�nfā', 'tươi s�ng, rạng rỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2585, '容身', 'r�ngsh�n', 'tr� th�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2586, '容不�9', 'r�ng b� xi�', 'kh�ng thỒ chấp nhận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2587, '人�0�', 'r�nc�i', 'người t�i nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2588, '仁�&�', 'r�nc�', 'nh�n từ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2589, '人�', 'r�nd�o', 'nh�n �ạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2590, '认定', 'r�nd�ng', 'cho rằng, nhận ��9nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2591, '人格', 'r�ng�', 'nh�n c�ch', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2592, '人工', 'r�ngōng', 'nh�n tạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2594, '人��', 'r�njiān', 'nh�n gian, thế gi�:i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2595, '人可', 'r�nk�:', 'cho ph�p, ��ng �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2596, '人口', 'r�nk�u', 'd�n s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2597, '人类', 'r�nl�i', 'nh�n loại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2598, '人�币', 'r�nm�nb�', 'nh�n d�n t�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2599, '任��', 'r�nm�ng', 'b�" nhi�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2600, '人�x', 'r�nsh�ng', '�ời s�ng, cu�"c �ời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2601, '人士', 'r�nsh�', 'nh�n sự', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2602, '人为', 'r�nw�i', 'con người l�m ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2603, '认为', 'r�nw�i', 'cho rằng, cho l�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2604, '人�0�', 'r�nw�', 'nh�n vật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2606, '任欧', 'r�nx�ng', 't�y hứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2607, '任��', 'r�ny�', 't�y �', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2608, '人��', 'r�nyu�n', 'nh�n vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2609, '认�Sx', 'r�nzh�n', 'chĒm ch�0, nghi�m t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2613, '鳒', 'sāi', 'mang c�', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2685, '�0�', 'sh�ng', 'thừa, c�n lại', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2620, '�0�', 'sānjiǎo', 'tam gi�c', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2624, '�"�', 'sh�', 'c�i g�', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2632, '�&�"�', 'sh�nch�ng', 'giỏi', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2645, '�" ��', 'shāngpǐn', 'h�ng h�a', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2672, '�影', 'sh�yǐng', 'nhiếp ảnh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2696, '声谒', 'sh�ngdi�o', 'thanh �i�!u, giọng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2702, '�x� ', 'sh�nglǐ', 'sinh l�', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2718, '绳子', 'sh�ngzi', 'd�y thừng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2611, '�', 'sǎ', 'rắc, tung, vẩy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2612, '�谎', 'sāhuǎng', 'n�i d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2674, '设撳', 'sh�xiǎng', 'tư�xng tượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2614, '伞', 'sǎn', '�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2615, '�0', 'sān', 'ba', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2617, '�"��', 's�nfā', 'toả ra, ph�t ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2618, '丧失', 's�ngshī', 'mất �i, mất m�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2619, '�子', 'sǎngzi', 'c�" họng, giọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2621, '�"��!', 'sǎnw�n', 'vĒn xu�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2623, '森�', 's�nl�n', 'rừng rậm, rừng s�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2625, '��', 'shǎ', 'ngu ng�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2626, '杬', 'shā', 'giết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2627, '�ƹ车', 'shāch�', 'phanh, thắng xe', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2628, '�"�', 'shāfā', 'ghế x�-pha', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2629, '�"', 'sh�i', 'phơi nắng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2631, '�"漠', 'shām�', 'sa mạc', NULL, 29);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2633, '�Ơ�"�', 'shānch�', 'x�a bỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2634, '����', 'shǎndi�n', 'tia ch�:p, s�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2635, '上', 'sh�ng', 'tr�n, ph�a tr�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2636, '伤��9', 'shāng nǎojīn', 'hại n�o, t�n t�m tr�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2637, '上班', 'sh�ngbān', '�i l�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2638, '�" �!', 'shāngbiāo', 'thương hi�!u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2639, '上�', 'sh�ngd�ng', 'b�9 lừa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2640, '�" �', 'shāngdi�n', 'cửa h�ng', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2642, '上课', 'sh�ngk�', 'học, l�n l�:p', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2643, '上�:忒', 'sh�ngj�nxīn', 'ch� tiến thủ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2644, '�" �!�', 'shāngli�ng', 'thương lượng, b�n thảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2646, '上任', 'sh�ngr�n', 'nhậm chức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2647, '上�', 'sh�ngwǎng', 'l�n mạng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2648, '上��', 'sh�ngw�', 'bu�"i s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2649, '伤忒', 'shāngxīn', 'thương t�m, �au l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2650, '上学', 'sh�ngxu�', '�i học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2651, '上�ܾ', 'sh�ngyǐn', 'nghi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2652, '上游', 'sh�ngy�u', 'thượng du', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2654, '山�0', 'shānm�i', 'rặng n�i, d�y n�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2655, '��璁', 'shǎnshu�', 'nhấp nh�y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2656, '�于', 'sh�ny�', 'giỏi về', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2657, '�0!子', 'sh�nzi', 'c�i quạt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2658, '稍', 'shāo', 'hơi, m�"t ch�t, sơ qua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2659, '��', 'sh�o', '��n, trạm g�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2660, '�', 'shǎo', '�t, trẻ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2661, '捎', 'shāo', 'mang h�", mang gi�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2662, '璧', 'shāo', 'ngon', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2663, '稍微', 'shāow�i', 'hơi, m�"t ch�t, sơ qua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2664, '�9�子', 'sh�ozi', 'c�i mu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2665, '�"滩', 'shātān', 'b�i biỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2666, '�:!', 'sh�', 'con rắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2668, '�ƍ不�', 'sh�:bude', 'luyến tiếc, kh�ng nỡ', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2669, '��!�', 'sh�jī', 'bắn, xạ k�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2670, '设计', 'sh�j�', 'thiết kế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2671, '社会', 'sh�hu�', 'x� h�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2675, '伸', 'sh�n', 'cĒng ra, du�i ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2678, '��请', 'sh�n qǐng', 'xin', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2679, '深奥', 'sh�n�"�o', 's�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2680, '��报', 'sh�nb�o', 'tr�nh b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2681, '身材', 'sh�nc�i', 'v�c d�ng, d�ng người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2682, '审�x�', 'sh�:nch�', 'xem x�t, thẩm tra', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2683, '深�0', 'sh�nch�n', 's�u lắng', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2684, '身份', 'sh�nf�n', 'th�n phận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2686, '�::', 'sh�ng', 'chứa, �ựng, dung nạp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2687, '�S�', 'sh�:ng', 't�0nh, tinh lược, tiết ki�!m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2688, '�!', 'sh�ng', 'l�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2689, '�S�x', 'sh�ng f�', 'thắng bại, �ược thua', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2690, '�x��', 'sh�ng xi�', 'r�0 s�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2692, '�::产', 'sh�ngchǎn', 'sản xuất nhiều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2693, '�x产', 'sh�ngchǎn', 'sản xuất', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2694, '�0��"S', 'sh�ngch�', 'chĒn nu�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2695, '�x��', 'sh�ngc�n', 's�ng s�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2697, '�x动', 'sh�ngd�ng', 'sinh ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2698, '�S�会', 'sh�:nghu�', 'thủ phủ của t�0nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2699, '�x活', 'sh�nghu�', 'cu�"c s�ng, s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2700, '�x�S�', 'sh�ngjī', 'sức s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2701, '�::弬', 'sh�ngkāi', 'n�x hoa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2703, '�S��"�', 'sh�:ngl��', 'lược bỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2705, '�x��', 'sh�ngm�ng', 't�nh mạng, sinh mạng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2706, '�x�', 'sh�ngq�', 'giận, tức giận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2707, '深�&', 'sh�nq�ng', 'th�m t�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2708, '�x��', 'sh�ngr�', 'sinh nhật', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2709, '声势', 'sh�ngsh�', 'thanh thế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2710, '�x��', 'sh�ngshū', 'm�:i lạ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2711, '�x欁', 'sh�ngt�i', 'sinh th�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2712, '�x�0�', 'sh�ngw�', 'sinh vật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2713, '�x�"�', 'sh�ngxi�o', 'c� hi�!u lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2714, '�::�R', 'sh�ngx�ng', 'th�9nh h�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2716, '声�0', 'sh�ngy�', 'danh tiếng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2717, '�x��', 'sh�ngy�', 'sinh �ẻ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2720, '审��', 'sh�:nw�n', 'thẩm vấn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2725, '审�Ƥ', 'sh�:np�n', 'x�t xử', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2807, '�"�:�', 'sh�t�', 't�nh to�n, thử, ��9nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2820, '实��', 'sh�y�ng', 'sử dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2732, '�鬏', 'sh�nt�u', 'thấm thấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2737, '��', 'sh�q�', 'hấp thu, (dinh dưỡng)', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2755, '��常', 'sh�ch�ng', 'thường', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2758, '�代', 'sh�d�i', 'thế h�!', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2762, '���&0', 'sh�guāng', 'thời gian', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2769, '实撠', 'sh�hu�', 'lợi �ch thực tế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2776, '����', 'sh�jiān', 'thời gian', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2715, '声�x�', 'sh�ngyīn', 'tiếng, �m thanh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2721, '深�ƻ', 'sh�nk�', 's�u sắc', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2723, '审美', 'sh�:nm�:i', 'thẩm mỹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2724, '神��', 'sh�nm�', 'thần b�, b� ẩn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2778, '��"R', 'sh�ji�', 'thế gi�:i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2726, '神�', 'sh�nq�', 'thần sắc, thần kh�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2727, '深�&厚谊', 'sh�nq�ng h�uy�', 't�nh bạn th�n thiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2728, '神�0�', 'sh�ns�', 'thần sắc', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2729, '神�S�', 'sh�nsh�ng', 'thi�ng li�ng, thần th�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2730, '�&士', 'sh�nsh�', 'th�n sĩ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2784, '� �:', 'sh�l�', 'th�9 lực', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2733, '神�"', 'sh�nxiān', 'thần ti�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2734, '审讯', 'sh�:nx�n', 'thẩm vấn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2735, '���!�', 'sh�nzh�', 'thậm ch�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2736, '�&��!�', 'sh�nzh�ng', 'cẩn thận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2793, '��尚', 'sh�sh�ng', 'thời thượng, m�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2738, '社�R�', 'sh�qū', 'c�"ng ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2739, '�氏度', 'sh�sh�d�', '��" C', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2740, '��R头', 'sh�tou', 'lưỡi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2741, '设置', 'sh�zh�', 'thiết lập', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2742, '�9�', 'sh�', 'nhặt, m�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2743, '十', 'sh�', 'mười', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2744, '�ܯ', 'sh�', 'l�', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2745, '�"', 'sh�', 'thi', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2746, '使', 'shǐ', 'khiến, sai bảo, d�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2747, '�', 'shī', 'thơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2749, '十�� ', 'sh� f�n', 'v� c�ng, rất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2750, '失败', 'shīb�i', 'thất bại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2751, '势�&', 'sh�b�', 'tất phải, bu�"c phải', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2752, '� �ƫ', 'sh�bi�', 'ph�n bi�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2753, '士�&�', 'sh�bīng', 'binh l�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2754, '��差', 'sh�chā', 'sự ch�nh l�!ch thời gian', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2757, '��代', 'sh�d�i', 'thời kỳ, thời �ại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2814, '实习', 'sh�x�', 'tập luy�!n, thực tập', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2759, '���R', 'sh��"�r', '��i khi', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2818, '�"�R', 'sh�y�n', 'th� nghi�!m', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2761, '�!���', 'sh�f�ng', 'ph�ng th�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2795, '实�R', 'sh�y�n', 'thực nghi�!m, th� nghi�!m', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2763, '�ܯ否', 'sh�f�u', 'phải chĒng, hay kh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2764, '���&', 'shīfu', 'thợ cả, ch�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2765, '�9�"&', 'sh�g�', 'sự c�, tai nạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2766, '���', 'sh�h�', 'ph� hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2767, '���"', 'sh�hou', 'l�c, khi', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2770, '实�"&', 'sh�j�', 'thực tế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2771, '���S�', 'sh�jī', 'cơ h�"i, thời cơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2772, '�纪', 'sh�j�', 'thế k�0', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2773, '�9迹', 'sh�j�', 'sự t�ch, c�u truy�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2774, '��加', 'shījiā', 'g�y, l�m (�p lực, ảnh hư�xng)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2775, '实践', 'sh�ji�n', 'thực hi�!n, thực h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2777, '�9件', 'sh�ji�n', 'sự ki�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2780, '使劲��', 'shǐ j�n er', 'gắng sức, ra sức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2781, '�句', 'shīj�', 'b�i thơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2782, '���ƻ', 'sh�k�', 'thời khắc, thời gian', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2783, '实�:', 'sh�l�', 'sức mạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2785, '��髦', 'sh�m�o', 'thời trang', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2786, '失�S�', 'shīmi�n', 'mất ngủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2787, '使��', 'shǐm�ng', 'nhi�!m vụ, sứ m�!nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2788, '�x��', 'sh�pǐn', 'thực phẩm', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2789, '���Sx', 'sh�qī', 'thời k�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2791, '失去', 'shīq�', 'mất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2792, '湿润', 'shīr�n', 'ư�:t, ẩm ư�:t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2794, '失业', 'shīy�', 'thất nghi�!p', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2796, '�9业', 'sh�y�', 'sự nghi�!p, c�ng cu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2797, '实�R', 'sh�x�ng', 'thực hi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2798, '使��', 'shǐy�ng', 'sử dụng, d�ng v�o thực tế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2799, '���9', 'sh�sh�', 'thời sự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2800, '实��', 'sh�shī', 'thực hi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2801, '�9实', 'sh�sh�', 'sự thực', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2802, '鬝�', 'sh�sh�', 'chết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2804, '�9欁', 'sh�t�i', 't�nh thế, t�nh h�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2805, '尸�', 'shītǐ', 'thỒ thi, tử thi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2806, '�x�头', 'sh�tou', '��', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2808, '失�S:', 'shīw�ng', 'thất vọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2809, '示威', 'sh�w�i', 'th�9 uy, ra oai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2810, '�x�0�', 'sh�w�', 'thức Ēn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2811, '�9务', 'sh�w�', 'c�ng vi�!c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2813, '失误', 'shīw�', 'l�i lầm, sai lầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2815, '� 线', 'sh�xi�n', '�ường nh�n, tầm mắt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2816, '�9�&�', 'sh�xiān', 'trư�:c, trư�:c ti�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2817, '�9项', 'sh�xi�ng', 'hạng mục c�ng vi�!c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2819, '� �!�', 'sh�y�:', 'phạm vi nh�n, tầm nh�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2821, '��', 'sh�y�ng', 'th�ch ứng, hợp v�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2822, '失�9', 'shīli�n', 'thất t�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3037, '�积', 'tǐjī', 'thỒ t�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2833, '�', 'sh�', 'thẳng �ứng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2834, '书', 'shū', 's�ch', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2843, '涮火�&', 'shu�nhu�guō', 'lẩu nh�ng', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2845, '�R蒞蒎', 'shuāngbāotāi', 'anh em sinh ��i', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2861, '水�Ʃ', 'shuǐl�', 'thủy lợi', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2866, '书架', 'shūji�', 'gi� s�ch', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2871, '�"�码', 'sh�mǎ', 'kỹ thuật s�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2875, '顺�Ʃ', 'sh�nl�', 'thuận lợi', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2884, '属于', 'sh�y�', 'thu�"c về', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2887, '�::', 's�', 'b�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2824, '�09�0�', 'sh�uy�', 'tay nghề, kỹ thuật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2895, '欝謒', 'sīkǎo', 'suy nghĩ', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2826, '���x��S�', 'shōuyīnjī', 'radio', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2827, '����', 'sh�uy�', 'trao tặng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2828, '�09�R!', 'sh�uzhǐ', 'ng�n tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2829, '�罪', 'sh�uzu�', 'mang vạ, b�9 gi�y v�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2830, '�"�', 'sh�', 's�, �ếm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2831, '�x', 'sh�', 'b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2832, '�', 'sh�', 'c�y', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2900, '欝维', 'sīw�i', 'tư duy, suy nghĩ', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2903, '欝绪', 'sīx�', 't�m tư, � nghĩ', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2835, '�', 'shū', 'thua', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2836, '謍', 'shuǎ', 'chơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2837, '�&', 'shu�i', '�ẹp trai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2839, '�', 'shuāi', 'ng�, rơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2840, '衰謁', 'shuāilǎo', 'gi� yếu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2841, '�!� ', 'shu�ilǐng', 'dẫn �ầu, ch�0 huy', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2842, '���0', 'shuǎidi�o', 'vứt bỏ, tr�t bỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2905, '�::��', 's�zhī', 'tứ chi, ch�n tay', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2844, '�R', 'shuāng', '��i, hai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2922, '随�09', 'su�sh�u', 'ti�!n tay, thuận tay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2846, '�R��', 'shuāngfāng', 'cả hai b�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2848, '�Ʒ�0"', 'shuāy�', '��nh rĒng', NULL, 39);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2849, '鼠�!', 'sh�biāo', 'chu�"t m�y t�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2850, '���S', 'shūc�i', 'rau', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2851, '���"&', 'shūch�ng', 'khoan kho�i, d�& ch�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2852, '书�"', 'shūfǎ', 'thư ph�p', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2853, '�x缚', 'sh�f�', 'r�ng bu�"c, g� b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2854, '���S�', 'shūfu', 'thỏa m�i, d�& ch�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2855, '��忽', 'shūhu', 'sơ suất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2856, '谁', 'shu�', 'ai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2857, '税', 'shu�', 'thuế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2858, '水', 'shuǐ', 'nư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2860, '睡�0', 'shu�ji�o', 'ngủ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2928, '�"子', 'sūnzi', 'ch�u trai', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2862, '水�"头', 'shuǐl�ngt�u', 'v�i nư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2863, '水平', 'shuǐp�ng', 'tr�nh ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2864, '书籍', 'shūj�', 's�ch v�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2865, '书记', 'shūj�', 'b� thư', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2867, '�"�据', 'sh�j�', 'dữ li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2869, '� x绒', 'sh�li�n', 'th�nh thạo, thuần thục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2870, '�"��!�', 'sh�li�ng', 's� lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2872, '书面', 'shūmi�n', 'vĒn bản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2873, '�"��:�', 'sh�m�', 'con s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2874, '顺便', 'sh�nbi�n', 'nh�n ti�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2876, '顺序', 'sh�nx�', 'trật tự, thứ tự', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2877, '说不定', 'shuō bu d�ng', 'c� thỒ, chưa biết chừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2878, '说�܎', 'shuōm�ng', 'thuyết minh, giải th�ch', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2879, '说�S�', 'shuōf�', 'thuyết phục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2880, '�S', 'shu�', '�ầu th�ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2881, '��&�', 'shūr�', 'nhập v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2883, '� x�0', 'sh�xī', 'quen thu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2885, '�"��', 'sh�z�', 'con s�, s�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2886, '梳子', 'shūzi', 'lược, c�i lược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2888, '死', 'sǐ', 'chết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2889, '�"', 'sī', 'x� r�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2890, '死亡', 'sǐw�ng', 'chết, tử vong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2891, '司�"', 'sīfǎ', 'tư ph�p', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2893, '似乎', 's�hū', 'c� vẻ như', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2894, '司�S�', 'sījī', 'l�i xe', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2896, '欝念', 'sīni�n', 'nh�:', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2897, '私人', 'sīr�n', 'ri�ng tư, c� nh�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2898, '欝撳', 'sīxiǎng', 'tư tư�xng, tư duy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2899, '欝索', 'sīsu�', 'suy nghĩ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2901, '���!', 'sīw�n', 'nh� nhặn, l�9ch sự', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2904, '饲�&�', 's�yǎng', 'chĒn nu�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2906, '私�!�', 'sīz�', 'tự �, m�"t m�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2907, '鬁', 's�ng', 'tặng, �ưa, ti�&n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2908, '�0�', 'sōu', 'con (t�u, thuyền)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2909, '�', 'su�n', 't�nh to�n, �ếm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2910, '�&�', 'suān', 'chua', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2911, '�� ', 'su�nle', 'th�i �ược r�i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2912, '��"�', 'su�nsh�', 't�nh, �ếm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2913, '�x度', 's�d�', 't�c ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2914, '�话', 's�hu�', 'tục ngữ', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2915, '岁', 'su�', 'tu�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2916, '碎', 'su�', 'vỡ, n�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2917, '随便', 'su�bi�n', 't�y ti�!n, t�y �', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2918, '隧�', 'su�d�o', '�ường hầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2919, '随即', 'su�j�', 'ngay lập tức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2920, '�"���', 'suīr�n', 'tuy, mặc d�', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2923, '随��', 'su�y�', 't�y �', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2924, '随�', 'su�zhe', 'theo, c�ng v�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2925, '��"�9', 's�li�od�i', 't�i ni-l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2926, '�x坏', 's�nhu�i', 'hư hỏng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2927, '�x失', 's�nshī', 'thua thi�!t, mất m�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2929, '�0�', 'su�', 'ch�, nơi', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2930, '��', 'su�', 'kho�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2931, '缩�x�', 'suōduǎn', 'r�t ngắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2952, '台风', 't�if�ng', 'b�o', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2972, '坦�!', 'tǎnshu�i', 'thẳng thắn, b�"c trực', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3007, '天空', 'tiānkōng', 'bầu trời', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3008, '天伦�9乐', 'tiānl�n zhī l�', 'niềm vui gia ��nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2932, '索�', 'su�p�i', 'b�i thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2933, '�0��', 'su�w�i', 'c�i gọi l�', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2934, '缩小', 'suōxiǎo', 'thu nhỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2935, '缩� "', 'suōxi�:', 'viết tắt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2936, '�0��S0', 'su�y�u', 'tất cả, to�n b�"', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2937, '宿�ƍ', 's�sh�', 'k� t�c x�', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2939, '�0讼', 's�s�ng', 'ki�!n tụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2940, '素质', 's�zh�', 't� chất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2941, '�鬠', 's�z�o', 'nặn, tạo h�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2942, '�', 'tǎ', 'th�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2943, '�', 'tā', '�ng ấy, ch� ấy, anh ấy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2944, '�R', 'tā', 'sập', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2945, '她', 'tā', 'b� ấy, c� ấy, ch�9 ấy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2946, '宒', 'tā', 'n�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2948, '抬', 't�i', 'n�ng l�n, khi�ng, nhấc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2949, '太', 't�i', 'cực, nhất, qu�, lắm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2950, '泰�', 't�id�u', 'ng�i sao s�ng, nh�n vật vĩ �ại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2951, '欁度', 't�id�', 'th�i ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2954, '台�ܶ', 't�iji�', 'bậc thềm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2955, '太空', 't�ikōng', 'vũ trụ, bầu trời cao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2956, '太太', 't�itai', 'vợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2957, '太�ܳ', 't�iy�ng', 'mặt trời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2958, '��', 't�n', 'n�i chuy�!n, b�n luận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2959, '����', 'tānr', 'sạp, quầy h�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2960, '弹��琴', 't�n gāngq�n', '��nh ��n piano', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2961, '坦�"�', 'tǎnb�i', 'thẳng thắn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2962, '探�9', 't�nc�', 'thĒm d�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2963, '�', 't�ng', '�ường, kẹo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2964, '躺', 'tǎng', 'nằm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2965, '璫', 't�ng', 'n�ng, bỏng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2967, '�', 't�ng', 'ph�ng l�:n, nh� ch�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2968, '��', 't�ng', 'ao, �ầm, h�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2969, '���9�', 'tǎngru�', 'nếu như, giả sử', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2970, '叹', 't�n', 'th�x d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2971, '�ܫ��', 'tānhu�n', 'bại li�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2973, '���Ƥ', 't�np�n', 'cu�"c ��m ph�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2974, '叹�', 't�nq�', 'th�x d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2976, '探讨', 't�ntǎo', 'thảo luận, b�n bạc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2977, '探�S:', 't�nw�ng', 'thĒm hỏi, viếng thĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2978, '贪污', 'tānwū', 'tham �, tham nhũng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2979, '弹欧', 't�nx�ng', '��n h�i, linh hoạt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2980, '桒', 't�o', 'quả ��o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2981, '鬒', 't�o', 'tr�n tho�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2982, '�', 't�o', 'b�", tập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2984, '讨价��价', 'tǎoji� hu�nji�', 'mặc cả, trả gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2985, '讨论', 'tǎol�n', 'thảo luận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2986, '���', 't�oq�', 'ngh�9ch ngợm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2987, '鬒避', 't�ob�', 'tr�n tr�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2988, '讨�R', 'tǎoy�n', 'gh�t, ch�n gh�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2989, '踏实', 'tāshi', 'ch�n thật, thực tế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2990, '�0��ƫ', 't�bi�', '�ặc bi�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2991, '�0��"�', 't�ch�ng', 's�x trường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2992, '�0���', 't�diǎn', '�ặc �iỒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2994, '��', 't�ng', '�au', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2995, '���Ʊ', 't�ng�"�i', 'thương y�u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2996, '�0��0�', 't�s�', '�ặc sắc', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2997, '�0���', 't�y�', 'c� �, �ặc bi�!t l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2998, '�0�征', 't�zh�ng', '�ặc trưng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2999, '�0', 'ti', 'nhặt ra, gỡ ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3000, '��', 't�', '�ề mục, �ề t�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3001, '踢足琒', 'tī z�qi�', '�� b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3002, '�S', 'ti�n', 'ngọt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3003, '��', 'tiǎn', 'liếm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3005, '���', 'ti�nj�ng', '�iền kinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3006, '填空', 'ti�nk�ng', '�iền v�o ch� tr�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3009, '天�', 'tiānq�', 'thời tiết', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3010, '天���', 'tiānr�nq�', 'kh� ��t tự nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3011, '天�x', 'tiānsh�ng', 'trời sinh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3012, '天�', 'tiānt�ng', 'thi�n �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3013, '天�!', 'tiānw�n', 'thi�n vĒn học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3014, '���!�', 'ti�ny�:', '��ng ru�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3016, '条', 'ti�o', 'c�nh, mảnh, sợi, con (rắn, c�,⬦)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3017, '�R�9�', 'tiǎobō', 'g�y x�ch m�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3018, '谒�R', 'ti�oh�', 'h�a giải', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3019, '谒�', 'ti�oji�', '�iều ch�0nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3020, '条件', 'ti�oji�n', '�iều ki�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3021, '谒�"�', 'ti�ozh�:ng', '�iều ch�0nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3022, '谒解', 'ti�oji�:', 'h�a giải', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3023, '条款', 'ti�okuǎn', '�iều khoản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3025, '谒�"', 'ti�oli�o', '�� gia v�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3026, '谒皮', 'ti�op�', 'ngh�9ch ngợm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3027, '�R�0', 'tiāot�', 'soi m�i, bắt l�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3028, '�R�0', 'tiāoxuǎn', 'lựa chọn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3029, '�R���', 'tiǎozh�n', 'th�ch thức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3030, '提�9', 't�b�', '�ề bạt, cất nhắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3031, '��材', 't�c�i', 'chủ �ề, n�"i dung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3032, '提嬡', 't�ch�ng', '�ề xư�:ng, kh�xi xư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3033, '提纲', 't�gāng', '�ề cương, d�n �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3034, '提��', 't�gāo', 'n�ng cao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3035, '提�:', 't�gōng', 'cung cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3036, '�会', 'tǐhu�', 'cảm nhận, nhận thức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3048, '提�0�', 't�qi�n', 's�:m, trư�:c', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3112, '鬒��', 'tuōtuō', 'tho�t ra, tho�t khỏi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3073, '�x�x', 't�ngt�ng', 'tất cả', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3096, '鬬', 'tu�', 'r�t lui, l�i lại', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3099, '推�x', 'tuīch�', 'ho�n lại, tr� ho�n', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3104, '推� ', 'tuīlǐ', 'suy luận', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3105, '推论', 'tuīl�n', 'suy luận, l� luận', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3123, '�&子', 't�zi', 'con thỏ', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3111, '�Sx壤', 't�rǎng', '�ất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3137, '玩', 'w�n', 'chơi', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3038, '�面', 'tǐmi�n', 'vẻ vang, danh gi�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3039, '���:�', 't�m�', '�ề mục, ti�u �ề', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3040, '�贴', 'tǐti�', 'chĒm s�c, quan t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3041, '听', 'tīng', 'nghe', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3043, '�S车', 't�ngch�', 'dừng xe, �� xe', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3044, '�S泊', 't�ngb�', 'cập bến, neo �ậu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3046, '�S滞', 't�ngzh�', '��nh tr�!, dừng lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3047, '亭子', 't�ngzi', '��nh, ch�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3049, '提示', 't�sh�', 'nhắc nh�x, gợi �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3050, '提��', 't�w�n', '�ặt c�u hỏi', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3051, '�系', 'tǐx�', 'h�! th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3052, '�形', 'tǐx�ng', 'h�nh thỒ, v�c d�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3053, '提� ', 't�xǐng', 'nhắc nh�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3054, '��R', 'tǐy�n', 'trải nghi�!m, thử nghi�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3055, '提议', 't�y�', '�ề ngh�9, �ề xuất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3056, '���', 'tǐy�', 'thỒ thao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3057, '�S', 't�ng', '��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3058, '桶', 't�ng', 'x�, th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3060, '�S�x�', 't�ng ku�ng', 'quặng ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3061, '�R蒞', 't�ngbāo', '��ng b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3062, '鬚常', 'tōngch�ng', 'th�ng thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3063, '�x筹�&�顾', 't�ngch�u jiāng�', 't�nh to�n mọi bề', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3064, '鬚�!', 'tōnggu�', 'vượt qua, th�ng qua, �i qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3065, '童话', 't�nghu�', 'truy�!n c�" t�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3066, '�x计', 't�ngj�', 'th�ng k�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3067, '�:�9�', 't�ngk�', '�au kh�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3068, '�:快', 't�ngku�i', 'vui sư�:ng, d�& ch�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3070, '�R��', 't�ngsh�', '��ng thời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3071, '�R�9', 't�ngsh�', '��ng nghi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3072, '鬚�', 'tōngs�', 'ph�" biến, th�ng tục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3074, '�R学', 't�ngxu�', 'bạn học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3075, '鬚讯', 'tōngx�n', 'truyền th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3076, '�x丬', 't�ngyī', 'th�ng nhất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3077, '鬚��', 'tōngy�ng', 'chung d�ng, th�ng dụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3078, '�x治', 't�ngzh�', 'th�ng tr�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3079, '鬚�x�', 'tōngzhī', 'th�ng b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3080, '头�', 't�ufa', 't�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3081, '头', 't�u', '�ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3082, '鬏�܎', 't�um�ng', 'trong su�t, minh bạch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3083, '�"票', 't�upi�o', 'bỏ phiếu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3084, '�"掷', 't�uzh�', 'n�m, quĒng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3085, '�"�', 't�uzī', '�ầu tư', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3087, '�:�', 'tu�n', 'nh�m, �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3088, '�:���', 't��"�n', 'hoa vĒn, h�nh vẽ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3089, '�:��', 'tu�nji�', '�o�n kết', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3090, '�:��', 'tu�ntǐ', 'tập thỒ, �o�n thỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3091, '�:���', 'tu�nyu�n', '�o�n vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3092, '突�!�', 'tūchū', 'n�"i bật, xuất sắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3093, '��x', 't�d�', '�� ��!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3094, '�Sx� ', 't�d�u', 'khoai t�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3097, '鬬步', 'tu�b�', 'thụt l�i, �i l�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3098, '推�9', 'tuīc�', 'suy �o�n, dự �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3100, '推辞', 'tuīc�', 'từ ch�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3101, '推翻', 'tuīfān', 'lật ��", �ảo ngược', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3102, '推广', 'tuīguǎng', 'm�x r�"ng, ph�" biến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3106, '推��', 'tuīxiāo', 'b�n h�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3107, '鬬�', 'tu�xiū', 'ngh�0 hưu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3108, '��', 't�j�ng', 'con �ường, c�ch thức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3109, '�抹', 't�m�', 'b�i, qu�t, t�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3110, '屠杬', 't�shā', 't�n s�t, �� s�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3113, '�9', 'tuō', 'k�o, l�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3114, '��', 'tuō', 'c�xi, tho�t, gỡ ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3116, '�9�90', 'tuōlā', 'k�o l�, lề mề', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3117, '�9�"', 'tu�zhǎn', 'm�x r�"ng, ph�t triỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3118, '椭�S ', 'tu�yu�n', 'h�nh bầu dục', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3119, '�0�运', 'tuōy�n', 'ủy th�c vận chuyỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3120, '突破', 'tūp�', '��"t ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3121, '突��', 'tūr�n', '��"t nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3122, '�:�书� ', 't�shū guǎn', 'thư vi�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3124, '�!', 'wa', 'oa, o�, oe, �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3125, '�', 'w�i', 'ngo�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3127, '�表', 'w�ibiǎo', 'vẻ ngo�i, bề ngo�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3128, '��R', 'w�ih�ng', 'người ngoại nghề', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3129, '�交', 'w�ijiāo', 'ngoại giao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3130, '��"R', 'w�iji�', 'thế gi�:i b�n ngo�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3131, '歪�:�', 'wāiqū', 'xuy�n tạc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3132, '��', 'w�ixi�ng', 'hư�:ng ngoại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3134, '�R��', 'wāju�', 'khai quật, ��o b�:i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3135, '丸', 'w�n', 'vi�n thu�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3136, '�R', 'w�n', 'xong, kết th�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3138, '�!', 'w�n', 'vạn, mười ngh�n', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3140, '弯', 'wān', 'cong, u�n cong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3141, '�!丬', 'w�nyī', 'vạn nhất, ng�" nhỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3142, '�R�!', 'w�nb�i', 'ho�n to�n, �ầy �ủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3194, '�:��"', 'w�ir�o', 'bao quanh, xoay quanh', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3149, '��S', 'wǎnglu�', 'mạng', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3177, '位于', 'w�iy�', 'nằm �x, tọa lạc tại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3221, '�!�܎', 'w�nm�ng', 'vĒn minh', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3152, '徬徬', 'wǎngwǎng', 'thường hay, thường thường', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3157, '�R��"', 'wǎnji�', 'cứu v�n, cứu gi�p', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3161, '玩�&�', 'w�nj�', '�� chơi', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3139, '�', 'wǎn', 'b�t', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3188, '�"�撧', 'w�ij�', 'sợ h�i, e ngại', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3189, '蒒口', 'w�ik�u', 'khẩu v�9, sự th�m Ēn', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3176, '���', 'w�:iqu', 'oan ức, tủi th�n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3203, '威信', 'w�ix�n', 'uy t�n', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3143, '�R�"', 'w�nb�', 'ho�n tất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3144, '�R�Ɛ', 'w�nch�ng', 'ho�n th�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3145, '�!�� ', 'w�nf�n', 'v� c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3146, '�R�&�', 'w�nqu�n', 'ho�n to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3147, '顽强', 'w�nqi�ng', 'ngoan cường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3148, '�R�"�', 'w�nzh�:ng', 'ho�n ch�0nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3210, '��', 'w�n', 'hỏi', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3150, '�琒', 'wǎngqi�', 'b�ng b�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3217, '�!�!�', 'w�np�ng', 'bằng cấp', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3153, '�撳', 'w�ngxiǎng', 'm�"ng tư�xng, ảo tư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3154, '��"', 'wǎngzh�n', 'trang web, website', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3155, '�9子', 'w�ngzǐ', 'ho�ng tử', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3156, '�R��:�', 'wǎnhu�', 'xoay chuyỒn, cứu v�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3239, '�', 'w�', 'nĒm', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3158, '�R美', 'w�nm�:i', 'ho�n hảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3159, '�"�上', 'wǎnshang', 'bu�"i t�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3224, '�!学', 'w�nxu�', 'vĒn học', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3162, '娒娒', 'w�wa', 'b�p b�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3163, '�R', 'wā', '��o, b�:i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3164, '位', 'w�i', 'v�9 tr�, ch�, nơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3165, '为', 'w�i', 'v�, �Ồ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3166, '�', 'w�i', 'alo, n�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3167, '�"�', 'w�i', 'sợ, e ngại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3168, '蒒', 'w�i', 'dạ d�y', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3169, '�S��&', 'w�ib�', 'chưa hẳn, kh�ng nhất thiết', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3170, '���9�', 'w�id�', 'ch�0 ri�ng, duy nhất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3171, '为� ', 'w�ile', '�Ồ, v�', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3172, '�:�', 'w�i', 'v�y quanh, bao quanh', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3174, '维护', 'w�ih�', 'duy tr�, bảo v�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3175, '尾巴', 'w�:iba', '�u�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3227, '�!章', 'w�nzhāng', 'b�i vĒn, b�i viết', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3229, '����', 'w�nt�', 'vấn �ề', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3179, '维�R�', 'w�ich�', 'duy tr�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3180, '�x大', 'w�:id�', 'vĩ �ại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3181, '���', 'w�id�o', 'm�i v�9, hương v�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3182, '违�"', 'w�ifǎ', 'vi phạm ph�p luật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3183, '微风', 'w�if�ng', 'vi phong, gi� nhẹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3184, '微�', 'w�iguān', 'vi m�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3185, '危害', 'w�ih�i', 'nguy hại', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3186, '危�S�', 'w�ijī', 'nguy cơ, khủng hoảng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3187, '�:�巾', 'w�ijīn', 'khĒn cho�ng c�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3232, '�!学家', 'w�nxu�jiā', 'nh� vĒn học', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3219, '�!件', 'w�nji�n', 't�i li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3190, '�S�来', 'w�il�i', 'tương lai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3192, '�S��&�', 'w�imiǎn', 'c� hơi, kh� tr�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3193, '为难', 'w�in�n', 'l�ng t�ng, kh� xử', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3245, '��謻', 'w�chǐ', 'v� li�m s�0', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3195, '为们��', 'w�ish�nme', 'tại sao, v� sao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3196, '卫�x��', 'w�ish�ngjiān', 'nh� v�! sinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3197, '维�x素', 'w�ish�ngs�', 'vitamin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3198, '为�', 'w�ish�u', '�ứng �ầu, cầm �ầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3199, '��0�', 'w�:ituō', 'ủy th�c, nhờ vả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3200, '�&���', 'w�iw�n', 'thĒm hỏi, an ủi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3201, '危�"�', 'w�ixiǎn', 'nguy hiỒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3202, '威蒁', 'w�ixi�', '�e dọa, uy hiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3204, '卫��x', 'w�ixīng', 'v�! tinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3206, '��丬', 'w�iyī', 'duy nhất', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3207, '���', 'w�:iyu�n', 'ủy vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3208, '伪鬠', 'w�:iz�o', 'giả mạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3209, '位置', 'w�izh�', 'v�9 tr�, ch�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3211, '吻', 'w�:n', 'h�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3212, '温带', 'w�nd�i', '�n ��:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3213, '稳定', 'w�:nd�ng', '�"n ��9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3214, '温度', 'w�nd�', 'nhi�!t ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3216, '�!�R�', 'w�nxi�n', 'vĒn hiến, t�i li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3218, '�!�R', 'w�nhu�', 'vĒn h�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3220, '�!�&�', 'w�nj�', 'dụng cụ học tập', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3222, '�!�:�', 'w�nm�ng', 'm� chữ', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3223, '温�', 'w�nnuǎn', 'ấm �p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3225, '�!�:&', 'w�nyǎ', 'tao nh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3228, '���"', 'w�nh�u', 'hỏi thĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3230, '吻��', 'w�:nh�', 'ph� hợp, Ēn kh�:p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3231, '�!�0�', 'w�nw�', 'di vật, c�" vật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3233, '�!书', 'w�nshū', 'vĒn thư', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3234, '��们', 'w�men', 'ch�ng ta', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3236, '握�09', 'w�sh�u', 'bắt tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3237, '��', 'w�', 'kh�ng c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3238, '�:�', 'w�', 'sương m�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3241, '��论��"', 'w�l�n r�h�', 'd� sao �i nữa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3242, '务�&', 'w�b�', 'nhất thiết phải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3243, '���', 'w�bǐ', 'kh�ng g� s�nh bằng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3244, '��偿', 'w�ch�ng', 'kh�ng ho�n lại, kh�ng c� �ền b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3246, '��从', 'w�c�ng', 'kh�ng biết từ ��u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3247, '�ƞ��', 'w�dǎo', 'nhảy m�a', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3249, '��非', 'w�f�i', 'chẳng qua l�, ch�0 l�', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3319, '�:��&�', 'xiāngguān', 'c� li�n quan', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3277, '�9', 'xi�', 'xu�ng, dư�:i, kế tiếp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3284, '�9令', 'xi�l�ng', 'ban l�!nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3287, '弦', 'xi�n', 'd�y ��n', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3349, '小吒', 'xiǎochī', '�� Ēn vặt, m�n Ēn nhẹ', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3293, '�ܾ示', 'xiǎnsh�', 'thỒ hi�!n, tr�nh b�y', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3250, '�R�', 'wūh�i', '�en s�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3251, '误会', 'w�hu�', 'hiỒu nhầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3252, '���', 'w�l�i', 'lưu manh, v� lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3253, '��精�0�!!', 'w�jīng dǎcǎi', 'phờ phạc, ủ rũ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3255, '��礼', 'w�lǐ', 'v� l�&, bất l�9ch sự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3256, '��聊', 'w�li�o', 'nhạt nhẽo, v� v�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3257, '��蒽', 'w�n�ng', 'bất lực, v� nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3258, '��论', 'w�l�n', 'bất luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3259, '���S', 'w�gū', 'v� t�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3260, '��微不�!�', 'w�w�i b� zh�', 'chu ��o, t�0 m�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3261, '武�"�', 'w�q�', 'vũ kh�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3262, '��穷��尽', 'w�qi�ng w�j�n', 'v� c�ng v� tận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3263, '污�x', 'wūrǎn', '� nhi�&m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3264, '侮辱', 'w�r�', 'lĒng nhục, s�0 nhục', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3265, '务实', 'w�sh�', 'thực tế, thiết thực', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3266, '���0��', 'w�su�w�i', 'kh�ng sao, kh�ng quan trọng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3267, '���x�', 'w�zhī', 'ngu d�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3268, '�0�质', 'w�zh�', 'vật chất', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3270, '�9子', 'wūzi', 'ng�i nh�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3271, '系', 'x�', 'bu�"c, c�"t, h�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3272, '�', 'xǐ', 'giặt, rửa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3273, '溪', 'xī', 'su�i, khe', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3274, '西', 'xī', 't�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3275, '系� 带', 'x� lǐngd�i', 'thắt c� vạt', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3278, '瞎', 'xiā', 'm�, m� qu�ng', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3279, '夏', 'xi�', 'm�a h�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3280, '峡', 'xi�', 'hẻm n�i, khe s�u', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3281, '�9�:�', 'xi� y�', 'trời mưa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3282, '�9���', 'xi��"�i', 'hẹp h�i, thiỒn cận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3285, '�S', 'xiān', 'tươi, m�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3286, '�R', 'xi�n', 'gh�t, ch�n gh�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3288, '贤', 'xi�n', 'hiền l�nh, t�i giỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3289, '县', 'xi�n', 'huy�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3291, '�"�', 'xi�n', 'hạn, gi�:i hạn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3292, '�ܾ', 'xiǎn', 'r� r�ng, hi�!n r�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3294, '�ܾ��', 'xiǎnr�n', 'hiỒn nhi�n, r� r�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3295, '�ܾ�', 'xiǎnzh�', 'r� r�!t, n�"i bật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3296, '现�S�', 'xi�nchǎng', 'hi�!n trường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3297, '现代', 'xi�nd�i', 'hi�!n �ại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3298, '�"�害', 'xi�nh�i', 'h�m hại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3300, '�&��', 'xi�n er', 'nh�n (b�nh)', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3301, '现�Ɛ', 'xi�nch�ng', 'c� sẵn, v�n c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3302, '�ܾ�', 'xiǎnde', 'l�" ra, hi�!n ra', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3303, '咏', 'xi�ng', 'gi�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3304, '�', 'xi�ng', 'hư�:ng, về ph�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3305, '巷', 'xi�ng', 'ng�, hẻm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3306, '项', 'xi�ng', 'hạng mục', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3307, '��', 'xiǎng', 'tiếng vang, vang l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3308, '撳', 'xiǎng', 'nghĩ, mu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3309, '�"', 'xiāng', 'thơm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3311, '�:��', 'xiāngch�', 's�ng chung, h�a hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3312, '�:��', 'xiāngdāng', 'tương �ương, tương xứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3313, '�:�对', 'xiāngdu�', 'tương ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3314, '�:��0', 'xiāngd�:ng', 'bằng, ngang nhau', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3316, '�:��&�:��Ɛ', 'xiāngf�xiāngch�ng', 'b�" trợ cho nhau', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3317, '�:��', 'xiāngh�', 'lẫn nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3318, '�:�连', 'xiāngli�n', 'li�n kết, n�i liền', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3320, '�:�声', 'xi�ngsheng', 'tấu h�i', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3321, '��亮', 'xiǎngli�ng', 'vang d�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3322, '享�', 'xiǎngsh�u', 'hư�xng thụ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3323, '橡皮', 'xi�ngp�', 'cục tẩy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3324, '象�9', 'xi�ngq�', 'cờ tư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3325, '�:�亲�:��Ʊ', 'xiāngqīnxiāng�"�i', 'y�u thương nhau', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3326, '撳象', 'xiǎngxi�ng', 'tư�xng tượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3327, '�:�信', 'xiāngx�n', 'tin tư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3328, '���', 'xiǎngy�ng', '��p lại, hư�xng ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3329, '�:��', 'xiāngy�ng', 'tương ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3330, '象征', 'xi�ngzh�ng', 'tượng trưng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3331, '贤撠', 'xi�nhu�', 'hiền thục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3333, '�&��:', 'xiānj�n', 'ti�n tiến', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3334, '羡�&"', 'xi�nm�', 'ngưỡng m�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3335, '�S�܎', 'xiānm�ng', 'tươi s�ng, r� n�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3336, '�S�0�', 'xiāny�n', 's�ng, tươi �ẹp, rực rỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3337, '纤维', 'xiānw�i', 'sợi, chất xơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3338, '现实', 'xi�nsh�', 'thực tế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3339, '现象', 'xi�nxi�ng', 'hi�!n tượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3340, '�R�身', 'xi�nsh�n', 'hiến th�n, c�ng hiến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3341, '�"��ƶ', 'xi�nzh�', 'hạn chế', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3342, '�R弒', 'xi�nq�', 'ch�, gh�t bỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3344, '�R�', 'xi�ny�', 'nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3345, '现�S�', 'xi�nz�i', 'b�y giờ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3346, '现状', 'xi�nzhu�ng', 'hi�!n trạng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3347, '�', 'xi�o', 'cười', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3348, '小', 'xiǎo', 'nhỏ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3350, '���"�', 'xiāoch�', 'loại bỏ, loại trừ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3352, '���ܲ', 'xiāof�ng', 'chữa ch�y, cứu hỏa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3363, '小麦', 'xiǎom�i', 'l�a m�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3380, '�9', 'xi�', 'gi�y', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3447, '信忒', 'x�nxīn', 'niềm tin', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3385, '衬�9', 'xi�:yā', 'huyết �p', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3388, '�9子', 'xi�zi', '��i gi�y', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3389, '� "', 'xi�:', 'viết', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3400, '欧�ƫ', 'x�ngbi�', 'gi�:i t�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3401, '欧格', 'x�ngg�', 't�nh c�ch', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3404, '西红�x�', 'xīh�ngsh�', 'c� chua', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3405, '�S欢', 'xǐhuan', 'th�ch', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3414, '信封', 'x�nf�ng', 'phong b�, bao thư', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3354, '�"��S', 'xi�ogu�', 'hi�!u quả', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3355, '���', 'xiāoh�o', 'ti�u hao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3356, '�话', 'xi�ohu�', 'truy�!n cười', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3357, '���R', 'xiāohu�', 'ti�u h�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3358, '��毁', 'xiāohuǐ', 'ti�u hủy, ph� hủy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3359, '小�"子', 'xiǎohu�zi', 'thanh ni�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3360, '��息', 'xiāoxi', 'tin tức, th�ng tin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3361, '��极', 'xiāoj�', 'ti�u cực', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3364, '��灭', 'xiāomi�', 'ti�u di�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3365, '小�', 'xiǎoq�', 'keo ki�!t, bủn x�0n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3366, '小��', 'xiǎosh�', 'tiếng, giờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3367, '��失', 'xiāoshī', 'biến mất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3368, '����', 'xiāosh�u', 'b�n h�ng, ti�u thụ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3369, '小说', 'xiǎoshuō', 'tiỒu thuyết', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3370, '小偷', 'xiǎotōu', 'kẻ tr�"m, t�n tr�"m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3371, '�咏', 'xi�oxi�ng', 'ch�n dung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3372, '小忒', 'xiǎoxīn', 'cẩn thận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3373, '小忒翼翼', 'xiǎoxīny�y�', 'thận trọng, t�0 m�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3374, '�"��:�', 'xi�oy�', 'lợi �ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3375, '校�"�', 'xi�ozhǎng', 'hi�!u trư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3376, '�9属', 'xi�sh�', 'cấp dư�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3378, '� 蒞', 'x�bāo', 'tế b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3379, '�S', 'xi�', 'nghi�ng, xi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3429, '�&�趣', 'x�ngq�', 'hứng th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3381, '携带', 'xi�d�i', 'mang theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3382, '协会', 'xi�hu�', 'hi�!p h�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3383, '协谒', 'xi�ti�o', 'ph�i hợp, �iều h�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3384, '�漏', 'xi�l�u', 'r� r�0', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3440, '信�', 'x�nl�i', 'tin cậy', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3387, '协助', 'xi�zh�', 'gi�p �ỡ, h� trợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3445, '����', 'xīnni�ng', 'c� d�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3452, '忒衬', 'xīnxu�', 't�m huyết, t�m sức', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3390, '谢谢', 'xi�xie', 'cảm ơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3391, '�S坡', 'xi�pō', 'd�c nghi�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3392, '卸', 'xi�', 'th�o dỡ, dỡ h�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3393, '�:�9�', 'xīnk�', 'vất vả, cực kh�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3394, '��', 'xīn', 'm�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3395, '忒', 'xīn', 'tim, l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3396, '信', 'x�n', 'thư, tin, t�n hi�!u', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3397, '�R动', 'x�ngd�ng', 'h�nh ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3398, '�R', 'x�ng', '�ược, �i, l�m, giỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3457, '信�0', 'x�ny�', 'danh dự, uy t�n', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3402, '�R为', 'x�ngw�i', 'h�nh vi', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3406, '袭�!�', 'x�j�', 'tập k�ch, tấn c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3407, '� �', 'x�ji�', 'chi tiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3408, '�Ə�0�', 'x�j�', 'k�9ch, tu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3409, '� �R', 'x�jūn', 'vi khuẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3410, '系��', 'x�li�', 'chu�i, loạt, h�ng loạt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3411, '� 灭', 'xīmi�', 'dập tắt, tắt ngấm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3413, '忒�', 'xīnd�', 't�m �ắc, �iều t�m �ắc', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3415, '�', 'x�ng', 'họ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3416, '� ', 'xǐng', 't�0nh, t�0nh t�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3417, '�&�', 'xīng', 'tanh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3418, '形�Ɛ', 'x�ngch�ng', 'h�nh th�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3419, '幸福', 'x�ngf�', 'hạnh ph�c', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3420, '欧�x', 'x�nggǎn', 'gợi cảm, hấp dẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3421, '�&����!!��', 'x�nggāocǎili�', 'v� c�ng phấn kh�xi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3422, '幸运', 'x�ngy�n', 'may mắn', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3423, '�R李箱', 'x�nglǐ xiāng', 'va-li, h�nh l�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3424, '�&�� ', 'xīngl�ng', 'hưng th�9nh, th�9nh vượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3425, '欧��', 'x�ngm�ng', 't�nh mạng, sinh m�!nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3426, '�&��::', 'xīngsh�ng', 'hưng th�9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3427, '��x�Sx', 'xīngqī', 'ng�y thứ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3430, '�R人', 'x�ngr�n', 'người �i b�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3431, '形容', 'x�ngr�ng', 'h�nh dung, mi�u tả', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3432, '���9', 'x�ngsh�', 'h�nh sự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3433, '形式', 'x�ngsh�', 'h�nh thức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3434, '形欁', 'x�ngt�i', 'h�nh th�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3435, '�&���', 'xīngw�ng', 'hưng th�9nh, ph�n vinh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3436, '形象', 'x�ngxi�ng', 'h�nh tượng, h�nh ảnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3437, '�R��', 'x�ngzh�ng', 'h�nh ch�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3438, '欧质', 'x�ngzh�', 't�nh chất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3439, '信号', 'x�nh�o', 't�n hi�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3442, '忒� ', 'xīnlǐ', 't�m l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3443, '忒灵', 'xīnl�ng', 't�m linh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3444, '信念', 'x�nni�n', 'niềm tin, l�ng tin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3446, '���S', 'xīnxiān', 'tươi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3449, '信使', 'x�nshǐ', 'sứ giả, người �ưa tin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3450, '忒�:', 'xīnt�ng', '�au l�ng, thương x�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3451, '欣欣�荣', 'xīnxīnxi�ngr�ng', 'ph�t triỒn tươi t�t, th�9nh vượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3453, '忒�S���', 'xīnyǎnr', 'n�"i t�m, l�ng dạ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3454, '信仰', 'x�nyǎng', 't�n ngưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3455, '���', 'xīnyǐng', 'm�:i mẻ, ��"c ��o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3456, '信��卡', 'x�ny�ngkǎ', 'thẻ t�n dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3462, '�:厚', 'xi�ngh�u', 'h�ng hậu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3473, '修', 'xiū', 'sửa chữa, tu sửa', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3474, '绣', 'xi�', 'th�u', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3475, '修� ', 'xiūlǐ', 'sửa chữa', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3486, '�澡', 'xǐzǎo', 'tắm, tắm rửa', NULL, 39);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3490, '宣传', 'xuānchu�n', 'tuy�n truyền', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3495, '宣�', 'xuānsh�', 'tuy�n th�!', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3496, '�0�09', 'xuǎnsh�u', 'tuyỒn thủ, �ấu thủ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3508, '学�x', 'xu�sh�ng', 'sinh vi�n, học sinh', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3459, '蒸', 'xiōng', 'ngực', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3461, '�!�恶', 'xiōng�"�', 'hung �c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3509, '学�S�', 'xu�sh�', 'học thuật', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3463, '蒸欬', 'xiōnghu�i', 'l�ng dạ, tấm l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3464, '� ��R�', 'xi�ngmāo', 'gấu tr�c', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3465, '�!��09', 'xiōngsh�u', 'kẻ giết người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3466, '蒸� :', 'xiōngt�ng', 'l�ng ngực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3468, '����', 'xīr�', 'ng�y xưa, trư�:c kia', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3469, '�0��0�', 'xīsh�ng', 'hi sinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3470, '吸��', 'xīshōu', 'hấp thụ, hấp thu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3471, '��09��', 'xǐsh�ujiān', 'nh� v�! sinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3472, '习�', 'x�s�', 'tập tục, phong tục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3513, '学习', 'xu�x�', 'học tập', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3524, '�0�', 'x�nd�o', 'tử v� �ạo', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3532, '序訬', 'x�y�n', 'lời n�i �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3476, '�息', 'xiūxi', 'ngh�0 ngơi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3477, '���', 'xiūxi�n', 'ngh�0 ngơi, giải tr�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3478, '修�&�', 'xiūyǎng', 'tu dưỡng, �iều dưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3479, '�R�S:', 'xīw�ng', 'hy vọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3481, '续', 'x�', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3482, '�"�ܳ', 'xīy�ng', 'mặt trời lặn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3483, '�衣�S�', 'xǐyījī', 'm�y giặt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3484, '吸�"', 'xīyǐn', 'thu h�t, hấp dẫn', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3485, '�S��', 'xǐyu�', 'vui mừng, sung sư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3535, '�0"� �', 'y�gāo', 'kem ��nh rĒng', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3487, '� �!�', 'x�zh�', 't�0 m�0, kỹ lưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3488, '�"述', 'x�sh�', 'tường thuật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3489, '宣帒', 'xuānb�', 'tuy�n b�, c�ng b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3537, '亚� :', 'y�jūn', '� qu�n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3491, '宣�0�', 'xuāny�ng', 'tuy�n dương, ca ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3492, '�0举', 'xuǎnj�', 'bầu cử', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3493, '�9�9', 'xu�nl�S', 'giai �i�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3539, '�:�', 'y�n', 'mu�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3550, '羊�0', 'y�ngr�u', 'th�9t d�', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3497, '��殊', 'xu�nshū', 'kh�c xa, ch�nh l�!ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3498, '���峭壁', 'xu�ny�qi�ob�', 'v�ch n�i hiỒm tr�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3499, '�0', 'xuǎn', 'chọn, tuyỒn chọn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3500, '�9转', 'xu�nzhuǎn', 'quay tr�n, xoay chuyỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3501, '许多', 'x�duō', 'nhiều, rất nhiều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3502, '衬', 'xu�', 'm�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3503, '�:�', 'xu�:', 'tuyết', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3504, '学� ', 'xu�l�', 'học vấn, tr�nh ��" học vấn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3505, '学�Sx', 'xu�qī', 'học kỳ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3506, '�"�弱', 'xūru�', 'suy yếu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3510, '学说', 'xu�shuō', 'học thuyết', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3511, '学位', 'xu�w�i', 'học v�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3512, '学��', 'xu�w�n', 'học vấn, tri thức', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3514, '学校', 'xu�xi�o', 'trường học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3515, '�"��!', 'xūjiǎ', 'giả tạo, giả d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3516, '�&�&', 'x�ji�', 'say rượu, nghi�!n rượu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3517, '许可', 'x�k�:', 'giấy ph�p', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3518, '恤', 'x�', 'thương x�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3519, '循环', 'x�nhu�n', 'tuần ho�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3520, '训绒', 'x�nli�n', 'huấn luy�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3521, '巡鬻', 'x�nlu�', '�i tuần', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3522, '寻�&', 'x�nm�', 't�m kiếm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3523, '�&�x', 'x�ns�', 'nhanh ch�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3525, '询��', 'x�nw�n', 'hỏi, hỏi thĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3527, '寻�0�', 'x�nzhǎo', 't�m kiếm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3528, '� �', 'xūn', 'hun, x�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3529, '�99章', 'xūnzhāng', 'hu�n chương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3530, '�"�伪', 'xūw�:i', 'giả d�i, �ạo �ức giả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3531, '序号', 'x�h�o', 's� thứ tự', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3533, '�S�要', 'xūy�o', 'cần, cần thiết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3534, '��', 'ya', 'a, �, nh�⬦', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3536, '押�!', 'yājīn', 'tiền �ặt cọc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3538, '�9�:', 'yāl�', '�p lực', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3541, '延�"�', 'y�nch�ng', 'k�o d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3542, '��!�', 'yǎnchū', 'biỒu di�&n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3543, '�&�', 'yǎng', 'nu�i dưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3545, '�&��Ɛ', 'yǎngch�ng', 'nu�i nấng, h�nh th�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3546, '掩�:', 'yǎng�i', 'che �ậy, bao phủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3547, '�ܳ�&0', 'y�ngguāng', '�nh s�ng mặt trời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3548, '样��', 'y�ngpǐn', 'h�ng mẫu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3549, '氧�', 'yǎngq�', 'oxy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3552, '宴会', 'y�nhu�', 'bữa ti�!c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3553, '�S��&0', 'yǎnguāng', '�nh mắt, tầm nh�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3554, '沿海', 'y�nhǎi', 'duy�n hải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3555, '严�', 'y�nh�n', 'r�t �ậm, r�t hại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3556, '掩护', 'yǎnh�', 'che ch�x, bảo v�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3558, '訬�R', 'y�nx�ng', 'lời n�i v� h�nh ��"ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3559, '�究�x', 'y�njiūsh�ng', 'nghi�n cứu sinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3560, '严谨', 'y�njǐn', 'nghi�m t�c, cẩn trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3561, '严�0', 'y�nl�', 'nghi�m khắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3562, '訬论', 'y�nl�n', 'ng�n luận, lời b�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3582, '�!', 'y�o', 'rung, lắc, �ung �ưa', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3615, '丬', 'yī', 's� m�"t', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3661, '营业', 'y�ngy�', 'kinh doanh', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3583, '药', 'y�o', 'thu�c', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3616, '亿', 'y�', 'm�"t trĒm tri�!u', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3620, '丬��子', 'yīb�izi', 'cả �ời, m�"t �ời', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3623, '�产', 'y�chǎn', 'di sản', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3624, '移�', 'y�m�n', 'di d�n', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3626, '依次', 'yīc�', 'lần lượt, theo thứ tự', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3628, '丬定', 'y�d�ng', 'nhất ��9nh, chắc chắn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3563, '严� ', 'y�nm�', 'chặt chẽ, k�n ��o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3564, '淹没', 'yānm�', 'ch�m ngập, nhấn ch�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3566, '��璭', 'y�nr�', 'n�ng bức, gay gắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3567, '�S�0�', 'y�ns�', 'm�u sắc', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3568, '�S��0�', 'yǎns�', '�nh mắt, nĒng lực quan s�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3569, '延伸', 'y�nsh�n', 'k�o d�i, m�x r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3570, '�S�神', 'yǎnsh�n', '�nh mắt, th�9 lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3572, '掩饰', 'yǎnsh�', 'che giấu, che �ậy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3573, '�R��', 'y�nshōu', 'nghi�!m thu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3574, '严��', 'y�ns�', 'nghi�m t�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3575, '�R恶', 'y�nw�', 'gh�t, ch�n gh�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3576, '�习', 'yǎnx�', 'di�&n tập', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3577, '延续', 'y�nx�', 'tiếp tục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3579, '���', 'yǎnyu�n', 'di�&n vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3580, '�R证', 'y�nzh�ng', 'kiỒm chứng, x�c nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3581, '�奏', 'yǎnz�u', 'di�&n tấu, biỒu di�&n nhạc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3636, '以后', 'yǐh�u', 'sau n�y, sau khi', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3653, '饮�"', 'yǐnli�o', 'nư�:c u�ng, �� u�ng', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3584, '要', 'y�o', 'cần, phải, mu�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3585, '��', 'yǎo', 'cắn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3586, '要不', 'y�ob�', 'nếu kh�ng th�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3587, '要不��', 'y�ob�r�n', 'nếu kh�ng th�, bằng kh�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3588, '�!� ', 'y�obǎi', '�ung �ưa, lắc lư', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3589, '�&�', 'yāo', 'eo, thắt lưng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3591, '謬�S�', 'y�oyǎn', 'ch�i mắt, l�a mắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3592, '遥�S', 'y�oyuǎn', 'xa x�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3593, '要素', 'y�os�', 'yếu t�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3594, '�!�"�', 'y�ohu�ng', '�ung �ưa, lắc lư', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3595, '遥控', 'y�ok�ng', '�iều khiỒn từ xa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3596, '要��', 'y�om�ng', 'chết người, kinh khủng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3597, '��请', 'yāoqǐng', 'mời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3598, '要�', 'yāoqi�', 'y�u cầu, ��i hỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3599, '���R"', 'y�oshi', 'ch�a kh�a', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3600, '�9�', 'yāy�', 'kiềm chế, n�n lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3601, '�9岁��', 'yāsu�qi�n', 'tiền mừng tu�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3602, '亚洲', 'y�zhōu', 'ch�u �', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3603, '�9迫', 'yāp�', '�p bức', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3605, '�9榨', 'yāzh�', '�p, b�p, vắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3606, '�9�ƶ', 'yāzh�', '�p chế, k�m n�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3607, '�S', 'y�', '��m', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3608, '页', 'y�', 'trang, tờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3609, '�x', 'y�:', 'cũng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3610, '业�"', 'y�y�', 'nghi�!p dư', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3611, '业务', 'y�w�', 'nghi�!p vụ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3612, '�!��:�', 'y�:m�n', 'man rợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3613, '�!�忒', 'y�:xīn', 'd� t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3654, '隐��', 'yǐnb�', 'ẩn n�u, giấu k�n', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3617, '�"', 'yǐ', 'thứ hai, Ất, B', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3618, '以', 'yǐ', 'lấy, b�xi v�, �Ồ, nhằm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3621, '丬边', 'yībiān', 'm�"t b�n, m�"t mặt, vừa... vừa...', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3622, '以便', 'yǐbi�n', '�Ồ, nhằm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3625, '�传', 'y�chu�n', 'di truyền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3627, '丬会��', 'y�hu�r', 'm�"t l�t, ch�c l�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3629, '移动', 'y�d�ng', 'di chuyỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3630, '丬度', 'y�d�', 'm�"t lần', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3633, '丬�&�', 'yīg�ng', 't�"ng c�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3634, '以�&�', 'yǐmiǎn', 'tr�nh, khỏi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3637, '��', 'y�hu�', 'nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3638, '以及', 'yǐj�', 'v�, c�ng v�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3639, '��见', 'y�ji�n', '� kiến, quan �iỒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3640, '已经', 'yǐjīng', '��, r�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3641, '依��', 'yīji�', 'như cũ, vẫn như trư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3642, '依靠', 'yīk�o', 'dựa v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3643, '丬举两�', 'yīj�liǎngd�', 'm�"t c�ng ��i vi�!c', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3644, '以来', 'yǐl�i', 'từ nay, tr�x lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3645, '�R��', 'yīli�o', 'y tế, chữa b�!nh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3646, '��""', 'y�li�', '�Ồ lại, lưu lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3647, '丬流', 'yīli�', 'hạng nhất, loại m�"t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3648, '丬�9', 'yīl�S', '�ều, như nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3650, '丬�:�� ��', 'yīm� liǎor�n', 'nh�n m�"t c�i l� hiỒu ngay', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3651, '��', 'y�n', 'bạc', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3652, '�ܴ', 'yīn', '�m, trời r�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3655, '�:�此', 'yīncǐ', 'v� thế, do ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3656, '�"导', 'yǐndǎo', 'hư�:ng dẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3657, '�:��R', 'yīn�"�r', 'v� thế, do ��', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3658, '硬', 'y�ng', 'cứng, rắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3659, '硬币', 'y�ngb�', 'tiền xu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3660, '迎接', 'y�ngji�', '��n tiếp, ngh�nh ��n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3662, '�9�俊', 'yīngj�n', 'anh tuấn, kh�i ng�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3663, '�:��Ʃ', 'y�ngl�', 'lợi nhuận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3664, '�9��܎', 'yīngm�ng', 's�ng su�t, anh minh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3666, '影��', 'yǐngxiǎng', 'ảnh hư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3668, '���', 'y�ngfu', 'ứng ph�, ��i ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3670, '���', 'y�ngp�n', 'ứng tuyỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3677, '���R', 'y�nh�ng', 'ng�n h�ng', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3688, '�x���', 'yīnxiǎng', 'nhạc cụ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3679, '隐�', 'yǐnm�n', 'che giấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3680, '�ܴ�9', 'yīnm�u', '�m mưu', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3684, '印�Ʒ', 'y�nshuā', 'in ấn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3708, '����睬', 'y�w�izh�', 'nghĩa l�', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3710, '�0务', 'y�w�', 'nghĩa vụ', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3717, '���', 'y�zh�', '� ch�', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3763, '幼稚', 'y�uzh�', 'ấu trĩ, non n�:t', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3734, '���', 'y�ngt�', 'c�ng dụng, phạm vi sử dụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3635, '以徬', 'yǐwǎng', 'trư�:c kia, trong qu� khứ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3665, '�9��:', 'yīngxi�ng', 'anh h�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3669, '���', 'y�ngy�ng', 'ứng dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3671, '��&�', 'y�ngchou', 'ti�!c t�ng, x� giao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3672, '���', 'y�ngyāo', 'nhận lời mời', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3673, '��', 'y�ngdāng', 'n�n, phải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3675, '影子', 'yǐngzi', 'b�ng, h�nh b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3676, '迎��', 'y�ngh�', '��n �, chiều l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3678, '隐��', 'yǐnhu�n', 'tai hoạ ngầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3682, '�"��', 'yǐnq�ng', '��"ng cơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3683, '饮�x', 'yǐnsh�', 'Ēn u�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3685, '�:�素', 'yīns�', 'nh�n t�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3686, '�:�为', 'yīnw�i', 'b�xi v�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3687, '印象', 'y�nxi�ng', 'ấn tượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3689, '�"��', 'yǐny�ng', 'tr�ch dẫn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3690, '隐约', 'yǐnyu�', 'lờ mờ, thấp tho�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3691, '�x�乐', 'yīnyu�', '�m nhạc', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3693, '以�0�', 'yǐqi�n', 'trư�:c ��y, trư�:c kia', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3694, '丬��!', 'yīqi�', 'tất cả', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3695, '�&��', 'y�r�n', 'ki�n quyết, kh�ng do dự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3696, '依��', 'yīr�n', 'như cũ, vẫn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3697, '丬���徬', 'yīr�j�wǎng', 'trư�:c sau như m�"t', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3698, '�R��x', 'yīsh�ng', 'b�c sĩ', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3699, '仪式', 'y�sh�', 'nghi l�&, nghi thức', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3700, '��� ', 'y�sh�', '� thức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3702, '��欝', 'y�si', '� nghĩa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3703, '丬丝不�9x', 'yīsīb�g�u', 'cẩn thận, kh�ng sơ suất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3704, '���:�', 'y�t�', 'mục ��ch, � ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3705, '依�0�', 'yītuō', 'dựa v�o, nhờ v�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3706, '���', 'y�w�i', 'bất ngờ, ngo�i � mu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3707, '以为', 'yǐw�i', 'tư�xng rằng, cho rằng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3709, '���', 'y�w�n', 'nghi ngờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3712, '丬样', 'y�y�ng', 'gi�ng như', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3713, '���0', 'y�y�', '� nghĩa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3714, '�R��"�', 'yīyu�n', 'b�!nh vi�!n', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3715, '丬� �', 'y�z�i', 'nhiều lần, hết lần n�y �ến lần kh�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3716, '丬�:�', 'yīzh�', 'li�n tục, su�t, lu�n lu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3718, '��ƶ', 'y�zh�', 'kiềm chế, k�m h�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3719, '丬�!�', 'y�zh�', 'nhất tr�, ��ng l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3720, '以�!�', 'yǐzh�', 'do ��, khiến cho', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3721, '�&子', 'yǐzi', 'ghế', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3722, '�9�抱', 'yōngb�o', '�m, c�i �m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3724, '���x', 'y�nggōng', 'chĒm ch�0, si�ng nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3725, '永�', 'y�ngh�ng', 'vĩnh hằng, m�i m�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3726, '���Ʒ', 'y�ngh�', 'người sử dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3727, '�9�护', 'yōngh�', 'ủng h�", t�n th�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3728, '�9��R�', 'yōngjǐ', 'chật ch�"i, ��ng ��c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3729, '�9!�', 'y�ngq�', 'dũng cảm, can �ảm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3730, '��', 'y�ng', 'd�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3731, '�9!于', 'y�ngy�', 'd�m, c� gan', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3733, '��人', 'y�ngr�n', 'd�ng người', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3735, '庸�', 'yōngs�', 'tầm thường, dung tục', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3736, '�R现', 'y�ngxi�n', 'tu�n ra, xuất hi�!n nhiều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3737, '�9��S0', 'y�ngy�u', 'c�, s�x hữu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3738, '永�S', 'y�ngyuǎn', 'vĩnh vi�&n, m�i m�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3739, '踊跒', 'y�ngyu�', 'nhảy nh�t, hĒng h�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3740, '��', 'y�u', 'do, b�xi, từ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3741, '��', 'y�u', 'lại, vừa⬦lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3742, '�S0', 'y�u', 'c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3744, '油��', 'y�u zh�', 'r�n bằng dầu mỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3745, '右边', 'y�ubiān', 'b�n phải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3746, '幼���:�', 'y�u�"�ryu�n', 'trường mẫu gi�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3747, '�9好', 'y�uhǎo', 'bạn th�n, th�n thi�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3748, '��撠', 'yōuhu�', 'ưu ��i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3749, '�S0害', 'y�uh�i', 'c� hại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3750, '�S0趣', 'y�uq�', 'th� v�9, l� th�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3751, '�S0名', 'y�um�ng', 'n�"i tiếng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3752, '幽��', 'yōum�', 'h�i hư�:c, vui t�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3753, '游泳', 'y�uy�ng', 'bơi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3754, '��秬', 'yōuxi�', 'ưu t�, xuất sắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3755, '游�Ə', 'y�ux�', 'tr� chơi', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3757, '�9谊', 'y�uy�', 't�nh hữu ngh�9, bạn b�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3758, '���', 'yōuy�', 'xuất sắc, vượt tr�"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3759, '��于', 'y�uy�', 'b�xi v�, do', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3760, '犹豫', 'y�uy�', 'do dự, ngập ngừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3761, '忧钁', 'yōuy�', 'bu�n rầu, u sầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3762, '��越', 'yōuyu�', 'ưu vi�!t, vượt tr�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3764, '鱼', 'y�', 'c�', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3765, '��', 'y�', 'khoẻ b�!nh, hết b�!nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3766, '与', 'y�', 'v�:i, c�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3768, '�S ', 'yu�n', 'tr�n, vi�n m�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3769, '�S', 'yuǎn', 'xa, xa x�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3770, '�&���', 'yu�nd�n', 'tết Dương l�9ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3792, '��&读', 'yu�d�', '�ọc hiỒu', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3806, '运�', 'y�nq�', 'vận kh�, may mắn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3836, '灾难', 'zāin�n', 'tai nạn', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3872, '�0�', 'zhā', 'ch�ch, ��m, ��m v�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3793, '岳�ƶ', 'yu�f�', 'b� vợ', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3801, '�� 论', 'y�l�n', 'dư luận', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3823, '�习', 'y�x�', 'học trư�:c b�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3844, '��', 'z�zh�', 'tạp ch�', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3858, '遭�', 'zāosh�u', 'gặp, b�9, ch�9u', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3862, '�9', 'zǎ', 'th�', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3772, '�x�&', 'yu�nli�ng', 'thứ l�i, tha thứ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3773, '�x�"', 'yu�nli�o', 'nguy�n li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3775, '�:��', 'yu�nl�n', 'vườn, c�ng vi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3776, '�x�9', 'yu�nshǐ', 'nguy�n thuỷ, ban sơ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3777, '�x�&�', 'yu�nxiān', 'trư�:c kia, ban �ầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3778, '�&��', 'yu�nsh�u', 'nguy�n thủ, người �ứng �ầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3779, '�S�', 'yuǎnch�', 'nơi xa, ch� xa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3780, '�&�素', 'yu�ns�', 'nguy�n t�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3781, '���S:', 'yu�nw�ng', 'nguy�!n vọng, mong mu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3782, '� ��0', 'yuānwǎng', 'b�9 oan, oan u�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3783, '�&�宵�', 'yu�nxiāoji�', 'Tết Nguy�n Ti�u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3784, '����', 'yu�ny�', 'bằng l�ng, mong mu�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3785, '�x�:�', 'yu�nyīn', 'nguy�n nh�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3786, '�x��"', 'yu�nz�', 'nguy�n tắc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3788, '��蠢', 'y�ch�n', 'ngu xuẩn, ng�c nghếch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3789, '�订', 'y�d�ng', '�ặt trư�:c, dự ��9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3790, '�S�', 'yu�', 'th�ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3791, '越', 'yu�', 'vượt qua, ng�y c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3794, '约会', 'yu�hu�', 'hẹn h�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3795, '�S�亮', 'yu�liang', 'mặt trĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3797, '约�x', 'yu�sh�', 'hạn chế, r�ng bu�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3798, '语�"', 'y�fǎ', 'ngữ ph�p', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3799, '�0快', 'y�ku�i', 'vui vẻ, hạnh ph�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3800, '娱乐', 'y�l�', 'giải tr�', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3802, '羽�:琒', 'y�m�oqi�', 'cầu l�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3803, '�0米', 'y�mǐ', 'ng�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3804, '�&�许', 'y�nx�', 'cho ph�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3807, '运动', 'y�nd�ng', 'vận ��"ng, thỒ thao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3808, '�', 'y�n', 'm�y', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3809, '�""', 'yūn', 'say (xe, t�u), ch�ng mặt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3810, '�"�!', 'y�nf�', 'phụ nữ mang thai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3811, '运��', 'y�ny�ng', 'vận dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3813, '运�', 'y�nsu�n', 't�nh to�n, l�m to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3814, '运�R', 'y�nx�ng', 'vận h�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3815, '��Sx', 'y�qī', 'dự t�nh, mong �ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3816, '与�&�', 'y�q�', 'th�... c�n hơn', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3817, '语�', 'y�q�', 'ngữ kh�', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3818, '与��俱增', 'y�r�j�z�ng', 'tĒng l�n từng ng�y', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3819, '�ƶ�S�', 'y�f�', '��ng phục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3820, '��', 'y�su�n', 'dự to�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3821, '于�ܯ', 'y�sh�', 'thế l�, do ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3822, '欲�S:', 'y�w�ng', 'ham mu�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3824, '��&�', 'y�xiān', 'trư�:c ti�n, sẵn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3825, '语訬', 'y�y�n', 'ng�n ngữ', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3827, '�訬', 'y�y�n', 'truy�!n ngụ ng�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3828, '�訬', 'y�y�n', 'ti�n �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3830, '�!�"', 'y�zh�u', 'vũ trụ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3831, '�', 'z�', 'tạp, pha tạp', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3832, '��', 'z�n', 'ch�ng ta', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3833, '� �', 'z�i', 'lại, nữa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3835, '灾害', 'zāih�i', 'tai hoạ, thi�n tai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3837, '�S�', 'z�i', 'tại, �x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3838, '� �见', 'z�iji�n', 'tạm bi�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3839, '�S�乎', 'z�ihū', 'lưu �, �Ồ �', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3840, '� �接� ��0', 'z�iji�z�il�', 'kh�ng ngừng c� gắng, n� lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3841, '栽�x�', 'zāip�i', 'vun x�:i, vun tr�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3842, '�S���', 'z�iy�', 'lưu �, lưu t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3843, '�抬', 'z�j�', 'tạp kỹ, xiếc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3846, '赞�Ɛ', 'z�nch�ng', 't�n th�nh, ��ng �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3847, '��', 'zāng', 'bẩn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3848, '赞美', 'z�nm�:i', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3849, '��们', 'z�nmen', 'ch�ng ta', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3850, '���', 'z�nsh�', 'tạm thời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3851, '赞叹', 'z�nt�n', 'khen ngợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3852, '赞�R', 'z�nt�ng', 't�n ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3854, '赞助', 'z�nzh�', 't�i trợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3855, '鬠反', 'z�ofǎn', 'phản loạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3856, '�x�"', 'zāogāo', 'hỏng b�t, gay go', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3857, '���"�', 'zǎoch�n', 'bu�"i s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3859, '鬠�Ɛ', 'z�och�ng', 'tạo th�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3860, '遭�!', 'zāoy�', 'gặp gỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3861, '�"��x�', 'z�oyīn', 'tiếng �n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3863, '责�!', 'z�b�i', 'khiỒn tr�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3864, '责欪', 'z�gu�i', 'khiỒn tr�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3865, '贼', 'z�i', 'kẻ tr�"m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3866, '增加', 'z�ngjiā', 'tĒng th�m, tĒng l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3868, '增�"�', 'z�ngzhǎng', 'tĒng l�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3869, '欎��', 'z�:nme', 'thế n�o, sao, l�m sao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3870, '欎��样', 'z�:nme y�ng', 'thế n�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3871, '责任', 'z�r�n', 'tr�ch nhi�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3873, '�', 'zhǎi', 'hẹp, chật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3874, '��', 'zhāi', 'h�i, bẻ, ngắt, lấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3875, '嬺�Ƹ', 'zh�iqu�n', 'phiếu c�ng tr�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3876, '��要', 'zhāiy�o', 'tr�ch yếu, t�m tắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3919, '��', 'zh�', 'gập lại', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3895, '占据', 'zh�nj�', 'chiếm, giữ', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3953, '�Sx实', 'zh�nsh�', 'ch�n thật, ch�n thực', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3900, '占�S0', 'zh�ny�u', 'chiếm', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3902, '�0�', 'zhǎo', 't�m', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3905, '睬欥', 'zh�oj�', 's�t ru�"t, lo lắng', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3894, '�&��0!', 'zh�opi�n', 'bức ảnh', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3927, '珍贵', 'zh�ngu�', 'qu� gi�', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3954, '征��', 'zh�ngshōu', 'trưng thu', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3879, '����', 'zh�nd�u', 'chiến �ấu, ��nh nhau', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3880, '涨', 'zhǎng', 'l�:n, cĒng, trư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3881, '�S碍', 'zh�ng�"�i', 'chư�:ng ngại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3882, '�"���', 'zhǎngb�i', '��n anh, trư�xng b�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3883, '章�9', 'zhāngch�ng', '�iều l�!, quy tắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3884, '��夫', 'zh�ngfu', 'ch�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3885, '账�Ʒ', 'zh�ngh�', 't�i khoản', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3886, '帐篷', 'zh�ngpeng', 'lều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3887, '�R握', 'zhǎngw�', 'nắm vững', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3888, '�R声', 'zhǎngsh�ng', 'tiếng v� tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3889, '�&�常', 'zh�och�ng', 'như thường l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3890, '�&�顾', 'zh�og�', 'chĒm s�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3891, '召弬', 'zh�okāi', 'tri�!u tập, mời dự họp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3892, '�&�亮', 'zh�oli�ng', 'soi s�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3965, '�Sx� ', 'zh�nlǐ', 'ch�n l�, sự thật', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3973, '�S!�9', 'zh�nyā', '��n �p, trấn �p', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3896, '�"现', 'zhǎnxi�n', 'b�y ra, hi�!n ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3897, '崭��', 'zhǎnxīn', 'm�:i tinh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3898, '瞻仰', 'zhānyǎng', 'chi�m ngưỡng, nh�n cung k�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3899, '���役', 'zh�ny�', 'chiến d�9ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3977, '只', 'zhī', 'ch�0', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3901, '����0', 'zh�nzh�ng', 'chiến tranh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3903, '�9:�"�!', 'zhāo t�ubiāo', '�ấu thầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3904, '�9:�&', 'zhāod�i', 'chi�u ��i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3906, '睬�!0', 'zh�oli�ng', 'cảm lạnh, nhi�&m lạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3907, '�&��"', 'zh�oli�o', 'chĒm s�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3908, '睬迷', 'zh�om�', 'say m�, say sưa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3910, '�S�����9�', 'zhāoq� p�ngb�', 'tr�n �ầy kh� b�ng b�"t như kh�xi ban mai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3911, '�9:��', 'zhāoshōu', 'chi�u m�", tuyỒn nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3912, '�&�样', 'zh�oy�ng', 'như thường l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3913, '�&�謬', 'zh�oy�o', 'chiếu s�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3914, '�&��', 'zh�oy�ng', 'ph�i hợp, Ēn kh�:p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3915, '沼泽', 'zhǎoz�', '�ầm lầy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3916, '���', 'zh�pi�n', 'lừa d�i, lừa b�9p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3917, '�0�实', 'zhāshi', 'vững chắc, chắc chắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3918, '�&', 'zh�:', 'người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3921, '��磨', 'zh�m�', 'dằn vặt, gi�y v�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3922, '�ܵ', 'zh�n', 'trận, cơn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3923, '�S!荡', 'zh�nd�ng', 'trấn ��"ng, rung ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3924, '��对', 'zh�ndu�', 'nhằm v�o, chĩa v�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3925, '�R��9', 'zh�nf�n', 'phấn chấn, phấn kh�xi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3926, '�Sx', 'zh�n', 'thật, ch�nh x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3928, '诊��', 'zh�:ndu�n', 'chẩn �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3929, '�R�动', 'zh�nd�ng', 'rung ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3931, '�"!�"', 'zh�nj�ng', 'trấn tĩnh, �iềm tĩnh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3932, '正', 'zh�ng', 'ch�nh, ngay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3933, '���S', 'zh�ngf�', 'ch�nh phủ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3934, '正确', 'zh�ngqu�', 'ch�nh x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3935, '���', 'zh�ngc�', 'ch�nh s�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3936, '正常', 'zh�ngch�ng', 'b�nh thường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3937, '正�', 'zh�ngd�ng', 'giữa l�c, trong l�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3938, '�0端', 'zh�ngduān', 'tranh chấp', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3939, '�0夺', 'zh�ngdu�', 'tranh �oạt, tranh gi�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3940, '�"�顿', 'zh�:ngd�n', 'sắp xếp, ch�0nh ��n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3941, '正派', 'zh�ngp�i', 'ngay thẳng, �oan ch�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3942, '�"�齐', 'zh�:ngq�', 'ngĒn nắp, trật tự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3943, '正�', 'zh�ngguī', 'ch�nh quy, nề nếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3944, '正好', 'zh�nghǎo', 'vừa hay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3946, '正经', 'zh�ngjīng', '�oan trang, ch�nh ph�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3947, '证据', 'zh�ngj�', 'chứng cứ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3948, '�"�� ', 'zh�:nglǐ', 'ch�0nh l�, thu xếp, thu dọn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3949, '�0论', 'zh�ngl�n', 'tranh c�i, tranh luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3950, '证�܎', 'zh�ngm�ng', 'chứng minh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3951, '正�', 'zh�ngq�', 'bầu kh�ng kh� l�nh mạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3952, '�0�', 'zh�ngq�', 'tranh thủ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3955, '证书', 'zh�ngshū', 'giấy chứng nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3957, '�0�&�恐后', 'zh�ngxiānk�ngh�u', 'chen lấn l�n trư�:c sợ r�:t lại sau', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3958, '正�0', 'zh�ngy�', 'ch�nh nghĩa', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3959, '�0议', 'zh�ngy�', 'tranh luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3960, '正�S�', 'zh�ngz�i', '�ang', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3961, '��治', 'zh�ngzh�', 'ch�nh tr�9', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3962, '��!�', 'zh�ngzh�ng', 'nghi�m t�c, tr�9nh trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3963, '�!状', 'zh�ngzhu�ng', 'b�!nh trạng, tri�!u chứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3964, '�S!动', 'zh�nd�ng', 'trấn tĩnh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3966, '�ܵ容', 'zh�nr�ng', '��"i h�nh, ��"i ngũ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3967, '侦探', 'zh�nt�n', 'trinh th�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3968, '�"头', 'zh�:ntou', 'c�i g�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3969, '珍�S', 'zh�nxī', 'qu�, tr�n trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3970, '珍珠', 'zh�nzhū', 'ngọc trai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3971, '�Sx�:�', 'zh�nxi�ng', 'sự thật', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3974, '���&�', 'zh�teng', '�i qua �i lại, lĒn lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3975, '��学', 'zh�xu�', 'triết học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3976, '�:�', 'zh�', 'thẳng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3980, '��', 'zhī', '��"i, �ơn v�9 (vĒn, b�i c�y, c�n)', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3992, '�R!定', 'zhǐd�ng', 'ch�0 ��9nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3998, '�R!�R�', 'zhǐhuī', 'ch�0 huy', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4002, '�x��0', 'zhīju�', 'tri gi�c', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4018, '�"��" ', 'zh�shāng', 'IQ', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4019, '�R!使', 'zhǐshǐ', 'khiến cho, l�m cho', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4020, '�R!示', 'zhǐsh�', 'ch�0 th�9', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4022, '�R位', 'zh�w�i', 'chức v�9', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4027, '�R业', 'zh�y�', 'nghề nghi�!p', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4031, '�ƶ鬠', 'zh�z�o', 'chế tạo, l�m ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3979, '�9', 'zhī', 't�:i, c�i ��, ng�n từ, của', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4046, '中�9', 'zhōngl�', 'trung lập', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3981, '枝', 'zhī', 'c�nh, nh�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3982, '治�0', 'zh��"ān', 'tr�9 an, cảnh s�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3983, '�:���', 'zh�bō', 'ph�t s�ng trực tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3984, '���R�', 'zhīch�', 'ch�ng �ỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3986, '�R!�!�', 'zhǐchū', 'ch�0 ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3987, '�R!导', 'zhǐdǎo', 'ch�0 �ạo, hư�:ng dẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3988, '�x��', 'zhīd�o', 'biết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3989, '嬼�', 'zh�de', 'xứng ��ng, ��ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3990, '�ƶ定', 'zh�d�ng', 'chế ��9nh, lập ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3991, '�ƶ订', 'zh�d�ng', 'quy ��9nh, ��9nh ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4065, '��x', 'zhōu', 'thuyền', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3993, '�ƶ度', 'zh�d�', 'chế ��"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3994, '���', 'zhīf�ng', 'mỡ, chất b�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3996, '只好', 'zhǐhǎo', '��nh phải', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3997, '�"��&�', 'zh�hu�', 'tr� tu�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3999, '�R!��', 'zhǐjiǎ', 'm�ng tay', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4000, '�:�接', 'zh�ji�', 'trực tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4001, '�!�今', 'zh�jīn', 'cho �ến nay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4003, '�"��:', 'zh�l�', 'tr� lực, tr� kh�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4005, '置于', 'zh� y�', 'd�c sức cho', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4006, '质�!�', 'zh�li�ng', 'chất lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4007, '治�', 'zh�li�o', '�iều tr�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4008, '�R!令', 'zhǐl�ng', 'm�!nh l�!nh, ch�0 th�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4009, '滞�""', 'zh�li�', 'ngưng lại, dừng lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4010, '��流', 'zhīli�', 'nh�nh s�ng, d�ng chảy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4011, '植�0�', 'zh�w�', 'thực vật', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4012, '�R!���', 'zhǐn�nzh�n', 'kim ch�0 nam', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4014, '�"�蒽', 'zh�n�ng', 'tr� tu�!, ch� th�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4015, '���&�', 'zhīp�i', 'an b�i, sắp xếp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4016, '��票', 'zhīpi�o', 'chi phiếu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4017, '�0��9�', 'zh�q�n', 'chấp h�nh', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4021, '�R!�S:', 'zhǐw�ng', 'tr�ng chờ, mong �ợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4023, '植�', 'zh�sh�', 'c�y c�i', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4024, '�R务', 'zh�w�', 'chức vụ', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4025, '秩序', 'zh�x�', 'trật tự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4028, '���', 'zh�yu�n', 'ư�:c nguy�!n, ch� nguy�!n, gi�p �ỡ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4029, '����&', 'zh�yu�n zh�:', 't�nh nguy�!n vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4030, '�ƶ约', 'zh�yu�', 'chế ư�:c, kiềm h�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4032, '�0��&�', 'zh�zh�o', 'giấy ph�p', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4033, '���x�', 'zhīzh�', 'c�y trụ, trụ ch�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4035, '�ƶ�S', 'zh�zu�', 'chế tạo, l�m ra, chế ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4036, '�!�', 'zh�ng', 'nặng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4037, '种', 'zh�ng', 'loại, kiỒu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4038, '�x', 'zhōng', 'chu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4039, '��', 'zhōng', 'kết th�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4040, '�!���', 'zh�ngdiǎn', 'trọng �iỒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4041, '����', 'zhōngdiǎn', '�iỒm cu�i, �iỒm kết th�c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4042, '��于', 'zhōngy�', 'cu�i c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4043, '中�:�', 'zhōnggu�', 'Trung Qu�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4044, '中��', 'zhōngjiān', '�x giữa, b�n trong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4045, '��究', 'zhōngjiū', 'chung quy, cu�i c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4047, '�!��!�', 'zh�ngli�ng', 'trọng lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4048, '���ܤ', 'zh�ngli�', 'bư�:u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4050, '��身', 'zhōngsh�n', 'su�t �ời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4051, '�!�� ', 'zh�ngsh�', 'coi trọng, xem trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4052, '忠实', 'zhōngsh�', 'trung th�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4053, '��0����x�', 'zh�ngsu�zhōuzhī', 'ai ai cũng biết', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4054, '中�!', 'zhōngw�n', 'tiếng Trung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4055, '中��', 'zhōngw�', 'bu�"i trưa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4056, '中忒', 'zhōngxīn', 'trung t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4057, '�!���', 'ch�ngxīn', 'ch�n nản', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4059, '中央', 'zhōngyāng', 'trung t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4060, '�!�要', 'zh�ngy�o', 'quan trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4061, '种子', 'zh�ngzi', 'hạt', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4062, '种��', 'zh�ngz�', 'chủng t�"c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4063, '州', 'zhōu', 'ch�u (�ơn v�9 h�nh ch�nh)', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4066, '��边', 'zhōubiān', 'chu vi, xung quanh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4067, '���ư', 'zhōud�o', 'chu ��o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4068, '��� ', 'zhōum�', 'chu ��o chặt chẽ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4069, '���S�', 'zhōum�', 'cu�i tuần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4070, '��年', 'zhōuni�n', '�ầy nĒm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4071, '���:�', 'zhōuw�i', 'xung quanh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4072, '皱纹', 'zh�uw�n', 'nếp nhĒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4073, '�ܼ�S', 'zh�uy�', 'ng�y v� ��m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4075, '��转', 'zhōuzhuǎn', 'quay v�ng (d�ng v�n)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4076, '住', 'zh�', '�x, cư tr�, dừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4077, '祝', 'zh�', 'ch�c, ch�c mừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4078, '�x�', 'zh�', 'c�"t, ch�ng (gậy)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4079, '�&�', 'zh�', 'nấu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4080, '株', 'zhū', 'c�y', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4081, '�R�', 'zhū', 'con lợn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4082, '�', 'zhuā', 'nắm, bắt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4083, '�紧', 'zhuājǐn', 'nắm chắc, nắm vững', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4119, '�R!�"', 'zhǐyǐn', 'dẫn dắt', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4091, '�&�!', 'zhuāngb�i', 'trang thiết b�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4137, '�!��', 'z�b�i', 'tự ti', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4095, '壮��', 'zhu�ngli�', 'lừng lẫy, oanh li�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4098, '�严', 'zhuāngy�n', 'tr�ng nghi�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (551, '传说', 'zhu�nshuō', 'truyền kỳ, tiỒu thuyết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4144, '�!�豪', 'z�h�o', 'tự h�o', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4138, '��S�', 'zīb�:n', 'v�n', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4126, '�格', 'zīg�', 'tư c�ch', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4145, '�!�己', 'z�jǐ', 'tự m�nh, bản th�n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4147, '��询', 'zīx�n', 'tư vấn, trưng cầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4084, '赚', 'zhu�n', 'kiếm tiền, lợi nhuận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4085, '转弯', 'zhuǎnwān', 'ng�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4087, '��"�', 'zhuānch�ng', 'chuy�n m�n, �ặc trưng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4088, '��9', 'zhuānch�ng', 'chuyến �i �ặc bi�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4089, '��', 'zhu�ng', '�ụng, va chạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4090, '�&', 'zhuāng', 'h�a trang, trang phục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4149, '�!��:�:��x', 'z�l�g�ngsh�ng', 'tự lực c�nh sinh', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4092, '壮�', 'zhu�ngguān', '�� s�", tr�ng l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4093, '状� �', 'zhu�ngku�ng', 't�nh h�nh, t�nh trạng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4094, '壮丽', 'zhu�ngl�', 'tr�ng l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4151, '��"', 'z�m�', 'phụ �ề', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4096, '�&饰', 'zhuāngsh�', 'trang tr�, trang sức', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4097, '状欁', 'zhu�ngt�i', 'trạng th�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4152, '�母', 'z�m�', 'chữ c�i', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4099, '�业', 'zhuāny�', 'chuy�n ng�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4100, '��Ʃ', 'zhuānl�', 'bằng s�ng chế', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4102, '转让', 'zhuǎnr�ng', 'chuyỒn nhượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4103, '���', 'zhuānt�', 'chủ �ề �ặc bi�!t, chuy�n �ề', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4104, '�忒', 'zhuānxīn', 'chuy�n t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4105, '转移', 'zhuǎny�', 'thay ��"i v�9 tr�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4106, '转��', 'zhuǎnzh�', 'chuyỒn ngoặt, chuyỒn hư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4107, '主管', 'zh�guǎn', 'người chủ tr� t�" chức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4108, '鬐步', 'zh�b�', 'lần lượt, từng bư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4109, '注� R', 'zh�c�', '�Ēng k�', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4110, '主�R�', 'zh�ch�', 'chủ tr�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4111, '主导', 'zh�dǎo', 'chủ �ạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4112, '主动', 'zh�d�ng', 'chủ ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4113, '祝福', 'zh�f�', 'ch�c ph�c', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4115, '祝贺', 'zh�h�', 'ch�c mừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4116, '追�', 'zhuīqi�', 'theo �u�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4117, '追��', 'zhuīd�o', 'tư�xng ni�!m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4118, '追究', 'zhuījiū', 'truy cứu, truy vấn', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4154, '姿势', 'zīsh�', 'tư thế', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4121, '�名', 'zh�m�ng', 'n�"i tiếng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4122, '�! �!', 'zh�nb�i', 'chuẩn b�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4123, '�! 确', 'zh�nqu�', 'ch�nh x�c, ��ng �ắn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4124, '�! ��', 'zh�nsh�', '��ng giờ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4125, '�! ��"', 'zh�nz�', 'nguy�n tắc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4157, '�9��', 'zīw�i', 'm�i v�9', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4127, '磨绒', 'm�li�n', 'r�n luy�!n, tập luy�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4128, '护�09', 'h�sh�u', 'bảo v�! tay, chĒm s�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4129, '睬撳', 'zhu�xiǎng', 'suy nghĩ, lo nghĩ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4130, '�越', 'zhu�yu�', 'n�"i bật, tr�c vi�!t, l�i lạc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4131, '睬�!�', 'zhu�zh�ng', 'nhấn mạnh, ch� trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4132, '竹子', 'zh�zi', 'c�y tr�c', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4133, '�S��', 'zu�pǐn', 't�c phẩm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4134, '�', 'z�', 'chữ', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4135, '紫', 'zǐ', 'm�u t�m', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4159, '�!�信', 'z�x�n', 'tự tin', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4162, '�!���', 'z�yu�n', 'tự nguy�!n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4139, '�产', 'zīchǎn', 't�i sản', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4140, '�!�动', 'z�d�ng', 'tự ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4141, '子弹', 'zǐd�n', '�ạn', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4142, '��&�', 'z�diǎn', 'từ �iỒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4143, '�!��', 'z�fā', 'tự ph�t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4172, '踪迹', 'zōngj�', 'dấu vết', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4148, '��"', 'zīli�o', 'tư li�!u, dữ li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4150, '�!�满', 'z�mǎn', 'tự m�n', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4153, '�!���', 'z�r�n', 'tự nhi�n, thi�n nhi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4155, '�!�私', 'z�sī', '�ch kỷ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4158, '�� ', 'zǐx�', 't�0 m�0, cẩn thận', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4160, '�!��R车', 'z�x�ngch�', 'xe �ạp', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4161, '�!���', 'z�y�u', 'tự do', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4163, '�源', 'zīyu�n', 't�i nguy�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4164, '�9�"�', 'zīzhǎng', 'ph�t sinh, nảy sinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4165, '�助', 'zīzh�', 'trợ cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4166, '欻�ܯ', 'z�ng sh�', 'lu�n lu�n, l�c n�o cũng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4168, '欻�&�', 'z�ngg�ng', 't�"ng c�"ng, tất cả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4169, '综��', 'zōngh�', 't�"ng hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4170, '欻�R', 'z�ngh�', 't�"ng hợp, t�"ng s�', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4171, '纵横', 'z�ngh�ng', 'tung ho�nh, ngang dọc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4173, '��""', 'zōngji�o', 't�n gi�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4174, '欻�', 'z�ngji�', 't�"ng kết', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4175, '欻� ', 'z�nglǐ', 'thủ tư�:ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4176, '�"�0�', 'zōngs�', 'm�u n�u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4177, '欻�', 'z�ngsu�n', 'cu�i c�ng cũng, nh�n chung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4178, '欻�x', 'z�ngt�ng', 't�"ng th�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4180, '���', 'zōngzhǐ', 't�n ch�0, mục ��ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4181, '揍', 'z�u', '��nh �ập', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4182, '走', 'z�u', '�i, �i b�"', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4183, '走廊', 'z�ul�ng', 'h�nh lang', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4184, '走漏', 'z�ul�u', 'r� r�0 ra ngo�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4185, '走私', 'z�usī', 'bu�n lậu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (116, '报�ư', 'b�od�o', '�iỒm danh, b�o danh', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (455, '�9序', 'ch�ngx�', 'chương tr�nh, tr�nh tự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4219, '�S�&', 'zu�zh�:', 't�c giả', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (336, '裁��', 'c�iyu�n', 'giảm bi�n chế, cắt giảm nh�n vi�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (365, '���', 'c�hu�', 'l�n kế hoạch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (48, '把握', 'bǎw�', 'cầm, nắm, nắm bắt', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (70, '办�&�室', 'b�ngōngsh�', 'vĒn ph�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (77, '半��R�x', 'b�nt��"�rf�i', 'bỏ cu�"c giữa chừng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (89, '保�""', 'bǎoli�', 'giữ nguy�n, bảo t�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (103, '�� �', 'b�ofā', 'b�ng n�", b�"c ph�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (127, '把�09', 'bǎsh�u', 'tay nắm cửa, chu�i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (134, '��"', 'b�ibǐ', 'h�n hạ, ti ti�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (142, '�R�"�', 'b�ijǐng', 'b�i cảnh, nền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (152, '�驰', 'b�nch�', 'chạy nhanh, chạy bĒng bĒng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (169, '�', 'bǐ', 'so, so v�:i, v�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (176, '��动', 'bi�nd�ng', 'biến ��"ng, thay ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (192, '边��', 'biānyu�n', 'gi�p danh, v�ng ven, bi�n gi�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (202, '�!� ', 'biāozh�', 'c�"t m�c, k� hi�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (214, '弊�&', 'b�b�ng', 't�! nạn, tai hại, sai lầm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (227, '�记�S�', 'bǐj�b�:n', 'v�x ghi ch�p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (237, '并��', 'b�ngli�', '�ặt cạnh nhau, ngang h�ng', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (250, '�&须', 'b�xū', 'phải, cần phải', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (261, '博��会', 'b�lǎnhu�', 'h�"i chợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (271, '补偿', 'b�ch�ng', 'b�i thường, �ền b�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (272, '不�', 'b�d�ng', 'kh�ng ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (274, '不见�', 'b�ji�nde', 'chưa chắc, kh�ng nhất thiết', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (283, '不訬�R��', 'b� y�n �r y�', 'kh�ng n�i cũng r�', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (290, '不�已', 'b�d�yǐ', 'bất �ắc dĩ, bất �ắc phải', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (302, '不可欝议', 'b�k�:sīy�', 'phi thường, kh�ng thỒ tư�xng tượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (315, '不�9��09段', 'b�z�sh�udu�n', 'kh�ng từ thủ �oạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (330, '材�"', 'c�ili�o', 'vật li�!u, tư li�!u', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (350, '��9', 'cānm�u', 'tham mưu, c� vấn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (370, '��!�不穷', 'c�ngchūb�qi�ng', 'li�n tiếp xuất hi�!n, tầng tầng l�:p l�:p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (380, '差距', 'chāj�', 'khoảng c�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (386, '产�x', 'chǎnsh�ng', 'xuất hi�!n, sản sinh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (402, '�S���', 'chǎngh�', 'trường hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (414, '嬡议', 'ch�ngy�', '�ề xuất, s�ng kiến', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (426, '�ܲ�', 'ch�oxi�o', 'nhạo b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (439, '�Ɛ忒', 'ch�ngxīn', 'th�nh t�m, c� �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (466, '��务��', 'ch�ngw�yu�n', 'nh�n vi�n phục vụ (tr�n t�u, m�y bay)', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (482, '称忒���', 'ch�nxīn r�y�', 'vừa l�ng �ẹp �', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (497, '� �', 'chōng', 'va �ập, ��"t k�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (507, '�!��ܳ�', 'ch�ngy�ng ji�', 'tết Tr�ng Dương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (518, '�!��:�', 'chūgu�', 'ra nư�:c ngo�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (526, '抽空', 'chōuk�ng', 'd�nh thời gian, tranh thủ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (535, '传达', 'zhuǎnd�', 'truyền tải', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (541, '床�"', 'chu�ngdān', 'khĒn trải giường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (547, '川流不息', 'chuānli�b�xī', 'd�ng nư�:c chảy li�n tục, kh�ng ngừng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (579, '�!�息', 'chūxī', 'triỒn vọng, tiến b�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (586, '�ƺ', 'c�', '��m, chọc, ch�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (588, '次��', 'c� pǐn', 'loại hai, thứ phẩm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4187, '�x', 'zū', 'thu�, mư�:n, cho thu�, tiền thu�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4188, '�ܻ碍', 'z��"�i', 'cản tr�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4189, '���x�', 'zu�nsh�', 'kim cương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4190, '���', 'zuāny�n', 'nghi�n cứu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4214, '做�x��', 'zu� sh�ngy�', 'l�m kinh doanh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4192, '��ƶ', 'z�f�', '�ng n�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4194, '���', 'z�h�', 't�" hợp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4195, '�S�', 'zu�', 'nhất', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4197, '�ܴ', 'zuǐ', 'mi�!ng, m�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4198, '�S�好', 'zu� hǎo', 't�t nhất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4199, '�ܴ�!', 'zuǐch�n', 'm�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4200, '罪犯', 'zu�f�n', 't�"i phạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4201, '�S�后', 'zu�h�u', 'cu�i c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4202, '�S��', 'zu�j�n', 'gần ��y, dạo n�y', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4203, '�ܻ止', 'z�zhǐ', 'ngĒn cản, ngĒn tr�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4204, '�x赁', 'zūl�n', 'thu�, cho thu�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4206, '尊�"�', 'zūnj�ng', 't�n k�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4207, '遵��', 'zūnsh�u', 'tu�n thủ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4208, '遵循', 'zūnx�n', 'theo, tu�n theo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4209, '尊严', 'zūny�n', 't�n nghi�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4210, '尊�!�', 'zūnzh�ng', 't�n trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4211, '坐', 'zu�', 'ng�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4212, '座', 'zu�', 'ch� ng�i, ��!m, t�a', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4213, '�S�S', 'zu�dōng', 'l�m chủ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4218, '�S为', 'zu�w�i', 'h�nh vi, vi�!c l�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4216, '�S�!', 'zu�w�n', 'viết vĒn, l�m vĒn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4217, '�S��', 'zu�y�ng', 't�c dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (488, '吒撊', 'chījīng', 'giật m�nh, sợ h�i', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4220, '�ܨ天', 'zu�tiān', 'h�m qua', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4221, '左边', 'zu�biān', 'b�n tr�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4222, '�S�x', 'zu�f�i', 'x�a bỏ, mất hi�!u lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4223, '�S风', 'zu�f�ng', 'phong c�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4224, '座位', 'zu�w�i', 'ch� ng�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4225, '�S业', 'zu�y�', 'b�i tập', NULL, 32);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4227, '足�x', 'z�g�u', '�ủ', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4228, '��&�', 'z�xiān', 't�" ti�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4229, '��!', 'z�zhī', 't�" chức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (567, '�墒', 'ch�j�ng', 'cảnh ng�", ho�n cảnh', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4191, '��Ɛ', 'z�ch�ng', 'cấu th�nh, tạo th�nh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (597, '辞�R', 'c�zh�', 'từ chức', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (605, '从�0�', 'c�ngqi�n', 'trư�:c ��y, ng�y trư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (636, '�0抱不平', 'dǎb�ob�p�ng', 'b�nh vực, b�nh kẻ yếu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (650, '代表', 'd�ibiǎo', '�ại biỒu, �ại di�!n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (664, '�"纯', 'dānch�n', '�ơn giản, �ơn thuần', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (674, '��S�', 'dāngd�', 'bản ��9a, bản xứ', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (684, '���', 'dāngsh�', 'l�c ��, khi ��', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (688, '�&��0', 'dǎngxuǎn', 'tr�ng cử', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (690, '淡却', 'd�nqu�', 'nhạt �i, phai nhạt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (703, '�ư达', 'd�od�', '�ến nơi, �ạt �ến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (723, '大使', 'd�shǐ', 'trạng trọng, kh�ng ki�ng nỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (738, '�不偿失', 'd�b�ch�ngshī', 'hại nhiều hơn lợi, lợi �t hại nhiều', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (753, '�天�9�厚', 'd�tiānd�h�u', 'gặp may mắn, �ược ưu �i', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (773, '��头', 'di�nt�u', 'gật �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (783, '谒�x�', 'di�och�', '�iều tra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (794, '�S���', 'd�fāng', '��9a phương, ch�, nơi, v�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (795, '抵�', 'dǐk�ng', 'ch�ng lại, �ề kh�ng, ch�ng cự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (803, '�确', 'd�qu�', 'thật, ��ch thực', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (824, '���9�"�', 'd�ngsh� zhǎng', 'chủ t�9ch h�"i ��ng quản tr�9', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (843, '��绝', 'du�nju�', 'cắt �ứt, �oạn tuy�!t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (854, '对��', 'du�fāng', 'ph�a b�n kia, ��i phương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (879, '顿��', 'd�nsh�', 'ngay, liền, tức khắc', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (892, '读书', 'd�shū', '�ọc s�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (896, '恶忒', '�:xīn', 'bu�n n�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (900, '�R�', '�rqi�:', 'm� c�n, hơn nữa', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (917, '�火', 'fāhu�', 'n�"i giận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (923, '反驳', 'fǎnb�', 'b�c bỏ, phản ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (937, '��', 'fāng', 'vu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (942, '��便', 'fāngbi�n', 'thuận ti�!n, thuận lợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (957, '���ܠ', 'f�ngy�ng', 'tr�nh chiếu, chiếu phim', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (968, '璦恼', 'f�nnǎo', 'phiền n�o, phiền mu�"n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (981, '�訬', 'fāy�n', 'ph�t biỒu', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (991, '诽谤', 'f�:ib�ng', 'n�i xấu, ph�0 b�ng, gi�m pha', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (997, '飞禽走�&�', 'f�iq�n z�ush�u', 'chim bay c� nhảy, chim trời c� nư�:c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1006, '�� �ƫ', 'f�nbi�', 'ph�n bi�!t', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1012, '丰�::', 'f�ngsh�ng', 'phong ph�, nhiều, gi�u c�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1022, '丰满', 'f�ngmǎn', 'sung t�c, �ầy �ủ, �ầy ắp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1037, '�� �!�', 'f�nli�ng', 'trọng lượng, sức nặng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1055, '�位', 'gǎngw�i', 'cương v�9, v�9 tr� c�ng t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1068, '干�0', 'gānsh�', 'can thi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1077, '���&', 'gāochāo', 'cao si�u, tuy�!t vời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1087, '���x�&�路', 'gāos� gōngl�', '�ường cao t�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1102, '根据', 'g�nj�', 'cĒn cứ, dựa v�o', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1109, '�:���', 'g�ngxīn', 'thay m�:i, ��"i m�:i, canh t�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1118, '��己见', 'g�shūjǐji�n', 'm�i người �ưa ra � kiến của ri�ng m�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1135, '�&��&�', 'gōngguān', 'giao tiếp, ��i ngoại, x� h�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1147, '�x蒽', 'gōngn�ng', 'c�ng nĒng, t�c dụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1158, '�x��', 'gōngy�ng', 'c�ng nĒng, c�ng hi�!u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1172, '购�', 'g�uji�', 'c�u kết, th�ng ��ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1184, '�&���', 'guānji�n', 'then ch�t, mấu ch�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1198, '�&0�', 'guānghu�', 'trơn tru, nhẵn b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1200, '广��', 'guǎngku�', 'r�"ng l�:n, b�t ng�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1217, '�动', 'g�d�ng', 'c�" ��"ng, khuyến kh�ch, x�i giục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1230, '��R�', 'guīf�n', 'quy tắc, ti�u chuẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1240, '估计', 'gūj�', '��nh gi�, ư�:c �o�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1252, '�!�9', 'gu�ch�ng', 'qu� tr�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1271, '�!�ܾ', 'gu�yǐn', 'thỏa nguy�!n, thỏa th�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1274, '��', 'z�nqi�:', 'tạm thời', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1284, '�:��S0', 'g�y�u', 'v�n c�, sẵn c�, c� hữu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1286, '顽�:�', 'w�ng�', 'bư�:ng b�0nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1297, '海�9', 'hǎiy�ng', 'biỒn, �ại dương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1308, '�"见', 'hǎnji�n', 'hiếm thấy, �t thấy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1323, '好咏', 'hǎoxi�ng', 'h�nh như, dường như', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1332, '��格', 'h�g�', 'hợp l�!, �ạt chuẩn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1344, '恨不�', 'h�:nb�d�', 'hận kh�ng thỒ, mu�n', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1361, '红�R&', 'h�ngbāo', 'tiền thư�xng, tiền l� x�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1369, '后顾�9忧', 'h�ug�zhīyōu', 'n�i lo về sau', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1380, '花��', 'huāb�n', 'c�nh hoa', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1389, '换', 'hu�n', '��"i, thay ��"i, trao ��"i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1401, '�&R张', 'huāngzhāng', 'hoang mang, r�i loạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1412, '���:!添足', 'hu�sh�tiānz�', 'vẽ rắn th�m ch�n, vẽ vời v� �ch, l�m chuy�!n dư thừa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1433, '�:�顾', 'hu�g�', 'nh�n lại, h�i tư�xng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1444, '���', 'h�li�nwǎng', 'internet', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1451, '�身', 'h�nsh�n', 'to�n th�n, khắp người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1462, '火箭', 'hu�ji�n', 't�n lửa, hỏa ti�&n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1474, '���"�', 'hūxi�o', 'g�o th�t, r�t, h� h�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1500, '坚强', 'jiānqi�ng', 'mạnh mẽ, ki�n cường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (712, '��0', 'd�oqi�n', 'xin thứ l�i, xin ch�9u l�i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (869, '对�', 'du�k�ng', '��i kh�ng, ��i �ầu', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1487, '家常', 'jiāch�ng', 'vi�!c thường ng�y, chuy�!n nh�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (812, '抵�ƶ', 'dǐzh�', 'ngĒn chặn, ngĒn lại', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (864, '推', 'tuī', '�ẩy, ��n, m�x r�"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (906, '�ƶ止', 'zh�zhǐ', 'ngĒn cấm, chặn �ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1110, '�:���', 'g�nggǎi', 'cải ch�nh, ��nh ch�nh, sửa lại', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1263, '�:�� �', 'gu�q�ngji�', 'ng�y qu�c kh�nh', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1484, '驾驶', 'ji�shǐ', 'l�i xe', NULL, 28);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1512, '�0�影', 'jiǎnyǐng', 'b�ng cắt, h�nh b�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1532, '交徬', 'jiāowǎng', 'qua lại, lui t�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1534, '饺子', 'jiǎozi', 'b�nh chẻo, sủi cảo', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1552, '践踏', 'ji�nt�', 'dẫm, giẫm, gi�y x�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1563, '坚贞', 'jiānzh�n', 'quả l�, thật l�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1574, '交�0', 'jiāosh�', 'can thi�!p, ��m ph�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1589, '���&', 'j�b�ng', 'b�!nh tật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1596, '濬动', 'jīd�ng', 'k�ch ��"ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1603, '���', 'ji�r�', 'ng�y tết, ng�y l�&', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1611, '竭尽�&��:', 'ji�j�n qu�nl�', 'd�c to�n lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1623, '接�', 'ji�sh�u', 'tiếp nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1632, '�x助', 'ji�zh�', 'nhờ v�o, cậy v�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1644, '�S�会', 'jīhu�', 'cơ h�"i, d�9p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1655, '濬励', 'jīl�', 'kh�ch l�!, khuyến kh�ch', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1674, '经常', 'jīngch�ng', 'thường, thường xuy�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1688, '精�!�', 'jīngzh�', 'tinh tế', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1700, '精�! ', 'jīngzh�n', 'ch�nh x�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1709, '�!融', 'jīnr�ng', 't�i ch�nh', NULL, 38);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1721, '抬巧', 'j�qiǎo', 'kỹ xảo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1725, '�: 中', 'j�zhōng', 'tập trung', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1731, '计��S�', 'j�su�njī', 'm�y t�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1747, '继徬弬来', 'j�wǎng kāil�i', 'tiếp n�i người trư�:c, m�x l�i cho người sau', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1756, '欥于��Ɛ', 'j�y� qi�ch�ng', 'v�"i v�ng mong �ạt �ược th�nh c�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1773, '� ��:', 'ju�s�i', 'trận chung kết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1787, '� :��x', 'jūndu�', 'qu�n ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1815, '砍', 'kǎn', 'chặt', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1821, '�&��&�', 'kāngkǎi', 'h�o ph�ng, h�ng h�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1839, '客�ƿ', 'k�f�ng', 'ph�ng kh�ch (kh�ch sạn)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1840, '客�', 'k�guān', 'kh�ch quan', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1842, '课�9', 'k�ch�ng', 'l�9ch dạy học', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1855, '课�', 'k�t�ng', 'l�:p học, giảng �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1856, '客��', 'k�zh�n', 'qu�n trọ (nếu trong ảnh dừng �x 2163 kh�c, bạn cho m�nh ảnh r� d�ng cu�i �Ồ m�nh sửa ��ng)', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1863, '可见', 'k�:ji�n', 'c� thỒ thấy', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1871, '可�', 'k�:xi�o', 'nực cười, bu�n cười', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1885, '�R�', 'ku�', 'cắp, x�ch, kho�c, �ai', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1895, '�:�', 'k�n', 'kh�n kh�", kh� khĒn, m�!t, bu�n ngủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1910, '謁板', 'lǎobǎn', '�ng chủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1919, '�9��', 'k�xi�o', 'cười kh�", cười gượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1942, '謁� � ', 'lǎopopo', 'b� n�"i, b� ngoại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1957, '� �却', 'l�:ngqu�', 'l�m lạnh, �Ồ ngu�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1970, '�0害', 'l�h�i', 'lợi hại, dữ d�"i, gay gắt', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1990, '聊天', 'li�otiān', 't�n gẫu, tr� chuy�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1995, '��欧', 'li�x�ng', 'mạnh mẽ, dữ d�"i, gay gắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2007, '�:�0�蒽及', 'l�su�n�ngj�', 'khả nĒng cho ph�p', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2021, '�""念', 'li�ni�n', 'lưu ni�!m, kỷ ni�!m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2032, '� �:��壮', 'lǐzh�q�zhu�ng', 'c�y ngay kh�ng sợ chết �ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2048, '轮�ƹ', 'l�nchu�n', 'thuyền chạy bằng hơi nư�:c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2060, '�S绎不绝', 'lu�y� b� ju�', 'lũ lượt k�o �ến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2068, '��:', 'ma', 'm�, nh�0', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2071, '麻��', 'm�b�', 'b�!nh t� li�!t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2080, '�x9��', 'm�iz�ng', 'ch�n giấu, ch�n cất', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2090, '�R���', 'm�ngr�n', 'm� t�9t, chẳng biết g�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2100, '�:�&', 'm�ob�ng', 'l�i, tật xấu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2112, '美丽', 'm�:il�', '�ẹp, xinh �ẹp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2123, '美�"', 'm�:imi�o', 'tuy�!t vời, tươi �ẹp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2137, '�&�费', 'miǎnf�i', 'mi�&n ph�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2150, '�SS�S', 'm�f�ng', 'ong', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2159, '名额', 'm�ng''�', 's� người', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2177, '迷失', 'm�shī', 'mất phương hư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2181, '����', 'm�cā', 'ma s�t', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2186, '莫名�&��"', 'm�m�ngq�mi�o', 'kh�ng hiỒu ra sao', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2191, '�S索', 'sōusu�', 't�m kiếm', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2198, '�S�头', 'm�tou', 'g�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2204, '謐忒', 'n�ixīn', 'ki�n nhẫn', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2212, '难堪', 'n�nkān', 'kh� ch�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2230, '年�', 'ni�nl�ng', 'tu�"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2238, '� S业', 'n�ngy�', 'n�ng nghi�!p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2248, '���"�', 'pānd�ng', 'leo, tr�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2258, '蒽�!�', 'n�ngli�ng', 'nĒng lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2267, '�!��:�', 'n�ngg�', 'cứng lại, ��ng �ặc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2279, '�"��&', 'n��d�i', 'h�nh hạ, ngược ��i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2289, '欧洲', 'ōuzhōu', 'ch�u u', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2294, '���x', 'p�idu�', 'xếp h�ng, sắp xếp', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2302, '��边', 'p�ngbiān', 'b�n cạnh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2311, '�&�偶', 'p�i�"�u', 'vợ, ch�ng, ph�i ngẫu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2325, '�0��', 'pīp�ng', 'ch�0 tr�ch, ph� b�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2333, '�9�搏', 'pīnb�', '�ấu tranh', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2343, '平��', 'p�ngfāng', 'vu�ng, b�nh phương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2380, '�:��&0', 'p�guāng', 'phơi b�y, l�" ra', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2390, '�0�', 'qi�n', 'trư�:c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2396, '签署', 'qiānsh�', 'k� t�n, k�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1665, '�代', 'j�nd�i', 'cận �ại', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1740, '�"济', 'ji�j�', 'cứu tế', NULL, 36);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2364, '���', 'p�qi', 't�nh kh�, t�m trạng, t�nh t�nh, t�nh c�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2397, '签证', 'qiānzh�ng', 'visa', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2169, '���', 'm�njiān', 'd�n gian', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1934, '垒�S�桶', 'lājīt�ng', 'th�ng r�c', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1983, '连�R', 'li�nt�ng', 't�nh cả, g�p lại, kỒ cả', NULL, 25);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (1689, '竞�0', 'zh�ngzh�ng', 'ngo ngoe, vung vẫy, �ấu tranh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2219, '���x', 'n�ozhōng', '��ng h� b�o thức', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2352, '平��', 'p�ngsh�', 'b�nh thường, ng�y thường', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2409, '强忍', 'qi�ngr�:n', 'nhẫn nh�9n, n�n nh�9n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2419, '�0�强�"会', 'qiānqi�ngf�hu�', 'gượng �p, cưỡng giải th�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2434, '巧巧', 'qi�qiǎo', '��ng l�c, vừa kh�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2448, '起�x', 'qǐf�', '�n hi�!p, bật lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2458, '�Sx��', 'q�jiān', 'd�9p, thời kỳ, thời gian', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2473, '�&楚', 'qīngchu', 'r� r�ng, minh mẫn, hiỒu r�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2487, '�&�ƽ', 'qīngshuǎng', 'd�& ch�9u, m�t mẻ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2497, '�9�劳', 'q�nl�o', 'si�ng nĒng, cần c�, cần mẫn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2507, '��', 'q�p�', 'kh� thế, quang cảnh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2516, '�Sx�"�', 'qīxi�n', 'kỳ hạn, thời hạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2537, '�x', 'rǎn', 'nhu�"m, m�, thế m�, song', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2549, '忍不住', 'r�:n b� zh�', 'kh�ng thỒ cưỡng lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2562, '璭忒��', 'r�xīnch�ng', 't�t bụng, nhi�!t t�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2573, '容�!�', 'r�ngli�ng', 'dung lượng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2578, '荣�0证书', 'r�ngy� zh�ngshū', 'giấy chứng nhận danh dự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2593, '人家', 'r�njiā', 'những người kh�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2605, '人欧', 'r�nx�ng', 'nh�n t�nh', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2610, '人质', 'r�nzh�', 'con tin', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2616, '�"�步', 's�nb�', '�i dạo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2622, '�0�彩', 's�cǎi', 'm�u sắc', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2630, '�:�0', 'shāixuǎn', 's�ng lọc, chọn lọc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2641, '上级', 'sh�ngj�', 'cấp tr�n, thượng cấp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2653, '��0�', 'sh�nli�ng', 'hảo t�m, lương thi�!n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2667, '设�!', 'sh�b�i', 'thiết b�9', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2673, '设��', 'sh�shī', 'thiết b�9, c�ng tr�nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2677, '神�!', 'sh�n q�', 'thần kỳ', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2691, '�x�&', 'sh�ngb�ng', 'b�9 �m, sinh b�!nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2704, '声�܎', 'sh�ngm�ng', 'tuy�n b�, thanh minh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2748, '似�', 'sh� de', 'dường như, tựa như', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2756, '��S�', 'sh�chǎng', 'th�9 trường, chợ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2768, '实话', 'sh�hu�', 'sự thật, n�i thật', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2779, '��"R�', 'sh�ji�guān', 'thế gi�:i quan', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2790, '�9�&', 'sh�q�ng', 'sự t�nh, sự vi�!c', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2812, '�9�0�', 'sh�w�', '�iều, vật, thứ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2823, '���"', 'shīzhǎn', 'ph�t huy, thi th� (nĒng lực)', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2838, '��', 'shuǎi', 'vung, quĒng, n�m', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2847, '�ƽ快', 'shuǎngku�i', 'sảng kho�i, d�& ch�9u', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2859, '水�S', 'shuǐgu�', 'hoa quả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2868, '��9', 'sh�l�', 'th�nh lập, x�y dựng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2882, '���', 'shūsh�', 'd�& ch�9u, thoải m�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2892, '丝毫', 'sīh�o', 'ti, t�, mảy may, ch�t n�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2902, '� ���R撮', 's�w�j�d�n', 'trắng trợn, kh�ng ki�ng nỒ g� cả', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2921, '随身', 'su�sh�n', 'mang theo, t�y th�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2938, '素�x主�0', 's�sh� zh�y�', 'chủ nghĩa Ēn chay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2953, '太极�9�', 't�ij�qu�n', 'th�i cực quyền', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2966, '�x', 't�ng', 'chuyến �i, lượt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2975, '探索', 't�nsu�', 'kh�m ph�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2983, '�"���', 't�oc�', '�� g�m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2993, '�0�定', 't�d�ng', '�ặc bi�!t, �ặc sắc', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3004, '天�0�', 'tiānc�i', 'thi�n t�i', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3015, '天�Sx', 'tiānzh�n', 'ng�y thơ, h�n nhi�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3024, '条�9', 'ti�ol�', 'luật l�!, �iều l�!', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3045, '�S顿', 't�ngd�n', 'tạm ngừng, ngắt qu�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3059, '鬚货� �蒬', 'tōng hu� p�ngzh�ng', 'sự lạm ph�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3069, '�R�&', 't�ngq�ng', '��ng cảm, th�ng cảm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3086, '�Sx', 't�', '�ất, th�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3095, '�&�', 'tuǐ', 'ch�n, ��i', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3115, '�9延', 'tuōy�n', 'tr� ho�n, k�o d�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3126, '歪', 'wāi', 'nghi�ng, l�!ch, xi�u vẹo', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3133, '��解', 'wǎji�:', 'sụp ��", tan r�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3151, '徬�9', 'wǎngsh�', 'chuy�!n cũ, qu� khứ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3160, '�9�S', 'wǎnxī', 'thương tiếc, x�t thương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3173, '违反', 'w�ifǎn', 'vi phạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3178, '微不足�', 'w�ib�z�d�o', 'kh�ng c� � nghĩa', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3191, '威�:', 'w�il�', 'sức mạnh, uy lực', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3215, '温�R', 'w�nh�', '�n h�a, nhẹ nh�ng', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3226, '�!�0�', 'w�ny�', 'vĒn ngh�!', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3235, '卧室', 'w�sh�', 'ph�ng ngủ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3240, '��可�0��', 'w�k�: f�ngg�o', 'kh�ng c� g� �Ồ n�i, mi�&n b�nh luận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3248, '��动于衷', 'w�d�ngy�zhōng', 'thờ ơ, l�nh �ạm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3269, '武�&', 'w�zhuāng', 'vũ trang', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3276, '�S�', 'xi�', 'r�ng m�y (s�ng hoặc t�i)', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3283, '�9��', 'xi�zhǎi', 'hẹp, chật hẹp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3299, '�"��ܱ', 'xi�njǐng', 'c�i bẫy', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3315, '�:�反', 'xiāngfǎn', 'tương phản, ngược lại', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3332, '�接', 'xi�nji�', 'li�n kết, n�i tiếp', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3343, '现任', 'xi�nr�n', '�ang giữ chức vụ', NULL, 23);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3351, '���', 'xiāod�', 'tẩy uế, khử tr�ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3353, '��费', 'xiāof�i', 'ti�u thụ, ti�u d�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3362, '�"��!', 'xi�ol�S', 'hi�!u suất, nĒng suất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3377, '�9��', 'xi�w�', 'bu�"i chiều', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2529, '群', 'q�n', 'bầy, ��n, t�p', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3290, '线', 'xi�n', 'sợi, �ường', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2719, '神话', 'sh�nhu�', 'truyền thuyết', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2722, '审� ', 'sh�:nlǐ', 'thẩm tra xử l�', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (2731, '身�', 'sh�ntǐ', 'cơ thỒ, th�n thỒ', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3103, '推荐', 'tuīji�n', 'gi�:i thi�!u, �ề cử', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3205, '维修', 'w�ixiū', 'sửa chữa, duy tu', NULL, 26);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3254, '��可���"', 'w�k�:n�ih�', '��nh ch�9u, bất lực', NULL, 22);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3310, '�:�似', 'xiāngs�', 'gi�ng, tương tự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3386, '协议', 'xi�y�', 'hi�!p ngh�9, thỏa thuận', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3399, '�&��9', 'xīngf�n', 'hưng phấn, phấn kh�ch', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3412, '���"�代谢', 'xīnch�nd�ixi�', 'sự thay cũ ��"i m�:i, trao ��"i chất', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3428, '欧�&', 'x�ngq�ng', 't�nh t�nh, t�nh nết', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3441, '��钎', 'xīnl�ng', 'ch� rỒ', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3448, '信任', 'x�nr�n', 'tin tư�xng, t�n nhi�!m', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3458, '忒��', 'xīnz�ng', 'tim', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3460, '�&�x', 'xiōngd�', 'anh em trai', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3467, '�:�x', 'xi�ngw�:i', 'h�ng vĩ, tr�ng l�!', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3480, '�S��乐见', 'xǐw�nl�ji�n', 'rất hoan ngh�nh, vui tai vui mắt', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3494, '��念', 'xu�nni�n', 'h�i h�"p, thấp thỏm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3507, '�:�上加�SS', 'xu�:sh�ngjiāshuāng', 'th�m kh�" n�y �ến kh�" kh�c, li�n tiếp gặp nạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3526, '循序渐�:', 'x�nx�ji�nj�n', 'tiến h�nh theo trật tự', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3540, '���', 'yǎnbi�n', 'ph�t triỒn, biến ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3544, '严�!�', 'y�nzh�ng', 'nghi�m trọng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3551, '样式', 'y�ngsh�', 'h�nh thức, kiỒu d�ng', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3565, '延�Sx', 'y�nqī', 'dời ng�y, k�o d�i thời hạn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3578, '�绎', 'yǎny�', 'di�&n d�9ch, suy luận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3590, '���0"��!齿', 'yǎoy�qi�chǐ', 'nghiến rĒng nghiến lợi', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3604, '�9缩', 'yāsuō', 'n�n, �p', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3614, '液�', 'y�tǐ', 'chất lỏng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3619, '丬�Ƭ', 'yībān', 'b�nh thường, ph�" biến', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3631, '丬� 风顺', 'yīfān f�ngsh�n', 'thuận bu�m xu�i gi�', NULL, 30);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3632, '衣�S�', 'yīfu', 'quần �o', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3649, '丬路平�0', 'yīl� p�ng�"ān', 'thượng l�" b�nh an', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3667, '营�&�', 'y�ngyǎng', 'dinh dưỡng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3681, '�"起', 'yǐnqǐ', 'g�y n�n, dẫn t�:i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3701, '�0��S�', 'y�sh�', 'ngh�! thuật', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3723, '�9!�"�', 'y�nggǎn', 'dũng cảm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3732, '���', 'y�ngchu', 'c�ng dụng, t�c dụng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3743, '�S0条不紊', 'y�uti�o b� w�:n', 'gọn g�ng, trật tự', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3756, '���&�', 'yōuxiān', 'quyền ưu ti�n', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3771, '�x��', 'yu�ng�o', 'nguy�n c�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3774, '�x来', 'yu�nl�i', 'v�n dĩ, ban �ầu', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3787, '�报', 'y�b�o', 'dự b�o', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3796, '乐谱', 'yu�p�', 'bản nhạc, nhạc ph�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3805, '运�', 'y�nshū', 'vận chuyỒn', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3826, '语�x�', 'y�yīn', '�m thanh, tiếng n�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3834, '� ��0', 'z�isān', 'nhiều lần, lặp lại', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3845, '�', 'zǎn', 't�ch lũy, trữ, gom lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3853, '赞�0�', 'z�ny�ng', 'khen ngợi, t�n dương', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3867, '赠鬁', 'z�ngs�ng', 'biếu, tặng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3877, '�"', 'zh�n', '�ứng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3878, '���0�ƪ��', 'zhǎndīngji�ti�:', 'ch�m �inh chặt sắt, dứt kho�t', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3893, '�&��:��S�', 'zh�oxi�ngjī', 'm�y chụp ảnh', NULL, 21);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3909, '�9:��', 'zhāop�n', 'tuyỒn dụng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3920, '遮�R�', 'zh�dǎng', 'che, ngĒn che', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3930, '�ܵ�S�', 'zh�nd�', 'trận ��9a, mặt trận', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3945, '证件', 'zh�ngji�n', 'giấy chứng nhận', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3956, '�"��', 'zh�:ngtǐ', 'to�n thỒ, t�"ng thỒ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3972, '�S!�&�', 'zh�nxīng', 'chấn hưng, hưng th�9nh', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3995, '����', 'zhīf�', '��ng phục', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4004, '治� ', 'zh�lǐ', 'th�ng tr�9, quản l�', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4013, '�R蒽', 'zh�n�ng', 'chức nĒng, c�ng nĒng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4034, '�x�足常乐', 'zhīz� ch�ng l�', 'tri t�c th� vui', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4049, '��年', 'zhōngni�n', 'su�t cả nĒm', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4058, '中��', 'zhōngx�n', 'trung tuần, giữa th�ng', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4074, '�9"劣', 'zhuōli�', 'trục trặc, trắc tr�x', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4086, '转��', 'zhuǎnbi�n', 'chuyỒn biến, thay ��"i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4101, '���', 'zhuānm�n', 'chuy�n m�n, chuy�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4120, '主流', 'zh�li�', 'chủ yếu, xu hư�:ng', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4136, '�深', 'zīsh�n', 'từng trải, th�m ni�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4146, '��!', 'zījīn', 'tiền v�n, quỹ', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4167, '欻�R訬�9', 'z�ng�"�ry�nzhī', 'n�i t�m lại', NULL, 35);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4179, '欻�9', 'z�ngzhī', 'n�i chung, t�m lại', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4186, '�', 'z�', 'nh�m, t�"', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4193, '��:�', 'z�gu�', 't�" qu�c', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4205, '�ܻ�R�', 'z�n�o', 'cản tr�x, ngĒn cản, ph� r�i', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4215, '�S息', 'zu�xī', 'l�m vi�!c v� ngh�0 ngơi', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4226, '座右��', 'zu�y�um�ng', 'lời rĒn, lời c�ch ng�n', NULL, 34);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3692, '丬起', 'yīqǐ', 'c�ng nhau', NULL, 24);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3711, '���', 'y�xi�ng', '� ��9nh, mục ��ch', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3767, '�!�ư', 'y� d�o', 'gặp phải, gặp �ược', NULL, 33);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3812, '�&��&�', 'y�nni�ng', 'ủ rượu, chuẩn b�9 (kỹ lưỡng)', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3978, '�R!', 'zhǐ', 'ch�0 ra, ng�n tay', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4156, '姿欁', 'zīt�i', 'tư thế, d�ng dấp', NULL, 37);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4026, '只要', 'zhǐy�o', 'ch�0 cần', NULL, 31);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (4114, '主�', 'zh�guān', 'chủ quan', NULL, 27);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3985, '�x�� ', 'zhīshi', 'tri thức, kiến thức', NULL, 40);
INSERT INTO public.vocabulary ("vocab_id", "chinese_word", "pinyin", "meaning_vn", "audio_url", "category_id") VALUES (3674, '�9��9!', 'yīngy�ng', 'anh dũng', NULL, 34);


--
-- Data for Name: vocabulary_box; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary_box ("box_id", "user_id", "created_at", "updated_at") VALUES (1, 2, '2026-01-05 11:57:47.748', '2026-01-05 11:57:47.748');
INSERT INTO public.vocabulary_box ("box_id", "user_id", "created_at", "updated_at") VALUES (2, 4, '2026-01-06 12:20:46.343', '2026-01-06 12:20:46.343');


--
-- Data for Name: vocabulary_box_item; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (1, 1, 32, true, false, 0, 0, 1, '2026-01-05 11:57:47.755', '2026-01-05 11:57:47.755');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (2, 1, 52, true, false, 0, 0, 1, '2026-01-05 11:57:48.774', '2026-01-05 11:57:48.774');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (3, 1, 55, true, false, 0, 0, 1, '2026-01-05 11:57:49.225', '2026-01-05 11:57:49.225');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (4, 1, 141, true, false, 0, 0, 1, '2026-01-05 11:57:49.67', '2026-01-05 11:57:49.67');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (5, 1, 122, true, false, 0, 0, 1, '2026-01-05 11:57:50.19', '2026-01-05 11:57:50.19');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (6, 1, 210, true, false, 0, 0, 1, '2026-01-05 11:57:50.624', '2026-01-05 11:57:50.624');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (7, 1, 219, true, false, 0, 0, 1, '2026-01-05 11:57:50.789', '2026-01-05 11:57:50.789');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (8, 1, 229, true, false, 0, 0, 1, '2026-01-05 11:57:51.159', '2026-01-05 11:57:51.159');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (9, 1, 143, true, false, 0, 0, 1, '2026-01-05 11:57:51.53', '2026-01-05 11:57:51.53');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (10, 1, 151, true, false, 0, 0, 1, '2026-01-05 11:57:51.883', '2026-01-05 11:57:51.883');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (14, 2, 97, true, false, 0, 0, 1, '2026-01-06 12:20:48.466', '2026-01-06 12:20:48.466');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (15, 2, 91, true, false, 0, 0, 1, '2026-01-06 12:20:48.849', '2026-01-06 12:20:48.849');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (16, 2, 151, true, false, 0, 0, 1, '2026-01-06 12:20:49.554', '2026-01-06 12:20:49.554');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (17, 2, 143, true, false, 0, 0, 1, '2026-01-06 12:20:49.891', '2026-01-06 12:20:49.891');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (11, 2, 32, true, true, 0, 0, 2, '2026-01-06 12:20:46.358', '2026-01-06 12:33:41.841');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (12, 2, 52, true, false, 0, 0, 3, '2026-01-06 12:20:47.618', '2026-01-06 12:33:42.85');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (13, 2, 55, true, false, 0, 0, 2, '2026-01-06 12:20:48.128', '2026-01-06 12:33:43.335');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (18, 2, 141, true, false, 0, 0, 2, '2026-01-06 12:20:50.232', '2026-01-06 12:33:43.656');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (19, 2, 122, true, false, 0, 0, 2, '2026-01-06 12:20:50.619', '2026-01-06 12:33:44.033');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (20, 2, 116, true, false, 0, 0, 2, '2026-01-06 12:20:51.822', '2026-01-06 12:33:44.376');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (31, 2, 171, true, false, 0, 0, 1, '2026-01-06 12:33:44.772', '2026-01-06 12:33:44.772');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (32, 2, 210, true, false, 0, 0, 1, '2026-01-06 12:33:45.088', '2026-01-06 12:33:45.088');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (33, 2, 219, true, false, 0, 0, 1, '2026-01-06 12:33:45.469', '2026-01-06 12:33:45.469');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (34, 2, 229, true, false, 0, 0, 1, '2026-01-06 12:33:45.866', '2026-01-06 12:33:45.866');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (35, 2, 284, true, false, 0, 0, 1, '2026-01-06 12:33:46.208', '2026-01-06 12:33:46.208');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (36, 2, 1652, true, false, 0, 0, 1, '2026-01-07 12:45:47.488', '2026-01-07 12:45:47.488');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (39, 2, 4027, true, false, 0, 0, 1, '2026-01-07 12:45:50.205', '2026-01-07 12:45:50.205');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (40, 2, 3343, true, false, 0, 0, 1, '2026-01-07 12:45:50.764', '2026-01-07 12:45:50.764');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (41, 2, 3710, true, false, 0, 0, 1, '2026-01-07 12:45:51.348', '2026-01-07 12:45:51.348');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (42, 2, 4022, true, false, 0, 0, 1, '2026-01-07 12:45:52.544', '2026-01-07 12:45:52.544');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (43, 2, 1106, true, false, 0, 0, 1, '2026-01-07 12:45:52.956', '2026-01-07 12:45:52.956');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (37, 2, 1128, true, false, 0, 0, 2, '2026-01-07 12:45:48.967', '2026-01-07 12:45:53.343');
INSERT INTO public.vocabulary_box_item ("item_id", "box_id", "vocab_id", "is_read", "is_memorized", "correct_count", "incorrect_count", "listen_count", "created_at", "updated_at") VALUES (38, 2, 4024, true, false, 0, 0, 2, '2026-01-07 12:45:49.85', '2026-01-07 12:45:54.184');


--
-- Data for Name: vocabulary_categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (21, 'S� �ếm & s� lượng', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (22, 'Con người & quan h�! x� h�"i', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (23, 'Nghề nghi�!p & c�ng vi�!c', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (24, 'Sức khỏe & cơ thỒ', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (25, 'Đ�"ng vật & thực vật', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (26, 'M�n Ēn & �� u�ng', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (27, 'Đ� d�ng & quần �o', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (28, 'Phương ti�!n & giao th�ng', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (29, 'Đ�9a �iỒm & m�i trường', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (30, 'Thời gian & thời tiết', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (31, 'Giải tr� & s�x th�ch', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (32, 'Trường học & học tập', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (33, 'Ng�n ngữ & giao tiếp', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (34, 'T�nh từ & �ặc �iỒm', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (35, 'Từ loại �ặc bi�!t & trợ từ', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (36, 'VĒn h�a � th�i quen � l�& nghi', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (37, 'Mua sắm & giao d�9ch', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (38, 'C�ng vi�!c, kinh doanh', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (39, 'Hoạt ��"ng thường ng�y', NULL);
INSERT INTO public.vocabulary_categories ("id", "name_vi", "name_en") VALUES (40, 'Đ�"ng từ', NULL);


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

