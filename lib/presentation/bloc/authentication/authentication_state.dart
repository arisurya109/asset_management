// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

enum StatusAuthentication { initial, loading, failed, success }

// ignore: must_be_immutable
class AuthenticationState extends Equatable {
  StatusAuthentication? status;
  User? user;
  String? message;

  AuthenticationState({
    this.status = StatusAuthentication.initial,
    this.user,
    this.message,
  });

  AuthenticationState copyWith({
    StatusAuthentication? status,
    bool resetUser = false,
    User? user,
    String? message,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: resetUser ? null : (user ?? this.user),
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
