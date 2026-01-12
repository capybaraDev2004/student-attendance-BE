-- =====================================================
-- SQL Script để cập nhật bảng users và tạo bảng payments
-- Chạy trên Supabase PostgreSQL Database
-- =====================================================

-- 1. Tạo enum types (nếu chưa tồn tại)
-- =====================================================

-- Tạo enum VipPackageType
DO $$ BEGIN
    CREATE TYPE "VipPackageType" AS ENUM ('lifetime', 'one_day', 'one_week', 'one_month', 'one_year');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Tạo enum PaymentStatus
DO $$ BEGIN
    CREATE TYPE "PaymentStatus" AS ENUM ('pending', 'paid', 'cancelled', 'expired', 'cancel');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 2. Cập nhật bảng users - Thêm cột VIP
-- =====================================================

-- Thêm cột vip_package_type
ALTER TABLE "users" 
ADD COLUMN IF NOT EXISTS "vip_package_type" "VipPackageType" NULL;

-- Thêm cột vip_expires_at
ALTER TABLE "users" 
ADD COLUMN IF NOT EXISTS "vip_expires_at" TIMESTAMP(3) NULL;

-- 3. Tạo bảng payments
-- =====================================================

CREATE TABLE IF NOT EXISTS "payments" (
    "payment_id" SERIAL PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "order_code" BIGINT NOT NULL UNIQUE,
    "amount" INTEGER NOT NULL,
    "vip_package_type" "VipPackageType" NOT NULL,
    "status" "PaymentStatus" NOT NULL DEFAULT 'pending',
    "description" TEXT NULL,
    "checkout_url" TEXT NULL,
    "qr_code" TEXT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "paid_at" TIMESTAMP(3) NULL,
    
    -- Foreign key constraint
    CONSTRAINT "payments_user_id_fkey" 
        FOREIGN KEY ("user_id") 
        REFERENCES "users"("user_id") 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- 4. Tạo indexes để tối ưu query
-- =====================================================

-- Index cho order_code (thường dùng để lookup)
CREATE INDEX IF NOT EXISTS "payments_order_code_idx" ON "payments"("order_code");

-- Index cho user_id (thường dùng để lấy payments của user)
CREATE INDEX IF NOT EXISTS "payments_user_id_idx" ON "payments"("user_id");

-- Index cho status (thường dùng để filter theo status)
CREATE INDEX IF NOT EXISTS "payments_status_idx" ON "payments"("status");

-- Index cho created_at (thường dùng để sort)
CREATE INDEX IF NOT EXISTS "payments_created_at_idx" ON "payments"("created_at" DESC);

-- 5. Tạo trigger để auto-update updated_at
-- =====================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW."updated_at" = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Áp dụng trigger cho bảng payments
DROP TRIGGER IF EXISTS update_payments_updated_at ON "payments";
CREATE TRIGGER update_payments_updated_at
    BEFORE UPDATE ON "payments"
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- KẾT THÚC SCRIPT
-- =====================================================
-- Kiểm tra kết quả:
-- SELECT column_name, data_type, is_nullable 
-- FROM information_schema.columns 
-- WHERE table_name = 'users' AND column_name IN ('vip_package_type', 'vip_expires_at');
--
-- SELECT * FROM information_schema.tables WHERE table_name = 'payments';
-- =====================================================
