<template>
  <div>
    <p>{{ book.id }}: {{ book.name }}</p>
  </div>
</template>

<script>
export default {
  props: {
    book: {},
  },
}
</script>
