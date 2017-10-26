<template>
  <div>
    <md-button
      class="md-raised md-primary"
      @click.stop="showShelves"
      @click.right="showShelves">
      本棚変更
    </md-button>
    <md-menu ref="menu">
      <span md-menu-trigger></span>
      <md-menu-content>
        <md-menu-item
          v-if="shelves.length"
          v-for="shelf in shelves"
          @click="assignShelf(index, shelf)"
          :key="shelf.id"
          :disabled="!selectableShelf(shelf)">
          {{ selectableShelf(shelf) ? '' : '* ' }}
          {{ shelf.name }}
        </md-menu-item>
      </md-menu-content>
    </md-menu>
  </div>
</template>

<script>
  import Books from '../../models/global/books'

  export default {
    name: 'book-menu',
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
    methods: {
      shelfMenuRef() {
        return `shelfMenu${ this.book.id }`
      },
      showShelves() {
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
