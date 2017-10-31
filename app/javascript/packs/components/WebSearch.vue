<template>
  <div>
    <form id="search">
      <md-select
        @selected="selectApi" >
        <md-option
          v-for="api in apis"
          :key="api.name"
          :value="api.name">
          {{ api.name }}
        </md-option>
      </md-select>
      <md-input-container>
        <label>title</label>
        <md-input
          v-model="query.title"
          @keydown.enter.native="findSuggest" />
      </md-input-container>

      <md-input-container>
        <label>author</label>
        <md-input
          v-model="query.author"
          @keydown.enter.native="findSuggest" />
      </md-input-container>

      <md-input-container>
        <label>isbn</label>
        <md-input
          v-model="query.isbn"
          @keydown.enter.native="findSuggest" />
      </md-input-container>

      <md-button
        class="md-raised md-primary"
        @click="findSuggest">
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
  import AmazonBooksDriver from '../infra/WebSearches/AmazonBooks'
  import WebSearch from '../infra/WebSearch'

  export default {
    name: 'web-search',
    components: {
      BookCell,
    },
    created() {
      this.init()
    },
    data () {
      return {
        apis: [
          { name: 'google', plugin: this.googlePlugin },
          { name: 'amazon', plugin: this.amazonPlugin },
        ],
        plugin: {},
        googlePlugin: {},
        amazonPlugin: {},
        query: {
          title: '',
          author: '',
          isbn: '',
        },
        books: Books,
      }
    },
    methods: {
      init() {
        this.googlePlugin = new WebSearch(new GoogleBooksDriver())
        this.amazonPlugin = new WebSearch(new AmazonBooksDriver())
        this.plugin = this.googlePlugin
      },
      selectApi() {
        console.log('select api')
        this.plugin = this.amazonPlugin
      },
      select(result) {
        result.selected = true;
        this.books.state.new_request = result.book;
      },
      reset(result) {
        result.selected = false;
        this.books.state.new_request = new Book();
      },
      findSuggest () {
        this.plugin
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
