import Vue from 'vue'
import VueRouter from 'vue-router'

import Home from './../components/AppSectionHome'
import Produtos from './../components/AppSectionProdutos'
import Login from './../components/AppLogin'
import App404 from './../components/App404'

Vue.use(VueRouter)

export default new VueRouter({

    linkExactActiveClass: 'link-active',
        
    routes: [{
        path: '/',
        component: Home,
        meta: { requiresAuth: true },
    },
    {
        path: '/produtos',
        component: Produtos,
        meta: { requiresAuth: true },
    },
    {
        path: '/login',
        component: Login,
        meta: { requiresAuth: false },
    },
    {
        path: '*',        
        component: App404
    }
   ]

})
