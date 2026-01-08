-- CreateTable: user_daily_scores
CREATE TABLE IF NOT EXISTS "user_daily_scores" (
  "id" SERIAL NOT NULL,
  "user_id" INTEGER NOT NULL,
  "score" INTEGER NOT NULL DEFAULT 0,
  "score_date" DATE NOT NULL,
  "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "user_daily_scores_pkey" PRIMARY KEY ("id")
);

-- Unique: mỗi user chỉ có 1 dòng / 1 ngày
CREATE UNIQUE INDEX IF NOT EXISTS "user_daily_scores_user_id_score_date_key"
ON "user_daily_scores"("user_id", "score_date");

-- FK: users
ALTER TABLE "user_daily_scores"
ADD CONSTRAINT "user_daily_scores_user_id_fkey"
FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
ON DELETE CASCADE ON UPDATE CASCADE;

