import Vue from 'vue/dist/vue.esm'
import App from './App'
import router from './router'
import VueMaterial from 'vue-material/dist/vue-material'
import 'vue-material/dist/vue-material.css'
import 'sanitize.css/sanitize.css'
import axios from 'axios'
import lodash from 'lodash'

Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  window.axios = axios
  window.axios.defaults.headers.common['X-CSRF-Token'] =  document.getElementsByName('csrf-token')[0].content

  window._ = lodash

  Vue.use(VueMaterial)

  new Vue({
    el: '#app',
    router,
    template: '<App/>',
    components: {
      App,
    }
  })
});
