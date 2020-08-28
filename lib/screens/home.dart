import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/linkOpener.dart';
import 'package:radreviews/screens/SignIn.dart';
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
import 'dart:ui';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 2;
  int selectedAppIndex = 2;

  final List<Widget> _children = [
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

  void _onItemTapped(int index) {
    setState(() {
      if(index<5){
        if(index!=1){
          selectedIndex = index;
          selectedAppIndex=index;
          isEditable=false;}
        else{
          QuickLaunchLink().hitLink(
              'mailto:$supportEmaill?subject=Need%20Help&body=Hi%20Support');
        }
      }
      else{
        selectedAppIndex=index;
        isEditable=false;
      }
      print(selectedIndex);
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                _onItemTapped(0);
              } else if (value == 2) {

                _onItemTapped(4);

              } else if (value == 3) {
                _onItemTapped(5);
              } else if (value == 4) {
                _onItemTapped(3);
              } else if (value == 5) {
                _onItemTapped(6);
              } else if (value == 6) {
                setState(() {
                  _onItemTapped(7);
                });
              } else if (value == 7) {
                Logout();
              }
              else if (value == 8) {
                setState(() {
                  _onItemTapped(8);
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
            icon:
            Icon(
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
        currentIndex: selectedIndex,
        selectedItemColor: kshadeColor1,
        onTap: _onItemTapped,
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
                      selectedIndex = 2;
                      selectedAppIndex = 2;
                    });
                  },
                ),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: const Color(0xffffffff),
      body: _children[selectedAppIndex],
    );
  }
}
