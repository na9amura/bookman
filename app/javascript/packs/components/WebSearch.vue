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
                class="md-raised md-accent"
                v-on:click="reset(result)">
                Selected
              </md-button>
            </div>
            <div v-show="!result.selected">
              <md-button
                class="md-raised"
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
import axios from 'axios'
import Books from '../models/global/books'
import BookCell from '../components/BookCell'

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
      this.books.state.new_request = {
        title: '',
        author: '',
        isbn: '',
      };
    },
    find_suggest () {
      let vm = this;
      axios
        .get(`https://www.googleapis.com/books/v1/volumes?q=${ vm.queryString() }`)
        .then((res) => {
          let items = res.data.items;
          vm.books.state.web_search.results = items.map((item) => {
            return {
              selected: false,
              selectable: true,
              book: {
                title: item.volumeInfo.title,
                author: item.volumeInfo.authors[0],
                isbn: item.volumeInfo.industryIdentifiers[0].identifier
              }
            };
          });
        })
        .catch((e) => {
          console.log(e);
           vm.books.state.web_search.results = [
             {
               selected: false,
               selectable: true,
               book: { id: null, title: 'foobar', author: 'fizz bazz', isbn: '123456789678'},
             },
             {
               selected: false,
               selectable: true,
               book: { id: null, title: 'foobar', author: 'fizz bazz', isbn: '123456789678'},
             },
             {
               selected: false,
               selectable: true,
               book: { id: null, title: 'foobar', author: 'fizz bazz', isbn: '123456789678'},
             },
             {
               selected: false,
               selectable: true,
               book: { id: null, title: 'foobar', author: 'fizz bazz', isbn: '123456789678'},
             },
             {
               selected: false,
               selectable: true,
               book: { id: null, title: 'foobar', author: 'fizz bazz', isbn: '123456789678'},
             },
           ]
        })
    },
    queryElements () {
      return {
        intitle: this.query.title,
        inauthor: this.query.author,
        isbn: this.query.isbn,
      }
    },
    queryString () {
      let queries = this.queryElements();
      return Object.keys(queries)
        .map(function(k) { return [k, this[k]] }, queries)
        .filter((e) => e[1])
        .map((e) => `${ e[0] }:${ e[1] }`)
        .join('+');
    },
  }
}
</script>

<style scoped lang="sass">
.suggests
  display: flex
  flex-direction: column
</style>
