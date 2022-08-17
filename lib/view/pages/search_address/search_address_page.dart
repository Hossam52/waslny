import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/data/models/prediction_model.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/value_manager.dart';
import 'search_result_builder.dart';
import 'search_address_builder.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({Key? key}) : super(key: key);

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  late List<Prediction> prediction;

  Widget lodingBuilder() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(AppPadding.p8),
      child: CircularProgressIndicator(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          ConstentManager.searchAddress,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavigatorTextBuilder(),
            Divider(
              thickness: 20,
              color: ColorManager.liteGray,
            ),

            // destinationPredictionbuilder(),
            SearchResultBuilder(
              onPredictionPressed: (place) async {
                final GoogleMapCubit googleMapCubit =
                    GoogleMapCubit.get(context);
                googleMapCubit.selectedPrediction = place;
                // await googleMapCubit
                //     .getDataOfPlace(place.placeId.toString())
                //     .then((value) async {
                //   // await LoginCubit.get(context).getAllDriver(
                //   //   dropLat: googleMapCubit.detactiedLocationLongData,
                //   //   dropLon: googleMapCubit.detactiedLocationLongData,
                //   //   pickUpLat: googleMapCubit.currentLocation.latitude,
                //   //   pickUpLong: googleMapCubit.currentLocation.latitude,
                //   // );
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
