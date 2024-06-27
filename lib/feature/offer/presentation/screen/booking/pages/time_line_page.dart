import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/countdown/countdown_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/text_row.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/timeline/timev2/step_status.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile/address/widget/footer_app.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepperDemo extends StatefulWidget {
  final String startJobId;
  const StepperDemo({Key? key, required this.startJobId}) : super(key: key);
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  List<StepStatus?> _statuses = [
    StepStatus.PRE_DEPARTURE,
    StepStatus.ARRIVED,
    null, // START_JOB สามารถเป็นค่า null ได้ในตอนแรก
    StepStatus.FINISH_JOB,
  ];

  Timer? _timer;
  String statusProcess = '';
  Map<String, dynamic>? jobData;
  Duration countdownDuration = Duration();
  bool _hasCountdownStarted = false;

  @override
  void initState() {
    super.initState();
    _fetchDataFromAPI();
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

  Future<void> _fetchDataFromAPI() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('accessToken');
    print(token);
    final response = await http.get(
      Uri.parse(
          'http://18.142.53.143:9393/api/v1/job/start-jop/${widget.startJobId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        jobData = data['data'];
        statusProcess = jobData?['status_process'] ?? '';
        _statuses = _getStatusesFromProcess(statusProcess);

        // ดึงค่า hours จาก API และแปลงเป็น Duration
        double hoursDouble = jobData?['hours'].toDouble();
        countdownDuration = Duration(minutes: (hoursDouble * 60).toInt());

        // เริ่มการนับถอยหลังเมื่อสถานะเป็น START_JOB และยังไม่เคยเริ่มการนับถอยหลัง
        if (statusProcess == 'START_JOB' && !_hasCountdownStarted) {
          startCountdown(countdownDuration);
          _hasCountdownStarted = true;
        }

        print(jobData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _submitStatusProcess(String newStatus) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('accessToken');

    final response = await http.put(
      Uri.parse(
          'http://18.142.53.143:9393/api/v1/job/start-jop-offer/${widget.startJobId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'status_process': newStatus}),
    );

    if (response.statusCode == 200) {
      setState(() {
        statusProcess = newStatus;
        _statuses = _getStatusesFromProcess(statusProcess);

        // เริ่มการนับถอยหลังเมื่อสถานะเปลี่ยนเป็น START_JOB และยังไม่เคยเริ่มการนับถอยหลัง
        if (statusProcess == 'START_JOB' && !_hasCountdownStarted) {
          startCountdown(countdownDuration);
          _hasCountdownStarted = true;
        }
      });
      print('Status updated successfully');
    } else {
      throw Exception('Failed to update status');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ເລີ່ມວຽກ')),
      body: RefreshIndicator(
        onRefresh: _fetchDataFromAPI,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  BlocBuilder<CountdownCubit, Duration>(
                                    builder: (context, duration) {
                                      return Text(
                                        formatDuration(duration),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(color: MColors.accent),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Gap(20),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('show messages'),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(
                                    statusProcess == 'ARRIVED' ||
                                            statusProcess == 'FINISH_JOB'
                                        ? Colors.teal
                                        : Colors.grey,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                onPressed: statusProcess == 'ARRIVED' ||
                                        statusProcess == 'FINISH_JOB'
                                    ? () {
                                        // ตัวอย่างการเรียกใช้ฟังก์ชัน `_submitStatusProcess`
                                        _submitStatusProcess(
                                            statusProcess == 'ARRIVED'
                                                ? 'CONFIRM_ARRIVAL'
                                                : 'CONFIRM_FINISH_JOB');
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${jobData?['chosen_job_hunter']['first_name']} ${jobData?['chosen_job_hunter']['last_name']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: MColors.black, fontSize: 14),
                              ),
                              Text(
                                "+856 ${jobData?['chosen_job_hunter']['phone']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: MColors.black, fontSize: 14),
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
                            text: jobData?['service_name'] ?? 'n/a',
                          ),
                          const Gap(10),
                          TextRow(
                            title: 'ກໍານົດການ',
                            text: jobData != null
                                ? formatDateTime(jobData!['date_service'])
                                : 'n/a',
                          ),
                          const Gap(10),
                          TextRow(
                            title: 'ໄລຍະເວລາ',
                            text: '${jobData?['hours']} ' "ຊ.ມ",
                          ),
                          const Gap(10),
                          TextRow(
                            title: 'ແຂວງ',
                            text: jobData?['address']?['province'] ?? 'n/a',
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: statusProcess == 'CONFIRM_FINISH_JOB'
          ? FooterApp(
              title: 'ສຳເລັດ', onPressed: () => context.go('/review-page'))
          : null,
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
