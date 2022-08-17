import 'package:dio/dio.dart';
// import 'package:user_app/data/services/endpoint.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiServices {
  Dio _dio = Dio();

  ApiServices.internal();

  static final ApiServices _instance = ApiServices.internal();

  factory ApiServices() => _instance;

  Future<ApiServices> init() async {
    _dio = Dio(
      BaseOptions(
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    return this;
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params}) async {
    Response response;

    try {
      if (method == Method.POST) {
        _dio.options.headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        };
        response = await _dio.post(url, data: params);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(url, queryParameters: params);
      }
      return response;
    } catch (e) {
      return e.toString();
    }
  }
}
