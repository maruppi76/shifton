<template>
  <v-card class="ma-5">
    <v-card-title>
      スタッフ一覧
      <v-spacer></v-spacer>
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
      ></v-text-field>
      <v-dialog
        v-model="dialog"
        max-width="500px"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            class="ma-2"
            outlined
            color="indigo"
            v-bind="attrs"
            v-on="on"
          >
            新規ユーザー登録
          </v-btn>
        </template>
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
                  md="6"
                >
                  <v-text-field
                    v-model="editedUser.first_name"
                    label="名前（姓）"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    v-model="editedUser.last_name"
                    label="名前（名）"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    v-model="editedUser.first_name_kana"
                    label="カナ（姓）"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    v-model="editedUser.last_name_kana"
                    label="カナ（名）"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                >
                  <v-text-field
                    v-model="editedUser.email"
                    label="メールアドレス"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                >
                  <v-text-field
                    v-model="editedUser.password"
                    label="パスワード"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    v-model="editedUser.staff_code"
                    label="スタッフコード"
                    dense
                  ></v-text-field>
                </v-col>
                <v-col
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-select
                    dense
                    :items="roles"
                    label="権限"
                    v-model="editedUser.role"
                    
                  ></v-select>
                </v-col>
                <v-col
                  cols="12"
                >
                  <v-select
                    dense
                    :items="departments"
                    label="所属部署（メイン）"
                    item-text="str"
                    item-value="id"
                    v-model="editedUser.department_main"
                    
                  ></v-select>
                </v-col>
                <v-col
                  cols="12"
                >
                  <v-select
                    dense
                    :items="departments"
                    label="所属部署（サブ）"
                    item-text="str"
                    item-value="id"
                    v-model="editedUser.department_sub"
                  ></v-select>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="blue darken-1"
              text
              @click="close"
            >
              Cancel
            </v-btn>
            <v-btn
              color="blue darken-1"
              text
              @click="save"
            >
              Save
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="users"
      :items-per-page="5"
      class="elevation-1"
      :search="search"
    >
      <template v-slot:[`item.actions`]="{ item }">
        <v-icon
          small
          class="mr-2"
          @click="editUser(item)"
        >
          mdi-pencil
        </v-icon>
      </template>
    </v-data-table>
    <v-snackbar
      v-model="snackbar"
      :timeout="timeout"
    >
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn
          color="blue"
          text
          v-bind="attrs"
          @click="snackbar = false"
        >
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
  </v-card>
</template>

<script>
  import axios from 'axios';
  import CsrfToken from '../../mixins/csrf'
  export default {
    data() {
      return {
        snackbar: false,
        text: '',
        timeout: 2000,
        dialog: false,
        dialogDelete: false,
        users: [],
        search: '',
        departments: [],
        roles: ['全権管理者','シフト管理者','スタッフ'],
        headers: [
          { text: 'スタッフコード', value: 'staff_code' },
          { text: '状態', value: 'status' },
          { text: 'ユーザー名', value: 'full_name' },
          { text: 'メールアドレス', value: 'email'},
          { text: '権限', value: 'role'},
          { text: '所属部署(メイン)', value: 'department_main.str'},
          { text: '所属部署(サブ)', value: 'department_sub.str'},
          { text: '操作', value: 'actions'}
        ],
        editedIndex: -1,
        editedUser: {
          id: '',
          status: '',
          first_name: '',
          last_name: '',
          first_name_kana: '',
          last_name_kana: '',
          email: '',
          password: '',
          staff_code: '',
          company_id: 1,
          department_main: '',
          department_sub: '',
          role: 'スタッフ',
          admin: false,
        },
        defaultUser: {
          id: '',
          status: '',
          first_name: '',
          last_name: '',
          first_name_kana: '',
          last_name_kana: '',
          email: '',
          password: '',
          staff_code: '',
          company_id: 1,
          department_main: '',
          department_sub: '',
          role: 'スタッフ',
          admin: false,
        },
      }
    },
    computed: {
      formTitle () {
        return this.editedIndex === -1 ? '新規ユーザー登録' : 'ユーザー情報編集'
      },
    },
    mounted() {
      axios.get('/api/users/all_users.json')
        .then(response => {
          this.users = response.data
          console.log(this.users)
        })
      axios.get('/api/departments.json')
        .then(response => {
          this.departments = response.data
          console.log(this.departments)
        })
      
    },
    methods: {
      editUser(user) {
        this.editedIndex = this.users.indexOf(user)
        this.editedUser = Object.assign({}, user)
        this.dialog = true
      },
      close () {
        this.dialog = false
        this.$nextTick(() => {
          this.editedUser = Object.assign({}, this.defaultUser)
          this.editedIndex = -1
        })
      },
      save(e) {
        e.preventDefault();
        this.setAxiosDefaults();
        if(this.editedIndex == -1){
          axios.post('/users',{
            user: {
              id: this.editedUser.id,
              status: this.editedUser.status,
              first_name: this.editedUser.first_name,
              last_name: this.editedUser.last_name,
              first_name_kana: this.editedUser.first_name_kana,
              last_name_kana: this.editedUser.last_name_kana,
              email: this.editedUser.email,
              password: this.editedUser.password,
              staff_code: this.editedUser.staff_code,
              company_id: this.editedUser.company_id,
              department_main_id: this.editedUser.department_main,
              department_sub_id: this.editedUser.department_sub,
              role: this.editedUser.role,
              admin: this.editedUser.admin,
            }
          })
          .then(response =>{
            if(response.data.status == 'ok'){
              axios.get('/api/users/all_users.json')
                .then(response => {
                  this.users = response.data
                  console.log(this.users)
                })
              this.close()
            } else {
              this.text = "入力内容に誤りがあります。"
              this.snackbar = true
            }
          })
        } else {
          axios.patch('/users',{
            user: {
              id: this.editedUser.id,
              status: this.editedUser.status,
              first_name: this.editedUser.first_name,
              last_name: this.editedUser.last_name,
              first_name_kana: this.editedUser.first_name_kana,
              last_name_kana: this.editedUser.last_name_kana,
              email: this.editedUser.email,
              password: this.editedUser.password,
              staff_code: this.editedUser.staff_code,
              company_id: this.editedUser.company_id,
              department_main_id: this.editedUser.department_main,
              department_sub_id: this.editedUser.department_sub,
              role: this.editedUser.role,
              admin: this.editedUser.admin,
            }
          })
          .then(response =>{
            if(response.data.status == 'ok'){
              axios.get('/api/users/all_users.json')
                .then(response => {
                  this.users = response.data
                  console.log(this.users)
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

<style>

</style>