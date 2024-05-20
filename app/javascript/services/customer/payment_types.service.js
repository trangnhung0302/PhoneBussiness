import { BaseService } from './base.service';

export class PaymentTypesService extends BaseService {
  static get resourceEndpoint() {
    return 'payment_types';
  }
}
