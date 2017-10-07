<template>
  <div class="book-cell--root">
    <div class="frame book-cell--frame" v-bind:class="{ 'frame__selected': selected }">
      <div class="book-cell--information">
        <div class="book-cell--image-area">
          <img v-bind:src="book.image_url" class="book-cell--image">
        </div>
        <div class="book-cell--text">
          <md-list>
            <md-list-item>
              <md-icon>book</md-icon>
              <span>{{ book.title }}</span>
            </md-list-item>
            <md-list-item>
              <md-icon>create</md-icon>
              <span>{{ book.author }}</span>
            </md-list-item>
            <div v-if="book.shelf">
              <md-list-item>
                <span>{{ book.shelf.name }} にあります</span>
              </md-list-item>
            </div>
            <div v-if="book.checking_out">
              <md-list-item>
                <md-icon>lock</md-icon>
                <span>現在 {{ book.checking_out.user.name }} が利用中</span>
              </md-list-item>
            </div>
            <div v-else>
              <md-list-item>
                <md-icon>lock_open</md-icon>
                <span>貸出可</span>
              </md-list-item>
            </div>
          </md-list>
          <div class="book-cell--controls">
            <slot></slot>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'book-cell',
  props: {
    book: {},
    selected: Boolean,
    selectable: Boolean,
  },
}
</script>

<style scoped lang="sass" prefix="book-cell--">
.book-cell--root
  padding: 0.5em
  width: 100%

.book-cell--frame
  display: flex
  flex-direction: column

.frame
  padding: 1em
  box-shadow: 3px 3px 6px 2px #CCCCCC

  &__selected
    box-shadow: 2px 2px 10px 4px #6f79cc

.book-cell--information
  display: flex
  flex-direction: row

.book-cell--image
  background-color: gray
  flex: 3
  height: 40vw

.book-cell--text
  flex: 6
  padding: 2%

.book-cell--controls


</style>
