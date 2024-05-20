<template>
  <div class="customer-auth-container">
    <div class="customer-auth-container-background">
      <div class="customer-auth-header">
        Đăng nhập tài khoản
      </div>
      <div class="customer-auth-content">
        <form>
          <div class="mb-4">
            <div class="w-100 d-flex">
              <input v-model="email" class="form-control w-50" type="text" placeholder="Nhập email">
              <div class="w-fit-content ms-2">
                <button type="button" class="btn-getToken" :class="isSent ? 'disabled' : ''" @click="onGetToken">Lấy mã xác thực</button>
              </div>
            </div>
            <span v-for="error in errors['email']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="token" class="form-control" type="token" placeholder="Nhập mã xác thực">
            <span v-for="error in errors['token']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="password" class="form-control" type="password" placeholder="Nhập mật khẩu">
            <span v-for="error in errors['password']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="password_confirmation" class="form-control" type="password" placeholder="Nhập lại mật khẩu">
            <span v-for="error in errors['password_confirmation']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <button type="button" class="btn-submit-login-customer" @click="onSubmit">Cập nhật mật khẩu</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import Validator from '../../../validator';
import { AccountService } from '../../../services/customer/account.service';

export default {
  data() {
    return {
      email: null,
      token: null,
      errors: {},
      password: null,
      password_confirmation: null,
      isSent: false,
    }
  },
  methods: {
    async onGetToken() {
      this.validateGetToken();
      if (Object.keys(this.errors).length) return;

      const params = {
        email: this.email,
      }
      this.$loading(true);
      try {
        await AccountService.forgotPassword(params);
        this.isSent = true;
        this.$loading(false);
      } catch (error) {
        this.errors = {
          email: ['Email không tồn tại!'],
        }
        this.$loading(false);
      }
    },

    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;

      const params = {
        email: this.email,
        token: this.token,
        password: this.password,
      }
      this.$loading(true);
      try {
        await AccountService.resetPassword(params);
        this.$router.push('/customer/register_success')
        this.$loading(false);
      } catch (error) {
        this.errors = {
          token: ['Mã xác nhận không chính xác hoặc hết hạn!'],
        }
        this.$loading(false);
      }
    },

    validateGetToken() {
      const validator = new Validator();

      validator.checkRequire('email', this.email, 'Email') &&
        validator.checkEmail('email', this.email, 'Email');

      this.errors = validator.errors;
    },

    validate() {
      const validator = new Validator();

      validator.checkRequire('email', this.email, 'Email') &&
        validator.checkEmail('email',this.email, 'Email');

      validator.checkRequire('token', this.token, 'Mã xác thực') &&

      validator.checkRequire('password', this.password, 'Mật khẩu') &&
        validator.checkMaxLength('password', this.password, 18, 'Mật khẩu') &&
          validator.checkMinLength('password', this.password, 6, 'Mật khẩu');

      validator.checkRequire('password_confirmation', this.password_confirmation, 'Mật khẩu xác nhận') &&
        validator.checkMaxLength('password_confirmation', this.password_confirmation, 18, 'Mật khẩu xác nhận') &&
          validator.checkMinLength('password_confirmation', this.password_confirmation, 6, 'Mật khẩu xác nhận') &&
            validator.checkSameValue('password_confirmation', this.password, this.password_confirmation, 'Mật khẩu xác nhận');

      this.errors = validator.errors;
    },
  },
}
</script>
