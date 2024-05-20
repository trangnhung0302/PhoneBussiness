import { BaseService } from './base.service';
import { ResponseWrapper, ApiError } from './http';

export class ItemsService extends BaseService {  
  static get resourceEndpoint() {
    return 'items';
  }

  static async getItemByCategoryIds(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `${this.resourceEndpoint}/get_item_by_category_ids`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
}
