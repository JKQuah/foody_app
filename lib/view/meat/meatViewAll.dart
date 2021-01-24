import 'package:flutter/material.dart';
import 'package:foody_app/view/meat/meatCreate.dart';
import 'package:foody_app/view/meat/meatViewOne.dart';
import 'package:foody_app/widget/app_bar.dart';

class MeatViewAll extends StatefulWidget {
  MeatViewAll({Key key}) : super(key: key);

  @override
  _MeatViewAllState createState() => _MeatViewAllState();
}

class _MeatViewAllState extends State<MeatViewAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => MeatViewOne()),
              MaterialPageRoute(builder: (context) => MeatCreate()),
            );
          },
          icon: Icon(Icons.alternate_email),
          color: Colors.amber,
        ),
      ),
    );
  }
}
