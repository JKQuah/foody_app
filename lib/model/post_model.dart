import 'package:foody_app/utils/convertUtils.dart';

class PostModel {
  int id;
  int userId;
  String username;
  String postImages;
  String location;
  String caption;
  double services;
  double cleanliness;
  double taste;
  double price;

  PostModel({
    this.id,
    this.userId,
    this.username,
    this.postImages,
    this.location,
    this.caption,
    this.services,
    this.cleanliness,
    this.taste,
    this.price,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      username: json['username'] as String,
      postImages: json['media_link'] as String,
      caption: json['description'] as String,
      services: ConvertUtils.convertInttoDouble(json['services']),
      cleanliness: ConvertUtils.convertInttoDouble(json['cleanliness']),
      taste: ConvertUtils.convertInttoDouble(json['taste']),
      price: ConvertUtils.convertInttoDouble(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "images": ConvertUtils.convertStringToBase64String(postImages),
      "description": caption,
      "services": services,
      "cleanliness": cleanliness,
      "taste": taste,
      "price": price
    };
  }
}