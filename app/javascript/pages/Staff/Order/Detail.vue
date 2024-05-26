<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Chi tiết đơn hàng</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="card-body">
            <div class="admin-form">
              <div class="mb-3">
                <label class="form-label">Mã đơn hàng</label>
                <input :value="order.order_number" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Thời gian đặt hàng</label>
                <input :value="formatDateTime(order.created_at)" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Tài khoản đặt hàng</label>
                <input :value="order.customer_email" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Tên người đặt hàng</label>
                <input :value="order.customer_name" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Phương thức thanh toán</label>
                <input :value="order.payment_type" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Phương thức vận chuyển</label>
                <input :value="order.transport_service_name" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Trạng thái thanh toán</label>
                <vSelect
                  v-model="order.payment_status"
                  :options="paymentStatus"
                  :reduce="(option) => option.value"
                  :clearable="false"
                  class="v-select"
                  label="name"
                  @input="updateOrder()"
                >
                  <span slot="no-options">Không có lựa chọn</span>
                </vSelect>
              </div>
              <div class="mb-3">
                <label class="form-label">Trạng thái vận chuyển</label>
                <vSelect
                  v-model="order.status"
                  :options="orderStatus"
                  :reduce="(option) => option.value"
                  :clearable="false"
                  class="v-select"
                  label="name"
                  @input="updateOrder()"
                >
                  <span slot="no-options">Không có lựa chọn</span>
                </vSelect>
              </div>
            </div>
            <div class="fs-4 mb-3">Thông tin người nhận</div>
            <div class="admin-form">
              <div class="mb-3">
                <label class="form-label">Tên người nhận</label>
                <input :value="customer_destination.recipient_name" class="form-control" disabled>
              </div>
              <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <input :value="customer_destination.recipient_phone" class="form-control" disabled>
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label">Địa chỉ người nhận</label>
              <textarea :value="`${customer_destination.address}\n${customer_destination.ward_name}, ${customer_destination.district_name}, ${customer_destination.province_name}`" class="form-control" disabled></textarea>
            </div>
            <div class="fs-4 mb-3">Thông tin mặt hàng</div>
            <div class="cart-content-container mb-3">
              <div v-for="(item, index) in order.items" :key="index" class="cart-item">
                <div class="cart-item-image-container">
                  <img :src="item.item_image ? item.item_image : noImage" class="image-full-width">
                </div>
                <div class="cart-item-name-price">
                  <div class="cart-item-name">{{ item.item_name }}</div>
                  <div class="cart-item-price">{{ convertNumberFormat(item.price) }}đ</div>
                </div>
                <div class="cart-item-quantity">
                  <div class="display-item-quantity">{{ item.quantity }}</div>
                </div>
              </div>
            </div>
            <div class="fs-4 mb-3">Thông tin thanh toán</div>
            <div class="cart-item cart-item-d-block">
              <div class="order-info-details">
                <div>Tổng tiền hàng</div>
                <div>{{ convertNumberFormat(order.total_price) }}đ</div>
              </div>
              <div class="order-info-details">
                <div>Phí vận chuyển</div>
                <div>0đ</div>
              </div>
              <div class="order-info-details">
                <div>Giảm giá hàng</div>
                <div>0đ</div>
              </div>
              <div class="order-info-details">
                <div>Giảm giá vận chuyển</div>
                <div>0đ</div>
              </div>
              <div class="order-info-title order-info-details">
                <div>Tổng số tiền</div>
                <div>{{ convertNumberFormat(order.total_price) }}đ</div>
              </div>
            </div>
            <div v-if="order.review && order.review.id">
              <div class="fs-4 mb-3">Đánh giá khách hàng</div>
              <div class="mt-3">
                <label>Chất lượng sản phẩm</label>
                <div class="d-flex gap-5px mt-1">
                  <b-icon-star-fill v-for="star in new Array(order.review.ratings).fill(0).map((_, i) => i + 1)" :key="star" variant="danger" scale="1.2" class="cursor-pointer"></b-icon-star-fill>
                  <b-icon-star v-for="star in new Array(5 - order.review.ratings).fill(order.review.ratings).map((_, i) => i + 1)" :key="star + order.review.ratings" scale="1.2" variant="danger" class="cursor-pointer"></b-icon-star>
                </div>
              </div>
              <div class="mt-3">
                <label>Mô tả sản phẩm</label>
                <textarea v-model="order.review.review" class="form-control height-three-line mt-1" disabled></textarea>
              </div>
              <div class="mt-3">
                <label>Phản hồi</label>
                <textarea v-model="order.review.reply" class="form-control height-three-line mt-1"></textarea>
              </div>
              <div class="admin-form-button d-flex justify-content-center mt-2">
                <button type="button" class="btn btn-primary admin-btn-primary mb-2" @click="updateOrder">Cập nhật phản hồi</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { OrdersService } from '../../../services/staff/orders.service';
import utils from '../../../common/util';
import constants from '../../../common/constants';
import vSelect from 'vue-select';
import noImage from '../../../../assets/images/no_image.png';
import moment from 'moment';

export default {
  components: {
    vSelect,
  },
  data() {
    return {
      id: this.$router.history.current.params.id,
      order: {},
      paymentStatus: constants.paymentStatus,
      orderStatus: constants.orderStatus,
      customer_destination: {},
      noImage: noImage,
    }
  },
  mounted() {
    this.getOrder();
  },
  methods: {
    ...utils,

    async getOrder() {
      this.$loading(true);
      try {
        const { response } = await OrdersService.get(this.id);
        this.order = response.data;
        this.customer_destination = this.order.customer_destination;
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
    },

    async updateOrder() {
      const params = {
        payment_status: this.order.payment_status,
        status: this.order.status,
        review: {
          reply: this.order.review ? this.order.review.reply : null
        }
      }

      this.$loading(true);
      try {
        await OrdersService.update(this.id, params);
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
    },

    formatDateTime(date) {
      return moment(date).format('HH:mm DD/MM/YYYY');
    },
  },
}
</script>

<style scoped>
.height-three-line {
  height: 90px;
}
</style>
