<template>
  <v-container>
    <v-list-item>
      <v-list-item-content>
        <v-list-item-title class="title grey--text text--darken-2">
          {{ user.first_name}} {{ user.last_name }} さん
        </v-list-item-title>
        <v-list-item-subtitle class="caption">
          {{ user.email }}
        </v-list-item-subtitle>
        <v-list-item-subtitle class="caption" v-if="user.company">
          {{ user.company.name}}
        </v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>
    <v-divider></v-divider>
    <v-list dense nav>
      <v-subheader>シフト</v-subheader>
      <template v-for="shift_list in shift_lists">
        <v-list-item
            v-if="!shift_list.lists" 
            :to="shift_list.link"
            :key="shift_list.name"
            @click="menu_close"
        >
        <v-list-item-icon>
          <v-icon>{{ shift_list.icon }}</v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>
            {{ shift_list.name }}
          </v-list-item-title>
        </v-list-item-content>
        </v-list-item>
        <v-list-group
            v-else
            no-action
            :prepend-icon="shift_list.icon"
            :key="shift_list.name"
            v-model="shift_list.active"
        >
          <template v-slot:activator>
              <v-list-item-content>
                <v-list-item-title>
                  {{ shift_list.name }}
                </v-list-item-title>
              </v-list-item-content>
          </template>
          <v-list-item
              v-for="list in shift_list.lists"
              :key="list.name"
              :to="list.link"
          >
            <v-list-item-title>
              {{ list.name }}
            </v-list-item-title>
          </v-list-item>
        </v-list-group>
      </template>
      <div v-if="user.role != 'スタッフ'">
        <v-subheader>シフト管理</v-subheader>
        <v-list-item v-for="management_list in management_lists" :key="management_list.name" :to="management_list.link">
          <v-list-item-icon>
            <v-icon>{{ management_list.icon }}</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>{{ management_list.name }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <div v-if="user.role == '全権管理者'">
          <v-subheader>全権管理者メニュー</v-subheader>
          <template v-for="admin_list in admin_lists">
            <v-list-item
                v-if="!admin_list.lists" 
                :to="admin_list.link"
                :key="admin_list.name"
                @click="menu_close"
            >
            <v-list-item-icon>
              <v-icon>{{ admin_list.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>
                {{ admin_list.name }}
              </v-list-item-title>
            </v-list-item-content>
            </v-list-item>
            <v-list-group
                v-else
                no-action
                :prepend-icon="admin_list.icon"
                :key="admin_list.name"
                v-model="admin_list.active"
            >
              <template v-slot:activator>
                  <v-list-item-content>
                    <v-list-item-title>
                      {{ admin_list.name }}
                    </v-list-item-title>
                  </v-list-item-content>
              </template>
              <v-list-item
                  v-for="list in admin_list.lists"
                  :key="list.name"
                  :to="list.link"
              >
                <v-list-item-title>
                  {{ list.name }}
                </v-list-item-title>
              </v-list-item>
            </v-list-group>
          </template>
        </div>
      </div>
      <v-subheader>設定</v-subheader>
      <v-list-item v-for="setting_list in setting_lists" :key="setting_list.name" :to="setting_list.link">
        <v-list-item-icon>
          <v-icon>{{ setting_list.icon }}</v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>{{ setting_list.name }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-container>
</template>

<script>
  export default {
    props:['user'],
    data() {
      return{
        current_user: '',
        shift_lists: [
          {
            name: '確定シフト',
            icon: 'mdi-calendar-month',
            lists: [
              {
                name: '個人シフト',
                link: '/shifts/me',
              },
              {
                name: '所属部署シフト',
                link: '/shifts/department',
              },
              {
                name: '全体シフト(新)',
                link: '/shifts/all',
              },
            ]
          },
        ],
        management_lists: [
          {
            name: 'シフト作成・編集',
            icon: 'mdi-calendar-edit',
            link: '/shifts/create'
          }
        ],
        admin_lists: [
          {
            name: 'スタッフ管理',
            icon: 'mdi-account-multiple',
            lists: [
              {
                name: 'スタッフ一覧(旧)',
                link: '/staff_managementold',
              },
              {
                name: 'スタッフ一覧(新)',
                link: '/staff',
              },
            ]
          },
        ],
        setting_lists: [
          {
            name: 'アカウント情報',
            icon: 'mdi-account',
            link: '/'
          },
        ],
      }
    },
    methods: {
      menu_close(){
        this.nav_lists.forEach( nav_list => nav_list.active = false)
      }
    },

  }
</script>

<style>

</style>