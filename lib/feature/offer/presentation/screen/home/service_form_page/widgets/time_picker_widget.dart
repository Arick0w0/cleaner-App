import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class TimePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const TimePickerWidget({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedTime.format(context),
                style: Theme.of(context).textTheme.bodyMedium),
            const Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final List<String> allTimeOptions = [
      '07:00',
      '07:30',
      '08:00',
      '08:30',
      '09:00',
      '09:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '12:00',
      '12:30',
      '13:00',
      '13:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
      '16:00',
      '16:30',
      '17:00',
      '17:30',
      '18:00',
      '18:30',
      '19:00',
      '19:30',
    ];

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime selectedDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final List<String> availableTimeOptions;

    if (selectedDay == today) {
      // Limit time selection to +3 hours from now if today
      final DateTime threeHoursLater = now.add(Duration(hours: 2));
      availableTimeOptions = allTimeOptions.where((time) {
        final hour = int.parse(time.split(':')[0]);
        final minute = int.parse(time.split(':')[1]);
        final selectedTime = TimeOfDay(hour: hour, minute: minute);
        final selectedDateTime = DateTime(now.year, now.month, now.day,
            selectedTime.hour, selectedTime.minute);

        return selectedDateTime.isAfter(threeHoursLater) ||
            selectedDateTime.isAtSameMomentAs(threeHoursLater);
      }).toList();
    } else {
      // Allow all time options if not today
      availableTimeOptions = allTimeOptions;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height *
              0.5, // Adjust the height as needed
          child: ListView.separated(
            itemCount: availableTimeOptions.length,
            itemBuilder: (context, index) {
              final time = availableTimeOptions[index];
              return ListTile(
                dense: true, // Reduce the height of ListTile
                title: Text(
                  time,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: MColors.black),
                ),
                contentPadding: EdgeInsets.only(
                    left: 16.0, right: 16), // Remove padding inside ListTile
                trailing: selectedTime.format(context) == time
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  onTimeSelected(TimeOfDay(
                    hour: int.parse(time.split(':')[0]),
                    minute: int.parse(time.split(':')[1]),
                  ));
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 1); // Adjust the height of Divider
            },
          ),
        );
      },
    );
  }
}
