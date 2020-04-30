import Vue          from 'vue'
import VueRouter    from 'vue-router'
import ToDoHome     from '../pages/ToDoHome.vue'
import UserToDoHome from '../pages/UserToDoHome.vue'
import LoginHome    from '../pages/Login.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',  name: 'UserToDoHome', component: UserToDoHome },
//  { path: '/',  name: 'ToDoHome', component: ToDoHome },
  { path: '/login',  name: 'LoginHome', component: LoginHome },
];

export default new VueRouter({ routes });