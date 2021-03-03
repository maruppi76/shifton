<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >確定シフト</v-card-title>
    </v-card>
    <v-card elevation="2" class="rounded-0 ma-1 ma-lg-4">
      <v-row class="pa-3" justify="space-between">
        <v-col cols="auto" class="text-h5">
          {{ current_user.first_name }}  {{ current_user.last_name }}
        </v-col>
        <v-col cols="auto">
          <v-row align="center" justify="end">
            <v-col cols="3" lg="2" class="pr-0">
              <v-select
                v-model="selectYear"
                class="mr-2"
                :items="years"
                @change="changeYear"
              ></v-select>
            </v-col>
            <v-col cols="6" lg="3" class="pr-0">
              <v-select
                v-model="selectMonth"
                class="mr-2"
                :items="monthes"
              ></v-select>
            </v-col>
            <v-col cols="3" lg="2">
              <v-btn
                outlined
                class="mr-2"
                @click="changeCalendar"
              >表示</v-btn>
            </v-col>
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
            <v-card-title class="py-1">サマリー</v-card-title>
            <v-row class="ma-0" justify="center">
              <v-col class="pa-0 mx-3" cols="3">
                <div class="text-subtitle-2">出勤日数</div>
                <div class="text-h6 font-weight-bold">17.5 日</div>
              </v-col>
              <v-col class="pa-0 mx-3" cols="3">
                <div class="text-subtitle-2">公休日数</div>
                <div class="text-h6 font-weight-bold">10 日</div>
              </v-col>
              <v-col class="pa-0 mx-3" cols="3">
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
              <v-tooltip top v-if="date.holiday">
                <template v-slot:activator="{ on, attrs }">
                  <td
                    v-bind="attrs"
                    v-on="on"
                    class="text-no-wrap"
                  >祝日</td>
                </template>
                <span>{{ date.holiday_name }}</span>
              </v-tooltip>
              
              <td
                v-else
              ></td>
              <td 
                class="text-no-wrap"
                v-if="filterShiftName(date.value).length < 2"
              >{{ filterShiftName(date.value)[0] }}</td>
              <td 
                class="text-no-wrap"
                v-else
              >※</td>
              <td 
                v-if="filterShiftPhase(date.value).length < 2"
                class="text-no-wrap"
              >{{ filterShiftPhase(date.value)[0] }}</td>
              <td 
                v-else
                class="text-no-wrap"
              >※</td>
              <td 
                v-if="filterShiftSTime(date.value).length < 2"
                class="text-lg-subtitle-1 font-weight-medium"
              >{{ filterShiftSTime(date.value)[0] }}</td>
              <td 
                v-else
                class="text-lg-subtitle-1 font-weight-medium"
              >※</td>
              <td 
                v-if="filterShiftETime(date.value).length < 2"
                class="text-lg-subtitle-1 font-weight-medium"
              >{{ filterShiftETime(date.value)[0] }}</td>
              <td 
                v-else
                class="text-lg-subtitle-1 font-weight-medium"
                >※</td>
              <td 
                v-if="filterShiftRemarks(date.value).length < 2"
                class="text-no-wrap"
              >{{ filterShiftRemarks(date.value)[0] }}</td>
              <td 
                v-else
                class="text-no-wrap"
              >※</td>
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
  import holiday_jp from '@holiday-jp/holiday_jp';
  import axios from 'axios';
  moment.locale('ja')

  export default {
    data(){
      return {
        day : new Date().toISOString().substr(0, 7),
        dates: [],
        shifts: [],
        years: [],
        monthes: [],
        selectYear: moment(this.day).year(),
        selectMonth: '',
        current_user: '',
        menu: false,
      }
    },
    mounted(){
      let date = moment(this.day);
      let num = moment(date).daysInMonth()
      let year = moment(date).year()
      let years = [year - 1, year, year + 1, year + 2]
      let monthes = []
      let dates = []
      
      for(let i = 1; i < num + 1; i++){
        let result = moment(date).date(i)
        let text = result.format('MM/DD(ddd)')
        let textmiddle = result.format('ddd')
        let value = result.format('YYYY-MM-DD')
        let holiday = holiday_jp.isHoliday(value)
        let holiday_name = ''
        let hash = ''

        if (holiday){
          holiday_name = holiday_jp.between(new Date(value), new Date(value))[0]['name']
        }

        if(value == moment().format("YYYY-MM-DD")){
          hash = {text: text, value: value, tc: 'teal lighten-5', holiday: holiday, holiday_name: holiday_name}
        } else if(textmiddle == '土'){
          hash = {text: text, value: value, tc: 'blue lighten-5', holiday: holiday, holiday_name: holiday_name}
        } else if(textmiddle == '日'){
          hash = {text: text, value: value, tc: 'red lighten-5', holiday: holiday, holiday_name: holiday_name}
        } else {
          hash = {text: text, value: value, holiday: holiday, holiday_name: holiday_name}
        }
        dates.push(hash)
      }

      for(let i = 0; i < 12; i ++){
        let check_start_day = moment().year(year).month(i).date(1)
        let start_day = check_start_day.format('MM/DD')
        let end_day = moment().year(year).month(i).date(moment(check_start_day).daysInMonth()).format('MM/DD')
        let month_text = start_day + '~' + end_day
        monthes.push(month_text)
      }
      this.dates = dates
      this.years = years
      this.monthes = monthes
      this.selectMonth = monthes[moment().month()]
      axios.get('/api/shifts/my_shift.json')
        .then(response => {
          this.shifts = response.data
          console.log(this.shifts)
        })
        .catch(error => console.log(error))
      axios.get('/api/users/user_detail.json')
        .then(response => {
          this.current_user = response.data
          console.log(this.current_user)
        })
        .catch(error => console.log(error))
    },
    methods: {
      filterShiftName(key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.date == key) {
            filterd.push(shift.pattern.name);
          }
        });
        return filterd
      },
      filterShiftPhase(key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.date == key && shift.type) {
            filterd.push(shift.type.name);
          }
        });
        return filterd
      },
      filterShiftSTime(key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.date == key && shift.pattern.start_time) {
            filterd.push(moment(shift.pattern.start_time).format('HH:mm'));
          }
        });
        return filterd
      },
      filterShiftETime(key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.date == key && shift.pattern.end_time) {
            filterd.push(moment(shift.pattern.end_time).format('HH:mm'));
          }
        });
        return filterd
      },
      filterShiftRemarks(key) {
        let filterd = [];
        this.shifts.forEach(shift => {
          if (shift.date == key) {
            filterd.push(shift.remarks);
          }
        });
        return filterd
      },
      changeCalendar() {
        const year = this.selectYear
        const month = this.selectMonth.slice(0, 2) - 1
        const startday = moment().year(year).month(month).date(1)
        const num = moment(startday).daysInMonth()
        let dates = []
        for(let i = 1; i < num + 1; i++){
          let result = moment().year(year).month(month).date(i)
          let text = result.format('MM/DD(ddd)')
          let textmiddle = result.format('ddd')
          let value = result.format('YYYY-MM-DD')
          let holiday = holiday_jp.isHoliday(value)
          let holiday_name = ''
          let hash = ''

          if (holiday){
            holiday_name = holiday_jp.between(new Date(value), new Date(value))[0]['name']
          }

          if(value == moment().format("YYYY-MM-DD")){
            hash = {text: text, value: value, tc: 'teal lighten-5', holiday: holiday, holiday_name: holiday_name}
          } else if(textmiddle == '土'){
            hash = {text: text, value: value, tc: 'blue lighten-5', holiday: holiday, holiday_name: holiday_name}
          } else if(textmiddle == '日'){
            hash = {text: text, value: value, tc: 'red lighten-5', holiday: holiday, holiday_name: holiday_name}
          } else {
            hash = {text: text, value: value, holiday: holiday, holiday_name: holiday_name}
          }
          dates.push(hash)
        }
        this.dates = dates
      },
      changeYear() {
        const year = this.selectYear
        let monthes = []
        for(let i = 0; i < 12; i ++){
          let check_start_day = moment().year(year).month(i).date(1)
          let start_day = check_start_day.format('MM/DD')
          let end_day = moment().year(year).month(i).date(moment(check_start_day).daysInMonth()).format('MM/DD')
          let month_text = start_day + '~' + end_day
          monthes.push(month_text)
        }
        this.monthes = monthes
        this.selectMonth = monthes[0]
      }
    }
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