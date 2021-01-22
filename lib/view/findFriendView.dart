import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    users = FollowingHTTPService.getAllFollowingUsers();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      body: new Column(
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
              )
            )
          ),
          Expanded(
            child: FutureBuilder<List<UserListDTO>>(
              future: users,
              builder: (context, snapshot) {
                print(snapshot);
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
                                          image: new NetworkImage('${snapshot.data[index].imageUrl}')
                                      )
                                  )
                              )
                          ),
                          title: Text('${snapshot.data[index].username}'),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfileView()),
                                );
                              },
                              icon: Icon(Icons.chevron_right)
                          ),
                        );
                      }
                  );
                } else {
                  return Container();
                }
              }

            )








          )
        ],
      )
    );
  }
}
