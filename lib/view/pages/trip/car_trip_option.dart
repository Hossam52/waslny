import 'dart:math';

import 'package:flutter/material.dart';

import 'package:user_app/data/models/direction_details_model.dart';
import 'package:user_app/data/models/store_trip_model.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/value_manager.dart';

class CarTripOption extends StatefulWidget {
  final NearestDrivers driver;
  const CarTripOption({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  State<CarTripOption> createState() => _CarTripOptionState();
}

class _CarTripOptionState extends State<CarTripOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Image(
                    width: 100,
                    height: 70,
                    image: AssetImage("assets/images/car2.png"),
                    fit: BoxFit.fill,
                  ),
                  Text(
                    // "Standard",
                    widget.driver.driverName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                Random().nextInt(100).toString() +
                    ' km', // widget.directionDetails.distanceText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Column(
                children: [
                  Text(
                    "\$ 20.45",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      color: ColorManager.gray,
                    ),
                    child: Center(
                      child: Text(
                        // widget.directionDetails.durationText,
                        Random().nextInt(33).toString() + ' m',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
