import 'package:flutter/material.dart';
import 'package:foody_app/view/loadingView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => Loading(),
      //   '/home': (context) => MyApp(),
      // },
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Nexa',
      ),
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
