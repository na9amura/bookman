<template>
  <div>
    <form id="search">
      <md-input-container>
        <label>Search</label>
        <md-input v-model="filterKey">
        </md-input>
      </md-input-container>

      <md-input-container>
        <label>Tag</label>
        <md-input v-model="tagName">
        </md-input>
      </md-input-container>
    </form>
    <div v-for="(book, index) in filteredBooks">
      <router-link
        class="books-row--link"
        tag="div"
        :to="{ name: 'book', params: { id: book.id } }">
        <book-cell :book=book>
          <book-menu :index=index :book=book :shelves=shelves />
        </book-cell>
      </router-link>
    </div>
  </div>
</template>

<script>
import Books from '../models/global/books'
import BookCell from '../components/BookCell'
import BookMenu from '../components/books/Menu'

export default {
  name: 'books',
  components: {
    BookCell,
    BookMenu,
  },
  data () {
    return {
      books: Books,
      filterKey: '',
      tagName: '',
      shelves: [
        { name: 'Main Shelf', id: 1 },
        { name: 'Sub Shelf', id: 2 },
      ]
    }
  },
  computed: {
    filteredBooks () {
      const searchQuery = this.filterKey && this.filterKey.toLowerCase()
      const tagName = this.tagName
      let books = this.books.state.list

      if(searchQuery || tagName) {
        books = books
          .filter((row) => {
            return Object.keys(row)
              .some((key) => String(row[key]).toLowerCase().indexOf(searchQuery) > -1)
          })
          .filter((book) => {
            return book.tags.length !== 0 &&
               book.tags.filter((tag) => tag.name === tagName).length === 1
          })
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
      this.loadShelves()
    },
    loadBooks () {
      const vm = this
      axios.get('/books.json')
        .then(function(response) {
          vm.books.state.list = response.data
        })
    },
    loadShelves() {
      axios.get('/shelves.json')
        .then((response) => { this.shelves = response.data })
    },
  }
}
</script>
