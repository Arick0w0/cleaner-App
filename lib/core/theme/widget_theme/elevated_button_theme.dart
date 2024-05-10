import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';

class MElevatedButtonTheme {
  MElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: MColors.light,
      backgroundColor: MColors.accent,
      disabledForegroundColor: MColors.primary,
      disabledBackgroundColor: MColors.primary,
      side: const BorderSide(color: MColors.accent),
      padding: const EdgeInsets.symmetric(vertical: MSize.buttonHeight),
      textStyle: const TextStyle(
          fontFamily: 'NotoSansLao',
          fontSize: 18,
          color: MColors.secondary,
          fontWeight: FontWeight.w900),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MSize.buttonRadius),
      ),
    ),
  );
}
