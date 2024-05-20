<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">{{ id ? "Chỉnh sửa sản phẩm" : "Thêm mới sản phẩm" }}</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="card-body">
            <form class="" autocomplete="off">
              <div class="d-blox">
                <UploadMultipleImage
                  :imagesProps="this.item.item_images"
                  @setDataImage="setDataImage"
                />
                <div class="admin-form">
                  <div class="mb-3">
                    <label class="form-label">Mã sản phẩm</label>
                    <input v-model="item.product_no" type="text" class="form-control" name="product_no" placeholder="Mã sản phẩm" disabled>
                    <span v-for="error in errors['product_no']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Tên sản phẩm</label>
                    <input v-model="item.name" type="text" class="form-control" name="name" placeholder="Tên">
                    <span v-for="error in errors['name']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Hãng sản phẩm</label>
                    <vSelect
                      v-model="item.supplier_id"
                      :options="suppliers"
                      :reduce="(option) => option.id"
                      class="v-select"
                      label="name"
                    >
                      <span slot="no-options">Không có lựa chọn</span>
                    </vSelect>
                    <span v-for="error in errors['supplier_id']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Loại sản phẩm</label>
                    <vSelect
                      v-model="item.category_id"
                      :options="categories"
                      :reduce="(option) => option.id"
                      class="v-select"
                      label="name"
                    >
                      <span slot="no-options">Không có lựa chọn</span>
                    </vSelect>
                    <span v-for="error in errors['category_id']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Trạng thái</label>
                    <vSelect
                      v-model="item.status"
                      :options="status"
                      :reduce="(option) => option.value"
                      class="v-select"
                      label="text"
                    >
                      <span slot="no-options">Không có lựa chọn</span>
                    </vSelect>
                    <span v-for="error in errors['category_id']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                </div>
                <div class="mb-3">
                  <label class="form-label">Phân loại màu sắc</label>
                  <div class="d-flex">
                    <ul class="btn-choose-type">
                      <li>
                        <input v-model="isItemColor" type="radio" v-on:change="onChangeIsItemColor" name="isItemColor" value="1">
                        <label class="type-search-time">Không phân loại</label>
                      </li>
                      <li>
                        <input v-model="isItemColor" type="radio" v-on:change="onChangeIsItemColor" name="isItemColor" value="2">
                        <label class="type-search-time">Phân loại</label>
                      </li>
                    </ul>
                    <div class="ms-4">
                      <button v-if="isItemColor == 2" type="button" class="btn-add-itemColor" @click="addColor">Thêm màu sắc</button>
                    </div>
                  </div>
                </div>
                <div v-if="isItemColor == 1" class="admin-form">
                  <div class="mb-3">
                    <label class="form-label">Số lượng còn</label>
                    <input v-model="item.quantity" type="text" class="form-control" name="quantity" placeholder="Số lượng còn">
                    <span v-for="error in errors['quantity']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Giá nhập hàng</label>
                    <input v-model="item.purchase_price" type="text" class="form-control" name="purchase_price" placeholder="Số lượng còn">
                    <span v-for="error in errors['purchase_price']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Giá bán gốc</label>
                    <input v-model="item.original_price" type="text" class="form-control" name="original_price" placeholder="Giá bán gốc">
                    <span v-for="error in errors['original_price']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Giá hiện tại</label>
                    <input v-model="item.price" type="text" class="form-control" name="price" placeholder="Giá hiện tại">
                    <span v-for="error in errors['price']" :key="error" class="admin-error">
                      {{ error }}
                    </span>
                  </div>
                </div>
                <template v-if="isItemColor == 2">
                  <template v-for="(itemColor, index) in itemColors">
                    <div v-if="!itemColor._destroy" class="admin-form item-color-element">
                      <div class="mb-3">
                        <label class="form-label">Màu sắc</label>
                        <input v-model="itemColor.color" type="text" class="form-control" name="quantity" placeholder="Màu sắc">
                        <span v-for="error in errors[`color_${index}`]" :key="error" class="admin-error">
                          {{ error }}
                        </span>
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Số lượng còn</label>
                        <input v-model="itemColor.quantity" type="text" class="form-control" name="quantity" placeholder="Số lượng còn">
                        <span v-for="error in errors[`quantity_${index}`]" :key="error" class="admin-error">
                          {{ error }}
                        </span>
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Giá nhập hàng</label>
                        <input v-model="itemColor.purchase_price" type="text" class="form-control" name="purchase_price" placeholder="Số lượng còn">
                        <span v-for="error in errors[`purchase_price_${index}`]" :key="error" class="admin-error">
                          {{ error }}
                        </span>
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Giá bán gốc</label>
                        <input v-model="itemColor.original_price" type="text" class="form-control" name="original_price" placeholder="Giá bán gốc">
                        <span v-for="error in errors[`original_price_${index}`]" :key="error" class="admin-error">
                          {{ error }}
                        </span>
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Giá hiện tại</label>
                        <input v-model="itemColor.price" type="text" class="form-control" name="price" placeholder="Giá hiện tại">
                        <span v-for="error in errors[`price_${index}`]" :key="error" class="admin-error">
                          {{ error }}
                        </span>
                      </div>
                      <div class="mb-3">
                        <button v-if="itemColors.filter(itemColor => !itemColor._destroy).length > 2" type="button" class="btn btn-primary admin-btn-primary" style="margin-top: 33px;" @click="deleteColor(itemColor)">Xóa màu sắc</button>
                      </div>
                    </div>
                  </template>
                </template>
                <div class="mb-3">
                  <label class="form-label">Giới thiệu sản phẩm</label>
                  <textarea v-model="item.note" class="form-control height-three-line" />
                </div>
              </div>
              <div class="admin-form-button d-flex justify-content-center mt-2">
                <button type="button" class="btn btn-primary admin-btn-primary mb-2" @click="onSubmit">{{ id ? "Chỉnh sửa" : "Thêm mới" }}</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Validator from '../../../validator';
