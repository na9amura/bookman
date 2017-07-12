import Vue from 'vue/dist/vue.esm'
import App from './app.vue'
import Books from './pages/books.vue'
import VueRouter from 'vue-router'
import routes from './routes'

document.addEventListener('DOMContentLoaded', () => {
  Vue.use(VueRouter)

  const router = new VueRouter({
    mode: 'history',
    base: __dirname,
    routes: routes
  })

  new Vue({
    router,
    render: h => h(Books)
  }).$mount('#app')

  // const app = new Vue({
  //   el: '#app',
  //   data: {
  //     searchQuery: '',
  //   },
  //   components: {
  //     App,
  //     Hello,
  //     Books,
  //   },
  // })
})
