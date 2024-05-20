import Vue from 'vue';
import VueRouter from 'vue-router';
import store from './stores/index';

import CustomerLayout from './layout/CustomerLayout.vue';
import AdminLayout from './layout/AdminLayout.vue';
import StaffLayout from './layout/StaffLayout.vue';

import CustomerHome from './pages/Customer/Home/Index.vue';
import SelectCategory from './pages/Customer/SelectCategory/Index.vue';
import SelectSupplier from './pages/Customer/SelectSupplier/Index.vue';
import SelectItem from './pages/Customer/SelectItem/Index.vue';
import CustomerLogin from './pages/Customer/Login/Index.vue';
import CustomerRegister from './pages/Customer/Login/Register.vue';
import CustomerRegisterConfirm from './pages/Customer/Login/RegisterConfirm.vue';
import CustomerPasswordSetting from './pages/Customer/Login/PasswordSetting.vue';
import CustomerRegisterSuccess from './pages/Customer/Login/RegisterSuccess.vue';
import CustomerVerifyFail from './pages/Customer/Login/VerifyFail.vue';
import CustomerCart from './pages/Customer/Cart/Index.vue';
import CustomerOrder from './pages/Customer/Order/Index.vue';
import CustomerOrderSuccess from './pages/Customer/Order/Success.vue';
import CustomerForgotPassword from './pages/Customer/Login/ForgotPassword.vue';
import CustomerOrderHistory from './pages/Customer/OrderHistory/Index.vue';
import CustomerOrderDetail from './pages/Customer/OrderHistory/Detail.vue';
import CustomerReorder from './pages/Customer/Order/Reorder.vue';

import AdminLogin from './pages/Admin/Login/Index.vue';
import AdminHome from './pages/Admin/Home/Index.vue';
import AdminStaffIndex from './pages/Admin/Staff/Index.vue';
import AdminStaffForm from './pages/Admin/Staff/Form.vue';
import AdminCustomerIndex from './pages/Admin/Customer/Index.vue';
import AdminReport from './pages/Admin/Report/Index.vue';

import StaffHome from './pages/Staff/Home/Index.vue';
import StaffLogin from './pages/Staff/Login/Index.vue';
import StaffCategory from './pages/Staff/Category/Index.vue';
import StaffSupplier from './pages/Staff/Supplier/Index.vue';
import StaffSupplierForm from './pages/Staff/Supplier/Form.vue';
import StaffItem from './pages/Staff/Item/Index.vue';
import StaffItemForm from './pages/Staff/Item/Form.vue';
import StaffOrder from './pages/Staff/Order/Index';
import StaffOrderDetail from './pages/Staff/Order/Detail';

