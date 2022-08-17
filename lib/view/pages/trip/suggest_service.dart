import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/cubit/drivers_cubit/drivers_cubit.dart';
import 'package:user_app/cubit/drivers_cubit/drivers_states.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/data/models/direction_details_model.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/pages/pickup_driver_info/pickup_driver_info.dart';
import 'package:user_app/view/wigdets/text_button.dart';
import 'car_trip_option.dart';
import 'trip_icon_button.dart';

class SuggestServicesBuilder extends StatefulWidget {
  const SuggestServicesBuilder({Key? key}) : super(key: key);

  @override
  State<SuggestServicesBuilder> createState() => _SuggestServicesBuilderState();
}

class _SuggestServicesBuilderState extends State<SuggestServicesBuilder> {
  late DirectionDetails directionDetails;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = BlocProvider.of<AppCubit>(context);
    final mapCubit = GoogleMapCubit.get(context);
    return DriversBlocBuilder(
      builder: (context, state) {
        final driversCubit = DriversCubit.instance(context);
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ColorManager.offWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    _richText(
                        title: 'Estimated distance: ',
                        value: mapCubit.routeDistance),
                    _richText(
                        title: 'Estimated duration: ',
                        value: mapCubit.routeDuration),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    ConstentManager.suggestServices,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Text(
                    ConstentManager.viewAll,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.yellow,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_up,
                    color: ColorManager.gray,
                  ),
                ],
              ),
              Builder(builder: (context) {
                if (state is GetDriversLoadingState) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                // if (driversCubit.tripNotLoaded) {
                //   return Center(
                //     child: TextButton(
                //         onPressed: () {}, child: Text('Error happened reload')),
                //   );
                // }
                if (driversCubit.nearestDrivers.isEmpty) {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/images/cry.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Center(
                          child: Text(
                        'Sorry,no  drivers near you ',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                    ],
                  );
                }
                return ListView.builder(
                    itemCount: driversCubit.nearestDrivers.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return CarTripOption(
                          driver: driversCubit.nearestDrivers[index]);
                    });
              }),
              if (!driversCubit.tripNotLoaded)
                Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TripIconButton(
                              ontap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: ColorManager.offWhite,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      height: 700,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: 5,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container();
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              buttonText: ConstentManager.options,
                              textColor: ColorManager.black,
                              borderColor: ColorManager.offWhite,
                              backgroundColor: ColorManager.offWhite,
                              icon: Icons.settings),
                          const VerticalDivider(
                            endIndent: 8,
                            indent: 8,
                            thickness: 2,
                          ),
                          TripIconButton(
                              ontap: () {},
                              buttonText: ConstentManager.promo,
                              textColor: ColorManager.black,
                              borderColor: ColorManager.offWhite,
                              backgroundColor: ColorManager.offWhite,
                              icon: Icons.card_giftcard),
                        ],
                      ),
                    ),
                    DefualtTextButton(
                        ontap: () {
                          cubit.scaffoldKey.currentState
                              ?.showBottomSheet((context) {
                                return Visibility(
                                    visible: cubit.showBackwardIcon,
                                    child: const PcikupDriverInfo());
                              })
                              .closed
                              .then((value) {
                                cubit.drawerIconVisibility(ishow: true);
                                cubit.currentLocationIconVisibility(
                                    ishow: true);
                                cubit.backwardIconVisibility(ishow: false);
                              });
                        },
                        buttonText: ConstentManager.bookNow,
                        borderColor: ColorManager.yellow,
                        textColor: ColorManager.offWhite,
                        backgroundColor: ColorManager.yellow),
                  ],
                ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        driversCubit.assignTrip(true);
                      },
                      child: Text('Test no drivers')),
                  TextButton(
                      onPressed: () {
                        driversCubit.assignTrip(false);
                      },
                      child: Text('Test has drivers')),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  RichText _richText({required String title, required String value}) {
    return RichText(
      text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.black,
              ),
          children: [
            TextSpan(
              text: value,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
