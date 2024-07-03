import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class Status extends StatelessWidget {
  final String status;
  final bool showStatusText;

  const Status({
    Key? key,
    required this.status,
    this.showStatusText = false,
  }) : super(key: key);

  Color getStatusColor(String status) {
    switch (status) {
      case 'WAIT_HUNTER':
        return const Color(0xff613EEA);
      case 'WAIT_OFFER':
        return const Color(0xffFFBF06);
      case 'CHOOSE_HUNTER':
        return const Color(0xffFFBF06);
      case 'MATCH_OFFER':
        return const Color(0xff77E91E);
      case 'MATCH_HUNTER':
        return const Color(0xff77E91E);
      case 'NOT_MATCHED':
        return const Color(0xffF03975);
      case 'DONE':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'WAIT_HUNTER':
        return 'ຕອບຮັບບໍລການ';
      case 'WAIT_OFFER':
        return 'ລໍຖ້າການຕອບຮັບ';
      case 'CHOOSE_HUNTER':
        return 'ລໍຖ້າການຕອບຮັບ';
      case 'MATCH_OFFER':
        return 'ຕອບຮັບສຳເລັດ';
      case 'MATCH_HUNTER':
        return 'ຕອບຮັບສຳເລັດ';
      case 'NOT_MATCHED':
        return 'ບໍ່ຖືກຕອບຮັບ';
      case 'DONE':
        return 'ສຳເລັດ';
      default:
        return 'ບໍ່ຮູ້ຈັກ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.25;
        double fontSize = containerWidth * 0.12;

        if (containerWidth < 90) {
          containerWidth = 90;
          fontSize = 10;
        } else if (containerWidth > 100) {
          containerWidth = 100;
          fontSize = 12;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showStatusText)
              Text(
                'ສະຖານະ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const Gap(5),
            Container(
              width: containerWidth,
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
                        fontSize: fontSize,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
