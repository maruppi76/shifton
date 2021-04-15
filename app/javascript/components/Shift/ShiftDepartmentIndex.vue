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
        <v-col cols="2" class="px-0">
          <table class="ShiftTable ShiftTable--User">
            <thead>
              <tr class="ShiftTableRow">
                <th class="pl-3">スタッフ名</th>
              </tr>
            </thead>
            <tbody>
              <tr class="ShiftTableRow" v-for="user of users" :key="user.id">
                <td class="pl-3">
                  <ruby>
                    <rb>{{ user.first_name }}</rb>
                    <rt>{{ user.first_name_kana }}</rt>
                  </ruby>
                  <ruby>
                    <rb>{{ user.last_name }}</rb>
                    <rt>{{ user.last_name_kana }}</rt>
                  </ruby>
                </td>
              </tr>
            </tbody>
          </table>
        </v-col>
        <v-col cols="10" class="fill-width px-0">
          <table  class="ShiftTable">
            <thead>
              <tr class="ShiftTableRow">
                <th v-for="date of dates" :key="date.value" class="mainwidth">{{ date.text }}</th>
              </tr>
            </thead>
            <tbody>
              <tr class="ShiftTableRow" v-for="user of users" :key="user.id">
                <td v-for="date of dates" :key="date.value" class="mainwidth">{{ date.text }}</td>
              </tr>
            </tbody>
          </table>
        </v-col>
      </v-row>
    </v-card>
  </v-app>
</template>

<script>
  import moment from 'moment'
  import holiday_jp from '@holiday-jp/holiday_jp';
  import axios from 'axios';
  moment.locale('ja')
  export default {
    data() {
      return {
        current_user: '',
        dates: [],
        shifts: [],
        users: [],
      }
    },
    mounted() {
      let date = moment(this.day);
      let num = moment(date).daysInMonth()
      let dates = []
      for(let i = 1; i < num + 1; i++){
        let result = moment(date).date(i)
        let text = result.format('DD(ddd)')
        let value = result.format('YYYY-MM-DD')
        let hash = {text: text, value: value}

        dates.push(hash)
      }
      this.dates = dates
      console.log(dates)
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
        })
        .catch(error => console.log(error))
      axios.get('/api/users/all_users.json')
        .then(response => {
          this.users = response.data
          console.log(this.users)
        })
        .catch(error => console.log(error))
      axios.get('/api/shifts/all_shifts.json')
        .then(response => {
          this.shifts = response.data
          console.log(this.shifts)
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

.fill-width::-webkit-scrollbar {
  display:none;
}

.mainwidth {
  min-width: 90px;
  text-align: center;
}

.ShiftTable--User {
  width: 100%;
}


.ShiftTableRow {
  height: 56px;
  text-align: left;
}
</style>