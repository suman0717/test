import 'package:flutter/material.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/screens/myapp.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        accentColor: Colors.white,
            primaryColor: kshadeColor1,
      ),
      title: 'Rad Reviews',
      home: MyApp(),
    )
  );
}