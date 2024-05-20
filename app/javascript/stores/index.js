import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import SecureLS from 'secure-ls';
import admins from './modules/admins';
import staffs from './modules/staffs';
import customers from './modules/customers';

var ls = new SecureLS();

Vue.use(Vuex);

export default new Vuex.Store({
  plugins: [
    createPersistedState({
      paths: ['isLoading', 'error'],
      storage: {
        getItem: key => ls.get(key),
        setItem: (key, value) => ls.set(key, value),
        removeItem: key => ls.remove(key)
      }
    })
  ],
  state: {
    isLoading: true,
    showSidebar: true,
    error: null,
  },
  modules: {
    admins,
    staffs,
    customers,
  },
  mutations: {
    LOADING(state, isLoading) {
      state.isLoading = isLoading;
    },
    ERROR(state, error) {
      state.error = error;
    },
  },
});
