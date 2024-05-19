import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/theme/widget_theme/appbar_theme.dart';
import 'package:mae_ban/core/theme/widget_theme/button_sheet_theme.dart';
import 'package:mae_ban/core/theme/widget_theme/elevated_button_theme.dart';
import 'package:mae_ban/core/theme/widget_theme/text_field_theme.dart';
import 'package:mae_ban/core/theme/widget_theme/text_theme.dart';

class MAppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'NotoSansLao',
    textTheme: MTextTheme.lightTextTheme,
    scaffoldBackgroundColor: MColors.primary,
    appBarTheme: MAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: MBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: MTextFormFieldTheme.lightInputDecorationTheme,
  );
}
