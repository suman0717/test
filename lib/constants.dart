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
bool isEditable=false;
String supportEmaill='hello@radreviews.com.au';

String openenvalope =
    '<svg viewBox="0.0 0.0 19.3 20.0" ><path transform="translate(-0.5, 0.0)" d="M 2.692272424697876 20.00129699707031 L 17.64733505249023 20.00129699707031 C 18.85969352722168 20.0000171661377 19.8424015045166 19.01731491088867 19.84385871887207 17.80477142333984 L 19.84385871887207 7.656608581542969 C 19.84367561340332 7.537399291992188 19.77886962890625 7.427500247955322 19.67426300048828 7.369994640350342 L 11.58661460876465 0.5219407677650452 C 10.76802921295166 -0.1750622242689133 9.564432144165039 -0.1746977120637894 8.746394157409668 0.5230361223220825 L 0.6844936013221741 7.360527515411377 C 0.5693004131317139 7.414198875427246 0.495729923248291 7.529574871063232 0.495729923248291 7.656634330749512 L 0.495729923248291 17.80480003356934 C 0.4970078468322754 19.01734161376953 1.4797123670578 20.00004196166992 2.692255020141602 20.00132179260254 Z M 9.169591903686523 1.02199125289917 C 9.743917465209961 0.5321903824806213 10.5889720916748 0.531825840473175 11.16366195678711 1.021261096000671 L 19.01048851013184 7.665411472320557 L 11.16983127593994 14.31558990478516 C 10.59532356262207 14.80520915985107 9.750452041625977 14.80557441711426 9.175761222839355 14.31631946563721 L 1.328932285308838 7.671984195709229 L 9.169591903686523 1.02199125289917 Z M 1.150031566619873 8.377908706665039 L 8.752812385559082 14.81558418273926 C 9.571395874023438 15.51258850097656 10.77499389648438 15.51203727722168 11.59302997589111 14.81448841094971 L 19.18959426879883 8.371719360351562 L 19.18959426879883 17.80479621887207 C 19.18977737426758 18.05910110473633 19.12679290771484 18.30956840515137 19.00612449645996 18.53356742858887 L 14.54881572723389 13.99849128723145 C 14.42212200164795 13.86960601806641 14.21491813659668 13.8677806854248 14.08603382110596 13.99447441101074 C 13.95733070373535 14.12098693847656 13.95550537109375 14.32818794250488 14.082200050354 14.45707321166992 L 18.57912635803223 19.03230667114258 C 18.31149673461914 19.23677062988281 17.98398780822754 19.34721946716309 17.64735412597656 19.34703826904297 L 2.692292213439941 19.34703826904297 C 2.354562044143677 19.3474006652832 2.026324033737183 19.23622512817383 1.758329391479492 19.03103256225586 L 6.230792045593262 14.45652294158936 C 6.31367301940918 14.37309455871582 6.345620155334473 14.25169372558594 6.31421947479248 14.13851070404053 C 6.282819747924805 14.02514266967773 6.193002700805664 13.93733215332031 6.079086303710938 13.90867042541504 C 5.965170860290527 13.87982845306396 5.844500541687012 13.91433143615723 5.763080596923828 13.99903774261475 L 1.332240581512451 18.53119087219238 C 1.212300539016724 18.30774307250977 1.149683594703674 18.05818939208984 1.150048732757568 17.80479621887207 L 1.150031566619873 8.377908706665039 Z M 1.150031566619873 8.377908706665039" fill="#971a9f" stroke="#971a9f" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


