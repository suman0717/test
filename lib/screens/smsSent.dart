import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/bottomBar.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/feedbackState.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/myaccount.dart';
import 'package:radreviews/screens/negFeedback.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/termsand%20conditins.dart';
import 'package:radreviews/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

bool _waiting = false;

class SMSSent extends StatefulWidget {
  @override
  _SMSSentState createState() => _SMSSentState();
}

class _SMSSentState extends State<SMSSent> {
  @override
  void initState() {
    setState(() {
      _waiting=true;
    });
    getSmsSent().whenComplete(() {
      setState(() {_waiting=false;});
      print("success");
    }).catchError((error, stackTrace) {
      setState(() {_waiting=false;});
      print("outer: $error");
    });

    super.initState();
  }

  List<Widget> custom_listTile = [];
  int len;

  Future<List<Widget>> getSmsSent() async {
    setState(() {
      _waiting=true;
    });
    var data = await http.get(
        kURLBase+'REST/REVIEWS/App_GetSmsSent?Client=$curClientID');
    var jsonData = json.decode(data.body);
    List jsonRes = jsonData['response'];
    print(jsonRes.length);
    len = jsonRes.length;
    IconData posOutIcon;
    Color _posOutIconColor;
    IconData negOutIcon;
    Color _negOutIconColor;

    for (int i = 0; i < jsonRes.length; i++) {
      print(i);
      print(jsonRes[i]["Mobile_validated"]);
      if(jsonRes[i]["SMS_Pos_Submit_Needs"]==circlethin){
        posOutIcon=FontAwesomeIcons.dotCircle;
        _posOutIconColor = Colors.grey;
      }
      else if(jsonRes[i]["SMS_Pos_Submit_Needs"]==posThumbThick){
        posOutIcon=FontAwesomeIcons.thumbsUp;
        _posOutIconColor = kshadeColor1;
      }
      else if(jsonRes[i]["SMS_Pos_Submit_Needs"]==posThumbThickGrey){
        posOutIcon=FontAwesomeIcons.solidThumbsUp;
        _posOutIconColor = Colors.grey;
      }

      if(jsonRes[i]["SMS_Neg_Submit_Needs"]==circlethin){
        negOutIcon=FontAwesomeIcons.dotCircle;
        _negOutIconColor = Colors.grey;
      }
      else if(jsonRes[i]["SMS_Neg_Submit_Needs"]==negThumbThick){
        negOutIcon=FontAwesomeIcons.thumbsDown;
        _negOutIconColor = kshadeColor1;
      }
      else if(jsonRes[i]["SMS_Neg_Submit_Needs"]==negThumbThickGrey){
        negOutIcon=FontAwesomeIcons.solidThumbsDown;
        _negOutIconColor = Colors.grey;
      }

      var _txt = CustomListTile(
          mobileValidated: jsonRes[i]["Mobile_validated"].toString(),
          requestedon: jsonRes[i]["Requested_On"].toString(),
          smsID: jsonRes[i]["SMS_ID"].toString(),
          smsClickCount: jsonRes[i]["SMSOpenClicks"],
          posIcon: posOutIcon,
          negIcon: negOutIcon,
          negIconColor: _negOutIconColor,
          posIconColor: _posOutIconColor
      );
      custom_listTile.add(_txt);
    }
    return custom_listTile;
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
                    'FEEDBACK SMS SENT',
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
                padding:
                EdgeInsets.only(top: 2.63 * SizeConfig.heightMultiplier),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: custom_listTile,
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

class CustomListTile extends StatefulWidget {
  String mobileValidated;
  String smsID;
  String requestedon;
  int smsClickCount;
  IconData posIcon;
  Color posIconColor = kshadeColor1;
  Color negIconColor = kshadeColor1;
  IconData negIcon;
  IconData customEnvelope = FontAwesomeIcons.envelope;

  CustomListTile({this.mobileValidated, this.smsID, this.requestedon,this.smsClickCount,this.negIcon,this.negIconColor,this.posIcon,this.posIconColor});

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          print(widget.smsID);
        },
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID:'+ widget.smsID,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 15,
                color: const Color(0xff363636),
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              widget.mobileValidated + '\n' + widget.requestedon,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 11,
                color: const Color(0xffa1a1a1),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        trailing: SizedBox(
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(widget.smsClickCount==0
                      ?widget.customEnvelope
                      :FontAwesomeIcons.envelopeOpen,
                    color: widget.smsClickCount==0
                        ? Colors.grey
                        : kshadeColor1,
                  ),
                  onPressed: () {
                    setState(() {
//                      if (widget.smsClickCount==0) {
//                        widget.customEnvelope = FontAwesomeIcons.envelopeOpen;
//                        widget.smsClickCount++;
//                      }
                    });
                    ;
                  }),
              IconButton(icon: Icon(widget.posIcon,color: widget.posIconColor,), onPressed: (){

              }),
              IconButton(icon: Icon(widget.negIcon,color: widget.negIconColor,), onPressed: (){

              }),
            ],
          ),
        ),
      ),
    );
  }
}