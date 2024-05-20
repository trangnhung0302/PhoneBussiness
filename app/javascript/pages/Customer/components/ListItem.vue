<template>
  <div class="categories-content">
    <div v-for="(item, index) in items" :key="index" class="item-standing" @click="$router.push(`/${item.category_id}-${item.category_name}/${item.supplier_id}-${item.supplier_name}/${item.id}-${item.name}`)">
      <div class="price-sale">
        <p>Giảm {{ Math.round(((item.original_price - item.price) / item.original_price) * 100) }} %</p>
      </div>
      <div class="item-standing-container">
        <div class="item-standing-image-container">
          <img :src="item.item_images && item.item_images[0] ? item.item_images[0].image_url : noImage" class="item-standing-image">
        </div>
        <div class="item-standing-content">
          <div class="item-standing-name">{{ item.name }}</div>
          <div class="item-standing-price">
            <div class="item-standing-red">{{ convertNumberFormat(item.price) }}đ</div>
            <div class="item-standing-gray">{{ convertNumberFormat(item.original_price) }}đ</div>
          </div>
          <div class="item-standing-note">
            <div><p class="item-standing-note-p">{{ item.note }}</p></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import utils from '../../../common/util';
import noImage from '../../../../assets/images/no_image.png';

export default {
  props: {
    items: {
      typeof: Array,
      default: [],
    }
  },
  data() {
    return {
      noImage: noImage,
    }
  },
  methods: {
    ...utils,
  },
}
</script>
