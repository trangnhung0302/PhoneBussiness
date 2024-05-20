import axios from 'axios';

/**
 * Http client using Axios
 */
export class Http {
  constructor() {
    this.instance = axios.create({
      baseURL: `${window.location.origin}/api/admins`,
      withCredentials: false,
      headers: {
        Authorization: `Bearer ${localStorage.getItem('csrf')}`
      }
    });

    return this.init();
  }

  init() {
    this.instance.interceptors.response.use(undefined, async error => {
      if (error.response.status === 401) {
        window.location.href = '/admin/login';
      }
      if (error.response.status === 423) {
        window.location.href = '/admin/login';
      }
      // redirect to LP if get 404 and specific error code
      if (error.response.status === 404) {
        window.location.href = '/admin/not_found';
      }
      return Promise.reject(error);
    });
    return this.instance;
  }
}

/**
 * Create instant, which represent response object
 * @param {Object} [response] - axios response object
 */
export class ResponseWrapper {
  constructor(response) {
    this.response = response.data;
    this.status = response.status;
    this.axios_response = response;
  }
}

/**
 * Create instant, which represent error object
 * @param {Object} [error] - axios error object
 */
export class ApiError extends Error {
  constructor(error) {
    super();
    this.response = error.response ? error.response.data : {};
    this.status = error.response ? error.response.status : null;
    this.axios_error = error;
  }
}