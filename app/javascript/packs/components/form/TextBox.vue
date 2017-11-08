<template>
  <md-input-container>
    <label>{{ attr_name }}</label>
    <md-input
      v-model="target[attr_name]">
    </md-input>
  </md-input-container>
</template>

<script>
  export default {
    name: 'text-box',
    props: {
      target: '',
      attr_name: '',
    },
  }
</script>
