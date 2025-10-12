part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnLoginUser extends UserEvent {
  final User params;

  const OnLoginUser(this.params);
}

class OnLogoutUser extends UserEvent {}

class OnAutoLogin extends UserEvent {}

class OnChangePassword extends UserEvent {
  final String username;
  final String oldPassword;
  final String newPassword;

  const OnChangePassword(this.username, this.oldPassword, this.newPassword);
}
