<template>
  <header>
    <div class="container">
      <nav class="navbar navbar-expand">
        <a href="#" class="link navbar-brand mr-auto">Conchayoro</a>

        <div class="links mr-2">
          <router-link class="btn mr-5" v-if="isLogged" to="/">Início</router-link>
          <router-link class="btn mr-5" v-if="isLogged" to="/produtos">Produtos</router-link>
          <router-link class="btn mr-5" v-if="isLogged" to="/arquivos">Arquivos</router-link>
          <a class="btn mr-5" v-if="isLogged" @click.prevent="logout">Logout</a> 
        </div>
      </nav>
    </div>
  </header>
</template>

<script>

export default {
  methods: {
    logout() {
      this.$store.dispatch("logout");
      this.$router.push("/login");
    }
  },
  computed: {
    isLogged() {
      return this.$store.getters.isLogged;
    }
  }
};
</script>

<style scoped>
header {
  background-color: #000;
}
#logo {
  width: 150px;
  height: 100%;
}
.links {
  display: inline-flex;
}
.link {
  color: #fff;
  font-size: 30px;
  font-family: "Rajdhani";
}

.links a {
  color: #fff;
}
.link-active {
  background-color: #fff !important;
  color: #000 !important;
}
.links a:focus {
  outline: none !important;
  box-shadow: none !important;
}
</style>