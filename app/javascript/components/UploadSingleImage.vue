<template>
  <div class="admin-input-image">
    <div v-show="image" class="file_upload_image" @click="$refs.file.click()">
      <img :src="image">
    </div>
    <div v-show="!image" class="file_upload_image no_image" @click="$refs.file.click()">
      <div class="file_upload_image_main">
        <div class="icon add_image" />
        <div class="file_upload_image_text">{{ textUploadImage }}</div>
      </div>
    </div>
    <div>
      <input id="file_uploader" ref="file" type="file"
              class="file_uploader"
              accept="image/x-png,image/gif,image/jpeg,image/jpg,image/tiff,image/bmp"
              hidden @change="previewFiles"
      >
    </div>
    <div v-if="image && isDeleteImage" class="admin-button-delete-image" @click="onDeleteImage">
      <b-icon-x-circle variant="danger" scale="1.3"></b-icon-x-circle>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    image: {
      typeof: String,
      default: "",
    },
    index: {
      typeof: Number,
      default: null,
    },
    textUploadImage: {
      typeof: String,
      default: "Upload ảnh",
    },
    isDeleteImage: {
      typeof: Boolean,
      default: false,
    },
  },
  data() {
    return {

    }
  },
  methods: {
    previewFiles(event) {
      if (event.target.files.length < 1) {
        return;
      }
      this.imageError = false;
      const file = event.target.files[0];
      if (file.size > 3 * 1000 * 1000) {
        this.imageError = true;
      }
      this.createBase64Image(file);
    },

    createBase64Image(file) {
      const reader = new FileReader();

      reader.onload = (e) => {
        this.$emit('setDataImage', {name: file.name, image: e.target.result, index: this.index});
      };
      reader.readAsDataURL(file);
    },

    onDeleteImage() {
      this.$emit('onDeleteImage', this.index);
    },
  },
}
</script>

<style scoped>

</style>
