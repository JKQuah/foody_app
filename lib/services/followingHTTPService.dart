import 'dart:convert';

import 'package:foody_app/model/user_list_dto.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';
import 'package:basic_utils/basic_utils.dart';

class FollowingHTTPService {
  static final String followingURL = AppConstants.baseURL + "/friends";

  static Future<List<UserListDTO>> getAllFollowingUsers() async {
    String requestUrl = followingURL;
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if(res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<UserListDTO> followingUsers =
        body.map((dynamic item) => UserListDTO.fromJson(item)).toList();
      return followingUsers;
    } else {
      throw Exception("Error at FollowingHTTPService getAllFollowingUsers: ${res.body.toString()}");
    }
  }

  static Future<List<UserListDTO>> getUserLikeUsername(String username) async{
    String endpointUrl = "${followingURL}/search";
    Map<String, String> queryParams = {
      'username': username
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = endpointUrl + "?" + queryString;

    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if(res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<UserListDTO> resultUsers =
        body.map((dynamic item) => UserListDTO.fromJson(item)).toList();
      return resultUsers;
    } else {
      throw Exception("Error at FollowingHTTPService getUserLikeUsername");
    }
  }

}