import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/utils/dateUtils.dart';

import 'location_dto.dart';

class MeatModel {
  int id;
  String imageUrl;
  String title;
  String description;
  int maxParticipant;
  DateTime startTime;
  DateTime endTime;
  String status;
  LocationDTO locationDTO;
  int totalParticipants;
  String role;
  List<PreferenceModel> preferences;
  DateTime createdDate;
  DateTime lastModifiedDate;

  MeatModel({
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.maxParticipant,
    this.startTime,
    this.endTime,
    this.status,
    this.locationDTO,
    this.totalParticipants,
    this.role,
    this.preferences,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory MeatModel.fromJson(Map<String, dynamic> json) {
    return MeatModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      maxParticipant: json['maxParticipant'] as int,
      startTime: DateUtils.fromIsoStrToDateTime(json['startTime'] as String),
      endTime: DateUtils.fromIsoStrToDateTime(json['endTime'] as String),
      status: json['status'] as String,
      locationDTO: LocationDTO.fromJson(json['locationDTO']),
      totalParticipants: json['totalParticipants'] as int,
      role: json['role'] as String,
      preferences: (json['preferences'] as List<dynamic>)
        .map((dynamic item) => PreferenceModel.fromJson(item))
        .toList(),
      createdDate: DateUtils.fromIsoStrToDateTime(json['createdDate'] as String),
      lastModifiedDate: DateUtils.fromIsoStrToDateTime(json['lastModifiedDate'] as String),
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
      // location DTO
      // image
    };
  }


}
