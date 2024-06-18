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
  final List<Address> address; // เปลี่ยนเป็น List<AddressModel>
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

  factory JobHunterModel.fromJson(Map<String, dynamic> json) {
    var addressList = json['address'] as List;
    List<Address> address =
        addressList.map((i) => Address.fromJson(i)).toList();

    var serviceTypeList = json['service_types'] as List;
    List<ServiceTypeModel> serviceTypes =
        serviceTypeList.map((i) => ServiceTypeModel.fromJson(i)).toList();

    return JobHunterModel(
      username: json['username'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      idCardImage: json['id_card_image'],
      selfImageIdCard: json['self_image_id_card'],
      birthDate: json['birth_date'],
      address: address,
      career: json['career'],
      nationality: json['nationality'],
      serviceTypes: serviceTypes,
    );
  }

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
      'address': address.map((e) => e.toJson()).toList(),
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
