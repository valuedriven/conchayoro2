<template>
  <div id="app">
    <AppHeader />
    <AppSection />
    <AppFooter />

  </div>
</template>

<script>
import AppHeader from './components/AppHeader'
import AppSection from './components/AppSection'
import AppFooter from './components/AppFooter'

export default {
  name: 'App',
  components: {
    AppHeader,
    AppSection,
    AppFooter
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Rajdhani&display=swap');
@import url('https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900');
@import url('https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css');
</style>

