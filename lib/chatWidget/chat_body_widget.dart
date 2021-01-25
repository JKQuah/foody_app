import 'package:foody_app/chatModel/user.dart';
import 'package:foody_app/chat//chat_page.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: buildChats(),
    ),
  );

  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      final user = users[index];

      return Container(
        height: 75,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(user: user),
            ));
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.urlAvatar ??"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngitem.com%2Fmiddle%2FJwbRJx_no-network-wifi-no-signal-icon-hd-png%2F&psig=AOvVaw2YvrBosjRzHewmlFZ13NYK&ust=1611669558837000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKi53o6ft-4CFQAAAAAdAAAAABAD" ),
          ),
          title: Text(user.name),
        ),
      );
    },
    itemCount: users.length,
  );
}
