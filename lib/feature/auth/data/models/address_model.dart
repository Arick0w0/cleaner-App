import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String village;
  final String district;
  final String province;

  const AddressModel({
    required this.village,
    required this.district,
    required this.province,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      village: json['village'],
      district: json['district'],
      province: json['province'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'village': village,
      'district': district,
      'province': province,
    };
  }

  @override
  List<Object?> get props => [village, district, province];
}
