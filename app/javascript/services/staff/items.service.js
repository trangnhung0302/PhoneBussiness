import { BaseService } from './base.service';

export class ItemsService extends BaseService {
  static get resourceEndpoint() {
    return 'items';
  }
}
