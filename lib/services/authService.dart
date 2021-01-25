import 'dart:convert';

import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';

class AuthService {
  final String userURL = AppConstants.APP_BASE_URL + "/users";

  Future<Map<String, String>> login(String email, String psw) async {
    String url = userURL + "/login";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    // headers['Content-Type'] = 'application/json; charset=UTF-8';
    Map<String, String> jsonBody = {
      "email": email,
      "password": psw,
    };
    Response response = await post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      if (body['auth'] == true) {
        return {
          "token": body['token'],
        };
      } else {
        return {
          "token": "false",
        };
      }
    } else {
      print(response.statusCode);
      throw Exception("Unable to get users!! ");
    }
  }
}
