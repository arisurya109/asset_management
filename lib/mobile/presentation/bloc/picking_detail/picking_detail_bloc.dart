import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:asset_management/domain/usecases/picking/add_pick_asset_picking_use_case.dart';
import 'package:asset_management/domain/usecases/picking/picking_detail_by_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'picking_detail_event.dart';
part 'picking_detail_state.dart';

class PickingDetailBloc extends Bloc<PickingDetailEvent, PickingDetailState> {
  final AddPickAssetPickingUseCase _pickedAssetUseCase;
  final PickingDetailByIdUseCase _findPickingDetailUseCase;

  PickingDetailBloc(this._pickedAssetUseCase, this._findPickingDetailUseCase)
    : super(PickingDetailState()) {
    on<OnGetPickingDetailEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPickingDetail.loading));

      final failureOrResponse = await _findPickingDetailUseCase(
        params: event.params,
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
            params: event.params.preparationId!,
          );

          return failureOrResponse.fold((_) {}, (response) {
            final preparationDetail = response.items
                ?.where(
                  (element) => element.id == event.params.preparationDetailId,
                )
                .firstOrNull;

            emit(
              state.copyWith(
                status: preparationDetail == null
                    ? StatusPickingDetail.completedSuccess
                    : StatusPickingDetail.addSuccess,
                response: response,
                message: message,
              ),
            );
          });
        },
      );
    });

    on<OnSetInitialStatus>((event, emit) async {
      emit(state.copyWith(status: StatusPickingDetail.initial));
    });
  }
}
