<template>
  <div>
    <md-button
      class="md-raised md-primary"
      @click.stop="showShelves(book)"
      @click.right="showShelves(book)">
      本棚変更
    </md-button>
    <md-menu :ref="shelfMenuRef(book)">
      <span md-menu-trigger></span>
      <md-menu-content>
        <md-menu-item
          v-if="shelves.length"
          v-for="shelf in shelves"
          @click="assignShelf(index, book, shelf)"
          :key="shelf.id"
          :disabled="!selectableShelf(book, shelf)">
          {{ selectableShelf(book, shelf) ? '' : '* ' }}
          {{ shelf.name }}
        </md-menu-item>
      </md-menu-content>
    </md-menu>
  </div>
</template>

<script>
  export default {
    name: 'book-menu',
    props: {
      index: 0,
      book: Object,
      shelves: Array,
    },
    methods: {
      shelfMenuRef(book) {
        return `shelfMenu${ book.id }`
      },
      showShelves(book) {
        this.$refs[this.shelfMenuRef(book)][0].toggle()
      },
      assignShelf(index, book, shelf) {
        const vm = this
        axios
          .patch(
            `/books/${ book.id }.json`,
            { book: { shelf_id: shelf.id } }
          )
          .then((response) => {
            vm.books.state.list.splice(index, 1, response.data)
          })
      },
      selectableShelf(book, newShelf) {
        return book.shelf_id !== newShelf.id
      },
    }
  }
</script>
