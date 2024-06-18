import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class FooterApp extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  const FooterApp({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MColors.accent,
      // padding: EdgeInsets.all(16),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          // clipBehavior: Clip.none,

          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            // shape: const StadiumBorder(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: onPressed,
          child: Text(title),
        ),
      ),
    );
  }
}
