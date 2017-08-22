<template>
  <div class="root">
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
  </div>
</template>

<script>
export default {
  name: 'book-cell',
  props: {
    book: {},
  },
}
</script>

<style scoped lang="sass">
.root
  padding: 0.5em
  width: 100%
  display: flex
  flex-direction: column

.image
  background-color: gray
  height: 100%
  flex: 3

.explanation
  width: 100%
  padding: 2%
</style>
