<template>
  <div class="customer-content-container">
    <div class="customer-bottom-sidebar">
      <button class="d-flex align-items-center" @click="$router.push('/')">
        <b-icon-house-door-fill variant="danger" /><span class="ms-2">Trang chủ</span>
      </button>
      <div>
        <b-icon-caret-right />
      </div>
      <button @click="$router.push(`/${category.id}-${category.name}`)">{{ category.name }}</button>
      <div>
        <b-icon-caret-right />
      </div>
      <button @click="$router.push(`/${category.id}-${category.name}/${supplier.id}-${supplier.name}`)">{{ supplier.name }}</button>
      <div>
        <b-icon-caret-right />
      </div>
      <button>{{ item.name }}</button>
    </div>
    <div class="space-height" />
    <div class="show-item-container">
      <div class="show-item-header">
        <h4>{{ item.name }}</h4>
      </div>
      <div class="show-item-content">
        <div class="show-item-image">
          <div class="show-image-first">
            <img :src="item.item_images && item.item_images[indexImage] ? item.item_images[indexImage].image_url : noImage" class="image-full-width br-10">
          </div>
          <div class="show-list-image">
            <div class="cursor-pointer" @click="onChangeImage(indexImage + 1)">
              <b-icon-arrow-left-square scale="1.5" />
            </div>
            <div class="show-image-scroll">
              <div v-for="(image, index) in item.item_images" :key="index" class="show-image-bonus cursor-pointer" @click="onChangeImage(index)">
                <img :src="image.image_url" class="image-full-width br-4">
              </div>
            </div>
            <div class="cursor-pointer" @click="onChangeImage(indexImage + 1)">
              <b-icon-arrow-right-square scale="1.5" />
            </div>
          </div>
        </div>
        <div class="info-item">
          <div class="info-item-price">
            <div class="info-item-price-red">{{ convertNumberFormat(itemColorSelect ? itemColorSelect.price : item.price) }}đ</div>
            <div class="info-item-price-gray">{{ convertNumberFormat(itemColorSelect ? itemColorSelect.original_price : item.original_price) }}đ</div>
            <div>| Đã bao gồm VAT</div>
          </div>
          <div v-if="item.status == 'stop_selling'" class="text-danger fs-3">
            Ngưng bán
          </div>
          <div v-else-if="item.status == 'out_of_stock'" class="text-danger fs-3">
            Hết hàng
          </div>
          <div class="info-item-order">
            <div class="info-free-ship">
              <b-icon-truck />
              Miễn phí vận chuyển toàn quốc khi trở thành VIP member
            </div>
            <div class="mt-3">
              <div>Lựa chọn màu</div>
              <div class="cm-item-color-content">
                <template v-for="(itemColor, index) in itemColors">
                  <div :key="index" v-if="itemColor.quantity > 0" class="cm-item-color-element" :class="itemColor.id == itemColorSelectId ? 'active' : ''" @click="itemColorSelectId = itemColor.id">
                    <input v-model="itemColorSelectId" type="radio" :value="itemColor.id" name="item-color"><label class="ms-2">{{ itemColor.color }}</label>
                    <div class="text-danger">{{ convertNumberFormat(itemColor.price) }}</div>
                  </div>
                  <div v-else class="cm-item-color-element disabled">
                    <input type="radio" name="item-color" disabled><label class="ms-2">{{ itemColor.color }}</label>
                    <div class="text-danger">{{ convertNumberFormat(itemColor.price) }}</div>
                  </div>
                </template>
              </div>
            </div>
            <div class="info-group-button">
              <button class="button-buy" :class="item.status == 'active' ? '' : 'btn-disabled'" @click="item.status == 'active' ? showModalBuy = true : ''">Mua ngay</button>
              <button class="button-save-buy" :class="item.status == 'active' ? '' : 'btn-disabled'" @click="item.status == 'active' ? showModalCart = true : ''">Thêm vào giỏ hàng</button>
            </div>
          </div>
        </div>
      </div>
      <div class="item-note mt-4">
        <div class="item-note-title">ĐẶC ĐIỂM NỔI BẬT</div>
        <div>
          {{ item.note }}
        </div>
      </div>
      <div class="mt-4">
        <div style="font-weight: 500; font-size: 18px;">Đánh giá sản phẩm</div>
        <hr>
        <div v-for="(review, index) in reviews" :key="index">
          <Ratings :review="review" ></Ratings>
          <hr>
        </div>
      </div>
    </div>
    <CheckSuccess
      :show="showCheckSuccess"
      @onClose="showCheckSuccess = false"
    />
    <CustomerModal
      v-if="showModalBuy || showModalCart"
      :title="`Chọn số lượng`"
      @onClose="onCloseQuantity"
      @onSubmit="onSubmitModal"
    >
      <div class="cart-item-quantity">
        <button class="button-change-quantity left" @click="changeQuantity(-1)"><b-icon-dash variant="danger" scale="1.5" /></button>
        <div class="display-item-quantity">{{ quantity }}</div>
        <button class="button-change-quantity right" @click="changeQuantity(1)"><b-icon-plus variant="danger" scale="1.5" /></button>
      </div>
    </CustomerModal>
  </div>
