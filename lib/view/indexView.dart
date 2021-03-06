import 'dart:async';

import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/view/loadingView.dart';
import 'package:foody_app/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String token;
  MyHomePage({Key key, this.token}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(token: token);
}

class _MyHomePageState extends State<MyHomePage> {
  final String token;
  @override
  void initState() {
    String jwtToken = token;
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIiLCJpYXQiOjE2MTE1ODg5NjcsImV4cCI6MTYxMTY3NTM2N30.Yl4vAHo5b6dA496SMOuRM-yqrk1XiXF362GA0r6Nhy8";
    HTTPUtils.saveJWToken(jwtToken);
    super.initState();
  }

  _MyHomePageState({this.token});

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit ' + AppConstants.APP_NAME),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text(
                  'Yes',
                  style: TextStyle(color: AppColors.TEXT_COLOR),
                ),
              ),
              new FlatButton(
                color: AppColors.PRIMARY_COLOR,
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: BottomNavBar(),
    );
  }
}
