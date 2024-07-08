import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TextColum extends StatelessWidget {
  final String title;
  final String text;
  const TextColum({
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
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Gap(10),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
