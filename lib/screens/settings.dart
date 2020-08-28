import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:radreviews/customswitch.dart';

String feedbackTemp=smsFeedbackWording;
String feedbackFollowTemp=smsFeedback_Followup_Wording;
bool followUpEnabled=feedBack_FollowUP=='Yes'?true:false;
int currentValue=feedback_FollowUp_Days as int;

var ctrlFeedbackFollowDays = TextEditingController(text: feedback_FollowUp_Days.toString());
var ctrlFeedbackTemp = TextEditingController(text: smsFeedbackWording);
var ctrlFeedbackFollowUp = TextEditingController(text: smsFeedback_Followup_Wording);
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
SharedPreferences sharedPreferences;
class _SettingsState extends State<Settings> {

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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  Future<bool> getFeedback() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(feedBack_FollowUP);
    print(feedback_FollowUp_Days);
    print(smsFeedbackWording);
    print(smsFeedback_Followup_Wording);
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

  var _formKey = GlobalKey<FormState>();

  void showFeedbackTemplateInfo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5.0,
            title: Text(
              'Template Tags',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 3.0 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Feedback URL = <Feedback_Url>\nClient Name = <Client_Name>',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                    'SETTINGS',
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
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6.35 * SizeConfig.widthMultiplier, 2.63 * SizeConfig.heightMultiplier, 6.35 * SizeConfig.widthMultiplier, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[


                          ],
                        ),
                        Text(
                          'Settings',
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
                          child: Row(
                            children: [
                              Text(
                                'Feedback Template',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.help_outline,
                                    color: kshadeColor1,
                                    size: 2.25 * SizeConfig.heightMultiplier,
                                  ),
                                  onPressed: () {
                                    showFeedbackTemplateInfo();
                                  })
                            ],
                          ),
                        ),
                        Container(
                          child: TextFormField(maxLines: 7,
                              controller: ctrlFeedbackTemp,
                              validator: (String value){
                            if(value.isEmpty){
                              return 'Feedback Template can\'t be null';
                            }
                              },
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                feedbackTemp = value;
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
                          padding: const EdgeInsets.only(top:18.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Feedback Follow Up:',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13,
                                  color: const Color(0xff707070),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              FlutterSwitch(
                                activeColor: kshadeColor1,
                                width: 21.82 * SizeConfig.widthMultiplier,
                                height: 4.6 * SizeConfig.heightMultiplier,
                                valueFontSize: 2.36 * SizeConfig.heightMultiplier,
                                toggleSize: 2.63 *SizeConfig.heightMultiplier,
                                value: followUpEnabled,
                                borderRadius: 3.94 *SizeConfig.heightMultiplier,
                                padding: 1.05 *SizeConfig.heightMultiplier,
                                showOnOff: true,
                                onToggle: (val) {
                                  setState(() {
                                    followUpEnabled = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Visibility(visible: followUpEnabled,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:18.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Feedback Follow Up Days',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 13,
                                        color: const Color(0xff707070),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Container(
                                      width: 110.0,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7.65 * SizeConfig.widthMultiplier),
                                        border: Border.all(
                                          color: Color(0xffe8e8e8),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(8.0),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                                                ),
                                              ),
                                              controller: ctrlFeedbackFollowDays,

                                              keyboardType: TextInputType.numberWithOptions(
                                                decimal: false,
                                                signed: true,
                                              ),
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(right:18.0),
                                            child: Container(
                                              height: 38.0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.keyboard_arrow_up,
                                                      size: 18.0,
                                                    ),
                                                    onTap: () {
                                                      int currentValue = int.parse(ctrlFeedbackFollowDays.text);
                                                      setState(() {
                                                        currentValue++;
                                                        ctrlFeedbackFollowDays.text = (currentValue)
                                                            .toString(); // incrementing value
                                                      });
                                                    },
                                                  ),
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 18.0,
                                                    ),
                                                    onTap: () {
                                                      currentValue = int.parse(ctrlFeedbackFollowDays.text);
                                                      setState(() {
                                                        print("Setting state");
                                                        currentValue--;
                                                        ctrlFeedbackFollowDays.text =
                                                            (currentValue > 0 ? currentValue : 0)
                                                                .toString(); // decrementing value
                                                      });
                                                    },
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0, top: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'Feedback Follow Up Template',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 1.7 * SizeConfig.heightMultiplier,
                                        color: const Color(0xffa1a1a1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.help_outline,
                                          color: kshadeColor1,
                                          size: 2.25 * SizeConfig.heightMultiplier,
                                        ),
                                        onPressed: () {
                                          showFeedbackTemplateInfo();
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(maxLines: 7,
                                    controller: ctrlFeedbackFollowUp,
                                    validator: (String value){
                                      if(value.isEmpty){
                                        return 'Feedback Follow Up Template can\'t be null';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      feedbackFollowTemp = value;
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
//                                  width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
                              ),
                            ],
                          ),),
                        SizedBox(height: 4 * SizeConfig.heightMultiplier,),
                        Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 53.2 * SizeConfig.widthMultiplier,
                              height: 5.65 * SizeConfig.heightMultiplier,
                              child: RaisedButton(
                                onPressed: () async {
                                  if(_formKey.currentState.validate()){
                                    print('done');
                                    setState(() {
                                      _waiting = true;
                                    });
                                    print(kURLBase +'REST/REVIEWS/App_UpdateTemplate?SMSFeedbackWording=$feedbackTemp&SMSFeedback_Followup_Wording=$feedbackFollowTemp&FeedBack_FollowUP=$followUpEnabled&Feedback_FollowUp_Days=${ctrlFeedbackFollowDays.text}&CUID=$curClientUserID');
                                    await UpdateTemplate(kURLBase +
                                        'REST/REVIEWS/App_UpdateTemplate?SMSFeedbackWording=$feedbackTemp&SMSFeedback_Followup_Wording=$feedbackFollowTemp&FeedBack_FollowUP=$followUpEnabled&Feedback_FollowUp_Days=${ctrlFeedbackFollowDays.text}&CUID=$curClientUserID');
                                    setState(() {
                                      _waiting = false;
                                    });
                                    await Flushbar(
                                      titleText: Text(
                                        'Template Updated',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 2.0 * SizeConfig.heightMultiplier,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      messageText: Text(
                                        'You have successfully updated the settings.',
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
                                      duration: Duration(seconds: 3),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));

                                  }


//                                    setState(() {
//                                      _waiting = false;
//                                    });
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
                                      'Save Changes',
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
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
    );
  }
}

UpdateTemplate(String url) async{
  print(url);
  http.Response response = await http.get(url);
  String data = response.body;
  print(data);
  sharedPreferences.setString('feedBack_FollowUP', jsonDecode(data)['FeedBack_FollowUP']);
  feedBack_FollowUP=sharedPreferences.get('feedBack_FollowUP');
  sharedPreferences.setInt('feedback_FollowUp_Days', jsonDecode(data)['Feedback_FollowUp_Days']);
  feedback_FollowUp_Days=sharedPreferences.get('feedback_FollowUp_Days').toString();
  sharedPreferences.setString('smsFeedbackWording', jsonDecode(data)['SMSFeedbackWording']);
  smsFeedbackWording=sharedPreferences.get('smsFeedbackWording');
  sharedPreferences.setString('smsFeedback_Followup_Wording', jsonDecode(data)['SMSFeedback_Followup_Wording']);
  smsFeedback_Followup_Wording=sharedPreferences.get('smsFeedback_Followup_Wording');
}
