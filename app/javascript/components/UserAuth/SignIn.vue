<template>
  <v-app>
    <v-card class="mx-lg-auto mx-sm-auto mx-md-auto mx-5 my-auto rounded-lg topborder SignInWrapper">
      <v-card-title class="mt-16">
        <v-img
          :src="login_top_image"
          max-height="40"
          max-width="150"
          class="mx-auto"
        >
        </v-img>
      </v-card-title>
      <p class="text-subtitle-2 text-center">ログイン</p>
      <v-card-text>
        <v-form>
          <v-text-field outlined v-model="email" prepend-inner-icon="mdi-email" label="メールアドレス" placeholder="メールアドレス" />
          <v-text-field outlined v-model="password" v-bind:type="showPassword ? 'text' : 'password'" 
          prepend-inner-icon="mdi-lock" 
          v-bind:append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" 
          label="パスワード" 
          placeholder="パスワード"
          @click:append="showPassword = !showPassword" />
        </v-form>
      </v-card-text>
      <v-card-actions class="mb-16">
        <v-btn 
          rounded
          class="info mx-auto"
          width="100%"
          @click="submitForm"
        >
          ログイン
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-app>
</template>

<script>
  import Signin from '../../mixins/sign_in'
  import CsrfToken from '../../mixins/csrf'
  export default {
    data(){
      return {
        login_top_image: require('../../../assets/images/logos/shifton_logo_maincolor.png'),
        showPassword : false,
        email: '',
        password: '',
        errors: [],
      }
    },
    methods: {
      submitForm(e){
        e.preventDefault();
        this.errors = []
        if (this.email && this.password) {
          this.logIn(e)
        }else{
          console.log('emailまたはpasswordが不正です')
          this.errors.push('emailまたはpasswordが不正です');
        }
      }
    },
    mixins: [
      Signin,
      CsrfToken,
    ]
  }
</script>

<style>
  .topborder {
    border-top: 5px solid #b3e5fc !important;
  }

  @media screen and (min-width:768px) {
    .SignInWrapper {
      width: 400px;
    }
  }

</style>