import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PayOS } from '@payos/node';

@Injectable()
export class PayOSService {
  private readonly payOS: PayOS;

  constructor(private readonly configService: ConfigService) {
    const clientId = this.configService.get<string>('PAYOS_CLIENT_ID');
    const apiKey = this.configService.get<string>('PAYOS_API_KEY');
    const checksumKey = this.configService.get<string>('PAYOS_CHECKSUM_KEY');

    if (!clientId || !apiKey || !checksumKey) {
      throw new Error('PayOS credentials are not configured');
    }

    this.payOS = new PayOS({
      clientId,
      apiKey,
      checksumKey,
    });
  }

  getPayOS(): PayOS {
    return this.payOS;
  }
}
