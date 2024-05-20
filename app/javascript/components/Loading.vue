<template>
  <div v-show="loading" class="modal fade show" style="display: block">
    <div class="loading">
      <div class="spinner-border" role="status"></div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      loading: false,
    };
  }};
</script>
<style scoped>
.loading {
    z-index: 50;
    position: absolute;
    width: 100%;
    height: 100%;
    background-color: #ffffffa1;
    display: flex;
    align-items: center;
    justify-content: center;
  }
</style>
