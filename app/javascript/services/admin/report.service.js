import { BaseService } from './base.service';
import { ResponseWrapper, ApiError } from './http';

export class ReportService extends BaseService {
  static get resourceEndpoint() {
    return 'reports';
  }

  static async getReportRevenue(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `${this.resourceEndpoint}/report_revenue`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }

  static async getReportByCategory(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `${this.resourceEndpoint}/report_by_category`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
  
  static async getReportBySupplier(parameters = {}) {
    const params = { ...parameters };
    try {
      const response = await this.request().get(
        `${this.resourceEndpoint}/report_by_supplier`,
        { params }
      );
      return new ResponseWrapper(response);
    } catch (error) {
      throw new ApiError(error);
    }
  }
}
