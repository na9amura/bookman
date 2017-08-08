<template>
  <div>
    <form id="register">
      <label for="book-title">title</label>
      <input name="book-title" type="text" v-model="book.title">

      <label for="book-author">author</label>
      <input name="book-author" type="text" v-model="book.author">

      <label for="book-isbn">isbn</label>
      <input name="book-isbn" type="text" v-model="book.isbn">

      <!-- <input type="hidden" v-model="book.csrf-token" :value="document.getElementsByName('csrf-token')[0].content"> -->

      <button type="button" name="submit-book" v-on:click="submitBook">Submit</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'

export default {
  name: 'book-form',
  data () {
    return {
      book: {
        title: '',
        author: '',
        isbn: '',
      },
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
            book: this.book,
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          })
        .then((response) => { vm.loadBooks() })
    },
    loadBooks () {
      var vm = this
      axios.get('/books.json')
        .then(function(response) {
          vm.books.state.list = response.data
        })
    },
  }
}
</script>
