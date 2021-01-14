import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/view/addPostView.dart';
import 'package:foody_app/view/chatRoomView.dart';

class FoodyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodyAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  void openChatRoom(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return ChatRoomView();
      },
    ));
  }

  void openPhoneGallery(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return AddPostView();
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
            AppConstants.APP_NAME,
            style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.TEXT_COLOR,
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.plus_app,
          size: 30,
        ),
        color: AppColors.ACCENT_COLOR,
        onPressed: () {
          openPhoneGallery(context);
        },
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
