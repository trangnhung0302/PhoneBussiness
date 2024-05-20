<template>
  <div class="customer-auth-container">
    <div class="customer-auth-container-background">
      <div class="customer-auth-header">
        Đăng ký tài khoản
      </div>
      <div class="customer-auth-content">
        <form>
          <div class="mb-4">
            <input v-model="name" class="form-control" type="text" placeholder="Nhập họ và tên">
            <span v-for="error in errors['name']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="email" class="form-control" type="text" placeholder="Nhập email">
            <span v-for="error in errors['email']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="phone" class="form-control" type="text" placeholder="Nhập số điện thoại">
            <span v-for="error in errors['phone']" :key="error" class="text-danger">
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
            <button type="button" class="btn-submit-login-customer" @click="onSubmit">Đăng ký</button>
          </div>
          <div class="text-center">
            <span class="text-not-account">Bạn đã có tài khoản?</span><a class="link-sigup" @click="$router.push('/customer/login')">Đăng nhập</a>
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
      name: null,
      email: null,
      password: null,
      phone: null,
      password_confirmation: null,
      errors: {}
    }
  },
  methods: {
    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      const params = {
        name: this.name,
        email: this.email,
        phone: this.phone,
        password: this.password,
      }
      
      this.$loading(true);
      try {
        await AccountService.register(params);
        this.$router.push('/customer/register_confirm')
        this.$loading(false);
      } catch (error) {
        this.errors = {email: ['Địa chỉ email đã tồn tại.']};
        this.$loading(false);
      }
        
    },

    validate() {
      const validator = new Validator();
      validator.checkRequire('name', this.name, 'Tên');

      validator.checkRequire('email', this.email, 'Email') &&
        validator.checkEmail('email',this.email, 'Email');

      validator.checkRequire('password', this.password, 'Mật khẩu') &&
        validator.checkMaxLength('password', this.password, 18, 'Mật khẩu') &&
          validator.checkMinLength('password', this.password, 6, 'Mật khẩu');

      validator.checkRequire('password_confirmation', this.password_confirmation, 'Mật khẩu xác nhận') &&
        validator.checkMaxLength('password_confirmation', this.password_confirmation, 18, 'Mật khẩu xác nhận') &&
          validator.checkMinLength('password_confirmation', this.password_confirmation, 6, 'Mật khẩu xác nhận') &&
            validator.checkSameValue('password_confirmation', this.password, this.password_confirmation, 'Mật khẩu xác nhận');

      validator.checkMaxLength('phone', this.phone, 10, 'Số điện thoại') &&
        validator.checkDigit('phone', this.phone, 'Số điện thoại') &&
          validator.checkMinLength('phone', this.phone, 10, 'Số điện thoại');
      this.errors = validator.errors;
    },
  },
}
</script>
