import 'package:flutter/material.dart';
import 'package:foody_app/widget/app_bar.dart';

class FoodSuggestionView extends StatefulWidget {
  FoodSuggestionView({Key key}) : super(key: key);

  @override
  _FoodSuggestionViewState createState() => _FoodSuggestionViewState();
}

class _FoodSuggestionViewState extends State<FoodSuggestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text('food suggestion'),
      ),
    );
  }
}
