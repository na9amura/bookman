<template>
  <div>
    <menu-bar></menu-bar>

    <div class="main-content">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  import MenuBar from "./components/MenuBar.vue";

  export default {
    name: 'app',
    components: {
      MenuBar,
    },
}
</script>

<style scoped lang="sass">
</style>
