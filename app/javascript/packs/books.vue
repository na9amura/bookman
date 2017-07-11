<template>
  <div>
    <div v-for="book in books">
      <book :book=book></book>
    </div>
  </div>
</template>

<script>
import Book from './book.vue'

export default {
  data: function () {
    return {
      books: [
        {
          id: 1,
          name: 'foo',
        },
        {
          id: 2,
          name: 'bar',
        }
      ],
    }
  },
  components: { Book }
}
</script>
