import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class BookingInfoWidget extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String image;

  const BookingInfoWidget({
    Key? key,
    required this.name,
    required this.date,
    required this.time,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                width: 60,
                height: 60,
                image.isNotEmpty ? image : 'assets/mock/mock05.png',
                fit: BoxFit.cover,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16),
                  ),
                  const Gap(5),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MColors.dark,
                        ),
                  ),
                  const Gap(5),
                  Text(
                    ('$time ຊມ'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
