import Vue          from 'vue'
import VueRouter    from 'vue-router'
import ToDoHome     from '../pages/ToDoHome.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',  name: 'ToDoHome', component: ToDoHome },
];

export default new VueRouter({ routes });