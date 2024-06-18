import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('d MMM y', 'th').format(selectedDate)),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime firstDate = DateTime.now();
    final DateTime lastDate = firstDate.add(const Duration(days: 7));

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height *
              0.5, // Adjust the height as needed
          child: Column(
            children: [
              Expanded(
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: firstDate,
                  lastDate: lastDate,
                  selectableDayPredicate: (DateTime day) {
                    return day.isAfter(
                            firstDate.subtract(const Duration(days: 1))) &&
                        day.isBefore(lastDate.add(const Duration(days: 1)));
                  },
                  onDateChanged: (DateTime date) {
                    onDateSelected(date);
                    Navigator.pop(context);
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
