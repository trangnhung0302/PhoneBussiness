<template>
  <main class="main-container">
    <div v-if="isSuggestItem" class="backdrop-main" @click="isSuggestItem = false"></div>
    <div class="customer-sidebar">
      <div class="customer-sidebar-container">
        <div class="customer-sidebar-left">
          <div class="customer-sidebar-item" @click="$router.push('/')">
            <b-icon-lightning-charge variant="warning" scale="2"></b-icon-lightning-charge>
            <span class="ms-2 text-hidden-mobile">STORENAME</span>
          </div>
          <div class="customer-sidebar-item">
            <div class="serach_field_2">
              <input v-model="nameSearch" type="text" class="form-control input-search-user" placeholder="Hôm nay bạn cần tìm gì?" @input="onSearchItems" @click="isSuggestItem = true">
              <div class="icon-search-end"><b-icon-search scale="1.5" /></div>
              <div v-if="isSuggestItem" class="list-item-suggest-container">
                <div>
                  <div class="item-suggest-header">Sản phẩm gợi ý</div>
                  <div v-if="suggestItems.length">
                    <div v-for="(item, index) in suggestItems" :key="index" class="item-suggest" @click="onSelectItem(item)">
                      <div class="div-img-search">
                        <img :src="item.item_images[0] ? item.item_images[0].image_url : noImage" class="img-search">
                      </div>
                      <div>
                        <div class="item-suggest-name">{{ item.name }}</div>
                        <div class="d-flex align-items-end">
                          <div class="item-suggest-red">{{ convertNumberFormat(item.price) }}đ</div>
                          <div class="item-suggest-gray">{{ convertNumberFormat(item.original_price) }}đ</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div v-else class="mt-2">
                    Không tìm thấy sản phẩm nào
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="customer-sidebar-right">
          <div class="customer-sidebar-item" @click="$router.push('/customer/order_history')">
            <b-icon-clock-history variant="light" scale="1.5"></b-icon-clock-history>
            <div class="number-phone-contact text-hidden-mobile">
              <div><span>Lịch sử</span></div>
              <div><span>đặt hàng</span></div>
            </div>
          </div>
          <div class="customer-sidebar-item" @click="$router.push('/customer/cart')">
            <b-icon-cart variant="light" scale="1.5"></b-icon-cart>
            <div class="number-phone-contact text-hidden-mobile">
              <div><span>Giỏ hàng</span></div>
            </div>
          </div>
          <div v-if="isLogin" class="customer-sidebar-item" @click="logout">
            <b-icon-person variant="light" scale="1.5"></b-icon-person>
            <div class="number-phone-contact text-hidden-mobile">
              <div><span>Đăng xuất</span></div>
            </div>
          </div>
          <div v-else class="customer-sidebar-item" @click="$router.push('/customer/login')">
            <b-icon-person variant="light" scale="1.5"></b-icon-person>
            <div class="number-phone-contact text-hidden-mobile">
              <div><span>Đăng nhập</span></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="customer-container">
      <router-view />
    </div>
  </main>
</template>

<script>
import noImage from '../../assets/images/no_image.png';
import { ItemsService } from '../services/items.service';
import _ from 'lodash';
import utils from '../common/util';
import { AuthService } from '../services/customer/auth.service';

export default {
  data() {
    return {
      sidebar: [
        { text: 'Trang chủ', url: ''},
        { text: 'Giới thiệu', url: ''},
        { text: 'Trung tâm bảo hành', url: ''},
        { text: 'Hệ thống cửa hàng', url: ''},
        { text: 'Tuyển dụng', url: ''},
        { text: 'Trang cứu đơn hàng', url: ''},
        { text: 'Đăng nhập', url: ''},
      ],
      suggestItems: [],
      nameSearch: '',
      noImage: noImage,
      isSuggestItem: false,
      isLogin: localStorage.getItem('customer_login'),
    }
  },
  mounted() {
    this.getItems();
  },
  methods: {
    ...utils,

    async getItems() {
      const params = {
        name: this.nameSearch,
      }
      this.$loading(true);
      try {
        const { response } = await ItemsService.index({...params, page_size: 5});
        this.suggestItems = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    onSearchItems: _.debounce(async function() {
      this.getItems();
    }, 500),

    onSelectItem(item) {
      this.$router.push(`/${item.category_id}-${item.category_name}/${item.supplier_id}-${item.supplier_name}/${item.id}-${item.name}`);
      this.isSuggestItem = false;
    },

    async logout() {
      this.$loading(true);
      try {
        await AuthService.logout();
        this.$loading(true);
      } catch (error) {
        this.$loading(false);
      }
      window.location.reload();
    }
  },
}
</script>

<style lang="scss" scoped>

.customer-sidebar {
  width: 100%;
  display: flex;
  position: fixed;
  padding: 10px 20px;
  background: #d70018;
  color: #FFFFFF;
  z-index: 10;

  .customer-sidebar-container {
    display: flex;
    width: 100%;
    justify-content: space-between;

    .customer-sidebar-left {
      display: flex;
    }

    .customer-sidebar-right {
      display: flex;
      width: 50%;
      justify-content: flex-end;
      gap: 20px;
    }

    .customer-sidebar-item {
      display: flex;
      align-items: center;
      border-radius: 10px;
      padding: 0 10px;
      cursor: pointer;

      .number-phone-contact {
        margin-left: 10px;
        font-size: 13px;
      }
    }

    .customer-sidebar-item:hover {
      background: hsla(0,0%,100%,.2);
    }
  }
}

.icon-search-end {
  position: absolute;
  right: 10px;
  top: 7px;
  color: #CCCCCC;
}

.customer-container {
  padding: 59px 30px 30px 30px;
  background: #f9f9f9;
  height: 100%;
  min-height: 100vh;
}

.input-search-user {
  padding-right: 40px;
}

@media (max-width: 808px) {
  .text-hidden-mobile {
    display: none !important;
  }
}

@media (max-width: 480px) {
  .customer-container {
    padding-left: 10px;
    padding-right: 10px;
  }
}
</style>
