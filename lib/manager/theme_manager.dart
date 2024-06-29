import 'package:flutter/material.dart';
import 'package:healthcy/manager/color_manager.dart';
import 'package:healthcy/manager/font_manager.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardColor: appColors.containerLight,
      iconTheme: const IconThemeData(color: Colors.black),
      indicatorColor: appColors.linearBarBgLight,
      appBarTheme: AppBarTheme(
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade50,
          elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          hintStyle: const TextStyle(
            fontSize: 14,
          )),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.red),
      textTheme: TextTheme(
          labelMedium: appFonts.logoTextLight,
          titleMedium: appFonts.homeGreetLight,
         titleSmall: appFonts.containerTitleLight,
        labelSmall: appFonts.containerDataLight,
        displaySmall: appFonts.smallInfoLight,));

  ///Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    cardColor: appColors.containerDark,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
       indicatorColor: appColors.linearBarBgDark,
    scaffoldBackgroundColor: appColors.brandDark,
     iconTheme: const IconThemeData(color: Colors.white),

    appBarTheme: AppBarTheme(
      backgroundColor: appColors.brandDark,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    // bottomAppBarColor: ColorConstants.gray800,

    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    textTheme: TextTheme(
        labelMedium: appFonts.logoTextDark,
        titleSmall: appFonts.containerTitleDark,
        labelSmall: appFonts.containerDataDark,
        displaySmall: appFonts.smallInfoDark,
        titleMedium: appFonts.homeGreetDark,
        ),
  );
}
