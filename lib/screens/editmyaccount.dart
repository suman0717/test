import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/bottomBar.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/feedbackState.dart';
import 'package:radreviews/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:radreviews/screens/myaccount.dart';
import 'package:radreviews/screens/negFeedback.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/smsSent.dart';
import 'package:radreviews/screens/termsand%20conditins.dart';
import 'dart:convert';
import 'package:radreviews/size_config.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

String firstName=curUserFName;
String surname=curUserSName;
String userName=curUserName;
String mobile=unmasked_mobile;
String password=curPassword;
String confirm_Password;
String _maskednumber=masked_mobile;

var ctrlFirstName = TextEditingController(text: curUserFName);
var ctrlSurame = TextEditingController(text: curUserSName);
var ctrlMobile = TextEditingController(text: masked_mobile);
var ctrlUserName = TextEditingController(text: curUserName);
var ctrlPassword = TextEditingController(text: curPassword);
var ctrlCnfPassword = TextEditingController(text: curPassword);

var mobileMaskUSA = MaskTextInputFormatter(
    mask: "(###) ###-####", filter: {"#": RegExp(r'[0-9]')});
var mobileMaskAustralia = MaskTextInputFormatter(
    mask: "####-###-###", filter: {"#": RegExp(r'[0-9]')});

class EditMyAccount extends StatefulWidget {
  @override
  _EditMyAccountState createState() => _EditMyAccountState();
}
SharedPreferences sharedPreferences;
class _EditMyAccountState extends State<EditMyAccount> {

  bool _isHiddenPwd = true;
  bool _isHiddenCnfPwd = true;
  bool _waiting = false;


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
  void initState() {
    setState(() {
      _waiting = true;
    });
    getFeedback().whenComplete(() {
      setState(() {
        _waiting = false;
      });
    }).catchError((error, stackTrace) {
      setState(() {
        _waiting = false;
      });
      print("outer: $error");
    });
    super.initState();
  }


  Future<bool> getFeedback() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  void Logout() async {
    print(locationListTemp.length);
    locationListTemp = ['No Location'];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(locationListTemp.length);
    print(sharedPreferences.get('curuser'));
    await sharedPreferences.clear();
    print(sharedPreferences.get('curuser'));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => XDSignIn()));
  }

