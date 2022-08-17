import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(BottomSheetInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  MapType currentMapType = MapType.terrain;
  bool isVisiable = true;
  bool isSuggestServicesShow = false;

// show map types bottom sheet
  bool showMapsTypes = false;

  void showMapTypesBottomSheet({required bool ishow}) {
    showMapsTypes = ishow;
    emit(ShowBottomSheetState());
  }

  //visibility

  bool showMapTypesIcon = true;
  void mapTypesIconVisibility({required bool ishow}) {
    showMapTypesIcon = ishow;
    emit(ShowMaptypesState());
  }

  bool showDrawerIcon = true;
  void drawerIconVisibility({required bool ishow}) {
    showDrawerIcon = ishow;
    emit(ShowDrawerIconState());
  }

  bool showCurrentLocationIcon = true;
  void currentLocationIconVisibility({required bool ishow}) {
    showCurrentLocationIcon = ishow;
    emit(ShowCurrnetLocationIconState());
  }

  bool showBackwardIcon = false;
  void backwardIconVisibility({required bool ishow}) {
    showBackwardIcon = ishow;
    emit(ShowBackWardIconState());
  }

  // choose between map types

  void changeMapHybrid() {
    currentMapType = MapType.hybrid;
    emit(MapHybrid());
  }

  void changeMapNoraml() {
    currentMapType = MapType.normal;
    emit(MapNormal());
  }

  void changeMapsatellite() {
    currentMapType = MapType.satellite;
    emit(MapSatellite());
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
}  

  //todo check later

  // late Position currentPosition;
  // late GoogleMapController controller;

  // getLocation() async {
  //   bool serviceEnabled;

  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   currentPosition = position;
  //   LatLng pos = LatLng(currentPosition.latitude, currentPosition.longitude);
  //   CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 14);
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //   Results? results;

  //   results!.latitud = currentPosition.altitude;
  //   results.longtud = currentPosition.altitude;

  //   emit(UserCurrentLocationState());
  // }

  //todo when using geocoding package function  getlocation stop working

//convert lat and long of location into address
  // late StreamSubscription<Position> streamSubscription;
  // findCordinateAddress() async {
  //   streamSubscription =
  //       Geolocator.getPositionStream().listen((Position position) {
  //     getLocationFromLatLong(position);
  //     emit(DestinationPredictiontest());
  //   });
  // }

  // var address;

  // getLocationFromLatLong(Position position) async {
  //   List<Placemark> userAddress =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark placemark = userAddress[0];
  //   address = "${placemark.locality}, ${placemark.street}";
  //   emit(FindCordinateAddress());
  //   return address;
  // }
