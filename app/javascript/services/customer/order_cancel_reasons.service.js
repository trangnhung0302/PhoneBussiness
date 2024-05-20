import { BaseService } from './base.service';

export class OrderCancelReasonsService extends BaseService {
  static get resourceEndpoint() {
    return 'order_cancel_reasons';
  }
}
