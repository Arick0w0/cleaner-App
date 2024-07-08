import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../../auth/data/models/address_model.dart';
import 'add_new_address.dart';
import '../../../widgets/footer_app.dart';

Future<List<Address>> fetchAddresses(String userId, String token) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final String? token = sharedPreferences.getString('accessToken');
  final baseUrl = Config.apiBaseUrl;

  final response = await http.get(
    Uri.parse('${baseUrl}/user/$userId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    final addressesJson = data['data']['address'];
    if (addressesJson == null || addressesJson.isEmpty) {
      return [];
    }
    return (addressesJson as List)
        .map((json) => Address.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load address');
  }
}

class AddressView extends StatefulWidget {
  final String userId;
  final String token;

  const AddressView({super.key, required this.userId, required this.token});

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  late Future<List<Address>> futureAddresses;

  @override
  void initState() {
    super.initState();
    futureAddresses = fetchAddresses(widget.userId, widget.token);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureAddresses = fetchAddresses(widget.userId, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ທີ່ຢູ່ຂອງຂ້ອຍ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: FutureBuilder<List<Address>>(
        future: futureAddresses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load address'));
          } else if (snapshot.hasData) {
            final addresses = snapshot.data!;
            if (addresses.isEmpty) {
              return const Center(child: Text('No address found'));
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.addressName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                        color: Colors.black, fontSize: 27),
                              ),
                              Text(
                                  '${address.village}, ${address.district}, ${address.province}'),
                              Text(address.googleMap),
                              Gap(10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, address);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'ເລືອກ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No address found'));
          }
        },
      ),
      bottomNavigationBar: FooterApp(
        title: 'ເພີ່ມທີ່ຢູ່ໃໝ່',
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddressForm(
                userId: widget.userId,
                token: widget.token,
              ),
            ),
          );
          if (result == true) {
            setState(() {
              futureAddresses = fetchAddresses(widget.userId, widget.token);
            });
          }
        },
      ),
    );
  }
}
