// lib/core/theme/widget_theme/bottom_sheet_theme.dart

import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class CustomBottomSheetTheme {
  static BottomSheetThemeData get theme {
    return BottomSheetThemeData(
      backgroundColor: MColors.white, // Customize background color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}
