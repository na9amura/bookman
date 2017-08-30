<template>
  <div>
    <div class="checkout--books">
      <div class="checkout--book" v-for="book in books">
        <book-cell :book=book>
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
  created: function() {
    this.init()
  },
  methods: {
    init: function() {
      this.loadBook()
    },
    loadBook: function() {
      let vm = this
      axios.get(`/checkouts.json`)
        .then((response) => {
          vm.books = response.data
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
