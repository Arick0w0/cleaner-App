import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class mInputDecorationTheme {
  _border([Color color = MColors.secondary]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
}
