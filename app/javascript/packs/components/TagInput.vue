<template>
  <div>
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

    <div v-for="tag in book.tags" :key="tag.id">
      <md-chip md-deletable
        @delete="deleteTag(tag)">
        {{ tag.name }}
      </md-chip>
    </div>
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
    submit () {
      console.log('submit!')
    },
    input () {
      console.log('input!')
    },
    addTag() {
      console.log('add tag')
      this.$emit('add-tag', this.newTag)
      this.newTag = ''
    },
    deleteTag(selected) {
      console.log('delete!')
      this.tags = this.tags.filter((tag) => tag !== selected)
      // TODO: tell server
    }
  },
}
</script>
