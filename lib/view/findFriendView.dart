import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/view/profileView.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/model/user_list_dto.dart';
import 'package:foody_app/services/followingHTTPService.dart';


class FindFriendView extends StatefulWidget {
  FindFriendView({Key key}) : super(key: key);

  @override
  _FindFriendViewState createState() => _FindFriendViewState();
}

class _FindFriendViewState extends State<FindFriendView> {
  Future<List<UserListDTO>> users;
  final fieldText = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchUser("");
  }

  void searchUser(username) {
    setState(() {
      if(username == ""){
        users = FollowingHTTPService.getAllFollowingUsers();
      } else {
        users = FollowingHTTPService.getUserLikeUsername(username);
      }
    });
  }

  void clearText(){
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: new Padding(
              padding: new EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 8.0),
              child: Text (
                "Find Friends",
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
              )
            )
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: new TextField(
              onChanged: (value) {
                searchUser(value);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.black54,),
                hintText: 'Search username',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26, width: 2.0),
                    borderRadius: BorderRadius.circular(32.0)
              )
              ),
              controller: fieldText,
            )
          ),
          Expanded(
            child: FutureBuilder<List<UserListDTO>>(
              future: users,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return new ListTile(
                          leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 44,
                                  maxHeight: 44
                              ),
                              child: Container(
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.contain,
                                          image: new NetworkImage(snapshot.data[index].imageUrl ??
                                          "https://thumbs.dreamstime.com/b/default-avatar-photo-placeholder-profile-picture-default-avatar-photo-placeholder-profile-picture-eps-file-easy-to-edit-125707135.jpg")
                                      )
                                  )
                              )
                          ),
                          title: Text('${snapshot.data[index].username}'),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => ProfileView(userId: snapshot.data[index].id)),
                                ).then((_){
                                  clearText();
                                  searchUser("");
                                });
                              },
                              icon: Icon(Icons.chevron_right)
                          ),
                        );
                      }
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      children:[
                        Text(
                            "No following users.",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.TEXT_COLOR
                            )
                        ),
                        Text(
                            "Search and follow new friends.",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.TEXT_COLOR
                            )
                        ),
                      ]
                    ),
                  );
                }
              }
            )
          )
        ],
      )
    );
  }
}
