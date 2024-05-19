import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/persentation/widgets/password_text_form_field.dart';

class PasswordMatch extends StatelessWidget {
  const PasswordMatch({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordTextFormField(
          controller: passwordController,
          labelText: MTexts.password,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          showSuffixIcon:
              true, // Set to false if you don't want to show the icon
          icon: const Icon(Icons.lock), // Example icon
          error: 'Please enter a password',
        ),
        const Gap(MSize.spaceBtwItems),
        PasswordTextFormField(
          controller: confirmPasswordController,
          labelText: MTexts.confirmPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          showSuffixIcon:
              true, // Set to false if you don't want to show the icon
          icon: const Icon(Icons.lock), // Example icon
          error: 'Please confirm your password',
        ),
      ],
    );
  }
}
