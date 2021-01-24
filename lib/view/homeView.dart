import 'package:flutter/material.dart';
import 'package:foody_app/model/post_model.dart';
// import 'package:foody_app/view_model/post_view_model.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/widget/post_widget.dart';
import 'package:foody_app/services/postService.dart';
import '../resource/app_colors.dart';
import '../resource/app_constants.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<PostModel>> posts;

  @override
  void initState() {
    super.initState();
    posts = PostService().fetchPosts();
  }

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
            child: FutureBuilder<List<PostModel>>(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data[index];
                      return PostWidget(post: item);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
