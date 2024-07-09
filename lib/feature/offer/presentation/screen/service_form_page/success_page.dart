import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/footer_app.dart';
// import '../../profile/address/widget/footer_app.dart';
import 'detail_page.dart'; // import DetailPage

class SuccessPage extends StatelessWidget {
  final String postJobId;
  final String billCode;
  final String dateTimeService;
  final double total;
  final String token; // Add token

  const SuccessPage({
    Key? key,
    required this.postJobId,
    required this.billCode,
    required this.dateTimeService,
    required this.total,
    required this.token, // Add token
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');
    final formattedTotal = formatter.format(total);

    return Scaffold(
      backgroundColor: MColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // ลบไอคอนย้อนกลับ
        title: const Text('ຈ່າຍເງິນ ສໍາເລັດ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text('dataTimeService: $postJobId'),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/logo/success01.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const Gap(25),
            Text(
              'ຈ່າຍເງິນ ສໍາເລັດ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const Gap(200),
            const Divider(
              color: Colors.grey,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('ລະຫັດໃບບິນ:'),
                    Text(
                      billCode,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('ວັນທີຮັບບໍລິການ:'),
                    Text(
                      dateTimeService,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('ຈໍານວນເງິນ:'),
                    Text(
                      '$formattedTotal LAK',
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xffCA090C)),
                    ),
                  ],
                ),
                const Gap(20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ຮູບແບບຊໍາລະ:'),
                    Text(
                      'ທະນະຄານການຄ້າ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterApp(
        title: 'ສໍາເລັດ',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                postJobId: postJobId,
              ),
            ),
          );
        },
      ),
    );
  }
}
