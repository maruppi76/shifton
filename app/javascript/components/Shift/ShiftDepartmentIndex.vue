<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >確定シフト</v-card-title>
    </v-card>
    <v-card elevation="2" class="rounded-0 ma-1 ma-lg-4">
      <v-row class="pa-3" justify="space-between" v-if="current_user">
        <v-col cols="auto" class="text-h5">
          {{ current_user.department_main.mobile }}
        </v-col>
      </v-row>
    </v-card>
  </v-app>
</template>

<script>
  import axios from 'axios';
  export default {
    data() {
      return {
        current_user: '',
      }
    },
    mounted() {
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
        })
        .catch(error => console.log(error))
    }
  }
</script>