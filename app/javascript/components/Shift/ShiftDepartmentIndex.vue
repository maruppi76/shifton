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
              <tr class="ShiftTableHeaderRow">
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
              <tr class="ShiftTableHeaderRow">
                <th v-for="date of dates" :key="date.value" :class="date.tc" class="mainwidth grey--text text--darken-1">{{ date.text }}</th>
              </tr>
            </thead>
            <tbody>
              <tr class="ShiftTableRow" v-for="user of users" :key="user.id">
                <td v-for="date of dates" :key="date.value" :class="date.tc" class="mainwidth">{{ date.text }}</td>
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
        let textmiddle = result.format('ddd')
        let value = result.format('YYYY-MM-DD')
        let holiday = holiday_jp.isHoliday(value)
        let holiday_name = ''
        let hash = ''

        if (holiday){
          holiday_name = holiday_jp.between(new Date(value), new Date(value))[0]['name']
          hash = {text: text, value: value, tc: 'rl5', holiday: holiday, holiday_name: holiday_name}
        } else if(textmiddle == '土'){
          hash = {text: text, value: value, tc: 'bl5', holiday: holiday, holiday_name: holiday_name}
        } else if(textmiddle == '日'){
          hash = {text: text, value: value, tc: 'rl5', holiday: holiday, holiday_name: holiday_name}
        } else {
          hash = {text: text, value: value, holiday: holiday, holiday_name: holiday_name}
        }
        dates.push(hash)
      }
      this.dates = dates
      console.log(dates)
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
        })
        .catch(error => console.log(error))
      axios.get('/api/users/dep_users.json')
        .then(response => {
          this.users = response.data
          console.log(this.users)
        })
        .catch(error => console.log(error))
      axios.get('/api/shifts/dep_shifts.json')
        .then(response => {
          this.shifts = response.data
          console.log(this.shifts)
        })
        .catch(error => console.log(error))
    },
    methods: {
      filterShiftName(uid, key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.user_id == uid && shift.date == key) {
            filterd.push(shift.pattern.name);
          }
        });
        return filterd
      },
      filterShiftType(uid, key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.user_id == uid && shift.date == key && shift.type) {
            filterd.push(shift.type.name);
          }
        });
        return filterd
      },
    },
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
  box-shadow: 3px 0 rgba(0,0,0,0.1);
}


.ShiftTableHeaderRow {
  height: 56px;
  text-align: left;
}

.ShiftTableRow {
  height: 90px;
  text-align: left;
}

.ShiftTableHeaderRow > th,
.ShiftTableRow > td {
  border-bottom: 1px solid #dce2e6 !important;
  border-right: 1px solid #dce2e6 !important;
}

.ShiftTableHeaderRow > th:last-child,
.ShiftTableRow > td:last-child {
  border-right: none;
}

.bl5 {
  background-color: #e3f2fd;
}

.rl5 {
  background-color: #ffebee;
}
</style>