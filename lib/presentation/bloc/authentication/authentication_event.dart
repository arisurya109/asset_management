part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class OnLoginEvent extends AuthenticationEvent {
  final Authentication params;

  const OnLoginEvent(this.params);
}

class OnAutoLoginEvent extends AuthenticationEvent {}

class OnLogoutEvent extends AuthenticationEvent {}

class OnChangePasswordEvent extends AuthenticationEvent {
  final Authentication params;

  const OnChangePasswordEvent(this.params);
}
