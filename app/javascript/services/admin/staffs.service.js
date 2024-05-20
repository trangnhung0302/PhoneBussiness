import { BaseService } from './base.service';

export class StaffsService extends BaseService {
  static get resourceEndpoint() {
    return 'staffs';
  }
}
