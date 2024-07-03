import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/cleaner_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:mae_ban/core/constants/color.dart';

class ChoosePage extends StatefulWidget {
  final String postJobId;
  final String billCode;

  const ChoosePage({Key? key, required this.postJobId, required this.billCode})
      : super(key: key);

  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  List<dynamic> cleanerData = [];
  String? token;

  @override
  void initState() {
    super.initState();
    _fetchCleaners();
  }

  Future<void> _getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    token = sharedPreferences.getString('accessToken');
  }

  Future<Map<String, String>> _getHeaders() async {
    if (token == null) {
      await _getToken();
    }
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<void> _fetchCleaners({int retries = 3}) async {
    final url =
        'http://18.142.53.143:9393/api/v1/job/post-jop-hunter-info/${widget.postJobId}';
    final headers = await _getHeaders();

    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        setState(() {
          cleanerData = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        });
      } else {
        _showErrorSnackBar(
            'Failed to fetch cleaner data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } on TimeoutException catch (_) {
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
        _fetchCleaners(retries: retries - 1);
      } else {
        _showErrorSnackBar('Request timed out. Please try again later.');
      }
    } on SocketException catch (e) {
      _showErrorSnackBar(
          'Connection refused. Please check your network connection.');
      print('SocketException: $e');
    } catch (e) {
      _showErrorSnackBar('Error fetching cleaner data: $e');
      print('Exception: $e');
    }
  }

  Future<void> _chooseCleaner(String hunterUsername, {int retries = 3}) async {
    final url = 'http://18.142.53.143:9393/api/v1/job/choose-hunter/';
    final headers = await _getHeaders();

    final body = jsonEncode({
      "bill_code": widget.billCode,
      "status": "MATCH_HUNTER",
      "hunter_username": hunterUsername,
    });

    try {
      final response = await http
          .put(Uri.parse(url), headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        context.go('/home-job-offer', extra: {'initialTabIndex': 1});
        // Fetch the updated job details after choosing cleaner
        await _fetchJobDetails();
      } else {
        _showErrorSnackBar('Failed to choose cleaner: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } on TimeoutException catch (_) {
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
        _chooseCleaner(hunterUsername, retries: retries - 1);
      } else {
        _showErrorSnackBar('Request timed out. Please try again later.');
      }
    } on SocketException catch (e) {
      _showErrorSnackBar(
          'Connection refused. Please check your network connection.');
      print('SocketException: $e');
    } catch (e) {
      _showErrorSnackBar('Error choosing cleaner: $e');
      print('Exception: $e');
    }
  }

  Future<void> _fetchJobDetails() async {
    final url =
        'http://18.142.53.143:9393/api/v1/job/post-jop/${widget.postJobId}';
    final headers = await _getHeaders();

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jobData = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        // Update job data in the state or do something with the updated job data

        print('Updated job data: $jobData');
      } else {
        print('Failed to fetch updated job data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching updated job data: $e');
    }
  }

  void _showConfirmationDialog(String hunterUsername) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  MTexts.warning,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(10),
              Text(
                'ທ່ານຕ້ອງການເລືອກແມ່ບ້ານຄົນນີ້ແທ້ບໍ?',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: MColors.grey),
              ),
            ],
          ),
          content: Text(
            'ເລືອກແລ້ວຈະບໍສາມາຍົກເລີກໄດ້?',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: MColors.orange, fontSize: 12),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: MColors.redPink,
                      border: Border.all(color: MColors.accent),
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ຍົກເລີກ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: MColors.accent),
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  width: 100,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MColors.accent,
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    child: Text(
                      'ຕົກລົງ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _chooseCleaner(hunterUsername);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຜູ້ໃຫ້ບໍລິການ'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchCleaners,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: cleanerData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: cleanerData.length,
                  itemBuilder: (context, index) {
                    final cleaner = cleanerData[index];
                    return GestureDetector(
                      onTap: () => _showConfirmationDialog(cleaner['username']),
                      child: CleanerCard(
                        name:
                            '${cleaner['first_name']} ${cleaner['last_name']}',
                        imageProfile: cleaner['image_profile'] ?? '',
                        image: cleaner['cover_image'] ?? '',
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
