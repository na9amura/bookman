<template>
  <div>
    <div>
      <label v-bind:id="id">{{ title }}</label>
      <input
        v-bind:id="id"
        v-model="text"/>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'text-box',
  props: {
    id: '',
    title: '',
  },
  data () {
    return {
      text: '',
    }
  },
  watch: {
    text (val) {
      this.$emit('update:text', val)
    }
  }
}
</script>
