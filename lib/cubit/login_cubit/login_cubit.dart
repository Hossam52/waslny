import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/core/dioHelper.dart';
import 'package:user_app/data/models/user_login.dart';
import 'package:user_app/data/services/user_api.dart';

import '../../data/models/login_model.dart';
import '../../data/models/profile_data_model.dart';
import '../../data/services/endpoint.dart';
import '../../data/services/localDataLayer.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);
  late LoginModel loginModel;
  String? loginToken;

  bool obs1 = true;
  bool obs2 = true;
  bool obs3 = true;

  Future<void> changeObs1() async {
    obs1 = !obs1;
    emit(ObsState1());
  }

  changeObs2() {
    obs2 = !obs2;
    emit(ObsState2());
  }

  changeObs3() {
    obs3 = !obs3;
    emit(ObsState3());
  }

  loginUser(String password, String mobile) async {
    emit(UserLoginlodingState());
    var response = await DioHelper.postData(
        url: Endpoints.login,
        data: {"mobile": "$mobile", "password": "$password"});
    if (response.statusCode == 200) {
      loginModel = LoginModel.fromJson(response.data);
      Shared.prefSetString(key: "token", value: loginModel.data?.token);
      loginToken = loginModel.data?.token;
      debugPrint(loginToken);
      profieUser();
      emit(SuccessLoginState());
    } else {
      emit(ErrorLoginState(error: response.data["message"]));
    }
  }

  ProfileDataModel? profileDataModel;
  String? name;

  profieUser() async {
    emit(UserProfilelodingState());
    var response = await DioHelper.getDataWithAuth(
        url: Endpoints.profile,
        token: loginToken ?? Shared.prefGetString(key: "token").toString());
    debugPrint("${response.statusCode}");
    if (response.statusCode == 200) {
      profileDataModel = ProfileDataModel.fromJson(response.data);
      debugPrint("sss${profileDataModel?.toJson()}");
      name = profileDataModel?.data?.name;
      emit(SuccessUserProfileState(profileData: profileDataModel?.data));
    } else {
      emit(ErrorUserProfileState(error: "Error On get Profile Data"));
    }
  }

  ///Edit User Name
  TextEditingController textNameEdittingController = TextEditingController();
  ProfileDataModel? editUserProfileName;

  editUser({name}) async {
    emit(EditNamelodingState());
    var response = await DioHelper.postDataWithAuth(
        data: {"name": name},
        url: Endpoints.changeName,
        token: loginToken ?? Shared.prefGetString(key: "token").toString());
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      editUserProfileName = ProfileDataModel.fromJson(response.data);
      debugPrint("888${editUserProfileName?.data?.name}");
      profieUser();
      emit(SuccessEditNameState());
    } else {
      emit(ErrorEditNameState(error: "Error On get Profile Data"));
    }
  }

  ///edit password
  TextEditingController textPasswordEdittingController =
      TextEditingController();
  TextEditingController textNewPasswordEdittingController =
      TextEditingController();
  TextEditingController textConfirmedPasswordEdittingController =
      TextEditingController();
  ProfileDataModel? editPasswordProfile;

  editPassword({
    currentPassword,
    newPassword,
    confirmPassword,
  }) async {
    emit(EditPasslodingState());
    var response = await DioHelper.postDataWithAuth(
        data: {
          "old_password": currentPassword,
          "new_password": newPassword,
          "password_confirmation": confirmPassword,
        },
        url: Endpoints.changePassowrd,
        token: loginToken ?? Shared.prefGetString(key: "token").toString());
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      editPasswordProfile = ProfileDataModel.fromJson(response.data);
      debugPrint("888${editPasswordProfile?.data?.name}");
      profieUser();
      emit(SuccessEditPassState());
    } else {
      emit(ErrorEditPassState(error: "${response.data["message"]}"));
    }
  }

  File? imageData;

  changeImageData({imageFile}) {
    imageData = imageFile;
    emit(ChangeImageUpdateState());
    profieUser();
  }

  UploadImage() async {
    emit(UploadImagelodingState());
    var response = await DioHelper.postDataWithAuth(
        data: {"photo": await DioHelper.uploadFile(imageData!)},
        url: Endpoints.changeAvatar,
        token: loginToken ?? Shared.prefGetString(key: "token").toString());
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      profieUser();
      emit(SuccessUploadImageState());
    } else {
      emit(ErrorUploadImageState(error: "${response.data["message"]}"));
    }
  }
}
