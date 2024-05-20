import { ResponseWrapper, ApiError } from './http';
import axios from 'axios';

export class DestinationsService {
  constructor() {
    this.instance = axios.create({
      baseURL: `https://online-gateway.ghn.vn/shiip/public-api/`,
      withCredentials: false,
      headers: {
        token: 'b355a4f5-e4ea-11ee-b6f7-7a81157ff3b1',
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
    return new DestinationsService();
  }

  static async getProvinces() {
    try {
      const response = await this.request().get(
        'master-data/province',
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getDistricts(provinceId) {
    try {
      const response = await this.request().get(
        `master-data/district?province_id=${provinceId}`,
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getWards(districtId) {
    try {
      const response = await this.request().get(
        `master-data/ward?district_id=${districtId}`,
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getTransports(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `v2/shipping-order/available-services`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getShipAmount(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `v2/shipping-order/fee`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
}
