import 'package:flutter/material.dart';
import 'package:foody_app/widget/app_bar.dart';

class MeetAndEatView extends StatefulWidget {
  MeetAndEatView({Key key}) : super(key: key);

  @override
  _MeetAndEatViewState createState() => _MeetAndEatViewState();
}

class _MeetAndEatViewState extends State<MeetAndEatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Text('meet and eat'),
      ),
    );
  }
}
