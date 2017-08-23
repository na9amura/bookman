<template>
  <div>
    <web-search></web-search>
  </div>
</template>

<script>
import Books from '../models/global/books'
import WebSearch from '../components/WebSearch'

export default {
  name: 'book-web-search',
  components: {
    WebSearch,
  },
  data () {
    return {
      books: Books,
      suggests: Array,
    }
  },
}
</script>

<style scoped lang="sass">
.suggests
  display: flex
  flex-direction: row
  flex-wrap: wrap

@media(max-width: 600px)
  .suggest-item
    width: percentage(1 / 3)

@media(min-width: 600px)
  .suggest-item
    width: percentage(1 / 4)

</style>
