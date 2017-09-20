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
          <md-list>
            <md-list-item>
              <md-icon>book</md-icon>
              <span>{{ book.title }}</span>
            </md-list-item>
            <md-list-item>
              <md-icon>create</md-icon>
              <span>{{ book.author }}</span>
            </md-list-item>
            <md-list-item>
              <md-icon>fingerprint</md-icon>
              <span>{{ book.isbn }}</span>
            </md-list-item>
            <md-list-item>
              <md-icon>tags</md-icon>
              <tag-list :tags=book.tags ></tag-list>
            </md-list-item>
            <div v-if="book.shelf">
              <md-list-item>
                <md-icon>view_column</md-icon>
                <span>{{ book.shelf.name }} にあります</span>
              </md-list-item>
            </div>
            <check-out-form :book=book></check-out-form>
          </md-list>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import CheckOutForm from '../components/CheckOutForm'
import TagList from '../components/TagList'

export default {
  name: 'book',
  components: {
    CheckOutForm,
    TagList,
  },
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
