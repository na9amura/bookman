<template>
  <div>
    <div class="checkout--books">
      <div class="checkout--book" v-for="book in books">
        <book-cell :book=book>
          <md-button
            class="md-raised md-accent"
            v-on:click="checkIn(book)">
            Check In
          </md-button>
        </book-cell>
      </div>
    </div>
  </div>
</template>

<script>
import BookCell from '../components/BookCell'

export default {
  name: 'checkouts',
  components: {
    BookCell,
  },
  props: {
  },
  data: () => {
    return {
      books: {},
    }
  },
  created () {
    this.init()
  },
  methods: {
    init () {
      this.loadMyBooks()
    },
    loadMyBooks () {
      let vm = this;
      axios.get('/checkouts.json')
        .then((response) => {
          vm.books = response.data
        })
    },
    checkIn (book) {
      let vm = this;
      axios
        .post(
          '/checkins.json',
          { id: book.checking_out.id }
        )
        .then((res) => {
          vm.books = vm.books.filter((book) => !(book.id === res.data.book_id))
        })
    },
  },
}
</script>
