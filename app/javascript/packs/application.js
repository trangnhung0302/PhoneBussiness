import Vue from 'vue';
import App from '../App.vue';
import router from '../routes';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue';
import DisableAutocomplete from 'vue-disable-autocomplete';
import VueLoading from '../plugins/loading';

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

import DatePicker from 'vue2-datepicker';
import 'vue2-datepicker/locale/vi';
Vue.component('DateTimePicker', DatePicker);

Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(DisableAutocomplete);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: (h) => h(App),
    router,
  }).$mount();

  document.body.appendChild(app.$el);
});

Vue.use(VueLoading);
