import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/bottomBar.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/editmyaccount.dart';
import 'package:radreviews/screens/feedbackState.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/smsSent.dart';
import 'package:radreviews/screens/termsandconditins.dart';
import 'package:radreviews/size_config.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'negFeedback.dart';

var textEditingController = TextEditingController();
var mobileMaskUSA = MaskTextInputFormatter(
    mask: "(###) ###-####", filter: {"#": RegExp(r'[0-9]')});
var mobileMaskAustralia = MaskTextInputFormatter(
    mask: "####-###-###", filter: {"#": RegExp(r'[0-9]')});

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool _waiting = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(FontAwesomeIcons.solidEdit,color: Colors.white,size: 1.7 * SizeConfig.heightMultiplier,), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditMyAccount()));
        },padding: EdgeInsets.only(top: 1.5 * SizeConfig.heightMultiplier),),
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
          child: Material(color: kshadeColor1,shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),
              child:InkWell(
                child:IconButton(
                  iconSize: 4 * SizeConfig.heightMultiplier,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Home()));
                  },
                ),))
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
                    'ACCOUNT',
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
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 7.6),
                              Text(
                                curUserFName,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 15,
                                  color: const Color(0xff363636),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Surname',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 7.6),
                              Text(
                                curUserSName,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 15,
                                  color: const Color(0xff363636),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Mobile-Number',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      color: const Color(0xffa1a1a1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 7.6),
                  Text(
                    masked_mobile,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      color: const Color(0xff363636),
                    ),
                    textAlign: TextAlign.left,
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
                  Text(
                    'Email-Address',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      color: const Color(0xffa1a1a1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 1 * SizeConfig.heightMultiplier),
                  Text(
                    curUserName,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      color: const Color(0xff363636),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      color: const Color(0xffa1a1a1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 1 * SizeConfig.heightMultiplier),
                  Text(
                    '********',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      color: const Color(0xff363636),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
