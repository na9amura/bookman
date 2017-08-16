<template>
  <div>
    <div v-if="book !== undefined && book.length != 0">
      <div class="titles">
        <h2>{{ book.title }}</h2>
        <h3>著者：{{ book.author }}</h3>
      </div>
      <div class="information">
        <div class="image"></div>
        <div class="text">
          <div class="text--title">
            ISBN
          </div>
          <div class="text--content">
            {{ book.isbn }}
          </div>
        </div>
      </div>
      <div class="checkouts">
        <button type="button" v-on:click="checkout"></button>
      </div>
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
