// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum StatusUser { initial, loading, failed, success }

// ignore: must_be_immutable
class UserState extends Equatable {
  StatusUser? status;
  List<User>? users;
  User? user;
  String? message;

  UserState({
    this.status = StatusUser.initial,
    this.users,
    this.user,
    this.message,
  });

  @override
  List<Object?> get props => [status, users, user, message];

  UserState copyWith({
    StatusUser? status,
    List<User>? users,
    User? user,
    String? message,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
