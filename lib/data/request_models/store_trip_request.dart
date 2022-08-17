import 'dart:convert';

class StoreTripRequest {
  final double pickup_lat;
  final double pickup_lon;
  final double drop_lat;
  final double drop_lon;
  final double duration;
  final double distance;
  StoreTripRequest({
    required this.pickup_lat,
    required this.pickup_lon,
    required this.drop_lat,
    required this.drop_lon,
    required this.duration,
    required this.distance,
  });

  Map<String, dynamic> toMap() {
    return {
      'pickup_lat': pickup_lat,
      'pickup_lon': pickup_lon,
      'drop_lat': drop_lat,
      'drop_lon': drop_lon,
      'duration': duration,
      'distance': distance,
    };
  }

  factory StoreTripRequest.fromMap(Map<String, dynamic> map) {
    return StoreTripRequest(
      pickup_lat: map['pickup_lat']?.toDouble() ?? 0.0,
      pickup_lon: map['pickup_lon']?.toDouble() ?? 0.0,
      drop_lat: map['drop_lat']?.toDouble() ?? 0.0,
      drop_lon: map['drop_lon']?.toDouble() ?? 0.0,
      duration: map['duration'] ?? '',
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreTripRequest.fromJson(String source) =>
      StoreTripRequest.fromMap(json.decode(source));
}
