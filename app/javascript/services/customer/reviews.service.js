import { BaseService } from './base.service';

export class ReviewsService extends BaseService {
  static get resourceEndpoint() {
    return 'reviews';
  }
}
