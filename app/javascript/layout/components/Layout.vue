<template>
  <main class="admin-main-container">
    <div :class="showSidebar ? 'sidebar-backdrop' : 'd-none'" @click="showSidebar = false"></div>
    <div :class="showSidebar ? 'admin-sidebar admin-sidebar-menu' : 'admin-sidebar admin-hidden-sidebar'">
      <div class="d-flex align-items-center p-4 admin-sidebar-header">
        <b-icon-lightning-charge variant="warning" scale="2"></b-icon-lightning-charge>
        <div class="text-light fs-3 ms-4">Store</div>
      </div>
      <ul>
        <a v-for="(item, key) in sidebar" :key="key" :href="item.url" class="text-light admin-sidebar-url">
          <li class="admin-sidebar-li">
            <b-icon :icon="item.icon" v-if='showSidebar' variant='Light' scale='2' />
            {{ item.text }}
          </li>
        </a>
      </ul>
    </div>
    <section class="admin-main-content" :class="showSidebar ? '' : 'admin-hidden-sidebar-container'">
      <div class="admin-navbar header_iner d-flex justify-content-between align-items-center">
        <div @click="showSidebar=!showSidebar" class="cursor-pointer">
          <b-icon-blockquote-left v-if="showSidebar" variant="primary" scale="2" />
          <b-icon-blockquote-right v-else variant="primary" scale="2" />
        </div>
        <div class="header_right d-flex justify-content-between align-items-center">
          <div class="profile_info d-flex align-items-center">
            <div class="profile_thumb me-2">
              <img src="../../../assets/images/adminAvatar.jpeg" style="width: 40px;">
            </div>
            <div class="author_name">
              <p class="f_s_12 f_w_400">{{ emailLogin }}</p>
            </div>
            <div class="profile_info_iner">
              <div class="profile_info_details">
                <a @click="logout"><b-icon-box-arrow-left scale="2"/></a>
                <div class="tooltip-logout">Đăng xuất</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="admin-container">
        <router-view></router-view>
      </div>
    </section>
  </main>
</template>

<script>
export default {
  props: {
    loginUrl: {
      type: String,
    },
    sidebar: {
      type: Array,
    },
    emailLogin: {
      type: String,
      default: "",
    }
  },
  data() {
    return {
      showSidebar: screen.width > 1024,
    };
  },
  // mounted() {
  //   console.log(screen.width);
  // },
  methods: {
    logout() {
      this.$emit('logout');
    }
  }
}
</script>

<style scoped>
body {
  position: relative;
}

.dropdown {
  cursor: pointer;
  position: relative;
  display: inline-block;
}

.dropdown-content {
  border-radius: 5px;
  display: none;
  position: absolute;
  background-color: #FFFFFF;
  min-width: 150px;
  box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
  z-index: 1;
}

.dropdown-content a {
  font-size: 12px;
  color: #222222;
  padding: 12px 8px 12px 8px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {
  background-color: #F5F9FF;
  border-radius: 5px;
}

.dropdown:hover .dropdown-content {
  display: block;
}

.icon_shevron_down.after:after {
  margin-left: 8px !important;
}

.profile_info_details {
  position: relative;
}

.tooltip-logout {
  visibility: hidden;
  position: absolute;
  left: -25px;
  background-color: gray;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 10px;
  top: 50px;
}

.profile_info_details:hover .tooltip-logout {
  visibility: visible;
}

</style>
