import { BaseService } from './base.service';

export class SuppliersService extends BaseService {
  static get resourceEndpoint() {
    return 'suppliers';
  }
}
