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
            @click="input(user,date)"
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
      <v-dialog
        v-model="dialog"
        max-width="500px"
      >
        <v-card>
          <v-card-title>
            <span class="headline">{{ formTitle }}</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col
                  cols="12"
                  sm="6"
                >
                  <v-text-field
                    v-model="createShift.date"
                    label="日付"
                    disabled
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                >
                  <v-text-field
                    v-model="username"
                    label="スタッフ名"
                    disabled
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                >
                  <v-select
                    dense
                    :items="patterns"
                    item-text="name"
                    :item-value="Object"
                    label="シフト名"
                    v-model="createShift.pattern"
                  ></v-select>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                >
                  <v-select
                    v-if="createShift.pattern.pattern_type == '出勤日'"
                    dense
                    :items="types"
                    item-text="name"
                    :item-value="Object"
                    label="種別"
                    v-model="createShift.type"
                  ></v-select>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-btn
              v-if="editedIndex != -1"
              color="red"
              text
              @click="shift_delete"
            >
              削除
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn
              color="blue darken-1"
              text
              @click="close"
            >
              キャンセル
            </v-btn>
            <v-btn
              color="blue darken-1"
              text
              @click="save"
            >
              保存
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </template>
  </v-simple-table>
</template>

<script>
  import axios from 'axios';
  import CsrfToken from '../../mixins/csrf'
  export default {
    props:['dates', 'shifts', 'users'],
    data(){
      return {
        dialog: false,
        editedIndex: -1,
        username: '',
        patterns: [],
        types: [],
        submitShift: '',
        createShift: {
          id: '',
          date: '',
          user_id: '',
          pattern: '',
          type: '',
        },
        defaultShift: {
          id: '',
          date: '',
          user_id: '',
          pattern: '',
          type: '',
        }
      }
    },
    computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'シフト登録' : 'シフト編集'
      },
    },
    mounted() {
      axios.get('/api/patterns.json')
        .then(response => {
          this.patterns = response.data
        })
      axios.get('/api/types.json')
      .then(response => {
        this.types = response.data
      })
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
      input(user,date) {
        this.shifts.forEach(shift => {
          if(shift.user_id == user.id && shift.date == date.value ) {
            this.editedIndex = 1
            this.createShift = Object.assign({}, shift)
          } else {
            this.createShift.date = date.value
            this.createShift.user_id = user.id
          }
          this.username = user.full_name
        })
        console.log(this.createShift)
        this.dialog = true
      },
      shift_delete(){

      },
      close(){
        this.dialog = false
        this.$nextTick(() => {
          this.createShift = Object.assign({}, this.defaultShift)
          this.editedIndex = -1
        })
      },
      save(e){
        e.preventDefault();
        this.setAxiosDefaults();
        if (this.createShift.pattern.pattern_type != "出勤日"){
          this.submitShift = {
            id: this.createShift.id,
            date: this.createShift.date,
            user_id: this.createShift.user_id,
            pattern_id: this.createShift.pattern.id,
            type_id: null
          } 
        } else {
          this.submitShift = {
            id: this.createShift.id,
            date: this.createShift.date,
            user_id: this.createShift.user_id,
            pattern_id: this.createShift.pattern.id,
            type_id: this.createShift.type.id
          }
        }

        
        if(this.editedIndex == -1){
          console.log('新規投稿です')
        } else {
          axios.patch(`/api/shifts/${this.createShift.id}`, {
            shift: this.submitShift
          })
          .then(response =>{
            if(response.data.status == 'ok'){
              axios.get('/api/shifts/all_shifts.json')
                .then(response => {
                  this.shifts = response.data
                })
              this.close()
            } else {
              this.text = "入力内容に誤りがあります。"
              this.snackbar = true
            }
          })
        }
      }
    },
    mixins:[
      CsrfToken,
    ]
  }
</script>