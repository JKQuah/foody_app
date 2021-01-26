import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/services/followingHTTPService.dart';
import 'package:foody_app/services/postService.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/model/post_grid_dto.dart';
import 'package:foody_app/model/profile_dto.dart';
import 'package:foody_app/services/profileHTTPService.dart';

class ProfileView extends StatefulWidget {
  final int userId;

  ProfileView({Key key, @required this.userId}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<ProfileDTO> profile;
  Future<List<PostGridDTO>> posts;
  int myId;

  @override
  void initState() {
    HTTPUtils.decodeJWT().then((data) {
      myId = data;
    });
    print(myId);
    posts = PostService.getGridPosts(widget.userId);
    profile = ProfileHTTPService.getUserProfile(widget.userId);
    super.initState();
  }

  void _refresh() {
    setState(() {
      profile = ProfileHTTPService.getUserProfile(widget.userId);
    });
  }

  Widget _buildButton(bool isFollowing) {
    if (widget.userId != myId) {
      if (isFollowing) {
        return ButtonTheme(
          minWidth: 250.0,
          child: OutlineButton(
              child: Text("Following"),
              onPressed: () async {
                if (await FollowingHTTPService.unfollowUser(widget.userId)) {
                  _refresh();
                }
              }),
        );
      } else {
        return ButtonTheme(
          minWidth: 250.0,
          child: RaisedButton(
              color: AppColors.PRIMARY_COLOR,
              child: Text("Follow", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if (await FollowingHTTPService.followUser(widget.userId)) {
                  _refresh();
                }
              }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
            padding: new EdgeInsets.fromLTRB(5.0, 30.0, 10.0, 5.0),
            child: Column(children: [
              FutureBuilder<ProfileDTO>(
                  future: profile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        width: 65.0,
                                        height: 65.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: new NetworkImage(
                                                  snapshot.data.imageUrl ??
                                                      "https://thumbs.dreamstime.com/b/default-avatar-photo-placeholder-profile-picture-default-avatar-photo-placeholder-profile-picture-eps-file-easy-to-edit-125707135.jpg",
                                                ))))
                                  ]),
                            ),
                            Container(width: 10),
                            Expanded(
                              flex: 10,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(children: [
                                        Text(
                                          snapshot.data.postCount.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        Text(
                                          "Post",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        ),
                                      ]),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(children: [
                                        Text(
                                          snapshot.data.followerCount
                                                  .toString() ??
                                              "0",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        Text(
                                          "Followers",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        ),
                                      ]),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(children: [
                                        Text(
                                          snapshot.data.followingCount
                                                  .toString() ??
                                              "0",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        Text(
                                          "Followings",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        ),
                                      ]),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: _buildButton(
                                          snapshot.data.isFollowing),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ]),
                          Container(
                              alignment: FractionalOffset.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data.username ?? "username",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(height: 5),
                                    Text(snapshot.data.biography ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300))
                                  ])),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
              Divider(color: AppColors.TEXT_COLOR, thickness: 0.5),
              Expanded(
                child: FutureBuilder<List<PostGridDTO>>(
                    future: posts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return new GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.all(2),
                                child: Container(
                                    decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            image: new NetworkImage(
                                                snapshot.data[index].imageUrl),
                                            fit: BoxFit.cover))));
                          },
                        );
                      } else {
                        return Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Text('No Post',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.TEXT_COLOR)));
                      }
                    }),
              )
            ])),
      ),
    );
  }
}
