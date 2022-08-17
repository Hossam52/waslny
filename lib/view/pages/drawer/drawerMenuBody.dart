// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// // import 'package:flutter_svg/flutter_svg.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_app/view/wigdets/onWillPop.dart';
//
// import '../../../cubit/login_cubit/login_cubit.dart';
// import '../../../data/services/localDataLayer.dart';
// import '../../../utils/color_manager.dart';
// import '../../../utils/const_manager.dart';
// import '../../../utils/value_manager.dart';
// import '../../routes/route.dart';
// import '../user_profile/user_profile_pic.dart';
// import 'drawer_tile.dart';
//
//
// class DrawerMenuBody extends StatelessWidget {
//   bool isSwitched = false;
//   Widget drawerheaderBuild() {
//     return userDrawerInfo();
//   }
//
//   Widget userDrawerInfo({context}) {
//     return Row(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, Routes.userProfilePage);
//               },
//               child: Column(
//                 children: [
//                   UserProfilePic(
//                     radiusSize: AppSize.s30,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     "sasa",
//                     style: Theme.of(context).textTheme.headlineLarge,
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   "100 Point -",
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   "Gold Member",
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget defualtUserDrawerInfo({context}) {
//     return Row(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: ColorManager.black.withOpacity(0.04),
//               radius: AppSize.s30,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "User Name",
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Point -",
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   "Member",
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () =>OnWillPop(context,"Are you sure you want to leave the app?"),
//       child: Scaffold(
//         backgroundColor: ColorManager.yellow,
//         body: Padding(
//           padding: const EdgeInsets.only(
//             left: 20.0,
//             top: 50,
//             bottom: 50,
//           ),
//           child: Column(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: ColorManager.yellow,
//                 ),
//                 child: drawerheaderBuild(),
//               ),
//               DrawerTile(
//                   text: ConstentManager.home,
//                   icon: Icons.home,
//                   onPress: () {
//                     Navigator.popAndPushNamed(context, Routes.homePage);
//                   }),
//               DrawerTile(
//                   text: ConstentManager.paymet,
//                   icon: Icons.payment,
//                   onPress: () {}),
//               DrawerTile(
//                   text: ConstentManager.history,
//                   icon: Icons.history,
//                   onPress: () {}),
//               DrawerTile(
//                   text: ConstentManager.notification,
//                   icon: Icons.notifications,
//                   onPress: () {}),
//               DrawerTile(
//                   text: ConstentManager.termsConsditions,
//                   icon: Icons.settings,
//                   onPress: () {}),
//               DrawerTile(
//                 text: ConstentManager.logout,
//                 icon: Icons.logout,
//                 onPress: () {
//                   Shared.prefClear();
//                   Navigator.pushReplacementNamed(context, Routes.loginPage);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );  }
// }