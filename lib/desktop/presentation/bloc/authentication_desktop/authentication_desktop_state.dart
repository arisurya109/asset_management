// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_desktop_bloc.dart';

enum StatusAuthenticationDesktop { initial, loading, failure, success }

// ignore: must_be_immutable
class AuthenticationDesktopState extends Equatable {
  StatusAuthenticationDesktop? status;
  User? user;
  String? message;

  AuthenticationDesktopState({
    this.status = StatusAuthenticationDesktop.initial,
    this.user,
    this.message,
  });

  AuthenticationDesktopState copyWith({
    StatusAuthenticationDesktop? status,
    bool resetUser = false,
    User? user,
    String? message,
  }) {
    return AuthenticationDesktopState(
      status: status ?? this.status,
      user: resetUser ? null : (user ?? this.user),
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
