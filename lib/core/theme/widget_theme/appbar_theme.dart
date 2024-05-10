import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class MAppBarTheme {
  MAppBarTheme._();
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: MColors.accent,
    // backgroundColor: Colors.transparent,
    surfaceTintColor: MColors.accent,
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
      fontFamily: 'NotoSansLao',
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
