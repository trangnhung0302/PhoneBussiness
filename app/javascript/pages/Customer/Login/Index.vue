<template>
  <div class="customer-auth-container">
    <div class="customer-auth-container-background">
      <div class="customer-auth-header">
        Đăng nhập tài khoản
      </div>
      <div class="customer-auth-content">
        <form>
          <div class="mb-4">
            <input v-model="email" class="form-control" type="text" placeholder="Nhập email">
            <span v-for="error in errors['email']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="password" class="form-control" type="password" placeholder="Nhập mật khẩu">
            <span v-for="error in errors['password']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="btn-reset-password mb-4">
            <a @click="$router.push('/customer/forgot_password')">Quên mật khẩu</a>
          </div>
          <div class="mb-4">
            <button type="button" class="btn-submit-login-customer" @click="onSubmit">Đăng nhập</button>
          </div>
          <div class="text-center">
            <span class="text-not-account">Bạn chưa có tài khoản?</span><a class="link-sigup" @click="$router.push('/customer/register')">Đăng ký ngay</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import Validator from '../../../validator';
import { AuthService } from '../../../services/customer/auth.service';

export default {
  data() {
    return {
      email: null,
      password: null,
      errors: {}
    }
  },
  methods: {
    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      const params = {
        email: this.email,
        password: this.password,
      }

      this.$loading(true);
      try {
        await AuthService.login(params);
        this.$loading(false);
        window.location.href = "/";
      } catch (error) {
        this.errors = {...this.errors, password: ['Tên đăng nhập hoặc mật khẩu không chính xác.']};
        this.$loading(false);
      }
    },

    validate() {
      const validator = new Validator();

      validator.checkRequire('email', this.email, 'Email') &&
        validator.checkEmail('email',this.email, 'Email');

      validator.checkRequire('password', this.password, 'Mật khẩu') &&
        validator.checkMaxLength('password', this.password, 18, 'Mật khẩu') &&
          validator.checkMinLength('password', this.password, 6, 'Mật khẩu');

      this.errors = validator.errors;
    },
  },
}
</script>
