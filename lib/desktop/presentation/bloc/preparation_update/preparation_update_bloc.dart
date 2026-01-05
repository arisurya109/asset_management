import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/domain/usecases/movement/create_movement_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_update_event.dart';
part 'preparation_update_state.dart';

class PreparationUpdateBloc
    extends Bloc<PreparationUpdateEvent, PreparationUpdateState> {
  final CreateMovementUseCase _createMovementUseCase;

  PreparationUpdateBloc(this._createMovementUseCase)
    : super(PreparationUpdateState()) {
    on<OnPreparationUpdate>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationUpdate.loading));

      await Future.delayed(Duration(milliseconds: 50));

      final failureOrResponse = await _createMovementUseCase(event.params);

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationUpdate.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusPreparationUpdate.success,
            message: response,
          ),
        ),
      );
    });
  }
}
