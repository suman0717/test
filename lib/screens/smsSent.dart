import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      _waiting = true;
    });
    getSmsSent().whenComplete(() {
      setState(() {
        _waiting = false;
      });
      print("success");
    }).catchError((error, stackTrace) {
      setState(() {
        _waiting = false;
      });
      print("outer: $error");
    });

    super.initState();
  }

  List<Widget> custom_listTile = [];
  int len;

  Future<List<Widget>> getSmsSent() async {
    Widget posOutIcon;

    Widget negOutIcon;

    setState(() {
      _waiting = true;
    });
    var data = await http
        .get(kURLBase + 'REST/REVIEWS/App_GetSmsSent?Client=$curClientID');
    var jsonData = json.decode(data.body);
    if (jsonData['response'] != null) {
      List jsonRes = jsonData['response'];
      print(jsonRes.length);
      len = jsonRes.length;

      for (int i = 0; i < jsonRes.length; i++) {
        if (jsonRes[i]["SMS_Pos_Submit_Needs"] == circlethin) {
          posOutIcon = CustomIcons().CircleIconGrey();
        } else if (jsonRes[i]["SMS_Pos_Submit_Needs"] == posThumbThick) {
          posOutIcon = CustomIcons().ThumbsUpSolid();
        } else if (jsonRes[i]["SMS_Pos_Submit_Needs"] == posThumbThickGrey) {
          posOutIcon = CustomIcons().ThumbsUpRegular();
        }

        if (jsonRes[i]["SMS_Neg_Submit_Needs"] == circlethin) {
          negOutIcon = CustomIcons().CircleIconGrey();
        } else if (jsonRes[i]["SMS_Neg_Submit_Needs"] == negThumbThick) {
          negOutIcon = CustomIcons().ThumbsDownRegular();
        } else if (jsonRes[i]["SMS_Neg_Submit_Needs"] == negThumbThickGrey) {
          negOutIcon = CustomIcons().ThumbsDownRegular();
        }

        var _txt = CustomListTile(
          mobileValidated: jsonRes[i]["Mobile_validated"].toString(),
          requestedon: GetBrisbaneTime(jsonRes[i]["Requested_On"].toString()),
          smsID: jsonRes[i]["SMS_ID"].toString(),
          smsClickCount: jsonRes[i]["SMSOpenClicks"],
          negIcon: negOutIcon,
          posIcon: posOutIcon,
        );
        custom_listTile.add(_txt);
      }
    } else {
      var _txt = CustomListTile(
        mobileValidated: jsonData["Mobile_validated"].toString(),
        requestedon: GetBrisbaneTime(jsonData["Requested_On"].toString()),
        smsID: jsonData["SMS_ID"].toString(),
        smsClickCount: jsonData["SMSOpenClicks"],
        negIcon: jsonData["SMS_Neg_Submit_Needs"] == circlethin
            ? negOutIcon = CustomIcons().CircleIconGrey()
            : jsonData["SMS_Neg_Submit_Needs"] == negThumbThickGrey
                ? negOutIcon = CustomIcons().ThumbsDownRegular()
                : negOutIcon = CustomIcons().ThumbsDownRegular(),
        posIcon: jsonData["SMS_Pos_Submit_Needs"] == circlethin
            ? posOutIcon = CustomIcons().CircleIconGrey()
            : jsonData["SMS_Pos_Submit_Needs"] == posThumbThickGrey
                ? posOutIcon = CustomIcons().ThumbsUpRegular()
                : posOutIcon = CustomIcons().ThumbsUpSolid(),
      );
      custom_listTile.add(_txt);
    }
    return custom_listTile;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
  IconData posIconData;
  Widget posIcon;
  Color posIconColor = kshadeColor1;
  Color negIconColor = kshadeColor1;
  IconData negIconData;
  Widget negIcon;
  IconData customEnvelope = FontAwesomeIcons.envelope;

  CustomListTile(
      {this.mobileValidated,
      this.smsID,
      this.requestedon,
      this.smsClickCount,
      this.negIconData,
      this.negIcon,
      this.negIconColor,
      this.posIconData,
      this.posIcon,
      this.posIconColor});

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
              'ID:' + widget.smsID,
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
                  icon: widget.smsClickCount == 0
                      ? CustomIcons().EnvelopeClose()
                      : CustomIcons().EnvelopeOpen(),
                  onPressed: () {}),
              IconButton(icon: widget.posIcon, onPressed: () {}),
              IconButton(icon: widget.negIcon, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
