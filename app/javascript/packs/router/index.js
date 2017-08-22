import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'
import Books from '../pages/Books'
import Book from '../pages/Book'
import BookForm from '../pages/BookForm'

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
      path: '/book/:id',
      component: Book,
      props: true,
    },
    {
      name: 'book_form',
      path: 'book_form',
      component: BookForm,
    }
  ]
})
