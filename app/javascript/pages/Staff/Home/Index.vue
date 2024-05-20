<template>
  <main>
    <div class="customer-auth-container">
      <div class="admin-home">
        <div v-for="(item, key) in sidebar" :key="key" class="admin-home-item" @click="$router.push(item.url)">
          <div class="admin-home-content">
            <div class="admin-home-icon">
              <b-icon :icon="item.icon" variant="dark" scale="1"></b-icon>
            </div>
            <div class="admin-home-text">{{ item.text }}</div>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
export default {
  data() {
    return {
      sidebar: [
        { text: 'Hãng sản phẩm', url: '/staff/suppliers', icon: 'card-list' },
        { text: 'Phân loại sản phẩm', url: '/staff/categories', icon: 'tablet' },
        { text: 'Quản lý sản phẩm', url: '/staff/items', icon: 'stack' },
        { text: 'Quản lý đơn hàng', url: '/staff/orders', icon: 'view-stacked' },
      ],
    }
  }
}
</script>
