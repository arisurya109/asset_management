// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_desktop_bloc.dart';

class AuthenticationDesktopEvent extends Equatable {
  const AuthenticationDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnLoginEvent extends AuthenticationDesktopEvent {
  final Authentication params;

  const OnLoginEvent({required this.params});
}

class OnLogoutEvent extends AuthenticationDesktopEvent {}

class OnResetStateEvent extends AuthenticationDesktopEvent {}

class OnChangePasswordEvent extends AuthenticationDesktopEvent {
  final Authentication params;
  final String conNewPassword;

  const OnChangePasswordEvent({
    required this.params,
    required this.conNewPassword,
  });
}
