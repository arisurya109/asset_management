part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnCreateUserEvent extends UserEvent {
  final User params;

  const OnCreateUserEvent(this.params);
}

class OnFindAllUserEvent extends UserEvent {}

class OnFindUserByIdEvent extends UserEvent {
  final int params;

  const OnFindUserByIdEvent(this.params);
}

class OnUpdateUserEvent extends UserEvent {
  final User params;

  const OnUpdateUserEvent(this.params);
}

class OnDeleteUserEvent extends UserEvent {
  final int params;

  const OnDeleteUserEvent(this.params);
}
