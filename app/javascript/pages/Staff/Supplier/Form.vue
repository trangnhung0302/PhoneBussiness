<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">{{ id ? "Chỉnh sửa hãng sản phẩm" : "Thêm mới hãng sản phẩm" }}</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="card-body">
            <form class="" autocomplete="off">
              <div class="d-blox">
                <div class="mb-3">
                  <UploadSingleImage
                    :image="image"
                    @setDataImage="setDataImage"
                  />
                </div>
                <div class="mb-3">
                  <label class="form-label">Tên</label>
                  <input v-model="supplier.name" type="text" class="form-control" name="name" placeholder="Tên">
                  <span v-for="error in errors['name']" :key="error" class="admin-error">
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
import Validator from '../../../validator';
import { SuppliersService } from '../../../services/staff/suppliers.service';
import UploadSingleImage from '../../../components/UploadSingleImage.vue';

export default {
  components: {
    UploadSingleImage,
  },

  data() {
    return {
      id: this.$router.history.current.params.id,
      errors: {},
      supplier: {},
      image: '',
      imageName: '',
    }
  },
  mounted() {
    if (this.id) {
      this.getSupplier(); 
    }
  },
  methods: {
    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      
      const params = {
        name: this.supplier.name,
      }

      if (this.image && this.imageName) {
        params['image'] = {
          name: this.imageName,
          content: this.image
        };
      }
      
      try {
        if (this.id) {
          await SuppliersService.update(this.id, params)
          this.$router.push('../../suppliers');
        }
        else {
          await SuppliersService.create(params);
          this.$router.push('../suppliers');
        }
      }catch (error) {
        console.log(error);
      }
    },
    
    async getSupplier() {
      const { response } = await SuppliersService.get(this.id);
      this.supplier = response.data;
      this.image = this.supplier.logo;
    },

    validate() {
      const validator = new Validator();
      validator.checkRequire('name', this.supplier.name, 'Tên hãng') &&
        validator.checkMaxLength('name', this.supplier.name, 255, 'Tên hãng');

      this.errors = validator.errors;
    },

    setDataImage(dataImage) {
      this.imageName = dataImage.name;
      this.image = dataImage.image;
    }
  },
}
</script>
