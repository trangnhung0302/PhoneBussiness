<template>
  <div class="review-container">
    <div style="font-weight: 500;">{{ review.customer_name }}</div>
    <div class="d-flex gap-5px mt-1">
      <b-icon-star-fill v-for="star in new Array(review.ratings).fill(0).map((_, i) => i + 1)" :key="star" variant="danger" scale="1.2" class="cursor-pointer" @click="updateStar(star)"></b-icon-star-fill>
      <b-icon-star v-for="star in new Array(5 - review.ratings).fill(review.ratings).map((_, i) => i + 1)" :key="star + review.ratings" scale="1.2" variant="danger" class="cursor-pointer" @click="updateStar(star + review.ratings)"></b-icon-star>
    </div>
    <div class="mt-3">
      {{ review.review }}
      <div v-if="review.reply" style="background-color: #c3c3c3; padding: 10px 20px; margin-left: 40px; border-radius: 10px;">
        <div style="font-weight: 500;">Phản hồi của cửa hàng</div>
        <div>{{ review.reply }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    review: {
      type: Object,
    },
  }
}
</script>

<style lang="scss" scoped>
</style>
