import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_app/core/dioHelper.dart';
import 'package:user_app/data/models/store_trip_model.dart';
import 'package:user_app/data/request_models/store_trip_request.dart';
import 'package:user_app/data/services/driver_services.dart';
import 'package:user_app/data/services/endpoint.dart';
import 'package:user_app/data/services/localDataLayer.dart';
import './drivers_states.dart';

//Bloc builder and bloc consumer methods
typedef DriversBlocBuilder = BlocBuilder<DriversCubit, DriversStates>;
typedef DriversBlocConsumer = BlocConsumer<DriversCubit, DriversStates>;

//
class DriversCubit extends Cubit<DriversStates> {
  DriversCubit() : super(IntitalDriversState());
  static DriversCubit instance(BuildContext context) =>
      BlocProvider.of<DriversCubit>(context);
  final DriverServices _driverServices = DriverServices.instance;

  TripModel? _trip;
  bool get tripNotLoaded => _trip == null;
  List<NearestDrivers> get nearestDrivers => _trip?.nearestdrivers ?? [];
  void assignTrip(bool emptyTrip) {
    log(_trip.toString());
    final newTrip = TripModel.fromMap({});
    newTrip.nearestdrivers.add(NearestDrivers(driverName: 'driverName'));
    newTrip.nearestdrivers.add(NearestDrivers(driverName: 'driverName2'));
    newTrip.nearestdrivers.add(NearestDrivers(driverName: 'driverName3'));
    newTrip.nearestdrivers.add(NearestDrivers(driverName: 'driverName4'));
    newTrip.nearestdrivers.add(NearestDrivers(driverName: 'driverName5'));
    newTrip.nearestdrivers.add(NearestDrivers(driverName: 'driverName6'));
    emptyTrip ? _trip = null : _trip = newTrip;
    emit(GetDriversSuccessState());
  }

  Future<void> getDrivers({
    required double pickupLat,
    required double pickupLng,
    required double dropLat,
    required double dropLng,
    required double duration,
    required double distance,
  }) async {
    try {
      _trip = null;
      emit(GetDriversLoadingState());
      final map = await _driverServices.getAllDrivers(
        StoreTripRequest(
          pickup_lat: pickupLat,
          pickup_lon: pickupLng,
          drop_lat: dropLat,
          drop_lon: dropLng,
          duration: duration,
          distance: distance,
        ),
      );
      _trip = TripModel.fromMap(map);

      emit(GetDriversSuccessState());
    } catch (e) {
      emit(GetDriversErrorState(error: e.toString()));
      rethrow;
    }
  }
}
