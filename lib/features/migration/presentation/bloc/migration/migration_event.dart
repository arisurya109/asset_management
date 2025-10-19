part of 'migration_bloc.dart';

class MigrationEvent extends Equatable {
  const MigrationEvent();

  @override
  List<Object> get props => [];
}

class OnMigrationAssetIdOld extends MigrationEvent {
  final Migration params;

  const OnMigrationAssetIdOld(this.params);
}
