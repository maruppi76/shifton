<template>
  <v-app class="grey lighten-5">
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >{{ this.user.full_name }}</v-card-title>
    </v-card>
    <v-container>
      <v-card
        elevation="1"
        tile
      >
        hogehoge
      </v-card>
    </v-container>
    
  </v-app>
</template>

<script>
import axios from 'axios';
export default {
  props: {id: Number},

  data() {
    return{
      user: '',
    }
  },
  mounted() {
    axios.get(`/api/users/${this.id}.json`)
      .then(response => {
        this.user = response.data
        console.log(this.user)
      })
  }
}
</script>