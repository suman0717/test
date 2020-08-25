import 'dart:convert';
import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/bottomBar.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/editUserDetails.dart';
import 'package:radreviews/screens/feedbackState.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/myaccount.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/smsSent.dart';
import 'package:radreviews/screens/termsandconditins.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class ManageUser extends StatefulWidget {
  @override
  _ManageUserState createState() => _ManageUserState();
}
bool waiting = false;
bool isticked=false;
List<String> filterActionList=['All','Actioned','Not Actioned'];
List<String> filterNameList=['All'];
class _ManageUserState extends State<ManageUser> {
  List<Widget> customListManageUser=[];
  List<Widget> filteredcustomListManageUser=[];

  int len;

  void initState() {
    setState(() {
      waiting=true;
    });
    getAllUsers().whenComplete(() {
      setState(() {waiting=false;});
      print("success");

    }).catchError((error, stackTrace) {
      setState(() {waiting=false;});
      print("outer: $error");
    });

    super.initState();
  }

  Future<List<Widget>> getAllUsers() async {
    List jsonRes;
    setState(() {
      waiting=true;
    });
    print(
        kURLBase+'REST/REVIEWS/App_ManageUser?Client=$curClientID');
    var data = await http.get(
        kURLBase+'REST/REVIEWS/App_ManageUser?Client=$curClientID');

    var jsonData = json.decode(data.body);
    if(jsonData['response'] != null){
      filterNameList=['All'];
      print('not null');
       jsonRes = jsonData['response'];
       print(jsonRes);
       print(jsonRes.length);
       len = jsonRes.length;


       for (int i = 0; i < jsonRes.length; i++) {
         print(i);
         print(jsonRes[i]["EXT_ID"]);
         if(!(filterNameList.contains(jsonRes[i]["Name"]))){
           filterNameList.add(jsonRes[i]["Name"]);
         }

         var _txt = UserDetails(
           first_Name: jsonRes[i]["First_Name"],
           surName: jsonRes[i]["Surname"],
           primary_User: jsonRes[i]["Primary_User"],
           email: jsonRes[i]["EmailAddress"],
           pwd: jsonRes[i]["Decrypted_Password"],
           id: jsonRes[i]["EXT_ID"],
           mobile_masked: jsonRes[i]["Mobile_Masked"],
           mobile: jsonRes[i]["Mobile"],
         );
         customListManageUser.add(_txt);
         filteredcustomListManageUser.add(_txt);
       }
    }
    else{
      filterNameList=['All'];
      filterNameList.add(jsonData['Name']);
       var _txt = UserDetails(
         first_Name: jsonData['First_Name'],
         surName: jsonData["Surname"],
         primary_User: jsonData["Primary_User"],
         email: jsonData['EmailAddress'],
         pwd: jsonData["Decrypted_Password"],
         id: jsonData['EXT_ID'],
         mobile_masked: jsonData['Mobile_Masked'],
         mobile: jsonData['Mobile'],
       );
       customListManageUser.add(_txt);
      filteredcustomListManageUser.add(_txt);
    }
    print(filterNameList);
    return customListManageUser;

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
    return ModalProgressHUD(          inAsyncCall: waiting,
      color: Color(0xff3ba838),
      opacity: 0.1,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
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
                      'MANAGE USERS',
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

                      children: filteredcustomListManageUser,
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

class UserDetails extends StatelessWidget {
  String first_Name;
  String surName;
  int id;
  String email;
  String mobile_masked;
  String mobile;
  String primary_User;
  String pwd;

  UserDetails({this.first_Name,this.surName,this.id,this.mobile_masked,this.email,this.primary_User,this.pwd, this.mobile});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserDetailsCheckbox(isActioned: false,id: id,),
      title:Padding(
        padding: EdgeInsets.symmetric(vertical:1.31* SizeConfig.heightMultiplier),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Text('$first_Name $surName' ,style: TextStyle(
  fontFamily: 'Manrope',
  fontSize: 15,
  color: const Color(0xff363636),
),)

          ],
        ),
      ),
      trailing: SizedBox(width: 25.0 * SizeConfig.widthMultiplier,
        child: RawMaterialButton(
          onPressed: () {
//            tempfirst_Name ='';
//            tempsurName ='';
//            tempid = 0;
//            tempemail = '';
//            tempmobile ='';
//            tempunmaskedmobile = '';
//            tempprimary_User = '';
//            temppwd ='';
//            print(mobile_masked);
//            print(mobile);
//            print(first_Name);
//             tempfirst_Name=first_Name;
//             tempsurName=surName;
//            tempid=id;
//             tempemail=email;
//             tempmobile=mobile_masked;
//             tempunmaskedmobile=mobile;
//             tempprimary_User=primary_User;
//             temppwd=pwd;
//             if(tempfirst_Name !=null && tempsurName !=null && tempid != null && tempemail != null && tempmobile !=null && tempunmaskedmobile != null && tempprimary_User != null && temppwd !=null){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>EditUserDetails(userDetail: this.,)));
//             }
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditUserDetails(
              firstName: first_Name,
              surname: surName,
              userName: email,
            mobile: mobile,
            maskednumber: mobile_masked,
            password: pwd,
            confirm_Password: pwd,
            id: id,)));
            },
          elevation: 5.0,
          fillColor: Colors.white,
          child: Icon(
            FontAwesomeIcons.solidEdit,
            size: 12.0,
            color: kshadeColor1,
          ),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}

class UserDetailsCheckbox extends StatefulWidget {
  int id;
  bool isActioned;
  UserDetailsCheckbox({this.isActioned,this.id});
  @override
  _UserDetailsCheckboxState createState() => _UserDetailsCheckboxState();
}

class _UserDetailsCheckboxState extends State<UserDetailsCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(activeColor: kshadeColor1,value: widget.isActioned, onChanged: (bool s)  {
      setState(()  {
        widget.isActioned=s;
        print(widget.isActioned);
        print(widget.id);
        print('text');
        MakeActionedNotActioned();
      });});
  }

  void MakeActionedNotActioned() async{
    setState(() {
      waiting=true;
    });
    print(widget.isActioned);
    print(widget.id);
    print(kURLBase+ 'REST/REVIEWS/App_Is_Actioned?Neg_Review_ID=${widget.id}&Ticked1=${widget.isActioned==true?'Actioned':'Not Actioned'}');
//    http.Response _response = await http.get(kURLBase+ 'REST/REVIEWS/App_Is_Actioned?Neg_Review_ID=${widget.id}&Ticked1=${widget.isActioned==true?'Actioned':'Not Actioned'}');
//    var _data = _response.body;
//    print(_data);
    setState(() {
      waiting=false;
    });
  }
}
