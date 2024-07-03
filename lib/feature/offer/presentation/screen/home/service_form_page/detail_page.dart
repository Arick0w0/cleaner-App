import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/choose_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/star_job_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile/address/widget/footer_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../booking/widget/booking_status_widget.dart';
import '../../home/service_form_page/widgets/text_colum.dart';

class DetailPage extends StatefulWidget {
  final String postJobId;

  const DetailPage({super.key, required this.postJobId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? jobData;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('accessToken');
    final url =
        'http://18.142.53.143:9393/api/v1/job/post-jop/${widget.postJobId}';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        jobData = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        print(jobData);
      });
    } else {
      print('Failed to fetch job data: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
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
      return hours.toString(); // ถ้าเป็น int ให้แสดงผลตามเดิม
    } else if (hours is double) {
      int hourPart = hours.truncate();
      int minutePart = ((hours - hourPart) * 60).round();
      return '$hourPart.${minutePart.toString().padLeft(2, '0')}';
    } else {
      throw ArgumentError('hours must be an int or a double');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ການຈອງຂອງຂ້ອຍ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () =>
              context.go('/home-job-offer', extra: {'initialTabIndex': 1}),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
          child: jobData == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
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
                          jobData!['bill_code'] ?? 'N/A',
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
                      text: jobData!['service_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ປະເພດທີພັກ',
                      text: jobData!['place_type_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ວັນທີຮັບບໍລິການ',
                      text: formatDateTime(jobData!['date_service'] ?? 'N/A'),
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
                            // ภายใน build method หรือ widget ที่คุณใช้งาน
                            Text(
                              formatHours(jobData!['hours']),
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
                            )
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
                            if (jobData!['status'] == 'CHOOSE_HUNTER') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChoosePage(
                                    postJobId: widget.postJobId,
                                    billCode: jobData!['bill_code'],
                                  ),
                                ),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      jobData!['chosen_job_hunter'] != null &&
                                              jobData!['chosen_job_hunter']
                                                      ['first_name'] !=
                                                  null &&
                                              jobData!['chosen_job_hunter']
                                                      ['first_name']!
                                                  .isNotEmpty
                                          ? jobData!['chosen_job_hunter']
                                              ['first_name']
                                          : 'ເລືອກຜູ້ໃຫ້ບໍລິການທີ່ທ່ານຕ້ອງການ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: MColors.black,
                                              fontWeight: FontWeight.w500)),
                                  Text(
                                    jobData!['chosen_job_hunter']
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
                                    status: jobData!['status'] ?? 'N/A',
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
                          text: jobData!['first_name'] ?? 'N/A',
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
                          '${jobData?['address']['province']}'
                          ", "
                          '${jobData?['address']['district']}'
                          ", "
                          '${jobData?['address']['village']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                        ),

                        // Text(
                        //   jobData?['address']['province'] ?? 'N/A',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(
                        //           fontSize: 14, fontWeight: FontWeight.w400),
                        // ),
                        // const Text(', '),
                        // Text(
                        //   jobData!['address']['district'] ?? 'N/A',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(
                        //           fontSize: 14, fontWeight: FontWeight.w400),
                        // ),
                        // const Text(', '),
                        // Text(
                        //   jobData!['address']['village'] ?? 'N/A',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(
                        //           fontSize: 14, fontWeight: FontWeight.w400),
                        // ),
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
                                  formatCurrency(
                                    jobData?['price'],
                                  ),
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
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar:
          jobData != null && jobData!['status'] == 'MATCH_HUNTER'
              ? FooterApp(
                  title: 'ຕິດຕາມວຽກ',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StepperDemo(
                          startJobId: jobData!['start_job_id'],
                        ),
                      ),
                    );
                  })
              : null,
    );
  }
}
