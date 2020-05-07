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
          v-model="newTask"
          v-on:keyup.enter="createTask"
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
    <v-list-item v-for="(task, index) in tasks" :key="task.name">
      <v-list-item-content>
      <v-list-item-title>
      <label v-bind:class="{ done:task.is_done }">
        <input type="checkbox" v-model="task.is_done" v-on:change="updateTask(task.id, index)">
        <span v-bind:class="{done: task.is_done}">{{ task.name }}</span>
      </label>

      <v-btn color="red" v-model="task.id" v-on:click="deleteTask(task.id, index)">削除</v-btn>
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
import axios from 'axios';

  export default {
    props: {
      source: String,
    },

    data: function () {
      return {
        drawer: null,
        items: [
          { text: 'LOG IN', link: '/login' },
          { text: '新着', link: '/login' },
          { text: '優先度', link: '/login' },
          { text: '自分の物だけ', link: '/login' },
        ],

        tasks: [],
        newTask: '',

        links: [
          'Home',
          'Git Hub',
          'developer Blog',
        ],
      }
    },

    created() {
      this.RoomChannel = this.$cable.subscriptions.create( "RoomChannel", {
        received: (data) => {
          switch (data.req){
            case 'create':
              this.tasks.unshift(data.name);
              break;
            case 'read':
              // nothing
              break;
            case 'update':
              this.tasks[data.index].is_done = data.is_done;
              break;
            case 'delete':
              this.tasks.splice(data.index, 1);
              break;
          }
          console.log(data.req);
        },
      })
    },

    methods: {
      speak(req, index) {
        this.RoomChannel.perform('speak', { 
          task: this.newTask,
          req: req,
          index: index,
          if ( index ){
            is_done: this.tasks[index].is_done
          }
        });
      },

      create_speak(res) {
        this.RoomChannel.perform('create_speak', { 
          created_task: res
        });
      },

      update_speak(req, index) {
        this.RoomChannel.perform('speak', { 
          task: this.newTask,
          req: req,
          index: index,
          if ( index ){
            is_done: this.tasks[index].is_done
          }
        });
      },

      delete_speak(req, index) {
        this.RoomChannel.perform('speak', { 
          task: this.newTask,
          req: req,
          index: index,
          if ( index ){
            is_done: this.tasks[index].is_done
          }
        });
      },

      createTask: function(){
        // テキストボックスが空の場合はreturnして終了
        if(this.newTask== '') return;

        // apiへ追加リクエスト
        axios.post('/api/tasks', { task: { name: this.newTask} }).then((response) => {
          this.create_speak(response.data);
          //this.tasks.unshift(response.data);
          this.newTask= '';
        }, (error) => {
          console.log(error, response);
        });
      },

      readTask: function(){
        // apiへ取得リクエスト
        axios.get('/api/tasks').then((response) => {
          for(let i = 0; i < response.data.tasks.length; i++) {
            this.tasks.push(response.data.tasks[i]);
          }
        }, (error) => {
          console.log(error, response);
        });
      },

      updateTask: function(task_id, index){
        // apiへ更新リクエスト
        axios.put('/api/tasks/' + task_id).then((response) => {
          this.speak('update', index);
        }, (error) => {
          console.log(error);
        });
      },

      deleteTask: function(task_id, index){
        // apiへ削除リクエスト
        axios.delete('/api/tasks/' + task_id).then((response) => {
          this.speak('delete', index);
          //this.tasks.splice(index, 1);
        }, (error) => {
          console.log(error, response);
        });
      },
    },

    // 初期表示
    mounted: function(){
      this.$vuetify.theme.dark = true
      this.readTask();
    },
  }
</script>

<style>
  .done { text-decoration: line-through; }
</style>