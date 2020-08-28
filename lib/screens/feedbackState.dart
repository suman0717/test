import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/size_config.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalSmsSent,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
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
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalSmsOpened,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
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
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalNegSubmitted,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
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
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Text(
                      totalPosOpended,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.97 * SizeConfig.heightMultiplier,
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
