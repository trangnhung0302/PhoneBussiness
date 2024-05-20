<template>
  <div class="admin-form-image-container">
    <template  v-for="(image ,index) in images">
      <div :key="index" v-if="!image._destroy">
        <UploadSingleImage
          :index="index"
          :image="image.image_url"
          :isDeleteImage="true"
          @setDataImage="setDataImage"
          @onDeleteImage="onDeleteImage"
        />
      </div>
    </template>
    <button type="button" class="btn btn-success btn-upload-image" @click="addNewImage"><span>Thêm ảnh</span></button>
  </div>
</template>

<script>
import UploadSingleImage from "./UploadSingleImage.vue";

export default {
  components: {
    UploadSingleImage,
  },
  props: {
    imagesProps: {
      typeof: Array,
    }
  },
  watch: {
    imagesProps: {
      handler(value) {
        if (value.length > 0) {
          this.images = value.map(image => {
            console.log(image);
            return {
              id: image.id,
              image_url: image.image_url,
              name: '',
              is_new: false,
            }
          });
        }
        else {
          this.images = [{ id: null, name: '', image_url: '', is_new: true }];
        }
      }
    },
  },
  data() {
    return {
      images: [{ id: null, name: '', image_url: '', is_new: true }],
    }
  },
  methods: {
    setDataImage(image) {
      this.images[image.index] = {
        ...this.images[image.index],
        name: image.name,
        image_url: image.image,
        is_new: false
      };
      this.images.push();
      this.$emit('setDataImage', this.images);
    },

    addNewImage() {
      if (this.images[this.images.length - 1].is_new) return;
      this.images.push({ id: null, name: '', image_url: '', is_new: true });
    },

    onDeleteImage(index) {
      this.images[index] = {
        ...this.images[index],
        _destroy: true,
      };
      this.images.push();
      this.$emit('setDataImage', this.images);
    }
  },
}
</script>
