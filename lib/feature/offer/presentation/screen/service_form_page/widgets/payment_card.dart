import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class PayMent extends StatelessWidget {
  final String title;
  final String image;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  const PayMent({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // color: Colors.amber,
                ),
                child: ClipOval(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover, // ให้รูปภาพเต็มพื้นที่
                  ),
                ),
              ),
              const Gap(10),
              Text(
                title,
              ),
            ],
          ),
          Radio<int>(
            // hoverColor: MColors.accent,
            // fillColor: MaterialStateProperty.all(MColors.accent),
            activeColor: MColors.accent,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
