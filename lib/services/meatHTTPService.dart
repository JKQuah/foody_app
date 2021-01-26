import 'dart:convert';

import 'package:foody_app/model/location_dto.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/meat_participant_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/utils/convertUtils.dart';
import 'package:http/http.dart';

class MeatHTTPService {
  static final String meatURL = AppConstants.baseURL + "/meat";

  static Future<int> createMeat(MeatModel meatModel) async {
    String requestUrl = meatURL;
    Map<String, String> headers = await HTTPUtils.getHeaders();
    headers["Content-Type"] = 'application/json; charset=UTF-8';
    Response res = await post(requestUrl,
        headers: headers, body: jsonEncode(meatModel.toJson()));
    print(res.statusCode);
    if (res.statusCode == 201) {
      Map<String, dynamic> json = jsonDecode(res.body);
      return ConvertUtils.fromDynamicToInt(json["meatId"]);
    } else {
      throw Exception("Error at MeatHTTPService createMeat");
    }
  }

  static Future<int> updateMeat(MeatModel meatModel) async {
    String requestUrl = meatURL;
    Map<String, String> headers = await HTTPUtils.getHeaders();
    headers["Content-Type"] = 'application/json; charset=UTF-8';
    Response res = await put(requestUrl,
        headers: headers, body: jsonEncode(meatModel.toJson()));
    print(res.statusCode);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      return ConvertUtils.fromDynamicToInt(json["meatId"]);
    } else {
      throw Exception("Error at MeatHTTPService updateMeat");
    }
  }

  static Future<int> cancelMeat(int meatId) async {
    String requestUrl = "${meatURL}/${meatId}/cancel";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await put(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      return ConvertUtils.fromDynamicToInt(json["meatId"]);
    } else {
      throw Exception("Error at MeatHTTPService cancelMeat");
    }
  }

  static Future<List<MeatModel>> getExploreMeats(
      LocationDTO locationDTO, List<PreferenceModel> preferences) async {
    String locationParams = "";
    String preferencesParams = "";
    if (locationDTO != null) {
      if (locationDTO.longitude != null && locationDTO.latitude != null) {
        locationParams =
            "latitude=${locationDTO.latitude}&longitude=${locationDTO.longitude}";
      }
    }
    if (preferences != null) {
      preferencesParams = preferences.map((e) => "&${e.id}").join();
    }
    String requestUrl = "$meatURL/explore?$preferencesParams$locationParams";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    print(requestUrl);
    Response res = await get(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<MeatModel> meatModels =
          body.map((dynamic item) => MeatModel.fromJson(item)).toList();
      return meatModels;
    } else {
      throw Exception("Error at MeatHTTPService getExploreMeats");
    }
  }

  static Future<List<MeatModel>> getUpcomingMeats() async {
    String requestUrl = "${meatURL}/upcoming";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<MeatModel> meatModels =
          body.map((dynamic item) => MeatModel.fromJson(item)).toList();
      return meatModels;
    } else {
      throw Exception("Error at MeatHTTPService getUpcomingMeats");
    }
  }

  static Future<MeatModel> getOneMeat(int meatId) async {
    String requestUrl = "${meatURL}/${meatId}";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return MeatModel.fromJson(body);
    } else {
      throw Exception("Error at MeatHTTPService getOneMeat");
    }
  }

  static Future<int> joinMeat(int meatId) async {
    String requestUrl = "${meatURL}/${meatId}/join";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await post(requestUrl, headers: headers);
    if (res.statusCode == 201) {
      Map<String, dynamic> json = jsonDecode(res.body);
      return ConvertUtils.fromDynamicToInt(json["meatId"]);
    } else {
      throw Exception("Error at MeatHTTPService joinMeat");
    }
  }

  static Future<int> unjoinMeat(int meatId) async {
    String requestUrl = "${meatURL}/${meatId}/unjoin";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await put(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      return ConvertUtils.fromDynamicToInt(json["meatId"]);
    } else {
      throw Exception("Error at MeatHTTPService unjoinMeat");
    }
  }

  static Future<List<MeatParticipantModel>> readAllMeatParticipants(
      int meatId) async {
    String requestUrl = "${meatURL}/${meatId}/meat-users";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<MeatParticipantModel> meatParticipantModels = body
          .map((dynamic item) => MeatParticipantModel.fromJson(item))
          .toList();
      return meatParticipantModels;
    } else {
      throw Exception("Error at MeatHTTPService readAllMeatParticipants");
    }
  }
}
