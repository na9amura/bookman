<template>
  <div class="dialog--overlay">
    <div class="dialog--box">
      <h3 class="dialog--title">{{ title }}</h3>
      <div class="dialog--message">{{ message }}</div>
      <div class="dialog--close" @click="close">Close</div>
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
