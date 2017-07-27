<template>
  <div>
    <div v-if="book !== undefined && book.length != 0">
      <p>{{ book.id }}: {{ book.name }}</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'book',
  props: {
    id: Number,
  },
  data: () => {
    return {
      book: {},
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
      axios.get(`/books/${ vm.id }.json`)
        .then((response) => {
          vm.book = response.data
        })
    },
  },
}
</script>
