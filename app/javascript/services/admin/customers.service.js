import { BaseService } from './base.service';

export class CustomersService extends BaseService {
  static get resourceEndpoint() {
    return 'customers';
  }
}
