<template>
  <div>
    <router-link :to="{ name: 'book', params: { id: book.id } }">
      {{ book.id }}: {{ book.title }} / {{ book.author }} [{{ book.isbn }}]
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
