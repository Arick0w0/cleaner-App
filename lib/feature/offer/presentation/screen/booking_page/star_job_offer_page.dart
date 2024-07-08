import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/start_job/start_job_cubit.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/start_job/start_job_state.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/countdown/countdown_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/widget/text_row.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/footer_app.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class StartJobOffer extends StatefulWidget {
  final String startJobId;
  const StartJobOffer({Key? key, required this.startJobId}) : super(key: key);

  @override
  _StartJobOfferState createState() => _StartJobOfferState();
}

enum StepStatus {
  PRE_DEPARTURE,
  DEPARTURE,
  ARRIVED,
  CONFIRM_ARRIVAL,
  START_JOB,
  FINISH_JOB,
  CONFIRM_FINISH_JOB
}

class _StartJobOfferState extends State<StartJobOffer> {
  List<StepStatus?> _statuses = [
    StepStatus.PRE_DEPARTURE,
    StepStatus.ARRIVED,
    null, // START_JOB สามารถเป็นค่า null ได้ในตอนแรก
    StepStatus.FINISH_JOB,
  ];

  Timer? _timer;
  Duration countdownDuration = Duration();
  bool _hasCountdownStarted = false;

  @override
  void initState() {
    super.initState();
    context.read<StartJobCubit>().fetchStartJobDetail(widget.startJobId);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown(Duration duration) {
    context.read<CountdownCubit>().startCountdown(duration);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  Future<void> _submitStatusProcess(String newStatus) async {
    print('Submitting new status: $newStatus');
    await context
        .read<StartJobCubit>()
        .submitStatusProcessOfferUseCase(widget.startJobId, newStatus);
    await context.read<StartJobCubit>().fetchStartJobDetail(widget.startJobId);
  }

  List<StepStatus?> _getStatusesFromProcess(String process) {
    switch (process) {
      case 'PRE_DEPARTURE':
        return [
          StepStatus.PRE_DEPARTURE,
          StepStatus.ARRIVED,
          null,
          StepStatus.FINISH_JOB,
        ];
      case 'DEPARTURE':
        return [
          StepStatus.DEPARTURE,
          StepStatus.ARRIVED,
          null,
          StepStatus.FINISH_JOB,
        ];
      case 'ARRIVED':
        return [
          StepStatus.DEPARTURE,
          StepStatus.ARRIVED,
          null,
          StepStatus.FINISH_JOB,
        ];
      case 'CONFIRM_ARRIVAL':
        return [
          StepStatus.DEPARTURE,
          StepStatus.CONFIRM_ARRIVAL,
          null,
          StepStatus.FINISH_JOB,
        ];
      case 'START_JOB':
        return [
          StepStatus.DEPARTURE,
          StepStatus.CONFIRM_ARRIVAL,
          StepStatus.START_JOB,
          StepStatus.FINISH_JOB,
        ];
      case 'FINISH_JOB':
        return [
          StepStatus.DEPARTURE,
          StepStatus.CONFIRM_ARRIVAL,
          StepStatus.START_JOB,
          StepStatus.FINISH_JOB,
        ];
      case 'CONFIRM_FINISH_JOB':
        return [
          StepStatus.DEPARTURE,
          StepStatus.CONFIRM_ARRIVAL,
          StepStatus.START_JOB,
          StepStatus.CONFIRM_FINISH_JOB,
        ];
      default:
        return [
          StepStatus.PRE_DEPARTURE,
          StepStatus.ARRIVED,
          null,
          StepStatus.FINISH_JOB,
        ];
    }
  }

  Text getStatusMessage(String status, BuildContext context) {
    switch (status) {
      case 'PRE_DEPARTURE':
        return Text(
          'ແມ່ບ້ານຈະອອກເດີນທາງເມື່ອໃກ້ເຖິງເວລາທີກຳນົດ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        );
      case 'DEPARTURE':
        return Text(
          'ແມ່ບ້ານກຳລັງເດີນທາງ...',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        );
      case 'ARRIVED':
        return Text(
          'ແມ່ບ້ານໄດ້ເຖິງສະຖານທີແລ້ວກະລຸນາຍືນຢັນສະຖານະ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: MColors.orange),
        );
      case 'CONFIRM_ARRIVAL':
        return Text(
          'ກະລຸນາລໍຖ້າແມ່ບ້ານກະກຽມເພື່ອເລີ່ມວຽກ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: MColors.orange),
        );
      case 'START_JOB':
        return Text(
          'ແມ່ບ້ານກຳລັງທຳຄວາມສະອາດ...',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        );
      case 'FINISH_JOB':
        return Text(
          '*ຍືນຢັນສະຖານະເມື່ອເຮັດວຽກສຳເລັດ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: MColors.orange),
        );
      default:
        return Text('');
    }
  }

  Widget _buildIndicator(StepStatus? status) {
    if (status == null) {
      return _buildEmptyIndicator();
    }

    switch (status) {
      case StepStatus.DEPARTURE:
      case StepStatus.CONFIRM_ARRIVAL:
      case StepStatus.CONFIRM_FINISH_JOB:
      case StepStatus.START_JOB:
        return _buildCompletedIndicator();
      case StepStatus.PRE_DEPARTURE:
      case StepStatus.ARRIVED:
      case StepStatus.FINISH_JOB:
        return _buildPendingIndicator();
      default:
        return _buildEmptyIndicator();
    }
  }

  Widget _buildEmptyIndicator() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: MColors.accent, width: 1),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: MColors.accent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedIndicator() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: MColors.accent,
        shape: BoxShape.circle,
        border: Border.all(color: MColors.accent, width: 1),
      ),
      child: const Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPendingIndicator() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: MColors.accent, width: 1),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: MColors.accent,
            shape: BoxShape.circle,
          ),
        ),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                SizedBox(
                    width: 100,
                    child: Image.asset(
                      MTexts.success,
                      fit: BoxFit.cover,
                    )),
                const Gap(20),
                Text(
                  'ຂອບໃຈທີໃຊ້ບໍລິການຂອງພວກເຮົາ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pop();
      context.go('/review-page');
    });
  }

  Future<void> _launchGoogleMaps(String url) async {
    final Uri googleMapsUri = Uri.parse(url);
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ເລີ່ມວຽກ')),
      body: RefreshIndicator(
        color: MColors.accent,
        onRefresh: () => context
            .read<StartJobCubit>()
            .fetchStartJobDetail(widget.startJobId),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: BlocBuilder<StartJobCubit, StartJobState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.startJobDetail != null) {
                  final jobData = state.startJobDetail;
                  final statusProcess = jobData?['status_process'] ?? '';
                  _statuses = _getStatusesFromProcess(statusProcess);

                  // ดึงค่า hours จาก API และแปลงเป็น Duration
                  double hoursDouble = jobData?['hours'].toDouble();
                  countdownDuration =
                      Duration(minutes: (hoursDouble * 60).toInt());

                  // เริ่มการนับถอยหลังเมื่อสถานะเป็น START_JOB และยังไม่เคยเริ่มการนับถอยหลัง
                  if (statusProcess == 'START_JOB' && !_hasCountdownStarted) {
                    startCountdown(countdownDuration);
                    _hasCountdownStarted = true;
                  }

                  return Column(
                    children: [
                      const Gap(20),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    _buildTimelineTile(
                                      isFirst: true,
                                      status: _statuses[0],
                                      label: 'ເດີນທາງ',
                                    ),
                                    _buildTimelineTile(
                                      status: _statuses[1],
                                      label: 'ເຖິງສະຖານທີ',
                                    ),
                                    _buildTimelineTile(
                                      status: _statuses[2],
                                      label: 'ເລີ່ມວຽກ',
                                    ),
                                    _buildTimelineTile(
                                      isLast: true,
                                      status: _statuses[3],
                                      label: 'ສໍາເລັດວຽກ',
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(20),
                              if (statusProcess == 'START_JOB')
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ໄລຍະເວລາໃນການເຮັດວຽກ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        BlocBuilder<CountdownCubit, Duration>(
                                          builder: (context, duration) {
                                            return Text(
                                              formatDuration(duration),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: MColors.accent),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const Gap(20),
                                  ],
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: getStatusMessage(
                                        statusProcess, context),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          statusProcess == 'ARRIVED' ||
                                                  statusProcess == 'FINISH_JOB'
                                              ? MColors.accent
                                              : Colors.grey,
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: statusProcess == 'ARRIVED' ||
                                              statusProcess == 'FINISH_JOB'
                                          ? () {
                                              print(
                                                  'Button pressed with statusProcess: $statusProcess');
                                              String newStatus =
                                                  statusProcess == 'ARRIVED'
                                                      ? 'CONFIRM_ARRIVAL'
                                                      : 'CONFIRM_FINISH_JOB';
                                              _submitStatusProcess(newStatus);
                                            }
                                          : null,
                                      child: const Text(
                                        'ຍຶນຍັນ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),
                      if (jobData != null)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 23, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ຂໍ້ມູນການຕິດຕໍ່',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: MColors.black),
                                ),
                                const Gap(14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${jobData['chosen_job_hunter']['first_name']} ${jobData['chosen_job_hunter']['last_name']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: MColors.black,
                                              fontSize: 14),
                                    ),
                                    Text(
                                      "+856 ${jobData['chosen_job_hunter']['phone']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: MColors.black,
                                              fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      const Gap(20),
                      if (jobData != null)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 23, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ສະຖານທີ່ໃຊ້ບໍລິການ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: MColors.black),
                                ),
                                const Gap(14),
                                TextRow(
                                  title: 'ບໍລິການ',
                                  text: jobData['service_name'] ?? 'n/a',
                                ),
                                const Gap(10),
                                TextRow(
                                  title: 'ກໍານົດການ',
                                  text: jobData != null
                                      ? formatDateTime(jobData['date_service'])
                                      : 'n/a',
                                ),
                                const Gap(10),
                                TextRow(
                                  title: 'ໄລຍະເວລາ',
                                  text: '${formatHours(jobData['hours'])} '
                                      "ຊ.ມ",
                                ),
                                const Gap(10),
                                TextRow(
                                  title: 'ແຂວງ',
                                  text:
                                      jobData['address']?['province'] ?? 'n/a',
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                } else if (state.errorMessage != null) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else {
                  return Center(child: Text('Please select a job'));
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<StartJobCubit, StartJobState>(
        builder: (context, state) {
          final jobData = state.startJobDetail;
          if (jobData != null &&
              jobData['status_process'] == 'CONFIRM_FINISH_JOB') {
            return FooterApp(
              title: 'ສຳເລັດ',
              onPressed: () {
                _showSuccessDialog(context);
              },
            );
          } else {
            return const SizedBox
                .shrink(); // Return an empty widget when condition is not met
          }
        },
      ),
    );
  }

  Widget _buildTimelineTile({
    bool isFirst = false,
    bool isLast = false,
    required StepStatus? status,
    required String label,
  }) {
    return Expanded(
      child: TimelineTile(
        alignment: TimelineAlign.center,
        axis: TimelineAxis.horizontal,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: _buildIndicator(status),
        ),
        beforeLineStyle: const LineStyle(
          color: MColors.accent,
          thickness: 2,
        ),
        afterLineStyle: const LineStyle(
          color: MColors.accent,
          thickness: 2,
        ),
        endChild: Container(
          constraints: const BoxConstraints(
            minWidth: 100,
          ),
          child: Center(
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ),
    );
  }
}
