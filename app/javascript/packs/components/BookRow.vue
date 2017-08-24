<template>
  <div class="book-row-root">
    <router-link
      :to="{ name: 'book', params: { id: book.id } }"
      class="book-row">
      <div class="image">

      </div>
      <div class="explanation">
        <h3 class="title">
          {{ book.title }}
        </h3>
        <div class="information">
          <div class="author">
            著者：{{ book.author }}
          </div>
          <div class="isbn">
            [{{ book.isbn }}]
          </div>
        </div>
      </div>
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'book-row',
  props: {
    book: {},
  },
}
</script>

<style scoped>
.book-row-root {
  padding-bottom: 3%;
}

.book-row {
  display: flex;
  padding: 2%;
  box-shadow: 3px 3px 6px 2px #CCCCCC
}

.image {
  flex-shrink: 6;
  background-color: gray;
  width: 100%;
}

.explanation {
  flex-shrink: 3;
  width: 100%;
  padding: 2%;
}

</style>
