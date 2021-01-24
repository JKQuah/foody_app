import 'package:foody_app/utils/convertUtils.dart';

class MeatParticipantModel {
  int userId;
  String role;
  String status;
  String username;
  String imageUrl;

  MeatParticipantModel({
    this.userId,
    this.role,
    this.status,
    this.username,
    this.imageUrl,
  });

  factory MeatParticipantModel.fromJson(Map<String, dynamic> json) {
    return MeatParticipantModel(
      userId: ConvertUtils.fromDynamicToInt(json['userId']),
      role: json['role'] as String,
      status: json['status'] as String,
      username: json['username'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'status': status,
      'username': username,
      'imageUrl': imageUrl,
    };
  }
}
