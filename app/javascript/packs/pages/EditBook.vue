<template>
  <div>
    <cover-background :book="book"></cover-background>
    <div class="edit">
      <h2>
        Edit {{ book.title }}
      </h2>
      <text-box
        v-for="name in attrs"
        :target="book"
        :attr_name="name">
      </text-box>
      <md-button
        @click="update()">
        保存
      </md-button>
    </div>
  </div>
</template>

<script>
  import TextBox from '../components/form/TextBox'
  import CoverBackground from '../components/books/CoverBackground'

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
      CoverBackground,
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
  .edit
    background-color: white
    opacity: 0.95
    padding: 2em
    margin-top: 20em
    height: 100em
    height: -webkit-fill-available
</style>
