import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text
        .replaceAll(RegExp(r'[^0-9]'), ''); // Remove non-digit characters
    if (text.length > 8) return oldValue; // Limit to 8 digits (ddmmyyyy)

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) buffer.write('-');
      buffer.write(text[i]);
    }

    final newText = buffer.toString();
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final String errorText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final String prefix;
  final bool enableDatePicker; // Add this line to enable/disable the formatter
  final VoidCallback? onTap;

  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.errorText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefix = '',
    this.enableDatePicker = false,
    this.onTap,
  }) : super(key: key) {
    // Initialize the controller with the prefix
    controller.text = prefix;
    controller.addListener(() {
      // Ensure the prefix is maintained
      if (!controller.text.startsWith(prefix)) {
        final cursorPosition = controller.selection;
        controller.text = prefix + controller.text.replaceFirst(prefix, '');
        controller.selection = cursorPosition.copyWith(
          baseOffset: cursorPosition.baseOffset + prefix.length,
          extentOffset: cursorPosition.extentOffset + prefix.length,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value == prefix) {
          return errorText;
        }
        return validator?.call(value);
      },
      keyboardType: keyboardType,
      inputFormatters: enableDatePicker
          ? [DateTextInputFormatter(), LengthLimitingTextInputFormatter(10)]
          : null,
      onTap: onTap,
    );
  }
}
