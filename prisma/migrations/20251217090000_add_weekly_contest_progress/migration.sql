-- CreateTable
CREATE TABLE IF NOT EXISTS "weekly_contest_progress" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "contest_id" INTEGER NOT NULL,
    "correct_count" INTEGER NOT NULL DEFAULT 0,
    "total_questions" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "weekly_contest_progress_pkey" PRIMARY KEY ("id")
);

-- Ensure one progress row per user + contest
CREATE UNIQUE INDEX IF NOT EXISTS "weekly_contest_progress_user_id_contest_id_key"
ON "weekly_contest_progress"("user_id", "contest_id");

-- Foreign key to users
ALTER TABLE "weekly_contest_progress"
ADD CONSTRAINT "weekly_contest_progress_user_id_fkey"
FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
ON DELETE CASCADE ON UPDATE CASCADE;


