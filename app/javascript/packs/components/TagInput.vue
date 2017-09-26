<template>
  <div class="tags--root">
    <div class="tags--current">
      <md-chip
        v-for="tag in book.tags"
        :key="tag.id"
        md-deletable
        @delete="removeTag(tag)">
        {{ tag.name }}
      </md-chip>
    </div>
    <md-input-container>
      <label>Tags for {{ book.title }}</label>
      <md-autocomplete
        :list="suggests"
        :min-chars="2"
        @keydown.native.prevent.enter="addTag"
        @keydown.native.prevent.tab="addTag"
        v-model="newTag">
      </md-autocomplete>
    </md-input-container>
  </div>
</template>

<script>
export default {
  name: 'tag-input',
  props:  {
    book: Object,
  },
  data () {
    return {
      suggests: [{ name: 'foo', value: '1' }, { name: 'bar', value: '2' }],
      newTag: '',
    }
  },
  methods: {
    addTag() {
      this.$emit('add-tag', this.newTag)
      this.newTag = ''
    },
    removeTag(selected) {
      this.$emit('remove-tag', selected.id)
    }
  },
}
</script>

<style scoped lang="sass">
  .tags--root
    display: flex

  .tags--current
    width: 100%
    margin: 4px 0 24px
    padding-top: 16px

</style>
