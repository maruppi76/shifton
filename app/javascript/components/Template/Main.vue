<template>
  <v-app>
    <v-navigation-drawer app v-model="drawer" clipped>
      <SideBar :user="this.current_user"/>
      <template v-slot:append>
        <div class="pa-2">
          <v-btn 
            block
            @click="logout"
          >
            <v-icon left>
              mdi-logout-variant
            </v-icon>
            ログアウト
          </v-btn>
        </div>
      </template>
    </v-navigation-drawer>
    
    <v-app-bar :elevation="0" color="light-blue lighten-4" dark app  clipped-left>
      <v-app-bar-nav-icon @click="drawer=!drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>
        <v-img
          :src="top_image"
          max-height="40"
          max-width="150"
        >
        </v-img>
      </v-toolbar-title>
    </v-app-bar>
    <v-main>
      <router-view :user="this.current_user"/>
      <v-footer padless app>
        <v-col
          class="text-center text-caption"
          cols="12"
        >
          &copy; copyright {{ new Date().getFullYear() }} - <strong>shifton</strong>
        </v-col>
      </v-footer>
    </v-main>
  </v-app>
</template>

<script>
  import axios from 'axios';
  import Csrf from '../../mixins/csrf'
  import SideBar from './SideBar.vue'
  export default {
    data(){
      return {
        current_user: '',
        drawer: null,
        top_image: require('../../../assets/images/logos/shifton_logo_white.png'),
      }
    },
    components: {
      SideBar,
    },
    methods: {
      logout(event){
        event.preventDefault()
        this.setAxiosDefaults();
        axios.delete(
          '/users/sign_out'
        )
        .then(response => {
          this.updateCsrfToken(response.data.csrf_token);
          this.$router.push({path: '/sign_in'});
        })
      },
    },
    mounted(){
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
          console.log(response)
        })
        .catch(error => console.log(error))
    },
    mixins:[
      Csrf,
    ]
  }
</script>

<style scoped>

</style>