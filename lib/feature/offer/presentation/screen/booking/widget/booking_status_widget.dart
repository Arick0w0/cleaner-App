import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class BookingStatusWidget extends StatelessWidget {
  final String status;

  BookingStatusWidget({required this.status});

  Color getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return Colors.purple;
      case 'select cleaner':
        return Colors.blue;
      case 'accept':
        return Colors.yellow;
      case 'success':
        return Colors.green;
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'สถานะ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Gap(5),
        SizedBox(
          width: 110,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: getStatusColor(status),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                status,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: MColors.white,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
