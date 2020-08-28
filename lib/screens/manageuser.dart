import 'dart:convert';
import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/screens/SignIn.dart';
import 'package:radreviews/screens/addNewUser.dart';
import 'package:radreviews/screens/editUserDetails.dart';
import 'package:radreviews/screens/manageuser_prior.dart';
import 'package:radreviews/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class ManageUser extends StatefulWidget {
  @override
  _ManageUserState createState() => _ManageUserState();
}

bool waiting = false;
List<String> filterActionList = ['All', 'Actioned', 'Not Actioned'];
List<String> filterNameList = ['All'];

class _ManageUserState extends State<ManageUser> {
  List<Widget> customListManageUser = [];
  List<Widget> filteredcustomListManageUser = [];

  int len;

  void initState() {
    setState(() {
      waiting = true;
    });
    getAllUsers().whenComplete(() {
      setState(() {
        waiting = false;
      });
      print("success");
    }).catchError((error, stackTrace) {
      setState(() {
        waiting = false;
      });
      print("outer: $error");
    });

    super.initState();
  }

  Future<List<Widget>> getAllUsers() async {
    List jsonRes;
    setState(() {
      waiting = true;
    });
    print(kURLBase + 'REST/REVIEWS/App_ManageUser?Client=$curClientID');
    var data = await http
        .get(kURLBase + 'REST/REVIEWS/App_ManageUser?Client=$curClientID');

    try{
      var jsonData = json.decode(data.body);
      if (jsonData['response'] != null) {
        filterNameList = ['All'];
        print('not null');
        jsonRes = jsonData['response'];
        print(jsonRes);
        print(jsonRes.length);
        len = jsonRes.length;

        for (int i = 0; i < jsonRes.length; i++) {
          print(i);
          print(jsonRes[i]["EXT_ID"]);
          if (!(filterNameList.contains(jsonRes[i]["Name"]))) {
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
      } else {
        filterNameList = ['All'];
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
    catch(e){await Flushbar(
      titleText: Text(
        'Error',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 2.0 *
              SizeConfig.heightMultiplier,
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        'Something went wrong.',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 1.3 *
              SizeConfig.heightMultiplier,
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.left,
      ),
      padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 5.1 *
              SizeConfig.widthMultiplier),
      icon: Icon(
        Icons.clear,
        size: 3.94 *
            SizeConfig.heightMultiplier,
        color: Colors.white,
      ),
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      borderColor: Colors.transparent,
      shouldIconPulse: false,
      maxWidth:
      91.8 * SizeConfig.widthMultiplier,
      boxShadows: [
        BoxShadow(
          color:
          Colors.black.withOpacity(0.3),
          spreadRadius:
          1 * SizeConfig.heightMultiplier,
          blurRadius:
          2 * SizeConfig.heightMultiplier,
          offset: Offset(0,
              10), // changes position of shadow
        ),
      ],
      backgroundColor: kshadeColor1,
    ).show(context);}


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
    return ModalProgressHUD(
      inAsyncCall: waiting,
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
            SizedBox(
              height: 10.0,
            ),
            ListTile(
                leading: SizedBox(width: 12 * SizeConfig.widthMultiplier),
                title: Text(
                  'User Name',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 15,
                    color: const Color(0xffa1a1a1),
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: SizedBox(
                  width: 25.51 * SizeConfig.widthMultiplier,
                  child: IconButton(
                      icon: (Icon(
                        Icons.person_add,
                        color: kshadeColor1,
                      )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewUser()));
                      }),
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: filteredcustomListManageUser,
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

  UserDetails(
      {this.first_Name,
      this.surName,
      this.id,
      this.mobile_masked,
      this.email,
      this.primary_User,
      this.pwd,
      this.mobile});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserDetailsCheckbox(
        isPrimary_User: primary_User == 'Yes' ? true : false,
        id: id,
      ),
      title: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 1.31 * SizeConfig.heightMultiplier),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$first_Name $surName',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 15,
                color: const Color(0xff363636),
              ),
            )
          ],
        ),
      ),
      trailing: SizedBox(
        width: 25.0 * SizeConfig.widthMultiplier,
        child: RawMaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditUserDetails(
                  firstName: first_Name,
                  surname: surName,
                  userName: email,
                  mobile: mobile,
                  maskednumber: mobile_masked,
                  password: pwd,
                  confirm_Password: pwd,
                  id: id,
                ),
              ),
            );
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
  bool isPrimary_User;

  UserDetailsCheckbox({this.isPrimary_User, this.id});

  @override
  _UserDetailsCheckboxState createState() => _UserDetailsCheckboxState();
}

class _UserDetailsCheckboxState extends State<UserDetailsCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: kshadeColor1,
        value: widget.isPrimary_User,
        onChanged: (bool s) {
          setState(() {
            widget.isPrimary_User = s;
            print(widget.isPrimary_User);
            print(widget.id);
            print('text');
            MarkAsPrimaryUser();
          });
        });
  }

  void MarkAsPrimaryUser() async {
    setState(() {
      waiting = true;
    });
    await Flushbar(
      titleText: Text(
        'Updating . . .',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 2.0 * SizeConfig.heightMultiplier,
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        'This User is being marked as Primary user.',
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
        Icons.priority_high,
        size: 3.94 * SizeConfig.heightMultiplier,
        color: Colors.white,
      ),
      duration: Duration(seconds: 2),
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
    print(widget.isPrimary_User);
    print(widget.id);
    print(kURLBase +
        'REST/REVIEWS/App_MakePrimaryUser?Client=$curClientID&CUID=${widget.id}&Primary_User=${widget.isPrimary_User == true ? 'Yes' : 'No'}');
    http.Response _response = await http.get(kURLBase +
        'REST/REVIEWS/App_MakePrimaryUser?Client=$curClientID&CUID=${widget.id}&Primary_User=${widget.isPrimary_User == true ? 'Yes' : 'No'}');
    try {
      var _data = _response.body;
      print(_data);
      setState(() {
        waiting = false;
      });
      await Flushbar(
        titleText: Text(
          'Updated',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        messageText: Text(
          'User has being marked as Primary user.',
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
        duration: Duration(seconds: 2),
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ManageUserNew()));
    } catch (e) {
      print(e);
      await Flushbar(
        titleText: Text(
          'Error',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 2.0 *
                SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        messageText: Text(
          'Something went wrong.',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 1.3 *
                SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.left,
        ),
        padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 5.1 *
                SizeConfig.widthMultiplier),
        icon: Icon(
          Icons.clear,
          size: 3.94 *
              SizeConfig.heightMultiplier,
          color: Colors.white,
        ),
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        borderColor: Colors.transparent,
        shouldIconPulse: false,
        maxWidth:
        91.8 * SizeConfig.widthMultiplier,
        boxShadows: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.3),
            spreadRadius:
            1 * SizeConfig.heightMultiplier,
            blurRadius:
            2 * SizeConfig.heightMultiplier,
            offset: Offset(0,
                10), // changes position of shadow
          ),
        ],
        backgroundColor: kshadeColor1,
      ).show(context);
    }
  }
}
