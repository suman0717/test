import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterSwitch Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Default"),
            SizedBox(height: 10.0),

            SizedBox(height: 20.0),
            Text("Custom Colors"),
            SizedBox(height: 10.0),

            SizedBox(height: 20.0),
            Text("With 'On' and 'Off' text and custom text colors"),
            SizedBox(height: 10.0),

            SizedBox(height: 20.0),
            Text("Custom size"),
            SizedBox(height: 10.0),

            SizedBox(height: 20.0),
            Text("Custom border radius and padding"),
            SizedBox(height: 10.0),

            SizedBox(height: 20.0),
            Text("Custom text"),
            SizedBox(height: 10.0),

          ],
        ),
      ),
    );
  }
}