<template>
  <div>
    <a href=""></a>
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
