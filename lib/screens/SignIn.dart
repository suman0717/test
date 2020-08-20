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
import 'package:radreviews/screens/homenew.dart';
import 'package:radreviews/screens/otp_forgotPassword.dart';
import 'package:radreviews/screens/registration_success.dart';
import 'package:radreviews/screens/signup.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> locationListTemp = [''];
class XDSignIn extends StatefulWidget {
  @override
  _XDSignInState createState() => _XDSignInState();
}

class _XDSignInState extends State<XDSignIn> {
  String username;
  String password;
  String serverUsername;
  String serverPassword;
  bool _waiting = false;
  bool _waiting_Forgot = false;
  String message = '';

  String accountStatus = '';
  String forgotEmailAddress;
  int _len;
  bool isButtonEnabled=true;

  void ShowForgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5.0,
          title: Text(
            'Password Recovery',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              color: const Color(0xff363636),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68.2 * SizeConfig.widthMultiplier,
                  height: 5.65 * SizeConfig.heightMultiplier,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      forgotEmailAddress = value;
                    },
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                    ),
                    decoration: kTextFieldDecorationNoback.copyWith(
                      hintText: 'Email Address',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 1.5 * SizeConfig.heightMultiplier,
                          horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 68.2 * SizeConfig.widthMultiplier,
                  height: 5.65 * SizeConfig.heightMultiplier,
                  child: RaisedButton(color: kshadeColor1,
                    onPressed: () async {
                      FocusManager.instance.primaryFocus.unfocus();
                      int _otp;
                      print('clicked');
                      if (forgotEmailAddress != null) {
                        Flushbar(
                          titleText: Text(
                            'Checking User. . . ',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 2.0 * SizeConfig.heightMultiplier,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          messageText: Text(
                            'Email will be sent once we validate email address',
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
                            Icons.priority_high,
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
                              offset: Offset(0, 10), // changesvalue position of shadow
                            ),
                          ],
                          backgroundColor: kshadeColor1,
                        ).show(context);
                        Random _random = Random();
                        _otp = _random.nextInt(999999);
                        print(_otp);
                        if (_otp < 100000) {
                          _otp = _otp + 100000;
                        }

                        http.Response _response = await http.get(kURLBase +
                            'REST/REVIEWS/App_ForgotPWD?EmailAddress=$forgotEmailAddress&OTP=$_otp');
                        print(kURLBase +
                            'REST/REVIEWS/App_ForgotPWD?EmailAddress=$forgotEmailAddress&OTP=${_otp.toString()}');
                        print(_response.body);
                        var _responseBody=_response.body;
                        String _errormessage = jsonDecode(_responseBody)['Error'];
                        print(_errormessage);
                        if(_errormessage !='No Error'){
                          Flushbar(
                            titleText: Text(
                              'User does not exists',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 2.0 * SizeConfig.heightMultiplier,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            messageText: Text(
                              'User with email address does not exist in our system',
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
                              Icons.clear,
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
                                offset: Offset(0, 10), // changesvalue position of shadow
                              ),
                            ],
                            backgroundColor: kshadeColor1,
                          ).show(context);

                        }
                        else{
                          serverOTP=jsonDecode(_responseBody)['OTP'];
                          forgotClientUserID=jsonDecode(_responseBody)['CUID'];

                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setString('tempUserID', forgotClientUserID);
                          sharedPreferences.setString('serverOTP', serverOTP);
                          print(serverOTP);
                          print(forgotClientUserID);
                          if(forgotClientUserID!=null && serverOTP!=null){
                            await Flushbar(
                              titleText: Text(
                                'Email Sent',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 2.0 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              messageText: Text(
                                'An email with one time password has been sent on your registered email address.',
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
                                  offset: Offset(0, 10), // changesvalue position of shadow
                                ),
                              ],
                              backgroundColor: kshadeColor1,
                            ).show(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EnterOTP()));}
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            2.63 * SizeConfig.heightMultiplier)),
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      'Send Email',
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
              ],
            ),
          ),
        );
      },
    );
  }



  GetUserLogin(String urlString) async {
    print(urlString);
    http.Response response = await http.get(urlString);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = response.body;
    serverUsername = jsonDecode(data)['UserName'];
    serverPassword = jsonDecode(data)['Decrypted_Password'];
    accountStatus = jsonDecode(data)['Account_Status'];
    sharedPreferences.setString('curuser', jsonDecode(data)['UserName']);
    curUserName = sharedPreferences.get('curuser');
    sharedPreferences.setString(
        'curUserPWD', jsonDecode(data)['Decrypted_Password']);
    curPassword = sharedPreferences.get('curUserPWD');
    sharedPreferences.setString(
        'business_Name', jsonDecode(data)['Business_Name']);
    curbusinessName = sharedPreferences.get('business_Name');
    sharedPreferences.setString(
        'business_Num', jsonDecode(data)['Business_Num']);
    businessnumber = sharedPreferences.get('business_Num');
    sharedPreferences.setString(
        'maskedbusiness_Num', jsonDecode(data)['Business_Num_Masked']);
    maskedbusinessnumber = sharedPreferences.get('maskedbusiness_Num');
    sharedPreferences.setString(
        'account_Status', jsonDecode(data)['Account_Status']);
    curaccountStatus = sharedPreferences.get('account_Status');
    sharedPreferences.setString('clientID', jsonDecode(data)['CID']);
    curClientID = sharedPreferences.get('clientID');
    sharedPreferences.setString('mobile', jsonDecode(data)['Mobile']);
    unmasked_mobile = sharedPreferences.get('mobile');
    sharedPreferences.setString(
        'maskedMobile', jsonDecode(data)['Mobile_Masked']);
    masked_mobile = sharedPreferences.get('maskedMobile');
    sharedPreferences.setString('cUID', jsonDecode(data)['CUID']);
    curClientUserID = sharedPreferences.get('cUID');
    sharedPreferences.setString('first_Name', jsonDecode(data)['First_Name']);
    curUserFName = sharedPreferences.get('first_Name');
    sharedPreferences.setString('surname', jsonDecode(data)['Surname']);
    curUserSName = sharedPreferences.get('surname');
    sharedPreferences.setString('country', jsonDecode(data)['Country']);
    country = sharedPreferences.get('country');
    sharedPreferences.setString(
        'feedBack_FollowUP', jsonDecode(data)['FeedBack_FollowUP']);
    feedBack_FollowUP = sharedPreferences.get('feedBack_FollowUP');
    sharedPreferences.setInt(
        'feedback_FollowUp_Days', jsonDecode(data)['Feedback_FollowUp_Days']);
    feedback_FollowUp_Days =
        sharedPreferences.get('feedback_FollowUp_Days').toString();
    sharedPreferences.setString(
        'smsFeedbackWording', jsonDecode(data)['SMSFeedbackWording']);
    smsFeedbackWording = sharedPreferences.get('smsFeedbackWording');
    sharedPreferences.setString('smsFeedback_Followup_Wording',
        jsonDecode(data)['SMSFeedback_Followup_Wording']);
    smsFeedback_Followup_Wording =
        sharedPreferences.get('smsFeedback_Followup_Wording');
    String _cid = sharedPreferences.get('clientID');
    print(sharedPreferences.get('curuser'));
    print(sharedPreferences.get('clientID'));
    print(sharedPreferences.get('feedBack_FollowUP'));
    print(sharedPreferences.get('feedback_FollowUp_Days'));
    print(sharedPreferences.get('smsFeedbackWording'));
    print(sharedPreferences.get('smsFeedback_Followup_Wording'));
    print(feedBack_FollowUP);
    print(feedback_FollowUp_Days);
    print(smsFeedbackWording);
    print(smsFeedback_Followup_Wording);
    print(_cid);
    print(kURLBase + 'REST/REVIEWS/Get_Location?Client=$_cid');

    if (curaccountStatus == 'Active') {
      http.Response _locationResponse =
          await http.get(kURLBase + 'REST/REVIEWS/Get_Location?Client=$_cid');
      try {
        var _locationData = _locationResponse.body;

        print(_locationData);

        List _localData = jsonDecode(_locationData)["response"];

        if (_localData != null) {
          _len = _localData.length;
        }

        if (_localData != null) {
          print('test4');
          locationListTemp = [];
//        TODO Implement length
          for (int i = 0; i < _len; i++) {
            var _lodata = _localData[i];
            locationListTemp.add(_lodata["Location_Name"]);
          }
        } else {
          print('test5');
          locationListTemp = [];
          print(locationListTemp);
          var _localData = jsonDecode(_locationData);
          print(_localData);
          locationListTemp.add(_localData["Location_Name"]);
          selectedlocation = _localData[
              "Location_Name"]; //this will initiate if client have only 1 location
        }
      } catch (e) {
        locationListTemp = ['No Location'];
        print(e);
      }
    }
    print(locationListTemp);

    print(locationListTemp.length);
    sharedPreferences.setStringList('loc', locationListTemp);
    print(sharedPreferences.get('loc'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: ModalProgressHUD(
        inAsyncCall: _waiting,
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
                  'Sign in to your account',
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
                Container(
                  width: 68.2 * SizeConfig.widthMultiplier,
                  height: 5.65 * SizeConfig.heightMultiplier,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      username = value;
                    },
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                    ),
                    decoration: kTextFieldDecorationNoback.copyWith(
                      hintText: 'Username',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 1.5 * SizeConfig.heightMultiplier,
                          horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.9 * SizeConfig.heightMultiplier,
                ),
                Container(
                  width: 68.2 * SizeConfig.widthMultiplier,
                  height: 5.65 * SizeConfig.heightMultiplier,
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                    ),
                    decoration: kTextFieldDecorationNoback.copyWith(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 1.5 * SizeConfig.heightMultiplier,
                          horizontal: 20.0),
                    ),
                  ),
                ),
                Visibility(
                    visible: message != '',
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        message,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 1.5 * SizeConfig.heightMultiplier),
                      ),
                    )),
                SizedBox(
                  height: 5.3 * SizeConfig.heightMultiplier,
                ),
                Container(
                  width: 68.2 * SizeConfig.widthMultiplier,
                  height: 5.65 * SizeConfig.heightMultiplier,
                  child:
                  RaisedButton(color: kshadeColor1,
                    onPressed: () async {
                      setState(() {
                        _waiting = true;
                      });
                      if (username != null && password != null) {
                        await GetUserLogin(kURLBase +
                            'REST/REVIEWS/App_GetUserDetails?UserName=$username&Temp_pdw=$password');
                        setState(() {
                          _waiting = false;
                        });
                        if(username != null && serverUsername != null){
                        if (username.toLowerCase() == serverUsername.toLowerCase() &&
                            password == serverPassword) {
                          if (accountStatus == 'Active') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Success(),
                              ),
                            );
                          }
                        }}
                        else {
                          message = '*Username or Password is Incorrect';
                        }
                      }
                      setState(() {
                        _waiting = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            2.63 * SizeConfig.heightMultiplier)),
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      'Sign In',
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
                GestureDetector(
                  onTap: () {
                    print('Forgot Password Tapped');
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterOTP()));
                    ShowForgotPassword();
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 2.23 * SizeConfig.heightMultiplier,
                      color: kshadeColor1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 7.23 * SizeConfig.heightMultiplier,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 2.23 * SizeConfig.heightMultiplier,
                        color: const Color(0xff1a1a1a),
                      ),
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                            text: ' Sign Up',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 2.23 * SizeConfig.heightMultiplier,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 5.92 * SizeConfig.heightMultiplier,
                ),
                RawMaterialButton(
                  child: Container(
                    child: SvgPicture.string(
                      _svg_731xhc,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  elevation: 6.0,
                  onPressed: () {
                    QuickLaunchLink().hitLink(
                        'mailto:support@ethink.solutions?subject=Need%20Help&body=Hi%20Support');
                  },
                ),
                SizedBox(
                  height: 2.63 * SizeConfig.heightMultiplier,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _svg_731xhc =
    '<svg viewBox="167.0 724.6 41.1 41.1" ><path transform="translate(167.0, 724.56)" d="M 20.530517578125 0 C 9.192509651184082 0 0.001000000047497451 9.19178295135498 0.001000000047497451 20.5297908782959 C 0.001000000047497451 31.86752700805664 9.192509651184082 41.06000137329102 20.530517578125 41.06000137329102 C 31.86853218078613 41.06000137329102 41.06072235107422 31.86753082275391 41.06072235107422 20.52979469299316 C 41.06072235107422 9.19178295135498 31.86853218078613 0 20.530517578125 0 Z M 20.53092765808105 7.211029529571533 L 32.67974090576172 14.78667449951172 L 8.382115364074707 14.78667449951172 L 20.53092765808105 7.211029529571533 Z M 32.83111953735352 26.88402938842773 L 32.82988739013672 26.88402938842773 C 32.82988739013672 28.09914398193359 31.84512138366699 29.08377265930176 30.63014602661133 29.08377265930176 L 10.43171215057373 29.08377265930176 C 9.216598510742188 29.08377265930176 8.23197078704834 28.09900856018066 8.23197078704834 26.88402938842773 L 8.23197078704834 15.26872444152832 C 8.23197078704834 15.14020442962646 8.245109558105469 15.01524448394775 8.266460418701172 14.8924732208252 L 19.87396621704102 22.13046646118164 C 19.88819885253906 22.13936233520508 19.90338897705078 22.14538383483887 19.91803741455078 22.15359497070312 C 19.93336296081543 22.16208076477051 19.94896697998047 22.17029571533203 19.96457099914551 22.1780948638916 C 20.04655265808105 22.22039031982422 20.13100242614746 22.25447082519531 20.21736526489258 22.27677726745605 C 20.22626304626465 22.27924156188965 20.23515892028809 22.28033638000488 20.24405670166016 22.28238677978516 C 20.33876991271973 22.3046989440918 20.43471145629883 22.31865882873535 20.53052139282227 22.31865882873535 L 20.53120613098145 22.31865882873535 C 20.53189086914062 22.31865882873535 20.53257369995117 22.31865882873535 20.53257369995117 22.31865882873535 C 20.62838172912598 22.31865882873535 20.72432518005371 22.30510902404785 20.81904029846191 22.28238677978516 C 20.82793617248535 22.28019714355469 20.83683204650879 22.27924156188965 20.84572982788086 22.27677726745605 C 20.93195724487305 22.25447082519531 21.01612854003906 22.22038841247559 21.09852600097656 22.1780948638916 C 21.11412811279297 22.17029571533203 21.12973022460938 22.16208076477051 21.14505767822266 22.15359497070312 C 21.15956687927246 22.1453857421875 21.17489624023438 22.13936233520508 21.18913078308105 22.13046646118164 L 32.796630859375 14.8924732208252 C 32.8179817199707 15.01524448394775 32.83112335205078 15.13992977142334 32.83112335205078 15.26872444152832 L 32.83112335205078 26.88402938842773 Z" fill="#971a9f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

void SignIn(String uid, String pwd) {
  if (uid != null && pwd != null) {
    print('$uid-$pwd');
  }
}
