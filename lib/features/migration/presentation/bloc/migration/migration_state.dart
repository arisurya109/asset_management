// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'migration_bloc.dart';

enum StatusMigration { initial, loading, failed, success }

// ignore: must_be_immutable
class MigrationState extends Equatable {
  StatusMigration? status;
  String? response;
  String? message;
  MigrationState({this.status, this.response, this.message});

  @override
  List<Object?> get props => [status, response, message];

  MigrationState copyWith({
    StatusMigration? status,
    String? response,
    String? message,
  }) {
    return MigrationState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
