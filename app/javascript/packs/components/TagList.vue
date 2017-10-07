<template>
  <div>
    <div v-show="tags">
      <div v-for="tag in tags">
        <md-button
          class="md-raised md-primary">
          {{ tag.name }}
        </md-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'tag-list',
  props: {
    tags: Array
  },
}
</script>
