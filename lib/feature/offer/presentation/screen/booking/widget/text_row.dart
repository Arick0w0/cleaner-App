import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class TextRow extends StatelessWidget {
  final String title;
  final String text;
  const TextRow({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title :',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500, color: MColors.accent),
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: 14, color: MColors.black),
        )
      ],
    );
  }
}
