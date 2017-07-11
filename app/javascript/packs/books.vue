<template>
  <div>
    <div v-for="book in filteredBooks">
      <book :book=book></book>
    </div>
  </div>
</template>

<script>
import Book from './book.vue'

export default {
  props: {
    filterKey: String,
  },
  data: function () {
    return {
      books: [
        {
          id: 1,
          name: 'foo',
        },
        {
          id: 2,
          name: 'bar',
        }
      ],
    }
  },
  computed: {
    filteredBooks: function() {
      let filterKey = this.filterKey && this.filterKey.toLowerCase()
      let books = this.books
      if(filterKey) {
        books = books.filter(
          (row) => {
            return Object.keys(row).some(
              (key) => {
                return String(row[key]).toLowerCase().indexOf(filterKey) > -1
              }
            )
          }
        )
      }
      return books
    },
  },
  components: { Book }
}
</script>
