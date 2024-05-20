import {AuthService} from '../../services/customer/auth.service';
const staffs = {
  actions: {
    async getCustomer(data) {
      try {
        await AuthService.checkToken(data);
        return;
      } catch (error) {
        return {status: 401};
      }
    },
  },
};

export default staffs;
