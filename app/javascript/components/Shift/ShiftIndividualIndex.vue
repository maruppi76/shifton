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
        <v-col class="pa-0" cols="12" lg="4">
          <v-card tile shaped outlined>
            <v-chip
              class="ma-2 pa-2 ma-lg-8 px-lg-5"
              color="success"
              outlined
              label
              large
            >
              確定済
            </v-chip>
          </v-card>
        </v-col>
        <v-col class="pa-0" cols="12" lg="8">
          <v-card tile shaped outlined style="height: 100%;">
            <v-row class="ma-0 px-5" style="height: 100%;" justify="center">
              <v-col class="pa-0 my-auto mx-3" cols="3">
                <div class="text-subtitle-2">出勤日数</div>
                <div class="text-h6 font-weight-bold">17.5 日</div>
              </v-col>
              <v-col class="pa-0 my-auto mx-3" cols="3">
                <div class="text-subtitle-2">公休日数</div>
                <div class="text-h6 font-weight-bold">10 日</div>
              </v-col>
              <v-col class="pa-0 my-auto mx-3" cols="3">
                <div class="text-subtitle-2">有休等日数</div>
                <div class="text-h6 font-weight-bold">3.5 日</div>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
      <v-simple-table class="ShiftViewTable">
        <template v-slot:default>
          <thead class="ShiftViewTable__Header">
            <tr class="grey lighten-2">
              <th class="text-center" width="8%">日付</th>
              <th class="text-center" width="5%">休日<br/>区分</th>
              <th class="text-center" width="5%">名称</th>
              <th class="text-center" width="8%">種別</th>
              <th class="text-center" width="5%">開始</th>
              <th class="text-center" width="5%">終了</th>
              <th class="text-center">備考</th>
              <th class="text-center" width="5%"></th>
            </tr>
          </thead>
          <tbody class="ShiftViewTable__Body">
            <tr
              v-for="date in dates"
              :key="date.value"
              class="text-center"
              height="50px"
            >
              <td class="grey--text text--darken-1" :class="date.tc">{{ date.text }}</td>
              <td>祝日</td>
              <td>早番</td>
              <td>本社</td>
              <td class="text-lg-h6">10:00</td>
              <td class="text-lg-h6">19:00</td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
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
      let date = moment(this.day);
      let num = moment(date).daysInMonth()
      let dates = []
      
      for(let i = 1; i < num + 1; i++){
        let result = moment(date).date(i)
        let text = result.format('MM/DD(ddd)')
        let textmiddle = result.format('ddd')
        let value = result.format('YYYY-MM-DD')
        let hash = ''

        if(value == moment().format("YYYY-MM-DD")){
          hash = {text: text, value: value, tc: 'teal lighten-5'}
        } else if(textmiddle == '土'){
          hash = {text: text, value: value, tc: 'blue lighten-5'}
        } else if(textmiddle == '日'){
          hash = {text: text, value: value, tc: 'red lighten-5'}
        } else {
          hash = {text: text, value: value}
        }
        dates.push(hash)
      }
      this.dates = dates
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
          console.log(this.current_user)
        })
        .catch(error => console.log(error))
    },
  }
</script>

<style lang="scss">
.ShiftViewTable {
  th, td{
    border-right: thin solid #F5F5F5;

    &:last-child{
      border-right: none;
    }
  }
}
</style>