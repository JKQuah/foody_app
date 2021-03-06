import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/utils/convertUtils.dart';

import 'location_dto.dart';

class MeatModel {
  int id;
  String imageUrl;
  String title;
  String description;
  int maxParticipant;
  DateTime startTime;
  DateTime endTime;
  String meatStatus;
  String userStatus;
  LocationDTO locationDTO;
  int totalParticipants;
  String role;
  List<PreferenceModel> preferences;
  DateTime createdDate;
  DateTime lastModifiedDate;
  double distanceInKm;

  MeatModel({
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.maxParticipant,
    this.startTime,
    this.endTime,
    this.meatStatus,
    this.userStatus,
    this.locationDTO,
    this.totalParticipants,
    this.role,
    this.preferences,
    this.createdDate,
    this.lastModifiedDate,
    this.distanceInKm,
  });

  factory MeatModel.fromJson(Map<String, dynamic> json) {
    return MeatModel(
        id: json['id'] as int,
        imageUrl: json['imageUrl'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        maxParticipant: json['maxParticipant'] as int,
        startTime: ConvertUtils.fromIsoStrToDateTime(
            json['startTime'] as String),
        endTime: ConvertUtils.fromIsoStrToDateTime(json['endTime'] as String),
        meatStatus: json['meatStatus'] as String,
        userStatus: json['userStatus'] as String,
        locationDTO: (json['locationDTO'] == null)
            ? null
            : LocationDTO.fromJson(json['locationDTO']),
        totalParticipants: json['totalParticipants'] as int,
        role: json['role'] as String,
        preferences: (json['preferences'] == null)
            ? null
            : (json['preferences'] as List<dynamic>)
            .map((dynamic item) => PreferenceModel.fromJson(item))
            .toList(),
        createdDate:
        ConvertUtils.fromIsoStrToDateTime(json['createdDate'] as String),
        lastModifiedDate:
        ConvertUtils.fromIsoStrToDateTime(json['lastModifiedDate'] as String),
        distanceInKm: ConvertUtils.fromNumberToDouble(json['distanceInKm'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'maxParticipant': maxParticipant,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'preferenceIds': preferences.map((PreferenceModel p) => p.id).toList(),
      'locationDTO': locationDTO.toJson(),
      'base64String': (imageUrl is String) ? imageUrl : null
    };
  }
}
