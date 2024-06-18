import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mae_ban/feature/offer/presentation/screen/profile/address/widget/reusable_dropdown_row.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile/address/widget/text_google_map.dart';
import 'widget/custom_text_field_row.dart';
import 'widget/footer_app.dart';

class AddressForm extends StatefulWidget {
  final String userId;
  final String token;

  AddressForm({required this.userId, required this.token});

  @override
  _AddressFormWidgetState createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends State<AddressForm> {
  String selectedDistrict = 'ເມືອງສີສັດຕະນາກ';
  String selectedProvince = 'ນະຄອນຫຼວງວຽງຈັນ';
  TextEditingController addressController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController googleController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    villageController.dispose();
    googleController.dispose();
    super.dispose();
  }

  Future<void> saveAddress() async {
    final url = 'http://18.142.53.143:9393/api/v1/user/${widget.userId}';

    // Fetch existing address list
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch existing addresses')),
      );
      return;
    }

    // Decode response with utf8
    final existingData = jsonDecode(utf8.decode(response.bodyBytes));
    List<dynamic> addressList = existingData['data']['address'] ?? [];

    // Add new address to the list
    addressList.add({
      'address_name': addressController.text,
      'village': villageController.text,
      'district': selectedDistrict,
      'province': selectedProvince,
      'google_map': googleController.text,
    });

    final Map<String, dynamic> payload = {
      'address': addressList,
    };

    final updateResponse = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode(payload),
    );

    print('Response status: ${updateResponse.statusCode}');
    print('Response body: ${updateResponse.body}');

    if (updateResponse.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address saved successfully')),
      );
      Navigator.pop(context, true); // Pass true to indicate success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save address')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເພີມທີ່ຢູ່'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ກ່ຽວກັບທີ່ພັກຂອງເຈົ້າ'),
            const Gap(10),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: CustomTextFieldRow(
                  label: 'ຊື່ທີ່ພັກ',
                  hintText: 'ໃສ່ຊື່ທີ່ພັກ',
                  controller: addressController,
                ),
              ),
            ),
            const Gap(20),
            const Text('ຂໍ້ມູນທີ່ຢູ່'),
            const Gap(10),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ລິ້ງປັກໝຸດຈາກ google map',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: MColors.black),
                    ),
                    const Gap(10),
                    TextgoogleMap(
                      controller: googleController,
                    ),
                    const Divider(),
                    ReusableDropdownRow(
                      label: 'ແຂວງ',
                      value: selectedProvince,
                      items: ['ນະຄອນຫຼວງວຽງຈັນ'],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedProvince = newValue!;
                        });
                      },
                    ),
                    Gap(10),
                    ReusableDropdownRow(
                      label: 'ເມືອງ',
                      value: selectedDistrict,
                      items: [
                        'ເມືອງສີສັດຕະນາກ',
                        'ເມືອງຈັນທະບູລີ',
                        'ເມືອງໄຊເສດຖາ',
                        'ເມືອງສີໂຄດຕະບອງ',
                        'ເມືອງຫາດຊາຍຟອງ',
                        'ເມືອງນາຊາຍທອງ',
                        'ເມືອງສັງທອງ',
                        'ເມືອງປາກງື່ມ',
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDistrict = newValue!;
                        });
                      },
                    ),
                    Gap(10),
                    CustomTextFieldRow(
                      label: 'ບ້ານ',
                      hintText: 'ກະລຸນາປ່ອນຂໍ້ມູນບ້ານ',
                      controller: villageController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterApp(
        title: 'ບັນທຶກ',
        onPressed: () {
          saveAddress();
        },
      ),
    );
  }
}
