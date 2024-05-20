<template>
  <section class="vh-100 gradient-custom">
    <div class="container py-5 h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-8 col-lg-6 col-xl-5">
          <div class="card bg-dark text-white" style="border-radius: 1rem;">
            <div class="card-body p-5 text-center">

              <div class="mb-md-5 mt-md-4 pb-5">

                <h2 class="fw-bold mb-2 text-uppercase mb-4">Đăng nhập</h2>

                <div class="form-outline form-white mb-4 text-start">
                  <label class="form-label" for="typeEmailX">Email</label>
                  <input v-model="email" type="email" id="typeEmailX" class="form-control form-control-lg" />
                  <span v-for="error in errors['email']" :key="error" class="text-danger">
                    {{ error }}
                  </span>
                </div>

                <div class="form-outline form-white mb-4 text-start">
                  <label class="form-label" for="typePasswordX">Mật khẩu</label>
                  <input v-model="password" type="password" id="typePasswordX" class="form-control form-control-lg" />
                  <span v-for="error in errors['password']" :key="error" class="text-danger">
                    {{ error }}
                  </span>
                </div>
                <button class="btn btn-outline-light btn-lg px-5" type="submit" @click="loginAdmin">Đăng nhập</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { AuthService } from '../../../services/admin/auth.service';
import Validator from '../../../validator';

export default {
  data () {
    return {
      email: '',
      password: '',
      errors: {}
    };
  },

  methods: {
    async loginAdmin() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      try {
        await AuthService.login({ email: this.email, password: this.password });
        return this.$router.push({ path: '/admin' });
      } catch (error) {
        return this.errors = {password: ['Tên đăng nhập hoặc mật khẩu không chính xác.']};
      }
    },
    validate() {
      const validator = new Validator();
      validator.checkRequire('email', this.email, 'Email') &&
        validator.checkEmail('email',this.email, 'Email');
      validator.checkRequire('password', this.password, 'Mật khẩu');
      this.errors = validator.errors;
    },
  },
}
</script>

<style scoped>
.gradient-custom {
  background: #6a11cb;
  background: -webkit-linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1));
  background: linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1))
}
</style>
