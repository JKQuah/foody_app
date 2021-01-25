import 'package:foody_app/api/firebase_api.dart';
import 'package:foody_app/chatModel/user.dart';
import 'package:foody_app/chatWidget/chat_body_widget.dart';
import 'package:foody_app/chatWidget/chat_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/model/user_list_dto.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/services/chatService.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  Future<List<User>> userListDTOs = ChatService.getChats();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: Container(
          child: FutureBuilder<List<User>>(
            future: userListDTOs,
            builder: (context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                List<User> users = snapshot.data;
                return ((users.isEmpty)
                    ? buildText('No Users Found')
                    : Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users)
                        ],
                      ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
