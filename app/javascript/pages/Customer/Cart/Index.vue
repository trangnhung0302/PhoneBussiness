<template>
  <div class="cart-container">
    <div class="cart-header">Giỏ hàng của bạn</div>
    <div class="cart-content">
      <div class="cart-content-container">
        <div v-for="(cart, index) in carts" :key="index" class="cart-item">
          <div class="cart-item-radio"><input v-model="cart.checked" type="checkbox"></div>
          <div class="cart-item-image-container" @click="$router.push(`/${cart.category_id}-${cart.category_name}/${cart.supplier_id}-${cart.supplier_name}/${cart.item_id}-${cart.item_name}`)">
            <img :src="cart.item_images[0] ? cart.item_images[0].image_url : noImage" class="image-full-width">
          </div>
          <div class="cart-item-name-price"  @click="$router.push(`/${cart.category_id}-${cart.category_name}/${cart.supplier_id}-${cart.supplier_name}/${cart.item_id}-${cart.item_name}`)">
            <div class="cart-item-name">{{ cart.item_name + (cart.color ? ' - ' + cart.color : '') }}</div>
            <div class="cart-item-price">{{ convertNumberFormat(cart.item_price) }}đ</div>
          </div>
          <div class="cart-item-quantity">
            <button class="button-change-quantity left" @click="changeQuantity(cart, -1)"><b-icon-dash variant="danger" scale="1.5" /></button>
            <div class="display-item-quantity">{{ cart.quantity }}</div>
            <button class="button-change-quantity right" @click="changeQuantity(cart, 1)"><b-icon-plus variant="danger" scale="1.5" /></button>
          </div>
        </div>
      </div>
    </div>
    <div class="cart-footer">
      <div class="info-group-button">
        <button class="button-save-buy h-60" @click="updateCarts">Cập nhật giỏ hàng</button>
        <button class="button-buy h-60" @click="onSubmit">Mua ngay</button>
      </div>
    </div>
    <CheckSuccess
      :show="showCheckSuccess"
      @onClose="showCheckSuccess = false"
    />
  </div>
</template>

<script>
import { CartsService } from '../../../services/customer/carts.service';
import noImage from '../../../../assets/images/no_image.png';
import utils from '../../../common/util';
import CheckSuccess from '../../../components/CheckSuccess.vue';

export default {
  components: {
    CheckSuccess,
  },
  data() {
    return {
      carts: [],
      noImage: noImage,
      showCheckSuccess: false,
    }
  },
  mounted() {
    this.getCarts();
  },
  methods: {
    ...utils,

    async getCarts() {
      this.$loading(true);
      try {
        const { response } = await CartsService.index();
        this.carts = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    changeQuantity(cart, value) {
      if (cart.quantity + value < 0 || cart.quantity + value > 99) return;
      cart.quantity = cart.quantity + value;
    },

    async updateCarts() {
      const params = { carts: this.carts.map(cart => {
        return {
          id: cart.id,
          quantity: cart.quantity,
        }
      })};

      this.$loading(true);
      try {
        await CartsService.updateCarts(params);
        this.getCarts();
        this.$loading(false);
        this.showCheckSuccess = true;
      } catch (error) {
        this.$loading(false);
      }
    },

    async onSubmit() {
      const cartIds = this.carts.filter(c => c.checked).map(c => c.id).join(',');
      if (cartIds != '') {
        await this.updateCarts();
        localStorage.setItem('cart_ids', cartIds);
        this.$router.push('/customer/order');
      }
    },
  },
}
</script>
