<template>
  <div>
    <md-button
      class="md-raised md-primary"
      @click.stop="open"
      @click.right="open">
      Menu
    </md-button>
    <md-menu ref="menu" :md-close-on-select="false">
      <span md-menu-trigger></span>
      <md-menu-content>
        <md-menu-item>
          <router-link :to="{ name: 'book', params: { id: book.id } }">
            詳細を見る
          </router-link>
        </md-menu-item>
        <md-menu-item>
          <router-link :to="{ name: 'edit-book', params: { id: book.id } }">
            登録内容編集
          </router-link>
        </md-menu-item>
        <md-menu-item @click="deleteBook">本を削除</md-menu-item>
        <md-menu-item @click="openSubMenu('shelfMenu')">本棚変更</md-menu-item>
        <shelf-menu :book="book" :shelves="shelves" ref="shelfMenu"></shelf-menu>
      </md-menu-content>
    </md-menu>
  </div>
</template>

<script>
  import Books from '../../models/global/books'
  import ShelfMenu from './ShelfMenu'

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
    components: {
      ShelfMenu,
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
      openSubMenu(refName) {
        this.$refs[refName].open()
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
