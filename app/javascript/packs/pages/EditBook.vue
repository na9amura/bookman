<template>
  <div>
    <img v-bind:src="book.image_url" class="bg">
    <div class="edit">
      <h2>
        Edit {{ book.title }}
      </h2>
      <md-input-container>
        <label>title</label>
        <md-input v-model="book.title"></md-input>
      </md-input-container>
      <md-input-container>
        <label>author</label>
        <md-input v-model="book.author"></md-input>
      </md-input-container>
      <md-input-container>
        <label>publisher_name</label>
        <md-input v-model="book.publisher_name"></md-input>
      </md-input-container>
      <md-button
        @click="update()">
        保存
      </md-button>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'edit-book',
    props: {
      id: Number
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
