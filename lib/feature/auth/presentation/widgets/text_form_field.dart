import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mae_ban/core/constants/text_strings.dart';

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
  final bool enableDatePicker;
  final VoidCallback? onTap;
  final bool usePrefix;
  final bool useMaxLength;
  final int maxLength;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.errorText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enableDatePicker = false,
    this.onTap,
    this.usePrefix = false,
    this.useMaxLength = false,
    this.maxLength = 8,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        prefixText: usePrefix ? '20 ' : null, // Show prefix 20
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        if (useMaxLength && value.length != maxLength) {
          // return 'ກະລຸນາປ່ອນເບີໂທຂອງທ່ານໃຫ້ຄົບ  $maxLength ';
          return MTexts.plsenterphonenumber;
        }
        return validator?.call(value);
      },
      keyboardType: keyboardType,
      inputFormatters: [
        if (useMaxLength) LengthLimitingTextInputFormatter(maxLength),
        if (enableDatePicker) DateTextInputFormatter(),
      ],
      onTap: onTap,
    );
  }
}
