<template>
  <div class="layout--root"
       v-if="book !== undefined && book.length != 0" >
    <img :src="book.image_url" class="layout--background">
    <div class="layout--content">
      <div class="titles">
        <h3>
          <md-icon>book</md-icon>
          <span>{{ book.title }}</span>
        </h3>
      </div>
      <slot></slot>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'single-book-layout',
    props: {
      book: Object,
    },
  }
</script>

<style scoped lang="sass">
  .layout--root
    display: grid
    grid-template-rows: auto
    height: -webkit-fill-available

  .layout--content
    grid-row: 6/6
    background-color: white
    opacity: 0.95
    padding: 2em
    border-top-style: solid
    border-top-width: 1px
    border-top-color: #ccc
  .layout--background
    width: 100%
    position: fixed
    top: 0
    left: 0
    right: 0
    z-index: -10
</style>
