import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
const day=new Date
const store = () => {
  return new Vuex.Store({
      state: {
        selectedDate:day,
        currentUser:null,
        fromPath:null
      },
      getters:{
        currentUser(state){return state.currentUser},
        fromPath(state){return state.fromPath}
      },
      mutations: {
        setDate(state, val) {
            state.selectedDate = val
        },
        setCurrentUser(state, val) {
            state.currentUser = val.user
        }, 
        setFromPath(state, val) {
            state.fromPath= val
        },
      },
      actions: {
      }
  })
}

export default store