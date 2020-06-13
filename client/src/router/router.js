import Vue from 'vue'
import VueRouter from 'vue-router'

import Home from './../components/AppSectionHome'
import Produtos from './../components/AppSectionProdutos'
import App404 from './../components/App404'

Vue.use(VueRouter)

export default new VueRouter({

    linkExactActiveClass: 'link-active',

    routes: [{
        path: '/',
        component: Home
    },
    {
        path: '/produtos',
        component: Produtos
    },
    {
        path: '*',        
        component: App404
    }

]

})