var _editFormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: _waiting,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            PopupMenuButton(
              offset: Offset(0, 200),
              icon: Icon(Icons.more_horiz),
              onSelected: (value) {
                if(value==1){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
                }
                else if(value==2){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAccount()));
                }
                else if(value==3){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackStats()));
                }
                else if(value==4){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SMSSent(),
                    ),
                  );
                }
                else if(value==5){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NegFeedback(),
                    ),
                  );
                }
                else if(value==6){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TandC(kURLTerms),
                    ),
                  );
                }
                else if(value==7){
                  Logout();
                };
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 1,
                ),
                PopupMenuItem(height: 1,
                  child: PopupMenuDivider(height: 1,
                  ),),
                PopupMenuItem(
                  child: Text(
                    'My Account',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 2,
                ),
                PopupMenuItem(height: 1,
                  child: PopupMenuDivider(height: 1,
                  ),),
                PopupMenuItem(
                  child: Text(
                    'Feedback Stats',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 3,
                ),
                PopupMenuItem(height: 1,
                  child: PopupMenuDivider(height: 1,
                  ),),
                PopupMenuItem(
                  child: Text(
                    'Feedback SMS Sent',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 4,
                ),
                PopupMenuItem(height: 1,
                  child: PopupMenuDivider(height: 1,
                  ),),
                PopupMenuItem(
                  child: Text(
                    'Feedback Negative',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 5,
                ),
                PopupMenuItem(height: 1,
                  child: PopupMenuDivider(height: 1,
                  ),),
                PopupMenuItem(
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 6,
                ),
                PopupMenuItem(height: 1,
                  child: PopupMenuDivider(height: 1,
                  ),),
                PopupMenuItem(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 7,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white, width: 1 * SizeConfig.heightMultiplier),
            color: kshadeColor1,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1 * SizeConfig.heightMultiplier,
                blurRadius: 2 * SizeConfig.heightMultiplier,
                offset: Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: IconButton(
            iconSize: 4 * SizeConfig.heightMultiplier,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
        body: ModalProgressHUD(
          inAsyncCall: _waiting,
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
                      'EDIT ACCOUNT',
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
                child: Form(
                  key: _editFormKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6.35 * SizeConfig.widthMultiplier, 2.63 * SizeConfig.heightMultiplier, 6.35 * SizeConfig.widthMultiplier, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Basic Information',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18,
                              color: const Color(0xff363636),
                              fontWeight: FontWeight.w500,
                              height: 0.2 * SizeConfig.heightMultiplier,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(
                                controller: ctrlFirstName,
                                validator: (String value){
                              if(value.isEmpty){
                                return 'First Name must be provided';
                              }
                                },
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  firstName = value;
                                },
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.5 * SizeConfig.heightMultiplier,
                                      horizontal: 20.0),
                                )),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Surname',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(controller: ctrlSurame,
                                validator: (String value){
                              if(value.isEmpty){
                                return 'Surname must be provided';
                              }
                                },
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  surname = value;
                                },
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.5 * SizeConfig.heightMultiplier,
                                      horizontal: 20.0),
                                )),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Mobile Number',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(inputFormatters: [
                              country == 'Australia'
                                  ? mobileMaskAustralia
                                  : mobileMaskUSA
                            ],
                                controller: ctrlMobile,
                                validator: (String value){
                                  print(value);
                                  print(value.length);
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
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  mobile = (country == 'Australia'
                                      ? mobileMaskAustralia
                                      : mobileMaskUSA)
                                      .getUnmaskedText();
                                  _maskednumber=(country=='Australia'
                                      ? mobileMaskAustralia
                                  :mobileMaskUSA
                                  ).getMaskedText();

                                },
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.5 * SizeConfig.heightMultiplier,
                                      horizontal: 20.0),
                                )),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(height: 3.94 * SizeConfig.heightMultiplier),
                          Divider(
                            thickness: 2.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text(
                              'Account Information',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 18,
                                color: const Color(0xff363636),
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Email Address',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(controller: ctrlUserName,
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
                                    fontFamily: 'Manrope',
                                    fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.5 * SizeConfig.heightMultiplier,
                                      horizontal: 20.0),
                                )),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
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
                            child: TextFormField(controller: ctrlPassword,
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
                                  fontFamily: 'Manrope',
                                  fontSize: 1.84 * SizeConfig.heightMultiplier),
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
                                    vertical: 1.05 * SizeConfig.heightMultiplier,
                                    horizontal: 2.63 * SizeConfig.heightMultiplier),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      3.95 * SizeConfig.heightMultiplier)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffe8e8e8), width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      3.95 * SizeConfig.heightMultiplier)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffe8e8e8), width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        3.95 * SizeConfig.heightMultiplier),
                                  ),
                                ),
                              ),
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
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
                            child: TextFormField(controller: ctrlCnfPassword,
                              validator: (String value){
                              if(ctrlPassword.text!=ctrlCnfPassword.text){
                              return 'Password did not match';
                              }
                              },
                              textAlign: TextAlign.center,
                              obscureText: _isHiddenPwd,
                              onChanged: (value) {
                                confirm_Password = value;
                              },
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 1.84 * SizeConfig.heightMultiplier),
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
                                    vertical: 1.05 * SizeConfig.heightMultiplier,
                                    horizontal: 2.63 * SizeConfig.heightMultiplier),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      3.95 * SizeConfig.heightMultiplier)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffe8e8e8), width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      3.95 * SizeConfig.heightMultiplier)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffe8e8e8), width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      3.95 * SizeConfig.heightMultiplier)),
                                ),
                              ),
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(height: 4 * SizeConfig.heightMultiplier),
                          Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 53.2 * SizeConfig.widthMultiplier,
                                height: 5.65 * SizeConfig.heightMultiplier,
                                child: RaisedButton(
                                  onPressed: () async {
                                    print('Before validation');
                                    if(_editFormKey.currentState.validate()){
                                      print('done');
                                      setState(() {
                                        _waiting = true;
                                      });

                                      await UpdateUserDetails(kURLBase +
                                          'REST/REVIEWS/UpdateUserDetail?First_Name=$firstName&Surname=$surname&Mobile=$mobile&EmailAddress=$userName&Temp_pdw=$password&CUID=$curClientUserID&Client=$curClientID&Mobile_Masked=$_maskednumber');
                                      setState(() {
                                        _waiting = false;
                                      });
                                      await Flushbar(
                                        titleText: Text(
                                          'Details Updated',
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 2.0 * SizeConfig.heightMultiplier,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        messageText: Text(
                                          'You successfully updated your details.',
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
                                        duration: Duration(seconds: 2),
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAccount()));

                                    }


                                    setState(() {
                                      _waiting = false;
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
                                        'Update',
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
                              Container(
                                width: 30.2 * SizeConfig.widthMultiplier,
                                height: 5.65 * SizeConfig.heightMultiplier,
                                child: RaisedButton(
                                  onPressed: () {
                                   Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff929292),
                                          borderRadius:
                                          BorderRadius.circular(2.9 *SizeConfig.heightMultiplier)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Cancel',
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
                            ],
                          ),
                          SizedBox(height: 5 * SizeConfig.heightMultiplier)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

UpdateUserDetails(String url) async{
  print(url);
  http.Response response = await http.get(url);
  String data = response.body;
  print(data);
  sharedPreferences.setString('first_Name', jsonDecode(data)['First_Name']);
  curUserFName=jsonDecode(data)['First_Name'];
  sharedPreferences.setString('surname', jsonDecode(data)['Surname']);
  curUserSName=jsonDecode(data)['Surname'];
  sharedPreferences.setString('mobile', jsonDecode(data)['Mobile']);
  unmasked_mobile=jsonDecode(data)['Mobile'];
  sharedPreferences.setString('curuser', jsonDecode(data)['EmailAddress']);
  curUserName=jsonDecode(data)['EmailAddress'];
  sharedPreferences.setString('curUserPWD', jsonDecode(data)['Decrypted_Password']);
  curPassword=jsonDecode(data)['Decrypted_Password'];
  sharedPreferences.setString('maskedMobile', jsonDecode(data)['Mobile_Masked']);
  masked_mobile=jsonDecode(data)['Mobile_Masked'];

}
