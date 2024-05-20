import { ResponseWrapper, ApiError } from './http';
import axios from 'axios';

export class VietqrService {
  constructor() {
    this.instance = axios.create({
      baseURL: `https://api.vietqr.io/v2/`,
      withCredentials: false,
      headers: {
        'X-Client-Id': '11b81c00-5469-48fa-9361-830441a04e38',
        'X-Api-Key': '92ed2d34-ba74-46c6-8397-77244863cd53',
      },
    });

    return this.init();
  }

  init() {
    this.instance.interceptors.response.use(undefined, async error => {
      return Promise.reject(error);
    });
    return this.instance;
  }

  static request() {
    return new VietqrService();
  }

  static async getAccountNo(parameters = {}) {
    const params = { ...parameters };
    console.log(params);
    try {
      const response = await this.request().post(
        'lookup',
        params
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getQrCode(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().post(
        'generate',
        params
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getBanks() {
    try {
      const response = await this.request().get(
        'banks',
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
}
