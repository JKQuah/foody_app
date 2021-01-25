import 'dart:convert';

import 'package:foody_app/model/like_model.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/services/userService.dart';
import 'package:foody_app/utils/sharedPreferenceUtils.dart';
import 'package:http/http.dart';
import 'package:foody_app/resource/app_constants.dart';

class PostService {
  final String postURL = AppConstants.APP_BASE_URL + "/post";
  final String likeURL = AppConstants.APP_BASE_URL + "/like";

  // Get all following posts
  Future<List<PostModel>> fetchPosts() async {
    String url = postURL;
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    Response response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<PostModel> postModels =
          body.map((dynamic e) => PostModel.fromJson(e)).toList();
      // print(postModels);
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

  // Update a post

  // Delete a post

  // Read a like from a post
  Future<bool> readLike(Like like) async {
    String url = likeURL + "/${like.postId}/${like.userId}";
    // print(url);
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    Response response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      dynamic isLike = response.body;
      return isLike == "success";
    } else {
      print(response.statusCode);
      throw Exception("Unable to get like!! ");
    }
  }

  Future<bool> createLike(Like like) async {
    String url = likeURL;
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    Map<String, dynamic> jsonRequest = like.toJson();

    Response response =
        await post(url, headers: headers, body: jsonEncode(jsonRequest));
    // print(jsonDecode(response.body));
    print("Create like status : ${response.statusCode}");
    return response.statusCode == 201;
  }
}
