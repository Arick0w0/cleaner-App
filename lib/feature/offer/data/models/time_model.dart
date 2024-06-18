import 'package:mae_ban/feature/offer/domain/entities/time.dart';

class TimeModel extends Time {
  TimeModel({
    required String id,
    required String time,
    required String codeName,
    required double value,
  }) : super(id: id, time: time, codeName: codeName, value: value);

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      id: json['_id'],
      time: json['time'],
      codeName: json['code_name'],
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'time': time,
      'code_name': codeName,
      'value': value,
    };
  }
}
