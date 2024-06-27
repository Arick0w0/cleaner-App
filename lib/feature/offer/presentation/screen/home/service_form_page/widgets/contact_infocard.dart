import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import '../../../../../../auth/data/models/address_model.dart';

class ContactInfoCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final VoidCallback? onPresseds;
  final Address? address;

  const ContactInfoCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.onPresseds,
    this.address,
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
              'ຂໍ້ມູ້ນການຕິດຕໍ່',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name),
                Text(phoneNumber),
              ],
            ),
            const Gap(16),
            Text(
              'ສະຖານທີ່ໃຊ້ບໍລິການ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(14),
            if (address != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${address!.addressName},  ${address!.village}',
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              1, // จำนวนบรรทัดสูงสุดที่จะแสดง (เลือกได้ตามความต้องการ)
                        ),
                        // Text('  ${address!.province}'),
                        // Text('  ${address!.googleMap}'),
                        // Text(' ${address!.village},'),
                        // Text(' ${address!.district},'),
                      ]),
                  InkWell(
                    onTap: onPresseds,
                    child: Text(
                      'ແກ້ໄຂ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: MColors.accent),
                    ),
                  ),
                ],
              ),
            const Gap(14),
            if (address == null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onPresseds,
                  icon: const Icon(
                    Icons.add_box_outlined,
                    size: 18,
                    color: MColors.grey,
                  ),
                  label: Text(
                    'ເພີ່ມທີ່ຢູ່ໃໝ່',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                    side: const BorderSide(color: Colors.grey, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
