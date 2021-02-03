import axios from 'axios';
export default {
  data(){
    return{
      errors:[]
    }
  },
  
  methods:{
    logIn(event){
      event.preventDefault()
      this.setAxiosDefaults();
      return (
        axios.post('/users/sign_in', {
          user: {
            email: this.email,
            password: this.password,
          }
        })
        .then(response => {
          console.log('OK!')
          this.updateCsrfToken(response.data.csrf_token);
          this.$store.commit("setCurrentUser",response.data.result)
          this.$router.push('/');
        })
        .catch(error => {
          console.log(error)
          this.errors.push('emailまたはpasswordが不正です');
        })
      )
    },
  }
}