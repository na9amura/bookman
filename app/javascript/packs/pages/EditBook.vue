<template>
  <cover-background-layout :book="book">
    <text-box v-for="name in attrs"
              :target="book"
              :attr_name="name">
    </text-box>
    <md-button @click="update">保存</md-button>
  </cover-background-layout>
</template>

<script>
  import TextBox from '../components/form/TextBox'
  import CoverBackgroundLayout from '../components/books/CoverBackgroundLayout'

  export default {
    name: 'edit-book',
    props: {
      id: Number,
      attrs: {
        type: Array,
        default: () => ['title', 'author', 'publisher_name'],
      }
    },
    components: {
      CoverBackgroundLayout,
      TextBox,
    },
    data() {
      return {
        book: {},
      }
    },
    created() {
      this.init()
    },
    methods: {
      init() {
        this.loadBook()
      },
      loadBook() {
        let vm = this
        axios.get(`/books/${ vm.id }.json`)
          .then((response) => { vm.book = response.data })
      },
      update() {
        console.log('TODO implement update')
      },
    },
  }
</script>

<style scoped lang="sass">
</style>
