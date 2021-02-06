<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >確定シフト - {{ current_user.first_name }}  {{ current_user.last_name }}さん</v-card-title>
    </v-card>
    <v-container class="my-10">
      <v-card elevation="2" class="rounded-0 pa-10">
        <v-row>
          <v-col
            cols="11"
            sm="5"
          >
            <v-menu
              ref="menu"
              v-model="menu"
              :close-on-content-click="false"
              :return-value.sync="day"
              transition="scale-transition"
              offset-y
              max-width="290px"
              min-width="auto"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-text-field
                  v-model="day"
                  label="Picker in menu"
                  prepend-icon="mdi-calendar"
                  readonly
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
              </template>
              <v-date-picker
                v-model="day"
                type="month"
                no-title
                scrollable
              >
                <v-spacer></v-spacer>
                <v-btn
                  text
                  color="primary"
                  @click="menu = false"
                >
                  Cancel
                </v-btn>
                <v-btn
                  text
                  color="primary"
                  @click="$refs.menu.save(day)"
                >
                  OK
                </v-btn>
              </v-date-picker>
            </v-menu>
          </v-col>
        </v-row>
        <v-simple-table
          class="MyShiftTable"
        >
          <template v-slot:default>
            <thead class="MyShiftTableHeader">
              <tr>
                <th class="text-center" width="10%">
                  日付
                </th>
                <th class="text-center" width="15%">
                  シフト名
                </th>
                <th class="text-center" width="15%">
                  種別
                </th>
                <th class="text-center" width="10%">
                  開始時刻
                </th>
                <th class="text-center" width="10%">
                  終了時刻
                </th>
                <th class="text-center">
                  備考
                </th>
              </tr>
            </thead>
            <tbody class="MyShiftTableMain">
              <tr
                v-for="date in dates"
                :key="date.value"
              >
                <td 
                  class="text-center"
                  v-if="date.text != null"
                >{{ date.text }}</td>
                <td 
                  class="text-center"
                  v-else
                >{{ date.left }}<font :class="date.tc">{{ date.middle }}</font>{{ date.right }}</td>
                <td 
                  class="text-center"
                  v-if="filterShiftName(date.value).length < 2"
                >{{ filterShiftName(date.value)[0] }}</td>
                <td 
                  class="text-center"
                  v-else
                >※</td>
                <td 
                  v-if="filterShiftPhase(date.value).length < 2"
                  class="text-center"
                >{{ filterShiftPhase(date.value)[0] }}</td>
                <td 
                  v-else
                  class="text-center"
                >※</td>
                <td 
                  v-if="filterShiftSTime(date.value).length < 2"
                  class="text-center"
                >{{ filterShiftSTime(date.value)[0] }}</td>
                <td 
                  v-else
                  class="text-center"
                >※</td>
                <td 
                  v-if="filterShiftETime(date.value).length < 2"
                  class="text-center"
                >{{ filterShiftETime(date.value)[0] }}</td>
                <td 
                  v-else
                  class="text-center"
                >※</td>
                <td 
                  v-if="filterShiftRemarks(date.value).length < 2"
                  class="text-center"
                >{{ filterShiftRemarks(date.value)[0] }}</td>
                <td 
                  v-else
                  class="text-center"
                >※</td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
  import moment from 'moment'
  import axios from 'axios';
  moment.locale('ja')

  export default {
    data(){
      return {
        checkRadio: '1',
        dates: [],
        shifts: [],
        current_user: '',
      }
    },
    mounted(){
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
    watch: {
      menu: function() {
        let date = moment(this.day);
        let num = moment(date).daysInMonth()
        let dates = []
        
        for(let i = 1; i < num + 1; i++){
          let result = moment(date).date(i)
          let text = result.format('MM/DD(ddd)')
          let textleft = result.format('MM/DD(')
          let textmiddle = result.format('ddd')
          let textright = result.format(')')
          let value = result.format('YYYY-MM-DD')
          let hash = ''

          if(textmiddle == '土'){
            hash = {left: textleft, middle: textmiddle, right: textright, value: value, tc: 'blue--text'}
          } else if(textmiddle == '日'){
            hash = {left: textleft, middle: textmiddle, right: textright, value: value, tc: 'red--text'}
          } else {
            hash = {text: text, value: value}
          }
          dates.push(hash)
        }
        this.dates = dates
      }
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
    }
  }
</script>

<style>
  .MyShiftTable {
    border-radius: 0;
    border-top: thin solid #E0E0E0;
    border-bottom: thin solid #E0E0E0;
  }
  .MyShiftTableHeader {
    background-color: #BDBDBD;
    color: #424242;
  }
  .MyShiftTableHeader > tr > th,
  .MyShiftTableMain > tr > td {
    border-right: thin solid #E0E0E0;
  }
  .MyShiftTableHeader > tr > th:last-child,
  .MyShiftTableMain > tr > td:last-child {
    border-right: none;
  }

  .SearchSelect > label {
    font-size: 0.75rem;
    font-weight: 600;
  }
</style>