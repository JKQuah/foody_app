import 'dart:convert';
import 'package:foody_app/model/profile_dto.dart';
import 'package:foody_app/model/profile_model.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';

class ProfileHTTPService {
  static final String profileURL = AppConstants.baseURL + '/friends';

  static Future<ProfileDTO> getUserProfile(userId) async {
    String requestUrl = "${profileURL}/${userId}";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if(res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      dynamic item = ProfileDTO.fromJson(body);
      return item;
    } else {
      throw Exception("Error at ProfileHTTPService getUserProfile: ${res.body.toString()}");
    }
  }
}