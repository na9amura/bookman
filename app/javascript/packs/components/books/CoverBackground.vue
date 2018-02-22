<template>
  <img v-bind:src="book.image_url" class="background--image">
</template>

<script>
  export default {
    name: 'cover-background',
    props: {
      book: Object,
    },
  }
</script>

<style scoped lang="sass">
  .background--image
    width: 100%
    position: fixed
    top: 0
    left: 0
    right: 0
    z-index: -10
</style>
