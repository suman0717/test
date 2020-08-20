//import 'package:flutter/material.dart';
//
//import 'Homepage.dart';
//import 'Setting.dart';
//import 'Print.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//// This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  MyHomePageState createState() => MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//  int _currentIndex=0;
//  final List<Widget> _children=
//  [
//    Homepage(),
//    Setting(),
//    Print(),
//  ];
//
//  void ontabbed(int index){
//    setState(() {
//      _currentIndex= index;
//    });
//  }
//
//  void _incrementCounter() {
//    setState(() {
//
//      _currentIndex=0;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: _children[_currentIndex],
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: ontabbed,
//        currentIndex: _currentIndex,
//        type: BottomNavigationBarType.fixed,
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Home'),
//              backgroundColor: Colors.green),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.camera),
//              title: Text('Camera'),
//              backgroundColor: Colors.blue
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.print),
//              title: Text('Print'),
//              backgroundColor: Colors.red
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.settings),
//              title: Text('Setting'),
//              backgroundColor: Colors.pink
//          )
//        ],
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}