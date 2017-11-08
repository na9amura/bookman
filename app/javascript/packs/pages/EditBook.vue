<template>
  <div>
    <img v-bind:src="book.image_url" class="bg">
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

  export default {
    name: 'edit-book',
    props: {
      id: Number,
      attrs: {
        type: Array,
        default: ['title', 'author', 'publisher_name'],
      }
    },
    components: {
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
  .bg
    width: 100%
    position: fixed
    top: 0
    left: 0
    right: 0
    z-index: -10
  .edit
    background-color: white
    opacity: 0.95
    padding: 2em
    margin-top: 20em
    height: 100em
    height: -webkit-fill-available
</style>
