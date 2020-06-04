<template>
  <v-data-table
    :headers="headers"
    :items="tutorials"
    sort-by="title"
    class="elevation-1"
  >
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Tutorials</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">New Item</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.title" label="Title"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.description" label="Description"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.published" label="Published"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="save">Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.actions="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        small
        @click="deleteItem(item)"
      >
        mdi-delete
      </v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>
  </v-data-table>
</template>

<script>
import axios from "../http-common";

export default {
  data: () => ({
    //search: "",
    dialog: false,
    headers: [
      { text: "Title", value: "title" },
      { text: "Description", value: "description" },
      { text: "Published", value: "published" },
      { text: "Actions", value: "actions", sortable: false }
    ],
    tutorials: [],
    editedIndex: -1,
    editedItem: {
      title: "",
      description: "",
      published: false
    },
    defaultItem: {
      title: "",
      description: "",
      published: false
    }
  }),

  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
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
    fetchTutorials() {
      axios.get("/tutorials").then(response => {
        console.log(response);
        this.tutorials = response.data;
      });
    },

    initialize() {
      this.fetchTutorials();
    },

    editItem(item) {
      this.editedIndex = this.tutorials.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      const index = this.tutorials.indexOf(item);
      confirm("Are you sure you want to delete this item?") &&
        this.tutorials.splice(index, 1);
      axios.delete("/tutorials/" + item.id);
    },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },

    save() {
      if (this.editedIndex > -1) {
        axios
          .put("/tutorials/" + this.editedItem.id, {
            title: this.editedItem.title,
            description: this.editedItem.description
          })
          .then(response => {
            console.log(response);
          });
        Object.assign(this.tutorials[this.editedIndex], this.editedItem);
      } else {
        axios
          .post("/tutorials", {
            title: this.editedItem.title,
            description: this.editedItem.description
          })
          .then(response => {
            console.log(response);
          });
        this.tutorials.push(this.editedItem);
      }
      this.close();
    }
  }
};
</script>
