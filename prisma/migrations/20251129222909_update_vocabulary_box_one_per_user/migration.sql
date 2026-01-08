-- DropIndex
DROP INDEX IF EXISTS "vocabulary_box_user_id_name_key";

-- AlterTable
ALTER TABLE "vocabulary_box" DROP COLUMN IF EXISTS "name";

-- CreateIndex
CREATE UNIQUE INDEX "vocabulary_box_user_id_key" ON "vocabulary_box"("user_id");

