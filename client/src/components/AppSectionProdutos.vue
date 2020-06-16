<template>
  <section>
    <div class="container">
      <v-app id="app">
      <v-data-table :headers="headers" :items="produtos" sort-by="nome" class="elevation-1">
        <template v-slot:top>
          <v-toolbar flat color="white">
            <v-toolbar-title>{{ formTitle }}</v-toolbar-title>
            <v-divider class="mx-4" inset vertical></v-divider>
            <v-spacer></v-spacer>
            <v-dialog v-model="dialog" max-width="500px">
              <template v-slot:activator="{ on, attrs }">
                <v-btn color="primary" dark class="mb-2" v-bind="attrs" v-on="on">{{ newItem }}</v-btn>
              </template>
              <v-card>
                <v-card-title>
                  <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-row>                      
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.nome" label="Nome do Produto"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.unidade" label="Unidade"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.tipoProduto" label="Tipo do Produto"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.precoUnitario" label="Preço Unitário"></v-text-field>
                      </v-col>                      
                    </v-row>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text @click="close">{{ cancelButton }}</v-btn>
                  <v-btn color="blue darken-1" text @click="save">{{ saveButton }}</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
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
    newItem: 'Novo Produto',
    cancelButton: 'Cancelar',
    saveButton: 'Salvar',
    hostService: 'produtos',
    search: 'nome',
    dialog: false,
    headers: [
      {
        text: "Nome do Produto",
        align: "start",
        sortable: true,        
        value: "nome", 
        editable: true
      },
      { text: "Unidade", value: "unidade" },
      { text: "Tipo de Produto", value: "tipoProduto" },
      { text: "Preço Unitário", value: "precoUnitario", sortable: false },
      { text: "Ações", value: "actions", sortable: false }
    ],
    produtos: [],
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
    fetchProdutos() {
      axios.get("/"+this.hostService).then(response => {
        console.log(response);
        this.produtos = response.data;
      });
    },

    initialize() {
      this.fetchProdutos();
    },

    editItem(item) {
      this.editedIndex = this.produtos.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      const index = this.produtos.indexOf(item);
      confirm("Confirma a deleção do item?") && 
        this.produtos.splice(index, 1);
      axios.delete(`/${this.hostService}/${item.id}`);

    },

    close() {
      this.dialog = false;
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      });
    },

    save() {
      if (this.editedIndex > -1) {
        axios
          .put(`/${this.hostService}/${this.editedItem.id}`, {
            nome: this.editedItem.nome,
            unidade: this.editedItem.unidade,
            tipoProduto: this.editedItem.tipoProduto,
            precoUnitario: this.editedItem.precoUnitario
          })
          .then(response => {
            console.log(response);
          });
        Object.assign(this.produtos[this.editedIndex], this.editedItem);
      } else {
        axios
          .post(`/${this.hostService}`, {
            nome: this.editedItem.nome,
            unidade: this.editedItem.unidade,
            tipoProduto: this.editedItem.tipoProduto,
            precoUnitario: this.editedItem.precoUnitario
          })
          .then(response => {
            console.log(response);
          });
        this.produtos.push(this.editedItem);
      }
      this.close();
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