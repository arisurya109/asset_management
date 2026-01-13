import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/usecases/picking/find_picking_detail_use_case.dart';
import 'package:asset_management/domain/usecases/picking/picked_asset_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'picking_detail_event.dart';
part 'picking_detail_state.dart';

class PickingDetailBloc extends Bloc<PickingDetailEvent, PickingDetailState> {
  final PickedAssetUseCase _pickedAssetUseCase;
  final FindPickingDetailUseCase _findPickingDetailUseCase;

  PickingDetailBloc(this._pickedAssetUseCase, this._findPickingDetailUseCase)
    : super(PickingDetailState()) {
    on<OnGetPickingDetailEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPickingDetail.loading));

      final failureOrResponse = await _findPickingDetailUseCase(
        id: event.params,
      );

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPickingDetail.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusPickingDetail.loaded,
            response: response,
          ),
        ),
      );
    });
    on<OnPickAssetEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPickingDetail.loading));

      final failureOrMessage = await _pickedAssetUseCase(params: event.params);

      return failureOrMessage.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPickingDetail.failure,
            message: failure.message,
          ),
        ),
        (message) async {
          final failureOrResponse = await _findPickingDetailUseCase(
            id: event.preparationId,
          );

          return failureOrResponse.fold(
            (_) {},
            (response) => emit(
              state.copyWith(
                status: StatusPickingDetail.addSuccess,
                response: response,
                message: message,
              ),
            ),
          );
        },
      );
    });

    on<OnSetInitialStatus>((event, emit) async {
      emit(state.copyWith(status: StatusPickingDetail.initial));
    });
  }
}
