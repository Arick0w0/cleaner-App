import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/text_row.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; // นำเข้าแพ็กเกจ intl

import '../widget/timeline/step_indicator.dart';

class TrackPage extends StatefulWidget {
  final String startJobId;

  const TrackPage({Key? key, required this.startJobId}) : super(key: key);

  @override
  _TrackPageState createState() => _TrackPageState();
}

const _processes = [
  'ເດີນທາງ',
  'ເຖິງສະຖານທີ',
  'ເລີ່ມວຽກ',
  'ສໍາເລັດວຽກ',
];

class _TrackPageState extends State<TrackPage> {
  int _processIndex = 0;
  bool isLoading = true;
  Map<String, dynamic>? jobData; // เก็บข้อมูลจาก API เพื่อตรวจสอบ

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'http://18.142.53.143:9393/api/v1/job/start-jop/${widget.startJobId}';

    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString('accessToken');

      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          jobData = responseData['data']; // เก็บข้อมูลเพื่อตรวจสอบ
          print(jobData); // พิมพ์ข้อมูลลงในคอนโซล
        });
      } else {
        print('Failed to fetch job data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching job data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDateTime(String dateTimeStr) {
    final DateTime dateTime = DateTime.parse(dateTimeStr);
    final DateFormat formatter = DateFormat('dd-MM-yyyy (HH:mm)');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ເລີ່ມວຽກ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(
                    processIndex: _processIndex,
                    isLoading: isLoading,
                    onPress: () {},
                    title: 'ແມ່ບ້ານຈະອອກເດີນທາງເມື່ອໃກ້ເຖິງເວລາທີກຳນົດ',
                  ),
                  const Gap(20),
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
                                ''
                                "+856 "
                                '${jobData?['chosen_job_hunter']['phone']}',
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
                  const Gap(25),
                  Card(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                              text: '${jobData?['hours']} ' "ຊ.ມ" ''),
                          const Gap(10),
                          TextRow(
                            title: 'ແຂວງ',
                            text: jobData?['address']?['province'] ?? 'n/a',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(25),
                  // if (jobData != null) ...[
                  //   Text(
                  //     'Job Data from API:',
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  //   Text(
                  //       jobData.toString()), // แสดงข้อมูลที่ได้รับจาก API บน UI
                  // ],
                ],
              ),
            ),
    );
  }
}
