<template>
  <div>
    <form id="search">
      <input value="query" v-model="searchQuery">
    </form>
    <div v-for="book in filteredBooks">
      <book-row :book=book></book-row>
      <!-- <p>{{ book.id }}: {{ book.name }}</p> -->
    </div>
  </div>
</template>

<script>
import BookRow from '../components/BookRow'
import axios from 'axios'

export default {
  name: 'books',
  components: {
    BookRow,
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
