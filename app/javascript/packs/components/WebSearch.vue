<template>
  <div>
    <form id="search">
      <md-input-container>
        <label>title</label>
        <md-input v-model="query.title"></md-input>
      </md-input-container>

      <md-input-container>
        <label>author</label>
        <md-input v-model="query.author"></md-input>
      </md-input-container>

      <md-input-container>
        <label>isbn</label>
        <md-input v-model="query.isbn"></md-input>
      </md-input-container>

      <md-button
        class="md-raised md-primary"
        v-on:click="find_suggest">
        検索
      </md-button>
    </form>
    <div class="suggests">
      <div class="suggest-item" v-for="result in books.state.web_search.results">
        <book-cell :book=result.book :selected=result.selected>
          <div v-show="result.selectable">
            <div v-show="result.selected">
              <md-button
                class="md-raised"
                v-on:click="reset(result)">
                Selected
              </md-button>
            </div>
            <div v-show="!result.selected">
              <md-button
                class="md-raised md-primary"
                v-on:click="select(result)">
                Select
              </md-button>
            </div>
          </div>
        </book-cell>
      </div>
    </div>
  </div>
</template>

<script>
import Book from '../models/Book'
import Books from '../models/global/books'
import BookCell from '../components/BookCell'
import GoogleBooksDriver from '../infra/WebSearches/GoogleBooks'
import WebSearch from '../infra/WebSearch'

export default {
  name: 'web-search',
  components: {
    BookCell,
  },
  computed: {
  },
  data () {
    return {
      query: {
        title: '',
        author: '',
        isbn: '',
      },
      books: Books,
    }
  },
  methods: {
    select (result) {
      result.selected = true;
      this.books.state.new_request = result.book;
    },
    reset (result) {
      result.selected = false;
      this.books.state.new_request = new Book();
    },
    find_suggest () {
      const webSearch = new WebSearch(new GoogleBooksDriver())
      webSearch
        .find(this.query.title, this.query.author, this.query.isbn)
        .then((books) => {
          this.books.state.web_search.results = books.map((book) => {
            return {
              selected: false,
              selectable: true,
              book: book,
            }
          })
        })
    }
  },
}
</script>

<style scoped lang="sass">
.suggests
  display: flex
  flex-direction: column
</style>
