import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:mae_ban/feature/offer/domain/usecases/submit_job.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/job_post/job_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/job_post/job_state.dart';
import 'package:mae_ban/feature/offer/presentation/screen/service_form_page/widgets/text_onepay.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/footer_app.dart';
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

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');
    final formattedTotalPrice = formatter.format(totalPrice);

    // print('OnePayPage built with:');
    // print('billCode: $billCode');
    // print('dateTimeService: $dateTimeService');
    // print('totalPrice: $totalPrice');
    // print('token: $token');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back icon
        backgroundColor: const Color(0xffB61C1C),
        title: const Text('OnePay'),
      ),
      body: BlocListener<JobCubit, JobState>(
        listener: (context, state) {
          if (state is JobSuccess) {
            print('Job submitted successfully!');
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Job submitted successfully!'),
            //     backgroundColor: Colors.green,
            //   ),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessPage(
                  postJobId: state.postJobId, // Pass the appropriate data
                  billCode: billCode,
                  dateTimeService: dateTimeService,
                  total: totalPrice,
                  token: token,
                ),
              ),
            );
          } else if (state is JobFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
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
                    'MAE BAN',
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
                text: 'Thatluangkang, Xaysettha, Vientian Capital',
              ),
              const Divider(),
              const TextOnePay(
                title: 'Description:',
                text: 'BUY_SERVICE',
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Amount:'),
                  Text(
                    '$formattedTotalPrice LAK',
                    style: const TextStyle(
                        color: Color(0xff098DE7),
                        fontSize: 28,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterApp(
        title: 'ຊໍາລະເງິນ',
        color: const Color(0xffB61C1C),
        onPressed: () {
          final params = SubmitJobParams(
            billCode: billCode,
            token: token,
          );
          context.read<JobCubit>().executeSubmitJob(params);
        },
      ),
    );
  }
}
