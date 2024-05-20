<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">{{ id ? "Chỉnh sửa nhân viên" : "Thêm mới nhân viên" }}</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="card-body">
            <form class="" autocomplete="off">
              <div class="admin-form">
                <div class="mb-3">
                  <label class="form-label">Email</label>
                  <input v-model="staff.email" type="text" class="form-control" name="email"  placeholder="Email">
                  <span v-for="error in errors['email']" :key="error" class="text-danger">
                    {{ error }}
                  </span>
                </div>
                <div class="mb-3">
                  <label class="form-label">Tên</label>
                  <input v-model="staff.name" type="text" class="form-control" name="name" placeholder="Tên">
                  <span v-for="error in errors['name']" :key="error" class="admin-error">
                    {{ error }}
                  </span>
                </div>
                <div class="mb-3">
                  <label class="form-label">Số điện thoại</label>
                  <input v-model="staff.phone" type="text" class="form-control" name="phone" placeholder="Số điện thoại">
                  <span v-for="error in errors['phone']" :key="error" class="admin-error">
                    {{ error }}
                  </span>
                </div>
                <div class="mb-3">
                  <label class="form-label">Mật khẩu</label>
                  <input v-model="staff.password" type="password" class="form-control" name="password" placeholder="Mật khẩu">
                  <span v-for="error in errors['password']" :key="error" class="admin-error">
                    {{ error }}
                  </span>
                </div>
                <div class="mb-3">
                  <label class="form-label">Trạng thái</label>
                  <vSelect
                    v-model="staff.status"
                    :options="statusList"
                    :reduce="(option) => option.status"
                    class="v-select"
                    label="text"
                  >
                    <span slot="no-options">Không có lựa chọn</span>
                  </vSelect>
                  <span v-for="error in errors['status']" :key="error" class="admin-error">
                    {{ error }}
                  </span>
                </div>
              </div>
              <div class="admin-form-button d-flex justify-content-center mt-2">
                <button type="button" class="btn btn-primary admin-btn-primary mb-2" @click="onSubmit">{{ id ? "Chỉnh sửa" : "Thêm mới" }}</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import vSelect from 'vue-select';
import Validator from '../../../validator';
import { StaffsService } from '../../../services/admin/staffs.service';

export default {
  components: {
    vSelect
  },

  data() {
    return {
      id: this.$router.history.current.params.id,
      statusList: [
        { text: "Làm việc", status: 10 },
        { text: "Tạm nghỉ", status: 20 },
        { text: "Nghỉ việc", status: 30 },
      ],
      errors: {},
      staff: {},
    }
  },
  mounted() {
    if (this.id) {
      this.getStaff(); 
    }
  },
  methods: {
    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      
      const params = {
        name: this.staff.name,
        email: this.staff.email,
        phone: this.staff.phone,
        password: this.staff.password,
        status: this.staff.status,
      }
      
      try {
        if (this.id) {
          await StaffsService.update(this.id, params)
          this.$router.push('../../staffs');
        }
        else {
          await StaffsService.create(params);
          this.$router.push('../staffs');
        }
      }catch (error) {
        console.log(error);
        this.errors = {
          email: ["Email đã tồn tại."]
        }
      }
    },
    async getStaff() {
      const { response } = await StaffsService.get(this.id);
      this.staff = response.data;
    },
    validate() {
      const validator = new Validator();
      validator.checkEmail('email', this.staff.email, 'Email');
        validator.checkMaxLength('email', this.staff.email, 255, 'Email');
      validator.checkRequire('name', this.staff.name, 'Tên') &&
        validator.checkMaxLength('name', this.staff.name, 255, 'Tên');
      validator.checkRequire('status', this.staff.status, 'Trạng thái');
      if (this.phone) {
        validator.checkMaxLength('phone', this.staff.phone, 10, 'Số điện thoại') &&
          validator.checkMinLength('phone', this.staff.phone, 10, 'Số điện thoại');
      }

      this.errors = validator.errors;
    }
  },
}
</script>
