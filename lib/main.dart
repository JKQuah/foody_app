import 'package:flutter/material.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/widget/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Nexa',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    String jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUiLCJpYXQiOjE2MTEzNjU0MzMsImV4cCI6MTYxMTQ1MTgzM30.LjLj_kdKjeTY0Ip4ks9suABW6QoPCW7wusIAZ7kQdpA";
    HTTPUtils.saveJWToken(jwtToken);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavBar();
  }
}
