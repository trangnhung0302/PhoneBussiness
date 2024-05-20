<template>
  <CustomerModal
    :title="`Cài đặt địa chỉ nhận hàng`"
    @onClose="$emit('onClose')"
    @onSubmit="onSubmitSelectDestination"
  >
    <div v-if="customerDestinations.length > 0">
      <div v-for="(destination, index) in customerDestinations">
        <div class="select-destination-contaner">
          <div>
            <input type="radio" :checked="destinationSelectId == destination.id || (destinationSelectId == null && destinationId == destination.id)" @change="destinationSelectId = destination.id">
          </div>
          <div>
            <div class="select-destination-2-line">
              {{ destination.recipient_name }} | {{ destination.recipient_phone }}
            </div>
            <div class="select-destination-2-line">
              {{ destination.address }}
            </div>
            <div class="select-destination-2-line">
              {{ destination.ward_name }} , {{ destination.district_name }} , {{ destination.province_name }}
            </div>
          </div>
          <div class="destination-button-edit">
            <button class="destination-btn-edit" @click="editDestination(destination)">Sửa</button>
          </div>
        </div>
        <hr>
      </div>
    </div>
    <div v-else>
      Chưa có địa chỉ nhận hàng
      <hr>
    </div>
    <div>
      <button @click="addDestination" class="w-100 text-align-left"><b-icon-plus />Thêm địa chỉ mới</button>
    </div>
    <CustomerModal
      v-if="showModalDestination"
      :title="destination.id ? 'Chỉnh sửa địa chỉ nhận hàng' : 'Thêm địa chỉ nhận hàng'"
      @onClose="showModalDestination = false"
      @onSubmit="onSubmit"
    >
     <form>
      <div class="mb-3">
        <label class="form-label">Tên người nhận</label>
        <input v-model="destination.recipient_name" type="text" class="form-control" name="recipient_name" placeholder="Tên người nhận">
        <span v-for="error in errors['recipient_name']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div class="mb-3">
        <label class="form-label">Số điện thoại người nhận</label>
        <input v-model="destination.recipient_phone" type="text" class="form-control" name="recipient_phone" placeholder="Số điện thoại người nhận">
        <span v-for="error in errors['recipient_phone']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div class="mb-3">
        <label class="form-label">Tỉnh / Thành phố</label>
        <vSelect
          v-model="destination.province_id"
          :options="provinces"
          :reduce="(option) => option.ProvinceID"
          :clearable="false"
          class="v-select"
          label="ProvinceName"
          @input="onChangeProvince"
        >
          <span slot="no-options">Không có lựa chọn</span>
        </vSelect>
        <span v-for="error in errors['province_id']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div class="mb-3">
        <label class="form-label">Quận / Huyện</label>
        <vSelect
          v-model="destination.district_id"
          :options="districts"
          :reduce="(option) => option.DistrictID"
          :clearable="false"
          class="v-select"
          label="DistrictName"
          @input="onChangeDistrict"
        >
          <span slot="no-options">Không có lựa chọn</span>
        </vSelect>
        <span v-for="error in errors['district_id']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div class="mb-3">
        <label class="form-label">Phường / Xã</label>
        <vSelect
          v-model="destination.ward_code"
          :options="wards"
          :reduce="(option) => option.WardCode"
          :clearable="false"
          class="v-select"
          label="WardName"
          @input="onChangeWard"
        >
          <span slot="no-options">Không có lựa chọn</span>
        </vSelect>
        <span v-for="error in errors['ward_code']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div class="mb-3">
        <label class="form-label">Chi tiết địa điểm</label>
        <textarea
          v-model="destination.address"
          class="form-control"
        />
        <span v-for="error in errors['address']" :key="error" class="text-danger">
          {{ error }}
        </span>
      </div>
      <div v-if="destination.id" class="d-flex justify-content-center">
        <button type="button" class="btn-payment-orderdetail" @click="onDeleteDestination"><b-icon-trash-fill class="me-2" />Xóa địa điểm</button>
      </div>
     </form>
    </CustomerModal>
  </CustomerModal>
</template>

<script>
import CustomerModal from '../../../../components/CustomerModal.vue';
import { CustomerDestinationsService } from '../../../../services/customer/customer_destinations.service';
import { DestinationsService } from '../../../../services/customer/destinations.service';
import vSelect from 'vue-select';
import Validator from '../../../../validator';

