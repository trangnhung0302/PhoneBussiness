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
import {AuthService} from '../services/staff/auth.service';

export default {
  components: {
    Layout,
  },
  data() {
    return {
      sidebar: [
        { text: 'Trang chủ', url: '/staff', icon: 'house-door' },
        { text: 'Hãng sản phẩm', url: '/staff/suppliers', icon: 'card-list' },
        { text: 'Phân loại sản phẩm', url: '/staff/categories', icon: 'tablet' },
        { text: 'Quản lý sản phẩm', url: '/staff/items', icon: 'stack' },
        { text: 'Quản lý đơn hàng', url: '/staff/orders', icon: 'view-stacked' },
      ],
      loginUrl: "/staff/login",
      emailLogin: localStorage.getItem('staff_login'),
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
