import 'package:equatable/equatable.dart';

class JobHunter extends Equatable {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final String idCardImage;
  final String selfImageIdCard;
  final String birthDate;
  final Address address;
  final String career;
  final String nationality;

  JobHunter({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.idCardImage,
    required this.selfImageIdCard,
    required this.birthDate,
    required this.address,
    required this.career,
    required this.nationality,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
        gender,
        idCardImage,
        selfImageIdCard,
        birthDate,
        address,
        career,
        nationality,
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
