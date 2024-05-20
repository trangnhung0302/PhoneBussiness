<template>
  <div class="cart-container">
    <div class="cart-header">Lịch sử đơn hàng</div>
    <div class="cart-content cart-content-order-history">
      <div class="cart-content-container">
        <div v-for="(order, index) in orders" :key="index" class="cart-item d-block">
          <div @click="$router.push(`/customer/order_detail/${order.id}`)">
            <div class="order-history-item">
              <div class="cart-item-image-container">
                <img :src="order.order_items[0] && order.order_items[0].item_images[0] && order.order_items[0].item_images[0].image_url ? order.order_items[0].item_images[0].image_url : noImage" class="image-full-width">
              </div>
              <div class="cart-item-name-price">
                <div class="cart-item-name">{{ order.order_items[0] && (order.order_items[0].item_name + (order.order_items[0].color ? ' - ' + order.order_items[0].color : '')) }}</div>
                <div class="cart-item-price">{{ convertNumberFormat(order.order_items[0] ? order.order_items[0].item_price : 0) }}đ</div>
              </div>
              <div class="cart-item-quantity">
                <div class="display-item-quantity">{{ order.order_items[0] ? order.order_items[0].quantity : 0}}</div>
              </div>
            </div>
            <hr>
            <div class="order-history-subcontent">
              <div>
                {{ order.order_items.length }} sản phẩm
              </div>
              <div>
                Thành tiền: {{ convertNumberFormat(Number(order.total_price) + Number(order.ship_amount)) }}
              </div>
            </div>
          </div>
          <hr>
          <div class="order-history-subcontent">
            <div>Mã đơn hàng: {{ order.order_number }}</div>
            <div>{{ displayDateTime(order.created_at) }}</div>
          </div>
          <hr>
          <div class="order-history-subcontent">
            <div>{{ displayOrderStatus(order.status) }}</div>
            <button class="button-reorder" @click="$router.push(`/customer/reorder/${order.id}`)">Mua lại</button>
          </div>
        </div>
      </div>
      <scroll-loader :loader-method="onPageChange" :loader-disable="disable" />
    </div>
  </div>
</template>

<script>
import { OrdersService } from '../../../services/customer/orders.service';
import noImage from '../../../../assets/images/no_image.png';
import utils from '../../../common/util';
import moment from 'moment';
import Vue from 'vue';
import ScrollLoader from 'vue-scroll-loader';
Vue.use(ScrollLoader);

export default {
  data() {
    return {
      orders: [],
      noImage: noImage,
      disable: false,
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
    this.getOrders();
  },
  methods: {
    ...utils,

    async getOrders() {
      try {
        const { response } = await OrdersService.index(this.pageParams);
        this.orders = [...this.orders, ...response.data];
        this.pager = response.pager;
        this.disable = this.pager.page === this.pager.page_count;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    displayDateTime(dateTime) {
      return moment(dateTime).format('HH:mm DD/MM/YYYY');
    },

    onPageChange() {
      this.pageParams.page++;
      this.getOrders();
    },

    displayOrderStatus(status) {
      switch (status) {
        case 'complete':
          return ' Giao hàng thành công'
        case 'transporting':
          return ' Đang vận chuyển'
        case 'prepare':
          return 'Đang chuẩn bị hàng'
        case 'cancel':
          return 'Đã hủy'
        default:
          return 'Chờ xác nhận'
      }
    },
  }
}
</script>
