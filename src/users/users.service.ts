import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import * as bcrypt from 'bcryptjs';

import { PrismaService } from '../prisma/prisma.service';
import {
  AccountStatus,
  AccountType,
  CreateUserDto,
  Region,
} from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UpdateProfileDto } from './dto/update-profile.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    // Lấy danh sách user, ẩn password hash để đảm bảo an toàn
    return this.prisma.users.findMany({
      orderBy: { created_at: 'desc' },
      select: {
        user_id: true,
        username: true,
        email: true,
        role: true,
        created_at: true,
        email_confirmed: true,
        verification_code: true,
        verification_code_expires_at: true,
        reset_code: true,
        reset_code_expires_at: true,
        account_status: true,
        account_type: true,
        must_set_password: true,
        image_url: true,
        address: true,
        province: true,
        region: true,
        vip_package_type: true,
        vip_expires_at: true,
      },
    });
  }

  async findById(userId: number) {
    const user = await this.prisma.users.findUnique({
      where: { user_id: userId },
      select: {
        user_id: true,
        username: true,
        email: true,
        role: true,
        created_at: true,
        email_confirmed: true,
        verification_code: true,
        verification_code_expires_at: true,
        reset_code: true,
        reset_code_expires_at: true,
        account_status: true,
        account_type: true,
        must_set_password: true,
        image_url: true,
        address: true,
        province: true,
        region: true,
        vip_package_type: true,
        vip_expires_at: true,
      },
    });

    if (!user) {
      throw new NotFoundException('Không tìm thấy người dùng');
    }

    return user;
  }

  async findByEmail(email: string) {
    return this.prisma.users.findUnique({ where: { email } });
  }

  async create(dto: CreateUserDto) {
    const passwordHash = await bcrypt.hash(dto.password, 10);
    try {
      const newUser = await this.prisma.users.create({
        data: {
          username: dto.username,
          email: dto.email,
          password_hash: passwordHash,
          role: dto.role ?? 'customer',
          email_confirmed: dto.email_confirmed ?? false,
          verification_code: dto.verification_code,
          verification_code_expires_at: dto.verification_code_expires_at
            ? new Date(dto.verification_code_expires_at)
            : undefined,
          account_status: dto.account_status ?? AccountStatus.NORMAL,
          account_type: dto.account_type ?? AccountType.LOCAL,
        must_set_password:
          (dto.account_type ?? AccountType.LOCAL) === AccountType.GOOGLE
            ? dto.must_set_password ?? true
            : dto.must_set_password ?? false,
        image_url: dto.image_url,
        address: dto.address,
        province: dto.province,
        region: dto.region ?? Region.BAC,
        },
        select: {
          user_id: true,
          username: true,
          email: true,
          role: true,
          created_at: true,
          email_confirmed: true,
          verification_code: true,
          verification_code_expires_at: true,
        reset_code: true,
        reset_code_expires_at: true,
          account_status: true,
          account_type: true,
        must_set_password: true,
        image_url: true,
        address: true,
        province: true,
        region: true,
        },
      });

      return newUser;
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException('Email hoặc username đã tồn tại');
      }
      throw error;
    }
  }

  async update(userId: number, dto: UpdateUserDto) {
    await this.ensureExists(userId);

    const data: Prisma.usersUpdateInput = {
      username: dto.username,
      email: dto.email,
      role: dto.role,
      email_confirmed: dto.email_confirmed,
      verification_code: dto.verification_code,
      verification_code_expires_at: dto.verification_code_expires_at
        ? new Date(dto.verification_code_expires_at)
        : dto.verification_code_expires_at,
      account_status: dto.account_status,
      account_type: dto.account_type,
      must_set_password: dto.must_set_password,
      image_url: dto.image_url,
      address: dto.address,
      province: dto.province,
      region: dto.region,
      vip_package_type: dto.vip_package_type,
      vip_expires_at: dto.vip_expires_at
        ? new Date(dto.vip_expires_at)
        : dto.vip_expires_at === null
          ? null
          : undefined,
    };

    if (dto.password) {
      data.password_hash = await bcrypt.hash(dto.password, 10);
    }

    try {
      return await this.prisma.users.update({
        where: { user_id: userId },
        data,
        select: {
          user_id: true,
          username: true,
          email: true,
          role: true,
          created_at: true,
          email_confirmed: true,
          verification_code: true,
          verification_code_expires_at: true,
          account_status: true,
          account_type: true,
          must_set_password: true,
          image_url: true,
          address: true,
          province: true,
          region: true,
          vip_package_type: true,
          vip_expires_at: true,
        },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException('Email hoặc username đã tồn tại');
      }
      throw error;
    }
  }

  async remove(userId: number) {
    await this.ensureExists(userId);
    await this.prisma.users.delete({ where: { user_id: userId } });
    return { message: 'Đã xóa người dùng thành công' };
  }

  async updateProfile(
    userId: number,
    dto: UpdateProfileDto,
    imageUrl?: string,
  ) {
    const data: Prisma.usersUpdateInput = {};

    if (dto.username) {
      data.username = dto.username;
    }
    if (dto.email) {
      data.email = dto.email;
    }
    if (typeof dto.address !== 'undefined') {
      data.address = dto.address;
    }
    if (typeof dto.province !== 'undefined') {
      data.province = dto.province;
    }
    if (dto.region) {
      data.region = dto.region;
    }
    if (imageUrl) {
      data.image_url = imageUrl;
    }

    try {
      return await this.prisma.users.update({
        where: { user_id: userId },
        data,
        select: {
          user_id: true,
          username: true,
          email: true,
          role: true,
          created_at: true,
          email_confirmed: true,
          account_status: true,
          account_type: true,
          must_set_password: true,
          image_url: true,
          address: true,
          province: true,
          region: true,
        },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException('Email hoặc username đã tồn tại');
      }
      throw error;
    }
  }

  private async ensureExists(userId: number) {
    const exists = await this.prisma.users.findUnique({
      where: { user_id: userId },
    });
    if (!exists) {
      throw new NotFoundException('Không tìm thấy người dùng');
    }
  }

  async saveVerificationCode(
    userId: number,
    code: string,
    expiresAt: Date,
  ): Promise<void> {
    await this.prisma.users.update({
      where: { user_id: userId },
      data: {
        verification_code: code,
        verification_code_expires_at: expiresAt,
      },
    });
  }

  async confirmEmail(userId: number): Promise<void> {
    await this.prisma.users.update({
      where: { user_id: userId },
      data: {
        email_confirmed: true,
        verification_code: null,
        verification_code_expires_at: null,
      },
    });
  }

  async saveResetCode(userId: number, code: string, expiresAt: Date) {
    await this.prisma.users.update({
      where: { user_id: userId },
      data: {
        reset_code: code,
        reset_code_expires_at: expiresAt,
      },
    });
  }

  async clearResetCode(userId: number) {
    await this.prisma.users.update({
      where: { user_id: userId },
      data: {
        reset_code: null,
        reset_code_expires_at: null,
      },
    });
  }

  async updatePassword(
    userId: number,
    newPassword: string,
    options?: { mustSetPassword?: boolean },
  ) {
    const password_hash = await bcrypt.hash(newPassword, 10);
    return this.prisma.users.update({
      where: { user_id: userId },
      data: {
        password_hash,
        must_set_password: options?.mustSetPassword ?? false,
      },
      select: {
        user_id: true,
        username: true,
        email: true,
        role: true,
        created_at: true,
        email_confirmed: true,
        account_status: true,
        account_type: true,
        must_set_password: true,
      },
    });
  }
}
