import 'dart:convert';

import 'package:foody_app/model/locationDTO.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';

class MealHTTPService {
  static final String mealURL = AppConstants.baseURL + "/meal";

  static Future<List<PostModel>> getMealSuggestion(LocationDTO locationDTO) async {
    String locationParams = "";
    String preferencesParams = "";
    if (locationDTO != null) {
      if (locationDTO.longitude != null && locationDTO.latitude != null) {
        locationParams = "latitude=${locationDTO.latitude}&longitude=${locationDTO.longitude}";
      }
    }

    String requestUrl = "${mealURL}/suggest?${preferencesParams}${locationParams}";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    print(requestUrl);
    Response res = await get(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<PostModel> postModels =
      body.map((dynamic item) => PostModel.fromJson(item)).toList();
      return postModels;
    } else {
      throw Exception("Error at MealHTTPServices getMealSuggestion");
    }
  }
}