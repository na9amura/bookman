import Vue from 'vue/dist/vue.esm'
import App from './app.vue'
import Hello from './hello.vue'
import Books from './books.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    data: {
      searchQuery: '',
    },
    components: {
      App,
      Hello,
      Books,
    },
  })
})
