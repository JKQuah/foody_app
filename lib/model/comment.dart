import 'package:foody_app/utils/convertUtils.dart';

class Comment {
  int id;
  int postId;
  int userId;
  String username;
  String comment;
  DateTime createdDate;
  DateTime lastModifiedDate;

  Comment({
    this.id,
    this.postId,
    this.userId,
    this.username,
    this.comment,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      postId: json['post_id'] as int,
      userId: json['user_id'] as int,
      username: json['username'] as String,
      comment: json['comment'] as String,
      createdDate: ConvertUtils.convertStringToDateTime(json['created_date']),
      lastModifiedDate:
          ConvertUtils.convertStringToDateTime(json['last_modified_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "post_id": postId,
      "user_id": userId,
      "comment": comment,
    };
  }
}
