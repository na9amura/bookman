<template>
  <div>
    <book-form></book-form>
    <form id="search">
      <input v-model="filterKey">
    </form>
    <div v-for="book in filteredBooks">
      <book-row :book=book></book-row>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'
import BookForm from '../components/BookForm'
import BookRow from '../components/BookRow'

export default {
  name: 'books',
  components: {
    BookRow,
    BookForm,
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
