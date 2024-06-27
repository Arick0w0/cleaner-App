import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class BookingStatusWidget extends StatelessWidget {
  final String status;
  final bool showStatusText;

  const BookingStatusWidget({
    Key? key,
    required this.status,
    this.showStatusText = false,
  }) : super(key: key);

  Color getStatusColor(String status) {
    switch (status) {
      case 'WAIT_HUNTER':
        return const Color(0xffFFBF06);
      case 'CHOOSE_HUNTER':
        return const Color(0xff613EEA);
      case 'MATCH_HUNTER':
        return const Color(0xff77E91E);
      case 'DONE':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'WAIT_HUNTER':
        return 'ລໍຖ້າການຕອບຮັບ';
      case 'CHOOSE_HUNTER':
        return 'ເລືອກຜູ້ໃຫ້ບໍລິການ';
      case 'MATCH_HUNTER':
        return 'ຕອບຮັບ';
      case 'DONE':
        return 'ສຳເລັດ';
      default:
        return 'ບໍ່ຮູ້ຈັກ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showStatusText)
          Text(
            'ສະຖານະ',
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
                getStatusText(status),
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
