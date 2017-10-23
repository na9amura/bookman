<template>
  <div>
    <div class="dialog--overlay"></div>
    <div class="dialog--wrap">
      <div class="dialog--box">
        <h3 class="dialog--title">{{ title }}</h3>
        <div class="dialog--message">{{ message }}</div>
        <md-button @click="close">Close</md-button>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'dialog',
    props: {
      title: String,
      message: String,
    },
    methods: {
      removeDialog() {
        this.$el.parentNode.removeChild(this.$el)
      },
      open() {
        document.body.appendChild(this.dialogElement)
      },
      close() {
        this.removeDialog()
      },
    },
    mounted() {
      this.dialogElement = this.$el
      this.removeDialog()
    }
  }
</script>

<style lang="sass" scped>
  .dialog
    &--overlay
      z-index: 100
      position: fixed
      top: 0
      right: 0
      bottom: 0
      left: 0
      background-color: #ccc
      opacity: 0.5
    &--wrap
      z-index: 101
      display: flex
      flex-flow: column
      justify-content: center
      align-items: center
      position: fixed
      top: 0
      right: 0
      bottom: 0
      left: 0
    &--box
      z-index: 102
      background-color: white
      opacity: 1
      position: relative
      min-width: 300px
      max-width: 80%
      max-height: 80%


</style>
