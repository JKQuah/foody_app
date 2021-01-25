import 'package:foody_app/utils/convertUtils.dart';

class LocationDTO {
  double latitude;
  double longitude;
  String locationName;
  String locationAddress;
  LocationDTO(
      {this.latitude, this.longitude, this.locationName, this.locationAddress});

  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(
      latitude: ConvertUtils.convertNumberToDouble(json['latitude']),
      longitude: ConvertUtils.convertNumberToDouble(json['longitude']),
      locationName: json['location_name'] as String,
      locationAddress: json['location_address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'locationAddress': locationAddress,
    };
  }
}
