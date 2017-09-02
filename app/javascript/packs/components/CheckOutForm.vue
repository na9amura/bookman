<template>
  <div>
    <button type="button" v-on:click="checkout">Check out</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'check-out-form',
  props: {
    book: Object
  },
  methods: {
    checkout () {
      let vm = this
      axios
        .post(
          '/checkouts.json',
          {
            book: { id: vm.book.id },
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          }
        )
        .then((res) => {
          // TODO
          console.log(res)
        })
        .catch((e) => {
          console.log(e.response)
        })
    },
  },
}
</script>
