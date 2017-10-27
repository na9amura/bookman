<template>
  <div>
    <form id="search">
      <md-input-container>
        <label>Search</label>
        <md-input v-model="filterKey">
        </md-input>
      </md-input-container>

      <md-input-container>
        <label>Shelf Name</label>
        <md-input v-model="shelfName">
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
      shelfName: '',
      shelves: [
        { name: 'Main Shelf', id: 1 },
        { name: 'Sub Shelf', id: 2 },
      ]
    }
  },
  computed: {
    filteredBooks () {
      const searchQuery = this.filterKey && this.filterKey.toLowerCase()
      const shelfName = this.shelfName && this.shelfName.toLowerCase()
      let books = this.books.state.list

      if(searchQuery || shelfName) {
        books = books
          .filter((row) => {
            return Object.keys(row)
              .some((key) => String(row[key]).toLowerCase().indexOf(searchQuery) > -1)
          })
          .filter((book) => {
            return book.shelf.name.toLocaleLowerCase().indexOf(shelfName) > -1
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
