import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/theme/widget_theme/text_theme.dart';

class MAppTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: mTextTheme.lightTextTheme,
    scaffoldBackgroundColor: mPrimaryColor,
  );
}
