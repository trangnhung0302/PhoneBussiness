<template>
  <div class="cart-container">
    <div class="cart-header">Đặt hàng</div>
    <div class="cart-content">
      <div class="customer-destinations">
        <div class="customer-destinations-container" @click="openSelectDestination">
          <div><b-icon-geo-alt variant="danger" scale="1.5" /><span class="ms-2">Địa chỉ nhận hàng</span></div>
          <div v-if="destination && destination.id">
            <div class="destination-address">
              {{ destination.recipient_name }} | {{ destination.recipient_phone }}
            </div>
            <div class="destination-address">
              {{ destination.address }}
            </div>
            <div class="destination-address">
              {{ destination.ward_name }} , {{ destination.district_name }} , {{ destination.province_name }}
            </div>
          </div>
          <div v-else>Chưa có địa chỉ nhận hàng</div>
        </div>
        <span v-for="error in errors['destination']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div class="cart-content-container">
        <div v-for="(cart, index) in carts" :key="index" class="cart-item">
          <div class="cart-item-image-container" @click="$router.push(`/${cart.category_id}-${cart.category_name}/${cart.supplier_id}-${cart.supplier_name}/${cart.item_id}-${cart.item_name}`)">
            <img :src="cart.item_images[0] ? cart.item_images[0].image_url : noImage" class="image-full-width">
          </div>
          <div class="cart-item-name-price" @click="$router.push(`/${cart.category_id}-${cart.category_name}/${cart.supplier_id}-${cart.supplier_name}/${cart.item_id}-${cart.item_name}`)">
            <div class="cart-item-name">{{ cart.item_name + (cart.color ? ' - ' + cart.color : '') }}</div>
            <div class="cart-item-price">{{ convertNumberFormat(cart.item_price) }}đ</div>
          </div>
          <div class="cart-item-quantity">
            <div class="display-item-quantity">{{ cart.quantity }}</div>
          </div>
        </div>
      </div>
      <div class="info-order">
        <div class="cart-item cart-item-d-block">
          <div class="w-100">
            <label class="form-label">Phương thức vận chuyển</label>
            <vSelect
              v-model="transport"
              :options="transports"
              :reduce="(option) => option"
              :clearable="false"
              class="v-select"
              label="short_name"
              @input="getShipAmount"
            >
              <span slot="no-options">Không có lựa chọn</span>
            </vSelect>
            <span v-for="error in errors['transport']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
          <div class="w-100 mt-3">
            <label class="form-label">Phương thức thanh toán</label>
            <vSelect
              v-model="paymentTypeId"
              :options="paymentTypes"
              :reduce="(option) => option.id"
              :clearable="false"
              class="v-select"
              label="name"
            >
              <span slot="no-options">Không có lựa chọn</span>
            </vSelect>
            <span v-for="error in errors['payment']" :key="error" class="text-danger">
              {{ error }}
            </span>
          </div>
        </div>
        <div class="cart-item cart-item-d-block">
          <div class="order-info-title">Chi tiết thanh toán</div>
          <div class="order-info-details">
            <div>Tổng tiền hàng</div>
            <div>{{ convertNumberFormat(totalPrice) }}đ</div>
          </div>
          <div class="order-info-details">
            <div>Tổng tiền phí vận chuyển</div>
            <div>{{ convertNumberFormat(shipAmount) }}đ</div>
          </div>
          <div class="order-info-details">
            <div>Giảm giá hàng</div>
            <div>0đ</div>
          </div>
          <div class="order-info-details">
            <div>Giảm giá phí vận chuyển</div>
            <div>0đ</div>
          </div>
          <div class="order-info-title order-info-details">
            <div>Tổng số tiền cần thanh toán</div>
            <div>{{ convertNumberFormat(totalPrice + shipAmount) }}đ</div>
          </div>
        </div>
      </div>
    </div>
    <div class="cart-footer">
      <div class="info-group-button">
        <button class="button-buy button-by-order h-60" @click="onSubmit">Mua ngay</button>
      </div>
    </div>
    <DestinationModal
      v-if="showSelectDestination"
      :customerDestinations="destinations"
      :destinationId="destination ? destination.id : null"
      @onClose="showSelectDestination = false"
      @onSubmitSelectDestination="onSubmitSelectDestination"
    />
    <CustomerModalError
      v-if="errors.item"
      :errors="errors.item"
      @onClose="errors.item = null"
    />
  </div>
</template>

