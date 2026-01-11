const { PrismaClient } = require('@prisma/client');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

/**
 * Script để fix encoding bằng cách:
 * 1. Import file SQL vào database (với encoding hiện tại)
 * 2. Export lại với encoding UTF-8 đúng cách
 * 
 * LƯU Ý: Cách này chỉ work nếu database có thể import được file hiện tại
 */

const prisma = new PrismaClient();
const inputFile = path.join(__dirname, 'temp_migration', 'dump_final.sql');
const outputFile = path.join(__dirname, 'temp_migration', 'dump_final_fixed.sql');

async function fixViaDatabase() {
  console.log('🔄 Cách này sẽ import và export lại từ database...');
  console.log('⚠️  Cần database connection và có thể mất thời gian');
  console.log('');
  console.log('💡 Thay vào đó, bạn nên:');
  console.log('   1. Kết nối database với psql');
  console.log('   2. Set encoding: SET client_encoding = ''UTF8'';');
  console.log('   3. Dump lại: pg_dump --encoding=UTF8 ... > dump_final.sql');
  console.log('');
  console.log('   Hoặc sử dụng script: node scripts/dump_with_utf8.ps1');
  
  process.exit(0);
}

fixViaDatabase().catch(console.error);
