import 'package:flutter/material.dart';
import 'package:foody_app/widget/app_bar.dart';

class FindFriendView extends StatefulWidget {
  FindFriendView({Key key}) : super(key: key);

  @override
  _FindFriendViewState createState() => _FindFriendViewState();
}

class _FindFriendViewState extends State<FindFriendView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Text('food suggestion'),
      ),
    );
  }
}
