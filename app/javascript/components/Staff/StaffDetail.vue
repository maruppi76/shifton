<template>
  <v-app class="grey lighten-5" v-if="this.user">
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >{{ this.user.full_name }}</v-card-title>
    </v-card>
      <v-card
        elevation="1"
        tile
        class="pa-5 ma-5"
      >
        <v-row>
          <v-col cols="4">
            <v-row>
              <v-col cols="7" class="mt-10">
                <p class="text-subtitle-1 mb-0">{{ this.user.first_name_kana }} {{ this.user.last_name_kana }}</p>
                <h1 class="mb-3">{{ this.user.full_name }}</h1>
                <v-chip label class="mb-2">{{ this.user.status }}</v-chip>
                <p>{{ this.user.department_main.str }}</p>
                <p>{{ this.user.email }}</p>
              </v-col>
              <v-col cols="5">
                <v-img
                  class="rounded-circle"
                  :aspect-ratio="1/1"
                  width="200px"
                  src="http://placehold.jp/c2c2c2/ffffff/200x200.png?text=No%20Image"
                ></v-img>
              </v-col>
            </v-row>
          </v-col>
          <v-col cols="8">
            <v-row justify="end" align-content="center" class="mr-2 mt-2">
              <v-icon>
                mdi-account-edit
              </v-icon>
            </v-row>
            <v-row>
              <v-col cols="6">
                <v-row>
                  <v-col cols="4" class="grey--text text--lighten-1 text-caption">
                    <v-subheader>スタッフコード</v-subheader>
                  </v-col>
                  <v-col cols="8">
                    <v-subheader
                      class="StaffDetailBB"
                    >{{ this.user.staff_code }}</v-subheader>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="6">
                <v-row>
                  <v-col cols="4" class="grey--text text--lighten-1 text-caption">
                    <v-subheader>入社日</v-subheader>
                  </v-col>
                  <v-col cols="8">
                    <v-subheader
                      class="StaffDetailBB"
                      v-if="this.user.joining_date"
                    >{{ this.user.joining_date }}</v-subheader>
                    <v-subheader
                      class="StaffDetailBB"
                      v-else
                    >データなし</v-subheader>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="12">
                <v-row>
                  <v-col cols="2" class="grey--text text--lighten-1 text-caption">
                    <v-subheader>所属部署(メイン)</v-subheader>
                  </v-col>
                  <v-col cols="10">
                    <v-subheader
                      class="StaffDetailBB"
                    >{{ this.user.department_main.str }}</v-subheader>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="12">
                <v-row>
                  <v-col cols="2" class="grey--text text--lighten-1 text-caption">
                    <v-subheader>所属部署(サブ)</v-subheader>
                  </v-col>
                  <v-col cols="10">
                    <v-subheader
                      class="StaffDetailBB"
                      v-if="this.user.department_sub"
                    >{{ this.user.department_sub.str }}</v-subheader>
                    <v-subheader
                      class="StaffDetailBB"
                      v-else
                    >データなし</v-subheader>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card>    
  </v-app>
</template>

<script>
import axios from 'axios';
export default {
  props: {id: Number},

  data() {
    return{
      user: '',
    }
  },
  mounted() {
    axios.get(`/api/users/${this.id}.json`)
      .then(response => {
        this.user = response.data
        console.log(this.user)
      })
  }
}
</script>

<style>
.StaffDetailBB {
  border-bottom: 1px solid #E0E0E0 !important;
}
</style>