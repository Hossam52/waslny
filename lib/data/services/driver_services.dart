import 'package:user_app/core/dioHelper.dart';
import 'package:user_app/data/request_models/store_trip_request.dart';
import 'package:user_app/data/services/endpoint.dart';
import 'package:user_app/data/services/localDataLayer.dart';

class DriverServices {
  DriverServices._();
  static DriverServices get instance => DriverServices._();
  String? get _getToken => Shared.prefGetString(key: "token").toString();
  Future<Map<String, dynamic>> getAllDrivers(
      StoreTripRequest tripRequest) async {
    final response = await DioHelper.postData(
      url: Endpoints.bookingStore,
      token: _getToken,
      data: tripRequest.toMap(),
    );
    return response.data;
  }
}
