import 'dart:convert';

import 'package:foody_app/model/comment.dart';
import 'package:foody_app/utils/sharedPreferenceUtils.dart';
import 'package:http/http.dart';
import 'package:foody_app/resource/app_constants.dart';

class CommentService {
  final String commentURL = AppConstants.APP_BASE_URL + "/comment";

  // Get comments
  Future<List<Comment>> fetchComments(int postId) async {
    String url = commentURL + "/$postId";
    // print(url);
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    Response response = await get(url, headers: headers);
    // print(response);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Comment> commentModels =
          body.map((dynamic e) => Comment.fromJson(e)).toList();
      // print(commentModels);
      return commentModels;
    } else {
      print(response.statusCode);
      throw Exception("Unable to get comments!! ");
    }
  }

  // Create a comment
  Future<int> createComment(Comment comment) async {
    String url = commentURL;
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    Map<String, dynamic> jsonRequest = comment.toJson();

    Response response =
        await post(url, headers: headers, body: jsonEncode(jsonRequest));
    int commentId = jsonDecode(response.body)['commentId'];
    if (response.statusCode == 201) {
      return commentId;
    } else {
      print(response.statusCode);
      throw Exception("Unable to create comment!!");
    }
  }

  // Update a comment

  // Delete a comment
  Future<bool> deleteComment(int commandId) async {
    String url = commentURL + "/$commandId";
    Map<String, String> headers = await SharedPreferenceUtils.getHeaders();
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    Response response = await delete(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception("Unable to delete comment!!");
    }
  }
}
