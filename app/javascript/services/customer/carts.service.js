import { BaseService } from './base.service';
import { ResponseWrapper, ApiError } from './http';

export class CartsService extends BaseService {
  static get resourceEndpoint() {
    return 'carts';
  }

  static async updateCarts(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().post(
        `${this.resourceEndpoint}/update_carts`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
}
