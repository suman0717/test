import 'dart:math';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/linkOpener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/password_reset_success.dart';
import 'package:radreviews/screens/registration_success.dart';
import 'package:radreviews/screens/signup.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> locationListTemp=[''];
var _restformKey = GlobalKey<FormState>();
class EnterNewPWD extends StatefulWidget {
  @override
  _EnterNewPWDState createState() => _EnterNewPWDState();
}

class _EnterNewPWDState extends State<EnterNewPWD> {
  var ctrlPWDReset = TextEditingController();
  var ctrlPWDCnfReset = TextEditingController();
  bool _waiting = false;
  String _enteredOTP;
  String _message='';
  String forgotEmailAddress;
  String _password;
  String _confirm_Password;
  String _serverPassword;
  bool _isHiddenPwd = true;
  bool _isHiddenCnfPwd = true;

  void validationOTPMessage(String errormsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5.0,
            title: Text(
              'Error:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 3.0 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    errormsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool validateOTP(String number) {
    print(number);
    if (number.length != 6) {
      validationOTPMessage('Please enter correct verification code');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {


    void _toggleVisibilityPwdRest() {
      setState(() {
        _isHiddenPwd = !_isHiddenPwd;
      });
    }

    void _toggleVisibilityCnfPwdRest() {
      setState(() {
        _isHiddenCnfPwd = !_isHiddenCnfPwd;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: ModalProgressHUD(
        inAsyncCall: _waiting,
        child: Form(key: _restformKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0 * SizeConfig.heightMultiplier,
                  ),
                  Image.asset(
                    'images/radcolored.png',
                    width: 24.3 * SizeConfig.widthMultiplier,
                    height: 18.2 * SizeConfig.heightMultiplier,
                  ),
                  SizedBox(
                    height: 5.3 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    'Enter New Password',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 2.3 * SizeConfig.heightMultiplier,
                      color: const Color(0xff1a1a1a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 6.3 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0, top: 20),
                    child: Text(
                      'New Password',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.7 * SizeConfig.heightMultiplier,
                        color: const Color(0xffa1a1a1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: TextFormField(controller: ctrlPWDReset,
                      validator: (String value){
                        if(value.length<8){
                          return 'Password must have atleast 8 characters';
                        }
                      },
                      textAlign: TextAlign.center,
                      obscureText: _isHiddenPwd,
                      onChanged: (value) {
                        _password = value;
                      },
                      style: TextStyle(
                          fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _toggleVisibilityPwdRest,
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
                      'Confirm New Password',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.7 * SizeConfig.heightMultiplier,
                        color: const Color(0xffa1a1a1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: TextFormField(controller: ctrlPWDCnfReset,
                      validator: (String value){
                        if(ctrlPWDReset.text!=ctrlPWDCnfReset.text){
                          return 'Password did not match';
                        }
                      },
                      textAlign: TextAlign.center,
                      obscureText: _isHiddenCnfPwd,
                      onChanged: (value) {
                        confirm_Password = value;
                      },
                      style: TextStyle(
                          fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _toggleVisibilityCnfPwdRest,
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
                  SizedBox(
                    height: 6.3 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    width: 68.2 * SizeConfig.widthMultiplier,
                    height: 5.65 * SizeConfig.heightMultiplier,
                    child: RaisedButton(color: kshadeColor1,
                      onPressed: () async {

                          if(_restformKey.currentState.validate()){
                            setState(() {
                              _waiting=true;
                            });
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            String _tempUserID=sharedPreferences.get('tempUserID');
                            print(_tempUserID);
                            print(_password);
                            FocusManager.instance.primaryFocus.unfocus();
                            http.Response _response =await http.get(kURLBase +
                              'REST/REVIEWS/App_SetNewPWD?Temp_pdw=$_password&CUID=$_tempUserID');
                            print(_response.body);
                            var _responseBody = _response.body;
                            var _error = jsonDecode(_responseBody)['Error'];
                            print(_error);
                            if(_error=='No Error'){
                              await Flushbar(
                                titleText: Text(
                                  'Reset Successful',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 2.0 * SizeConfig.heightMultiplier,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                messageText: Text(
                                  'You successfully reset your password.',
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
                                  Icons.check,
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResetSuccess()));
                            }
                            setState(() {
                              _waiting=false;
                            });
                          print('Validated');
                          }

                        setState(() {
                          _waiting=false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.63 * SizeConfig.heightMultiplier)),
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 2.0 * SizeConfig.heightMultiplier,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.95 * SizeConfig.heightMultiplier,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

