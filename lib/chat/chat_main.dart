import 'package:foody_app/api/firebase_api.dart';
import 'package:foody_app/chat/chats_page.dart';
import 'package:foody_app/chatWidget/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi.addRandomUsers(Users.initUsers);

  runApp(FoodyChat());
}

class FoodyChat extends StatelessWidget {
  static final String title = 'Foody Chat';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: ChatsPage(),
  );
}
