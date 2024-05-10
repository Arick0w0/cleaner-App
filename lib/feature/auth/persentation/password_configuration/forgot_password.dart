import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/text_strings.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MTexts.forgotPassword),
      ),
      body: Center(
        child: Text(
          MTexts.forgotPassword,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
