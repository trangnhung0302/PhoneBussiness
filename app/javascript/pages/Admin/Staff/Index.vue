<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Danh sách nhân viên</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="list_header">
            <div class="box_right d-flex lms_block">
              <div class="serach_field_2">
                <div class="search_inner">
                  <input v-model="keySearch" type="text" class="" placeholder="Tìm kiếm nhân viên" @input="onSearch">
                  <div class="icon-search"><b-icon-search scale="1.5" /></div>
                </div>
              </div>
              <div class="add_button ms-2">
                <button class="btn-create" @click="$router.push('staff/create')">Thêm mới</button>
              </div>
            </div>
          </div>
          <div class="list-body">
            <div class="dataTables_wrapper no-footer">
              <table class="table lms_table_active3 dataTable no-footer dtr-inline">
                <thead>
                  <td v-for="header in tableHeader" :key="header">
                    {{ header }}
                  </td>
                </thead>
                <tbody>
                  <tr v-for="(staff, index) in staffs" :key="index" class="cursor-pointer" @click="$router.push(`staff/${staff.id}/edit`)">
                    <td>{{ staff.name }}</td>
                    <td>{{ staff.email }}</td>
                    <td>{{ staff.phone }}</td>
                    <td>{{ statusList.filter(status => status.status == staff.status)[0].text }}</td>
                  </tr>
                </tbody>
              </table>
              <Pager
                :totalPage="pager.page_count"
                :page="pager.page"
                @jumpPage="onPageChange"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { StaffsService } from '../../../services/admin/staffs.service';
import _ from 'lodash';
import Pager from '../../../components/AdminPager.vue';

export default {
  components: {
    Pager,
  },
  data() {
    return {
      tableHeader: ["Tên", "Email", "Số điện thoại", "Trạng thái"],
      staffs: [],
      statusList: [
        { text: "Làm việc", status: 10, color: "green" },
        { text: "Tạm nghỉ", status: 20, color: "orange" },
        { text: "Nghỉ việc", status: 30, color: "red" },
      ],
      keySearch: null,
      pager: {
        page: 1,
        page_count: 1,
        page_size: 10,
        item_count: 0,
      },
      pageParams: {
        page: 1,
        page_size: 10,
        total_page: 1,
      }
    }
  },
  mounted() {
    this.getStaffs();
  },
  methods: {
    async getStaffs() {
      const params = {
        name: this.keySearch,
        ...this.pageParams,
      }
      this.$loading(true);
      try {
        const { response } = await StaffsService.index(params);
        this.staffs = response.data;
        this.pager = response.pager;
        this.$loading(false);
      } catch (e) {
        this.$loading(false);
      }
    },

    onSearch: _.debounce(async function() {
      this.getStaffs();
    }, 500),

    onPageChange(page) {
      this.pageParams.page = page;
      this.getStaffs();
    },
  },
}
</script>
