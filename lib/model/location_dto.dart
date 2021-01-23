import 'package:foody_app/utils/convertUtils.dart';

class LocationDTO {
  double latitude;
  double longitude;

  LocationDTO({
    this.latitude,
    this.longitude,
  });

  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(
      latitude: ConvertUtils.fromNumberToDouble(json['latitude']),
      longitude: ConvertUtils.fromNumberToDouble(json['longitude']),
    );
  }
}


