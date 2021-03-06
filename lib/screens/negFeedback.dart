import 'dart:convert';
import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:radreviews/size_config.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class NegFeedback extends StatefulWidget {
  @override
  _NegFeedbackState createState() => _NegFeedbackState();
}
bool waiting = false;
bool isticked=false;
String filterAction='All';
String filterName='All';
List<String> filterActionList=['All','Actioned','Not Actioned'];
List<String> filterNameList=['All'];
class _NegFeedbackState extends State<NegFeedback> {
  List<Widget> customListTileNegFeedback=[];
  List<Widget> filteredCustomListTileNegFeedback=[];

  int len;

  void initState() {
    setState(() {
      waiting=true;
    });
    getNegFeedback().whenComplete(() {
      setState(() {waiting=false;});
      print("success");

    }).catchError((error, stackTrace) {
      setState(() {waiting=false;});
      print("outer: $error");
    });

    super.initState();
  }

  Future<List<Widget>> getNegFeedback() async {
    List jsonRes;
    setState(() {
      waiting=true;
    });
    var data = await http.get(
        kURLBase+'REST/REVIEWS/App_NegFeedback?Client=$curClientID&Ticked1=All&Name=All');
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

         var _txt = NegFeedbackListTile(
           name: jsonRes[i]["Name"],
           actioned: jsonRes[i]["Ticked1"],
           email: jsonRes[i]["EmailAddress"],
           id: jsonRes[i]["EXT_ID"],
           mobile: jsonRes[i]["Mobile"],
           SMSSentDateTime: jsonRes[i]["SMSSentDateTime"],
           message: jsonRes[i]["Message"],
         );
         customListTileNegFeedback.add(_txt);
         filteredCustomListTileNegFeedback.add(_txt);
       }
    }
    else{
      filterNameList=['All'];
      filterNameList.add(jsonData['Name']);
       var _txt = NegFeedbackListTile(
         name: jsonData['Name'],
         actioned: jsonData['Ticked1'],
         email: jsonData['EmailAddress'],
         id: jsonData['EXT_ID'],
         mobile: jsonData['Mobile'],
         SMSSentDateTime: jsonData['SMSSentDateTime'],
         message: jsonData["Message"],
       );
       customListTileNegFeedback.add(_txt);
      filteredCustomListTileNegFeedback.add(_txt);
    }
    print(filterNameList);
    return customListTileNegFeedback;

  }
  Future<List<Widget>> getNegFeedbackFiltered() async {
    filteredCustomListTileNegFeedback=[];
    List jsonRes;
    setState(() {
      waiting=true;
    });
    print('Filtered');
    print(kURLBase+'REST/REVIEWS/App_NegFeedback?Client=$curClientID&Ticked1=$filterAction&Name=$filterName');
    var data = await http.get(
        kURLBase+'REST/REVIEWS/App_NegFeedback?Client=$curClientID&Ticked1=$filterAction&Name=$filterName');
    try{var jsonData = json.decode(data.body);
    if(jsonData['response'] != null){
      print('not null');
      jsonRes = jsonData['response'];
      print(jsonRes);
      print(jsonRes.length);
      len = jsonRes.length;


      for (int i = 0; i < jsonRes.length; i++) {
        print(i);
        print(jsonRes[i]["EXT_ID"]);
        var _txt = NegFeedbackListTile(
          name: jsonRes[i]["Name"],
          actioned: jsonRes[i]["Ticked1"],
          email: jsonRes[i]["EmailAddress"],
          id: jsonRes[i]["EXT_ID"],
          mobile: jsonRes[i]["Mobile"],
          SMSSentDateTime: jsonRes[i]["SMSSentDateTime"],
          message: jsonRes[i]["Message"],
        );
        customListTileNegFeedback.add(_txt);
        filteredCustomListTileNegFeedback.add(_txt);
      }
    }
    else{
      var _txt = NegFeedbackListTile(
        name: jsonData['Name'],
        actioned: jsonData['Ticked1'],
        email: jsonData['EmailAddress'],
        id: jsonData['EXT_ID'],
        mobile: jsonData['Mobile'],
        SMSSentDateTime: jsonData['SMSSentDateTime'],
        message: jsonData["Message"],
      );
      customListTileNegFeedback.add(_txt);
      filteredCustomListTileNegFeedback.add(_txt);
    }
    print(filterNameList);}
    catch(e){
      print(e);
    }

    setState(() {
      waiting=false;
    });
    return customListTileNegFeedback;

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
                      'NEGATIVE FEEDBACK',
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
              Container(padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 11.0 * SizeConfig.heightMultiplier,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.9 * SizeConfig.heightMultiplier,

                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(

                            height: 5.7 * SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  4 * SizeConfig.heightMultiplier),
                              border: Border.all(
                                  color: Color(0xffe8e8e8), width: 1.0),
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                items: filterNameList.map((e) {
                                  return DropdownMenuItem<String>(child: Text(e),value: e,);
                                }).toList(),
                                onChanged: (e){
                                  setState(() {
                                    filterName=e;
                                    getNegFeedbackFiltered();
                                  });
                                },
                                value: filterName,
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
                        ],
                      ),
                    ),
                    SizedBox(width: 2.5 * SizeConfig.widthMultiplier,),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Status',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.9 * SizeConfig.heightMultiplier,

                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(

                            height: 5.7 * SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  4 * SizeConfig.heightMultiplier),
                              border: Border.all(
                                  color: Color(0xffe8e8e8), width: 1.0),
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                items: filterActionList.map((e) {
                                  return DropdownMenuItem<String>(child: Text(e),value: e,);
                                }).toList(),
                                onChanged: (e){
                                  setState(() {
                                    filterAction=e;
                                    getNegFeedbackFiltered();
                                  });
                                },
                                value: filterAction,
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
                        ],
                      ),
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

                      children: filteredCustomListTileNegFeedback,
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

