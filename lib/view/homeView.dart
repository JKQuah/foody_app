import 'package:flutter/material.dart';
import 'package:foody_app/widget/app_bar.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Text('home'),
      ),
    );
  }
}
