import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/linkOpener.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/editUserDetails.dart';
import 'package:radreviews/screens/feedbackState.dart';
import 'package:radreviews/screens/homenew.dart';
import 'package:radreviews/screens/manageuser.dart';
import 'package:radreviews/screens/myaccount.dart';
import 'package:radreviews/screens/negFeedback.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/smsSent.dart';
import 'package:radreviews/screens/termsandconditins.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'dart:io' show File, Platform;

class ManageUserNew extends StatefulWidget {
  @override
  _ManageUserNewState createState() => _ManageUserNewState();
}

bool waiting = false;

class _ManageUserNewState extends State<ManageUserNew> {

  int selectedIndexuser = 2;
  int selectedAppIndexuser = 8;

  final List<Widget> _childrenuser = [
    Settings(),
    Settings(),
    HomeNew(),
    SMSSent(),
    MyAccount(),
    FeedbackStats(),
    NegFeedback(),
    TandC(kURLTerms),
    ManageUser(),
  ];

  void Logout() async {
    print(locationListTemp.length);
    locationListTemp = ['No Location'];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(locationListTemp.length);
    print(sharedPreferences.get('curuser'));
    await sharedPreferences.clear();
    print(sharedPreferences.get('curuser'));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>XDSignIn()), (route) => false);
  }

  void _onItemTappeduser(int index) {
    setState(() {
      if(index<5){
        if(index!=1){
          selectedIndexuser = index;
          selectedAppIndexuser=index;
          isEditable=false;}
        else{
          QuickLaunchLink().hitLink(
              'mailto:$supportEmaill?subject=Need%20Help&body=Hi%20Support');
        }
      }
      else{
        selectedAppIndexuser=index;
        isEditable=false;
      }
      print(selectedIndexuser);
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: waiting,
      color: Color(0xff3ba838),
      opacity: 0.1,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton(
              offset: Offset(0, 200),
              icon: Icon(Icons.more_horiz),
              onSelected: (value) {
                if (value == 1) {
                  _onItemTappeduser(0);
                } else if (value == 2) {

                  _onItemTappeduser(4);

                } else if (value == 3) {
                  _onItemTappeduser(5);
                } else if (value == 4) {
                  _onItemTappeduser(3);
                } else if (value == 5) {
                  _onItemTappeduser(6);
                } else if (value == 6) {
                  if(Platform.isIOS){
                    setState(() {
                      _onItemTappeduser(7);
                    });
                    print('ios');
                  }
                  else{
                    launchInBrowser(kURLTerms);
                  }
                } else if (value == 7) {
                  Logout();
                }
                else if (value == 8) {
                  setState(() {
                    _onItemTappeduser(8);
                  });
                }

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
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
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
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    'Manage Users',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11,
                      color: const Color(0xff363636),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  value: 8,
                ),
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
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
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
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
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
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
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
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
                PopupMenuItem(
                  height: 1,
                  child: PopupMenuDivider(
                    height: 1,
                  ),
                ),
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
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Feather.settings,
                size: 2.0 * SizeConfig.heightMultiplier,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.phone_call,
                size: 2.36 * SizeConfig.heightMultiplier,
              ),
              title: Text(
                'Support',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.phone_in_talk,
                size: 0.0,
              ),
              title: Text(
                '',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                AntDesign.message1,
                size: 2.6 * SizeConfig.heightMultiplier,
              ),
              title: Text(
                'SMS Sent',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 3.0 * SizeConfig.heightMultiplier,
              ),
              title: Text(
                'Account',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          currentIndex: selectedIndexuser,
          selectedItemColor: kshadeColor1,
          onTap: _onItemTappeduser,
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
            child: Material(
                color: kshadeColor1,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(6.65 * SizeConfig.widthMultiplier)),
                child: InkWell(
                  child: IconButton(
                    iconSize: 4 * SizeConfig.heightMultiplier,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isEditable = false;
                        selectedIndexuser = 2;
                        selectedAppIndexuser = 2;
                      });
                    },
                  ),
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        backgroundColor: const Color(0xffffffff),
        body: _childrenuser[selectedAppIndexuser],
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  String first_Name;
  String surName;
  int id;
  String email;
  String mobile_masked;
  String mobile;
  String primary_User;
  String pwd;

  UserDetails(
      {this.first_Name,
      this.surName,
      this.id,
      this.mobile_masked,
      this.email,
      this.primary_User,
      this.pwd,
      this.mobile});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserDetailsCheckbox(
        isActioned: false,
        id: id,
      ),
      title: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 1.31 * SizeConfig.heightMultiplier),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$first_Name $surName',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 15,
                color: const Color(0xff363636),
              ),
            )
          ],
        ),
      ),
      trailing: SizedBox(
        width: 25.0 * SizeConfig.widthMultiplier,
        child: RawMaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditUserDetails(
                  firstName: first_Name,
                  surname: surName,
                  userName: email,
                  mobile: mobile,
                  maskednumber: mobile_masked,
                  password: pwd,
                  confirm_Password: pwd,
                  id: id,
                ),
              ),
            );
          },
          elevation: 5.0,
          fillColor: Colors.white,
          child: Icon(
            FontAwesomeIcons.solidEdit,
            size: 12.0,
            color: kshadeColor1,
          ),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}

class UserDetailsCheckbox extends StatefulWidget {
  int id;
  bool isActioned;

  UserDetailsCheckbox({this.isActioned, this.id});

  @override
  _UserDetailsCheckboxState createState() => _UserDetailsCheckboxState();
}

class _UserDetailsCheckboxState extends State<UserDetailsCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: kshadeColor1,
        value: widget.isActioned,
        onChanged: (bool s) {
          setState(() {
            widget.isActioned = s;
            print(widget.isActioned);
            print(widget.id);
            print('text');
            MakeActionedNotActioned();
          });
        });
  }

  void MakeActionedNotActioned() async {
    setState(() {
      waiting = true;
    });
    print(widget.isActioned);
    print(widget.id);
    print(kURLBase +
        'REST/REVIEWS/App_Is_Actioned?Neg_Review_ID=${widget.id}&Ticked1=${widget.isActioned == true ? 'Actioned' : 'Not Actioned'}');
//    http.Response _response = await http.get(kURLBase+ 'REST/REVIEWS/App_Is_Actioned?Neg_Review_ID=${widget.id}&Ticked1=${widget.isActioned==true?'Actioned':'Not Actioned'}');
//    var _data = _response.body;
//    print(_data);
    setState(() {
      waiting = false;
    });
  }
}
