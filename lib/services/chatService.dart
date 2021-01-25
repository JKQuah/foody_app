import 'dart:convert';

import 'package:foody_app/chatModel/user.dart';
import 'package:foody_app/model/user_list_dto.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';
import 'package:foody_app/model/user_model.dart';

class ChatService {
  static final String chatURL = AppConstants.APP_BASE_URL + "/chat";

  static Future<List<User>> getChats() async {
    String url = chatURL;
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response response = await get(url, headers: headers);

    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> users =
          body.map((dynamic item) => User.fromMysql(item)).toList();
      return users;
    } else {
      print(response.statusCode);
      throw Exception("Unable to getChats!! ");
    }
  }
}
