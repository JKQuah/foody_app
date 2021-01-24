import 'package:flutter/material.dart';
import 'package:foody_app/utils/sharedPreferenceUtils.dart';
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
    String jwtToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIiLCJpYXQiOjE2MTEzOTQyMTcsImV4cCI6MTYxMTQ4MDYxN30.E2EGbAfh9tIOhYm3YHneq_4Ii5hml_SCNBQx7dLq7lk";
    SharedPreferenceUtils.saveJWToken(jwtToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBar();
  }
}
