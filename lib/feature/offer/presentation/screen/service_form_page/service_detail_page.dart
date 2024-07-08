import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/domain/usecases/generate_bill.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/generate_bill/billing_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/generate_bill/billing_state.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home_page/widget/footer_widget.dart';
import '../../../../auth/data/models/address_model.dart';
import 'widgets/contact_infocard.dart';
import 'widgets/price_info_card.dart';
import 'widgets/service_infocard.dart';
import 'payment_page.dart';
import '../profile_page/address/address_view.dart';

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

  @override
  Widget build(BuildContext context) {
    final double price = double.parse(widget.data['cost'].replaceAll(',', ''));
    final double vat = price * 0.10;
    final double total = price + vat;
    final NumberFormat formatter = NumberFormat('###,###', 'en_US');

    return Scaffold(
      appBar: AppBar(
        title: const Text('ບໍລິການທໍາຄວາມສະອາດ'),
      ),
      body: BlocListener<BillingCubit, BillingState>(
        listener: (context, state) {
          print('BlocListener received state: $state'); // Debug log
          if (state is BillingSuccess) {
            print('BillingSuccess state reached'); // Debug log
            print(
                'Navigating to PaymentPage with bill code: ${state.billCode}'); // Debug log

            // Show SnackBar immediately
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Bill generated successfully: ${state.billCode}'),
            //     backgroundColor: Colors.green,
            //   ),
            // );

            // Navigate to PaymentPage after showing SnackBar
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  billCode: state.billCode,
                  dateTimeService:
                      widget.data['date'] + ' ' + widget.data['time'],
                  total: total,
                  token: widget.token,
                ),
              ),
            ).then((_) {
              print('Returned from PaymentPage'); // Debug log
            });
          } else if (state is BillingFailure) {
            print(
                'BillingFailure state reached with error: ${state.error}'); // Debug log
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.error)),
            // );
          } else {
            print('State: $state'); // Debug log for other states
          }
        },
        child: BlocBuilder<BillingCubit, BillingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactInfoCard(
                      name:
                          '${widget.data['firstName']} ${widget.data['lastName']}',
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
                    // if (state is BillingLoading)
                    //   Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: FooterWidget(
        serviceCost: "${formatter.format(total)} LAK",
        onPressed: () {
          if (selectedAddress == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ກະລຸນນາເພີ່ມທີ່ຢູ່'),
                backgroundColor: MColors.orange,
              ),
            );
            return;
          }

          final params = BillingParams(
            serviceType: widget.data['serviceType'],
            date: widget.data['date'],
            time: widget.data['time'],
            price: total,
            hours: double.parse(
                widget.data['value'].toString()), // Ensure it's a double
            placeType: widget.data['codename'],
            address: selectedAddress!,
          );

          print('Executing generate bill'); // Debug log
          context.read<BillingCubit>().executeGenerateBill(params);
        },
      ),
    );
  }
}
