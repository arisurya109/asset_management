// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/migration/domain/entities/migration.dart';
import 'package:asset_management/features/migration/domain/usecases/migration_asset_old_use_case.dart';

part 'migration_event.dart';
part 'migration_state.dart';

class MigrationBloc extends Bloc<MigrationEvent, MigrationState> {
  final MigrationAssetOldUseCase _useCase;
  MigrationBloc(this._useCase) : super(MigrationState()) {
    on<OnMigrationAssetIdOld>((event, emit) async {
      emit(state.copyWith(status: StatusMigration.loading));

      final failureOrResponse = await _useCase(event.params);

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusMigration.failed,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(status: StatusMigration.success, response: response),
        ),
      );
    });
  }
}
