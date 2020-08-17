import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radreviews/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:radreviews/screens/registration_success.dart';
import 'package:radreviews/screens/termsand%20conditins.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';

var mobileMaskUSA = MaskTextInputFormatter(
    mask: "(###) ###-####", filter: {"#": RegExp(r'[0-9]')});
var mobileMaskAustralia = MaskTextInputFormatter(
    mask: "####-###-###", filter: {"#": RegExp(r'[0-9]')});

String _country ='Australia';
String businessName;
String businessContactName;
String BusinessContactEmail;
String businessContactNumber;
String maskedBusinessmobile;
String firstName;
String surname;
String userName;
String mobile;
String maskedUserMobile;
String password;
String confirm_Password;
bool termsAndCondition = true;
bool waiting = false;
String serverUsername;
String serverPassword;
String error='No Error';

var ctrlBusinessaName = TextEditingController();
var ctrlBusinessContactName = TextEditingController();
var ctrlBusinessContactEmail = TextEditingController();
var ctrlBusinessContactNumber = TextEditingController();
var ctrlUserFirstName = TextEditingController();
var ctrlUserSurame = TextEditingController();
var ctrlUserMobile = TextEditingController();
var ctrlUserUserName = TextEditingController();
var ctrlUserPassword = TextEditingController();
var ctrlUserCnfPassword = TextEditingController();


var _formKey = GlobalKey<FormState>();

