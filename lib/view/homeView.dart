import 'package:flutter/material.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/widget/post_widget.dart';

import '../resource/app_colors.dart';
import '../resource/app_constants.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PostModel> posts = [
    PostModel(username: 'quah_jia_kai'),
    PostModel(username: 'QJK 2'),
    PostModel(username: 'QJK 3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              AppConstants.NEWSFEED_TITLE,
              style: TextStyle(
                fontFamily: 'Nexa',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.TEXT_COLOR,
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) => Column(
                children: posts
                    .map((post) => PostWidget(
                          post: post,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
