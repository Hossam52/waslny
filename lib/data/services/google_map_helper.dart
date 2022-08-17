import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/core/dioHelper.dart';
import 'package:user_app/data/models/address_model.dart';
import 'package:user_app/data/models/place_details_model.dart';
import 'package:user_app/data/services/endpoint.dart';
import 'package:user_app/utils/const_manager.dart';

import '../models/direction_details_model.dart';
import 'api_helper.dart';

class GoogleMapMethod {
  GoogleMapMethod.internal();

  static final GoogleMapMethod _instance = GoogleMapMethod.internal();

  factory GoogleMapMethod() => _instance;

  final ApiServices _apiServices = ApiServices();

  Future<Results> getFormattedAddress(Position position) async {
    String url = Endpoints.baseUrl +
        Endpoints.geocode +
        'latlng=${position.latitude},${position.longitude}';

    Response response = await _apiServices.request(
      method: Method.GET,
      url: url,
      params: {"key": googleMapApiKey},
    );
    return Results.fromJson(response.data['results'][1]);
  }

  Future searchPlace(String placeName) async {
    // String url =
    //     Endpoints.baseUrl + Endpoints.placeAutoComplete + "input=$placeName";
    //
    // Response response = await _apiServices.request(
    //   method: Method.GET,
    //   url: url,
    //   params: {
    //     "key": googleMapApiKey,
    //     "types": 'geocode',
    //     "language": 'en',
    //     "components": 'country:eg',
    //   },
    // );
    // return response.data['predictions'];

    String url = Endpoints.baseUrl +
        Endpoints.placeAutoComplete +
        "input=$placeName&key=$googleMapApiKey&sessiontoken=1234567890&component=country:eg";
    Response response = await DioHelper.getData(url: url);
    if (response == "failed") {
      return debugPrint("error");
    }
    debugPrint("$response");
    return response;
  }

  //todo need to redo it both of them

  Future<PlaceDetails> getPlaceDetails(String placeId) async {
    String url =
        Endpoints.baseUrl + Endpoints.placeDetails + 'place_id=$placeId';
    Response response = await _apiServices.request(
      url: url,
      params: {"key": googleMapApiKey},
      method: Method.GET,
    );

    return PlaceDetails.fromJson(response.data['result']);
  }

  Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$googleMapApiKey';

    Response response =
        await _apiServices.request(url: url, method: Method.GET);
    return DirectionDetails.fromMap(response.data['routes'][0]);
  }
}
