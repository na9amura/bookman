<template>
  <div>
    <form id="search">
      <label for="book-title">title</label>
      <input name="book-title" type="text" v-model="book.title">

      <label for="book-author">author</label>
      <input name="book-author" type="text" v-model="book.author">

      <label for="book-isbn">isbn</label>
      <input name="book-isbn" type="text" v-model="book.isbn">

      <button type="button" name="submit-book" v-on:click="find_suggest">find</button>
    </form>
    <div class="suggests">
      <div class="suggest-item" v-for="book in suggests">
        <book-cell :book=book></book-cell>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'
import BookCell from '../components/BookCell'

export default {
  name: 'book-search',
  components: {
    BookCell,
  },
  computed: {
  },
  data () {
    return {
      book: {
        title: '',
        author: '',
        isbn: '',
      },
      suggests: Array,
    }
  },
  methods: {
    find_suggest () {
      let vm = this;
      axios
        .get(`https://www.googleapis.com/books/v1/volumes?q=${ vm.queryString() }`)
        .then((res) => {
          let items = res.data.items;
          vm.suggests = items.map((item) => {
            return {
              title: item.volumeInfo.title,
              author: item.volumeInfo.authors[0],
              isbn: item.volumeInfo.industryIdentifiers[0].identifier
            };
          });
        })
        .catch((e) => {
          console.log(e);
           vm.suggests = [
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'fizzbazz',
               author: 'bazzfizz',
               isbn: 'u6rt7iylu6drtyfuygi',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
             {
               id: null,
               title: 'foobar',
               author: 'barfoo',
               isbn: 'dftguyihojp',
             },
           ]
        })
    },
    queryElements () {
      return {
        intitle: this.book.title,
        inauthor: this.book.author,
        isbn: this.book.isbn,
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
  flex-direction: row
  flex-wrap: wrap

@media(max-width: 600px)
  .suggest-item
    width: percentage(1 / 3)

@media(min-width: 600px)
  .suggest-item
    width: percentage(1 / 4)

</style>
