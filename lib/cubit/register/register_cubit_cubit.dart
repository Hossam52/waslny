import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:user_app/data/models/register_model.dart';
import 'package:user_app/data/services/user_api.dart';

import '../../core/dioHelper.dart';
import '../../data/models/login_model.dart';
import '../../data/services/endpoint.dart';
import '../../data/services/localDataLayer.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());

  static RegisterCubitCubit get(context) => BlocProvider.of(context);

  final UserApi _userApi = UserApi();

  bool isMale = false;
  bool isFemale = false;

  changeMaleGender() {
    isMale = true;
    isFemale = false;
    emit(ChangeMaleGenderState());
  }

  changeFemaleGender() {
    isMale = false;
    isFemale = true;
    emit(ChangeFemaleGenderState());
  }
  LoginModel? registerModel;
  void registerUser(String name, String email, String password,
      String passwordConfirmation, String mobile, String gender) async {
    emit(RegisterlodingState());
    var response = await DioHelper.postData(url: Endpoints.register, data: {
      "name":"$name",
      "email":"$email",
      "mobile": "$mobile",
      "password": "$password",
      "password_confirmation":"$passwordConfirmation",
      "type":"rider",
      "gender":"$gender"
    });
    if (response.statusCode == 201) {
      registerModel = LoginModel.fromJson(response.data);
      emit(SuccessRegisterState());
    } else {
      emit(ErrorRegisterState(
        error: response.data["message"]
      ));
    }
      }
}
