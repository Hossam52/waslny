part of 'google_map_cubit.dart';

abstract class GoogleMapState {
  const GoogleMapState();
}

class GoogleMapInitial extends GoogleMapState {}

class UserCurrentLocationState extends GoogleMapState {}

class GetNameOfPosition extends GoogleMapState {}

class FormattedAddressLoading extends GoogleMapState {}

class FormattedAddressLoaded extends GoogleMapState {
  Results results;
  FormattedAddressLoaded({
    required this.results,
  });
}

class DestinationPredictionLoading extends GoogleMapState {}

class DestinationPredictionLoaded extends GoogleMapState {
  List<Prediction> prediction;
  DestinationPredictionLoaded({
    required this.prediction,
  });
}

class DestinationControllerUpdated extends GoogleMapState {}

class DefualtDestinationController extends GoogleMapState {}

class PlaceDetailsLoaded extends GoogleMapState {
  PlaceDetails placeDetails;
  PlaceDetailsLoaded({
    required this.placeDetails,
  });
}

class DirectionDetailsLoaded extends GoogleMapState {
  DirectionDetails directionDetails;
  DirectionDetailsLoaded({
    required this.directionDetails,
  });
}

class DirectionDetailsLoading extends GoogleMapState {}

class LoadingSearchState extends GoogleMapState {}

class ErrorOnSearchSTate extends GoogleMapState {}

class SuccessPredictionData extends GoogleMapState {
  Prediction prediction;
  SuccessPredictionData({required this.prediction});
}

class LoadingGetState extends GoogleMapState {}

class ErrorOnGetdataPlace extends GoogleMapState {}

class SuccessGetPlaceData extends GoogleMapState {
  DetactiedLocationResultModel detactiedLocationResultModel;
  SuccessGetPlaceData({required this.detactiedLocationResultModel});
}

class ChangeSelectedLocation extends GoogleMapState {}

class ChangeSelectedPickupLocation extends GoogleMapState {}

class ChangeSelectedDestinationLocation extends GoogleMapState {}
