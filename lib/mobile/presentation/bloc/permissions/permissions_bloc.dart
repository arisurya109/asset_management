// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:asset_management/domain/usecases/permissions/find_all_permissions_use_case.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final FindAllPermissionsUseCase _useCase;

  PermissionsBloc(this._useCase) : super(PermissionsState()) {
    on<OnFindAllPermissionsEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPermissions.loading));

      final failureOrPermissions = await _useCase();

      return failureOrPermissions.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPermissions.failed,
            message: failure.message,
          ),
        ),
        (permissions) => emit(
          state.copyWith(
            status: StatusPermissions.success,
            permissions: permissions,
          ),
        ),
      );
    });
  }
}
