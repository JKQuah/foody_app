import 'dart:async';

import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/sharedPreferenceUtils.dart';
import 'package:foody_app/view/loadingView.dart';
import 'package:foody_app/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    String jwtToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIiLCJpYXQiOjE2MTE0ODEzNTcsImV4cCI6MTYxMTU2Nzc1N30.1SrS_GEacUG-BTI2SxcUuvN6vOT9KsA0N4OJ657x3FI";
    SharedPreferenceUtils.saveJWToken(jwtToken);
    super.initState();
  }

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
