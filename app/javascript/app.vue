<template>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      app
      clipped
    >
      <v-list dense>
        <v-list-item
          v-for="item in items"
          :key="item.text"
          link
        >
        <v-list-item-content>
          <v-list-item-title>
            {{ item.text }}
          </v-list-item-title>
        </v-list-item-content>
        </v-list-item>
        <v-subheader class="mt-4 grey--text text--darken-1">Information</v-subheader>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      app
      clipped-left
      color="red"
      dense
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-icon
        class="mx-4"
        large
      >
        mdi-youtube
      </v-icon>
      <v-toolbar-title class="mr-12 align-center">
        <span class="title">Vue TODO</span>
      </v-toolbar-title>
      <v-spacer />
      <v-row
        align="center"
        style="max-width: 650px"
      >
        <v-text-field
          :append-icon-cb="() => {}"
          placeholder="Input TODO..."
          v-model="newItemTitle"
          v-on:keyup.enter="addTodo(newItemTitle)"
          single-line
          append-icon="mdi-magnify"
          color="white"
          hide-details
        />
      </v-row>
    </v-app-bar>

<v-content id="app">
  <v-container fluid>
  <v-row
    justify="start"
    align="start"
  >
    <v-list-item v-for="item in todo_items" :key="item.title">
      <v-list-item-content>
      <v-list-item-title>
      <label v-bind:class="{ done:item.isChecked }">
        <input type="checkbox" v-model="item.isChecked" v-on:change="saveTodo"> {{ item.title }}
      </label>

        <!--v-checkbox
          v-model= "item.isChecked"
          :label = "item.title"
          v-bind:class="{ done:item.isChecked }"
          v-on:change="saveTodo"
        ></v-checkbox-->
      </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-row>

  <v-btn color="red" v-on:click="deleteTodo()">チェック項目を削除</v-btn>
  </v-container>
</v-content>

<v-footer
  color="red"
  padless
>
  <v-row
    justify="center"
    align="center"
  >
    <v-btn
      v-for="link in links"
      :key="link"
      color="white"
      text
      rounded
      class="my-2"
    >
      {{ link }}
    </v-btn>
  </v-row>
</v-footer>

  </v-app>
</body>

</html>
</template>

<script>
  export default {
    props: {
      source: String,
    },

    created () {
      this.$vuetify.theme.dark = true
    },

    data: function () {
      return {
        drawer: null,
        items: [
          { text: 'LOG IN' },
          { text: '新着' },
          { text: '優先度' },
          { text: '自分の物だけ' },
        ],

        todo_items: [
            { title: 'todo1', isChecked: true },
            { title: 'todo2', isChecked: true },
            { title: 'todo3', isChecked: false },
        ],
        newItemTitle: '',

        links: [
          'Home',
          'Git Hub',
          'developer Blog',
        ],
      }
    },

    methods: {
      addTodo: function(newTitle){
        this.todo_items.push({
          title: newTitle,
          isChecked: false
        });
        this.newItemTitle = ''; //追加
        this.saveTodo(); //ブラウザに保存
      },

      deleteTodo: function(){
        this.todo_items = this.todo_items.filter(function (item) {
          return item.isChecked === false; //
        });
        this.saveTodo(); //ブラウザに保存
      },

      saveTodo: function(){
        localStorage.setItem('todo_items', JSON.stringify(this.todo_items));
      },

      loadTodo: function(){
        this.todo_items = JSON.parse( localStorage.getItem('todo_items') );
        if( !this.todo_items ){
          this.todo_items = [];
        }
      },
    },

    // 初期表示
    mounted: function(){
      this.loadTodo();
    },
  }
</script>

<style>
  .done { text-decoration: line-through; }
</style>