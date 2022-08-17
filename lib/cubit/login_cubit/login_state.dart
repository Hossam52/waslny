part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class UserLoginSuccesfullState extends LoginState {
  final LoginModel userLogin;

  const UserLoginSuccesfullState({
    required this.userLogin,
  });
}

class UserLoginFailedState extends LoginState {}

class UserLoginlodingState extends LoginState {}

class UserLoginSuccessState extends LoginState {}

class ObsState1 extends LoginState {}

class ObsState2 extends LoginState {}

class ObsState3 extends LoginState {}

class ErrorLoginState extends LoginState {
  String? error;

  ErrorLoginState({required this.error});
}

class SuccessLoginState extends LoginState {}

class UserProfilelodingState extends LoginState {}

class SuccessUserProfileState extends LoginState {
  ProfileData? profileData;

  SuccessUserProfileState({required this.profileData});
}

class ErrorUserProfileState extends LoginState {
  String? error;

  ErrorUserProfileState({required this.error});
}

class EditNamelodingState extends LoginState {}

class SuccessEditNameState extends LoginState {}

class ErrorEditNameState extends LoginState {
  String? error;

  ErrorEditNameState({required this.error});
}

class EditPasslodingState extends LoginState {}

class SuccessEditPassState extends LoginState {}

class ErrorEditPassState extends LoginState {
  String? error;

  ErrorEditPassState({required this.error});
}

class ChangeImageUpdateState extends LoginState {}

class UploadImagelodingState extends LoginState {}

class SuccessUploadImageState extends LoginState {}

class ErrorUploadImageState extends LoginState {
  String? error;

  ErrorUploadImageState({required this.error});
}

class GetAllDriverlodingState extends LoginState {}

class SuccessGetAllDriverState extends LoginState {}

class ErrorGetAllDriverState extends LoginState {
  String? error;

  ErrorGetAllDriverState({required this.error});
}
