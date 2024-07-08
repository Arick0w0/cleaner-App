import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';

class PriceInfoCard extends StatelessWidget {
  final String price;
  final String vat;
  final String result;

  const PriceInfoCard({
    super.key,
    required this.price,
    required this.vat,
    required this.result,
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
              'ລາຍລະອຽດການຊໍາລະເງິນ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ລວມ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(price.toString() + " LAK"),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ພາສີມູນຄາເພີ່ມ 10%',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(vat.toString() + " LAK"),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ຍອດລວມທັງໝົດ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(result.toString() + " LAK"),
              ],
            ),
            const Gap(10),
            Text(
              'ລາຄານີ້ລວມອຸປະກອນ ນໍ້າຢາທໍາຄາວມສະອາດ ແລະ ຄາເດີນທາງແລ້ວ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
