class PlaceDetails {
  // String name;
  late final double lat;
  late final double lng;
  PlaceDetails({
    // required this.name,
    required this.lat,
    required this.lng,
  });

  PlaceDetails.fromJson(Map<String, dynamic> json) {
    lat = json['geometry']['location']['lat'];
    lng = json['geometry']['location']['lng'];
  }
}
