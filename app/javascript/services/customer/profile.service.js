import { BaseService } from './base.service';

export class ProfileService extends BaseService {
  static get resourceEndpoint() {
    return 'profile';
  }
}
