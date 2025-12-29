// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Authentication extends Equatable {
  final String username;
  final String password;
  final String? newPassword;

  const Authentication({
    required this.username,
    required this.password,
    this.newPassword,
  });

  @override
  List<Object?> get props => [username, password, newPassword];
}
