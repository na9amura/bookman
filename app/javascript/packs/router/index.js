import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'
import Books from '../pages/Books'
import Book from '../pages/Book'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Books,
      // children: [
      //   {
      //     path: ':filterType',
      //     component: TodoList,
      //   },
      // ],
    },
    {
      name: 'book',
      path: '/book/:id',
      component: Book,
      props: true,
    },
  ]
})
