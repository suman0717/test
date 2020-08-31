// Future<List<Widget>> getNegFeedback() async {
//   List jsonRes;
//   setState(() {
//     waiting=true;
//   });
//   var data = await http.get(
//       kURLBase+'REST/REVIEWS/App_NegFeedback?Client=$curClientID&Ticked1=All&Name=All');
//   var jsonData = json.decode(data.body);
//   if(jsonData['response'] != null){
//     filterNameList=['All'];
//     print('not null');
//     jsonRes = jsonData['response'];
//     print(jsonRes);
//     print(jsonRes.length);
//     len = jsonRes.length;
//
//
//     for (int i = 0; i < jsonRes.length; i++) {
//       print(i);
//       print(jsonRes[i]["EXT_ID"]);
//       if(!(filterNameList.contains(jsonRes[i]["Name"]))){
//         filterNameList.add(jsonRes[i]["Name"]);
//       }
//
//       var _txt = NegFeedbackListTile(
//         name: jsonRes[i]["Name"],
//         actioned: jsonRes[i]["Ticked1"],
//         email: jsonRes[i]["EmailAddress"],
//         id: jsonRes[i]["EXT_ID"],
//         mobile: jsonRes[i]["Mobile"],
//         SMSSentDateTime: jsonRes[i]["SMSSentDateTime"],
//         message: jsonRes[i]["Message"],
//       );
//       customListTileNegFeedback.add(_txt);
//       filteredCustomListTileNegFeedback.add(_txt);
//     }
//   }
//   else{
//     filterNameList=['All'];
//     filterNameList.add(jsonData['Name']);
//     var _txt = NegFeedbackListTile(
//       name: jsonData['Name'],
//       actioned: jsonData['Ticked1'],
//       email: jsonData['EmailAddress'],
//       id: jsonData['EXT_ID'],
//       mobile: jsonData['Mobile'],
//       SMSSentDateTime: jsonData['SMSSentDateTime'],
//       message: jsonData["Message"],
//     );
//     customListTileNegFeedback.add(_txt);
//     filteredCustomListTileNegFeedback.add(_txt);
//   }
//   print(filterNameList);
//   return customListTileNegFeedback;
//
// }