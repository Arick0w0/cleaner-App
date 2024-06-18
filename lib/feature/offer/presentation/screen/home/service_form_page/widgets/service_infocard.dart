import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class ServiceInfoCard extends StatelessWidget {
  final String service;
  final String date;
  final String units;

  ServiceInfoCard({
    required this.service,
    required this.date,
    required this.units,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: MColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ຂໍ້ມູ້ນບໍລິການ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ບໍລິການ:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: MColors.accent, fontSize: 14),
                ),
                Text(service),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ກໍານົດການ:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: MColors.accent, fontSize: 14),
                ),
                Text(date),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ໄລຍະເວລາ:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: MColors.accent, fontSize: 14),
                ),
                Text(units),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
