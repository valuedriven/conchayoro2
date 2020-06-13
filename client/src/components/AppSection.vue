<template>
  <div>    

  <router-view></router-view>

  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  components: {
  },
  props: {
  },
  computed: { 
    ...mapGetters ({
    })
  },
  data() {
    return {
    }    
  }
};
</script>

<style scoped>
.fade-view-enter, .fade-view-leave-to {
  opacity: 0;
}
.fade-view-enter-active, .fade-view-leave-active {
  transition: opacity 0.5s ease-in-out;
}

</style>