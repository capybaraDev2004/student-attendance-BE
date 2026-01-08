-- CreateTable: user_monthly_scores
CREATE TABLE IF NOT EXISTS "user_monthly_scores" (
  "id" SERIAL NOT NULL,
  "user_id" INTEGER NOT NULL,
  "score" INTEGER NOT NULL DEFAULT 0,
  "month_cycle" TEXT NOT NULL,
  "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "user_monthly_scores_pkey" PRIMARY KEY ("id")
);

-- Unique: mỗi user chỉ có 1 dòng / 1 tháng
CREATE UNIQUE INDEX IF NOT EXISTS "user_monthly_scores_user_id_month_cycle_key"
ON "user_monthly_scores"("user_id", "month_cycle");

-- FK: users
ALTER TABLE "user_monthly_scores"
ADD CONSTRAINT "user_monthly_scores_user_id_fkey"
FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
ON DELETE CASCADE ON UPDATE CASCADE;


