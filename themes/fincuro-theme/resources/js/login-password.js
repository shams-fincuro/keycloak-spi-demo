Vue.component('validation-provider', VeeValidate.ValidationProvider);
Vue.component('validation-observer', VeeValidate.ValidationObserver);
Vue.use(VeeValidate);

const {ValidationObserver, ValidationProvider, extend} = VeeValidate
const {required, email} = VeeValidate.Rules

extend('passwordstrength', (value) => {
    const regex = /^(?=(.*[a-z]){0,})(?=(.*[A-Z]){0,})(?=(.*[0-9]){0,})(?=(.*[!\"#\\$%&'\\(\\)\\*\\+,\\-\\./:;<=>\\?@\\[\\\\\\]\\^_`\\{\\|\\}~]){0,}).{6,}$/;
    if (regex.test(value)) {
      var matches = value.match(regex).filter((el)=>el===undefined)
      const [,lowercase,uppercase,number] = value.match(regex)
      if(!lowercase) {
        return 'The {_field_} must contain a lowercased letter';
      }
      if(!uppercase) {
        return 'The {_field_} must contain a uppercased letter';
      }
      if(!number) {
        return 'The {_field_} must contain a number';
      }
      if(matches <=1) {
        return true
      }
    }
    return 'The {_field_} must contain at least 6 characters';
});

var register = new Vue({
    el: '#kc-form',
    data: {
        username: '',
        password: '',
        passwordConfirm: '',
        showPassword: false,
        showPasswordConfirm: false,
    },
    methods: {
        showPass(type) {
            if(type === 'passwordConfirm') {
                this.showPasswordConfirm = !this.showPasswordConfirm;
            } else {
                this.showPassword = !this.showPassword;
            }
        },
        sendLoginGTM() {
          dataLayer.push({event:'log-in', data: this.username});
        },
        sendRecoveryGTM() {
          dataLayer.push({event:'recover-password', data: this.username});
        }
    }
});