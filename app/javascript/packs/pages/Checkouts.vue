<template>
  <div>
    <div class="checkout--books">
      <div class="checkout--book" v-for="book in books">
        <book-cell :book=book>
          <button type="button" v-on:click="checkIn(book)">Check In this book</button>
        </book-cell>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
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
      this.loadBook()
    },
    loadBook () {
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
          {
            id: book.checking_out.id,
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          }
        )
        .then((res) => {
          console.log(res)
          console.log(res.data)
        })
    },
  },
}
</script>

<style scoped>
.information {
  display: flex;
}

.image {
  flex-shrink: 6;
  background-color: gray;
  width: 100%;
}

.text {
  flex-shrink: 3;
  width: 100%;
  padding: 2%;
}

</style>