import { SuppliersService } from '../../../services/staff/suppliers.service';
import { ItemsService } from '../../../services/staff/items.service';
import { CategoriesService } from '../../../services/staff/categories.service';
import vSelect from 'vue-select';
import UploadMultipleImage from '../../../components/UploadMultipleImage.vue';

export default {
  components: {
    vSelect,
    UploadMultipleImage,
  },

  data() {
    return {
      id: this.$router.history.current.params.id,
      errors: {},
      item: {},
      image: '',
      imageName: '',
      categories: [],
      suppliers: [],
      images: [],
      itemColors: [],
      isItemColor: 1,
      status: [
        { value: 'active', text: 'Còn hàng' },
        { value: 'out_of_stock', text: 'Hết hàng' },
        { value: 'stop_selling', text: 'Ngừng bán' },
      ],
    }
  },
  mounted() {
    if (this.id) {
      this.getItem(); 
    }
    this.getSuppliers();
    this.getCategories();
  },
  methods: {
    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;
      
      let params = {
        name: this.item.name,
        category_id: this.item.category_id,
        supplier_id: this.item.supplier_id,
        quantity: this.item.quantity,
        purchase_price: this.item.purchase_price,
        original_price: this.item.original_price,
        price: this.item.price,
        note: this.item.note,
        status: this.item.status,
      }

      if (this.isItemColor == 2) {
        const colorMinPrice = this.colorMinPrice();
        params = {
          ...params,
          quantity: this.sumQuantity(),
          purchase_price: colorMinPrice.purchase_price,
          original_price: colorMinPrice.original_price,
          price: colorMinPrice.price,
        }
      }

      if (this.images.length) {
        params['item_images'] = this.images.map(image => {
          return {
            id: image.id,
            image_url: image.image_url,
            name: image.name,
            _destroy: image._destroy,
          }
        });
      }

      if (this.itemColors.length) {
        params['item_colors_attributes'] = this.itemColors.map(itemColor => {
          return {
            id: itemColor.id,
            color: itemColor.color,
            quantity: itemColor.quantity,
            purchase_price: itemColor.purchase_price,
            original_price: itemColor.original_price,
            price: itemColor.price,
            _destroy: this.isItemColor == 1 ? true : itemColor._destroy,
          }
        });
      }
      this.$loading(true);
      try {
        if (this.id) {
          await ItemsService.update(this.id, params)
          this.$router.push('../../items');
        }
        else {
          await ItemsService.create(params);
          this.$router.push('../items');
        }
        this.$loading(false);
      }catch (error) {
        this.$loading(false);
      }
    },

    async getSuppliers() {
      this.$loading(true);
      try {
        const { response } = await SuppliersService.index();
        this.suppliers = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },
    
    async getItem() {
      this.$loading(true);
      try {
        const { response } = await ItemsService.get(this.id);
        this.item = response.data;
        this.itemColors = this.item.item_colors;
        if (this.itemColors.length > 0) {
          this.isItemColor = 2;
        }
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    async getCategories() {
      this.$loading(true);
      try {
        const { response } = await CategoriesService.index();
        this.categories = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    onChangeIsItemColor() {
      if (this.isItemColor == 2 && this.itemColors.length == 0) {
       this.addColor();
       this.addColor();
      }
    },

    validate() {
      const validator = new Validator();
      validator.checkRequire('name', this.item.name, 'Tên sản phẩm') &&
        validator.checkMaxLength('name', this.item.name, 255, 'Tên sản phẩm');

      validator.checkRequire('supplier_id', this.item.supplier_id, 'Hãng sản phẩm');
      validator.checkRequire('category_id', this.item.category_id, 'Loại sản phẩm');

      if (this.isItemColor == 1) {
        validator.checkDigit('quantity', this.item.quantity, 'Số lượng');
        validator.checkDigit('purchase_price', this.item.purchase_price, 'Giá nhập hàng');
        validator.checkDigit('original_price', this.item.original_price, 'Giá nhập gốc');
        validator.checkDigit('price', this.item.price, 'Giá hiện tại');
      } else if (this.isItemColor == 2) {
        this.itemColors.forEach((itemColor, index) => {
          if (!itemColor._destroy) {
            validator.checkRequire(`color_${index}`, itemColor.color, 'Màu sắc')
            validator.checkDigit(`quantity_${index}`, itemColor.quantity, 'Số lượng');
            validator.checkDigit(`purchase_price_${index}`, itemColor.purchase_price, 'Giá nhập hàng');
            validator.checkDigit(`original_price_${index}`, itemColor.original_price, 'Giá nhập gốc');
            validator.checkDigit(`price_${index}`, itemColor.price, 'Giá hiện tại');
          }
        });
      }


      this.errors = validator.errors;
    },

    setDataImage(images) {
      this.images = images;
    },

    addColor() {
      const itemColor = {
        id: null,
        color: null,
        quantity: 0,
        purchase_price: this.item.purchase_price,
        original_price: this.item.original_price,
        price: this.item.price,
      }
      this.itemColors.push(itemColor);
    },

    deleteColor(itemColor) {
      itemColor._destroy = true;
      this.itemColors.push();
    },

    colorMinPrice() {
      return this.itemColors.filter(itemColor => !itemColor._destroy).reduce((minItem, currentItem) => {
        return (currentItem.price < minItem.price) ? currentItem : minItem;
      });
    },

    sumQuantity() {
      return this.itemColors.filter(itemColor => !itemColor._destroy).reduce((sum, currentItem) => {
          return Number(sum) + Number(currentItem.quantity);
      }, 0);
    },
  },
}
</script>

<style scoped>
.height-three-line {
  height: 120px;
}
</style>
