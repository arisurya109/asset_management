// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/modules/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/usecases/create_asset_transfer_use_case.dart';

part 'asset_transfer_event.dart';
part 'asset_transfer_state.dart';

class AssetTransferBloc extends Bloc<AssetTransferEvent, AssetTransferState> {
  final CreateAssetTransferUseCase _useCase;

  AssetTransferBloc(this._useCase) : super(AssetTransferState()) {
    on<OnCreateAssetTransfer>((event, emit) async {
      emit(state.copyWith(status: StatusAssetTransfer.loading));

      final response = await _useCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetTransfer.failed,
            messageFailed: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetTransfer.success,
            messageSuccess: r,
          ),
        ),
      );
    });
  }
}
