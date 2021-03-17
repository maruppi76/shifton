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
        class="pa-5"
      >
        <v-row>
          <v-col cols="5">
            <v-row>
              <v-col cols="7" class="mt-10">
                hoge
              </v-col>
              <v-col cols="5">
                <v-img
                  class="rounded-circle"
                  :aspect-ratio="1/1"
                  width="200px"
                  src="http://placehold.jp/c2c2c2/ffffff/200x200.png?text=No%20Image"
                ></v-img>
              </v-col>
            </v-row>
          </v-col>
          <v-col cols="7">
            hogehoge
          </v-col>
        </v-row>
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