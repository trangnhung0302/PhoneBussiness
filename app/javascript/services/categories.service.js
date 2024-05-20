import { BaseService } from './base.service';

export class CategoriesService extends BaseService {
  static get resourceEndpoint() {
    return 'categories';
  }
}
