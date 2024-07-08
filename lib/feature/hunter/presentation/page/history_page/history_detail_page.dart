import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/start_job/start_job_cubit.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/start_job/start_job_state.dart';
import 'package:mae_ban/feature/hunter/presentation/widget/status_widget.dart';

class HistoryDetailPage extends StatelessWidget {
  final String startJobId;

  const HistoryDetailPage({super.key, required this.startJobId});

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลเมื่อหน้าเพจถูกโหลดขึ้นมา
    context.read<StartJobCubit>().fetchStartJobDetail(startJobId);

    return Scaffold(
      backgroundColor: MColors.white,
      appBar: AppBar(
        title: Text('ລາຍລະອຽດ'),
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            context.go('/home-job-hunter', extra: {
              'initialTabIndex': 0,
              'initialActivityTabIndex': 1,
            });
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<StartJobCubit, StartJobState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.startJobDetail != null) {
            final jobDetail = state.startJobDetail;

            return ListView(
              padding: const EdgeInsets.all(16.0),
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
                TextColum(
                  title: 'ວັນທີຮັບບໍລິການ',
                  text: formatDateTime(jobDetail!['date_service'] ?? 'N/A'),
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
                  'ທີ່ຢູ',
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
                          '${jobDetail!['address']['province']}'
                          ", "
                          '${jobDetail!['address']['district']}'
                          ", "
                          '${jobDetail!['address']['village']}',
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
                      '${jobDetail!['place_type_name'] ?? 'N/A'}',
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
                      ' ${formatCurrency(jobDetail!['price'] ?? 'N/A')} LAK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            );
          } else if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: Text('ไม่มีข้อมูล'));
          }
        },
      ),
    );
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
}

class TextColum extends StatelessWidget {
  final String title;
  final String text;

  const TextColum({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Gap(5),
          Text(
            text,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
