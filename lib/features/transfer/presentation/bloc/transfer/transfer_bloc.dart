// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/transfer/domain/entities/transfer.dart';
import 'package:asset_management/features/transfer/domain/usecases/transfer_asset_use_case.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferAssetUseCase _useCase;

  TransferBloc(this._useCase) : super(TransferState()) {
    on<OnTransferAsset>((event, emit) async {
      emit(state.copyWith(status: StatusTransfer.loading));

      final response = await _useCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusTransfer.failed, message: l.message),
        ),
        (r) =>
            emit(state.copyWith(status: StatusTransfer.success, response: r)),
      );
    });
  }
}
