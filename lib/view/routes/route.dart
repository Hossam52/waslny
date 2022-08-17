import 'package:flutter/material.dart';
import 'package:user_app/view/pages/edit_profile/edit_profile.dart';
import 'package:user_app/view/pages/login/login_page.dart';
import 'package:user_app/view/pages/registration/registration_page.dart';
import 'package:user_app/view/pages/search_address/search_address_page.dart';
import 'package:user_app/view/pages/user_profile/user_profile_page.dart';

import '../pages/drawer/zoomDrawer.dart';
import '../pages/edit_profile/editProfileName.dart';
import '../pages/edit_profile/edit_profile_password.dart';
import '../pages/home/home_page.dart';
import '../pages/splashScreen.dart';

class Routes {
  static const String splashScreen = "/";
  static const String onboardingPage = "/on";
  static const String homePage = "/home_page";
  static const String loginPage = "/login_page";
  static const String searchAddressPage = "/Search_address_page";
  static const String registrationPage = "/registration_page";
  static const String userProfilePage = "/user_profile_page";
  static const String editProfileName = "/EditProfileName";
  static const String changePassword="/changePassword";
}

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (context)=>EditProfilePassword());
      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => HomePage());
      case Routes.searchAddressPage:
        return MaterialPageRoute(
            builder: (context) => const SearchAddressPage());
      case Routes.loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case Routes.registrationPage:
        return MaterialPageRoute(builder: (context) => RegistrationPage());
      case Routes.userProfilePage:
        return MaterialPageRoute(builder: (context) => UserProfilePage());
      case Routes.editProfileName:
        return MaterialPageRoute(builder: (context) => EditProfileName());
      default:
        throw ('this page does not exist');
    }
  }
}
