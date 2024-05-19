import 'package:equatable/equatable.dart';

class JobOfferModel extends Equatable {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;

  JobOfferModel({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
    };
  }

  @override
  List<Object?> get props => [username, password, firstName, lastName, gender];
}
