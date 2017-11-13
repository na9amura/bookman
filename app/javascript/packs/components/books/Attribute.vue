<template>
  <md-list-item>
    <label class="attribute--title">{{ this.title() }}</label>
    <span class="attribute--content">{{ this.content() }}</span>
  </md-list-item>
</template>

<script>
  export default {
    name: 'book-attribute',
    props: {
      book: Object,
      attrName: [String, Array],
    },
    methods: {
      content() {
        if (this.attrName.constructor.name === 'Array') {
          return _.get(this.book, this.attrName)
        } else {
          return this.book[this.attrName]
        }
      },
      title() {
        if (this.attrName.constructor.name === 'Array') {
          return this.attrName.join('_')
        } else {
          return this.attrName
        }
      }
    }
  }
</script>

<style scoped lang="sass">
  .attribute--title
    padding-right: 2em
    min-width: 10em

  .attribute--content
    flex: 1 1 auto
</style>
