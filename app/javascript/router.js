import Router from 'vue-router'
import Vue from 'vue'
import axios from 'axios';

import SignIn from './components/UserAuth/SignIn'
import Home from './components/Home'
import AccountIndex from './components/Account/AccountIndex'
import ShiftIndividualIndex from './components/Shift/ShiftIndividualIndex'
import ShiftDepartmentIndex from './components/Shift/ShiftDepartmentIndex'
import ShiftDepartmentIndexOld from './components/Shift/ShiftDepartmentIndexOld'
import ShiftIndex from './components/Shift/ShiftIndex'
import StaffIndex from './components/Staff/StaffIndex'
import StaffDetail from './components/Staff/StaffDetail'
import StaffManagementOld from './components/Staff/StaffManagementOld'
import CreateShift from './components/Shift/CreateShift'

Vue.use(Router)

const router = new Router({

  mode: 'history',
  base: process.env.BASE_URL,
  routes:[
    {
      path: '/',
      component: Home,
      meta: {
        isSignIn: true
      },
      children: [
        {
          path: '/',
          component: AccountIndex
        },
        {
          path: '/shifts/me',
          component: ShiftIndividualIndex
        },
        {
          path: '/shifts/department',
          component: ShiftDepartmentIndex
        },
        {
          path: '/shifts/departmentold',
          component: ShiftDepartmentIndexOld
        },
        {
          path: '/shifts/all',
          component: ShiftIndex
        },
        {
          path: '/staff',
          component: StaffIndex
        },
        {
          path: '/staff/:id',
          component: StaffDetail,
          props: route => ({id: Number(route.params.id)})
        },
        {
          path: '/staff_managementold',
          component: StaffManagementOld
        },
        {
          path: '/shifts/create',
          component: CreateShift
        }
      ]
    },
    {
      path: '/sign_in',
      component: SignIn,
      meta: {
        isSignIn: false
      },
    }, 
  ],
})

// ユーザーのログインを必要とするか否かを判断
router.beforeEach((to, from, next) => {
  const isSignIn=to.matched.some(page => page.meta.isSignIn)

  axios
    .get('/api/users/login_check.json')
    .then(response => {
      if(isSignIn){
        if(response.data.login) {
          next()
        } else {
          next('/sign_in')
        }
      } else {
        if(response.data.login) {
          next('/')
        } else {
          next()
        }
      }
    })
})

export default router