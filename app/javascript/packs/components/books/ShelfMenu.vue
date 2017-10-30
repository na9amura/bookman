<template>
  <md-menu ref="menu" md-offset-x="176" md-offset-y="-36">
    <span md-menu-trigger></span>
    <md-menu-content>
      <md-menu-item
        :disabled="true">
        移動先を選択
      </md-menu-item>
      <md-menu-item
        v-if="shelves.length"
        v-for="shelf in selectableShelves"
        @click="assignShelf(index, shelf)"
        :key="shelf.id"
        :disabled="!selectableShelf(shelf)">
        {{ shelf.name }}
      </md-menu-item>
    </md-menu-content>
  </md-menu>
</template>

<script>
  import Books from '../../models/global/books'

  export default {
    name: 'shelf-menu',
    props: {
      index: 0,
      book: Object,
      shelves: Array,
    },
    data() {
      return {
        books: Books,
      }
    },
    computed: {
      selectableShelves () {
        return this.shelves.filter((shelf) => this.book.shelf_id !== shelf.id)
      }
    },
    methods: {
      open() {
        this.$refs.menu.toggle()
      },
      assignShelf(index, shelf) {
        const vm = this
        axios
          .patch(
            `/books/${ this.book.id }.json`,
            { book: { shelf_id: shelf.id } }
          )
          .then((response) => {
            vm.books.state.list.splice(index, 1, response.data)
          })
      },
      selectableShelf(newShelf) {
        return this.book.shelf_id !== newShelf.id
      },
    }
  }
</script>
