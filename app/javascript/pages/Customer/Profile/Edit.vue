<template>
  <div class="customer-auth-container">
    <div class="customer-auth-container-background">
      <div class="customer-auth-header">
        Thông tin cá nhân
      </div>
      <div class="customer-auth-content">
        <form>
          <div class="mb-4">
            <input v-model="email" class="form-control" type="text" placeholder="Nhập email" disabled>
            <span v-for="error in errors['email']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="mb-4">
            <input v-model="name" class="form-control" type="text" placeholder="Nhập họ và tên">
            <span v-for="error in errors['name']" :key="error" class="text-danger">
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
            <button type="button" class="btn-submit-login-customer" @click="onSubmit">Cập nhật</button>
          </div>
          <div v-if="isSuccess" class="btn-submit-login-customer" style="background-color: green; text-align: center;">
            Cập nhật thông tin thành công!
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import Validator from '../../../validator';
import { ProfileService } from '../../../services/customer/profile.service';

export default {
  data() {
    return {
      name: null,
      email: null,
      password: null,
      phone: null,
      password_confirmation: null,
      id: null,
      errors: {},
      isSuccess: false,
    }
  },
  mounted() {
    this.getProfile();
  },

  methods: {
    async getProfile() {
      this.$loading(true);
      try {
        const { response } = await ProfileService.index();
        const customer = response.data;
        this.id = customer.id;
        this.name = customer.name;
        this.email = customer.email;
        this.phone = customer.phone;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },
    
    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      const params = {
        name: this.name,
        email: this.email,
        phone: this.phone,
      }
      
      this.$loading(true);
      try {
        await ProfileService.update(this.id, params);
        this.isSuccess = true;
        setTimeout(() => {
          this.isSuccess = false;
        }, 3000);
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
        
    },

    validate() {
      const validator = new Validator();
      validator.checkRequire('name', this.name, 'Tên');

      validator.checkRequire('email', this.email, 'Email') &&
        validator.checkEmail('email',this.email, 'Email');

      validator.checkMaxLength('phone', this.phone, 10, 'Số điện thoại') &&
        validator.checkDigit('phone', this.phone, 'Số điện thoại') &&
          validator.checkMinLength('phone', this.phone, 10, 'Số điện thoại');
      this.errors = validator.errors;
    },
  },
}
</script>
