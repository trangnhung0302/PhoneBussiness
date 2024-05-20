import { ResponseWrapper, ApiError } from './http';
import { Http } from './http_auth';

export class AccountService {
  static request() {
    return new Http();
  }

  static async register(params) {
    try {
      const response = await this.request().post(
        'account/register',
        params
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async activeAccount(token) {
    try {
      const response = await this.request().get(
        `account/active_account/${token}`,
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async forgotPassword(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `account/forgot_password/`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async resetPassword(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().post(
        `account/reset_password/`,
        params
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
}
