// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'migration_cubit.dart';

enum StatusMigration { initial, loading, failure, success }

// ignore: must_be_immutable
class MigrationState extends Equatable {
  StatusMigration? status;
  AssetEntity? asset;
  String? message;

  MigrationState({
    this.status = StatusMigration.initial,
    this.asset,
    this.message,
  });

  @override
  List<Object?> get props => [status, asset, message];

  MigrationState copyWith({
    StatusMigration? status,
    AssetEntity? asset,
    String? message,
  }) {
    return MigrationState(
      status: status ?? this.status,
      asset: asset ?? this.asset,
      message: message ?? this.message,
    );
  }
}
