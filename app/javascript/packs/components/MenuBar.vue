<template>
  <div>
    <md-toolbar class="md-fixed">
      <md-button class="md-icon-button" @click="toggleSidenav">
        <md-icon>menu</md-icon>
      </md-button>
      <h1>Bookman</h1>
    </md-toolbar>

    <md-sidenav class="md-left" ref="leftSidenav" >
      <md-toolbar class="md-fixed">
        <router-link :to='{ path: "/" }' v-on:click.native="toggleSidenav">
          <h1>Bookman</h1>
        </router-link>
      </md-toolbar>

      <md-list>
        <md-list-item>
          <router-link :to="{ name: 'book_form'}" v-on:click.native="toggleSidenav">
            <md-icon>play_for_work</md-icon>
            <span>Register New Books</span>
          </router-link>
        </md-list-item>

        <md-list-item>
          <router-link :to="{ name: 'checkouts'}" v-on:click.native="toggleSidenav">
            <md-icon>book</md-icon>
            <span>My Checkouts</span>
          </router-link>
        </md-list-item>
      </md-list>
    </md-sidenav>
  </div>
</template>

<script>

  export default {
    name: 'menu-bar',
    methods: {
      toggleSidenav() {
        this.$refs.leftSidenav.toggle();
      },
    },
  }
</script>
