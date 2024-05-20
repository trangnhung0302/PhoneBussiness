<template>
  <div class="modal fade show" style="display: block;">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">{{ title }}</h5>
          <button type="button" class="close" @click="$emit('onClose')">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <slot />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="$emit('onClose')">{{textButtonClose}}</button>
          <button type="button" class="btn btn-primary" @click="$emit('onSubmit')">{{ textButtonSubmit }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    textButtonSubmit: {
      type: String,
      default: "Đồng ý"
    },
    textButtonClose: {
      type: String,
      default: "Đóng"
    },
    title: {
      type: String,
      default: "Tiêu đề"
    },
  }
}
</script>

<style scoped>
.modal {
  background-color: #2125298a;
  z-index: 20;
  position: fixed;
  height: 100vh;
}
.modal-header .close {
  padding: 1rem;
  margin: -1rem -1rem -1rem auto;
}
.close {
  font-size: 1.5rem;
}
.btn-primary {
  background-color: #d70018;
}
.btn-primary:hover {
  opacity: 0.7;
  background-color: #d70018;
}
</style>
