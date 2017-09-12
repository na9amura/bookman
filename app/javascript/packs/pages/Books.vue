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
      <text-box
        :id="'filterKey'"
        :title="'検索ワード'"
        :text.sync="filterKey">
      </text-box>
      <text-box
        :id="'shelfName'"
        :title="'本棚検索ワード'"
        :text.sync="shelfName">
      </text-box>
    </form>
    <div v-for="book in filteredBooks">
      <book-cell :book=book>
        <router-link
          tag="md-button"
          class="md-raised md-primary"
          :to="{ name: 'book', params: { id: book.id } }">
          本の情報を見る
        </router-link>
      </book-cell>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
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
  }
}
</script>
