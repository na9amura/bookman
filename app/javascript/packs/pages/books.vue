<template>
  <div>
    <form id="search">
      <input value="query" v-model="searchQuery">
    </form>
    <div v-for="book in filteredBooks">
      <book :book=book></book>
    </div>
  </div>
</template>

<script>
import Book from '../components/book_row.vue'
import axios from 'axios'

export default {
  components: {
    Book,
  },
  data: function () {
    return {
      books: {},
      searchQuery: '',
    }
  },
  computed: {
    filteredBooks: function() {
      let searchQuery = this.searchQuery && this.searchQuery.toLowerCase()
      let books = this.books
      if(searchQuery) {
        books = books.filter(
          (row) => {
            return Object.keys(row)
              .filter((key) => key !== 'url' )
              .some((key) => String(row[key]).toLowerCase().indexOf(searchQuery) > -1)
          }
        )
      }
      return books
    },
  },
  watch: {
    searchQuery: function(val) {
      this.filterKey = val
    }
  },
  created: function() {
    this.init()
  },
  methods: {
    init: function() {
      this.loadBooks()
    },
    loadBooks: function() {
      var vm = this
      axios.get('/books.json')
        .then(function(response) {
          vm.books = response.data
        })
    }
  }
}
</script>
