import 'dart:convert';

import 'package:foody_app/model/post_grid_dto.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/services/userService.dart';
import 'package:foody_app/utils/HTTPUtils.dart';
import 'package:foody_app/utils/sharedPreferenceUtils.dart';
import 'package:http/http.dart';
import 'package:foody_app/resource/app_constants.dart';

class PostService {
  static final String postURL = AppConstants.baseURL + "/post";

  // Get all following posts
  Future<List<PostModel>> fetchPosts() async {
    String url = postURL;
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    Response response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<PostModel> postModels =
          body.map((dynamic e) => PostModel.fromJson(e)).toList();
      // print()
      return postModels;
    } else {
      print(response.statusCode);
      throw Exception("Unable to get posts!! ");
    }
  }

  // Get a post
  Future<PostModel> fetchOnePost(int id) async {
    final String url = postURL + "/$id";
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    Response response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return PostModel.fromJson(body);
    } else {
      throw Exception("Unable to get one post!! ");
    }
  }

  // Create a post
  Future<bool> createPost(PostModel newPost) async {
    String url = postURL;
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    Map<String, dynamic> jsonRequest = newPost.toJson();
    dynamic userId = await UserService().getSelfId();
    jsonRequest['user_id'] = userId["id"];
    // print(jsonEncode(jsonRequest));

    Response response =
        await post(url, headers: headers, body: jsonEncode(jsonRequest));
    print("Create post status : ${response.statusCode}");
    return response.statusCode == 201;
  }

  // Get all post
  static Future<List<PostGridDTO>> getGridPosts(userId) async {
    String requestUrl = "${postURL}/grid/${userId}";
    Map<String, String> headers = await HTTPUtils.getHeaders();
    Response res = await get(requestUrl, headers: headers);
    if(res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<PostGridDTO> gridPosts =
      body.map((dynamic item) => PostGridDTO.fromJson(item)).toList();
      if(gridPosts.isEmpty){
        return null;
      }
      return gridPosts;
    } else {
      throw Exception("Error at FollowingHTTPService getAllFollowingUsers: ${res.body.toString()}");
    }
  }

}
