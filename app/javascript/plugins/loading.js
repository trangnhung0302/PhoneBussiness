import Loading from '../components/Loading.vue';

let vm = {};

export default {
  install(Vue, opts) {
    opts = opts || {};
    const LoadingPlugin = Vue.extend(Loading);
    vm = new LoadingPlugin({
      data: opts
    }).$mount();
    document.body.appendChild(vm.$el);
    Vue.prototype.$loading = (loading) => {
      vm.loading = loading;
    };
  }
};

export const asyncLoading = function(fn) {
  return new Promise((resolve, reject) => {
    vm.loading = true;
    const finished = cb => {
      return (result) => {
        cb(result);
        vm.loading = false;
      };
    };
    fn.then(finished(resolve)).catch(finished(reject));
  });
};
