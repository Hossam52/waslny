import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/data/models/profile_data_model.dart';
import 'package:user_app/data/models/user_login.dart';
import 'package:user_app/utils/color_manager.dart';
import 'package:user_app/utils/methods.dart';
import 'package:user_app/utils/value_manager.dart';
import 'package:user_app/view/pages/edit_profile/editProfileName.dart';
import 'package:user_app/view/pages/edit_profile/edit_profile_password.dart';
import 'package:user_app/view/routes/route.dart';

import 'edit_profile_pic.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);

  late UserLogin userLogin;

  Widget profilePageBuilder() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        if (state is UserProfilelodingState) {
          return profilePageLoading();
        }
        if (cubit.profileDataModel == null) {
          return TextButton(
            onPressed: () {
              cubit.profieUser();
            },
            child: const Text('Error happened try again'),
          );
        }
        return profilePageLoaded(cubit.profileDataModel!.data!);

        // if (state is SuccessUserProfileState) {
        //   return profilePageLoaded(context, state.profileData?.email,
        //       state.profileData?.mobile, state.profileData?.name);
        // } else {
        //   return profilePageLoading();
        // }
      },
    );
  }

  Widget profilePageLoaded(ProfileData profile) {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: EditProfilePic(
                  radiusSize: AppSize.s20,
                  image: profile.photo,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s8,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ListTile.divideTiles(tiles: [
                    ListTileDetails(
                      title: "Username",
                      onTap: () {
                        navigateTo(context, EditProfileName());
                        // Navigator.pushNamed(context, Routes.editProfileName);
                      },
                      subTitle: profile.name!,
                    ),
                    ListTileDetails2(
                      title: "Phone",
                      onTap: () {},
                      subTitle: profile.mobile!,
                    ),
                    ListTileDetails2(
                      title: "Email",
                      onTap: () {},
                      subTitle: profile.email!,
                    ),
                    ListTileDetails(
                      title: "Password",
                      onTap: () {
                        navigateTo(context, EditProfilePassword());
                        // Navigator.pushNamed(context, Routes.changePassword);
                      },
                      subTitle: "Change Password",
                    ),
                  ], color: Colors.black.withOpacity(0.5), context: context)
                      .toList(),
                  // [
                  //   Container(
                  //     height: AppSize.s80,
                  //     child: Column(
                  //       children: [
                  //         // Container(
                  //         //   height: AppSize.s60,
                  //         //   child: Row(
                  //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         //     children: [
                  //         //       Container(
                  //         //         child: Column(
                  //         //           crossAxisAlignment: CrossAxisAlignment.start,
                  //         //           children: [
                  //         //             Text(
                  //         //               "Phone",
                  //         //             ),
                  //         //             const Spacer(),
                  //         //             Text(
                  //         //               phone,
                  //         //               style:
                  //         //                   Theme.of(context).textTheme.bodyLarge,
                  //         //             ),
                  //         //           ],
                  //         //         ),
                  //         //       ),
                  //         //       IconButton(
                  //         //           onPressed: () {},
                  //         //           icon: Icon(
                  //         //             Icons.arrow_forward_ios,
                  //         //             color: Colors.grey,
                  //         //           ))
                  //         //     ],
                  //         //   ),
                  //         // ),
                  //         Divider(
                  //           color: Colors.black.withOpacity(0.2),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  //   const SizedBox(
                  //     height: 10,
                  //   ),
                  //   Container(
                  //     height: AppSize.s80,
                  //     child: Column(
                  //       children: [
                  //         Container(
                  //           height: AppSize.s60,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Email",
                  //                     ),
                  //                     const Spacer(),
                  //                     Text(
                  //                       email,
                  //                       style:
                  //                           Theme.of(context).textTheme.bodyLarge,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                   onPressed: () {},
                  //                   icon: Icon(
                  //                     Icons.arrow_forward_ios,
                  //                     color: Colors.grey,
                  //                   ))
                  //             ],
                  //           ),
                  //         ),
                  //         Divider(
                  //           color: Colors.black.withOpacity(0.2),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  //   const SizedBox(
                  //     height: 10,
                  //   ),
                  //   Container(
                  //     height: AppSize.s80,
                  //     child: Column(
                  //       children: [
                  //         Container(
                  //           height: AppSize.s60,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Password",
                  //                     ),
                  //                     const Spacer(),
                  //                     InkWell(
                  //                       onTap: () => Navigator.pushNamed(
                  //                           context, Routes.changePassword),
                  //                       child: Text(
                  //                         "change Password",
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyLarge,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               IconButton(
                  //                   onPressed: () {},
                  //                   icon: Icon(
                  //                     Icons.arrow_forward_ios,
                  //                     color: Colors.grey,
                  //                   ))
                  //             ],
                  //           ),
                  //         ),
                  //         Divider(
                  //           color: Colors.black.withOpacity(0.2),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget profilePageLoading() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(AppPadding.p8),
      child: CircularProgressIndicator(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: ColorManager.yellow,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Edit Profile"),
      ),
      body: Container(
        height: 400,
        color: Colors.white,
        child: profilePageBuilder(),
      ),
    );
  }
}

class ListTileDetails extends StatelessWidget {
  void Function()? onTap;
  String title;
  String subTitle;

  ListTileDetails(
      {required this.onTap, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          color: ColorManager.black.withOpacity(0.5),
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
      ),
    );
  }
}

class ListTileDetails2 extends StatelessWidget {
  void Function()? onTap;
  String title;
  String subTitle;

  ListTileDetails2(
      {required this.onTap, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          color: ColorManager.black.withOpacity(0.5),
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Text(
        "verified",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
