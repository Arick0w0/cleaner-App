import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: MColors.secondary,
      ),
    ));
  }
}
