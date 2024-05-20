<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Danh sách đơn hàng</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="list_header">
            <div class="box_right d-flex lms_block">
              <div class="serach_field_2">
                <div class="search_inner">
                  <input v-model="keySearch" type="text" class="" placeholder="Tìm kiếm sản phẩm" @input="onSearch">
                  <div class="icon-search"><b-icon-search scale="1.5" /></div>
                </div>
              </div>
              <div class="add_button ms-2">
                <button class="btn-create" @click="$router.push(`item/create`)">Thêm mới</button>
              </div>
            </div>
          </div>
          <div class="list_header mt-3">
            <div class="search-status">
              <div class="search-order">
                <vSelect
                  v-model="searchPaymentStatus"
                  :options="paymentStatus"
                  :reduce="(option) => option.value"
                  class="v-select"
                  label="name"
                  placeholder="Trạng thái thanh toán"
                  @input="getOrders()"
                >
                  <span slot="no-options">Không có lựa chọn</span>
                </vSelect>
              </div>
              <div class="search-order">
                <vSelect
                  v-model="searchOrderStatus"
                  :options="orderStatus"
                  :reduce="(option) => option.value"
                  class="v-select"
                  label="name"
                  placeholder="Trạng thái vận chuyển"
                  @input="getOrders()"
                >
                  <span slot="no-options">Không có lựa chọn</span>
                </vSelect>
              </div>
            </div>
          </div>
          <div class="list_header mt-3">
            <div class="search-status">
              <DateTimePicker v-model="month" format="MM/YYYY"
                              :editable="false" :clearable="false"
                              class="input_wrapper calender full_width" input-class="calendar__input calendar-text"
                              type="month"
                              :disabled-date="(date) => date > (new Date().setHours(0, 0, 0, 0))"
                              @input="getOrders()"
              >
                <span slot="icon-calendar">
                  <b-icon-calendar />
                </span>
              </DateTimePicker>
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
                  <tr v-for="(order, index) in orders" :key="index" class="cursor-pointer" @click="$router.push(`order/${order.id}/details`)">
                    <td>{{ formatDate(order.created_at) }}</td>
                    <td>{{ order.order_number }}</td>
                    <td>{{ order.customer_name }}</td>
                    <td>{{ paymentStatus.filter(e => e.value === order.payment_status)[0].name }}</td>
                    <td>{{ orderStatus.filter(e => e.value === order.status)[0].name }}</td>
                    <td>{{ order.staff_name }}</td>
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
import { OrdersService } from '../../../services/staff/orders.service';
import _ from 'lodash';
import Pager from '../../../components/AdminPager.vue';
import noImage from '../../../../assets/images/no_image.png';
import vSelect from 'vue-select';
import constants from '../../../common/constants';
import moment from 'moment';
import DatePicker from 'vue2-datepicker';
import 'vue2-datepicker/index.css';

export default {
  components: {
    Pager,
    vSelect,
    DatePicker,
  },
  data() {
    return {
      tableHeader: ["Ngày tạo", "Mã đơn hàng", "Tên khách hàng", "Trạng thái thanh toán", "Trạng thái vận chuyển", "Nhân viên cập nhật"],
      orders: [],
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
      searchPaymentStatus: '',
      searchOrderStatus: '',
      paymentStatus: constants.paymentStatus,
      orderStatus: constants.orderStatus,
      month: new Date(),
    }
  },
  mounted() {
    this.getOrders();
    setInterval(() => {
      this.getOrders();
    }, 300000);
  },
  methods: {
    async getOrders() {
      const params = {
        key_search: this.keySearch,
        status: this.searchOrderStatus,
        payment_status: this.searchPaymentStatus,
        month: moment(this.month).format('YYYY/MM/DD'),
        ...this.pageParams,
      }
      this.$loading(true);
      try {
        const { response } = await OrdersService.index(params);
        this.orders = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    onSearch: _.debounce(async function() {
      this.getOrders();
    }, 500),

    onPageChange(page) {
      this.pageParams.page = page;
      this.getOrders();
    },

    formatDate(date) {
      return moment(date).format('DD/MM/YYYY');
    },
  },
}
</script>

<style scoped>
.dataTables_wrapper {
  min-width: 900px !important;
}
</style>
