import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/bottomBar.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/myaccount.dart';
import 'package:radreviews/screens/negFeedback.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/smsSent.dart';
import 'package:radreviews/screens/termsand%20conditins.dart';
import 'package:radreviews/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String totalSmsSent='';
String totalSmsOpened='';
String totalNegSubmitted='';
String totalPosOpended='';

class FeedbackStats extends StatefulWidget {
  @override
  _FeedbackStatsState createState() => _FeedbackStatsState();
}

class _FeedbackStatsState extends State<FeedbackStats> {

  bool _waiting=false;
  @override
  void initState() {
    setState(() {
      _waiting=true;
    });
    getFeedback().whenComplete(() {
      setState(() {
        _waiting=false;
      });
    } ).catchError((error, stackTrace) {
      setState(() {_waiting=false;});
      print("outer: $error");
    });
    super.initState();
  }

  Future<bool> getFeedback() async {
    print(kURLBase+ 'REST/REVIEWS/App_GetStatByClient?Client=$curClientID');
    http.Response response = await http.get(kURLBase+ 'REST/REVIEWS/App_GetStatByClient?Client=$curClientID');

    var data = response.body;
    print(data);
    totalSmsSent = jsonDecode(data)['TotalSMSSent'];
    totalSmsOpened = jsonDecode(data)['TotalSmsOpen'];
    totalNegSubmitted = jsonDecode(data)['TotalNegSubmitted'];
    totalPosOpended = jsonDecode(data)['TotalPositiveOpened'];
    print(totalSmsSent);
    print(totalSmsOpened);
    print(totalNegSubmitted);
    print(totalPosOpended);

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
                    'FEEDBACK STATS',
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Text(
                      'Total SMS Sent',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalSmsSent,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff971a9f),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:15.0,right:15.0),
                    child: Divider(color: Color(0xffe6e6e6),thickness: 2.0,),
                  ),
                  ListTile(
                    leading: Text(
                      'Total SMS Opens',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalSmsOpened,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff971a9f),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:15.0,right:15.0),
                    child: Divider(color: Color(0xffe6e6e6),thickness: 2.0,),
                  ),
                  ListTile(
                    leading: Text(
                      'Total Negative Submitted',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalNegSubmitted,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff971a9f),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:15.0,right:15.0),
                    child: Divider(color: Color(0xffe6e6e6),thickness: 2.0,),
                  ),
                  ListTile(
                    leading: Text(
                      'Total Positive Opened',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalPosOpended,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: const Color(0xff971a9f),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
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
