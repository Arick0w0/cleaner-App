import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/feature/offer/presentation/screen/service_form_page/widgets/payment_card.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/footer_app.dart';
import 'onepay_page.dart'; // import OnePayPage

class PaymentPage extends StatefulWidget {
  final String billCode;
  final String dateTimeService;
  final double total;
  final String token;

  const PaymentPage({
    required this.billCode,
    required this.dateTimeService,
    required this.total,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###');
    final formattedTotal = formatter.format(widget.total);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false, //
        title: const Text('ຊໍາລະເງິນ'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ຄໍາສັ່ງຊື້ ${widget.billCode}'),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ວັນທີຮັບບໍລິການ'),
                        Text(widget.dateTimeService),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ຍອດລວມທີຕ້ອງຈ່າຍ'),
                        Text('$formattedTotal LAK'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(40),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ຮູບການຊໍາລະ'),
                    const Gap(25),
                    PayMent(
                      image: 'assets/logo/onepay.jpg',
                      title: 'BCEL - ທະນະຄານການຄ້າ',
                      value: 1,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    const Gap(25),
                    PayMent(
                      image: 'assets/logo/jdb.jpeg',
                      title: 'JDB - ທະນາຄານຮ່ວມພັດທະນາ ',
                      value: 2,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    const Gap(25),
                    PayMent(
                      image: 'assets/logo/ldb.jpeg',
                      title: 'LDB - ທະນາຄານພັດທະນາລາວ',
                      value: 3,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterApp(
        title: 'ຊໍາລະເງິນ',
        onPressed: () {
          if (_selectedPaymentMethod == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnePayPage(
                  billCode: widget.billCode,
                  dateTimeService: widget.dateTimeService,
                  totalPrice: widget.total,
                  token: widget.token,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
