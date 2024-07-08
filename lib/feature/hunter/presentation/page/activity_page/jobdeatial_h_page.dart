import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/widgets/confirmation_dialog.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/activity/booking_cubit.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/job_detail/job_detail_cubit.dart';
import 'package:mae_ban/feature/hunter/presentation/widget/status_widget.dart';
import 'package:mae_ban/feature/offer/presentation/screen/service_form_page/widgets/text_colum.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/footer_app.dart';

class JobDetailPage extends StatefulWidget {
  final String postJobId;

  const JobDetailPage({super.key, required this.postJobId});

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<JobDetailCubit>().fetchJobDetail(widget.postJobId);
  }

  String formatDateTime(String dateTimeStr) {
    final DateTime dateTime = DateTime.parse(dateTimeStr);
    final DateFormat formatter = DateFormat('dd-MM-yyyy (HH:mm)');
    return formatter.format(dateTime);
  }

  String formatHours(dynamic hours) {
    if (hours is int) {
      return hours.toString(); // ถ้าเป็น int ให้แสดงผลตามเดิม
    } else if (hours is double) {
      int hourPart = hours.truncate();
      int minutePart = ((hours - hourPart) * 60).round();
      return '$hourPart:${minutePart.toString().padLeft(2, '0')}';
    } else {
      throw ArgumentError('hours must be an int or a double');
    }
  }

  String formatCurrency(int number) {
    final format = NumberFormat("#,##0", "en_US");
    return format.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,
      appBar: AppBar(
        title: Text('ລາຍລະອຽດ'),
        leading: IconButton(
          onPressed: () => context.go('/home-job-hunter', extra: {
            'initialTabIndex': 0,
            'initialActivityTabIndex': 0,
          }),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<JobDetailCubit, JobDetailState>(
        builder: (context, state) {
          if (state is JobDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobDetailLoaded) {
            final jobDetail = state.jobDetail;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              children: [
                Row(
                  children: [
                    Text(
                      'ຄໍາສັ່ງຊື້ ',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 16),
                    ),
                    Text(
                      jobDetail!['bill_code'] ?? 'N/A',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextColum(
                      title: 'ວັນທີຮັບບໍລິການ',
                      text: formatDateTime(jobDetail!['date_service'] ?? 'N/A'),
                    ),
                    const Gap(10),
                    if (jobDetail['status'] == 'MATCH_HUNTER')
                      Text(
                        '*ກະລຸນາເດີນທາງເຖິງສະຖານທີກ່ອນໂມງ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: MColors.orange),
                      )
                    else if (jobDetail['status'] == 'CHOOSE_HUNTER')
                      Text(
                        '*ກະລຸນາລໍຖ້າການຍືນຍັນຈາກຜູ້ໃຊ້ບໍລິການ',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: MColors.orange),
                      ),
                  ],
                ),
                const Divider(),
                TextColum(
                  title: 'ໄລຍະເວລາ',
                  text: '${formatHours(jobDetail!['hours'] ?? 'N/A')} ຊມ.',
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ສະຖານະ',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Gap(10),
                      Status(
                        status: jobDetail!['status'] ?? 'N/A',
                      ),
                    ],
                  ),
                ),
                const Divider(),
                TextColum(
                  title: 'ຜູ້ຮັບບໍລິການ',
                  text: jobDetail!['first_name'] ?? 'N/A',
                ),
                const Divider(),
                Text(
                  'ທີ່ຢູ່',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${jobDetail?['address']['province']}'
                          ", "
                          '${jobDetail?['address']['district']}'
                          ", "
                          '${jobDetail?['address']['village']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Text(
                      '${jobDetail['place_type_name'] ?? 'N/A'}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ລາຄາບໍລິການ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ' ${formatCurrency(jobDetail['price'] ?? 'N/A')} LAK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            );
          } else if (state is JobDetailError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<JobDetailCubit, JobDetailState>(
        builder: (context, state) {
          if (state is JobDetailLoaded) {
            final jobDetail = state.jobDetail;
            if (jobDetail?['status'] == 'WAIT_HUNTER') {
              return FooterApp(
                title: 'ຕອບຮັບ',
                onPressed: () {
                  showConfirmationDialog(
                    context: context,
                    title: 'ທ່ານຕ້ອງການຕອບຮັບວຽກນີ້ແທ້ບໍ?',
                    content: 'ຕອບຮັບແລ້ວກະລຸນາລໍຖ້າການຍືນຍັນຈາກຜູ້ໃຊ້ບໍລິການ?',
                    onAccept: () {
                      context
                          .read<BookingCubit>()
                          .onAcceptBooking(jobDetail['bill_code']);
                      context.read<JobDetailCubit>().fetchJobDetail(
                          widget.postJobId); // Refetch job details
                    },
                  );
                },
              );
            }
            if (jobDetail?['status'] == 'MATCH_HUNTER') {
              // print("MATCH_HUNTER status detected."); // Debug print
              return FooterApp(
                title: 'ເລີ່ມວຽກ',
                onPressed: () {
                  // print("Button pressed."); // Debug print
                  // print(jobDetail!['start_job_id']);
                  context.push('/start-job', extra: jobDetail!['start_job_id']);
                },
              );
            }
          }
          return const SizedBox
              .shrink(); // Return empty widget if no job detail or status is not WAIT_HUNTER
        },
      ),
    );
  }
}
