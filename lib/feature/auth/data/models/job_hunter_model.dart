import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';
import 'address_model.dart';

class JobHunterModel extends Equatable {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final String idCardImage;
  final String selfImageIdCard;
  final String birthDate;
  final AddressModel address;
  final String career;
  final String nationality;
  final List<ServiceTypeModel> serviceTypes;

  const JobHunterModel({
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
    required this.serviceTypes,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'id_card_image': idCardImage,
      'self_image_id_card': selfImageIdCard,
      'birth_date': birthDate,
      'address': address.toJson(),
      'career': career,
      'nationality': nationality,
      'service_types':
          serviceTypes.map((serviceType) => serviceType.toJson()).toList(),
    };
  }

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
        serviceTypes,
      ];
}