export default {
  components: {
    CustomerModal,
    vSelect,
  },
  props: {
    destinationId: {
      typeof: Number,
    }
  },
  data() {
    return {
      destination: {},
      showModalDestination: false,
      provinces: [],
      districts: [],
      wards: [],
      errors: {},
      destinationSelectId: null,
      customerDestinations: [],
    }
  },
  watch: {
    destination(value) {
      if (value.province_id) {
        this.getDistricts();
      }
      if (value.district_id) {
        this.getWards();
      }
    }
  },
  mounted() {
    this.getCustomerDestinations();
    this.getProvinces();
  },
  methods: {
    async getCustomerDestinations() {
      this.$loading(true);
      try {
        const { response } = await CustomerDestinationsService.index();
        this.customerDestinations = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getProvinces() {
      this.$loading(true);
      try {
        const { response } = await DestinationsService.getProvinces();
        this.provinces = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getDistricts() {
      this.$loading(true);
      try {
        const { response } = await DestinationsService.getDistricts(this.destination.province_id);
        this.districts = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getWards() {
      this.$loading(true);
      try {
        const { response } = await DestinationsService.getWards(this.destination.district_id);
        this.wards = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    addDestination() {
      this.destination = {
        id: null,
        recipient_name: null,
        recipient_phone: null,
        province_id: null,
        province_name: null,
        district_id: null,
        district_name: null,
        ward_code: null,
        ward_name: null,
        address: null,
      }
      this.showModalDestination = true;
    },

    editDestination(destination) {
      this.destination = destination;
      this.showModalDestination = true;
    },

    async onChangeProvince() {
      this.getDistricts();
      this.destination = {
        ...this.destination,
        province_name: this.provinces.filter(province => province.ProvinceID == this.destination.province_id)[0].ProvinceName,
        district_id: null,
        district_name: null,
        ward_code: null,
        ward_name: null,
        address: null,
      }
      this.wards = [];
    },

    async onChangeDistrict() {
      this.getWards();
      this.destination = {
        ...this.destination,
        district_name: this.districts.filter(district => district.DistrictID == this.destination.district_id)[0].DistrictName,
        ward_code: null,
        ward_name: null,
        address: null,
      }
    },

    async onChangeWard() {
      this.destination = {
        ...this.destination,
        ward_name: this.wards.filter(ward => ward.WardCode == this.destination.ward_code)[0].WardName,
        address: null,
      }
    },

    async onSubmit() {
      this.validate();
      if (Object.keys(this.errors).length) return;

      this.$loading(true);
      try {
        if (this.destination.id) {
          await CustomerDestinationsService.update(this.destination.id, this.destination);
        }
        else {
          await CustomerDestinationsService.create(this.destination);
        }
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
      await this.getCustomerDestinations();
      this.showModalDestination = false;
    },

    onSubmitSelectDestination() {
      if (this.destinationSelectId) {
        const destination = this.customerDestinations.filter(destination => destination.id == this.destinationSelectId)[0];
        this.$emit('onSubmitSelectDestination', destination);
      }
      else {
        if (this.destinationId) {
          const destination = this.customerDestinations.filter(destination => destination.id == this.destinationId)[0];
          this.$emit('onSubmitSelectDestination', destination);
        }
        else {
          console.log('Vui lòng chọn địa chỉ nhận hàng');
          return;
        }
      }
    },

    validate() {
      const validator = new Validator();

      validator.checkRequire('recipient_name', this.destination.recipient_name, 'Tên người nhận') &&
        validator.checkMaxLength('recipient_name', this.destination.recipient_name, 255, 'Tên người nhận');

      validator.checkRequire('recipient_phone', this.destination.recipient_phone, 'Số điện thoại người nhận') &&
        validator.checkMaxLength('recipient_phone', this.destination.recipient_phone, 10, 'Số điện thoại người nhận') &&
          validator.checkMinLength('recipient_phone', this.destination.recipient_phone, 10, 'Số điện thoại người nhận');

      validator.checkRequire('province_id', this.destination.province_id, 'Tỉnh / Thành phố');
      validator.checkRequire('district_id', this.destination.district_id, 'Quận / Huyện');
      validator.checkRequire('ward_code', this.destination.ward_code, 'Phường / Xã');

      validator.checkRequire('address', this.destination.address, 'Chi tiết địa điểm');

      this.errors = validator.errors;
    },

    async onDeleteDestination() {
      this.$loading(true);
      try {
        await CustomerDestinationsService.delete(this.destination.id);
        await this.getCustomerDestinations();
        this.showModalDestination = false;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    }
  },
}
</script>
