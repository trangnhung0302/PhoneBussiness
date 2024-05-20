<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Danh sách hãng sản phẩm</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="list_header">
            <div class="box_right d-flex lms_block">
              <div class="serach_field_2">
                <div class="search_inner">
                  <input v-model="keySearch" type="text" class="" placeholder="Tìm kiếm hãng sản phẩm" @input="onSearch">
                  <div class="icon-search"><b-icon-search scale="1.5" /></div>
                </div>
              </div>
              <div class="add_button ms-2">
                <button class="btn-create" @click="$router.push(`supplier/create`)">Thêm mới</button>
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
                  <tr v-for="(supplier, index) in suppliers" :key="index" class="cursor-pointer" @click="$router.push(`supplier/${supplier.id}/edit`)">
                    <td>{{ index + 1 }}</td>
                    <td><img :src="supplier.logo ? supplier.logo : noImage" class="image-in-table"></td>
                    <td>{{ supplier.name }}</td>
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
  </div>
</template>

<script>
import { SuppliersService } from '../../../services/staff/suppliers.service';
import _ from 'lodash';
import Pager from '../../../components/AdminPager.vue';
import noImage from '../../../../assets/images/no_image.png';

export default {
  components: {
    Pager,
  },
  data() {
    return {
      tableHeader: ["STT", "Logo", "Hãng sản phẩm"],
      suppliers: [],
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
      noImage: noImage,
    }
  },
  mounted() {
    this.getSuppliers();
  },
  methods: {
    async getSuppliers() {
      const params = {
        name: this.keySearch,
        ...this.pageParams,
      }
      this.$loading(true);
      try {
        const { response } = await SuppliersService.index(params);
        this.suppliers = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    onSearch: _.debounce(async function() {
      this.getSuppliers();
    }, 500),

    onPageChange(page) {
      this.pageParams.page = page;
      this.getSuppliers();
    },
  },
}
</script>
