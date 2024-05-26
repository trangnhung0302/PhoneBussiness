<template>
  <div class="card admin-content-container">
    <div class="row">
      <div class="col-12">
        <div class="white_card_header">
          <div class="box_header m-0">
            <div class="main-title">
              <h3 class="m-0">Thống kê</h3>
            </div>
          </div>
        </div>
        <div class="white_card_body">
          <div class="mb-4">
            <label for="date" class="form_label calendar-title">Thời gian hiển thị</label>
            <div class="d-flex" style="justify-content: space-between;">
              <div class="form_input">
                <DateTimePicker v-if="typeSearchTime == searchTime.month" v-model="month" format="MM/YYYY"
                                :editable="false" :clearable="false"
                                class="input_wrapper calender full_width" input-class="calendar__input calendar-text"
                                type="month"
                                :disabled-date="(date) => date > (new Date().setHours(0, 0, 0, 0))"
                                @input="onChangeMonth"
                >
                  <span slot="icon-calendar">
                    <b-icon-calendar />
                  </span>
                </DateTimePicker>
                <DateTimePicker v-if="typeSearchTime == searchTime.year" v-model="year" format="YYYY"
                                :editable="false" :clearable="false"
                                class="input_wrapper calender full_width" input-class="calendar__input calendar-text"
                                type="year"
                                :disabled-date="(date) => date > (new Date().setHours(0, 0, 0, 0))"
                                @input="onChangeMonth"
                >
                  <span slot="icon-calendar">
                    <b-icon-calendar />
                  </span>
                </DateTimePicker>
                <DateTimePicker v-if="typeSearchTime == searchTime.range" v-model="rangeDate" format="DD/MM/YYYY"
                            :editable="false" :clearable="false"
                            class="input_wrapper calender full_width" input-class="calendar__input calendar-text"
                            type="date"
                            range
                            :disabled-date="(date) => date > (new Date().setHours(0, 0, 0, 0))"
                            @input="onChangeRange"
                >
                  <span slot="icon-calendar" />
                </DateTimePicker>
              </div>
              <div>
                <button class="btn btn-primary admin-btn-primary mb-2">
                  <a href="https://app.powerbi.com/reportEmbed?reportId=9a94ebdf-5eb2-439a-8abc-19fdfb135134&autoAuth=true&ctid=e7572e92-7aee-4713-a3c4-ba64888ad45f" target="_blank" style="color: white;">
                    Thống kê chi tiết
                  </a>
                </button>
              </div>
            </div>
          </div>
          <div class="menu-search">
            <ul class="btn-choose-type">
              <li>
                <input type="radio" v-model="typeSearchTime" v-on:change="onChangeTypeSearchTime" value="month" name="typeSearchTime" />
                <label class="type-search-time">Tháng</label>
              </li>
              <li>
                <input type="radio" v-model="typeSearchTime" v-on:change="onChangeTypeSearchTime" value="year" name="typeSearchTime" />
                <label class="type-search-time">Năm</label>
              </li>
              <li>
                <input type="radio" v-model="typeSearchTime" v-on:change="onChangeTypeSearchTime" value="range" name="typeSearchTime" />
                <label class="type-search-time">Khoảng thời gian</label>
              </li>
            </ul>
          </div>

          <div class="information-statistics">
            <div v-if="typeSearchTime == searchTime.month" class="infomation-by-month">
              <div class="order-statistical-container"> 
                <button class="btn-month pre actived" @click="previewMonth">&#8249;</button>
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Tháng {{ currentMonth() }}</p>
                      <p class="count">Số đơn hàng <span class="content_right">{{ countOrderFirst }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu <span class="content_right">{{ convertNumberFormat(sumIncomeOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí <span class="content_right">{{ convertNumberFormat(sumExpenseOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận <span class="content_right">{{ convertNumberFormat(sumOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Tháng {{ preMonth() }}</p>
                      <p class="count">Số đơn hàng  <span class="content_right">{{ countOrderSecond }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu <span class="content_right">{{ convertNumberFormat(sumIncomeOrderSecond) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí <span class="content_right">{{ convertNumberFormat(sumExpenseOrderSecond) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận <span class="content_right">{{ convertNumberFormat(sumOrderSecond) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Tháng {{ preTwoMonth() }}</p>
                      <p class="count">Số đơn hàng  <span class="content_right">{{ countOrderThird }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu <span class="content_right">{{ convertNumberFormat(sumIncomeOrderThird) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí <span class="content_right">{{ convertNumberFormat(sumExpenseOrderThird) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận <span class="content_right">{{ convertNumberFormat(sumOrderThird) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
                <button class="btn-month next" :class="isActiveBtnNextMonth() ? 'actived' : 'disabled'" @click="nextMonth">&#8250;</button>
              </div>
            </div>
            <div v-if="typeSearchTime == searchTime.year" class="infomation-by-month">
              <div class="order-statistical-container"> 
                <button class="btn-month pre actived" @click="previewYear">&#8249;</button>
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Năm {{ currentYear() }}</p>
                      <p class="count">Số đơn hàng  <span class="content_right">{{ countOrderFirst }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu <span class="content_right">{{ convertNumberFormat(sumIncomeOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí <span class="content_right">{{ convertNumberFormat(sumExpenseOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận <span class="content_right">{{ convertNumberFormat(sumOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Năm {{ preYear() }}</p>
                      <p class="count">Số đơn hàng  <span class="content_right">{{ countOrderSecond }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu <span class="content_right">{{ convertNumberFormat(sumIncomeOrderSecond) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí <span class="content_right">{{ convertNumberFormat(sumExpenseOrderSecond) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận<span class="content_right">{{ convertNumberFormat(sumOrderSecond) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Năm {{ preTwoYear() }}</p>
                      <p class="count">Số đơn hàng  <span class="content_right">{{ countOrderThird }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu <span class="content_right">{{ convertNumberFormat(sumIncomeOrderThird) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí <span class="content_right">{{ convertNumberFormat(sumExpenseOrderThird) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận <span class="content_right">{{ convertNumberFormat(sumOrderThird) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
                <button class="btn-month next" :class="isActiveBtnNextYear() ? 'actived' : 'disabled'" @click="nextYear">&#8250;</button>
              </div>
            </div>
            <div v-if="typeSearchTime == searchTime.range" class="infomation-by-month">
              <div class="order-statistical-container"> 
                <div class="detail-month">
                  <div class="month">
                    <div class="content-month">
                      <p class="title-time">Năm {{ displayRange() }}</p>
                      <p class="count">Số đơn hàng  <span class="content_right">{{ countOrderFirst }}<span class="text_content font_text-bold"></span></span></p>
                      <p>Doanh thu<span class="content_right">{{ convertNumberFormat(sumIncomeOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Chi phí<span class="content_right">{{ convertNumberFormat(sumExpenseOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                      <p>Lợi nhuận<span class="content_right">{{ convertNumberFormat(sumOrderFirst) }}<span class="text_content font_text-bold"></span>đ</span></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-4">
            <div class="report-category-group-button">
              <ul class="btn-choose-type">
                <li>
                  <input type="radio" v-model="typeReportCategory" value="1" name="typeReportCategory" />
                  <label class="type-search-time">Số sản phẩm bán</label>
                </li>
                <li>
                  <input type="radio" v-model="typeReportCategory" value="2" name="typeReportCategory" />
                  <label class="type-search-time">Lợi nhuận</label>
                </li>
                <li>
                  <input type="radio" v-model="typeReportCategory" value="3" name="typeReportCategory" />
                  <label class="type-search-time">Doanh thu</label>
                </li>
                <li>
                  <input type="radio" v-model="typeReportCategory" value="4" name="typeReportCategory" />
                  <label class="type-search-time">Chi phí</label>
                </li>
              </ul>
            </div>
            <div class="fs-4">Thống kê theo phân loại sản phẩm</div>
            <DoughnutChart
              v-if="typeReportCategory == 1"
              :data="dataSumItemByCategory"
            />
            <DoughnutChart
              v-if="typeReportCategory == 2"
              :data="dataSumPriceByCategory"
            />
            <DoughnutChart
              v-if="typeReportCategory == 3"
              :data="dataSumIncomeByCategory"
            />
            <DoughnutChart
              v-if="typeReportCategory == 4"
              :data="dataSumExpenseByCategory"
            />
          </div>
          <div class="mt-4">
            <div class="fs-4">Thống kê theo hãng sản phẩm</div>
            <BarChart
              v-if="typeReportCategory == 1"
              :data="dataSumItemBySupplier"
              :unit="'Số lượng'"
            />
            <BarChart
              v-if="typeReportCategory == 2"
              :data="dataSumPriceBySupplier"
              :unit="'Lợi nhuận (đ)'"
            />
            <BarChart
              v-if="typeReportCategory == 3"
              :data="dataSumIncomeBySupplier"
              :unit="'Số lượng'"
            />
            <BarChart
              v-if="typeReportCategory == 4"
              :data="dataSumExpenseBySupplier"
              :unit="'Lợi nhuận (đ)'"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment';
import DatePicker from 'vue2-datepicker';
import 'vue2-datepicker/index.css';
import { ReportService } from '../../../services/admin/report.service';
import utils from '../../../common/util';
import { CategoriesService } from '../../../services/admin/categories.service';

import DoughnutChart from './components/Doughnut.vue';
import BarChart from './components/Bar.vue';

export default {
  components: {
    DatePicker,
    DoughnutChart,
    BarChart,
  },
  data() {
    return {
      searchTime: {
        month: 'month',
        year: 'year',
        range: 'range',
      },
      typeSearchTime: 'month',
      month: new Date(),
      year: new Date(),
      rangeDate: [new Date(), new Date()],
      countOrderFirst: 0,
      sumOrderFirst: 0,
      sumExpenseOrderFirst: 0,
      sumIncomeOrderFirst: 0,
      countOrderSecond: 0,
      sumOrderSecond: 0,
      sumExpenseOrderSecond: 0,
      sumIncomeOrderSecond: 0,
      countOrderThird: 0,
      sumOrderThird: 0,
      sumExpenseOrderThird: 0,
      sumIncomeOrderThird: 0,
      categories: [],
      dataSumItemByCategory: [],
      dataSumExpenseByCategory: [],
      dataSumIncomeByCategory: [],
      dataSumPriceByCategory: [],

      dataSumItemBySupplier: [],
      dataSumExpenseBySupplier: [],
      dataSumIncomeBySupplier: [],
      dataSumPriceBySupplier: [],

      typeReportCategory: 1,
      typeReportSupplier: 1,
    }
  },
  mounted() {
    this.onLoadData();
    setInterval(() => {
      this.onLoadData();
    }, 300000);
  },
  methods: {
    ...utils,

    onLoadData() {
      this.getReportRevenue();
      this.getReportByCategory();
      this.getReportBySupplier();
    },

    onChangeTypeSearchTime() {
      this.onLoadData();
    },

    onChangeMonth() {
      this.onLoadData();
    },

    onChangeRange() {
      this.onLoadData();
    },

    previewMonth() {
      this.month = new Date(moment(this.month).subtract(1, 'month'));
      this.onLoadData();
    },

    nextMonth() {
      this.month = new Date(moment(this.month).add(1, 'month'));
      this.onLoadData();
    },

    isActiveBtnNextMonth() {
      return moment(this.month).format('YYYY/MM') == moment().format('YYYY/MM') ? false : true;
    },

    currentMonth() {
      return moment(this.month).format('MM/YYYY');
    },

    preMonth() {
      const month = new Date(moment(this.month).subtract(1, 'month'));
      return moment(month).format('MM/YYYY');
    },

    preTwoMonth() {
      const month = new Date(moment(this.month).subtract(2, 'month'));
      return moment(month).format('MM/YYYY');
    },

    previewYear() {
      this.year = new Date(moment(this.year).subtract(1, 'year'));
      this.onLoadData();
    },

    nextYear() {
      this.year = new Date(moment(this.year).add(1, 'year'));
      this.onLoadData();
    },

    isActiveBtnNextYear() {
      return moment(this.year).format('YYYY') == moment().format('YYYY') ? false : true;
    },

    currentYear() {
      return moment(this.year).format('YYYY');
    },

    preYear() {
      const year = new Date(moment(this.year).subtract(1, 'year'));
      return moment(year).format('YYYY');
    },

    preTwoYear() {
      const year = new Date(moment(this.year).subtract(2, 'year'));
      return moment(year).format('YYYY');
    },

    displayRange() {
      return `${moment(this.rangeDate[0]).format('DD/MM/YYYY')} - ${moment(this.rangeDate[1]).format('DD/MM/YYYY')}`;
    },

    async getReportRevenue() {
      const params = {
        month: moment(this.month).format('YYYY/MM/DD'),
        year: moment(this.year).format('YYYY/MM/DD'),
        type_search_time: this.typeSearchTime,
        start_time: moment(this.rangeDate[0]).format('YYYY/MM/DD'),
        end_time: moment(this.rangeDate[1]).format('YYYY/MM/DD'),
      }
      this.$loading(true);
      try {
        const { response } = await ReportService.getReportRevenue(params);
        const calculate = response.data;
        this.countOrderFirst = calculate.count_order_first ? calculate.count_order_first : 0;
        this.sumOrderFirst = calculate.sum_order_first ? calculate.sum_order_first : 0;
        this.sumExpenseOrderFirst = calculate.sum_expense_order_first ? calculate.sum_expense_order_first : 0;
        this.sumIncomeOrderFirst = calculate.sum_income_order_first ? calculate.sum_income_order_first : 0;

        this.countOrderSecond = calculate.count_order_second ? calculate.count_order_second : 0;
        this.sumOrderSecond = calculate.sum_order_second ? calculate.sum_order_second : 0;
        this.sumExpenseOrderSecond = calculate.sum_expense_order_second ? calculate.sum_expense_order_second : 0;
        this.sumIncomeOrderSecond = calculate.sum_income_order_second ? calculate.sum_income_order_second : 0;

        this.countOrderThird = calculate.count_order_third ? calculate.count_order_third : 0;
        this.sumOrderThird = calculate.sum_order_third ? calculate.sum_order_third : 0;
        this.sumExpenseOrderThird = calculate.sum_expense_order_third ? calculate.sum_expense_order_third : 0;
        this.sumIncomeOrderThird = calculate.sum_income_order_third ? calculate.sum_income_order_third : 0;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    },

    async getReportByCategory() {
      const params = {
        month: moment(this.month).format('YYYY/MM/DD'),
        year: moment(this.year).format('YYYY/MM/DD'),
        type_search_time: this.typeSearchTime,
        start_time: moment(this.rangeDate[0]).format('YYYY/MM/DD'),
        end_time: moment(this.rangeDate[1]).format('YYYY/MM/DD'),
      }
      this.$loading(true);
      try {
        const { response } = await ReportService.getReportByCategory(params);
        const dataReportByCategory = response.data;
        this.dataSumItemByCategory = dataReportByCategory.map(data => {
          return {
            label: data.name,
            data: data.sum_item,
          }
        })
        this.dataSumPriceByCategory = dataReportByCategory.map(data => {
          return {
            label: data.name,
            data: data.sum_price,
          }
        })
        this.dataSumIncomeByCategory = dataReportByCategory.map(data => {
          return {
            label: data.name,
            data: data.sum_income,
          }
        })
        this.dataSumExpenseByCategory = dataReportByCategory.map(data => {
          return {
            label: data.name,
            data: data.sum_expense,
          }
        })
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
    },

    async getReportBySupplier() {
      const params = {
        month: moment(this.month).format('YYYY/MM/DD'),
        year: moment(this.year).format('YYYY/MM/DD'),
        type_search_time: this.typeSearchTime,
        start_time: moment(this.rangeDate[0]).format('YYYY/MM/DD'),
        end_time: moment(this.rangeDate[1]).format('YYYY/MM/DD'),
      }
      this.$loading(true);
      try {
        const { response } = await ReportService.getReportBySupplier(params);
        const dataReportBySupplier = response.data;
        this.dataSumItemBySupplier = dataReportBySupplier.map(data => {
          return {
            label: data.name,
            data: data.sum_item,
          }
        })
        this.dataSumPriceBySupplier = dataReportBySupplier.map(data => {
          return {
            label: data.name,
            data: data.sum_price,
          }
        })
        this.dataSumIncomeBySupplier = dataReportBySupplier.map(data => {
          return {
            label: data.name,
            data: data.sum_income,
          }
        })
        this.dataSumExpenseBySupplier = dataReportBySupplier.map(data => {
          return {
            label: data.name,
            data: data.sum_expense,
          }
        })
        this.$loading(false);
      } catch (error) {
        console.log(error);
        this.$loading(false);
      }
    },

    async getCategories() {
      this.$loading(true);
      try {
        const { response } = await CategoriesService.index();
        this.categories = response.data;
        this.$loading(false);
      } catch (error) {
        this.$loading(false);
      }
    }
  },
}
</script>
