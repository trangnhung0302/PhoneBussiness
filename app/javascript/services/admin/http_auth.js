import axios from 'axios';

/**
 * Http client using Axios
 */
export class Http {
  constructor() {
    this.instance = axios.create({
      baseURL: `${window.location.origin}/api/admins`,
      withCredentials: false,
      headers: {}
    });

    return this.init();
  }

  init() {
    this.instance.interceptors.response.use(undefined, async error => {
      return Promise.reject(error);
    });
    return this.instance;
  }
}
