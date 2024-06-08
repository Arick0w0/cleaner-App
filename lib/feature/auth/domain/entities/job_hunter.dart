// lib/feature/job_hunter/domain/entities/job_hunter.dart
import 'package:equatable/equatable.dart';
// import 'package:mae_ban/feature/shared/data/models/service_tpye.dart';

class JobHunter extends Equatable {
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String idCardImage;
  final String selfImageIdCard;
  final String birthDate;
  final Address address;
  final String career;
  final String nationality;
  // final List<ServiceType> serviceTypes;

  JobHunter({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.idCardImage,
    required this.selfImageIdCard,
    required this.birthDate,
    required this.address,
    required this.career,
    required this.nationality,
    // required this.serviceTypes,
  });

  @override
  List<Object?> get props => [
        username,
        firstName,
        lastName,
        gender,
        idCardImage,
        selfImageIdCard,
        birthDate,
        address,
        career,
        nationality,
        // serviceTypes,
      ];
}

class Address extends Equatable {
  final String village;
  final String district;
  final String province;

  Address({
    required this.village,
    required this.district,
    required this.province,
  });

  @override
  List<Object?> get props => [village, district, province];
}
