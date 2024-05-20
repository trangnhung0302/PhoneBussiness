<template>
  <div class="dataTables_paginate paging_simple_numbers">
    <div class="paginate_button previous" :class="currentPage === 1 ? 'disable' : ''" @click="jumpPage(currentPage - 1)">
      <b-icon-arrow-left></b-icon-arrow-left>
    </div>
    <div>
      <div
        v-for="(page_no, index) in totalPage"
        :key="index"
        class="paginate_button"
        :class="currentPage === page_no ? 'current' : ''"
        @click="jumpPage(page_no)"
      >
        {{ page_no }}
      </div>
    </div>
    <div class="paginate_button next" :class="currentPage === totalPage ? 'disable' : ''" @click="jumpPage(currentPage + 1)">
      <b-icon-arrow-right></b-icon-arrow-right>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    totalPage: {
      type: Number,
    },
    page: {
      type: Number,
    }
  },
  data() {
    return {
      currentPage: this.page,
    }
  },
  methods: {
    jumpPage(page) {
      if (this.currentPage !== page && page >= 1 && page <= this.totalPage) {
        this.currentPage = page;
        this.$emit('jumpPage', page);
      }
    },
  }
}
</script>

<style scoped>
.dataTables_paginate {
  display: flex;
  float: right;
}

.paginate_button {
  display: inline-flex;
  box-sizing: border-box;
  min-width: 1.5em;
  width: 32px;
  height: 32px;
  background: #f9f9f9;
  border-radius: 3px;
  padding: 0;
  margin: 0 5px;
  align-items: center;
  cursor: pointer;
  justify-content: center;
}
.paginate_button.current {
  background-color: #00d82c;
  color: #fff;
}
.paginate_button:hover {
  background-color: #00d82c;
}
.paginate_button.disable:hover {
  background-color: #f9f9f9;
}
</style>
