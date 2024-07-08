import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/job_detail/job_detail_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/choose_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/star_job_offer_page.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/footer_app.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/widget/booking_status_widget.dart';
import 'widgets/text_colum.dart';

class DetailPage extends StatefulWidget {
  final String postJobId;

  const DetailPage({super.key, required this.postJobId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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

  String formatCurrency(int number) {
    final format = NumberFormat("#,##0", "en_US");
    return format.format(number);
  }

  String formatHours(dynamic hours) {
    if (hours is int) {
      return hours.toString(); // If int, show as is
    } else if (hours is double) {
      int hourPart = hours.truncate();
      int minutePart = ((hours - hourPart) * 60).round();
      return '$hourPart:${minutePart.toString().padLeft(2, '0')}';
    } else {
      throw ArgumentError('hours must be an int or a double');
    }
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = Config.s3BaseUrl;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ການຈອງຂອງຂ້ອຍ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go('/home-job-offer', extra: {
            'initialTabIndex': 1,
            'initialActivityTabIndex': 0,
          }),
        ),
      ),
      body: BlocBuilder<JobDetailCubit, JobDetailState>(
        builder: (context, state) {
          if (state is JobDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobDetailLoaded) {
            final jobData = state.jobDetail;
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          jobData['bill_code'] ?? 'N/A',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ປະເພດບໍລິການ',
                      text: jobData['service_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ປະເພດທີພັກ',
                      text: jobData['place_type_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ວັນທີຮັບບໍລິການ',
                      text: formatDateTime(jobData['date_service'] ?? 'N/A'),
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ໄລຍະເວລາ',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Text(
                              formatHours(jobData['hours']),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ' ຊມ.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ຜູ້ໃຫ້ບໍລິການ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (jobData['status'] == 'CHOOSE_HUNTER') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChoosePage(
                                    postJobId: widget.postJobId,
                                    billCode: jobData['bill_code'],
                                  ),
                                ),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    jobData['chosen_job_hunter'] != null &&
                                            jobData['chosen_job_hunter']
                                                    ['image_profile'] !=
                                                null &&
                                            jobData['chosen_job_hunter']
                                                    ['image_profile']
                                                .isNotEmpty
                                        ? baseUrl +
                                            jobData['chosen_job_hunter']
                                                ['image_profile']
                                        : 'assets/mock/human.png',
                                    // width: 80,
                                    // height: 80,
                                    scale: 1.0,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                          'assets/mock/human.png',
                                          fit: BoxFit.fill);
                                    },
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobData['chosen_job_hunter'] != null &&
                                            jobData['chosen_job_hunter']
                                                    ['first_name'] !=
                                                null &&
                                            jobData['chosen_job_hunter']
                                                    ['first_name']
                                                .isNotEmpty
                                        ? jobData['chosen_job_hunter']
                                            ['first_name']
                                        : 'ເລືອກຜູ້ໃຫ້ບໍລິການທີ່ທ່ານຕ້ອງການ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: MColors.black,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    jobData['chosen_job_hunter']
                                            ['customer_code'] ??
                                        'ID',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: MColors.black,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const Gap(10),
                                  BookingStatusWidget(
                                    status: jobData['status'] ?? 'N/A',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        TextColum(
                          title: 'ຜູ້ຮັບບໍລິການ',
                          text: jobData['first_name'] ?? 'N/A',
                        ),
                      ],
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
                    Row(
                      children: [
                        Text(
                          '${jobData['address']['province']}, ${jobData['address']['district']}, ${jobData['address']['village']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ສະຫຼຸບຍອດລວມທັ້ງໝົດ',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ຍອດລວມ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(
                                  formatCurrency(jobData['price']),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ' LAK',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            final jobData = state.jobDetail;
            if (jobData['status'] == 'MATCH_HUNTER') {
              return FooterApp(
                title: 'ຕິດຕາມວຽກ',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartJobOffer(
                        startJobId: jobData['start_job_id'],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
