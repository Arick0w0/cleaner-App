import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

// ignore: camel_case_types
class MTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    // displayLarge: const TextStyle().copyWith(
    //   fontFamily: 'Meticula',
    //   fontSize: 50.0,
    //   fontWeight: FontWeight.w900,
    //   color: MColors.secondary,
    // ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: MColors.secondary,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: MColors.dark,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: MColors.secondary,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: MColors.lightgrey,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: MColors.lightgrey,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: MColors.lightgrey,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: MColors.secondary,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: MColors.dark,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: MColors.white,
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: MColors.lightgrey,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: MColors.lightgrey,
    ),
  );
}
