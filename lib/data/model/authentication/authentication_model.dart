// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../domain/entities/authentication/authentication.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AuthenticationModel extends Equatable {
  final String username;
  final String password;
  final String? newPassword;

  const AuthenticationModel({
    required this.username,
    required this.password,
    this.newPassword,
  });

  @override
  List<Object> get props => [username, password];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'new_password': newPassword,
    };
  }

  factory AuthenticationModel.fromEntity(Authentication params) {
    return AuthenticationModel(
      username: params.username,
      password: params.password,
      newPassword: params.newPassword,
    );
  }
}
