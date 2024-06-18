import 'package:flutter/material.dart';

class CustomTextFieldRow extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const CustomTextFieldRow({
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: TextStyle(fontSize: 16, color: Colors.black)),
          ),
          SizedBox(
            width: 190,
            height: 35,
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
