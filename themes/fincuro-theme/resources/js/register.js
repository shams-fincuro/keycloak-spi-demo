Vue.component('validation-provider', VeeValidate.ValidationProvider);
Vue.component('validation-observer', VeeValidate.ValidationObserver);
Vue.use(VeeValidate);

const {ValidationObserver, ValidationProvider, extend} = VeeValidate
const {required, email, numeric, min, max, length} = VeeValidate.Rules

extend ('phonenumval', (value) => {
    const regex = /^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\./0-9]*$/g;
    if (regex.test(value)) {
        return true
    }
    return 'The {_field_} is invalid';
});

extend('zipcode', (value) => {
    const regex = /^\d{5}$|^\d{9}$|^\d{5}( |-)\d{4}$|^[A-Za-z]\d[A-Za-z](( |-)?)\d[A-Za-z]\d$/
    if (regex.test(value)) {
        return true
    }
    return 'The {_field_} is invalid ';
});

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
        firstName: '',
        lastName: '',
        printedCardNumber: '',
        email: '',
        mobilePhone: '',
        zipCode: '',
        password: '',
        passwordConfirm: '',
        showPassword: false,
        showPasswordConfirm: false,
        iHaveCardNum: false,
        emailKcErr: true,
        phoneKcErr: true,
        disableSignUp: false,
    },
    created() {
        const fname = document.getElementById('firstName');
        const lname = document.getElementById('lastName');
        const pcnumber = document.getElementById('printedCardNumber');
        const mail = document.getElementById('email');
        const phonenum = document.getElementById('mobilePhone');
        const zcode = document.getElementById('postalCode');

        const firstName = fname.dataset.firstName;
        const lastName = lname.dataset.lastName;
        const printedCardNumber = pcnumber.dataset.printedCardNumber;
        const email = mail.dataset.email;
        const phoneNumber = phonenum.dataset.mobilePhone;
        const zipCode = zcode.dataset.postalCode;

        this.firstName = firstName;
        this.lastName = lastName;
        this.printedCardNumber = printedCardNumber;
        this.email = email;
        this.mobilePhone = phoneNumber;
        this.zipCode = zipCode;
    },
    methods: {
        showPass(type) {
            if(type === 'passwordConfirm') {
                this.showPasswordConfirm = !this.showPasswordConfirm;
            } else {
                this.showPassword = !this.showPassword;
            }
        },
        sendGTM() {
            dataLayer.push({event:'sign-in', data: this.email});
        },
        disableBtn() {
            this.disableSignUp = true;
        },
        emailErrDel() {
            this.emailKcErr = false;
        },
        phoneErrDel() {
            this.phoneKcErr = false;
        }
    }
});