import 'package:flutter/material.dart';
import 'package:video/colors/color.dart';

AppColors colors = AppColors();

class AppTheme {
  ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      popupMenuTheme:  PopupMenuThemeData(
        color:const Color(0xffe8e8e8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      iconTheme: IconThemeData(size: 25, color: colors.unSelectedLightColor),
      scaffoldBackgroundColor: colors.backgroundLightColor,
      textTheme: TextTheme(
          headlineMedium:
              TextStyle(fontSize: 15, color: colors.unSelectedLightColor),
          headlineLarge:
              TextStyle(fontSize: 17, color: colors.lightThemeTextColor)));
  ThemeData darkTheme = ThemeData(
      popupMenuTheme:  PopupMenuThemeData(
        color:const Color(0xff2e2e2e),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
        
      ),
      useMaterial3: true,
      iconTheme: const IconThemeData(size: 25, color: Colors.white70),
      scaffoldBackgroundColor: colors.backgroundDarkColor,
      textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: colors.unSelectedDarkColor),
          headlineLarge: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: colors.darkThemeTextColor)));
}
