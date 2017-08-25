<template>
  <div class="root">
    <div class="frame" v-bind:class="{ frame__selected: selected }">
      <div class="image"></div>
      <div class="information">
        <h5 class="title">
          {{ book.title }}
        </h5>
        <div class="author">
          著者：{{ book.author }}
        </div>
        <div class="isbn">
          [{{ book.isbn }}]
        </div>
      </div>
      <div class="buttons">
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

<style scoped lang="sass">
.root
  padding: 0.5em
  width: 100%
  display: flex
  flex-direction: column

.frame
  padding: 1em
  box-shadow: 3px 3px 6px 2px #CCCCCC

  &__selected
    box-shadow: 2px 2px 10px 4px #6f79cc

.image
  background-color: gray
  height: 100%
  flex: 3

.explanation
  width: 100%
  padding: 2%
</style>
