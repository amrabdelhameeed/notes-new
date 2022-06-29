import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Cairo',
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    backgroundColor: AppColors.backgroundColor,
    primaryColorDark: AppColors.darkBackgroundColor,
    primaryColorLight: AppColors.backgroundColor,
    primaryColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        titleTextStyle: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          fontSize: 35.0,
          fontFamily: "Cairo",
          fontWeight: FontWeight.bold,
        )),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        color: AppColors.goldenColor,
        fontSize: 27,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle2: TextStyle(
        color: AppColors.darkColor,
        fontSize: 18,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      ),
      headline1: TextStyle(
        fontSize: 72.0,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      headline6: TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      bodyText2: TextStyle(
        fontSize: 25.0,
        fontFamily: 'Cairo',
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.darkBackgroundColor,
    primaryIconTheme: const IconThemeData(color: Colors.white),
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    primaryColorDark: AppColors.darkBackgroundColor,
    primaryColorLight: AppColors.backgroundColor,
    backgroundColor: AppColors.darkColor,
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        titleTextStyle: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "Cairo")),
    textTheme: const TextTheme(
      subtitle1: TextStyle(color: AppColors.secondaryColor, fontSize: 27),
      subtitle2: TextStyle(color: Colors.white, fontSize: 18),
      headline1: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      ),
      headline6: TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      bodyText2: TextStyle(
        fontSize: 25.0,
        fontFamily: 'Cairo',
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
