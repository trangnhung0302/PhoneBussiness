import {AuthService} from '../../services/admin/auth.service';
const admins = {
  actions: {
    async getAdmin(data) {
      try {
        await AuthService.checkToken(data);
        return;
      } catch (error) {
        return {status: 401};
      }
    },
  },
};

export default admins;
