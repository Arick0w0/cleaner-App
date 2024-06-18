import 'package:flutter/material.dart';

class TextgoogleMap extends StatelessWidget {
  final TextEditingController controller;

  const TextgoogleMap({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          // hintText: 'ລິ້ງປັກໝຸດຈາກ google map',
          // hintStyle: const TextStyle(color: Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
      ),
    );
  }
}
