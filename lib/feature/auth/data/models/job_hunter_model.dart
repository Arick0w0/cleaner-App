import 'package:equatable/equatable.dart';

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

  JobHunterModel({
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
      ];
}

class AddressModel extends Equatable {
  final String village;
  final String district;
  final String province;

  AddressModel({
    required this.village,
    required this.district,
    required this.province,
  });

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
