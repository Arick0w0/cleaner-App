import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class FieldContainerMD extends StatelessWidget {
  final String data;
  final IconData icon;
  final VoidCallback onTap;
  const FieldContainerMD({
    super.key,
    required this.data,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 175,
        height: 50,
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
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Icon(
                icon,
                color: MColors.grey,
              ),
              // Icon(Icons.calendar_month_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
