import 'package:flutter/material.dart';

class FieldContainer extends StatelessWidget {
  final String text;
  final String height;
  final VoidCallback callback;

  const FieldContainer({
    super.key,
    required this.text,
    required this.callback,
    this.height = "46",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.infinity,
        height: height == null ? 46 : double.parse(height),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
              8.0), // Adjust padding value or use your custom MSize.defaultPadding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Icon(Icons.keyboard_arrow_down_rounded),
              // const Icon(CupertinoIcons.chevron_down),
            ],
          ),
        ),
      ),
    );
  }
}
