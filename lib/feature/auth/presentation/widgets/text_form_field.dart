import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final String errorText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType; // Add this line
  final String prefix; // Add this line

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.errorText,
    this.keyboardType = TextInputType.text, // Default to text if not provided
    this.validator,
    this.prefix = '', // Default prefix to empty string
  }) {
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
    );
  }
}
