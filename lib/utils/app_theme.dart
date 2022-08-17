import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    drawerTheme: const DrawerThemeData(),
    //bottomsheet theme
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    // main colors
    primaryColor: ColorManager.yellow,
    disabledColor: ColorManager.gray,

    // // app bar theme
    // appBarTheme: AppBarTheme(
    //   centerTitle: true,
    //   color: ColorManager.offWhite,
    //   elevation: AppSize.s0,
    //   titleTextStyle:
    //       getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
    //   iconTheme: const IconThemeData(color: ColorManager.black),
    //   backwardsCompatibility: false,
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //
    //   )
    // ),
    // card theme
    cardTheme: CardTheme(
      elevation: AppSize.s10,
      color: ColorManager.offWhite,
    ),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      buttonColor: ColorManager.yellow,
      splashColor: ColorManager.yellow,
      disabledColor: ColorManager.gray,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.yellow,
        textStyle: getBoldStyle(
          color: ColorManager.offWhite,
          fontSize: FontSize.s25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
      ),
    ),
    //text theme
    textTheme: TextTheme(
      //used
      displayLarge:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s30),
      bodyLarge:
          getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
      titleSmall:
          getSemiBoldStyle(color: ColorManager.red, fontSize: FontSize.s14),
      bodyMedium:
          getBoldStyle(color: ColorManager.gray, fontSize: FontSize.s14),
      // for text field form label
      titleMedium:
          getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
      titleLarge:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s14),
      bodySmall:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
      displayMedium:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s25),
      // displaySmall: ,
      headlineLarge:
          getBoldStyle(color: ColorManager.offWhite, fontSize: FontSize.s18),
      headlineMedium: getSemiBoldStyle(
          color: ColorManager.offWhite, fontSize: FontSize.s16),
      headlineSmall:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      iconColor: ColorManager.yellow,
      //content padding
      contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      //hint style
      hintStyle:
          getRegularStyle(color: ColorManager.gray, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.red),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s10,
        ),
        borderSide: const BorderSide(color: ColorManager.gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.yellow,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s10,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s10,
        ),
        borderSide: const BorderSide(color: ColorManager.gray),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s10,
        ),
        borderSide: const BorderSide(color: ColorManager.gray),
      ),
    ),
  );
}
