<template>
  <Layout
    :sidebar="sidebar"
    :loginUrl="loginUrl"
    :emailLogin="emailLogin"
    @logout="logout"
  />
</template>

<script>
import Layout from './components/Layout.vue';
import {AuthService} from '../services/admin/auth.service';

export default {
  components: {
    Layout,
  },
  data() {
    return {
      sidebar: [
        { text: 'Trang chủ', url: '/admin', icon: 'house-door' },
        { text: 'Quản lý nhân viên', url: '/admin/staffs', icon: 'person-bounding-box' },
        { text: 'Quản lý khách hàng', url: '/admin/customers', icon: 'people' },
        { text: 'Thống kê', url: '/admin/report', icon: 'reception-4' },
      ],
      loginUrl: "/admin/login",
      emailLogin: localStorage.getItem('admin_login'),
    };
  },
  methods: {
    async logout() {
      await AuthService.logout();
      return this.$router.push(this.loginUrl);
    }
  },
}
</script>