GetUserLogin(String urlString) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  print(urlString);
  http.Response response = await http.get(urlString);
  String data = response.body;
  print(data);
  sharedPreferences.setString('curuser', jsonDecode(data)['UserName']);
  curUserName=sharedPreferences.get('curuser');
  sharedPreferences.setString('curUserPWD', jsonDecode(data)['Decrypted_Password']);
  curPassword=sharedPreferences.get('curUserPWD');
  sharedPreferences.setString('business_Name', jsonDecode(data)['Business_Name']);
  curbusinessName=sharedPreferences.get('business_Name');
  sharedPreferences.setString('business_Num', jsonDecode(data)['Business_Num']);
  businessnumber=sharedPreferences.get('business_Num');
  sharedPreferences.setString('maskedbusiness_Num', jsonDecode(data)['Business_Num_Masked']);
  maskedbusinessnumber=sharedPreferences.get('maskedbusiness_Num');
  sharedPreferences.setString('account_Status', jsonDecode(data)['Account_Status']);
  curaccountStatus=sharedPreferences.get('account_Status');
  sharedPreferences.setString('clientID', jsonDecode(data)['CID']);
  curClientID=sharedPreferences.get('clientID');
  sharedPreferences.setString('mobile', jsonDecode(data)['Mobile']);
  unmasked_mobile=sharedPreferences.get('mobile');
  sharedPreferences.setString('cUID', jsonDecode(data)['CUID']);
  curClientUserID=sharedPreferences.get('cUID');
  sharedPreferences.setString('first_Name', jsonDecode(data)['First_Name']);
  curUserFName=sharedPreferences.get('first_Name');
  sharedPreferences.setString('surname', jsonDecode(data)['Surname']);
  curUserSName=sharedPreferences.get('surname');
  sharedPreferences.setString('country', jsonDecode(data)['Country']);
  sharedPreferences.setString('maskedMobile', jsonDecode(data)['Mobile_Masked']);
  masked_mobile=sharedPreferences.get('maskedMobile');
  error=jsonDecode(data)['Error'];
  print(error);
  country=sharedPreferences.get('country');
  print(sharedPreferences.get('curuser'));
  print(sharedPreferences.get('clientID'));

  String _cid = sharedPreferences.get('clientID');
  print(_cid);
  serverUsername = jsonDecode(data)['UserName'];
  serverPassword = jsonDecode(data)['Decrypted_Password'];
  curClientID=sharedPreferences.get('clientID');
  curClientUserID=sharedPreferences.get('cUID');
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isHiddenPwd = true;
  bool _isHiddenCnfPwd = true;

  @override
  void dispose() {
    ctrlBusinessaName.dispose();
    ctrlBusinessContactName.dispose();
    ctrlBusinessContactEmail.dispose();
    ctrlBusinessContactNumber.dispose();
    ctrlUserFirstName.dispose();
    ctrlUserSurame.dispose();
    ctrlUserMobile.dispose();
    ctrlUserUserName.dispose();
    ctrlUserPassword.dispose();
    ctrlUserCnfPassword.dispose();

    super.dispose();
  }

  void _toggleVisibilityPwd() {
    setState(() {
      _isHiddenPwd = !_isHiddenPwd;
    });
  }

  void _toggleVisibilityCnfPwd() {
    setState(() {
      _isHiddenCnfPwd = !_isHiddenCnfPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: waiting,
        color: Color(0xff3ba838),
        opacity: 0.1,
        child: Column(
          children: [
            Container(
              height: 12.25 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.15, -0.25),
                  end: Alignment(-1.08, -0.32),
                  colors: [const Color(0xff1b0e97), const Color(0xff881c8e)],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'REGISTER',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3.3 * SizeConfig.heightMultiplier,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(6.35 * SizeConfig.widthMultiplier, 2.63 * SizeConfig.heightMultiplier, 6.35 * SizeConfig.widthMultiplier, 0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Create an acocount',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 2.36 * SizeConfig.heightMultiplier,
                            color: const Color(0xff363636),
                            fontWeight: FontWeight.w500,
                            height: 0.2 * SizeConfig.heightMultiplier,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 1.3 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier),
                          child: Text(
                            'Country',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
//                          height: 5.13 * SizeConfig.heightMultiplier,
                          width: 68.2 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.95 * SizeConfig.heightMultiplier),
                            border: Border.all(color: Color(0xffe8e8e8),width: 1.0),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
//                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,size: 2.5 * SizeConfig.heightMultiplier,
                              ),
                              underline: Container(
                                height: 1.0,
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0)),
                                ),
                              ),
                              value: _country,
                              items: countryList.map(
                                (String dropdownitem) {
                                  return DropdownMenuItem<String>(
                                    value: dropdownitem,
                                    child: Text(dropdownitem,style: TextStyle(
                                        fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),),
                                  );
                                },
                              ).toList(),
                              onChanged: (String newselectedCountry) {
                                setState(
                                  () {
                                    _country = newselectedCountry;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                          child: Text(
                            'Business Name',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlBusinessaName,
                            validator: (String value){
                            if(value.isEmpty){
                              return 'Business Name must be provided';
                            }
                            },
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              businessName = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                                hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                            ,
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'Business Contact Name',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlBusinessContactName,
                            validator: (String value){
                            if(value.isEmpty){
                              return 'Business contact name Must be provided';
                            }
                            },
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              businessContactName = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'Business Contact Email',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlBusinessContactEmail,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Email address must be provided';
                                }
                                else if(EmailValidator.validate(value)!=true){
                                  return 'Please enter a valid email';
                                }
                              },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              BusinessContactEmail = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'Business Contact Number',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlBusinessContactNumber,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Mobile number must be provided';
                                }
                                else if(!(value.startsWith('0'))){
                                  return 'Number should starts with 0';
                                }
                                else if(value.length!=12){
                                  return 'Please provide the Correct Number';
                                }
                              },
                              inputFormatters: [
                                _country == 'Australia'
                                    ? mobileMaskAustralia
                                    : mobileMaskUSA
                              ],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              businessContactNumber = (_country == 'Australia'
                                  ? mobileMaskAustralia
                                  : mobileMaskUSA)
                                  .getUnmaskedText();
                              maskedBusinessmobile=(_country == 'Australia'
                                  ? mobileMaskAustralia
                                  : mobileMaskUSA)
                                  .getMaskedText();
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'User\'s First Name',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlUserFirstName,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'User\'s first name Must be provided';
                                }
                              },
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              firstName = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'User\'s Surname',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlUserSurame,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'User\'s Surname Must be provided';
                                }
                              },
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              surname = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'User\'s mobile number',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlUserMobile,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Mobile number must be provided';
                                }
                                else if(!(value.startsWith('0'))){
                                  return 'Number should starts with 0';
                                }
                                else if(value.length!=12){
                                  return 'Please provide the Correct Number';
                                }
                              },
                              inputFormatters: [
                                _country == 'Australia'
                                    ? mobileMaskAustralia
                                    : mobileMaskUSA
                              ],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              mobile = (_country == 'Australia'
                                  ? mobileMaskAustralia
                                  : mobileMaskUSA)
                                  .getUnmaskedText();
                              maskedUserMobile=(_country == 'Australia'
                                  ? mobileMaskAustralia
                                  : mobileMaskUSA)
                                  .getMaskedText();
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'User\'s Email Address',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlUserUserName,
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'Email address must be provided';
                                }
                                else if(EmailValidator.validate(value)!=true){
                                  return 'Please enter a valid email';
                                }
                              },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              userName = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlUserPassword,
                            validator: (String value){
                              if(value.length<8){
                                return 'Password must have atleast 8 characters';
                              }
                            },
                            textAlign: TextAlign.center,
                            obscureText: _isHiddenCnfPwd,
                            onChanged: (value) {
                              password = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: _toggleVisibilityCnfPwd,
                                icon: _isHiddenCnfPwd
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 2.63 * SizeConfig.heightMultiplier,

                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                  size: 2.63 * SizeConfig.heightMultiplier,
                                      ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.05 * SizeConfig.heightMultiplier, horizontal: 2.63 * SizeConfig.heightMultiplier),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.95 * SizeConfig.heightMultiplier)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffe8e8e8), width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.95 * SizeConfig.heightMultiplier)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffe8e8e8), width: 2.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.95 * SizeConfig.heightMultiplier),
                                ),
                              ),
                            ),
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: TextFormField(controller: ctrlUserCnfPassword,
                            validator: (String value){
                              if(ctrlUserPassword.text!=ctrlUserCnfPassword.text){
                                return 'Password did not match';
                              }
                            },
                            textAlign: TextAlign.center,
                            obscureText: _isHiddenPwd,
                            onChanged: (value) {
                              confirm_Password = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: _toggleVisibilityPwd,
                                icon: _isHiddenPwd
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                  size: 2.63 * SizeConfig.heightMultiplier,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                  size: 2.63 * SizeConfig.heightMultiplier,
                                      ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.05 * SizeConfig.heightMultiplier, horizontal: 2.63 * SizeConfig.heightMultiplier),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.95 * SizeConfig.heightMultiplier)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffe8e8e8), width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.95 * SizeConfig.heightMultiplier)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffe8e8e8), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.95 * SizeConfig.heightMultiplier)),
                              ),
                            ),
                          ),
                          width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.31 * SizeConfig.heightMultiplier, horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  activeColor: kshadeColor1,
                                  value: termsAndCondition,
                                  onChanged: (bool newvalue) {
                                    setState(() {
                                      termsAndCondition = newvalue;
                                    });
                                  }),
                          GestureDetector(onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TandC(kURLTerms),
                              ),
                            );
                          },
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xff363636),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'I agree to ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'RAD Reviews Terms.',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 1.7 * SizeConfig.heightMultiplier,
                                        color: Colors.blue,
                                  ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),


                            ],
                          ),
                        ),
                        Container(
                          width: 68.2 * SizeConfig.widthMultiplier,
                          height: 5.65 * SizeConfig.heightMultiplier,
                          child: RaisedButton(
                            onPressed: () async {
                              setState(() {
                                waiting = true;
                              });
                              if (_formKey.currentState.validate()) {
                                await GetUserLogin(kURLBase +
                                    'REST/REVIEWS/Create_Client?Country=$_country&Business_Name=$businessName&Business_Contact=$businessContactName&Mobile=$businessContactNumber&EmailAddress=$BusinessContactEmail&First_Name=$firstName&User_mobile=$mobile&Surname=$surname&UserName=$userName&Temp_pdw=$password&Business_Num_Masked=$maskedBusinessmobile&Mobile_Masked=$maskedUserMobile');
                                setState(() {
                                  waiting = false;
                                });
                                if(curUserName != null && curPassword != null){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Success(),
                                    ),
                                  );
                                }
                                else{
                                  Flushbar(
                                    titleText: Text(
                                      error,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 2.0 * SizeConfig.heightMultiplier,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    messageText: Text(
                                      'Please Try Again.',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 1.3 * SizeConfig.heightMultiplier,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                                    icon: Icon(
                                      Icons.close,
                                      size: 3.94 * SizeConfig.heightMultiplier,
                                      color: Colors.white,
                                    ),
                                    duration: Duration(seconds: 3),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    borderColor: Colors.transparent,
                                    shouldIconPulse: false,
                                    maxWidth: 91.8 * SizeConfig.widthMultiplier,
                                    boxShadows: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1 * SizeConfig.heightMultiplier,
                                        blurRadius: 2 * SizeConfig.heightMultiplier,
                                        offset: Offset(0, 10), // changes position of shadow
                                      ),
                                    ],
                                    backgroundColor: kshadeColor1,
                                  ).show(context);

                                }
                              }
                              setState(() {
                                waiting = false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kshadeColor1,
                                    borderRadius:
                                        BorderRadius.circular(2.9 *SizeConfig.heightMultiplier)),
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 2.0 *SizeConfig.heightMultiplier,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.6 * SizeConfig.heightMultiplier,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
