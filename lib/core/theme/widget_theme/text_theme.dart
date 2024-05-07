import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

// ignore: camel_case_types
class mTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Meticula',
      fontSize: 50,
      fontWeight: FontWeight.w400,
      color: mSecondaryColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Meticula',
      fontSize: 32,
      fontWeight: FontWeight.w900,
      color: mSecondaryColor,
    ),
    // titleMedium: TextStyle(
    //   fontFamily: 'Meticula',
    //   fontSize: 32,
    //   fontWeight: FontWeight.w800,
    //   color: mSecondaryColor,
    // ),
    bodyLarge: TextStyle(
      fontFamily: 'NotoSansLao',
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: mSecondaryColor,
    ),
  );
}
