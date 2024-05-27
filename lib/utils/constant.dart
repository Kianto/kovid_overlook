import 'package:flutter/material.dart';

class Constants {
  static const String appName = "Kovid Overlôôk";

  static String msgNoInternet = "No Internet";
  static String msgServerError = "Error from Server, try later";
  static String msgFailure = "Request failed";

  static String defaultImage = "";

  static const String jCountryData = "assets/data/countries.json";

  static const String iFavicon = "assets/favicon.png";
  static const String iKovidOverlook = "assets/images/kovid_overlook.png";
  static const String iKovidOverlookBanner =
      "assets/images/kovid_overlook_banner.png";

  // Colors for theme
  static Color lightPrimary = const Color(0xffd34d0e);
  static Color lightAccent = Colors.orangeAccent;
  static Color lightBG = Colors.white;

  static Color darkPrimary = const Color(0xffde670d);
  static Color darkAccent = Colors.redAccent;
  static Color darkBG = Colors.black;

  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: lightBG,
      primary: lightPrimary,
      secondary: lightAccent,
    ),
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: darkBG,
      primary: darkPrimary,
      secondary: darkAccent,
    ),
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: lightBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );
}
