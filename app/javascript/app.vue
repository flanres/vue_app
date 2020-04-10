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
        <v-subheader class="mt-4 grey--text text--darken-1">INFO</v-subheader>
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
          placeholder="Search TODO..."
          single-line
          append-icon="mdi-magnify"
          color="white"
          hide-details
        />
      </v-row>
    </v-app-bar>

<v-content id="app">
  <p>
  <input type="text"
    placeholder="TODOを入力"
    v-model="newItemTitle"
    v-on:keyup.enter="addTodo(newItemTitle)">
  </p>

  <v-container fluid fill-height>
  <v-row
    justify="center"
    align="center"
  >

  <ul>
    <li v-for="item in todo_items" :key="item.title">
      <label v-bind:class="{ done: item.isChecked }">
        <input type="checkbox" v-model="item.isChecked"> {{ item.title }}
      </label>
    </li>
  </ul>

  </v-row>
        <!--v-layout wrap>
          <v-flex xs12 sm6 md4>コンテンツ</v-flex>
          <v-flex xs12 sm6 md4>コンテンツ</v-flex>
          <v-flex xs12 sm6 md4>コンテンツ</v-flex>
        </v-layout-->
  </v-container>
</v-content>

<v-footer color="red" dark app>
  Vuetify
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
          { text: '新着' },
          { text: '優先度' },
          { text: '自分の物だけ' },
        ],

        todo_items: [
            { title: 'test1', isChecked: true },
            { title: 'test2', isChecked: true },
            { title: 'test3', isChecked: false },
            { title: 'test4', isChecked: false },
        ],
        newItemTitle: ''
      }
    },

    methods: {
      addTodo: function(newTitle){
        this.todo_items.push({
          title: newTitle,
          isChecked: false
        });
        this.newItemTitle = ''; //追加
      },
    },
  }
</script>