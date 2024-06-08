import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final String name;
  final String codeName;

  const Province({
    required this.name,
    required this.codeName,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      name: json['province'],
      codeName: json['province_code_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province': name,
      'province_code_name': codeName,
    };
  }

  @override
  List<Object?> get props => [name, codeName];
}
