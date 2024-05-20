<template>
  <div class="customer-auth-container">
    <div class="customer-auth-container-background d-flex">
      <div class="register-confirm-container">
        <div class="mt-4">
          Xác thực thành công, vui lòng đăng nhập
        </div>
        <div class="mt-4 d-flex justify-content-center">
          <button class="button-buy order-success-btn-buy" @click="$router.push('/customer/login')">Đăng nhập</button>
        </div>
      </div>
    </div>
  </div>
</template>
