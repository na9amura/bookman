import Vue from 'vue/dist/vue.esm'
import App from './App'
import router from './router'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    router,
    template: '<App/>',
    components: { App }
  })
})
//
// document.addEventListener('DOMContentLoaded', () => {
//   Vue.use(VueRouter)
//
//   const router = new VueRouter({
//     mode: 'history',
//     base: __dirname,
//     routes: routes
//   })
//
//   new Vue({
//     router,
//     render: h => h(App),
//   }).$mount('#app')
//
//   // const app = new Vue({
//   //   el: '#app',
//   //   data: {
//   //     searchQuery: '',
//   //   },
//   //   components: {
//   //     App,
//   //     Hello,
//   //     Books,
//   //   },
//   // })
// })
