import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/movement/create_movement_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;
  final CreateMovementUseCase _createMovementUseCase;

  TransferBloc(this._findAssetByQueryUseCase, this._createMovementUseCase)
    : super(TransferState()) {
    on<OnGetAssetByAssetCode>((event, emit) async {
      emit(state.copyWith(status: StatusTransfer.loading));

      final failureOrAsset = await _findAssetByQueryUseCase(
        params: event.params,
      );

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusTransfer.failure,
            message: failure.message,
          ),
        ),
        (asset) {
          final newAsset = asset
              .where((element) => element.assetCode == event.params)
              .firstOrNull;

          if (newAsset != null) {
            emit(
              state.copyWith(status: StatusTransfer.loaded, asset: newAsset),
            );
          } else {
            emit(
              state.copyWith(
                status: StatusTransfer.failure,
                message: 'Asset not found',
              ),
            );
          }
        },
      );
    });

    on<OnTransferAsset>((event, emit) async {
      emit(state.copyWith(status: StatusTransfer.loading));

      final failureOrAsset = await _createMovementUseCase(event.params);

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusTransfer.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(status: StatusTransfer.success, message: response),
        ),
      );
    });
  }
}
