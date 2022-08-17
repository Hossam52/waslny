import 'package:flutter/material.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/utils/color_manager.dart';

import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/pages/pickup_driver_info/communication_icon_button.dart';
import 'package:user_app/view/pages/user_profile/user_profile_pic.dart';

class PcikupDriverInfo extends StatelessWidget {
  const PcikupDriverInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

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
          Row(
            children: [
              Column(
                children: [
                  //UserProfilePic(radiusSize: AppSize.s30),
                  const Text("Patrick"),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      color: ColorManager.liteGray,
                    ),
                    child: Text(
                      "ن ا ي ٣٣٤",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Text("Volkswagen Jetta"),
                  const Text("4.3"),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommunicationIconButton(
                icon: Icons.call,
                ontap: () {},
              ),
              CommunicationIconButton(
                icon: Icons.message,
                ontap: () {},
              ),
              CommunicationIconButton(
                icon: Icons.cancel,
                ontap: () {
                  Navigator.pop(context);
                  cubit.drawerIconVisibility(ishow: true);
                  cubit.currentLocationIconVisibility(ishow: true);
                  cubit.backwardIconVisibility(ishow: false);
                },
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
        ],
      ),
    );
  }
}
