<template>
  <div class="book-cell--root">
    <div class="frame book-cell--frame" v-bind:class="{ 'frame__selected': selected }">
      <div class="book-cell--information">
        <div class="book-cell--image"></div>
        <div class="book-cell--text">
          <h5 class="book-cell--title">
            {{ book.title }}
          </h5>
          <div class="book-cell--author">
            著者：{{ book.author }}
          </div>
          <div class="book-cell--isbn">
            [{{ book.isbn }}]
          </div>
        </div>
      </div>
      <div class="book-cell--controls">
        <slot></slot>
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
