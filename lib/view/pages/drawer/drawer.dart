import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/data/models/profile_data_model.dart';
import 'package:user_app/data/models/user_login.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/const_manager.dart';
import 'package:user_app/utils/methods.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/pages/login/login_page.dart';
import 'package:user_app/view/pages/user_profile/user_profile_page.dart';
import 'package:user_app/view/pages/user_profile/user_profile_pic.dart';
import 'package:user_app/view/routes/route.dart';
import '../../../data/services/localDataLayer.dart';
import 'drawer_tile.dart';

class DrawerMenue extends StatefulWidget {
  const DrawerMenue({Key? key}) : super(key: key);

  @override
  State<DrawerMenue> createState() => _DrawerMenueState();
}

class _DrawerMenueState extends State<DrawerMenue> {
  late UserLogin userLogin;

  Widget drawerheaderBuild() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        if (state is UserProfilelodingState) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (cubit.profileDataModel == null ||
            (cubit.profileDataModel?.data) == null) {
          return SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                cubit.profieUser();
              },
              child: const Text('Error happened try again'),
            ),
          );
        } else {
          return userDrawerInfo(
            (cubit.profileDataModel?.data)!,
          );
        }
      },
    );
  }

  Widget userDrawerInfo(ProfileData profile) {
    return Row(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  navigateTo(context, UserProfilePage());
                  // Navigator.pushNamed(context, Routes.userProfilePage);
                },
                child: Container(
                  child: Column(
                    children: [
                      UserProfilePic(
                        radiusSize: AppSize.s30,
                        image: profile.photo,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        profile.name ?? 'Unknwon',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "100 Point -",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gold Member",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget defualtUserDrawerInfo() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: ColorManager.black.withOpacity(0.04),
              radius: AppSize.s30,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "User Name",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Point -",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Member",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    LoginCubit.get(context).profileDataModel == null
        ? LoginCubit.get(context).profieUser()
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: ColorManager.yellow.withOpacity(0.9),
          ),
          child: drawerheaderBuild(),
        ),
        // DrawerTile(
        //     text: ConstentManager.home,
        //     icon: Icons.home,
        //     onPress: () {
        //       Navigator.pop(context);
        //       Navigator.pushReplacementNamed(context, Routes.homePage);
        //     }),
        DrawerTile(
            text: ConstentManager.paymet, icon: Icons.payment, onPress: () {}),
        DrawerTile(
            text: ConstentManager.history, icon: Icons.history, onPress: () {}),
        DrawerTile(
            text: ConstentManager.notification,
            icon: Icons.notifications,
            onPress: () {}),
        DrawerTile(
            text: ConstentManager.termsConsditions,
            icon: Icons.settings,
            onPress: () {}),
        DrawerTile(
          text: ConstentManager.logout,
          icon: Icons.logout,
          onPress: () {
            Shared.prefClear();
            navigateToReplacement(context, LoginPage());
            // Navigator.pushReplacementNamed(context, Routes.loginPage);
          },
        ),
      ],
    );
  }
}
