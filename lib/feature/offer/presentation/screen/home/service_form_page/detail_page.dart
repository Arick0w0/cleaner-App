import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/text_colum.dart';

class DetailPage extends StatefulWidget {
  final String postJobId;

  const DetailPage({Key? key, required this.postJobId}) : super(key: key);

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
      });
    } else {
      print('Failed to fetch job data: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ການຈອງຂອງຂ້ອຍ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    Text('Post Job ID: ${widget.postJobId}'),
                    const Divider(),
                    TextColum(
                      title: 'Bill Code',
                      text: jobData!['bill_code'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Service Code Name',
                      text: jobData!['service_code_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ວັນທີຮັບບໍລິການ',
                      text: jobData!['date_service'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'ໄລຍະເວລາ',
                      text: jobData!['hours'].toString() ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'First Name',
                      text: jobData!['first_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Last Name',
                      text: jobData!['last_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Phone',
                      text: jobData!['phone'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Area Code Name',
                      text: jobData!['area_code_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Address Name',
                      text: jobData!['address']['address_name'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Village',
                      text: jobData!['address']['village'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'District',
                      text: jobData!['address']['district'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Province',
                      text: jobData!['address']['province'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Google Map',
                      text: jobData!['address']['google_map'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Status',
                      text: jobData!['status'] ?? 'N/A',
                    ),
                    const Divider(),
                    TextColum(
                      title: 'Price',
                      text: jobData!['price'].toString() ?? 'N/A',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
