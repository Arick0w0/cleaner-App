import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class SearchBars extends StatelessWidget {
  final VoidCallback? onTap;

  const SearchBars({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Make it responsive
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10), // Simplify padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              size: 30,
              color: MColors.grey, // Ensure correct color constant
            ),
            const Gap(10),
            Text(
              'ຄົ້ນຫາ', // "Search" in Lao language
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
