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
              class="mr-2"
            ></v-select>
            <v-select
              label="Standard"
              class="mr-2"
            ></v-select>
          </v-row>
        </v-col>
      </v-row>
      <v-row class="ma-0">
        <v-col class="pa-0" cols="4">
          <v-card tile shaped outlined>
            <v-chip
              class="ma-8 px-5"
              color="success"
              outlined
              label
              large
            >
              確定済
            </v-chip>
          </v-card>
        </v-col>
        <v-col class="pa-0" cols="8">
          <v-card tile shaped outlined style="height: 100%;">
            <v-row class="ma-0 px-5" style="height: 100%;" justify="center">
              <v-col class="pa-0 my-auto mx-3" cols="3">
                <div class="text-subtitle-2">出勤日数</div>
                <div class="text-h6 font-weight-bold">２０ 日</div>
              </v-col>
              <v-col class="pa-0 my-auto mx-3" cols="3">
                <div class="text-subtitle-2">公休日数</div>
                <div class="text-h6 font-weight-bold">hogehoge</div>
              </v-col>
              <v-col class="pa-0 my-auto mx-3" cols="3">
                <div class="text-subtitle-2">有休等日数</div>
                <div class="text-h6 font-weight-bold">hogehoge</div>
              </v-col>
            </v-row>
          </v-card>
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