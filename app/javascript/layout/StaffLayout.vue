<template>
  <div>
    <Layout
      :sidebar="sidebar"
      :loginUrl="loginUrl"
      :emailLogin="emailLogin"
      @logout="logout"
    />
    <div v-if="messages.length" class="notification-fixed">
      <div v-for="(message, index) in messages" :key="index" class="notification-item">
        {{ message }}
      </div>
    </div>
  </div>
</template>

<script>
import Layout from './components/Layout.vue';
import {AuthService} from '../services/staff/auth.service';
import Pusher from 'pusher-js';

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
      messages: [],
    };
  },
  created() {
    Pusher.logToConsole = true;

    const pusher = new Pusher('0cee147bf16c7ab7dd86', {
      cluster: 'ap1',
    });

    const channel = pusher.subscribe('phone-bussiness-development');
    channel.bind('customer-order', (data) => {
      this.messages.push(data);
      setTimeout(() => {
        this.messages.shift();
      }, 20000);
    });
  },
  methods: {
    async logout() {
      await AuthService.logout();
      return this.$router.push(this.loginUrl);
    }
  },
}
</script>

<style scoped>
.notification-fixed {
  position: fixed;
  z-index: 15;
  right: 0;
  top: 80px;
}
.notification-item {
  background-color: blue;
  padding: 10px 20px;
  border-radius: 5px;
  color: #ffffff;
  margin-bottom: 5px;
}
</style>
