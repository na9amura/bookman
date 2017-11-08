<template>
  <div>
    <form id="search" class="books--form">
      <md-input-container>
        <label>Search</label>
        <md-input v-model="filterKey">
        </md-input>
      </md-input-container>

      <md-checkbox
        v-for="tag in tags"
        :key="tag.id"
        :md-value="tag.name"
        v-model="selectedTags">
        {{ tag.name }}
      </md-checkbox>
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
      shelves: [],
      tags: [],
      selectedTags: [],
    }
  },
  computed: {
    filteredBooks () {
      const searchQuery = this.filterKey && this.filterKey.toLowerCase()
      const selectedTags = this.selectedTags
      let books = this.books.state.list

      if(searchQuery || selectedTags.length !== 0) {
        books = books
          .filter((row) => {
            return Object.keys(row)
              .some((key) => this.matchString(row[key], searchQuery))
          })
          .filter((book) => {
            return book.tags.length !== 0 && this.matchedTags(book).length >= selectedTags.length
          })
      }
      return books
    },
  },
  created () {
    this.init()
  },
  methods: {
    matchedTags(book) {
      return book.tags.filter((tag) => this.selectedTags.indexOf(tag.name) >= 0)
    },
    init () {
      this.loadBooks()
      this.loadShelves()
      this.loadTags()
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
    loadTags() {
      axios.get('/tags.json')
        .then((response) => { this.tags = response.data })
    },
    matchString(source, query) {
      return String(source).toLowerCase().indexOf(query) > -1
    },
  }
}
</script>


<style scoped lang="sass">
  .books--form
    padding: 2em
</style>