class NegFeedbackListTile extends StatefulWidget {
  String name;
  int id;
  String SMSSentDateTime;
  String email;
  String mobile;
  String actioned;
  String message;

  NegFeedbackListTile({this.name,this.id,this.SMSSentDateTime,this.mobile,this.email,this.actioned,this.message});
  @override
  _NegFeedbackListTileState createState() => _NegFeedbackListTileState();
}

class _NegFeedbackListTileState extends State<NegFeedbackListTile> {

  void showRequestFeedbackMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5.0,
            title: Text(
              'Feedback Message',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 3.0 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 1.9 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NegFeedbackCheckbox(isActioned: widget.actioned=='Actioned'?true:false,id: widget.id,),
      title:Padding(
        padding: EdgeInsets.symmetric(vertical:1.31* SizeConfig.heightMultiplier),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text.rich(

              TextSpan(
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 11,
                  color: const Color(0xffa1a1a1),
                ),
                children: [
                  TextSpan(
                    text: '${widget.name}\n',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      color: const Color(0xff363636),
                    ),
                  ),
                  TextSpan(
                    text: 'ID: ${widget.id}\n${widget.SMSSentDateTime}\n',
                  ),
                  TextSpan(
                    text: '${widget.email}\n${widget.mobile}',
                    style: TextStyle(
                      color: const Color(0xff971a9f),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      trailing: SizedBox(width: 25.0 * SizeConfig.widthMultiplier,
        child: FittedBox(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 27.9 * SizeConfig.widthMultiplier,
                height: 3.55 * SizeConfig.heightMultiplier,
                child: RaisedButton(
                  onPressed: () {
                    print(widget.message);
                    showRequestFeedbackMessage();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.53* SizeConfig.heightMultiplier)),
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
                        'Feedback',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 11,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.31* SizeConfig.heightMultiplier,),
              Container(
                width: 27.9 * SizeConfig.widthMultiplier,
                height: 3.55 * SizeConfig.heightMultiplier,
                child: OutlineButton( borderSide: BorderSide(
                  color: kshadeColor1, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 1.5, //width of the border
                ),
                  onPressed: () async {
                    setState(() {
                      print('object');
                      waiting=true;
                    });
                    await http.get(kURLBase+ 'REST/REVIEWS/App_Email_Me1?CUID=$curClientUserID&Neg_Review_ID=${widget.id}');
                    try{
                      setState(() {
                        waiting=false;
                      });
                      Flushbar(
                        titleText: Text(
                          'Email Sent',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 2.0 * SizeConfig.heightMultiplier,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        messageText: Text(
                          'Email has been sent to your registered email address.',
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
                    }
                    catch(e){
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

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.53* SizeConfig.heightMultiplier)),
                  padding: EdgeInsets.all(0.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),

                          borderRadius:
                          BorderRadius.circular(2.9 *SizeConfig.heightMultiplier)),
                      alignment: Alignment.center,
                      child: Text(
                        'Email Me',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 11,
                          color: kshadeColor1,
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
    );
  }
}

class NegFeedbackCheckbox extends StatefulWidget {
  int id;
  bool isActioned;
  NegFeedbackCheckbox({this.isActioned,this.id});
  @override
  _NegFeedbackCheckboxState createState() => _NegFeedbackCheckboxState();
}

class _NegFeedbackCheckboxState extends State<NegFeedbackCheckbox> {
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
    http.Response _response = await http.get(kURLBase+ 'REST/REVIEWS/App_Is_Actioned?Neg_Review_ID=${widget.id}&Ticked1=${widget.isActioned==true?'Actioned':'Not Actioned'}');
    try{
    var _data = _response.body;
    print(_data);
    setState(() {
      waiting=false;
    });
    }
    catch(e){
      setState(() {
        waiting=false;
      });
      Flushbar(
        titleText: Text(
          'Email Sent',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        messageText: Text(
          'Email has been sent to your registered email address.',
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
    }
  }
}
