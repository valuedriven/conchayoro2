<template>
  <v-app>
<v-toolbar>
    <v-toolbar-title><v-btn text :to="{name:'Home'}">{{ title }}</v-btn></v-toolbar-title>
   <v-spacer> </v-spacer>
    <v-toolbar-items class="hidden-sm-and-down">
       <v-btn text exact >
         <a href="/tutorials">Tutorial</a>
       </v-btn>       
    </v-toolbar-items>
  </v-toolbar>

  <router-view></router-view>  
  </v-app>
</template>

<script>
export default {
  name: 'App',
  data () {
    return {
      title: "PNEV Stack"
    }
  }
  
}
</script>