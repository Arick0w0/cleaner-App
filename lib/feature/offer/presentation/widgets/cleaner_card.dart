import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/size.dart';

class CleanerCard extends StatelessWidget {
  final String name;
  final String imageProfile;
  final String image;

  const CleanerCard({
    super.key,
    required this.name,
    required this.imageProfile,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      // height: 300,
      // color: Colors.amber,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              width: 190,
              height: 154,
              image.isNotEmpty ? image : 'assets/mock/mock04.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Gap(MSize.spaceBtwItems),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: MSize.spaceBtwItems),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ສະອາດ ຮຽບຮ້ອຍ ຕົງເວລາ ໄວໃຈລັດຕະນາໄດ້',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(MSize.spaceBtwItems),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          imageProfile.isNotEmpty
                              ? imageProfile
                              : 'assets/mock/mock02.png',
                          fit: BoxFit.cover,
                          scale: 1.0,
                        ),
                      ),
                    ),
                    const Gap(MSize.spaceBtwItems),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Row(children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                Text(
                                  '5.0',
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ])
                            ],
                          ),
                          Text('3 ຣີວິວ - ນະຄອນຫຼວງວຽງຈັນ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Color(0xffA3ABB6))),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
