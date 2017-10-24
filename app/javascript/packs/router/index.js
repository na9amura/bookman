import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'
import Books from '../pages/Books'
import Book from '../pages/Book'
import BookForm from '../pages/BookForm'
import Checkouts from '../pages/Checkouts'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Books,
    },
    {
      name: 'book',
      path: '/books/:id',
      component: Book,
      props: true,
    },
    {
      name: 'book_form',
      path: 'book_form',
      component: BookForm,
    },
    {
      name: 'checkouts',
      path: 'checkouts',
      component: Checkouts,
    }
  ]
})
