import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/auth/persentation/widgets/text_form_field.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String errorText;
  final String text;

  const CustomDatePicker({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.errorText,
    required this.text,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MColors.secondary, // Header background color
              onPrimary: MColors.primary, // Header text color
              surface: MColors.primary, // Body background color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('dd-MM-yy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue[50], // Background color of the date picker
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: IgnorePointer(
          child: CustomTextFormField(
            controller: widget.controller,
            labelText: widget.labelText,
            prefixIcon: Icon(widget.icon),
            errorText: widget.errorText,
          ),
        ),
      ),
    );
  }
}
