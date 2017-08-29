import Vue from 'vue/dist/vue.esm'
import App from './App'
import router from './router'

Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    router,
    template: '<App/>',
    components: { App }
  })
});
