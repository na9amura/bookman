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
      <input v-model="filterKey">
      <input v-model="shelfName">
    </form>
    <div v-for="book in filteredBooks">
      <book-cell :book=book>
        <router-link :to="{ name: 'book', params: { id: book.id } }">
          <button>本の情報を見る</button>
        </router-link>
      </book-cell>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'
import BookCell from '../components/BookCell'

export default {
  name: 'books',
  components: {
    BookCell,
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
    booksInShelf () {
    }
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
