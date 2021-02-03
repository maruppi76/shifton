<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >確定シフト - 営業１部</v-card-title>
    </v-card>
    <v-sheet class="mt-10 mb-16 mx-5">
      <ShiftForm :dates="this.dates" :shifts="this.shifts" :users="this.users"/>
    </v-sheet>
  </v-app>
</template>

<script>
  import axios from 'axios';
  import moment from 'moment'
  moment.locale('ja')

  import ShiftForm from './ShiftSidewaysForm.vue'

  export default {
    data() {
      return {
        num: '',
        dates: [],
        shifts: [],
        users: [],
      }
    },
    mounted(){
      let date = moment();
      let num = moment(date).daysInMonth()
      let dates = []
      
      for(let i = 1; i < num + 1; i++){
        let result = moment(date).date(i)
        let day = result.format('D')
        let text = result.format('ddd')
        let value = result.format('YYYY-MM-DD')
        let tc = ''
        if(text == "土"){
          tc = "text-center blue--text"
        } else if(text == "日") {
          tc = "text-center red--text"
        } else {
          tc = "text-center"
        }
        let hash = {day: day, text: text, value: value, tc: tc}
        dates.push(hash)
      }
      this.num = num
      this.dates = dates
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
    components: {
      ShiftForm
    }
  }
</script>

<style scoped>
  .DepShiftTable {
    border-radius: 0;
    border-top: thin solid #E0E0E0;
    border-bottom: thin solid #E0E0E0;
  }
  .DepShiftTableHeader {
    border-bottom: thin solid #E0E0E0;
    background-color: #BDBDBD;
    color: #424242;
  }
  .DepShiftTableHeader > tr > th,
  .DepShiftTableBody > tr > td {
    border-right: thin solid #E0E0E0;
  }
  .DepShiftTableHeader > tr > th:last-child,
  .DepShiftTableBody > tr > td:last-child {
    border-right: none;
  }
  .DepShiftTableHeader > tr > th,
  .DepShiftTableBody > tr > td {
    padding: 0 !important;
  }

  .DepShiftTableBody > tr > td > p {
    white-space: nowrap;
  }
</style>