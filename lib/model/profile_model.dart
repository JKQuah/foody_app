

import 'package:foody_app/model/preference_model.dart';

import 'location_dto.dart';

class ProfileModel {
  String biography;
  String imageUrl;
  LocationDTO locationDTO;
  List<PreferenceModel> preferences;

  ProfileModel({this.biography, this.imageUrl, this.locationDTO, this.preferences});

  Map<String, dynamic> toJson() {
    return {
      'biography': biography,
      'locationDTO': locationDTO.toJson(),
      'preferenceIds': preferences.map((PreferenceModel p) => p.id).toList(),
      'base64String': (imageUrl is String) ? imageUrl : null,
    };
  }
}
