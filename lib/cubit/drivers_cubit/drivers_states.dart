//
abstract class DriversStates {}

class IntitalDriversState extends DriversStates {}

//
//GetDrivers online fetch data
class GetDriversLoadingState extends DriversStates {}

class GetDriversSuccessState extends DriversStates {}

class GetDriversErrorState extends DriversStates {
  final String error;
  GetDriversErrorState({required this.error});
}
