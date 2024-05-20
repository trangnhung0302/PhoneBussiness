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
      <button v-if="supplier.id">{{ supplier.name }}</button>
    </div>
    <div class="space-height" />
    <div class="mt-4">
      <div><h4>Sắp sếp theo</h4></div>
      <div class="list-supplier">
        <button class="btn-sort-customer" :class="sortPrice == 'asc' ? 'active' : ''" @click="onChangeSortPrice('asc')">
          <b-icon-sort-up></b-icon-sort-up>Giá từ thấp đến cao
        </button>
        <button class="btn-sort-customer" :class="sortPrice == 'desc' ? 'active' : ''" @click="onChangeSortPrice('desc')">
          <b-icon-sort-down-alt></b-icon-sort-down-alt>Giá từ cao đến thấp
        </button>
        <div class="list-supplier">
          <button class="btn-sort-customer bg-gray">
            <input v-model="checkedStatus" type="checkbox" value="10" id="active" @change="getItems()"><label for="active">Còn hàng</label>
          </button>
          <button class="btn-sort-customer bg-gray">
            <input v-model="checkedStatus" type="checkbox" value="20" id="out_of_stock" @change="getItems()"><label for="out_of_stock">Hết hàng</label>
          </button>
          <button class="btn-sort-customer bg-gray">
            <input v-model="checkedStatus" type="checkbox" value="30" id="stop_selling" @change="getItems()"><label for="stop_selling">Ngưng bán</label>
          </button>
        </div>
      </div>
    </div>
    <div class="">
      <ListItem :items="items" />
      <div v-if="totalItemNotDisplay > 0" class="customer-open-new-page">
        <button class="btn btn-secondary" @click="onNextPage()">Xem thêm {{ totalItemNotDisplay }} sản phẩm</button>
      </div>
    </div>
  </div>
</template>

<script>
import { ItemsService } from '../../../services/items.service';
import ListItem from '../components/ListItem.vue';

export default {
  components: {
    ListItem
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
      items: [],
      pager: {
        page: 1,
        page_count: 1,
        page_size: 20,
        item_count: 0,
      },
      pageParams: {
        page: 1,
        page_size: 20,
        total_page: 1,
      },
      totalItemNotDisplay: 0,
      sortPrice: null,
      sortView: null,
      checkedStatus: [10],
    }
  },
  async mounted() {
    await this.getItems();
  },
  methods: {
    async getItems(isNextPage = false) {
      const params = {
        category_id: this.category.id,
        supplier_id: this.supplier.id,
        sort_price: this.sortPrice,
        checked_status: this.checkedStatus.map(Number),
        ...this.pageParams,
      }
      this.$loading(true);
      try {
        const { response } = await ItemsService.index(params);
        this.pager = response.pager;
        this.items = isNextPage ? [...this.items, ...response.data] : response.data;
        this.totalItemNotDisplay = this.pager.item_count - this.pager.page * this.pager.page_size;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    onNextPage() {
      this.pageParams.page++;
      this.getItems(true);
    },

    onChangeSortPrice(sortPrice) {
      this.sortPrice = sortPrice;
      this.pageParams.page == 1;
      this.getItems();
    }
  },
}
</script>
