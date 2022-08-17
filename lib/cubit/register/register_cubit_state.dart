part of 'register_cubit_cubit.dart';

@immutable
abstract class RegisterCubitState {}

class RegisterCubitInitial extends RegisterCubitState {}

class RegisterSuccesfullState extends RegisterCubitState {
  final RegistrationModel registerModel;

  RegisterSuccesfullState({
    required this.registerModel,
  });
}

class RegisterFailedState extends RegisterCubitState {}

class SuccessRegisterState extends RegisterCubitState {}

class ErrorRegisterState extends RegisterCubitState {
  String? error;

  ErrorRegisterState({required this.error});
}

class RegisterlodingState extends RegisterCubitState {}

class ChangeMaleGenderState extends RegisterCubitState {}

class ChangeFemaleGenderState extends RegisterCubitState {}
