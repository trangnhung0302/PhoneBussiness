<template>
  <div class="customer-content-container">
    <div class="customer-home-header">
      <div class="home-left-header">
        <template v-for="(category, index) in categories">
          <div v-if="index < 8" class="home-left-header-item" @click="$router.push(`/${category.id}-${category.name}`)">
            <div>{{ category.name }}</div>
            <div>
              <b-icon-caret-right />
            </div>
          </div>
        </template>
      </div>
      <div class="home-right-header">
        <div class="image-banner-container">
          <img src="../../../../assets/images/1-300923-014812.jpg" class="image-banner">
        </div>
      </div>
    </div>
    <div class="list-categories-ipad">
      <div v-for="(category, index) in categories" :key="index">
        <button class="btn btn-secondary nowrap" @click="$router.push(`/${category.id}-${category.name}`)">{{ category.name }}</button>
      </div>
    </div>
    <template v-for="(category, index) in categories">
      <div v-if="index < 5" class="categories-standing mt-4">
        <div class="categories-header">
          <div class="min-w-fit-content">
            <h3>{{ category.name }} nổi bật nhất</h3>
          </div>
          <div class="list-supplier">
            <div>
              <button class="btn btn-secondary nowrap" @click="$router.push(`/${category.id}-${category.name}`)">Xem tất cả</button>
            </div>
            <div v-for="(supplier, index) in suppliers.filter(supplier => supplier.category_id == category.id)" :key="index">
              <button class="btn btn-secondary nowrap" @click="$router.push(`/${category.id}-${category.name}/${supplier.id}-${supplier.name}`)">{{ supplier.name }}</button>
            </div>
          </div>
        </div>
        <ListItem :items="items.filter(item => item.category_id == category.id)" />
      </div>
    </template>
  </div>
</template>

<script>
import { CategoriesService } from '../../../services/categories.service';
import { ItemsService } from '../../../services/items.service';
import { SuppliersService } from '../../../services/suppliers.service';
import ListItem from '../components/ListItem.vue';

export default {
  components: {
    ListItem,
  },
  data() {
    return {
      categories: [],
      items: [],
      suppliers: [],
      supplier: {},
      category: {},
    }
  },
  async mounted() {
    await this.getCategories();
    await this.getItems();
    await this.getSuppliers();
  },
  methods: {
    async getCategories() {
      const { response } = await CategoriesService.index();
      this.categories = response.data;
    },

    async getItems() {
      const params = {
        category_ids: this.categories.map(category => category.id),
        status: 'active',
      }
      this.$loading(true);
      try {
        const { response } = await ItemsService.getItemByCategoryIds(params);
        this.items = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getSuppliers() {
      this.$loading(true);
      try {
        const { response } = await SuppliersService.index();
        this.suppliers = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },
  },
}
</script>
