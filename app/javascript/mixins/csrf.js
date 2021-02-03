import axios from 'axios';
export default {
  methods:{
    getCsrfToken(){
     if (!(axios.defaults.headers.common['X-CSRF-Token'])) {
       return (
         document.getElementsByName('csrf-token')[0].getAttribute('content')
       )
       } 
     else {
       return (  
         axios.defaults.headers.common['X-CSRF-Token']
       )
     }
   },
   setAxiosDefaults(){
     axios.defaults.headers.common['X-CSRF-Token'] = this.getCsrfToken();
     axios.defaults.headers.common['Accept'] = 'application/json';
     console.log(axios.defaults.headers.common['X-CSRF-Token']);
   },
   updateCsrfToken(csrf_token){
    axios.defaults.headers.common['X-CSRF-Token'] = csrf_token;
  },
  }
}
