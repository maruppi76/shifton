<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >スタッフ一覧</v-card-title>
    </v-card>
    <v-row class="ma-0 align-content-start">
      <v-col cols="4" lg="1" v-for="user in users" :key="user.id">
        <v-card
          elevation="0"
          tile
        >
          <v-img
            class="rounded-circle"
            :aspect-ratio="1/1"
            width="200px"
            src="http://placehold.jp/c2c2c2/ffffff/200x200.png?text=No%20Image"
          ></v-img>
          <div class="text-center mt-3">
            {{ user.full_name }}
          </div>
          <div class="text-center mb-3">
            {{ user.staff_code }}
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-app>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      users: '',
    }
  },
  mounted() {
    axios.get('/api/users/all_users.json')
      .then(response => {
        this.users = response.data
        console.log(this.users)
      })
  }
}
</script>