<template>
  <div>
    <md-button
      class="md-raised md-primary"
      @click.stop="showMenu('topMenu')"
      @click.right="showMenu('topMenu')">
      Menu
    </md-button>
    <md-menu ref="topMenu" :md-close-on-select="false">
      <span md-menu-trigger></span>
      <md-menu-content>
        <md-menu-item @click="editBook">登録内容編集</md-menu-item>
        <md-menu-item @click="deleteBook">本を削除</md-menu-item>
        <md-menu-item @click="showMenu('shelfMenu')">本棚変更</md-menu-item>
        <md-menu ref="shelfMenu" md-offset-x="176" md-offset-y="-36">
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
    computed: {
      selectableShelves () {
        return this.shelves.filter((shelf) => this.book.shelf_id !== shelf.id)
      }
    },
    methods: {
      showMenu(refName) {
        this.$refs[refName].toggle()
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
      editBook() {
        console.log('Edit Book')
      },
      deleteBook() {
        console.log('Delete Book')
      },
    }
  }
</script>
