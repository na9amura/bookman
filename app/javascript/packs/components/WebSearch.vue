<template>
  <div>
    <form id="search" class="search--form">
      <md-select
        v-model="apiNames[0]"
        @selected="selectApi" >
        <md-option
          v-for="apiName in apiNames"
          :key="apiName"
          :value="apiName">
          {{ apiName }}
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
    props: {
      p_apis: {
        type: Object,
        default() {
          return {
            google: new WebSearch(new GoogleBooksDriver()),
            amazon: new WebSearch(new AmazonBooksDriver()),
          }
        }
      }
    },
    computed: {
      apiNames() {
        return Object.keys(this.p_apis)
      }
    },
    created() {
      this.init()
    },
    data () {
      return {
        apis: {
          google: 'googlePlugin',
          amazon: 'amazonPlugin',
        },
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
      selectApi(name) {
        this.plugin = this.p_apis[name]
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
  .search--form
    padding: 2em
</style>
