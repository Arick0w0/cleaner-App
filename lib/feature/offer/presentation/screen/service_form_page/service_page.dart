import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/price/price_event.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/price/price_state.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/selection/selection_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/selection/selection_state.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/time/time_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/time/time_state.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home_page/widget/field_container.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home_page/widget/footer_widget.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home_page/widget/selection_modal.dart';
import 'package:mae_ban/feature/offer/domain/entities/price.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/price/price_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/service_locator.dart' as di;

import 'service_detail_page.dart';
import 'widgets/date_picker_widget.dart';
import 'widgets/time_picker_widget.dart';

// service_form_page.dart

class ServiceFormPage extends StatefulWidget {
  final ServiceType service;

  const ServiceFormPage({
    required this.service,
    Key? key,
  }) : super(key: key);

  @override
  _ServiceFormPageState createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  List<Price> prices = [];

  @override
  void initState() {
    super.initState();
  }

  void _showSelectionModal(BuildContext context, String currentValue,
      List<String> items, ValueChanged<String> onSelected,
      {List<String>? recs}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SelectionModal(
          initialSelectedValue: currentValue,
          onSelected: (value) {
            onSelected(value);
            Navigator.pop(context);
          },
          items: items,
          recs: recs ?? [], // กำหนดค่าเริ่มต้นให้ recs ถ้าไม่ได้ส่งมา
        );
      },
    );
  }

  String formatPrice(int price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price);
  }

  Future<void> _handleSubmit(
      BuildContext context, SelectionState selectionState) async {
    final userCubit = context.read<UserCubit>();
    final localStorageService = LocalStorageService();
    final token =
        await localStorageService.getToken(); // ดึง token จาก SharedPreferences

    if (userCubit.state is UserLoaded) {
      final user = (userCubit.state as UserLoaded).user;

      if (selectionState.serviceCost == '0' ||
          selectionState.selectedTime == TimeOfDay(hour: 0, minute: 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.amber,
            content: Text('ກະລຸນາເລືອກປະເພດທີ່ພັກ ແລະ ເວລາ'),
          ),
        );

        return;
      }

      final formData = {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'phone': user.phone,
        'serviceType': widget.service.serviceType,
        'location': selectionState.selectedLocation,
        'type': selectionState.selectedType,
        'units': selectionState.selectedUnits,
        'value': selectionState.selectedValue,
        'date': DateFormat('yyyy-MM-dd').format(selectionState.selectedDate),
        'time': selectionState.selectedTime.format(context),
        'cost': selectionState.serviceCost,
        'userId': user.id,
        'token': token ?? '',
        'codename': selectionState.codename, // Add codename to formData
      };

      print('Form Data: $formData');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceDetailScreen(
            data: formData,
            userId: user.id,
            token: token ?? '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data is not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<SelectionCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<PriceBloc>()..add(FetchPrices()),
        ),
        BlocProvider(
          create: (context) => di.sl<TimeCubit>()..fetchTimes(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('ບໍລິການທໍາຄວາມສະອາດ'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('ເບິງລາຍລະອຽດ',
                  style: TextStyle(color: Colors.white)),
            ),
            const Gap(10)
          ],
        ),
        body: BlocBuilder<PriceBloc, PriceState>(
          builder: (context, priceState) {
            if (priceState is PriceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (priceState is PriceLoaded) {
              prices = priceState.prices;
              return BlocBuilder<TimeCubit, TimeState>(
                builder: (context, timeState) {
                  if (timeState is TimeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (timeState is TimeLoaded) {
                    final times =
                        timeState.times.map((time) => time.time).toList();
                    return BlocBuilder<SelectionCubit, SelectionState>(
                      builder: (context, selectionState) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                Text('ເລືອກສະຖານທີໃຊ້ບໍລິການ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const Gap(8),
                                FieldContainer(
                                  text: selectionState.selectedLocation,
                                  callback: () => _showSelectionModal(
                                    context,
                                    selectionState.selectedLocation,
                                    ['ນະຄອນຫຼວງວຽງຈັນ'],
                                    (value) {
                                      context
                                          .read<SelectionCubit>()
                                          .updateLocation(value);
                                    },
                                  ),
                                ),
                                const Gap(25),
                                Text(
                                    'ກະລຸນາເລືອກປະເພດທີ່ພັກ ເພື່ອໃຫ້ເຮົາຊ່ວຍປະເມີນໄລຍະເວລາທໍາຄວາມສະອາດແລະ ຄ່າບໍລິການ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const Gap(8),
                                FieldContainer(
                                  text: selectionState.selectedType,
                                  callback: () => _showSelectionModal(
                                    context,
                                    selectionState.selectedType,
                                    prices.map((price) => price.name).toList(),
                                    (value) {
                                      final selectedPrice = prices.firstWhere(
                                          (price) => price.name == value);
                                      context
                                          .read<SelectionCubit>()
                                          .updateType(value);
                                      print('type: $value');
                                      print(
                                          'codeName: ${selectedPrice.codeName}'); // Print codeName
                                      // Additional logic can be added here
                                    },
                                    recs: prices
                                        .map((price) => price.rec)
                                        .toList(), // Sending rec data
                                  ),
                                ),
                                const Gap(8),
                                FieldContainer(
                                  text: selectionState.selectedUnits,
                                  callback: () => _showSelectionModal(
                                    context,
                                    selectionState.selectedUnits,
                                    times,
                                    (value) {
                                      final selectedTime = timeState.times
                                          .firstWhere(
                                              (time) => time.time == value);
                                      context
                                          .read<SelectionCubit>()
                                          .updateUnits(
                                            value,
                                            selectedTime.value,
                                          );
                                      // print(
                                      //     'Updated Units: $value'); // Print the updated units
                                      // print(
                                      //     'Updated Value: ${selectedTime.value}'); // Print the updated value
                                    },
                                  ),
                                ),
                                const Gap(8),
                                const Text('*  ບໍ່ລວມເວລາພັກຂອງຜູ້ໃຫ້ບໍລິການ',
                                    style: TextStyle(color: Colors.orange)),
                                const Gap(25),
                                Text('ເລືອກວັນທີ ແລະ ເວລາ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const Gap(8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DatePickerWidget(
                                        selectedDate:
                                            selectionState.selectedDate,
                                        onDateSelected: (date) {
                                          context
                                              .read<SelectionCubit>()
                                              .updateDate(date);
                                        },
                                      ),
                                    ),
                                    const Gap(16),
                                    Expanded(
                                      child: TimePickerWidget(
                                        selectedDate:
                                            selectionState.selectedDate,
                                        selectedTime:
                                            selectionState.selectedTime,
                                        onTimeSelected: (time) {
                                          context
                                              .read<SelectionCubit>()
                                              .updateTime(time);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (timeState is TimeError) {
                    return Center(child: Text(timeState.message));
                  } else {
                    return const Center(child: Text('No times available'));
                  }
                },
              );
            } else if (priceState is PriceError) {
              return Center(child: Text(priceState.message));
            } else {
              return const Center(child: Text('No prices available'));
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<SelectionCubit, SelectionState>(
          builder: (context, selectionState) {
            return FooterWidget(
              serviceCost: "${selectionState.serviceCost} LAK",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _handleSubmit(context, selectionState);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
