-- Drop foreign key constraint first
ALTER TABLE "weekly_contest_progress" DROP CONSTRAINT IF EXISTS "weekly_contest_progress_user_id_fkey";

-- Drop unique index
DROP INDEX IF EXISTS "weekly_contest_progress_user_id_contest_id_attempt_date_key";

-- Drop the table
DROP TABLE IF EXISTS "weekly_contest_progress";

