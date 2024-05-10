import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class MTextFormFieldTheme {
  MTextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    // prefixIconColor: Colors.grey,
    prefixIconColor: MColors.secondary,
    suffixIconColor: Colors.grey,
    labelStyle:
        const TextStyle().copyWith(fontSize: 14, color: MColors.secondary),
    hintStyle:
        const TextStyle().copyWith(fontSize: 14, color: MColors.secondary),
    floatingLabelBehavior: FloatingLabelBehavior.never, // text animations
    // isCollapsed: true,
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: MColors.secondary.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.black12),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: Colors.orange),
    ),
  );
}
