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
    <div v-for="book in filteredBooks">
      <router-link
        class="books-row--link"
        tag="div"
        :to="{ name: 'book', params: { id: book.id } }">
        <book-cell :book=book>
          <md-button
            class="md-raised md-primary"
            @click.stop="selectShelf(book)"
            @click.right="selectShelf(book)">
            本棚変更
          </md-button>
          <md-menu :ref="shelfMenuRef(book)">
            <span md-menu-trigger></span>
            <md-menu-content>
              <md-menu-item v-if="shelves.length"
                v-for="shelf in shelves"
                :key="shelf.id">
                {{ shelf.name }}
              </md-menu-item>
            </md-menu-content>
          </md-menu>
        </book-cell>
      </router-link>
    </div>
  </div>
</template>

<script>
import Books from '../models/global/books'
import BookCell from '../components/BookCell'
import TextBox from '../components/form/TextBox'

export default {
  name: 'books',
  components: {
    BookCell,
    TextBox,
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
    },
    loadBooks () {
      const vm = this
      axios.get('/books.json')
        .then(function(response) {
          vm.books.state.list = response.data
        })
    },
    shelfMenuRef(book) {
      return `shelfMenu${ book.id }`
    },
    selectShelf(book) {
      console.log(`change shelf of ${ book }`)
      this.$refs[this.shelfMenuRef(book)][0].toggle()
    },
  }
}
</script>
