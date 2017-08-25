<template>
  <div>
    <book-web-search></book-web-search>

    <form id="register">
      <button type="button" name="submit-book" v-on:click="submitBook">Submit</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'
import BookWebSearch from '../pages/BookWebSearch'

export default {
  name: 'book-form',
  components: {
    BookWebSearch,
  },
  computed: {
  },
  data () {
    return {
      books: Books,
    }
  },
  methods: {
    submitBook () {
      let vm = this
      axios
        .post(
          '/books.json',
          {
            book: this.books.state.new_request,
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          })
        .then((res) => { vm.loadBooks() })
    },
    loadBooks () {
      var vm = this;
      axios.get('/books.json')
        .then(function(res) {
          vm.books.state.list = res.data
        })
    },
  }
}
</script>
