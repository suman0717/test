import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/linkOpener.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetSuccess extends StatefulWidget {
  @override
  _ResetSuccessState createState() => _ResetSuccessState();
}



class _ResetSuccessState extends State<ResetSuccess> {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                        'Password Reset Successful',
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
                        'You have successfully changed your password.\nPlease login using your new password.',
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>XDSignIn()));
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
                                'Sign in',
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
      );
  }
}
