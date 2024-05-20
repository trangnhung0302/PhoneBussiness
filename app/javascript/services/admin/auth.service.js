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
      localStorage.setItem('csrf', response.data.csrf);
      localStorage.setItem('admin_login', JSON.parse(response.config.data).email);
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
            Authorization: `Bearer ${localStorage.getItem('csrf')}`
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
            Authorization: `Bearer ${localStorage.getItem('csrf')}`
          }
        }
      );
      localStorage.removeItem('csrf');
      localStorage.removeItem('admin_login');
      return new ResponseWrapper(response);
    } catch (error) {
      localStorage.removeItem('csrf');
      localStorage.removeItem('admin_login');
      throw new ApiError(error);
    }
  }
}
