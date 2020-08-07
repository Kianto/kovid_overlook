import 'package:flutter/material.dart';
class Constants{

  static final String appName = "Kovid Overlôôk";

  static String msg_NoInternet = "No Internet";
  static String msg_ServerError = "Error from Server, try later";
  static String msg_Failure = "Request failed";


  static final String j_country_data = "assets/data/countries.json";

  static final String i_favicon = "assets/favicon.png";
  static final String i_kovid_overlook = "assets/images/kovid_overlook.png";
  static final String i_kovid_overlook_banner = "assets/images/kovid_overlook_banner.png";

  // Colors for theme
  static Color lightPrimary = Color(0xffd34d0e);
  static Color lightAccent = Colors.orangeAccent;
  static Color lightBG = Colors.white10;

  static Color darkPrimary = Color(0xffde670d);
  static Color darkAccent = Colors.redAccent;
  static Color darkBG = Colors.black12;

  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,

    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,

    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );


}