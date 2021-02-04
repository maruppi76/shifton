import Router from 'vue-router'
import Vue from 'vue'
import axios from 'axios';

import SignIn from './components/UserAuth/SignIn'
import Home from './components/Home'
import AccountIndex from './components/Account/AccountIndex'
import ShiftIndividualIndex from './components/Shift/ShiftIndividualIndex'
import ShiftDepartmentIndex from './components/Shift/ShiftDepartmentIndex'
import ShiftIndex from './components/Shift/ShiftIndex'
import StaffManagement from './components/Staff/StaffManagement'
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
          path: '/myshifts',
          component: ShiftIndividualIndex
        },
        {
          path: '/departmentshifts',
          component: ShiftDepartmentIndex
        },
        {
          path: '/shifts',
          component: ShiftIndex
        },
        {
          path: '/staff_management',
          component: StaffManagement
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