import { Module } from '@nestjs/common';
import { AdminUsersController } from './admin-users.controller';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';
import { ProfileController } from './profile.controller';

@Module({
  providers: [UsersService],
  controllers: [UsersController, AdminUsersController, ProfileController],
  exports: [UsersService],
})
export class UsersModule {}
