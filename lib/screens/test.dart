import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  _FirstPageState() {
    textField = SimpleAutoCompleteTextField(
      key: key,
      decoration: new InputDecoration(errorText: "Beans"),
      controller: TextEditingController(text: "Starting Text"),
      suggestions: suggestionsx,
      textChanged: (text) => currentText = text,
      clearOnSubmit: true,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          added.add(text);
        }
      }),
    );
  }

  List<String> suggestionsx = [
    "Apple",
    "Armidillo",
    "Actual",
    "Actuary",
    "America",
    "Argentina",
    "Australia",
    "Antarctica",
    "Blueberry",
    "Cheese",
    "Danish",
    "Eclair",
    "Fudge",
    "Granola",
    "Hazelnut",
    "Ice Cream",
    "Jely",
    "Kiwi Fruit",
    "Lamb",
    "Macadamia",
    "Nachos",
    "Oatmeal",
    "Palm Oil",
    "Quail",
    "Rabbit",
    "Salad",
    "T-Bone Steak",
    "Urid Dal",
    "Vanilla",
    "Waffles",
    "Yam",
    "Zest"
  ];

  SimpleAutoCompleteTextField textField;
  bool showWhichErrorText = false;

  @override
  Widget build(BuildContext context) {
    Column body = new Column(children: [
      new ListTile(
          title: textField,
          trailing: new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                textField.triggerSubmitted();
//                showWhichErrorText = !showWhichErrorText;
//                textField.updateDecoration(
//                    decoration: new InputDecoration(
//                        errorText: showWhichErrorText ? "Beans" : "Tomatoes"));
              })),
    ]);

    body.children.addAll(added.map((item) {
      return new ListTile(title: new Text(item));
    }));

    return new Scaffold(
        resizeToAvoidBottomPadding: false,

        body: body);
  }
}

class ArbitrarySuggestionType {
  //For the mock data type we will use review (perhaps this could represent a restaurant);
  num stars;
  String name, imgURL;

  ArbitrarySuggestionType(this.stars, this.name, this.imgURL);
}
