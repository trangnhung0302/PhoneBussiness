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
      localStorage.setItem('staff_csrf', response.data.csrf);
      console.log(response.config.data);
      localStorage.setItem('staff_login', JSON.parse(response.config.data).email);
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
            Authorization: `Bearer ${localStorage.getItem('staff_csrf')}`
          }
        }
      );
      return;
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async logout() {
    console.log(localStorage.getItem('staff_csrf'));
    try {
      const response = await this.request().delete(
        'auth/logout',
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem('staff_csrf')}`
          }
        }
      );
      localStorage.removeItem('staff_csrf');
      localStorage.removeItem('staff_login');
      return new ResponseWrapper(response);
    } catch (error) {
      localStorage.removeItem('staff_csrf');
      localStorage.removeItem('staff_login');
      throw new ApiError(error);
    }
  }
}
