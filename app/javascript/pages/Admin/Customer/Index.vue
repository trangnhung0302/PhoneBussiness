<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Danh sách khách hàng</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="list_header">
            <div class="box_right d-flex lms_block">
              <div class="serach_field_2">
                <div class="search_inner">
                  <input v-model="keySearch" type="text" class="" placeholder="Tìm kiếm nhân viên" @input="onSearch">
                  <div class="icon-search"><b-icon-search scale="1.5" /></div>
                </div>
              </div>
              <div class="add_button ms-2">
                <button class="btn-create" @click="$router.push('staff/create')">Thêm mới</button>
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
                  <tr v-for="(customer, index) in customers" :key="index" class="cursor-pointer">
                    <td>{{ customer.name }}</td>
                    <td>{{ customer.email }}</td>
                    <td>{{ customer.phone }}</td>
                    <td>
                      <select v-model="customer.status" class="form-control" @change="updateStatus(customer)">
                        <option v-for="(status, index) in statusList" :key="index" :value="status.status">{{ status.text }}</option>
                      </select>
                    </td>
                  </tr>
                </tbody>
              </table>
              <Pager
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
import { CustomersService } from '../../../services/admin/customers.service';
import _ from 'lodash';
import Pager from '../../../components/AdminPager.vue';
import vSelect from 'vue-select';

export default {
  components: {
    Pager,
    vSelect,
  },
  data() {
    return {
      tableHeader: ["Tên", "Email", "Số điện thoại", "Trạng thái"],
      customers: [],
      statusList: [
        { text: "Chưa xác thực", status: 'not_yet_authenticated', color: "orange" },
        { text: "Hoạt động", status: 'active', color: "green" },
        { text: "Khóa", status: 'block', color: "red" },
      ],
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
      }
    }
  },
  mounted() {
    this.getCustomers();
  },
  methods: {
    async getCustomers() {
      const params = {
        name: this.keySearch,
        ...this.pageParams,
      }
      this.$loading(true);
      try {
        const { response } = await CustomersService.index(params);
        this.customers = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    onSearch: _.debounce(async function() {
      this.getCustomers();
    }, 500),

    onPageChange(page) {
      this.pageParams.page = page;
      this.getCustomers();
    },

    async updateStatus(customer) {
      const params = {
        status: customer.status,
      }
      console.log(customer);
      console.log(params);
      this.$loading(true);
      try {
        await CustomersService.update(customer.id, params);
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },
  },
}
</script>
