import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home/widget/footer_widget.dart';
import '../../profile/address/address_view.dart';
import 'widgets/contact_infocard.dart';
import 'widgets/price_info_card.dart';
import 'widgets/service_infocard.dart';
import 'package:intl/intl.dart';
import '../../../../../auth/data/models/address_model.dart';
import 'dart:convert';
import 'payment_page.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String userId;
  final String token;

  const ServiceDetailScreen({
    required this.data,
    required this.userId,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  Address? selectedAddress;

  Future<void> generateBill() async {
    final url = 'http://18.142.53.143:9393/api/v1/job/generate-bill-code';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
    };

    final double total =
        double.parse(widget.data['cost'].replaceAll(',', '')) * 1.10;

    final payload = {
      "service_type": widget.data['serviceType'],
      "date_service_input": widget.data['date'],
      "time_service_input": widget.data['time'],
      "price_service_input": total.toInt(), // ส่ง total แทน
      "hours_service_input": widget.data['value'],
      "place_type": widget.data['codename'],

      "address": {
        "address_name": selectedAddress?.addressName ?? '',
        "village": selectedAddress?.village ?? '',
        "district": selectedAddress?.district ?? '',
        "province": selectedAddress?.province ?? '',
        "google_map": selectedAddress?.googleMap ?? ''
      }
    };

    // print('Headers: $headers');
    print('Payload: $payload');

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // print(responseData);
      if (responseData['error'] == false &&
          responseData['msg'] == 'DONT_HAVE_THIS_AREA') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ບໍ່ມີພື້ນທີໃຫ້ບໍລິການ')),
        );
      } else {
        debugPrint('Bill generated successfully'); // Print to debug console

        print(responseData['data']);
        // Print the data that will be passed to PaymentPage
        // print('Bill Code: ${responseData['data']['your_bill_code']}');
        // print(
        //     'DateTime Service: ${widget.data['date']} ${widget.data['time']}');
        // print('Total Price: $total');
        // print('Token: ${widget.token}');

        // Navigate to PaymentPage with the received data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              billCode: responseData['data']['your_bill_code'],
              dateTimeService: widget.data['date'] + ' ' + widget.data['time'],
              total: total,
              token: widget.token,
            ),
          ),
        );
      }
    } else {
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate bill')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double price = double.parse(widget.data['cost'].replaceAll(',', ''));
    final double vat = price * 0.10;
    final double total = price + vat;
    final NumberFormat formatter = NumberFormat(
      '###,###',
      'en_US',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ບໍລິການທໍາຄວາມສະອາດ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContactInfoCard(
                name: '${widget.data['firstName']} ${widget.data['lastName']}',
                phoneNumber: widget.data['phone'],
                onPresseds: () async {
                  final selected = await Navigator.push<Address>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressView(
                        userId: widget.userId,
                        token: widget.token,
                      ),
                    ),
                  );

                  if (selected != null) {
                    setState(() {
                      selectedAddress = selected;
                    });
                    print("Selected Address: $selected");
                  }
                },
                address: selectedAddress,
              ),
              const SizedBox(height: 16),
              ServiceInfoCard(
                service: widget.data['serviceType'],
                date: widget.data['date'] + ' ' + widget.data['time'],
                units: widget.data['units'],
              ),
              const SizedBox(height: 16),
              PriceInfoCard(
                price: formatter.format(price),
                vat: formatter.format(vat),
                result: formatter.format(total),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(
        serviceCost: "${formatter.format(total)} LAK",
        onPressed: () {
          if (selectedAddress == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'ກະລຸນນາເພີ່ມທີ່ຢູ່',
                ),
                backgroundColor: MColors.orange,
              ),
            );
            return;
          }
          generateBill();
        },
      ),
    );
  }
}
