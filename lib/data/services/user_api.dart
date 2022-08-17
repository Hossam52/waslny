import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_app/core/handle_error.dart';
import 'package:user_app/data/services/api_helper.dart';
import 'package:user_app/data/services/endpoint.dart';

class UserApi {
  UserApi.internal();

  static final UserApi _instance = UserApi.internal();

  factory UserApi() => _instance;

  ApiServices apiServices = ApiServices();

  registerUser(
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String mobile,
    String gender,
  ) async {
    String url = Endpoints.baseApi + Endpoints.register;
    Response response = await apiServices.request(
      url: url,
      method: Method.POST,
      params: {
        // 'Content-Type': 'application/json',
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "mobile": mobile,
        "type": "rider",
        "gender": gender,
      },
    );
    return response.data;
  }

  userLogin(
    String password,
    String mobile,
  ) async {
    try {
      String url = Endpoints.baseApi + Endpoints.login;

      Dio dio = Dio();

      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      Response response = await dio.post(url,
          queryParameters: {
            "password": password,
            "mobile": mobile,
          }
      );

      if (response.statusCode == 200) {
        debugPrint(
          "${
          response.data
          }"
        );
        return response.data;
      } else if (response.statusCode! < 500) {
        print(' <500');
        return response.data.toString();
      } else {
        print('smothing else');
      }
    } catch(e) {
      final errorMessage = DioExceptions.fromDioError(e as DioError).message;
      print(errorMessage);
      return errorMessage;
    }
  }

  changePassword(
    String oldPass,
    String newPass,
    String confirmPass,
  ) async {
    try {
      String url = Endpoints.baseApi + Endpoints.changePassowrd;
      Response response = await apiServices.request(
        url: url,
        method: Method.POST,
        params: {
          "old_password": oldPass,
          "new_password": newPass,
          "password_confirmation": confirmPass,
        },
      );
      return response.data;
    } catch (error) {
      return error.toString();
    }
  }
}
