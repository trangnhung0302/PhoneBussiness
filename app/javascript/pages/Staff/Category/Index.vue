<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Danh sách loại sản phẩm</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="list_header">
            <div class="box_right d-flex lms_block">
              <div class="serach_field_2">
                <div class="search_inner">
                  <input v-model="keySearch" type="text" class="" placeholder="Tìm kiếm loại sản phẩm" @input="onSearch">
                  <div class="icon-search"><b-icon-search scale="1.5" /></div>
                </div>
              </div>
              <div class="add_button ms-2">
                <button class="btn-create" @click="openModalCreate">Thêm mới</button>
              </div>
            </div>
          </div>
          <div class="list-body">
            <div class="dataTables_wrapper no-footer">
              <table class="table lms_table_active3 dataTable no-footer dtr-inline">
                <thead>
                  <td v-for="header in tableHeader" :key="header">
                    {{ header }}
                  </td>
                </thead>
                <tbody>
                  <tr v-for="(category, index) in categories" :key="index" class="cursor-pointer" @click="openModalEdit(category)">
                    <td>{{ index + 1 }}</td>
                    <td>{{ category.name }}</td>
                  </tr>
                </tbody>
              </table>
                <Pager
                  v-if="pager.page_count > 1"
                  :totalPage="pager.page_count"
                  :page="pager.page"
                  @jumpPage="onPageChange"
                />
            </div>
          </div>
        </div>
      </div>
    </div>
    <Modal
      v-if="isModal"
      :title="category.id ? 'Chỉnh sửa' : 'Tạo mới'"
      @onSubmit="onSubmit"
      @onClose="isModal = false"
    >
      <form>
        <div class="mb-3">
          <label class="form-label">Tên phân loại</label>
          <input v-model="category.name" type="text" class="form-control" name="name" placeholder="Tên phân loại">
          <span v-for="error in errors['name']" :key="error" class="text-danger">
            {{ error }}
          </span>
        </div>
      </form>
    </Modal>
  </div>
</template>

<script>
import { CategoriesService } from '../../../services/staff/categories.service';
import _ from 'lodash';
import Pager from '../../../components/AdminPager.vue';
import Modal from '../../../components/Modal.vue';
import Validator from '../../../validator';

export default {
  components: {
    Pager,
    Modal,
  },
  data() {
    return {
      tableHeader: ["STT", "Loại sản phẩm"],
      categories: [],
      keySearch: null,
      pager: {
        page: 1,
        page_count: 1,
        page_size: 10,
        item_count: 0,
      },
      pageParams: {
        page: 1,
        page_size: 10,
        total_page: 1,
      },
      isModal: false,
      category: {
        id: null,
        name: null,
      },
      errors: {},
    }
  },
  mounted() {
    this.getCategories();
  },
  methods: {
    async getCategories() {
      const params = {
        name: this.keySearch,
        ...this.pageParams,
      }
      this.$loading(true);
      try {
        const { response } = await CategoriesService.index(params);
        this.categories = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    onSearch: _.debounce(async function() {
      this.getCategories();
    }, 500),

    onPageChange(page) {
      this.pageParams.page = page;
      this.getCategories();
    },

    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      
      const params = {
        name: this.category.name,
      }
      
      this.$loading(true);
      try {
        if (this.category.id) {
          await CategoriesService.update(this.category.id, params);
          this.getCategories();
        }
        else {
          await CategoriesService.create(params);
          this.getCategories();
        }
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
      this.isModal = false;
    },

    openModalCreate() {
      this.isModal = true;
      this.category = {
        id: null,
        name: null,
      }
    },

    openModalEdit(category) {
      this.isModal = true;
      this.category = category;
    },

    validate() {
      const validator = new Validator();
      validator.checkRequire('name', this.category.name, 'Tên phân loại') &&
        validator.checkMaxLength('name', this.category.name, 255, 'Tên phân loại');
      this.errors = validator.errors;
    },
  },
}
</script>
