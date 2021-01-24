import 'package:flutter/material.dart';
import 'package:foody_app/model/user_list_dto.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/model/post_grid_dto.dart';
import 'package:foody_app/model/profile_dto.dart';
import 'package:foody_app/services/profileHTTPService.dart';

class ProfileView extends StatefulWidget {
  final UserListDTO user;

  ProfileView({Key key, @required this.user}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<ProfileDTO> profile;
  Future<List<PostGridDTO>> posts;

  @override
  void initState() {
    profile = ProfileHTTPService.getUserProfile(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: new EdgeInsets.fromLTRB(5.0, 30.0, 10.0, 5.0),
          child: Column(
              children: [
                FutureBuilder<ProfileDTO>(
                  future: profile,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                    children: [
                                      Container(
                                          width: 75.0,
                                          height: 75.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                    snapshot.data.imageUrl ?? "https://thumbs.dreamstime.com/b/default-avatar-photo-placeholder-profile-picture-default-avatar-photo-placeholder-profile-picture-eps-file-easy-to-edit-125707135.jpg",
                                                  )
                                              )
                                          ))
                                    ]
                                ),
                                Column(
                                    children: [
                                      Text(
                                        snapshot.data.postCount.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                      ),
                                      Text(
                                        "Post",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                      ),
                                    ]
                                ),
                                Column(
                                    children: [
                                      Text(
                                        snapshot.data.followerCount.toString() ?? "0",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                      ),
                                      Text(
                                        "Followers",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                      ),
                                    ]
                                ),
                                Column(
                                    children: [
                                      Text(
                                        snapshot.data.followingCount.toString() ?? "0",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                      ),
                                      Text(
                                        "Followings",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                      ),
                                    ]
                                )
                              ]
                          ),
                          Container(
                              alignment: FractionalOffset.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        snapshot.data.username ?? "username",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:16
                                        )
                                    ),
                                    SizedBox(
                                        height:5
                                    ),
                                    Text(
                                        snapshot.data.biography ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300
                                        )
                                    )
                                  ]
                              )
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }
                ),
                Divider(
                  color: Colors.black54,
                  thickness: 0.5,

                ),
                Expanded(
                  child: FutureBuilder<List<PostGridDTO>>(
                    future: posts,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return new GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new NetworkImage(
                                      snapshot.data[index].imageUrl),
                                    fit: BoxFit.contain)
                                )
                              )
                            );
                          },
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Text(
                            'No Post',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.TEXT_COLOR
                            )
                          )
                        );
                      }
                    }
                  ),
                )
              ]
          )
        ),
      ),
    );
  }
}
