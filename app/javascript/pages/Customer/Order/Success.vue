<template>
  <div class="customer-auth-container">
      <div class="customer-auth-container-background d-flex">
        <div class="register-confirm-container">
          <div class="order-success-title">
            Đặt hàng thành công
          </div>
          <div v-if="order.account_number" class="info-payment-container">
            <img :src="qrCode.qrDataURL" class="image-qrcode">
            <div class="d-flex align-items-center">
              <div class="info-payment-content">
                <div>Vui lòng thanh toán</div>
                <div class="order-info-details">
                  <div>Chủ tài khoản</div>
                  <div>{{ order.account_holders }}</div>
                </div>
                <div class="order-info-details">
                  <div>Số tài khoản</div>
                  <div>{{ order.account_number }}</div>
                </div>
                <div class="order-info-details">
                  <div>Ngân hàng</div>
                  <div>{{ order.bank_name }}</div>
                </div>
                <div class="order-info-details">
                  <div>Số tiền</div>
                  <div>{{convertNumberFormat(Number(order.total_price) + Number(order.ship_amount)) }}đ</div>
                </div>
                <div class="order-info-details">
                  <div>Nội dung</div>
                  <div>{{ order.order_number }}</div>
                </div>
                <div class="btn-payment-container">
                  <button v-if="this.order.payment_status == 'wait_confirm'" class="button-buy order-success-btn-payment disabled">
                    Chờ xác nhận thanh toán
                  </button>
                  <button v-else-if="this.order.payment_status == 'paid'" class="button-buy order-success-btn-payment disabled">
                    Thanh toán thành công
                  </button>
                  <button v-else="this.order.payment_status == 'unpaid'" class="button-buy order-success-btn-payment" @click="updateOrderStatus()">
                    Click vào đây nếu bạn đã chuyển khoản
                  </button>
                </div>
              </div>
            </div>
          </div>
          <div class="btn-order-success">
            <button class="button-buy order-success-btn-buy" @click="$router.push('/')">Trang chủ</button>
            <button class="button-save-buy order-success-btn-save" @click="$router.push(`/customer/order_detail/${id}`)">Đơn hàng</button>
          </div>
        </div>
      </div>
  </div>
</template>

<script>
import { VietqrService } from '../../../services/customer/vietqr.service';
import { OrdersService } from '../../../services/customer/orders.service';
import utils from '../../../common/util';

export default {
  data() {
    return {
      id: this.$router.history.current.params.id,
      order: {},
      qrCode: {},
      acqId: null,
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
        if (this.order.account_number) {
          await this.getBank();
        }
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getQrCode() {
      const params = {
        accountNo: this.order.account_number,
        accountName: this.order.account_holders,
        acqId: this.acqId,
        amount: Number(this.order.total_price) + Number(this.order.ship_amount),
        addInfo: this.order.order_number,
        format: "text",
        template: "compact"
      }
      this.$loading(true);
      try {
        const { response } = await VietqrService.getQrCode(params);
        this.qrCode = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getBank() {
      this.$loading(true);
      try {
        const { response } = await VietqrService.getBanks();
        const banks = response.data;
        if (banks.length > 0) {
          this.acqId = banks.filter(bank => bank.shortName == this.order.bank_name)[0]?.bin;
          if (this.acqId) {
            await this.getQrCode();
          }
        }
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
    },

    async updateOrderStatus() {
      const params = {
        payment_status: 20
      }
      this.$loading(true);
      try {
        const { response } = await OrdersService.update(this.id, params);
        this.order = response.data;
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
    }
  },
}
</script>

<style scoped>
.button-buy {
  height: unset !important;
  padding: 10px;
}

.button-buy.disabled {
  background-color: #cccccc !important;
}
</style>
