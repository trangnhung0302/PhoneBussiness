<template>
  <Form
    :carts="carts"
  />
</template>

<script>
import { OrdersService } from '../../../services/customer/orders.service';
import Form from "./components/Form.vue";

export default {
  components: {
    Form,
  },
  data() {
    return {
      id: this.$router.history.current.params.id,
      carts: [],
    }
  },
  mounted() {
    this.getCarts();
  },

  methods: {
    async getCarts() {
      this.$loading(true);
      try {
        const { response } = await OrdersService.get(this.id);
        this.carts = response.data.order_items;
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
