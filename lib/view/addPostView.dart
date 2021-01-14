import 'package:flutter/material.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey[900],
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Phone Gallery',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Text(
          'Phone Gallery',
        ),
      ),
    );
  }
}
