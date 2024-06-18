import 'package:intl/intl.dart';

class Booking {
  final String id; // เพิ่ม ID ที่นี่
  final String name;
  final String date;
  final String time;
  final String status;
  final String orderNumber;
  final String orderDate;

  Booking({
    required this.id, // เพิ่ม ID ที่นี่
    required this.name,
    required this.date,
    required this.time,
    required this.status,
    required this.orderNumber,
    required this.orderDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Booking(
      id: json['_id'], // ดึงค่า ID จาก JSON
      name: json['first_name'] + ' ' + json['last_name'],
      date: formatter.format(DateTime.parse(json['date_service']).toLocal()),
      time: json['hours'].toString(),
      status: json['status'],
      orderNumber: json['bill_code'],
      orderDate: formatter.format(DateTime.parse(json['created_at']).toLocal()),
    );
  }
}
