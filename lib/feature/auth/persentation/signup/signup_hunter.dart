import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/text_strings.dart';

class SignUpHunterPage extends StatelessWidget {
  const SignUpHunterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MTexts.signUpHunter),
      ),
    );
  }
}
