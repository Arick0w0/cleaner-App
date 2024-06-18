import 'package:flutter/material.dart';

class TextColum extends StatelessWidget {
  final String title;
  final String text;
  const TextColum({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(text),
      ],
    );
  }
}
