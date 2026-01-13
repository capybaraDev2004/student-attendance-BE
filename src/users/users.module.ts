import { Module } from '@nestjs/common';
import { AdminUsersController } from './admin-users.controller';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';
import { ProfileController } from './profile.controller';
import { VipExpirationService } from './vip-expiration.service';

@Module({
  providers: [UsersService, VipExpirationService],
  controllers: [UsersController, AdminUsersController, ProfileController],
  exports: [UsersService],
})
export class UsersModule {}
