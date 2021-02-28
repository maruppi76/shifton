<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >確定シフト - {{ current_user.first_name }}  {{ current_user.last_name }}さん</v-card-title>
    </v-card>
     <v-card elevation="2" class="rounded-0 pa-10 ma-2">
     </v-card>
  </v-app>
</template>

<script>
  import moment from 'moment'
  import axios from 'axios';
  moment.locale('ja')

  export default {
    data(){
      return {
        day : new Date().toISOString().substr(0, 7),
        checkRadio: '1',
        dates: [],
        shifts: [],
        current_user: '',
        menu: false,
      }
    },
    mounted(){
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
          console.log(this.current_user)
        })
        .catch(error => console.log(error))
    },
  }

  


</script>