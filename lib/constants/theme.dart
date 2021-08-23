import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final kThemeDark = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all<Color>(Color(0xFF222222)),
    interactive: true,
    isAlwaysShown: false,
  ),
  fontFamily: 'Inter',
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFFEDEDED),
    ),
    headline2: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFFEDEDED),
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFFEDEDED),
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFEDEDED),
    ),
    bodyText2: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFFEDEDED),
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: Color(0xFF171717),
  backgroundColor: Color(0xFF171717),
  splashColor: Color(0xFF444444),
  hoverColor: Colors.transparent,
  canvasColor: Color(0xFF171717),
  cardColor: Color(0xFF222222),
  buttonColor: Color(0xFF6F6F6F),
  dividerColor: Color(0xFF939393),
  scaffoldBackgroundColor: Color(0xFF171717),
  iconTheme: IconThemeData(
    color: Color(0xFF939393),
    size: 16.0,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Color(0xFF222222),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
  ),
);

final kThemeLight = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all<Color>(Color(0xFF939393)),
    interactive: true,
    isAlwaysShown: false,
  ),
  fontFamily: 'Inter',
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF171717),
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF171717),
    ),
    subtitle1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xFF171717),
    ),
    bodyText1: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Color(0xFF171717),
    ),
    bodyText2: TextStyle(
      fontSize: 8.0,
      fontWeight: FontWeight.w400,
      color: Color(0xFF171717),
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: Color(0xFFF5F5F5),
  backgroundColor: Color(0xFFF5F5F5),
  splashColor: Color(0xFF939393),
  canvasColor: Color(0xFFF5F5F5),
  cardColor: Color(0xFFEDEDED),
  buttonColor: Color(0xFF444444),
  dividerColor: Color(0xFF444444),
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  iconTheme: IconThemeData(
    color: Color(0xFF444444),
    size: 16.0,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Color(0xFFEDEDED),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
  ),
);