<script>
import { OrdersService } from '../../../../services/customer/orders.service';
import { CustomerDestinationsService } from '../../../../services/customer/customer_destinations.service';
import { DestinationsService } from '../../../../services/customer/destinations.service';
import { PaymentTypesService } from '../../../../services/customer/payment_types.service';
import noImage from '../../../../../assets/images/no_image.png';
import utils from '../../../../common/util';
import DestinationModal from './DestinationModal.vue';
import CustomerModalError from '../../../../components/CustomerModalError.vue';
import constant from '../../../../common/constants';
import vSelect from 'vue-select';
import Validator from '../../../../validator';

export default {
  components: {
    DestinationModal,
    CustomerModalError,
    vSelect,
  },
  props: {
  carts: {
    typeof: Array,
    default: () => [],
  }
  },
  data() {
    return {
      noImage: noImage,
      destinations: [],
      destination: {},
      showSelectDestination: false,
      errors: {},
      showModalError: false,
      transports: [],
      transport: {},
      paymentTypes: [],
      paymentTypeId: null,
      totalPrice: 0,
      shipAmount: 0,
      isErrorByTranpost: false,
    }
  },
  mounted() {
    this.getDestination();
    this.getPaymentTypes();
  },
  watch: {
    destination(value) {
      if (value?.district_id) {
        this.getTransport();
      }
    },

    carts() {
      this.calculateTotalPrice();
    }
  },

  methods: {
    ...utils,

    async getTransport() {
      const params = {
        shop_id: constant.SHOP_GHN_ID,
        from_district: constant.SHOP_GHN_DISTRICT_ID,
        to_district: this.destination.district_id,
      }
      
      this.$loading(true);
      try {
        const { response } = await DestinationsService.getTransports(params);
        this.transports = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    calculateTotalPrice() {
      this.totalPrice = 0;
      this.carts.forEach(cart => {
        this.totalPrice += cart.quantity * cart.item_price;
      })
    },

    async getDestination() {
      this.$loading(true);
      try {
        const { response } = await CustomerDestinationsService.index();
        this.destinations = response.data;
        this.destination = this.destinations[0];
        this.$loading(false);
      } catch (error) {
        this.errors = {...this.errors, item: [error.response.message]}
        this.$loading(false);
      }
    },

    async getPaymentTypes() {
      this.$loading(true);
      try {
        const { response } = await PaymentTypesService.index();
        this.paymentTypes = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    }, 

    openSelectDestination() {
      this.showSelectDestination = true;
    },

    onSubmitSelectDestination(destination) {
      this.destination = destination;
      if (this.transport.service_type_id) {
        this.getShipAmount();
      }
      this.showSelectDestination = false;
    },

    validate() {
      const validator = new Validator();
      validator.checkRequire('destination', this.destination.id, 'Địa chỉ người nhận');
      validator.checkRequire('payment', this.paymentTypeId, 'Phương thức thanh toán');
      validator.checkRequire('transport', this.transport.service_type_id, 'Phương thức vận chuyển');

      this.errors = validator.errors;
    },

    async onSubmit() {
      if (this.isErrorByTranpost) return;
      this.validate();
      if (Object.keys(this.errors).length) return;

      const params = {
        order_items: this.carts.map(cart => {
          return {
            cart_id: cart.id,
            item_id: cart.item_id,
            quantity: cart.quantity,
            item_color_id: cart.item_color_id,
          }
        }),
        customer_destination_id: this.destination.id,
        ship_amount: this.shipAmount,
        transport_service_id: this.transport.service_type_id,
        transport_service_name: this.transport.short_name,
        payment_type_id: this.paymentTypeId,
        message: '',
      }

      this.$loading(true);
      try {
        const { response } = await OrdersService.create(params);
        const orderId = response.data.id;
        this.$router.push(`/customer/order_success/${orderId}`);
        this.$loading(false);
      } catch (error) {
        this.errors = {...this.errors, item: [error.response.result.message]}
        this.$loading(false);
      }
    },

    async getShipAmount() {
      const params = {
        height: 20,
        length: 30,
        weight: 3000,
        width: 40,
        insurance_value: 0,
        from_district_id: constant.SHOP_GHN_DISTRICT_ID,
        to_district_id: this.destination.district_id,
        to_ward_code: this.destination.ward_code,
        service_type_id: this.transport.service_type_id,
      }

      this.$loading(true);
      try {
        const { response } = await DestinationsService.getShipAmount(params);
        this.shipAmount = response.data.total;
        this.errors = {...this.errors, transport: []};
        this.isErrorByTranpost = false;
        this.$loading(false);
      } catch (error) {
        this.isErrorByTranpost = true;
        this.errors = {...this.errors, transport: ['Không có gói vận chuyển phù hợp']}
        this.$loading(false);
      }
    }
  }
}
</script>