</template>

<script>
import { ItemsService } from '../../../services/items.service';
import noImage from '../../../../assets/images/no_image.png';
import utils from '../../../common/util';
import { CartsService } from '../../../services/customer/carts.service';
import CheckSuccess from '../../../components/CheckSuccess.vue';
import CustomerModal from '../../../components/CustomerModal.vue';
import Ratings from '../../../components/Ratings.vue';

export default {
  components: {
    CheckSuccess,
    CustomerModal,
    Ratings,
  },
  data() {
    return {
      category: {
        id: this.$router.history.current.params.category_id,
        name: this.$router.history.current.params.category_name,
      },
      supplier: {
        id: this.$router.history.current.params.supplier_id,
        name: this.$router.history.current.params.supplier_name,
      },
      item: {
        id: this.$router.history.current.params.item_id,
        name: this.$router.history.current.params.item_name,
        price: 0,
        original_price: 0,
      },
      noImage: noImage,
      indexImage: 0,
      showCheckSuccess: false,
      showModalBuy: false,
      showModalCart: false,
      quantity: 1,
      newCartId: null,
      itemColors: [],
      itemColorSelectId: null,
      itemColorSelect: null,
      reviews: [],
    }
  },
  async mounted() {
    await this.getItems();
  },
  watch: {
    itemColorSelectId(value) {
      this.itemColorSelect = this.itemColors.filter(itemColor => itemColor.id == this.itemColorSelectId)[0];
    }
  },
  methods: {
    ...utils,

    async getItems() {
      this.$loading(true);
      try {
        const { response } = await ItemsService.get(this.item.id);
        this.item = response.data;
        this.itemColors = this.item.item_colors;
        if (this.itemColors.length) {
          this.itemColorSelectId = this.itemColors[0].id;
        }
        this.reviews = response.reviews;
        console.log(this.reviews);
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    onChangeImage(index) {
      this.indexImage = index % this.item.item_images.length;
    },

    async addToCart(isBuy = false) {
      const params = {
        quantity: this.quantity,
        item_id: this.item.id,
        item_color_id: this.itemColorSelectId,
      }

      this.onCloseQuantity();

      this.$loading(true);
      try {
        const { response } = await CartsService.create(params);
        if (!isBuy) {
          this.showCheckSuccess = true;
        }
        else {
          this.newCartId = response.data.id;
        }
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    onCloseQuantity() {
      this.showModalBuy = false;
      this.showModalCart = false;
      this.quantity = 1;
    },

    changeQuantity(value) {
      const newQuantity = this.quantity + value;
      if (newQuantity < 1 || newQuantity > 99) return;
      this.quantity = newQuantity;
    },

    async onSubmitModal() {
      if (this.showModalCart) {
        this.addToCart();
      }
      else if(this.showModalBuy) {
        await this.addToCart(true);
        localStorage.setItem('cart_ids', this.newCartId);
        this.$router.push('/customer/order');
      }
    },
  },
}
</script>

<style scoped>
.cart-item-quantity {
  width: fit-content;
  margin: auto;
}

.button-change-quantity {
  width: 50px;
  height: 50px;
}

.display-item-quantity {
  width: 50px;
  height: 50px;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
