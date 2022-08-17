import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/pages/drawer/drawer.dart';
import 'package:user_app/view/pages/home/current_location_button.dart';
import 'package:user_app/view/wigdets/bottom_sheet_maps.dart';
import 'package:user_app/view/wigdets/text_button.dart';
import '../../../cubit/login_cubit/login_cubit.dart';
import '../navigation/navigator_builder.dart';
import '../trip/suggest_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const _initialMapPosition =
      CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sheetController = PanelController();
  @override
  void initState() {
    // LoginCubit.get(context).profileDataModel == null
    //     ? LoginCubit.get(context).profieUser()
    //     : null;

    super.initState();

    BlocProvider.of<GoogleMapCubit>(context).currentUserLocation();
  }

  // final EdgeInsets _mappading = const EdgeInsets.only(bottom: 220);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapCubit, GoogleMapState>(
      listener: (context, state) async {},
      listenWhen: (_, state) => state is DirectionDetailsLoaded,
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        GoogleMapCubit googleMapCubit = GoogleMapCubit.get(context);

        // String? placeid = cubit.placeid;
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                drawer: const DrawerMenue(),
                key: appCubit.scaffoldKey,
                body: _SliderUpWidget(
                  sheetController: sheetController,
                  child: Stack(
                    children: [
                      GoogleMap(
                        // padding: _mappading,
                        mapType: appCubit.currentMapType,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        compassEnabled: false,
                        zoomControlsEnabled: false,
                        markers: googleMapCubit.markers,
                        polylines: googleMapCubit.polylines,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapCubit.controller = controller;
                          //todo call getlocation function here later
                        },
                        initialCameraPosition: HomePage._initialMapPosition,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p50,
                                    horizontal: AppPadding.p10)
                                .copyWith(bottom: AppPadding.p8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _drawerIcon(appCubit),
                                    _backButton(
                                        appCubit, context, googleMapCubit),
                                  ],
                                ),
                                _searchField(appCubit),
                                _mapTypeIcon(appCubit, context),
                              ],
                            ),
                          ),
                          if (googleMapCubit.isDistanceAvailable)
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Distance: ${googleMapCubit.routeDistance}'),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  Visibility _mapTypeIcon(AppCubit appCubit, BuildContext context) {
    return Visibility(
      visible: appCubit.showMapTypesIcon,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.offWhite,
            borderRadius: BorderRadius.circular(10)),
        child: IconButton(
            onPressed: () {
              if (appCubit.showMapsTypes) {
                Navigator.pop(context);
                appCubit.drawerIconVisibility(ishow: true);
                appCubit.currentLocationIconVisibility(ishow: true);
                appCubit.backwardIconVisibility(ishow: false);
              } else {
                appCubit.drawerIconVisibility(ishow: false);
                appCubit.currentLocationIconVisibility(ishow: false);
                appCubit.showMapTypesBottomSheet(ishow: true);
                appCubit.backwardIconVisibility(ishow: false);
                appCubit.scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => Visibility(
                        visible: appCubit.showMapsTypes,
                        child: Container(
                          padding: const EdgeInsets.all(30.0),
                          color: Colors.grey[100],
                          child: const BottomSheetMaps(),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  appCubit.drawerIconVisibility(ishow: true);
                  appCubit.currentLocationIconVisibility(ishow: true);
                  appCubit.showMapTypesBottomSheet(ishow: false);
                });
              }
            },
            icon: const Icon(Icons.auto_awesome_motion_rounded)),
      ),
    );
  }

  Visibility _searchField(AppCubit appCubit) {
    return Visibility(
        visible: appCubit.showCurrentLocationIcon,
        child: const NavigatorBuilder());
  }

  Visibility _backButton(
      AppCubit appCubit, BuildContext context, GoogleMapCubit googleMapCubit) {
    return Visibility(
      visible: appCubit.showBackwardIcon,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.offWhite,
            borderRadius: BorderRadius.circular(40)),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              googleMapCubit.resetTrip();
              appCubit.backwardIconVisibility(ishow: false);
              appCubit.drawerIconVisibility(ishow: true);
              appCubit.currentLocationIconVisibility(ishow: true);
              appCubit.backwardIconVisibility(ishow: false);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            )),
      ),
    );
  }

  Builder _drawerIcon(AppCubit appCubit) {
    return Builder(
      builder: (context) => Visibility(
        visible: appCubit.showDrawerIcon,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                  color: ColorManager.offWhite,
                  borderRadius: BorderRadius.circular(40)),
              child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu)),
            );
          },
        ),
      ),
    );
  }
}

class _SliderUpWidget extends StatefulWidget {
  const _SliderUpWidget(
      {Key? key, required this.child, required this.sheetController})
      : super(key: key);
  final Widget child;
  final PanelController sheetController;
  @override
  State<_SliderUpWidget> createState() => _SliderUpWidgetState();
}

class _SliderUpWidgetState extends State<_SliderUpWidget> {
  @override
  void initState() {
    widgets.WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      log('Inside post frame call back');
      widget.sheetController.hide();
      log('After');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleMapCubit, GoogleMapState>(
      listener: (context, state) async {
        await widget.sheetController.show();
        widget.sheetController.animatePanelToPosition(1);
      },
      listenWhen: (_, state) => state is DirectionDetailsLoaded,
      child: SlidingUpPanel(
          defaultPanelState: PanelState.CLOSED,
          controller: widget.sheetController,
          onPanelClosed: () => setState(() {}),
          onPanelOpened: () => setState(() {}),
          panel: Builder(builder: (context) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    widget.sheetController.isPanelOpen
                        ? await widget.sheetController.close()
                        : await widget.sheetController.open();

                    setState(() {});
                  },
                  child: Card(
                    shape: StadiumBorder(),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(widget.sheetController.isPanelOpen
                            ? Icons.arrow_downward
                            : Icons.arrow_upward),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: const SuggestServicesBuilder()),
                ),
              ],
            );
          }),
          backdropTapClosesPanel: false,
          borderRadius: BorderRadius.circular(AppSize.s20),
          backdropColor: Colors.black12,
          // minHeight: MediaQuery.of(context).size.height * 0.07,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          body: widget.child),
    );
  }
}
