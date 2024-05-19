import 'package:equatable/equatable.dart';

class JobOffer extends Equatable {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;

  JobOffer({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });

  @override
  List<Object?> get props => [username, password, firstName, lastName, gender];
}
