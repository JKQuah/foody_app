import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/view/user/createProfile.dart';
import 'indexView.dart';

class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupHomeView() async {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfileCreate())));
  }

  @override
  void initState() {
    super.initState();
    setupHomeView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 10,
            child: Center(
              child: Image(
                image: AssetImage("assets/app_logo.png"),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              "Among Us 2.0",
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              "WIX3004 Mobile Application Development",
              style: TextStyle(
                color: AppColors.ACCENT_COLOR,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
