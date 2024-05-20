<template>
  <Form
    :carts="carts"
  />
</template>

<script>
import Form from "./components/Form.vue";
import { CartsService } from '../../../services/customer/carts.service';

export default {
  components: {
    Form,
  },
  data() {
    return {
      cartIds: localStorage.getItem('cart_ids'),
      carts: [],
    }
  },
  mounted() {
    this.getCarts();
  },
  methods: {
    async getCarts() {
      const params = {
        cart_ids: this.cartIds.split(","),
      }
      this.$loading(true);
      try {
        const { response } = await CartsService.index(params);
        this.carts = response.data;
        if (!this.carts.length) {
          this.$router.push('/customer/cart');
        }
        this.calculateTotalPrice();
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },
  }
}
</script>
