import 'package:foody_app/utils/convertUtils.dart';

class PreferenceModel {
  int id;
  String name;
  String description;
  DateTime createdDate;
  DateTime lastModifiedDate;

  PreferenceModel({
    this.id,
    this.name,
    this.description,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    return PreferenceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      createdDate: ConvertUtils.fromIsoStrToDateTime(json['createdDate'] as String),
      lastModifiedDate: ConvertUtils.fromIsoStrToDateTime(json['lastModifiedDate'] as String),
    );
  }
}
