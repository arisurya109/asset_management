part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnLoginUser extends UserEvent {
  final String username;
  final String password;

  const OnLoginUser(this.username, this.password);
}

class OnAutoLoginUser extends UserEvent {}

class OnLogoutUser extends UserEvent {}
