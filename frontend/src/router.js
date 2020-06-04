import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    {
      path: "/tutorials",
      alias: "/tutorials",
      name: "tutorial",
      component: () => import("./components/Tutorial")
    }
  ]
});