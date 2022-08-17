import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionDetails {
  final DirectionBounds bounds;
  final String distanceText;
  final String durationText;
  final int distanceValue;
  final int durationValue;
  final String edcodedPPoint;

  DirectionDetails({
    required this.bounds,
    required this.distanceText,
    required this.durationText,
    required this.distanceValue,
    required this.durationValue,
    required this.edcodedPPoint,
  });

  // DirectionDetails.fromJson(Map<String, dynamic> json) {
  //   distanceText = json['legs'][0]['distance']['text'];
  //   durationText = json['legs'][0]['duration']['text'];
  //   distanceValue = json['legs'][0]['distance']['value'];
  //   durationValue = json['legs'][0]['duration']['value'];
  //   edcodedPPoint = json['overview_polyline']['points'];
  // }

  Map<String, dynamic> toMap() {
    return {
      'bounds': bounds.toMap(),
      'distanceText': distanceText,
      'durationText': durationText,
      'distanceValue': distanceValue,
      'durationValue': durationValue,
      'edcodedPPoint': edcodedPPoint,
    };
  }

  factory DirectionDetails.fromMap(Map<String, dynamic> map) {
    return DirectionDetails(
      bounds: DirectionBounds.fromMap(map['bounds']),
      distanceText: map['legs'][0]['distance']['text'] ?? '',
      durationText: map['legs'][0]['duration']['text'] ?? '',
      distanceValue: map['legs'][0]['distance']['value']?.toInt() ?? 0,
      durationValue: map['legs'][0]['duration']['value']?.toInt() ?? 0,
      edcodedPPoint: map['overview_polyline']['points'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectionDetails.fromJson(String source) =>
      DirectionDetails.fromMap(json.decode(source));
}

class DirectionBounds {
  final DirectionLatLng northeast;
  final DirectionLatLng southwest;
  DirectionBounds({
    required this.northeast,
    required this.southwest,
  });

  Map<String, dynamic> toMap() {
    return {
      'northeast': northeast.toMap(),
      'southwest': southwest.toMap(),
    };
  }

  factory DirectionBounds.fromMap(Map<String, dynamic> map) {
    return DirectionBounds(
      northeast: DirectionLatLng.fromMap(map['northeast']),
      southwest: DirectionLatLng.fromMap(map['southwest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectionBounds.fromJson(String source) =>
      DirectionBounds.fromMap(json.decode(source));
}

class DirectionLatLng {
  double lat;
  double lng;
  DirectionLatLng({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory DirectionLatLng.fromMap(Map<String, dynamic> map) {
    return DirectionLatLng(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectionLatLng.fromJson(String source) =>
      DirectionLatLng.fromMap(json.decode(source));
  LatLng toLatLng() {
    return LatLng(lat, lng);
  }
}