import NotFoundPage from './pages/Notfound.vue';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  base: '',
  routes: [
    {
      path: '/',
      component: CustomerLayout,
      children: [
        { path: '', meta: { title: 'Trang chủ' }, name: 'home', component: CustomerHome },
        { path: ':category_id-:category_name', meta: { title: 'Trang chủ' }, name: 'select-category', component: SelectCategory },
        { path: ':category_id-:category_name/:supplier_id-:supplier_name', meta: { title: 'Trang chủ' }, name: 'select-supplier', component: SelectSupplier },
        { path: ':category_id-:category_name/:supplier_id-:supplier_name/:item_id-:item_name', meta: { title: 'Trang chủ' }, name: 'select-item', component: SelectItem },
      ]
    },
    {
      path: '/admin',
      component: AdminLayout,
      children: [
        { path: '', meta: { title: 'Trang chủ quản trị' }, name: 'admin-home', component: AdminHome },
        { path: 'staffs', meta: { title: 'Danh sách nhân viên' }, name: 'admin-staff-index', component: AdminStaffIndex },
        { path: 'staff/create', meta: { title: 'Tạo mới nhân viên' }, name: 'admin-staff-create', component: AdminStaffForm },
        { path: 'staff/:id/edit', meta: { title: 'Chỉnh sửa nhân viên' }, name: 'admin-staff-edit', component: AdminStaffForm },
        { path: 'customers', meta: { title: 'Danh sách khách hàng' }, name: 'admin-customer-index', component: AdminCustomerIndex },
        { path: 'report', meta: { title: 'Thống kê' }, name: 'admin-report', component: AdminReport },
      ]
    },
    {
      path: '/staff',
      component: StaffLayout,
      children: [
        { path: '', meta: { title: 'Trang chủ nhân viên' }, name: 'staff-home', component: StaffHome },
        { path: 'categories', meta: { title: 'Phân loại sản phẩm' }, name: 'staff-categories', component: StaffCategory },

        { path: 'suppliers', meta: { title: 'Hãng sản phẩm' }, name: 'staff-suppliers', component: StaffSupplier },
        { path: 'supplier/create', meta: { title: 'Thêm mới hãng sản phẩm' }, name: 'staff-supplier-create', component: StaffSupplierForm },
        { path: 'supplier/:id/edit', meta: { title: 'Chỉnh sửa hãng sản phẩm' }, name: 'staff-supplier-edit', component: StaffSupplierForm },

        { path: 'items', meta: { title: 'Quản lý sản phẩm' }, name: 'staff-items', component: StaffItem },
        { path: 'item/create', meta: { title: 'Thêm mới sản phẩm' }, name: 'staff-item-create', component: StaffItemForm },
        { path: 'item/:id/edit', meta: { title: 'Chỉnh sửa sản phẩm' }, name: 'staff-item-edit', component: StaffItemForm },

        { path: 'orders', meta: { title: 'Quản lý đơn hàng' }, name: 'staff-orders', component: StaffOrder },
        { path: 'order/:id/details', meta: { title: 'Chi tiết đơn hàng' }, name: 'staff-order-detail', component: StaffOrderDetail },
      ]
    },
    {
      path: '/customer',
      component: CustomerLayout,
      children: [
        { path: 'login', meta: { title: 'Đăng nhập' }, name: 'customer-login', component: CustomerLogin },
        { path: 'forgot_password', meta: { title: 'Quên mật khẩu', hideForAuth: true }, name: 'customer-forgot-password', component: CustomerForgotPassword },
        { path: 'register', meta: { title: 'Đăng ký', hideForAuth: true }, name: 'customer-register', component: CustomerRegister },
        { path: 'register_success', meta: { title: 'Xác thực thành công', hideForAuth: true }, name: 'customer-register-success', component: CustomerRegisterSuccess },
        { path: 'verify_fail', meta: { title: 'Xác thực thất bại', hideForAuth: true }, name: 'customer-verify-fail', component: CustomerVerifyFail },
        { path: 'password_setting/:token', meta: { title: 'Xác thực token', hideForAuth: true }, name: 'customer-password-setting', component: CustomerPasswordSetting },
        { path: 'register_confirm', meta: { title: 'Xác thực email', hideForAuth: true }, name: 'customer-confirm', component: CustomerRegisterConfirm },
        { path: 'cart', meta: { title: 'Giỏ hàng' }, name: 'customer-cart', component: CustomerCart },
        { path: 'order', meta: { title: 'Đặt hàng' }, name: 'customer-order', component: CustomerOrder },
        { path: 'order_success/:id', meta: { title: 'Đặt hàng thành công' }, name: 'customer-order-success', component: CustomerOrderSuccess },
        { path: 'order_history', meta: { title: 'Lịch sử đơn hàng' }, name: 'customer-order-history', component: CustomerOrderHistory },
        { path: 'order_detail/:id', meta: { title: 'Chi tiết đơn hàng' }, name: 'customer-order-detail', component: CustomerOrderDetail },
        { path: 'reorder/:id', meta: { title: 'Đặt lại đơn hàng' }, name: 'customer-reorder', component: CustomerReorder },
      ]
    },
    { path: '/admin/login', meta: { title: 'Quản trị đăng nhập' }, name: 'admin-login', component: AdminLogin },
    { path: '/staff/login', meta: { title: 'Nhân viên đăng nhập' }, name: 'staff-login', component: StaffLogin },
    { path: '*', name: '404', component: NotFoundPage },
  ],
  linkActiveClass: 'active',
});

const DEFAULT_TITLE = 'Phone Business';

router.beforeEach(async (to, from, next) => {
  const hideForAuth = to.matched.some(record => record.meta.hideForAuth);
  if (to.path.split('/')[1] === 'admin') {
    if (!localStorage.getItem('csrf') && !['/admin/login'].includes(to.path)) {
      next('/admin/login');
    } else {
      if ([
        '/admin/login',
      ].includes(to.path)) {
        const data = await store.dispatch('getAdmin', { csrf: localStorage.getItem('csrf') });
        if (data && data.status == 401) {
          next();
          return;
        } else {
          window.location.href = '/admin';
        }
      } else {
        next();
        return;
      }
    }
  } else if (to.path.split('/')[1] === 'staff') {
    if (!localStorage.getItem('staff_csrf') && !['/staff/login'].includes(to.path)) {
      next('/staff/login');
    } else {
      if ([
        '/staff/login',
      ].includes(to.path)) {
        const data = await store.dispatch('getStaff', { csrf: localStorage.getItem('staff_csrf') });
        if (data && data.status == 401) {
          next();
          return;
        } else {
          window.location.href = '/staff';
        }
      } else {
        next();
        return;
      }
    }
  } else if (to.path.split('/')[1] === 'customer') {
    if (!localStorage.getItem('customer_csrf') && !['/customer/login'].includes(to.path) && !hideForAuth) {
      next('/customer/login');
    } else {
      if ([
        '/customer/login',
      ].includes(to.path) || hideForAuth) {
        const data = await store.dispatch('getCustomer', { csrf: localStorage.getItem('customer_csrf') });
        if (data && data.status == 401) {
          next();
          return;
        } else {
          window.location.href = '/customer/cart';
        }
      } else {
        next();
        return;
      }
    }
  } else {
    next();
  }
});

router.afterEach((to) => {
  Vue.nextTick(() => {
    document.title = to.meta.title || DEFAULT_TITLE;
    document.body.scrollTop = document.documentElement.scrollTop = 0;
  });
});

export default router;
