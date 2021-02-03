<template>
  <v-simple-table dense class="DepShiftTable">
    <template v-slot:default>
      <thead class="DepShiftTableHeader">
        <tr>
          <th 
            rowspan="2"
            width="20%"
          ></th>
          <th
            v-for="date in dates"
            :key="date.value"
            class="text-center"
          >
            {{date.day}}
          </th>
        </tr>
        <tr>
          <th
            v-for="date in dates"
            :key="date.value"
            :class=date.tc
          >
            {{date.text}}
          </th>
        </tr>
      </thead>
      <tbody class="DepShiftTableBody">
        <tr
          v-for="user in users"
          :key="user.id"
        >
          <td>
            <p class="text-caption mb-2 mx-1">{{ user.department_main.str }}</p>
            <p class="text-caption text-center mb-0 mx-1">{{ user.first_name }} {{ user.last_name }}</p>
          </td>
          <td
            v-for="date in dates"
            :key="date.value"
          >
          
            <p
              class="text-caption text-center mb-0 mx-1"
              v-if="filterShiftName(user.id,date.value)[0] != '公休' && filterShiftType(user.id,date.value).length == 1"
            >{{filterShiftType(user.id,date.value)[0]}}</p>
            <p
              class="text-caption text-center mb-0 mx-1"
              v-if="filterShiftName(user.id,date.value).length == 0"
            >-----</p>
            <p
              class="text-caption text-center mb-0 mx-1"
              v-else-if="filterShiftName(user.id,date.value).length == 1"
            >{{ filterShiftName(user.id,date.value)[0] }}</p>
            <p
              class="text-caption text-center mb-0 mx-1"
              v-else-if="filterShiftName(user.id,date.value).length == 2"
            >◎</p>
          </td>
        </tr>
      </tbody>
    </template>
  </v-simple-table>
</template>

<script>
  export default {
   props:['dates', 'shifts', 'users'],

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