import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/usecases/picking/find_all_picking_task_use_case.dart';
import 'package:asset_management/domain/usecases/picking/update_status_picking_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'picking_event.dart';
part 'picking_state.dart';

class PickingBloc extends Bloc<PickingEvent, PickingState> {
  final FindAllPickingTaskUseCase _findAllPickingTaskUseCase;
  final UpdateStatusPickingUseCase _updateStatusPickingUseCase;

  PickingBloc(this._findAllPickingTaskUseCase, this._updateStatusPickingUseCase)
    : super(PickingState()) {
    on<OnFindAllPickingTaskEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      final failureOrPicking = await _findAllPickingTaskUseCase();

      return failureOrPicking.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failure,
            message: failure.message,
          ),
        ),
        (picking) => emit(
          state.copyWith(status: StatusPicking.loaded, picking: picking),
        ),
      );
    });
    on<OnUpdateStatusPickingEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      final failureOrMessage = await _updateStatusPickingUseCase(
        id: event.id,
        params: event.params,
        temporaryLocationId: event.locationId,
      );

      return failureOrMessage.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failure,
            message: failure.message,
          ),
        ),
        (messaeg) async {
          final failureOrPicking = await _findAllPickingTaskUseCase();

          return failureOrPicking.fold(
            (_) {},
            (picking) => emit(
              state.copyWith(
                status: StatusPicking.updateSuccess,
                picking: picking,
                message: messaeg,
              ),
            ),
          );
        },
      );
    });
  }
}
