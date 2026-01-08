-- CreateEnum
CREATE TYPE "Region" AS ENUM ('bac', 'trung', 'nam');

-- AlterTable
ALTER TABLE "users"
ADD COLUMN     "address" TEXT,
ADD COLUMN     "province" TEXT,
ADD COLUMN     "region" "Region";

