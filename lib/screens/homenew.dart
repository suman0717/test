import 'package:radreviews/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radreviews/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

String selectedlocation;
var _formkey = GlobalKey<FormState>();

class HomeNew extends StatefulWidget {
  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  String _unMaskedMobile;
  bool termsAndConsdditions = true;
  String _country = 'Australia';
  var ctrlMobile = TextEditingController();
  var ctrllocation = TextEditingController();

  var mobileMaskUSA = MaskTextInputFormatter(
      mask: "(###) ###-####", filter: {"#": RegExp(r'[0-9]')});
  var mobileMaskAustralia = MaskTextInputFormatter(
      mask: "####-###-###", filter: {"#": RegExp(r'[0-9]')});
  bool _isWaiting = false;

  @override
  void initState() {
    getSharedPref().whenComplete(() {
      setState(() {});
      print("success");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });

    super.initState();
  }

  Future<bool> getSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(locationListTemp);
    print('old list');
    if (sharedPreferences.getStringList('loc') == null) {
      locationListTemp = [''];
    } else {
      locationListTemp = (sharedPreferences.getStringList('loc'));
    }
    print('shared list');
    print(sharedPreferences.get('loc'));
    print('new list');
    print(locationListTemp);
    return true;
  }

  void showAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    );
  }

  void showRequestFeedbackInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5.0,
          title: Text(
            'Feedback Instructions',
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
                  'AUS Number Format 0412-343-567',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 1.9 * SizeConfig.heightMultiplier,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier,
                ),
                // Text(
                //   'USA Number Format (555)555-1234',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily: 'Manrope',
                //     fontSize: 1.9 * SizeConfig.heightMultiplier,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool validateMobile(String number) {
    print(number);
    if (number == null) {
      validationOnRequestFeedback('Please provide Mobile Number');
      return false;
    } else if (number.length != 10) {
      validationOnRequestFeedback('Please provide the Correct Number');
      return false;
    } else if (!(number.startsWith('0'))) {
      validationOnRequestFeedback('Number should starts with 0');
      return false;
    } else
      return true;
  }

  void validationOnRequestFeedback(String errormsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5.0,
            title: Text(
              'Error:',
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
                    errormsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
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
      backgroundColor: const Color(0xffffffff),
      body: ModalProgressHUD(
        inAsyncCall: _isWaiting,
        child: Stack(
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
                          height: 4 * SizeConfig.heightMultiplier,
                        ),
                        Image.asset(
                          'images/radwhite.png',
                          width: 26.5 * SizeConfig.imageSizeMultipier,
                          height: 20.4 * SizeConfig.heightMultiplier,
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
                        Container(
                          height: 5.7 * SizeConfig.heightMultiplier,
                          child: MaterialButton(
                            elevation: 10.0,
                            onPressed: () {
                              RequestFeedback(
                                  _unMaskedMobile, selectedlocation);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    1.31 * SizeConfig.heightMultiplier)),
                            child: Ink(
                                decoration: BoxDecoration(
                                    color: kshadeColor1,
                                    borderRadius: BorderRadius.circular(
                                        4 * SizeConfig.heightMultiplier)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          68.2 * SizeConfig.widthMultiplier,
                                      minHeight:
                                          5.7 * SizeConfig.heightMultiplier),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Request',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize:
                                          1.97 * SizeConfig.heightMultiplier,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6 * SizeConfig.heightMultiplier,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: locationListTemp.length > 1,
              replacement: Container(
                margin: EdgeInsets.only(top: 60.0),
                width: 82.5 * SizeConfig.imageSizeMultipier,
                height: 41.2 * SizeConfig.heightMultiplier,
                child: Card(
                  color: Colors.white,
                  elevation: 20.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Request Feedback',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 2.4 * SizeConfig.heightMultiplier,
                              color: const Color(0xff363636),
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.help_outline,
                                color: kshadeColor1,
                                size: 3.3 * SizeConfig.heightMultiplier,
                              ),
                              onPressed: () {
                                showRequestFeedbackInfo();
                              })
                        ],
                      ),
                      Container(
                        width: 68.2 * SizeConfig.widthMultiplier,
                        height: 5.7 * SizeConfig.heightMultiplier,
                        child: TextField(
//                            TODO Implement Dynamic ISD Code Selection, Use Quizler app concept
                          controller: ctrlMobile,
                          inputFormatters: [
                            _country == 'Australia'
                                ? mobileMaskAustralia
                                : mobileMaskUSA
                          ],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            _unMaskedMobile = (_country == 'Australia'
                                    ? mobileMaskAustralia
                                    : mobileMaskUSA)
                                .getUnmaskedText();
                            print(_unMaskedMobile);
                          },
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 2.0 * SizeConfig.heightMultiplier),
                          decoration: kTextFieldDecorationNoback.copyWith(
                            hintText: 'Mobile Number. . . ',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5 * SizeConfig.heightMultiplier,
                                horizontal: 20.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 68.2 * SizeConfig.widthMultiplier,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                activeColor: kshadeColor1,
                                value: termsAndConsdditions,
                                onChanged: (bool newvalue) {
                                  setState(() {
                                    termsAndConsdditions = newvalue;
                                  });
                                  print(newvalue);
//                        TODO
                                }),
                            Flexible(
                              child: Text(
                                'I certify that this recipient has opted in to receive communication. I further certify that I am an authorized Representative of $curbusinessName and I understand and accept Rad Reviews terms and conditions.',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 1.1 * SizeConfig.heightMultiplier,
                                  color: const Color(0xff363636),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 60.0),
                width: 82.5 * SizeConfig.imageSizeMultipier,
                height: 41.2 * SizeConfig.heightMultiplier,
                child: Form(
                  key: _formkey,
                  child: Card(
                    color: Colors.white,
                    elevation: 20.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Request Feedback',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 2.4 * SizeConfig.heightMultiplier,
                                color: const Color(0xff363636),
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.help_outline,
                                  color: kshadeColor1,
                                  size: 3.3 * SizeConfig.heightMultiplier,
                                ),
                                onPressed: () {
                                  showRequestFeedbackInfo();
                                })
                          ],
                        ),
                        Container(
                          width: 68.2 * SizeConfig.widthMultiplier,
                          height: 5.7 * SizeConfig.heightMultiplier,
                          child: TextField(
                            controller: ctrlMobile,
                            inputFormatters: [
                              _country == 'Australia'
                                  ? mobileMaskAustralia
                                  : mobileMaskUSA
                            ],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              _unMaskedMobile = (_country == 'Australia'
                                      ? mobileMaskAustralia
                                      : mobileMaskUSA)
                                  .getUnmaskedText();
                              print(_unMaskedMobile);
                            },
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 2.0 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: 'Mobile Number. . . ',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 68.2 * SizeConfig.widthMultiplier,
                          height: 5.7 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                4 * SizeConfig.heightMultiplier),
                            border: Border.all(
                                color: Color(0xffe8e8e8), width: 1.0),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              onTap: () {
                                FocusManager.instance.primaryFocus.unfocus();
                              },
                              items:
                                  locationListTemp.map((String dropdownitem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownitem,
                                  child: Text(
                                    dropdownitem,
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize:
                                            1.84 * SizeConfig.heightMultiplier),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newselectedcountry) {
                                setState(() {
                                  selectedlocation = newselectedcountry;
                                  print(selectedlocation);
                                });
                              },
                              value: selectedlocation,
                              hint: Text(
                                'Location',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize:
                                        2.0 * SizeConfig.heightMultiplier),
                              ),
                              underline: Container(
                                height: 1.0,
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0)),
                                ),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 2.5 * SizeConfig.heightMultiplier,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 68.2 * SizeConfig.widthMultiplier,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  activeColor: kshadeColor1,
                                  value: termsAndConsdditions,
                                  onChanged: (bool newvalue) {
                                    setState(() {
                                      termsAndConsdditions = newvalue;
                                    });
                                    print(newvalue);
//                        TODO
                                  }),
                              Flexible(
                                child: Text(
                                  'I certify that this recipient has opted in to receive communication. I further certify that I am an authorized Representative of $curbusinessName and I understand and accept Rad Reviews terms and conditions.',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 1.1 * SizeConfig.heightMultiplier,
                                    color: const Color(0xff363636),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  void RequestFeedback(String mob, String loc) async {
    if (loc != null && loc != 'No Location' && termsAndConsdditions == true) {
      bool _validate = validateMobile(mob);
      if (_validate == true) {
        print(loc);
        setState(() {
          _isWaiting = true;
        });

        String _tempMobile = '61' + mob.substring(1, mob.length);
        print(kURLBase +
            'REST/REVIEWS/RequestFeedback?Requested_On=${CurrentTime()}&CUID=$curClientUserID&Client=$curClientID&Mobile=$_tempMobile&Location_Name=$loc');
        http.Response response = await http.get(kURLBase +
            'REST/REVIEWS/RequestFeedback?Requested_On=${CurrentTime()}&CUID=$curClientUserID&Client=$curClientID&Mobile=$_tempMobile&Location_Name=$loc');
        var _smsString = response.body;
        String _smsID = jsonDecode(_smsString)['SMSID'];
        print(_smsString);
        print(_smsID);
        if (_smsID != null) {
          setState(() {
            _unMaskedMobile = '';
            ctrlMobile.text = '';
            selectedlocation = null;
            _isWaiting = false;
          });
          Flushbar(
            titleText: Text(
              'Request Sent',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 2.0 * SizeConfig.heightMultiplier,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            messageText: Text(
              'You successfully sent your feedback request.',
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
        } else {
          setState(() {
            _isWaiting = false;
          });
          Flushbar(
            titleText: Text(
              'Failed !',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 2.0 * SizeConfig.heightMultiplier,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            messageText: Text(
              'Something went wrong.',
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
              Icons.clear,
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
        }

      }
    } else if (termsAndConsdditions == false) {
      validationOnRequestFeedback(
          'Please confirm you are authorised to send this SMS Message');
    } else if (loc == null || loc == 'No Location') {
      validationOnRequestFeedback('Location Undefined');
    }
  }
}
