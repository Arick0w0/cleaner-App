import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/auth/domain/entities/address.dart';
import 'package:mae_ban/feature/shared/domain/entities/service_type.dart';

class JobHunter extends Equatable {
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String idCardImage;
  final String selfImageIdCard;
  final String birthDate;
  final List<Address> address; // เปลี่ยนจาก Address เป็น List<Address>
  final String career;
  final String nationality;
  final List<ServiceType> serviceTypes;

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
    required this.serviceTypes,
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
        serviceTypes,
      ];
}
