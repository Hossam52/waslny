// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_zoom_drawer/config.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:user_app/view/pages/home/home_page.dart';
//
// import '../../../utils/color_manager.dart';
// import 'drawerMenuBody.dart';
//
// class NavigationDrawer extends StatefulWidget {
//
//
//   @override
//   _NavigationDrawerState createState() => _NavigationDrawerState();
// }
//
// class _NavigationDrawerState extends State<NavigationDrawer>
//     with WidgetsBindingObserver {
//   // DynamicLink dynamicLink = DynamicLink();
//   onWillPop() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: Text("Exit"),
//           content: Text("Are you sure you want to leave the app?"),
//           actions: [
//             CupertinoDialogAction(
//                 child: Text("YES"),
//                 onPressed: () {
//                   SystemChannels.platform
//                       .invokeMethod('SystemNavigator.pop');
//                 }),
//             CupertinoDialogAction(
//                 child: Text("NO"),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 })
//           ],
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => onWillPop(),
//       child: ZoomDrawer(
//         mainScreenTapClose: true,
//         disableDragGesture: true,
//         menuBackgroundColor: ColorManager.yellow,
//         style: DrawerStyle.defaultStyle,
//         //disableGesture: true,
//         //clipMainScreen: true,
//         borderRadius: 24.0,
//         angle: 0,
//         slideWidth: MediaQuery.of(context).size.width * 0.63,
//         drawerShadowsBackgroundColor: Colors.blue.withOpacity(0.5),
//         showShadow: true,
//         mainScreenScale: 0,
//         menuScreen: DrawerMenuBody(),
//         mainScreen: HomePage(),
//         openCurve: Curves.fastOutSlowIn,
//         closeCurve: Curves.bounceOut,
//         androidCloseOnBackTap: true,
//         duration: Duration(milliseconds: 200),
//       ),
//     );
//   }
// }