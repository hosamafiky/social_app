// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/components/constants.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Metropolis',
  primarySwatch: kPrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.1,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: kPrimaryColor,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
    elevation: 40.0,
  ),
);
ThemeData darkTheme = ThemeData(
  fontFamily: 'Metropolis',
  primarySwatch: kPrimaryColor,
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff333739),
          statusBarIconBrightness: Brightness.light),
      color: Color(0xff333739),
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xff333739),
    selectedItemColor: kPrimaryColor,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
    elevation: 40.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3),
  ),
);
