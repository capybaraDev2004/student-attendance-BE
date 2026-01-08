-- Add attempt_date + completed_at and change uniqueness to 1 lần/ngày/bài

ALTER TABLE "weekly_contest_progress"
ADD COLUMN IF NOT EXISTS "attempt_date" DATE NOT NULL DEFAULT CURRENT_DATE,
ADD COLUMN IF NOT EXISTS "completed_at" TIMESTAMP(3);

-- Drop old unique constraint/index (user_id, contest_id)
DROP INDEX IF EXISTS "weekly_contest_progress_user_id_contest_id_key";

-- New unique index per day
CREATE UNIQUE INDEX IF NOT EXISTS "weekly_contest_progress_user_id_contest_id_attempt_date_key"
ON "weekly_contest_progress"("user_id", "contest_id", "attempt_date");


