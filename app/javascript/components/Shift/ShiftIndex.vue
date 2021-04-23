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
                <td v-for="date of dates" :key="date.value" :class="date.tc" class="mainwidth">
                  <p
                    class="body-2 text-center mb-0 mx-1"
                    v-if="filterShiftName(user.id,date.value)[0] != '公休' && filterShiftType(user.id,date.value).length == 1"
                  >{{filterShiftType(user.id,date.value)[0]}}</p>
                  <p
                    class="body-2 text-center mb-0 mx-1"
                    v-if="filterShiftName(user.id,date.value).length == 1"
                  >{{ filterShiftName(user.id,date.value)[0] }}</p>
                  <p
                    class="body-2 text-center mb-0 mx-1"
                    v-else-if="filterShiftName(user.id,date.value).length == 2"
                  >◎</p>
                </td>
              </tr>
            </tbody>
          </table>
        </v-col>
      </v-row>
    </v-card>
  </v-app>
</template>
<script>
export default {
  
}
</script>