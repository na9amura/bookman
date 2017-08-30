<template>
  <div>
    <div>
      <router-link :to="{ name: 'book_form'}">
        find new book
      </router-link>
    </div>
    <div>
      <router-link :to="{ name: 'checkouts'}">
        my books
      </router-link>
    </div>
    <form id="search">
      <input v-model="filterKey">
    </form>
    <div v-for="book in filteredBooks">
      <book-cell :book=book>
        <router-link :to="{ name: 'book', params: { id: book.id } }">
          <button>本の情報を見る</button>
        </router-link>
      </book-cell>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'
import BookCell from '../components/BookCell'

export default {
  name: 'books',
  components: {
    BookCell,
  },
  data () {
    return {
      books: Books,
      filterKey: '',
    }
  },
  computed: {
    filteredBooks () {
      let searchQuery = this.filterKey && this.filterKey.toLowerCase()
      let books = this.books.state.list
      if(searchQuery) {
        books = books.filter(
          (row) => {
            return Object.keys(row)
              .some((key) => String(row[key]).toLowerCase().indexOf(searchQuery) > -1)
          }
        )
      }
      return books
    },
  },
  created () {
    this.init()
  },
  methods: {
    init () {
      this.loadBooks()
    },
    loadBooks () {
      var vm = this
      axios.get('/books.json')
        .then(function(response) {
          vm.books.state.list = response.data
        })
    }
  }
}
</script>
