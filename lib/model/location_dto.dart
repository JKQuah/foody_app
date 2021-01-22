class LocationDTO {
  double latitude;
  double longitude;

  LocationDTO({
    this.latitude,
    this.longitude,
  });

  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}


