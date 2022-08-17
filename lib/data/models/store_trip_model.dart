import 'dart:convert';

class TripModel {
  final int userId;
  final String pickupLon;
  final String pickupLat;
  final String dropLon;
  final String dropLat;
  final String duration;
  final String distance;
  final String updatedAt;
  final String createdAt;
  final int id;
  final List<NearestDrivers> nearestdrivers;
  final List<bool> accepts;

  TripModel({
    required this.userId,
    required this.pickupLon,
    required this.pickupLat,
    required this.dropLon,
    required this.dropLat,
    required this.duration,
    required this.distance,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.nearestdrivers,
    required this.accepts,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'pickupLon': pickupLon,
      'pickupLat': pickupLat,
      'dropLon': dropLon,
      'dropLat': dropLat,
      'duration': duration,
      'distance': distance,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'id': id,
      'nearestdrivers': nearestdrivers.map((x) => x.toMap()).toList(),
      'accepts': accepts,
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      userId: map['userId']?.toInt() ?? 0,
      pickupLon: map['pickupLon'] ?? '',
      pickupLat: map['pickupLat'] ?? '',
      dropLon: map['dropLon'] ?? '',
      dropLat: map['dropLat'] ?? '',
      duration: map['duration'] ?? '',
      distance: map['distance'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      createdAt: map['createdAt'] ?? '',
      id: map['id']?.toInt() ?? 0,
      nearestdrivers: List<NearestDrivers>.from(
          (map['nearestdrivers']?.map((x) => NearestDrivers.fromMap(x))) ?? []),
      accepts: List<bool>.from(map['accepts'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory TripModel.fromJson(String source) =>
      TripModel.fromMap(json.decode(source));
}

class NearestDrivers {
  final String driverName;
  NearestDrivers({
    required this.driverName,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverName': driverName,
    };
  }

  factory NearestDrivers.fromMap(Map<String, dynamic> map) {
    return NearestDrivers(
      driverName: map['driverName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NearestDrivers.fromJson(String source) =>
      NearestDrivers.fromMap(json.decode(source));
}
