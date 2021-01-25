import 'package:foody_app/utils/convertUtils.dart';

class Like {
  int id;
  int postId;
  int userId;
  String postReaction;
  DateTime createdDate;
  DateTime lastModifiedDate;

  Like({
    this.id,
    this.postId,
    this.userId,
    this.postReaction,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'] as int,
      postId: json['post_id'] as int,
      userId: json['user_id'] as int,
      postReaction: json['post_reaction'] as String,
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
      "post_reaction": postReaction,
    };
  }
}
