<template>
  <div
    v-if="book !== undefined && book.length != 0"
    class="book--information">
    <div class="book--image-area">
      <img v-bind:src="book.image_url" class="book--image">
    </div>
    <div class="text">
      <div class="titles">
        <h3>
          <md-icon>book</md-icon>
          <span>{{ book.title }}</span>
        </h3>
        <h3>
          <span>著者：{{ book.author }}</span>
          <span>出版社：{{ book.publisher_name }}</span>
        </h3>
      </div>
      <div class="book--tags">
        <tag-input
          :book=book
          v-on:add-tag="addTag"
          v-on:remove-tag="removeTag">
        </tag-input>
      </div>
      <md-list>
        <md-list-item>
          <md-icon>fingerprint</md-icon>
          <span>{{ book.isbn }}</span>
        </md-list-item>
        <div v-if="book.shelf">
          <md-list-item>
            <md-icon>view_column</md-icon>
            <span>{{ book.shelf.name }} にあります</span>
          </md-list-item>
        </div>
        <check-out-form
          :book=book
          @checkout="checkout">
        </check-out-form>
      </md-list>
    </div>
  </div>
</template>

<script>
  import CheckOutForm from '../components/CheckOutForm'
  import TagList from '../components/TagList'
  import TagInput from '../components/TagInput'

  export default {
    name: 'book',
    components: {
      CheckOutForm,
      TagList,
      TagInput,
    },
    props: {
      id: Number,
    },
    data: () => {
      return {
        book: {},
      }
    },
    created() {
      this.init()
    },
    methods: {
      init () {
        this.loadBook()
      },
      loadBook () {
        let vm = this
        axios.get(`/books/${ vm.id }.json`)
          .then((response) => {
            vm.book = response.data
          })
      },
      addTag(tagName) {
        let vm = this
        axios
          .post(
            `/books/${ vm.id }/tags.json`,
            { tag: {name: tagName} },
          )
          .then((response) => {
            const tag = response.data.tag
            vm.book.tags.push(tag)
          })
      },
      removeTag(tagId) {
        let vm = this
        axios
          .delete(`/books/${ vm.id }/tags/${ tagId }.json`)
          .then((response) => {
            const removed = response.data.tag
            vm.book.tags = vm.book.tags.filter((tag) => tag.id !== removed.id)
          })
      },
      checkout() {
        this.loadBook()
      }
    },
  }
</script>

<style scoped lang="sass">
.information
  display: flex

.text
  flex-shrink: 3
  width: 100%
  padding: 2%

.book

  &--image-area
    flex-shrink: 6
    background-color: gray
    width: 100%

  &--image
    width: 100%

  &--tags
    padding-bottom: 1em
</style>
