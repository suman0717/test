import 'package:radreviews/alert.dart';
import 'package:radreviews/bottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/linkOpener.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}



class _SuccessState extends State<Success> {
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
    return
      SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton(

              icon: Icon(Icons.more_horiz),
              onSelected: (value) {
                if(value==1){
                  Logout();
                };
              },
              itemBuilder: (context) => [
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
                  value: 1,
                ),
              ],
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xffffffff),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.12, 1.05),
                        end: Alignment(-0.14, -0.78),
                        colors: [kshadeColor2, kshadeColor1],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 45.0,
                        ),
                        Image.asset(
                          'images/radwhite.png',
                          width: 104.0,
                          height: 155.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF5F8FB),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 60.0),
              width: 322.0,
              height: 290.0,
              child: Card(
                color: Colors.white,
                elevation: 20.0,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Account Panding Activation',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          color: const Color(0xff363636),
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Your account is currently in a Pending Activation Status.\nOnce activated you will be be provided full \n access to the platform.',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10,
                          color: const Color(0xff363636),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'If you haven’t heard from us\nplease check your spam folder.',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10,
                          color: const Color(0xff363636),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 43.0,
                        child: RaisedButton(
                          onPressed: () async {


                            QuickLaunchLink().hitLink('mailto:support@ethink.solutions?subject=Need%20Help&body=Hi%20Support');


                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Padding(
                            padding: EdgeInsets.only(left: 0.0, right: 0.0),
                            child: Container(decoration: BoxDecoration(color: kshadeColor1,borderRadius: BorderRadius.circular(22.0)),
                              constraints:
                              BoxConstraints(maxWidth: 266.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Contact Us',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 15,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
