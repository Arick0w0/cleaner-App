import 'package:intl/intl.dart';

String formatHours(dynamic hours) {
  if (hours is int) {
    return hours.toString(); // ถ้าเป็น int ให้แสดงผลตามเดิม
  } else if (hours is double) {
    int hourPart = hours.truncate();
    int minutePart = ((hours - hourPart) * 60).round();
    return '$hourPart:${minutePart.toString().padLeft(2, '0')}';
  } else {
    throw ArgumentError('hours must be an int or a double');
  }
}

class Booking {
  final String id; // เพิ่ม ID ที่นี่
  final String name;
  final String date;
  final String time;
  final String image;
  final String status;
  final String orderNumber;
  final String orderDate;

  Booking({
    required this.id, // เพิ่ม ID ที่นี่
    required this.name,
    required this.date,
    required this.time,
    required this.image,
    required this.status,
    required this.orderNumber,
    required this.orderDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Booking(
      id: json['_id'], // ดึงค่า ID จาก JSON
      name: json['first_name'] + ' ' + json['last_name'],
      date: json['date_service'],
      time: formatHours(json['hours']),
      image: json['chosen_job_hunter']['image_profile'],
      status: json['status'] ?? '',
      orderNumber: json['bill_code'],
      orderDate: formatter.format(DateTime.parse(json['created_at']).toLocal()),
    );
  }
}
