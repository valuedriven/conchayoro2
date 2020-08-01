<template>
  <section>
    <div class="container">
      <v-app id="app">
      <v-data-table :headers="headers" :items="arquivos" class="elevation-1">
        <template v-slot:top>
          <v-toolbar flat color="white">
            <v-toolbar-title>{{ formTitle }}</v-toolbar-title>
            <v-divider class="mx-4" inset vertical></v-divider>
            <v-spacer></v-spacer>
          </v-toolbar>
        </template>
        <template v-slot:item.actions="{ item }">
          <v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
          <v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
        </template>
        <template v-slot:no-data>
          <v-btn color="primary" @click="initialize">Reset</v-btn>
        </template>
      </v-data-table>
      </v-app>
    </div>
  </section>
</template>

<script>
import axios from "../axios";

export default {
  data: () => ({    
    newItem: 'Arquivos',
    cancelButton: 'Cancelar',
    hostService: 'arquivos',
    search: 'nome',
    dialog: false,
    headers: [
      { text: "Key", align: "start", value: "Key"},
      { text: "LastModified", value: "LastModified"},
      { text: "ETag", value: "ETag"},
      { text: "Size", value: "Size"},
      { text: "StorageClass", value: "StorageClass"}
    ],
    arquivos: [],
    editedIndex: -1,
    editedItem: {
      nome: '',
      unidade: '',
      tipoProduto:'',
      precoUnitario: 0
    },
    defaultItem: {
      nome: '',
      unidade: '',
      tipoProduto:'',
      precoUnitario: 0
    }
  }),

  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "Novo Item" : "Editar Item";
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  created() {
    this.initialize();
  },

  methods: {
    fetchArquivos() {
      axios.get(`/${this.hostService}/listar`).then(response => {
        const temp = response.data;
        console.log(temp);
        this.arquivos = temp.Coontents;
        console.log(this.arquivos);
      });
    },

    initialize() {
      this.fetchArquivos();
    },

    editItem(item) {
      this.arquivos.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },
    close() {
      this.dialog = false;
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      });
    }
  } 

};
</script>

<style scoped>
section {
  margin-top: 25px;
}

.container .row {
  height: 300px;
}

.container .row .col-5:first-child {
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
  /*background-color: rgba(0, 0, 0, 0.4); */
  padding: 10px;
}

.principal-news {
  cursor: pointer;
}
</style>