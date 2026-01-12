-- CreateEnum
CREATE TYPE "VipPackageType" AS ENUM ('lifetime', 'one_day', 'one_week', 'one_month', 'one_year');

-- AlterTable
ALTER TABLE "users" ADD COLUMN "vip_package_type" "VipPackageType",
ADD COLUMN "vip_expires_at" TIMESTAMP(3);
