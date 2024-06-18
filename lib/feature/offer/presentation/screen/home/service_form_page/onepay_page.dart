import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/feature/offer/presentation/screen/home/service_form_page/widgets/text_onepay.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile/address/widget/footer_app.dart';
import 'dart:convert';
import 'success_page.dart';

class OnePayPage extends StatelessWidget {
  final String billCode;
  final String dateTimeService;
  final double totalPrice;
  final String token;

  const OnePayPage({
    super.key,
    required this.billCode,
    required this.dateTimeService,
    required this.totalPrice,
    required this.token,
  });

  Future<void> submitJob(BuildContext context) async {
    final url = 'http://18.142.53.143:9393/api/v1/job/post-jop';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final payload = {
      "bill_code": billCode,
    };

    print('Headers: $headers');
    print('Payload: $payload');

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Job submitted successfully');
      print('Response data: $responseData');

      if (responseData['data'] == 'successfully') {
        // Print the data that will be passed to SuccessPage
        print('Post Job ID: ${responseData['post_job_Id']}');
        print('Bill Code: $billCode');
        print('DateTime Service: $dateTimeService');
        print('Total Price: $totalPrice');

        // แสดงหน้า SuccessPage เมื่อ data เป็น successfully
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessPage(
              postJobId: responseData['post_job_Id'],
              billCode: billCode,
              dateTimeService: dateTimeService,
              total: totalPrice,
              token: token, // Pass the token to SuccessPage
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to submit job: ${responseData['data']}')),
        );
      }
    } else {
      print('Failed to submit job');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit job')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');
    final formattedTotalPrice = formatter.format(totalPrice);

    print('OnePayPage built with:');
    print('billCode: $billCode');
    print('dateTimeService: $dateTimeService');
    print('totalPrice: $totalPrice');
    print('token: $token');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // ลบไอคอนย้อนกลับ
        backgroundColor: const Color(0xffB61C1C),
        title: const Text('OnePay '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 150,
                  child: Image.asset('assets/logo/onepay-01.jpeg'),
                )
              ],
            ),
            const Gap(20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Merchant:',
                  style: TextStyle(
                      color: Color(0xff7F8992),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'MAEBAN',
                  style: TextStyle(
                      color: Color(0xffB61C1C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Divider(),
            const TextOnePay(
              title: 'Address:',
              text: 'Hatsaiykhow, Sisattanak, Vientaine Capital',
            ),
            const Divider(),
            const TextOnePay(
              title: 'Description:',
              text: 'BUY_Service',
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Amount:'),
                Text(
                  '$formattedTotalPrice LAK',
                  style: const TextStyle(
                      color: Color(0xff098DE7),
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
      bottomNavigationBar: FooterApp(
        title: 'ຊໍາລະເງິນ',
        color: const Color(0xffB61C1C),
        onPressed: () {
          submitJob(context);
        },
      ),
    );
  }
}
