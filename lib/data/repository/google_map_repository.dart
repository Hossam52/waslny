import 'package:geolocator/geolocator.dart';
import 'package:user_app/data/models/address_model.dart';
import 'package:user_app/data/models/prediction_model.dart';
import 'package:user_app/data/services/google_map_helper.dart';

class GoogleMapMethodRepository {
  GoogleMapMethodRepository.internal();

  static final GoogleMapMethodRepository _instance =
      GoogleMapMethodRepository.internal();

  factory GoogleMapMethodRepository() => _instance;

  final GoogleMapMethod _googleMapMethod = GoogleMapMethod();
  Prediction? prediction;
  List<Prediction>? predictionList;
  Future searchPlace(String placeName) async {
    var response = await _googleMapMethod.searchPlace(placeName);
    prediction=Prediction.fromJson(response);
    predictionList?.add(prediction!);
    return predictionList;
  }
}
