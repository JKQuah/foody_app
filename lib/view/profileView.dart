import 'package:flutter/material.dart';
import 'package:foody_app/widget/app_bar.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.grey,
      body: Center(
        child: Text('profile'),
      ),
    );
  }
}
