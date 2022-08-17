import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/data/models/address_model.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/routes/route.dart';

import '../../../utils/color_manager.dart';

class NavigatorBuilder extends StatefulWidget {
  const NavigatorBuilder({Key? key}) : super(key: key);

  @override
  State<NavigatorBuilder> createState() => _NavigatorBuilderState();
}

class _NavigatorBuilderState extends State<NavigatorBuilder> {
  late Results results;

  Widget pickupBlocWidget() {
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      builder: (context, state) {
        if (state is FormattedAddressLoaded) {
          results = (state).results;
          return formattedAddressBuidler();
        } else {
          return defualtFormattedAddress();
        }
      },
    );
  }

  Widget formattedAddressBuidler() {
    return Text(
      results.formattedAddress,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget defualtFormattedAddress() {
    return Text(
      ConstentManager.selectPickupLocation,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      builder: (context, state) {
        GoogleMapCubit googleMapCubit = GoogleMapCubit.get(context);
        // String? droppOff = googleMapCubit.pickedPrediction;
        return Container(
          padding: const EdgeInsets.all(AppPadding.p10),
          height: AppSize.s50,
          width: MediaQuery.of(context).size.width/1.5,
          decoration: BoxDecoration(
            color: ColorManager.offWhite,
            borderRadius: BorderRadius.circular(AppSize.s10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.circle, color: Colors.black,size: AppSize.s10,),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   ConstentManager.dropOff,
                    //   style: Theme.of(context).textTheme.bodyMedium,
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.searchAddressPage);
                      },
                      child: Text(
                        googleMapCubit.updatedDropOffLocation ??
                            ConstentManager.selectDropoffLocation,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
