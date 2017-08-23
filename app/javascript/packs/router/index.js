import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'
import Books from '../pages/Books'
import Book from '../pages/Book'
import BookWebSearch from '../pages/BookWebSearch'
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
      path: '/books/:id',
      component: Book,
      props: true,
    },
    {
      name: 'book_web_search',
      path: 'book_web_search',
      component: BookWebSearch,
    },
    {
      name: 'book_form',
      path: 'book_form',
      component: BookForm,
    },
  ]
})
