<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >確定シフト</v-card-title>
    </v-card>
    <v-card elevation="2" class="rounded-0 ma-2">
      <v-row class="pa-3" justify="space-between">
        <v-col cols="auto" class="text-h5">
          {{ current_user.first_name }}  {{ current_user.last_name }}
        </v-col>
        <v-col cols="auto">
          <v-row>
            <v-select
              label="Standard"
              class="mr-1"
            ></v-select>
            <v-select
              label="Standard"
            ></v-select>
          </v-row>
        </v-col>
      </v-row>
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