import { BaseService } from './base.service';

export class CustomerDestinationsService extends BaseService {
  static get resourceEndpoint() {
    return 'customer_destinations';
  }
}
