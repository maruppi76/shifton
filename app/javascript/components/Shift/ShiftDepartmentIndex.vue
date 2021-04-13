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
      <v-row class="ma-0" align="center">
        <v-col cols="2">
          <table>
            <thead>
              <tr>
                <th>スタッフ名</th>
              </tr>
            </thead>
          </table>
        </v-col>
        <v-col cols="10" class="fill-width">
          <table>
            <thead>
              <tr>
                <th v-for="n of 31" :key="n" class="mainwidth">{{n}}</th>
              </tr>
            </thead>
          </table>
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

<style>
.fill-width {
  overflow-x: scroll;
  flex-wrap: nowrap;
}

.fill-width::-webkit-scrollbar {  /* Chrome, Safari 対応 */
  display:none;
}

.mainwidth {
  min-width: 90px;
}
</style>