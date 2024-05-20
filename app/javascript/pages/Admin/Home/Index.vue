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
        { text: 'Quản lý nhân viên', url: '/admin/staffs', icon: 'person-bounding-box' },
        { text: 'Quản lý khách hàng', url: '/admin/customers', icon: 'people' },
        { text: 'Thống kê', url: '/admin/report', icon: 'reception-4' },
      ],
    }
  }
}
</script>
