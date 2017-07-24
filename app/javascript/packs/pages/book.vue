<template>
  <div>
    <p>{{ book.id }}: {{ book.name }}</p>
  </div>
</template>

<script>
export default {
  name: 'book',
  props: {
    book: {},
  },
}
</script>
