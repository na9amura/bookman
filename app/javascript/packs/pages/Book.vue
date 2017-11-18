<template>
  <single-book-layout :book="book">
    <div class="book--tags">
      <tag-input :book=book
                 @add-tag="addTag"
                 @remove-tag="removeTag">
      </tag-input>
    </div>
    <md-list>
      <check-out-form :book=book
                      @checkout="checkout">
      </check-out-form>
      <attribute v-for="name in attrs"
                 :book="book"
                 :attrName="name">
      </attribute>
    </md-list>
  </single-book-layout>
</template>

<script>
  import Attribute from '../components/books/Attribute'
  import CheckOutForm from '../components/CheckOutForm'
  import SingleBookLayout from '../components/books/SingleBookLayout'
  import TagList from '../components/TagList'
  import TagInput from '../components/TagInput'

  export default {
    name: 'book',
    components: {
      Attribute,
      CheckOutForm,
      SingleBookLayout,
      TagList,
      TagInput,
    },
    props: {
      id: Number,
      attrs: {
        type: Array,
        default: () => [
          'title',
          'author',
          'publisher_name',
          'isbn',
          ['shelf', 'name']
        ],
      }
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
  .book--tags
    padding-bottom: 1em

  .book--information-frame
    display: grid
    grid-template-rows: 10/10
    height: -webkit-fill-available

  .book--information
    grid-row: 6/6
    background-color: white
    opacity: 0.95
    padding: 2em
    border-top-style: solid
    border-top-width: 1px
    border-top-color: #ccc
</style>
