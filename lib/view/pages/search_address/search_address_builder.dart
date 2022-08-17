import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/drivers_cubit/drivers_cubit.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/utils/color_manager.dart';
import '../navigation/navigator_text_field.dart';

class NavigatorTextBuilder extends StatefulWidget {
  const NavigatorTextBuilder({Key? key}) : super(key: key);

  @override
  State<NavigatorTextBuilder> createState() => _NavigatorTextBuilderState();
}

class _NavigatorTextBuilderState extends State<NavigatorTextBuilder> {
  var focusedFrom = FocusNode();
  var focusedDestination = FocusNode();

  bool isfocuse = false;

  @override
  void initState() {
    super.initState();
    bool isPickupFocused =
        GoogleMapCubit.get(context).isPickupLocationLastFocused;
    if (isPickupFocused) {
      focusedFrom.requestFocus();
    } else {
      focusedDestination.requestFocus();
    }
  }

  void setFocuse() {
    if (!isfocuse) {
      FocusScope.of(context).requestFocus(focusedDestination);
      isfocuse = true;
    }
  }

  @override
  void dispose() {
    focusedFrom.dispose();
    focusedDestination.dispose();
    super.dispose();
  }

  Future<void> getDrivers(BuildContext context) async {
    final googleMapCubit = GoogleMapCubit.get(context);
    await googleMapCubit.getDirectionDetails(context);
  }

  void setPickupLocation(BuildContext context) {
    final googleMapCubit = GoogleMapCubit.get(context);
    googleMapCubit.setPickupLocation();
    googleMapCubit.pickUpController.text = googleMapCubit
            .locationDetailsPickup?.result?.formattedAddress
            ?.toString() ??
        '';
    googleMapCubit.changeLastFocused(false);
    FocusScope.of(context).requestFocus(focusedDestination);
  }

  void setDistnationLocation(BuildContext context) async {
    final googleMapCubit = GoogleMapCubit.get(context);
    googleMapCubit.setDestinationLocation();
    googleMapCubit.destinationController.text = googleMapCubit
            .locationDetailsDestination?.result?.formattedAddress
            ?.toString() ??
        '';
    await getDrivers(context);
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapCubit, GoogleMapState>(
      listener: (context, state) async {
        final googleMapCubit = GoogleMapCubit.get(context);
        await googleMapCubit
            .getDataOfPlace(googleMapCubit.selectedPrediction!.placeId!);
        if (focusedFrom.hasFocus) {
          setPickupLocation(context);
        } else if (focusedDestination.hasFocus) {
          setDistnationLocation(context);
        } else {
          googleMapCubit.isPickupLocationLastFocused
              ? setPickupLocation(context)
              : setDistnationLocation(context);
        }
      },
      listenWhen: (old, newState) {
        return newState is ChangeSelectedLocation;
      },
      builder: (context, state) {
        final googleMapCubit = GoogleMapCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorManager.offWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.gps_fixed,
                    color: ColorManager.yellow,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NavigatorTextFeild(
                      focusNode: focusedFrom,
                      controller: GoogleMapCubit.get(context).pickUpController,
                      onSubmite: (value) {
                        GoogleMapCubit.get(context).searchPlaceCubit(value!);
                      },
                      onChange: (val) {
                        GoogleMapCubit.get(context).changeLastFocused(true);
                      },
                      label: googleMapCubit.locationDetailsPickup?.result
                              ?.formattedAddress ??
                          "${GoogleMapCubit.get(context).placeMark?[0].country},${GoogleMapCubit.get(context).placeMark?[0].street}",
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
                indent: 30,
              ),
              Row(
                children: [
                  const Icon(Icons.fmd_good, color: Colors.red),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NavigatorTextFeild(
                      focusNode: focusedDestination,
                      onSubmite: (value) {
                        GoogleMapCubit.get(context).searchPlaceCubit(value!);
                      },
                      suffix: Icons.close,
                      onChange: (val) {
                        GoogleMapCubit.get(context).changeLastFocused(false);
                      },
                      controller:
                          GoogleMapCubit.get(context).destinationController,
                      label: googleMapCubit.locationDetailsDestination?.result
                              ?.formattedAddress ??
                          "To",
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
