import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';

import 'package:user_app/utils/color_manager.dart';

class CurrentlocationButton extends StatelessWidget {
  const CurrentlocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleMapCubit cubit = BlocProvider.of<GoogleMapCubit>(context);

    return FloatingActionButton(
      onPressed: () {
        cubit.currentUserFormattedAddressLocation();
      },
      backgroundColor: ColorManager.offWhite,
      child: const Icon(
        Icons.gps_fixed,
        color: ColorManager.black,
      ),
    );
  }
}
