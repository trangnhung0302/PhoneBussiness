import {AuthService} from '../../services/staff/auth.service';
const staffs = {
  actions: {
    async getStaff(data) {
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
