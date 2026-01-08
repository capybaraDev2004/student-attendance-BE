-- CreateTable
CREATE TABLE "vocabulary_box" (
    "box_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "name" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vocabulary_box_pkey" PRIMARY KEY ("box_id")
);

-- CreateTable
CREATE TABLE "vocabulary_box_item" (
    "item_id" SERIAL NOT NULL,
    "box_id" INTEGER NOT NULL,
    "vocab_id" INTEGER NOT NULL,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "is_memorized" BOOLEAN NOT NULL DEFAULT false,
    "correct_count" INTEGER NOT NULL DEFAULT 0,
    "incorrect_count" INTEGER NOT NULL DEFAULT 0,
    "listen_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vocabulary_box_item_pkey" PRIMARY KEY ("item_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "vocabulary_box_user_id_name_key" ON "vocabulary_box"("user_id", "name");

-- CreateIndex
CREATE UNIQUE INDEX "vocabulary_box_item_box_id_vocab_id_key" ON "vocabulary_box_item"("box_id", "vocab_id");

-- AddForeignKey
ALTER TABLE "vocabulary_box" ADD CONSTRAINT "vocabulary_box_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vocabulary_box_item" ADD CONSTRAINT "vocabulary_box_item_box_id_fkey" FOREIGN KEY ("box_id") REFERENCES "vocabulary_box"("box_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vocabulary_box_item" ADD CONSTRAINT "vocabulary_box_item_vocab_id_fkey" FOREIGN KEY ("vocab_id") REFERENCES "vocabulary"("vocab_id") ON DELETE RESTRICT ON UPDATE CASCADE;

