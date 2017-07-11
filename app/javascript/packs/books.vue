<template>
  <div>
    <div v-for="book in filteredBooks">
      <book :book=book></book>
    </div>
  </div>
</template>

<script>
import Book from './book.vue'
import axios from 'axios'

export default {
  components: {
    Book,
  },
  props: {
    filterKey: String,
  },
  data: function () {
    return {
      books: {},
    }
  },
  computed: {
    filteredBooks: function() {
      let filterKey = this.filterKey && this.filterKey.toLowerCase()
      let books = this.books
      if(filterKey) {
        books = books.filter(
          (row) => {
            return Object.keys(row)
              .filter((key) => key !== 'url' )
              .some((key) => String(row[key]).toLowerCase().indexOf(filterKey) > -1)
          }
        )
      }
      return books
    },
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
          console.log(response.data)
          vm.books = response.data
        })
    }
  }
}
</script>
