<template>
  <div>
    <div>
      <label v-bind:id="id">{{ title }}</label>
      <input
        v-bind:id="id"
        v-model="text"
        v-on:input="changeText()"
        />
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
  methods: {
    changeText () {
      this.$emit('changeText', this.$props.id, this.$data.text)
    }
  },
}
</script>
