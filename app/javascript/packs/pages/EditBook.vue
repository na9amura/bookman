<template>
  <div>
    <h2>
      Edit {{ book.title }}
    </h2>
    <md-input-container>
      <label>title</label>
      <md-input v-model="book.title"></md-input>
    </md-input-container>
    <md-input-container>
      <label>publisher_name</label>
      <md-input v-model="book.publisher_name"></md-input>
    </md-input-container>
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
    },
  }
</script>

<style scoped lang="sass">
</style>
