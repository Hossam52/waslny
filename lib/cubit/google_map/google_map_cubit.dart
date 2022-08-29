import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/cubit/drivers_cubit/drivers_cubit.dart';
import 'package:user_app/data/models/address_model.dart';
import 'package:user_app/data/models/direction_details_model.dart';
import 'package:user_app/data/models/place_details_model.dart';
import 'package:user_app/data/models/prediction_model.dart';
import 'package:user_app/data/repository/google_map_repository.dart';
import 'package:user_app/data/services/google_map_helper.dart';
import 'package:user_app/utils/color_manager.dart';

import '../../core/dioHelper.dart';
import '../../data/models/detactedLocationModel.dart';
import '../../data/models/detactedLocationModel.dart' as modelLocation;
import '../../data/services/endpoint.dart';
import '../../utils/const_manager.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());

  static GoogleMapCubit get(context) => BlocProvider.of(context);

  final GoogleMapMethodRepository googleMapMethodRepository =
      GoogleMapMethodRepository();
  final GoogleMapMethod _googleMapMethod = GoogleMapMethod();

  // late Position currentLocation;

  late GoogleMapController controller;
  Set<Marker> markers = {}; //For the markers in source and distnation

  currentUserLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // currentLocation = position;

    // getFormattedAddress(currentLocation);
    await getFormattedAddress(position);
    await getNameOfPosition(position);

    await searchPlaceCubit(pickUpController.text);
    selectedPrediction = predictions?.predictions?[0];
    if (selectedPrediction != null) {
      await getDataOfPlace(selectedPrediction!.placeId!);
      setPickupLocation();
      changeLastFocused(false);
    }
  }

  currentUserFormattedAddressLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    // todo try to remove it later and test it
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // currentLocation = position;

    LatLng latPsoition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latPsoition, zoom: 14);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // getFormattedAddress(currentLocation);
    getFormattedAddress(position);

    emit((UserCurrentLocationState()));
  }

  //find name of postion
  String? countryName;
  List<Placemark>? placeMark;

  Future getNameOfPosition(Position position) async {
    placeMark = await placemarkFromCoordinates(
        // currentLocation.latitude, currentLocation.longitude);
        position.latitude,
        position.longitude);
    countryName = placeMark![0].country;
    emit(GetNameOfPosition());
  }

  Future getFormattedAddress(Position position) async {
    // emit(FormattedAddressLoading());
    Results results = await _googleMapMethod.getFormattedAddress(position);
    pickUpController.text = results.formattedAddress;
    // emit(FormattedAddressLoaded(results: results));
  }

  var destinationController = TextEditingController();
  var pickUpController = TextEditingController();
  List<Prediction> destinationSearchedList = [];

  //get position of place
  // List<Location>? locations;

  searchPlace(String placeName) async {
    emit(DestinationPredictionLoading());
    if (placeName.length > 4) {
      googleMapMethodRepository.searchPlace(placeName).then((value) {
        destinationSearchedList = value;
        emit(DestinationPredictionLoaded(prediction: value));
      });
    }
  }

  String? updatedDropOffLocation;

  updateNavigatorDropOffLocation(String pickedDestination) {
    updatedDropOffLocation = pickedDestination;
    emit(DestinationControllerUpdated());
  }

  late LatLng dropoffLocationLatLng;

  getPlaceDetails(String placeId) async {
    await _googleMapMethod.getPlaceDetails(placeId).then((value) {
      emit(PlaceDetailsLoaded(placeDetails: value));
      dropoffLocationLatLng = LatLng(value.lat, value.lng);
    });
  }

  Future<void> _getDrivers(BuildContext context) async {
    await DriversCubit.instance(context).getDrivers(
        pickupLat:
            locationDetailsPickup!.result!.geometry!.viewport!.northeast!.lat!,
        pickupLng:
            locationDetailsPickup!.result!.geometry!.viewport!.northeast!.lng!,
        dropLat: locationDetailsDestination!
            .result!.geometry!.viewport!.northeast!.lat!,
        dropLng: locationDetailsDestination!
            .result!.geometry!.viewport!.northeast!.lng!,
        duration: routeDirections!.durationValue.toDouble(),
        distance: routeDirections!.distanceValue.toDouble());
  }

  List<LatLng> polyLineCoordinate = [];
  Set<Polyline> polylines = {};

  DirectionDetails? routeDirections;
  Future<void> getDirectionDetails(BuildContext context) async {
    if (locationDetailsPickup?.result?.geometry?.location == null) {
      return; //Means there is error in location of pickup
    }
    if (locationDetailsDestination?.result?.geometry?.location == null) {
      return; //Means there is error in location of destination
    }
    // var pickupPosition = currentLocation;
    var pickupPosition = locationDetailsPickup!.result!.geometry!.location!;
    var distnationPosition =
        locationDetailsDestination!.result!.geometry!.location!;

    // var pickLatLng = LatLng(pickupPosition.latitude, pickupPosition.longitude);
    var pickLatLng = LatLng(pickupPosition.lat!, pickupPosition.lng!);
    // var dropLatLng = dropoffLocationLatLng;
    var dropLatLng = LatLng(distnationPosition.lat!, distnationPosition.lng!);

    markers.clear();
    routeDirections = null;

    final directionsResponse =
        await _googleMapMethod.getDirectionDetails(pickLatLng, dropLatLng);

    routeDirections = directionsResponse;
    _getDrivers(context);
    emit(DirectionDetailsLoaded(directionDetails: directionsResponse));
    addPickupToMarkers();
    addDistnationToMarkers();
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(directionsResponse.edcodedPPoint);

    polyLineCoordinate.clear();
    if (results.isNotEmpty) {
      for (var pointLatLng in results) {
        polyLineCoordinate
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    polylines.clear();
    Polyline polyline = Polyline(
      polylineId: const PolylineId('polylineId'),
      color: Theme.of(context).primaryColor,
      points: polyLineCoordinate,
      jointType: JointType.round,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );
    polylines.add(polyline);

    // fit polyline in the map scope
    fitPolyLineToMapScope(
        southwest: directionsResponse.bounds.southwest.toLatLng(),
        northeast: directionsResponse.bounds.northeast.toLatLng());
  }

  //fit polyline in the map scope

  fitPolyLineToMapScope(
      {required LatLng southwest, required LatLng northeast}) {
    LatLngBounds latLngBounds;

    if (southwest.latitude > northeast.latitude &&
        southwest.longitude > northeast.longitude) {
      latLngBounds = LatLngBounds(southwest: northeast, northeast: southwest);
    } else if (southwest.longitude > northeast.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(southwest.latitude, northeast.longitude),
        northeast: LatLng(northeast.latitude, northeast.longitude),
      );
    } else if (southwest.latitude > northeast.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(northeast.latitude, southwest.longitude),
        northeast: LatLng(southwest.latitude, northeast.longitude),
      );
    } else {
      latLngBounds = LatLngBounds(southwest: southwest, northeast: northeast);
    }

    controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
  }

  //todo when press back arrow need to clear poly routes

  //find Place
  Predictions?
      _selectedPrediction; //Set it with value when press the prediction item
  set selectedPrediction(Predictions? prediction) {
    _selectedPrediction = prediction;
    emit(ChangeSelectedLocation());
  }

  Predictions? get selectedPrediction => _selectedPrediction;

  Prediction? predictions;
  DateTime _lastSearchedTime = DateTime.now();
  Future searchPlaceCubit(String placeName) async {
    final lastSearchedTimeInMiliSeconds =
        DateTime.now().difference(_lastSearchedTime).inMilliseconds;
    _lastSearchedTime = DateTime.now();
    if (lastSearchedTimeInMiliSeconds <= 500 || state is LoadingSearchState) {
      return;
    }
    try {
      emit(LoadingSearchState());
      String url = Endpoints.baseUrl +
          Endpoints.placeAutoComplete +
          "input=$placeName&key=$googleMapApiKey&sessiontoken=1234567890&component=country:eg";
      Response response = await DioHelper.getData(url: url);

      debugPrint("$response");
      predictions = Prediction.fromJson(response.data);
      emit(SuccessPredictionData(
          prediction: Prediction.fromJson(response.data)));
    } catch (e) {
      emit(ErrorOnSearchSTate());
      rethrow;
    }
  }

  String? detactiedLocationLatData;
  String? detactiedLocationLongData;

  DetactiedLocationResultModel? detactiedLocation;

  DetactiedLocationResultModel? locationDetailsPickup;
  DetactiedLocationResultModel? locationDetailsDestination;
  void addPickupToMarkers() {
    final pickupLocation = locationDetailsPickup?.result?.geometry?.location;
    if (pickupLocation == null) return;
    markers.add(
      Marker(
          markerId: const MarkerId('Pickup'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(pickupLocation.lat!, pickupLocation.lng!),
          infoWindow: InfoWindow(
              title: locationDetailsPickup!.result!.name!,
              snippet: locationDetailsPickup?.result!.formattedAddress)),
    );
  }

  void addDistnationToMarkers() {
    final destnationLocation =
        locationDetailsDestination?.result?.geometry?.location;
    if (destnationLocation == null) return;
    markers.add(
      Marker(
        markerId: const MarkerId('Destnation'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(destnationLocation.lat!, destnationLocation.lng!),
        infoWindow: InfoWindow(
            title: locationDetailsDestination!.result!.name!,
            snippet: locationDetailsDestination?.result!.formattedAddress),
      ),
    );
  }

  void swapLocations() {
    detactiedLocation = locationDetailsPickup;
    final temp = locationDetailsDestination;
    setDestinationLocation();
    detactiedLocation = temp;
    setPickupLocation();
  }

  //For get distance between pickup and distnation locations
  bool get isDistanceAvailable {
    if (routeDirections == null) return false;
    return true;
    final pickupLocation = locationDetailsPickup?.result?.geometry?.location;
    final distnationLocation =
        locationDetailsDestination?.result?.geometry?.location;
    return pickupLocation != null && distnationLocation != null;
  }

  String get routeDistance {
    if (!isDistanceAvailable) {
      return 'Unknown';
    }

    return routeDirections!.distanceText;
  }

  String get routeDuration {
    if (!isDistanceAvailable) {
      return 'Unknwon';
    }

    return routeDirections!.durationText;
  }

  int _formattedDistance(modelLocation.Location pickupLocation,
      modelLocation.Location distnationLocation) {
    final distanceMeters = Geolocator.distanceBetween(
            pickupLocation.lat!,
            pickupLocation.lng!,
            distnationLocation.lat!,
            distnationLocation.lat!)
        .ceil();
    log(pickupLocation.lat!.toString() +
        ' - ' +
        pickupLocation.lng!.toString());
    log(distnationLocation.lat!.toString() +
        ' - ' +
        distnationLocation.lng!.toString());
    log('Distance is $distanceMeters');
    return (distanceMeters / 1000).ceil();
  }

  bool isPickupLocationLastFocused = true;
  void changeLastFocused(bool isPickupLastFocused) {
    isPickupLocationLastFocused = isPickupLastFocused;
  }

  void setPickupLocation() {
    if (detactiedLocation != null) {
      locationDetailsPickup = detactiedLocation;
      pickUpController.text =
          locationDetailsPickup?.result?.formattedAddress?.toString() ?? '';
      emit(ChangeSelectedPickupLocation());
    }
  }

  void setDestinationLocation() {
    if (detactiedLocation != null) {
      locationDetailsDestination = detactiedLocation;
      destinationController.text =
          locationDetailsDestination?.result?.formattedAddress?.toString() ??
              '';
      emit(ChangeSelectedDestinationLocation());
    }
  }

  Future getDataOfPlace(String placeId) async {
    emit(LoadingGetState());
    detactiedLocation = null;
    String url =
        Endpoints.baseUrl + Endpoints.placeDetails + 'place_id=$placeId';
    Response response = await DioHelper.getData(
      url: url,
      query: {"key": googleMapApiKey},
    );
    if (response == "failed") {
      emit(ErrorOnGetdataPlace());
    }
    debugPrint("sasa${response.data["result"]}");
    detactiedLocation = DetactiedLocationResultModel.fromJson(response.data);
    detactiedLocationLatData = detactiedLocation!
        .result!.geometry!.viewport!.northeast!.lat
        .toString();
    detactiedLocationLongData = detactiedLocation!
        .result!.geometry!.viewport!.northeast!.lng
        .toString();

    emit(SuccessGetPlaceData(
        detactiedLocationResultModel:
            DetactiedLocationResultModel.fromJson(response.data)));
  }

  resetTrip() {
    polylines.clear();
    polyLineCoordinate.clear();
  }
  //get Data of Driver
}
