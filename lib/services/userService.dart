import 'dart:convert';

import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';

class UserService {
  final String userURL = AppConstants.APP_BASE_URL + "/users";

  Future<dynamic> getSelfId() async {
    String url = userURL + "/me";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return body;
    } else {
      print(response.statusCode);
      throw Exception("Unable to get own users!! ");
    }
  }
}
