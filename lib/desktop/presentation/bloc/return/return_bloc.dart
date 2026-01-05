import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/domain/usecases/movement/create_movement_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'return_event.dart';
part 'return_state.dart';

class ReturnBloc extends Bloc<ReturnEvent, ReturnState> {
  final CreateMovementUseCase _createMovementUseCase;

  ReturnBloc(this._createMovementUseCase) : super(ReturnState()) {
    on<OnReturn>((event, emit) async {
      emit(state.copyWith(status: StatusReturn.loading));

      await Future.delayed(Duration(milliseconds: 50));

      final failureOrResponse = await _createMovementUseCase(event.params);

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusReturn.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(status: StatusReturn.success, message: response),
        ),
      );
    });
  }
}
