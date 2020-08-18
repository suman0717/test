import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(fillColor: Color(0xffF5F5F5),filled: true,
  hintStyle: TextStyle(
    fontFamily: 'Manrope',
    fontSize: 13,
    color: const Color(0xff828282),
//    fontWeight: FontWeight.w300,
  ),
//    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffF5F5F5), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffF5F5F5), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);

const kTextFieldDecorationNoback = InputDecoration(
  hintStyle: TextStyle(
    fontFamily: 'Manrope',

    color: const Color(0xff828282),
  ),

  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),

  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),

  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffe8e8e8), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffe8e8e8), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);

List<String> countryList = ['Australia','USA'];

String kURLBase = 'https://radreviews.online/app/';
String kURLTerms = 'https://radreviews.online/app/RAD/Terms.pdf';
String kURLAcceptableUsePolicy = 'https://radreviews.online/app/RAD/Acceptable-Use-Policy.pdf';
String kURLPrivacyPolicy = 'https://radreviews.online/app/RAD/Privacy-Policy.pdf';


const kshadeColor1 = Color(0xff881c8e);
const kshadeColor2 = Color(0xff1b0e97);

String circlethin = '<i class="fa fa-circle-thin" aria-hidden="true" style="margin-bottom: -6px;"></i>';
String negThumbThin = '';
String negThumbThick = '<i class="fa fa-thumbs-down" aria-hidden="true"></i>';
String negThumbThickGrey = '<i class="fa fa-thumbs-down" style="color:gray"></i>';
String posThumbThin = '';
String posThumbThick = '<i class="fa fa-thumbs-up" aria-hidden="true"></i>';
String posThumbThickGrey = '<i class="fa fa-thumbs-up" style="color:gray"></i>';

//Basic data

String curUserName;
String curPassword;
String curbusinessName;
String businessnumber;
String maskedbusinessnumber;
String curaccountStatus;
String curClientID;
String unmasked_mobile;
String curClientUserID;
String curUserFName;
String curUserSName;
String curemail;
String country;
String masked_mobile;
String feedBack_FollowUP;
String feedback_FollowUp_Days;
String smsFeedbackWording;
String smsFeedback_Followup_Wording;
String serverOTP;
String localOTP;
String forgotClientUserID;


