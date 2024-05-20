import { ResponseWrapper, ApiError } from './http';
import { Http } from './http_auth';

export class AuthService {
  static request() {
    return new Http();
  }

  static async login(params) {
    try {
      const response = await this.request().post(
        'auth/login',
        params
      );
      localStorage.setItem('customer_csrf', response.data.csrf);
      localStorage.setItem('customer_login', JSON.parse(response.config.data).email);
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async checkToken(params) {
    try {
      await this.request().post(
        'auth/check_token',
        params,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('customer_csrf')}`
          }
        }
      );
      return;
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async logout() {
    try {
      const response = await this.request().delete(
        'auth/logout',
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('customer_csrf')}`
          }
        }
      );
      localStorage.removeItem('customer_csrf');
      localStorage.removeItem('customer_login');
      return new ResponseWrapper(response);
    } catch (error) {
      localStorage.removeItem('customer_csrf');
      localStorage.removeItem('customer_login');
      throw new ApiError(error);
    }
  }
}
