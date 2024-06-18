import 'package:flutter/material.dart';

class TextOnePay extends StatelessWidget {
  final String title;
  final String text;
  const TextOnePay({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff7F8992),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xff000000),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
