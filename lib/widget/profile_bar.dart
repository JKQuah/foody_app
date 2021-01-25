import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/chat/chats_page.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/view/chatRoomView.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  void openChatRoom(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return ChatsPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/app_logo.png',
              height: 35,
            ),
          ),
          Text(
            "FoodyApp",
            style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.TEXT_COLOR,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(
              CupertinoIcons.chat_bubble_2,
              size: 30,
            ),
            color: AppColors.PRIMARY_COLOR,
            onPressed: () {
              openChatRoom(context);
            },
          ),
        )
      ],
    );
  }
}
