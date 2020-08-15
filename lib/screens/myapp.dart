import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/registration_success.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';


bool _sharedPrefUserExists = false;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _waiting;
  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    CheckUserAlreadyExists().whenComplete(() {
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

  Future<bool> CheckUserAlreadyExists() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.get('curuser')!=null){
      curUserName=sharedPreferences.get('curuser');
      curPassword=sharedPreferences.get('curUserPWD');
      curbusinessName=sharedPreferences.get('business_Name');
      businessnumber=sharedPreferences.get('business_Num');
      curaccountStatus=sharedPreferences.get('account_Status');
      curClientID=sharedPreferences.get('clientID');
      unmasked_mobile=sharedPreferences.get('mobile');
      curClientUserID=sharedPreferences.get('cUID');
      curUserFName=sharedPreferences.get('first_Name');
      curUserSName=sharedPreferences.get('surname');
      country=sharedPreferences.get('country');
      masked_mobile=sharedPreferences.get('maskedMobile');
      maskedbusinessnumber=sharedPreferences.get('maskedbusiness_Num');
      feedBack_FollowUP=sharedPreferences.get('feedBack_FollowUP');
      feedback_FollowUp_Days=sharedPreferences.get('feedback_FollowUp_Days').toString();
      smsFeedbackWording=sharedPreferences.get('smsFeedbackWording');
      smsFeedback_Followup_Wording=sharedPreferences.get('smsFeedback_Followup_Wording');
      print(unmasked_mobile);
      print(masked_mobile);
      _sharedPrefUserExists = true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(inAsyncCall: _waiting,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return SplashScreen(
                seconds: 2,
                image: Image.asset(
                  'images/radwhite.png',
                  width: 34.8 * SizeConfig.widthMultiplier,
                  height: 26.6 * SizeConfig.heightMultiplier,
                ),
                gradientBackground: LinearGradient(
                  begin: Alignment(-0.12, 1.05),
                  end: Alignment(-0.14, -0.78),
                  colors: [kshadeColor2, kshadeColor1],
                  stops: [0.0, 1.0],
                ),
                loaderColor: Color(0xff1b0e97),
                photoSize: 150.0,
//                navigateAfterSeconds:_sharedPrefUserExists==true?curaccountStatus=='Active'?Home():Success(): XDSignIn(),
                navigateAfterSeconds:_sharedPrefUserExists==true?Home(): XDSignIn(),
              );
            },
          );
        },
      ),
    );
  }
}
