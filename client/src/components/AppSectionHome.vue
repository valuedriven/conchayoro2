<template>

  <section>

    <div class="container">
       <div class="row">
           <div class="col-5 text-center principal-news">  
               <img class="imagem" :src="require(`@/assets/wine_picture.jpg`)" alt="Conchayoro">             
          </div>
          <div class="col-5 offset-2 text-center principal-news">
              <h2>Bem-vindo(a) {{ username }} !</h2>
              <h4>Aqui você encontra informações relativas à Vinícola ConchayOro (essa é original, a outra é falsa!!!)</h4>
          </div>

       </div>      
    </div>

  </section>
</template>

<script>
export default {   
  computed: {
    username() {
      return this.$store.getters.getUsername;
    }
  }
}
</script>

<style scoped>
section {
  margin-top: 25px;
}
.container .row {
  height: 300px;
}
.container .row .col-5:first-child .imagem{
  background-color: rgba(0, 0, 0, 0.5);
  background-repeat: no-repeat;
  background-size: 100%;
}

.container .row .col-5:nth-child(2) {
  background-size: 100%;
}

h2 {
  margin: 5% 0;
  color: rgba(114, 47, 55, 1);
  /*background-color: rgba(0, 0, 0, 0.4);*/
  padding: 10px;
}

.principal-news {
  cursor: default;
}
</style>