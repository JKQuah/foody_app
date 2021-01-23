import 'dart:convert';

import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:http/http.dart';

class PreferenceHTTPService {
  static final String preferenceUrl = AppConstants.baseURL + "/preferences";

  static Future<List<PreferenceModel>> getPreferences() async {
    String requestUrl = preferenceUrl;
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<PreferenceModel> preferenceModel =
          body.map((dynamic item) => PreferenceModel.fromJson(item)).toList();
      return preferenceModel;
    } else {
      throw Exception("Error at PreferenceHTTPService getPreferences");
    }
  }
}
