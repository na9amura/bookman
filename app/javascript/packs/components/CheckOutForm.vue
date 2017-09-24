<template>
  <div>
    <div v-if="book.checking_out">
      <md-list-item>
        <md-icon>lock</md-icon>
        <span>現在 {{ book.checking_out.user.name }} が利用中</span>
      </md-list-item>
    </div>
    <div v-else>
      <md-list-item>
        <md-icon>lock_open</md-icon>
        <span>貸出可</span>
        <md-button
          class="md-raised md-primary"
          v-on:click="checkout">
          Check out
        </md-button>
      </md-list-item>
    </div>
  </div>
</template>

<script>
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
          { book: { id: vm.book.id } }
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
