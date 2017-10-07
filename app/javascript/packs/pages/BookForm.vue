<template>
  <div>
    <web-search></web-search>

    <md-button
      class="md-raised md-accent"
      v-on:click="submitBook">
      Submit
    </md-button>
  </div>
</template>

<script>
import axios from 'axios'
import Books from '../models/global/books'
import WebSearch from '../components/WebSearch'

export default {
  name: 'book-form',
  components: {
    WebSearch,
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
